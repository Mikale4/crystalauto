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
	call CheckContinuousAutoBattle
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
	call CheckContinuousAutoBattle
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

CheckContinuousAutoBattle:
; Return nz if battles play out by themselves: the CONTINUOUS option, or the
; Demo playing.
	ld a, [wDemoState]
	cp DEMO_RUNNING
	jr z, .yes
	ld a, [wOptions2]
	and 1 << CONTINUOUS_AUTO_BATTLE
	ret

.yes
	and a
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

; Switch out of a matchup it's losing, if a party Pokémon would win it (see
; AutoBattle_ShouldSwitch); otherwise, FIGHT.
	call AutoBattle_ShouldSwitch
	ld a, 2 ; PKMN
	jr c, .got_choice
	ld a, 1 ; FIGHT
.got_choice
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

; how the matchup stands (for healing, status and stat-raising moves)
	call AutoBattle_FoeIsEnemyMon
	ld a, [wCurBattleMon]
	ld b, FALSE
	call AutoBattle_ScoreMatchup
	ld [wABCurScore], a

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
	call AutoBattle_RateSupportMove
	ret c
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
	cp EFFECT_LOW_KICK
	jr z, .low_kick
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

.low_kick
	callfar BattleCommand_LowKick
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
; Psywave deals 0.5 to 1.5x the user's level at random; use the level.
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

AutoBattle_StatLevel:
; hl: wABAttacker or wABDefender; de: the player's stat level, bc: the enemy's.
; Return in a that stat level of the Pokémon it points to if it's in battle (the
; foe out, or the candidate when it's the one out), else BASE_STAT_LEVEL.
	ld a, [hli]
	ld h, [hl]
	ld l, a
	cp LOW(wEnemyMon)
	jr nz, .not_enemy
	ld a, h
	cp HIGH(wEnemyMon)
	jr nz, .not_enemy
	ld a, [bc]
	ret

.not_enemy
	ld a, l
	cp LOW(wABCandidate)
	jr nz, .base
	ld a, h
	cp HIGH(wABCandidate)
	jr nz, .base
	ld a, [wABCandidateOut]
	and a
	jr z, .base
	ld a, [de]
	ret

.base
	ld a, BASE_STAT_LEVEL
	ret

AutoBattle_ScaleAccuracy:
; a: a move's accuracy; b: the attacker's accuracy level; c: the defender's
; evasion level. Return its chance to hit in a, as BattleCommand_CheckHit works
; it out (at least 1, at most 100%).
	ld e, a
	ld a, b
	call .Scale
	ld a, MAX_STAT_LEVEL + 1
	sub c
	call .Scale
	ld a, e
	ret

.Scale:
; e *= the multiplier for stat level a
	push bc
	dec a
	add a
	ld c, a
	ld b, 0
	ld hl, AutoBattleAccuracyMultipliers
	add hl, bc
	xor a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	ld a, e
	ldh [hMultiplicand + 2], a
	ld a, [hli]
	ldh [hMultiplier], a
	call Multiply
	ld a, [hl]
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	and a
	ld a, $ff
	jr nz, .got
	ldh a, [hQuotient + 3]
	and a
	jr nz, .got
	inc a
.got
	ld e, a
	pop bc
	ret

AutoBattleAccuracyMultipliers:
; (as AccuracyLevelMultipliers)
	db  33, 100 ; -6
	db  36, 100 ; -5
	db  43, 100 ; -4
	db  50, 100 ; -3
	db  60, 100 ; -2
	db  75, 100 ; -1
	db   1,   1 ;  0
	db 133, 100 ; +1
	db 166, 100 ; +2
	db   2,   1 ; +3
	db 233, 100 ; +4
	db 133,  50 ; +5
	db   3,   1 ; +6

AutoBattle_ApplyAccuracy:
; hl *= the move's chance to hit, with your Pokémon's accuracy and the foe's
; evasion
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_ALWAYS_HIT
	ld a, [wPlayerMoveStruct + MOVE_ACC]
	jr z, AutoBattle_MultiplyHL
	push hl
	push af
	ld a, [wPlayerAccLevel]
	ld b, a
	ld a, [wEnemyEvaLevel]
	ld c, a
	pop af
	call AutoBattle_ScaleAccuracy
	pop hl
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

; ---------- Judging matchups: who to send out, when to switch ----------
; A party Pokémon's matchup against the foe is judged by how many turns each
; needs to knock the other out (each using its strongest move against the
; other's types, stats and HP; the foe's moves at full damage, ours at the
; lowest roll), and who moves first. Switching in also means taking a free hit.

; battle struct offsets (see battle_struct)
DEF AB_MOVES  EQU 2
DEF AB_PP     EQU 8
DEF AB_LEVEL  EQU 13
DEF AB_STATUS EQU 14
DEF AB_HP     EQU 16
DEF AB_ATK    EQU 20
DEF AB_DEF    EQU 22
DEF AB_SPD    EQU 24
DEF AB_SAT    EQU 26
DEF AB_SDF    EQU 28
DEF AB_TYPE1  EQU 30
DEF AB_TYPE2  EQU 31
	assert wBattleMonMoves - wBattleMon == AB_MOVES && wBattleMonPP - wBattleMon == AB_PP
	assert wBattleMonLevel - wBattleMon == AB_LEVEL && wBattleMonStatus - wBattleMon == AB_STATUS
	assert wBattleMonHP - wBattleMon == AB_HP && wBattleMonAttack - wBattleMon == AB_ATK
	assert wBattleMonDefense - wBattleMon == AB_DEF && wBattleMonSpeed - wBattleMon == AB_SPD
	assert wBattleMonSpclAtk - wBattleMon == AB_SAT && wBattleMonSpclDef - wBattleMon == AB_SDF
	assert wBattleMonType1 - wBattleMon == AB_TYPE1 && wBattleMonType2 - wBattleMon == AB_TYPE2
	assert wEnemyMonType2 - wEnemyMon == AB_TYPE2

