; Auto battle: the game picks the player's move every turn.
; Pressing SELECT in the battle menu turns it on (see EnableAutoBattle);
; pressing SELECT again at any time turns it off from the next turn.
; Every battle starts with it off, or on with the CONTINUOUS option.

DEF AUTO_BATTLE_DELAY EQU 30 ; frames to show the auto battle text each turn
DEF AUTO_BATTLE_TEXT_DELAY EQU 40 ; frames before battle text moves on by itself

; AutoBattle_RateMove results, from worst to best
DEF AUTO_BATTLE_FAILS         EQU 0 ; the move would have no effect
DEF AUTO_BATTLE_LAST_RESORT   EQU 1 ; Selfdestruct and Explosion
DEF AUTO_BATTLE_NO_DAMAGE     EQU 2 ; status moves and unpredictable damage
DEF AUTO_BATTLE_DAMAGE        EQU 3 ; + expected damage this turn
DEF AUTO_BATTLE_SNORE         EQU $4000 ; can attack while asleep
DEF AUTO_BATTLE_SLEEP_TALK    EQU $8000 ; can use other moves while asleep

InitAutoBattle:
; With AUTO BATTLE set to CONTINUOUS in the options, battles start with it on.
; Called after ClearBattleRAM has turned it off.
	ld a, [wOptions2]
	bit CONTINUOUS_AUTO_BATTLE, a
	ret z
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	ret z
	cp BATTLETYPE_DEBUG
	ret z
	ld a, TRUE
	ld [wAutoBattle], a
; SELECT from now on, even during the opening text, turns it off.
	ld hl, hJoypadSum
	res B_PAD_SELECT, [hl]
	ret

AutoBattleTextDelay::
; Called when text waits for A or B (see PromptButton).
; In battles with continuous auto battle, wait a moment instead and
; return carry, so the player doesn't have to press anything.
; A or B still moves on right away, and SELECT turns this off
; along with auto battle.
	ld a, [wBattleMode]
	and a
	ret z
	ld a, [wOptions2]
	bit CONTINUOUS_AUTO_BATTLE, a
	ret z
	ld a, [wAutoBattle]
	and a
	ret z
	ldh a, [hJoypadSum]
	bit B_PAD_SELECT, a
	ret nz

	push bc
	ld c, AUTO_BATTLE_TEXT_DELAY
.wait
	call DelayFrame
	call JoyTextDelay
	ldh a, [hJoyPressed]
	and PAD_A | PAD_B
	jr nz, .done
	dec c
	jr nz, .wait
.done
	pop bc
	scf
	ret

AutoBattleTurn:
; Return carry and pick FIGHT if auto battle is on for this turn.
	ld a, [wAutoBattle]
	and a
	ret z

	ldh a, [hJoypadSum]
	bit B_PAD_SELECT, a
	jr nz, .stop

	hlcoord 1, 14
	ld de, AutoBattleText
	call PlaceString
	ld a, $1
	ldh [hBGMapMode], a

	ld c, AUTO_BATTLE_DELAY
.wait
	call DelayFrame
	ldh a, [hJoypadSum]
	bit B_PAD_SELECT, a
	jr nz, .stop
	dec c
	jr nz, .wait

	ld a, 1 ; FIGHT
	ld [wBattleMenuCursorPosition], a
	scf
	ret

.stop
	xor a
	ld [wAutoBattle], a
	ld hl, hJoypadSum
	res B_PAD_SELECT, [hl]
	call LoadTempTilemapToTilemap
	and a
	ret

AutoBattleText:
	db   "AUTO BATTLE"
	next "SELECT to stop@"

AutoBattle_ChooseMove:
; Pick the player's move like MoveSelectionScreen does,
; choosing whichever move should do the most damage this turn.
; Assumes CheckPlayerHasUsableMoves already ruled out Struggle.

; The damage estimates overwrite these, so restore them afterward
; to leave the battle as if the move had been chosen from the menu.
	ld hl, wCurDamage
	ld a, [hli]
	ld e, [hl]
	ld d, a
	push de
	ld a, [wCriticalHit]
	ld d, a
	ld a, [wTypeModifier]
	ld e, a
	push de
	ld a, [wAttackMissed]
	ld d, a
	ld a, [wTypeMatchup]
	ld e, a
	push de

	call SetPlayerTurn
	xor a
	ld [wCriticalHit], a

	lb bc, 0, -1 ; b = move slot, c = best slot
	ld de, 0 ; best rating
.loop
	push bc
	push de
	ld a, b
	call AutoBattle_RateMove
	pop de
	pop bc
	jr c, .next

; Ties go to the earlier move.
	ld a, c
	cp -1
	jr z, .better
	ld a, e
	sub l
	ld a, d
	sbc h
	jr nc, .next
.better
	ld c, b
	ld d, h
	ld e, l