DEF AB_WIN EQU 129 ; a score this high wins the matchup
DEF AB_MAX_TURNS EQU 60

DEF AB_OUR_ROLL   EQU 85 percent ; count on the lowest roll for our attacks
DEF AB_THEIR_ROLL EQU 100 percent ; and the highest for the foe's

AutoBattle_ChooseSendOut::
; wCurPartyMon: the party Pokémon (not the one out) that does best against the
; foe, for when one fainted (or BATON PASS). Return carry if there's none.
; If the foe is down too (the trainer's next is chosen after), each is judged by
; its worst matchup against the trainer's Pokémon still to come.
	call AutoBattle_FoeIsEnemyMon
	xor a
	ld [wABAgainstAll], a
	ld a, [wBattleMode]
	dec a
	jr z, .judge
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	jr nz, .judge
	ld a, TRUE
	ld [wABAgainstAll], a
.judge
	ld a, -1
	ld [wABBestSlot], a
	xor a
	ld [wABBestScore], a
	ld c, 0
.loop
	push bc
	ld a, [wCurBattleMon]
	cp c
	jr z, .next
	ld a, c
	call AutoBattle_CanSendOut
	jr nc, .next
	pop bc
	push bc
	ld a, c
	ld b, FALSE ; (no free hit: the foe moves next turn like it does)
	call AutoBattle_ScoreSendOut
	call AutoBattle_KeepIfBetter
.next
	pop bc
	inc c
	ld a, [wPartyCount]
	cp c
	jr nz, .loop
	ld a, [wABBestSlot]
	cp -1
	scf
	ret z
	ld [wCurPartyMon], a
	and a
	ret

AutoBattle_ShouldSwitch::
; Before choosing a move: return carry and wCurPartyMon to switch to a party
; Pokémon that wins the matchup the one out is losing.
	call AutoBattle_FoeIsEnemyMon
	ld a, [wAutoBattleSwitched]
	and a
	jr nz, .stay
	call AutoBattle_CanSwitchOut
	jr nc, .stay
	ld a, [wCurBattleMon]
	ld b, FALSE
	call AutoBattle_ScoreMatchup
	ld [wABCurScore], a
	ld a, [wABUs]
	ld [wABCurUs], a
	ld a, [wABCurScore]
	cp AB_WIN
	jr nc, .stay ; (it's winning)
	ld b, TRUE ; (switching in takes a hit)
	call AutoBattle_BestSwitch
	jr c, .switch
.stay
	xor a
	ld [wAutoBattleSwitched], a
	and a
	ret

.switch
	ld a, TRUE
	ld [wAutoBattleSwitched], a
	scf
	ret

AutoBattle_BestSwitch:
; b: whether switching in takes a hit. Return carry and wCurPartyMon if a party
; Pokémon (not the one out) is a sound switch: it isn't weak to any of the foe's
; attacks, it takes the foe's best attack well (two more after any it takes
; coming in), and it wins the matchup, or at least does clearly better in it
; than the one out (even if it's slower: a bulky one that resists the foe's
; attacks can take a hit). Or, if the one out can't hurt the foe at all, one
; that can.
	ld a, b
	ld [wABSwitchHit], a
	ld a, -1
	ld [wABBestSlot], a
	xor a
	ld [wABBestScore], a
	ld c, 0
.loop
	push bc
	ld a, [wCurBattleMon]
	cp c
	jr z, .next
	ld a, c
	call AutoBattle_CanSendOut
	jr nc, .next
	pop bc
	push bc
	ld a, [wABSwitchHit]
	ld b, a
	ld a, c
	call AutoBattle_ScoreMatchup
	call AutoBattle_SoundSwitchIn
	jr nc, .next
	call AutoBattle_KeepIfBetter
.next
	pop bc
	inc c
	ld a, [wPartyCount]
	cp c
	jr nz, .loop
	ld a, [wABBestSlot]
	cp -1
	jr z, .none
	ld b, a
; a winner, or clearly better (by 2 turns or more) than the one out, or one that
; can at least hurt the foe when the one out can't
	ld a, [wABBestScore]
	cp AB_WIN
	jr nc, .go
	ld c, a
	ld a, [wABCurScore]
	add 2 * 2
	jr c, .not_better
	cp c
	jr c, .go
	jr z, .go
.not_better
	ld a, [wABCurUs]
	cp AB_MAX_TURNS
	jr c, .none
	ld a, [wABBestUs]
	cp AB_MAX_TURNS
	jr nc, .none
.go
	ld a, b
	ld [wCurPartyMon], a
	scf
	ret

.none
	and a
	ret

AutoBattle_ScoreSendOut:
; AutoBattle_ScoreMatchup for party Pokémon a, or with wABAgainstAll, its worst
; score against the trainer's Pokémon still able to battle.
	ld [wABCandSlot], a
	ld a, [wABAgainstAll]
	and a
	ld a, [wABCandSlot]
	jp z, AutoBattle_ScoreMatchup
	push bc
	ld a, 255
	ld [wABMinScore], a
	xor a
	ld [wABMinUs], a
	ld a, LOW(wABFoe)
	ld [wABFoePtr], a
	ld a, HIGH(wABFoe)
	ld [wABFoePtr + 1], a
	ld c, 0
.loop
	push bc
	ld a, c
	ld hl, wOTPartyMon1HP
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	jr z, .next
	pop bc
	push bc
	ld a, c
	ld hl, wOTPartyMon1
	ld de, wABFoe
	call AutoBattle_LoadPartyStruct
	ld a, [wABCandSlot]
	ld b, FALSE
	call AutoBattle_ScoreMatchup
	ld b, a
	ld a, [wABMinScore]
	cp b
	jr c, .next
	ld a, b
	ld [wABMinScore], a
	ld a, [wABUs]
	ld [wABMinUs], a
.next
	pop bc
	inc c
	ld a, [wOTPartyCount]
	cp c
	jr nz, .loop
	ld a, [wABMinUs]
	ld [wABUs], a
	call AutoBattle_FoeIsEnemyMon
	ld a, [wABMinScore]
	pop bc
	ret

AutoBattle_SoundSwitchIn:
; After AutoBattle_ScoreMatchup: return carry if the Pokémon could come in on
; the foe: none of the foe's damaging moves is super effective on it, and it
; can take at least two more of the foe's best attacks after coming in.
	push af
	ld a, [wABThemEffectiveness]
	cp 4 + 1 ; (neutral is 4)
	jr nc, .unsound
	ld a, [wABThem]
	cp 2
	jr c, .unsound
	pop af
	scf
	ret

.unsound
	pop af
	and a
	ret

AutoBattle_KeepIfBetter:
; a: the score of party Pokémon c (wABUs: its turns to knock the foe out).
; Keep it if it's the best so far (ties go to the quicker knockout).
	ld b, a
	ld a, [wABBestSlot]
	cp -1
	jr z, .better
	ld a, [wABBestScore]
	cp b
	jr c, .better
	ret nz
	ld a, [wABUs]
	ld e, a
	ld a, [wABBestUs]
	cp e
	ret c
	ret z
.better
	ld a, b
	ld [wABBestScore], a
	ld a, [wABUs]
	ld [wABBestUs], a
	ld a, c
	ld [wABBestSlot], a
	ret

AutoBattle_CanSendOut:
; Return carry if party Pokémon a can battle (not an EGG, not fainted).
	ld e, a
	ld d, 0
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
	cp EGG
	jr z, .no
	ld a, e
	ld hl, wPartyMon1HP
	call GetPartyLocation
	ld a, [hli]
	or [hl]
	jr z, .no
	scf
	ret

.no
	and a
	ret

AutoBattle_CanSwitchOut:
; Return carry if the player's Pokémon can be switched out on its own.
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .no
	cp BATTLETYPE_CONTEST
	jr z, .no
	cp BATTLETYPE_DEBUG
	jr z, .no
	ld a, [wPlayerWrapCount]
	and a
	jr nz, .no
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_CANT_RUN, a
	jr nz, .no
	scf
	ret

.no
	and a
	ret

AutoBattle_ScoreMatchup:
; Party Pokémon a against the foe (wABFoePtr; b: TRUE if it must first take a
; free hit).
; Return its score in a: 128 + 2 x (the foe's turns to knock it out - its turns
; to knock the foe out), + 1 if it's faster; AB_WIN and up wins.
; Also wABUs, wABThem, and the foe's best type effectiveness against it in
; wABThemEffectiveness (in quarters: 4 is neutral).
	push bc
	call AutoBattle_LoadCandidate
; the foe's best attack on it
	call AutoBattle_GetFoe
	ld de, wABCandidate
	ld a, AB_THEIR_ROLL
	call AutoBattle_BestDamage
	push hl ; the foe's damage
	ld a, [wABBestCategory]
	ld [wABThemCategory], a
	ld a, [wABBestEffectiveness]
	push af
; its best attack on the foe
	call AutoBattle_GetFoe
	ld d, h
	ld e, l
	ld hl, wABCandidate
	ld a, AB_OUR_ROLL
	call AutoBattle_BestDamage
	ld b, h
	ld c, l
	call AutoBattle_GetFoe
	ld de, AB_HP
	add hl, de
	ld a, [hli]
	ld l, [hl]
	ld h, a
	call AutoBattle_TurnsToKO
	ld [wABUs], a
	pop af
	ld [wABThemEffectiveness], a
	pop bc ; the foe's damage
	ld a, b
	ld [wABThemDamage], a
	ld a, c
	ld [wABThemDamage + 1], a
	ld hl, wABCandidate + AB_HP
	ld a, [hli]
	ld l, [hl]
	ld h, a
	pop de ; d: whether it takes a hit first
	push de
	ld a, d
	and a
	jr z, .no_free_hit
; it takes one hit coming in
	ld a, l
	sub c
	ld l, a
	ld a, h
	sbc b
	ld h, a
	jr c, .fainted
	or l
	jr z, .fainted
.no_free_hit
	call AutoBattle_TurnsToKO
	ld [wABThem], a
; 128 + 2 x (them - us)
	ld b, a
	ld a, [wABUs]
	ld c, a
	ld a, b
	sub c
	jr c, .losing
	cp 63
	jr c, .got_margin
	ld a, 63
.got_margin
	add a
	add 128
	jr .speed

.losing
	cpl
	inc a ; us - them
	cp 64
	jr c, .got_loss
	ld a, 64
.got_loss
	add a
	ld b, a
	ld a, 128
	sub b
.speed
	ld b, a
; + 1 if it's faster
	call AutoBattle_GetFoe
	ld de, AB_SPD
	add hl, de
	push hl
	ld hl, wABCandidate + AB_SPD
	ld a, [hli]
	ld e, [hl]
	ld d, a
	pop hl
	ld a, [hli]
	ld l, [hl]
	ld h, a
	ld a, l
	sub e
	ld a, h
	sbc d
	ld a, b
	jr nc, .done ; (not faster)
	inc a
.done
	pop bc
	ret

.fainted
	xor a
	ld [wABThem], a
	pop bc
	ret

AutoBattle_TurnsToKO:
; a = how many hits of bc damage it takes to knock out hl HP (at most AB_MAX_TURNS).
	ld a, b
	or c
	ld a, AB_MAX_TURNS
	ret z
	ld e, 0
.loop
	inc e
	ld a, e
	cp AB_MAX_TURNS
	ret nc
	ld a, l
	sub c
	ld l, a
	ld a, h
	sbc b
	ld h, a
	jr c, .done
	or l
	jr nz, .loop
.done
	ld a, e
	ret

AutoBattle_GetFoe:
; hl: the foe's battle struct.
	ld hl, wABFoePtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

AutoBattle_FoeIsEnemyMon:
	ld a, LOW(wEnemyMon)
	ld [wABFoePtr], a
	ld a, HIGH(wEnemyMon)
	ld [wABFoePtr + 1], a
	ret

AutoBattle_LoadCandidate:
; wABCandidate: party Pokémon a as a battle struct (the one out: wBattleMon,
; with wABCandidateOut set).
	ld hl, wCurBattleMon
	cp [hl]
	jr nz, .party
	ld a, TRUE
	ld [wABCandidateOut], a
	ld hl, wBattleMon
	ld de, wABCandidate
	ld bc, wBattleMonStructEnd - wBattleMon
	jp CopyBytes

.party
	ld hl, wABCandidateOut
	ld [hl], FALSE
	ld hl, wPartyMon1
	ld de, wABCandidate
	; fallthrough

AutoBattle_LoadPartyStruct:
; Battle struct de: Pokémon a of the party at hl (wPartyMon1 or wOTPartyMon1).
	push de
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	pop de
	push de ; (the battle struct)
	push hl ; (the party struct)
	ld bc, MON_OT_ID ; species, item, moves
	call CopyBytes
	pop hl
	push hl
	ld bc, MON_DVS
	add hl, bc
	ld bc, MON_HAPPINESS + 1 - MON_DVS ; DVs, PP, happiness
	call CopyBytes
	pop hl
	push hl
	ld bc, MON_LEVEL
	add hl, bc
	ld a, [hli] ; level
	ld [de], a
	inc de
	ld a, [hli] ; status
	ld [de], a
	inc de
	xor a
	ld [de], a
	inc de
	inc hl
	ld bc, MON_STATS + NUM_BATTLE_STATS * 2 - MON_HP ; HP, max HP, stats
	call CopyBytes
	pop hl
; its types
	ld a, [hl]
	dec a
	ld hl, BaseData + BASE_TYPES
	ld bc, BASE_DATA_SIZE
	call AddNTimes
	ld a, BANK(BaseData)
	call GetFarByte
	ld b, a
	inc hl
	ld a, BANK(BaseData)
	call GetFarByte
	ld c, a
	pop hl
	push hl
	ld de, AB_TYPE1
	add hl, de
	ld a, b
	ld [hli], a
	ld [hl], c
; paralysis halves its speed
	pop hl
	ld de, AB_STATUS
	add hl, de
	bit PAR, [hl]
	ret z
	ld de, AB_SPD - AB_STATUS
	add hl, de
	srl [hl]
	inc hl
	rr [hl]
	ret

AutoBattle_BestDamage:
; hl = the most damage battle struct hl's moves can do to battle struct de
; (a: the damage roll to count on, /256), taking accuracy into account; also
; wABBestEffectiveness: the best type effectiveness of its damaging moves.
	ld [wABRoll], a
	ld a, l
	ld [wABAttacker], a
	ld a, h
	ld [wABAttacker + 1], a
	ld a, e
	ld [wABDefender], a
	ld a, d
	ld [wABDefender + 1], a
	xor a
	ld [wABDamage], a
	ld [wABDamage + 1], a
	ld [wABBestEffectiveness], a
	ld c, 0
.loop
	push bc
	call AutoBattle_AttackerField
	db AB_PP
	ld b, 0
	add hl, bc
	ld a, [hl]
	and PP_MASK
	jr z, .next
	call AutoBattle_AttackerField
	db AB_MOVES
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next
	call AutoBattle_MoveDamage
; keep the most (and its category)
	ld a, [wABDamage + 1]
	sub l
	ld a, [wABDamage]
	sbc h
	jr nc, .next
	ld a, h
	ld [wABDamage], a
	ld a, l
	ld [wABDamage + 1], a
	ld a, [wABMove + MOVE_TYPE]
	and ~TYPE_MASK
	ld [wABBestCategory], a
.next
	pop bc
	inc c
	ld a, c
	cp NUM_MOVES
	jr c, .loop
	ld hl, wABDamage
	ld a, [hli]
	ld l, [hl]
	ld h, a
	ret

AutoBattle_AttackerField:
; hl: the attacker's field (the byte after the call: its offset).
	ld hl, wABAttacker
	jr AutoBattle_StructField

AutoBattle_DefenderField:
; hl: the defender's field (the byte after the call: its offset).
	ld hl, wABDefender
AutoBattle_StructField:
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop de ; the return address: the offset's address
	ld a, [de]
	inc de
	push de
	add l
	ld l, a
	ret nc
	inc h
	ret

AutoBattle_MoveDamage:
; hl = the damage move a does from the attacker to the defender (0 if none):
; the damage formula, the attacker's type, the defender's types, accuracy, and
; whether it hits more than once or takes two turns.
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wABMove
	ld bc, MOVE_LENGTH
	ld a, BANK(Moves)
	call FarCopyBytes
	ld a, [wABMove + MOVE_POWER]
	and a
	jp z, .none
; type effectiveness (and immunities)
	ld a, [wABMove + MOVE_TYPE]
	and TYPE_MASK
	call AutoBattle_TypeEffectiveness
	and a
	jp z, .none
	ld [wABEffectiveness], a

	ld a, [wABMove + MOVE_EFFECT]
	ld hl, AutoBattleNeverDamagingEffects
	ld de, 1
	call IsInArray
	jp c, .none
	ld a, [wABMove + MOVE_EFFECT]
	cp EFFECT_LEVEL_DAMAGE
	jp z, .level
	cp EFFECT_PSYWAVE
	jp z, .level
	cp EFFECT_STATIC_DAMAGE
	jp z, .static
	cp EFFECT_SUPER_FANG
	jp z, .super_fang

; (how effective its best attack can be)
	ld a, [wABEffectiveness]
	ld b, a
	ld a, [wABBestEffectiveness]
	cp b
	jr nc, .effectiveness_ok
	ld a, b
	ld [wABBestEffectiveness], a
.effectiveness_ok
; the power (some vary: count on a typical one)
	ld a, [wABMove + MOVE_EFFECT]
	ld hl, AutoBattleTypicalPowers
	ld de, 2
	call IsInArray
	ld a, [wABMove + MOVE_POWER]
	jr nc, .got_power
	inc hl
	ld a, [hl]
.got_power
	ld [wABMove + MOVE_POWER], a

; attack and defense stats, by the move's category
	ld a, [wABMove + MOVE_TYPE]
	cp SPECIAL
	jr nc, .special
	call AutoBattle_AttackerField
	db AB_ATK
	push hl
	call AutoBattle_DefenderField
	db AB_DEF
	jr .got_stats

.special
	call AutoBattle_AttackerField
	db AB_SAT
	push hl
	call AutoBattle_DefenderField
	db AB_SDF
.got_stats
	ld a, [hli]
	ld c, [hl]
	ld b, a ; bc: defense
	pop hl
	ld a, [hli]
	ld l, [hl]
	ld h, a ; hl: attack
; both under 256, as the game does it
.scale
	ld a, h
	or b
	jr z, .scaled
	srl h
	rr l
	srl h
	rr l
	srl b
	rr c
	srl b
	rr c
	jr .scale

.scaled
	ld a, c
	and a
	jr nz, .def_ok
	inc c
.def_ok
	ld a, l
	and a
	jr nz, .atk_ok
	inc l
.atk_ok
	push bc ; (c: defense)
	push hl ; (l: attack)
; (level x 2 / 5 + 2) x power x attack / defense / 50 + 2
	call AutoBattle_AttackerField
	db AB_LEVEL
	ld a, [hl]
	add a
	ld c, 5
	call SimpleDivide ; b = a / 5
	ld a, b
	add 2
	ldh [hMultiplicand + 2], a
	xor a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	ld a, [wABMove + MOVE_POWER]
	ldh [hMultiplier], a
	call Multiply
	pop hl
	ld a, l
	ldh [hMultiplier], a
	call Multiply
	pop bc
	ld a, c
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ld a, 50
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	ld h, a
	ldh a, [hQuotient + 3]
	ld l, a
; (more than anything has HP for is all the same)
	ld a, h
	cp HIGH(1024)
	jr c, .not_capped
	ld hl, 1023
.not_capped
	inc hl
	inc hl
; its own type: x 1.5
	ld a, [wABMove + MOVE_TYPE]
	and TYPE_MASK
	ld b, a
	push hl
	call AutoBattle_AttackerField
	db AB_TYPE1
	ld a, [hli]
	cp b
	jr z, .stab
	ld a, [hl]
	cp b
	jr nz, .no_stab
.stab
	pop hl
	ld d, h
	ld e, l
	srl d
	rr e
	add hl, de
	push hl
.no_stab
	pop hl
; type effectiveness (in quarters)
	ld a, [wABEffectiveness]
.effectiveness
	cp 4
	jr z, .got_effectiveness
	jr c, .resisted
	add hl, hl
	srl a
	jr .effectiveness

.resisted
	srl h
	rr l
	sla a
	jr .effectiveness

.got_effectiveness
; hits more than once, or takes two turns
	ld a, [wABMove + MOVE_EFFECT]
	cp EFFECT_MULTI_HIT
	ld b, 3 ; (2-5 hits)
	jr z, .times
	cp EFFECT_TRIPLE_KICK
	ld b, 5 ; (up to 1x + 2x + 3x)
	jr z, .times
	cp EFFECT_DOUBLE_HIT
	ld b, 2
	jr z, .times
	cp EFFECT_POISON_MULTI_HIT
	jr z, .times
	push hl
	ld hl, AutoBattleTwoTurnEffects
	ld de, 1
	call IsInArray
	pop hl
	jr nc, .roll
	srl h
	rr l
	jr .roll

.times
	ld d, h
	ld e, l
	dec b
.times_loop
	add hl, de
	dec b
	jr nz, .times_loop
.roll
; the roll to count on, then the chance to hit (with the accuracy and evasion
; of the Pokémon in battle)
	ld a, [wABRoll]
	call AutoBattle_MultiplyHL
	ld a, [wABMove + MOVE_EFFECT]
	cp EFFECT_ALWAYS_HIT
	ld a, [wABMove + MOVE_ACC]
	jp z, AutoBattle_MultiplyHL
	push hl
	ld hl, wABAttacker
	ld de, wPlayerAccLevel
	ld bc, wEnemyAccLevel
	call AutoBattle_StatLevel
	push af
	ld hl, wABDefender
	ld de, wPlayerEvaLevel
	ld bc, wEnemyEvaLevel
	call AutoBattle_StatLevel
	ld c, a
	pop af
	ld b, a
	ld a, [wABMove + MOVE_ACC]
	call AutoBattle_ScaleAccuracy
	pop hl
	jp AutoBattle_MultiplyHL

.level
	call AutoBattle_AttackerField
	db AB_LEVEL
	ld l, [hl]
	ld h, 0
	ret

.static
	ld a, [wABMove + MOVE_POWER]
	ld l, a
	ld h, 0
	ret

.super_fang
	call AutoBattle_DefenderField
	db AB_HP
	ld a, [hli]
	ld l, [hl]
	ld h, a
	srl h
	rr l
	ret

.none
	ld hl, 0
	ret

AutoBattle_TypeEffectiveness:
; a = how effective attack type a is against the defender's types, in quarters
; (0, 1, 2, 4, 8 or 16; 4 is neutral). GHOST's immunities stand (no FORESIGHT).
	ld b, a
	push bc
	call AutoBattle_DefenderField
	db AB_TYPE1
	pop bc
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld c, 4
	ld hl, TypeMatchups
.loop
	ld a, BANK(TypeMatchups)
	call GetFarByte
	inc hl
	cp -1
	jr z, .done
	cp -2
	jr z, .loop
	cp b
	jr nz, .skip
	ld a, BANK(TypeMatchups)
	call GetFarByte
	inc hl
	cp d
	jr z, .match
	cp e
	jr nz, .skip_mult
.match
	ld a, BANK(TypeMatchups)
	call GetFarByte
	inc hl
	and a ; NO_EFFECT
	jr z, .immune
	cp EFFECTIVE
	jr c, .half
	sla c
	jr .loop

.half
	srl c
	jr .loop

.immune
	ld c, 0
	jr .loop

.skip
	inc hl
.skip_mult
	inc hl
	jr .loop

.done
	ld a, c
	ret

AutoBattleNeverDamagingEffects:
; no damage to count on from these
	db EFFECT_SELFDESTRUCT
	db EFFECT_DREAM_EATER
	db EFFECT_SNORE
	db EFFECT_OHKO
	db EFFECT_COUNTER
	db EFFECT_MIRROR_COAT
	db EFFECT_BIDE
	db EFFECT_FUTURE_SIGHT
	db -1

AutoBattleTypicalPowers:
; moves whose power varies, and a typical power
	db EFFECT_RETURN,      70
	db EFFECT_FRUSTRATION, 70
	db EFFECT_REVERSAL,    40
	db EFFECT_PRESENT,     40
	db EFFECT_MAGNITUDE,   70
	db EFFECT_LOW_KICK,    60
	db EFFECT_BEAT_UP,     30
	db -1

; ---------- Healing, status and stat-raising moves, when they're worth it ----------

AutoBattle_RateSupportMove:
; Return carry and its rating in hl if the move in wPlayerMoveStruct is a
; healing, status, stat-raising or stat-lowering move worth using now (by how the matchup
; stands: see AutoBattle_ChooseMove). Such a move comes before any attack,
; except one that knocks the foe out.
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	ld hl, AutoBattleHealEffects
	ld de, 1
	call IsInArray
	jr c, .heal
; status and stat-raising moves only against trainers (wild battles go quicker)
	ld a, [wBattleMode]
	dec a
	jp z, .no
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SLEEP
	jp z, .sleep
	cp EFFECT_PARALYZE
	jp z, .paralyze
	cp EFFECT_TOXIC
	jp z, .toxic
	ld hl, AutoBattleStatUpEffects
	ld de, 3
	call IsInArray
	jp c, .stat_up
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	ld hl, AutoBattleStatDownEffects
	ld de, 3
	call IsInArray
	jp c, .stat_down
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	ld hl, AutoBattleGuardEffects
	ld de, 3
	call IsInArray
	jp c, .guard
.no
	and a
	ret

.heal
; not when an attack knocks the foe out this turn
	ld a, [wABUs]
	cp 2
	jp c, .no
; only under half its HP (a third for REST)
	ld hl, wBattleMonHP
	ld a, [hli]
	ld l, [hl]
	ld h, a
	ld d, h
	ld e, l
	add hl, hl
	ld a, [wPlayerMoveStruct + MOVE_ANIM]
	cp REST
	jr nz, .got_hp
	add hl, de
.got_hp
	ld a, [wBattleMonMaxHP]
	ld d, a
	ld a, [wBattleMonMaxHP + 1]
	ld e, a
	ld a, l
	sub e
	ld a, h
	sbc d
	jp nc, .no
; and only if the foe can't take that back each turn (under half its max HP; a
; quarter for REST, which sleeps two turns)
	ld hl, wABThemDamage
	ld a, [hli]
	ld l, [hl]
	ld h, a
	add hl, hl
	ld a, [wPlayerMoveStruct + MOVE_ANIM]
	cp REST
	jr nz, .got_damage
	add hl, hl
.got_damage
	ld a, l
	sub e
	ld a, h
	sbc d
	jp nc, .no
	ld b, 1
	jp .rating

.sleep
; when knocking the foe out takes three turns or more, and it can't knock this
; one out first
	call .CanAffectFoe
	jp nc, .no
	ld a, [wABUs]
	cp 3
	jp c, .no
	ld a, [wABThem]
	cp 2
	jp c, .no
	ld b, 2
	jp .rating

.paralyze
; when knocking the foe out takes two turns or more, and it's faster or takes
; three; and it can't knock this one out first
	call .CanAffectFoe
	jp nc, .no
	ld a, [wABThem]
	cp 2
	jp c, .no
	ld a, [wABUs]
	cp 2
	jp c, .no
	cp 3
	jr nc, .paralyze_ok
	ld a, [wABCurScore]
	bit 0, a
	jp nz, .no ; (this one is faster)
.paralyze_ok
	ld b, 3
	jp .rating

.toxic
; in a long fight (four turns or more), against a foe that isn't POISON or STEEL
	call .CanAffectFoe
	jp nc, .no
	ld a, [wEnemyMonType1]
	call .PoisonProof
	jp z, .no
	ld a, [wEnemyMonType2]
	call .PoisonProof
	jp z, .no
	ld a, [wABUs]
	cp 4
	jp c, .no
	ld a, [wABThem]
	cp 3
	jp c, .no
	ld b, 3
	jp .rating