.next
	inc b
	ld a, b
	cp NUM_MOVES
	jr c, .loop

	ld a, c
	cp -1
	ld a, STRUGGLE
	jr z, .got_move
	ld a, c
	ld [wCurMoveNum], a
	ld hl, wBattleMonMoves
	ld b, 0
	add hl, bc
	ld a, [hl]
.got_move
	ld [wCurPlayerMove], a

	pop de
	ld a, d
	ld [wAttackMissed], a
	ld a, e
	ld [wTypeMatchup], a
	pop de
	ld a, d
	ld [wCriticalHit], a
	ld a, e
	ld [wTypeModifier], a
	pop de
	ld hl, wCurDamage
	ld a, d
	ld [hli], a
	ld [hl], e
	ret

AutoBattle_RateMove:
; Return carry if move slot a can't be selected.
; Otherwise, return how good the move is in hl (see AUTO_BATTLE_* above).
	ld c, a
	ld b, 0
	ld hl, wBattleMonPP
	add hl, bc
	ld a, [hl]
	and PP_MASK
	jr z, .cant_select

	ld a, [wPlayerDisableCount]
	swap a
	and $f
	dec a
	cp c
	jr z, .cant_select

	ld hl, wBattleMonMoves
	add hl, bc
	ld a, [hl]
	and a
	jr z, .cant_select
	ld [wCurPlayerMove], a
	callfar UpdateMoveData

	call .GetRating
	and a
	ret

.cant_select
	scf
	ret

.GetRating:
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SELFDESTRUCT
	jp z, .last_resort
	cp EFFECT_SLEEP_TALK
	jr z, .sleep_talk
	cp EFFECT_OHKO
	jr z, .ohko

	ld hl, AutoBattleNoDamageEffects
	ld de, 1
	call IsInArray
	jr c, .no_damage
	ld a, [wPlayerMoveStruct + MOVE_POWER]
	and a
	jr z, .no_damage

	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_DREAM_EATER
	jr nz, .not_dream_eater
	ld a, [wEnemyMonStatus]
	and SLP_MASK
	jr z, .fails
	jr .estimate_damage

.not_dream_eater
	cp EFFECT_SNORE
	jr nz, .estimate_damage
	ld a, [wBattleMonStatus]
	and SLP_MASK
	jr z, .fails

.estimate_damage
	call AutoBattle_EstimateDamage
	ld a, h
	or l
	jr z, .fails

; While asleep, Snore is the only move that can attack.
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SNORE
	jr z, .snore

; A knockout with a priority move doesn't give the foe a chance to attack.
	cp EFFECT_PRIORITY_HIT
	jr nz, .got_damage
	ld a, [wEnemyMonHP + 1]
	cp l
	jr nz, .got_damage
	ld a, [wEnemyMonHP]
	cp h
	jr nz, .got_damage
	inc hl

.got_damage
	ld bc, AUTO_BATTLE_DAMAGE
	add hl, bc
	ret nc
	ld hl, $ffff
	ret

.ohko
; OHKO moves fail against higher-level or immune foes.
	ld a, [wEnemyMonLevel]
	ld b, a
	ld a, [wBattleMonLevel]
	cp b
	jr c, .fails
	callfar BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	and a
	jr z, .fails
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld l, [hl]
	ld h, a
	call AutoBattle_ApplyAccuracy
	jr .got_damage

.sleep_talk
	ld a, [wBattleMonStatus]
	and SLP_MASK
	jr z, .fails
	ld hl, AUTO_BATTLE_SLEEP_TALK
	ret

.snore
	ld hl, AUTO_BATTLE_SNORE
	ret

.no_damage
	ld hl, AUTO_BATTLE_NO_DAMAGE
	ret

.last_resort
; Not worth fainting for if the foe is immune.
	callfar BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	and a
	jr z, .fails
	ld hl, AUTO_BATTLE_LAST_RESORT
	ret

.fails
	ld hl, AUTO_BATTLE_FAILS
	ret

AutoBattleNoDamageEffects:
; Their damage isn't known in advance, so they are rated like status moves.
	db EFFECT_COUNTER
	db EFFECT_MIRROR_COAT
	db EFFECT_BIDE
	db EFFECT_FUTURE_SIGHT
	db -1

AutoBattle_EstimateDamage:
; Return in hl the damage the player's move in wPlayerMoveStruct
; is expected to deal this turn, using the same damage formula as the
; move itself, assuming no critical hit and the lowest damage roll.
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	ld hl, AutoBattleConstantDamageEffects
	ld de, 1
	call IsInArray
	jr c, .constant_damage

	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_REVERSAL
	jr z, .reversal
	cp EFFECT_HIDDEN_POWER
	jr z, .hidden_power

	callfar PlayerAttackDamage
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_RETURN
	jr z, .return
	cp EFFECT_FRUSTRATION
	jr z, .frustration