.stat_up
; when the foe can barely hurt it (four turns or more to knock it out), it takes
; two turns or more to knock the foe out, the stat is no more than one stage up,
; and the stat suits its best attack
	inc hl
	ld a, [hli] ; the stat
	ld c, a
	ld a, [hl] ; the category it suits (0: any)
	ld d, a
	ld a, [wABThem]
	cp 4
	jp c, .no
	ld a, [wABUs]
	cp 2
	jp c, .no
	ld a, d
	and a
	jr z, .any_category
	ld a, [wABBestCategory]
	cp d
	jp nz, .no
.any_category
	ld b, 0
	ld hl, wPlayerStatLevels
	add hl, bc
	ld a, [hl]
	cp BASE_STAT_LEVEL + 2
	jp nc, .no
; AGILITY only when it's slower; CURSE only for a POKéMON that isn't a GHOST
	ld a, [wPlayerMoveStruct + MOVE_EFFECT]
	cp EFFECT_SPEED_UP_2
	jr nz, .not_speed
	ld a, [wABCurScore]
	bit 0, a
	jp nz, .no
	jr .stat_up_ok

.not_speed
	cp EFFECT_CURSE
	jr nz, .stat_up_ok
	ld a, [wBattleMonType1]
	cp GHOST
	jp z, .no
	ld a, [wBattleMonType2]
	cp GHOST
	jp z, .no
.stat_up_ok
	ld b, 4

.rating
; hl = AUTO_BATTLE_DAMAGE + the foe's HP - b: above any attack that doesn't knock
; it out, and the lower b, the higher
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld l, [hl]
	ld h, a
	ld de, AUTO_BATTLE_DAMAGE
	add hl, de
	ld a, l
	sub b
	ld l, a
	jr nc, .rated
	dec h
.rated
	scf
	ret

.stat_down
; when it pays for the turn it takes (see AutoBattleStatDownEffects), or for the
; teammates that follow (see .ForTheTeam); the stat no more than one stage down
	inc hl
	ld a, [hli] ; the stat
	ld c, a
	ld d, [hl] ; when it pays
	ld a, [wEnemySubStatus4]
	and 1 << SUBSTATUS_SUBSTITUTE | 1 << SUBSTATUS_MIST
	jp nz, .no
	push bc
	push de
	call .ForTheTeam
	pop de
	jr nc, .not_for_team
	ld a, d
	and a
	jr z, .lower_now ; (its accuracy: every teammate gains)
	dec a
	jr z, .team_defense
; its ATTACK: against physical attacks
	ld a, [wABThemCategory]
	cp PHYSICAL
	jr z, .lower_now
	jr .not_for_team

.team_defense
; its DEFENSE: for physical attacks (or when this one has none to use)
	ld a, [wABUs]
	cp AB_MAX_TURNS
	jr z, .lower_now
	ld a, [wABBestCategory]
	cp PHYSICAL
	jr z, .lower_now