; Magnitude and Present have random power; use a typical value.
	cp EFFECT_MAGNITUDE
	jr z, .magnitude
	cp EFFECT_PRESENT
	jr nz, .damage_calc
	ld d, 40
	jr .damage_calc

.magnitude
	ld d, 70
	jr .damage_calc

.return
	callfar BattleCommand_HappinessPower
	jr .damage_calc

.frustration
	callfar BattleCommand_FrustrationPower
	jr .damage_calc

.hidden_power
	callfar HiddenPowerDamage
.damage_calc
	callfar BattleCommand_DamageCalc
	callfar BattleCommand_Stab
; Damage varies from 85% to 100% at random.
; Count on the lowest roll, so a knockout is a sure one.
	ld hl, wCurDamage
	ld a, [hli]
	ld l, [hl]
	ld h, a
	ld a, 85 percent
	call AutoBattle_MultiplyHL
	jr .got_damage_hl

.reversal
	callfar BattleCommand_ConstantDamage
	callfar BattleCommand_Stab
	jr .got_damage

.constant_damage
; These ignore type effectiveness, but not immunities.
	callfar BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	and a
	ld hl, 0
	ret z
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_PSYWAVE
	jr z, .psywave
	callfar BattleCommand_ConstantDamage
	jr .got_damage

.psywave
; Psywave deals 1 to 1.5x the user's level at random; use the level.
	ld a, [wBattleMonLevel]
	ld l, a
	ld h, 0
	jr .got_damage_hl

.got_damage
	ld hl, wCurDamage
	ld a, [hli]
	ld l, [hl]
	ld h, a
.got_damage_hl
	ld a, h
	or l
	ret z

; Account for every hit of multi-hit moves.
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_MULTI_HIT
	ld a, 3 ; 2-5 hits
	jr z, .multiply
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_TRIPLE_KICK
	ld a, 5 ; up to 1x + 2x + 3x damage
	jr z, .multiply
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_DOUBLE_HIT
	jr z, .double
	cp EFFECT_POISON_MULTI_HIT
	jr nz, .cap_damage
.double
	ld a, 2
.multiply
	ld b, h
	ld c, l
	dec a
.multiply_loop
	add hl, bc
	jr c, .max_damage
	dec a
	jr nz, .multiply_loop
	jr .cap_damage

.max_damage
	ld hl, $ffff

.cap_damage
; Damage past the foe's remaining HP is wasted,
; so a weaker move that surely knocks it out is just as good.
	ld a, [wEnemyMonHP]
	ld b, a
	ld a, [wEnemyMonHP + 1]
	ld c, a
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_FALSE_SWIPE
	jr nz, .got_max_damage
	dec bc ; False Swipe always leaves 1 HP
.got_max_damage
	ld a, c
	sub l
	ld a, b
	sbc h
	jr nc, .not_capped
	ld h, b
	ld l, c
.not_capped
	ld a, h
	or l
	ret z

	call AutoBattle_ApplyAccuracy

; Two-turn moves deal their damage over two turns.
	push hl
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	ld hl, AutoBattleTwoTurnEffects
	ld de, 1
	call IsInArray
	pop hl
	jr nc, .at_least_1
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SOLARBEAM
	jr nz, .halve
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr z, .at_least_1
.halve
	srl h
	rr l

.at_least_1
; Don't round a hit down to no damage.
	ld a, h
	or l
	ret nz
	inc l
	ret

AutoBattle_ApplyAccuracy:
; hl *= move accuracy
	ld a, [wPlayerMoveStruct + MOVE_ACC]
	; fallthrough

AutoBattle_MultiplyHL:
; hl *= a / 100 percent, without rounding a nonzero hl down to 0
	cp 100 percent
	ret nc
	inc a
	ldh [hMultiplier], a
	xor a
	ldh [hMultiplicand + 0], a
	ld a, h
	ldh [hMultiplicand + 1], a
	ld a, l
	ldh [hMultiplicand + 2], a
	call Multiply
; hl = product / 256
	ldh a, [hProduct + 1]
	ld h, a
	ldh a, [hProduct + 2]
	ld l, a
	or h
	ret nz
	ldh a, [hProduct + 3]
	and a
	ret z
	inc l
	ret

AutoBattleConstantDamageEffects:
	db EFFECT_SUPER_FANG
	db EFFECT_STATIC_DAMAGE
	db EFFECT_LEVEL_DAMAGE
	db EFFECT_PSYWAVE
	db -1

AutoBattleTwoTurnEffects:
	db EFFECT_RAZOR_WIND
	db EFFECT_SKY_ATTACK
	db EFFECT_SKULL_BASH
	db EFFECT_SOLARBEAM
	db EFFECT_FLY
	db EFFECT_HYPER_BEAM ; must recharge
	db -1