.not_for_team
	ld a, d
	and a
	jr z, .accuracy
	dec a
	jr z, .defense
; its ATTACK: against physical attacks, when that wins this one the race
	ld a, [wABThemCategory]
	cp PHYSICAL
	jr nz, .pop_no
	lb bc, 3, 2 ; (it takes half again as many turns to knock this one out)
	call .FlipsRace
	jr .lower

.defense
; its DEFENSE: for this one's physical attacks, when that saves a turn
	ld a, [wABBestCategory]
	cp PHYSICAL
	jr nz, .pop_no
	call .SavesTurn
	jr .lower

.accuracy
; its accuracy: when that wins this one the race
	lb bc, 4, 3 ; (a quarter of its attacks missing)
	call .FlipsRace
.lower
	pop bc
	jp nc, .no
	jr .lower_stat

.lower_now
	pop bc
.lower_stat
	ld b, 0
	ld hl, wEnemyStatLevels
	add hl, bc
	ld a, [hl]
	cp BASE_STAT_LEVEL - 1
	jp c, .no
	ld b, 5
	jp .rating

.pop_no
	pop bc
	jp .no

.guard
; a defensive stat that suits the foe's attacks, no more than one stage up,
; when that wins this one the race
	inc hl
	ld a, [hli] ; the stat
	ld c, a
	ld d, [hl] ; the category of the foe's attacks it's against (0: any)
	ld a, d
	and a
	jr z, .guard_any
	ld a, [wABThemCategory]
	cp d
	jp nz, .no
.guard_any
	push bc
	ld a, c
	cp EVASION
	lb bc, 3, 2 ; (DEFENSE, SP.DEF: half again as many turns)
	jr nz, .guard_factor
	lb bc, 4, 3 ; (evasion: a quarter of its attacks missing)
.guard_factor
	call .FlipsRace
	pop bc
	jp nc, .no
	ld b, 0
	ld hl, wPlayerStatLevels
	add hl, bc
	ld a, [hl]
	cp BASE_STAT_LEVEL + 2
	jp nc, .no
	ld b, 5
	jp .rating

.FlipsRace:
; b, c: n, m. Return carry if this one is losing the race to a knockout (the foe
; needs no more turns than it does), but would win it if the foe needed n/m as
; many, after the turn this takes.
	ld a, [wABThem]
	ld d, a
	ld a, [wABUs]
	cp d
	jr c, .no_flip ; (it's winning anyway)
	ld a, d
	call .Times
	ld d, a
	ld a, [wABUs]
	inc a
	cp d
	jr z, .flip
	jr nc, .no_flip
.flip
	scf
	ret

.no_flip
	and a
	ret

.ForTheTeam:
; Return carry if this one clearly loses its race to a knockout (it needs two
; turns more than the foe, or more: the estimates are cautious ones), in a long
; fight (four or more of its attacks to knock the foe out), and a teammate can
; fight on after it: then a stat lowered helps the teammates that follow (it
; stays while the foe does).
	ld a, [wABUs]
	cp 4
	jr c, .no_flip
	ld b, a
	ld a, [wABThem]
	add 2
	ld c, a
	ld a, b
	cp c
	jr c, .no_flip ; (it could win)
	ld a, [wCurBattleMon]
	ld b, a
	ld a, [wPartyCount]
	ld c, a
.teammate
	dec c
	ld a, c
	cp -1
	jr z, .no_flip
	cp b
	jr z, .teammate
	push bc
	call AutoBattle_CanSendOut
	pop bc
	jr nc, .teammate
	scf
	ret

.SavesTurn:
; Return carry if, with the foe's DEFENSE a stage down (2/3 the turns), knocking
; it out would take fewer turns, this one included, and still win the race.
	ld a, [wABUs]
	lb bc, 2, 3
	call .Times
	inc a
	ld d, a
	ld a, [wABUs]
	cp d
	jr c, .no_flip
	jr z, .no_flip
	ld a, [wABThem]
	cp d
	jr c, .no_flip
	scf
	ret

.Times:
; Return a (turns, at most 60) x b / c, rounded up.
	cp 60
	jr c, .capped
	ld a, 60
.capped
	ld e, a
	xor a
.times
	add e
	dec b
	jr nz, .times
	add c
	dec a
	ld b, 0
.divide
	cp c
	jr c, .divided
	sub c
	inc b
	jr .divide

.divided
	ld a, b
	ret

.CanAffectFoe:
; Return carry if the foe has no status, substitute or SAFEGUARD, and the move's
; type can affect it.
	ld a, [wEnemyMonStatus]
	and a
	ret nz ; (nc)
	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	jr nz, .cant
	ld a, [wEnemyScreens]
	bit SCREENS_SAFEGUARD, a
	jr nz, .cant
	callfar BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	and a
	jr z, .cant
	scf
	ret

.cant
	and a
	ret

.PoisonProof:
; Return z if type a can't be poisoned.
	cp POISON
	ret z
	cp STEEL
	ret

AutoBattleHealEffects:
	db EFFECT_HEAL ; RECOVER, SOFTBOILED, MILK DRINK, REST
	db EFFECT_MORNING_SUN
	db EFFECT_SYNTHESIS
	db EFFECT_MOONLIGHT
	db -1

AutoBattleStatDownEffects:
; effect, the foe's stat it lowers (wEnemyStatLevels index), when it pays (0:
; its accuracy, 1: its DEFENSE, 2: its ATTACK; see .stat_down)
	db EFFECT_ACCURACY_DOWN,   ACCURACY, 0 ; SAND-ATTACK, SMOKESCREEN, FLASH
	db EFFECT_ACCURACY_DOWN_2, ACCURACY, 0
	db EFFECT_DEFENSE_DOWN,    DEFENSE,  1 ; LEER, TAIL WHIP
	db EFFECT_DEFENSE_DOWN_2,  DEFENSE,  1 ; SCREECH
	db EFFECT_ATTACK_DOWN,     ATTACK,   2 ; GROWL
	db EFFECT_ATTACK_DOWN_2,   ATTACK,   2 ; CHARM
	db -1

AutoBattleGuardEffects:
; effect, the stat it raises (wPlayerStatLevels index), the category of the foe's
; attacks it's against (0: any)
	db EFFECT_DEFENSE_UP,   DEFENSE,    PHYSICAL ; HARDEN, WITHDRAW, DEFENSE CURL
	db EFFECT_DEFENSE_UP_2, DEFENSE,    PHYSICAL ; BARRIER, ACID ARMOR
	db EFFECT_SP_DEF_UP_2,  SP_DEFENSE, SPECIAL  ; AMNESIA
	db EFFECT_EVASION_UP,   EVASION,    0        ; DOUBLE TEAM, MINIMIZE
	db -1

AutoBattleStatUpEffects:
; effect, the stat it raises (wPlayerStatLevels index), the category it suits
	db EFFECT_ATTACK_UP_2,  ATTACK,  PHYSICAL ; SWORDS DANCE
	db EFFECT_ATTACK_UP,    ATTACK,  PHYSICAL ; MEDITATE, SHARPEN
	db EFFECT_CURSE,        ATTACK,  PHYSICAL ; (not a GHOST's)
	db EFFECT_SP_ATK_UP_2,  SP_ATTACK, SPECIAL
	db EFFECT_SP_ATK_UP,    SP_ATTACK, SPECIAL ; GROWTH
	db EFFECT_SPEED_UP_2,   SPEED,   0 ; AGILITY (when slower)
	db -1
