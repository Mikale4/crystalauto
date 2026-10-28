; Moves as they work in the latest games, where they changed since GOLD and
; SILVER (called from the battle engine, which has little room left).

GetRecoilDamage::
; BattleCommand_Recoil: return the recoil in bc (at least 1 HP), and the user's
; max HP in hl. STRUGGLE costs 1/4 of the user's max HP, DOUBLE-EDGE 1/3 of the
; damage it did, the others 1/4 of it.
	ld hl, wBattleMonMaxHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wEnemyMonMaxHP
.got_hp
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cpmove STRUGGLE
	jr z, .struggle
	cpmove DOUBLE_EDGE
	jr z, .third
	ld a, [wCurDamage]
	ld b, a
	ld a, [wCurDamage + 1]
	ld c, a
	jr .quarter

.struggle
	ld a, [hli]
	ld b, a
	ld a, [hld]
	ld c, a
.quarter
	srl b
	rr c
	srl b
	rr c
	jr .got_recoil

.third
	xor a
	ldh [hDividend], a
	ldh [hDividend + 1], a
	ld a, [wCurDamage]
	ldh [hDividend + 2], a
	ld a, [wCurDamage + 1]
	ldh [hDividend + 3], a
	ld a, 3
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	ld c, a
.got_recoil
	ld a, b
	or c
	ret nz
	inc c
	ret

GetLowKickPower::
; BattleCommand_LowKick: LOW KICK's power d (50, as in the first games) is twice
; that when the target's DEFENSE c is higher than the user's ATTACK b, as they
; are for this hit (stat levels and all). (Keeps bc and e, the level.)
	ld a, b
	cp c
	ret nc
	sla d
	ret

GetDrainAmount::
; SapHealth: hDividend (2 bytes) = how much a draining move heals: half the
; damage, or 3/4 of it for DRAINING KISS (and at least 1 HP).
	ld hl, wCurDamage
	ld a, [hli]
	ld b, a
	ld c, [hl]
	srl b
	rr c
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cpmove DRAINING_KISS
	jr nz, .got_amount
	ld h, b
	ld l, c
	srl h
	rr l
	add hl, bc
	ld b, h
	ld c, l
.got_amount
	ld a, b
	or c
	jr nz, .at_least_one
	inc c
.at_least_one
	ld a, b
	ldh [hDividend], a
	ld a, c
	ldh [hDividend + 1], a
	ret

GetWeatherHealAmount::
; MOONLIGHT, MORNING SUN and SYNTHESIS: bc = how much they heal (and wHPBuffer1
; = the max HP): 1/2 of the max HP, 2/3 in sunshine, 1/4 in rain or a sandstorm.
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr z, .two_thirds
	and a
	jr z, .half
	farcall GetQuarterMaxHP
	ret

.half
	farcall GetHalfMaxHP
	ret

.two_thirds
	farcall GetMaxHP
	sla c
	rl b
	xor a
	ldh [hDividend], a
	ldh [hDividend + 1], a
	ld a, b
	ldh [hDividend + 2], a
	ld a, c
	ldh [hDividend + 3], a
	ld a, 3
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	ld c, a
	ret

HandleHeldEntryItems::
; Each turn (like the BERSERK GENE, see HandleBerserkGene): an X item, DIRE HIT or
; GUARD SPEC. held by a Pokémon that's out is used up for its boost.
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse
	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	xor a
	ldh [hBattleTurn], a
	ld de, wPartyMon1Item
	ld a, [wCurBattleMon]
	jr .go

.enemy
	ld a, 1
	ldh [hBattleTurn], a
	ld de, wOTPartyMon1Item
	ld a, [wCurOTMon]
.go
	push de
	push af
	farcall GetUserItem
	ld a, b
	cp HELD_ENTRY_BOOST
	jr z, .use
	pop af
	pop de
	ret

.use
; used up (gone from its party data too)
	ld a, [hl]
	ld [wNamedObjectIndex], a
	xor a
	ld [hl], a
	ld a, c
	ld [wEntryBoost], a
	pop af
	pop hl
	call GetPartyLocation
	xor a
	ld [hl], a
	ld a, [wEntryBoost]
	cp ENTRY_FOCUS
	jr z, .focus
	cp ENTRY_MIST
	jr z, .mist
; a stat, a stage up
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVarAddr
	push hl
	push af
	xor a
	ld [hl], a
	ld [wAttackMissed], a
	ld [wEffectFailed], a
	ld a, [wEntryBoost]
	ld e, a
	ld d, 0
	ld hl, .StatUps
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, BANK(BattleCommand_AttackUp)
	rst FarCall
	pop af
	pop hl
	ld [hl], a
	call .Activated
	farcall BattleCommand_StatUpMessage
	ret

.focus
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	call .Activated
	ld hl, GettingPumpedText
	jp StdBattleTextbox

.mist
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVarAddr
	set SUBSTATUS_MIST, [hl]
	call .Activated
	ld hl, MistText
	jp StdBattleTextbox

.Activated:
	call GetItemName
	ld hl, BattleText_UsersStringBuffer1Activated
	jp StdBattleTextbox

.StatUps:
; entries correspond to ENTRY_* constants
	dw BattleCommand_AttackUp
	dw BattleCommand_DefenseUp
	dw BattleCommand_SpeedUp
	dw BattleCommand_SpecialAttackUp
	dw BattleCommand_SpecialDefenseUp
	dw BattleCommand_AccuracyUp

SaveBattleHeldItems:
; Remember what each POKéMON in the party holds as the battle starts, so that
; what's used up in it (a berry, an X item) comes back afterwards.
	ld a, [wPartyCount]
	ld b, a
	ld c, 0
	ld hl, wPartyMon1Item
	ld de, wBattleHeldItems
.loop
	ld a, c
	cp b
	ld a, 0 ; (no POKéMON there: nothing to give back)
	jr nc, .got_item
	ld a, [hl]
.got_item
	ld [de], a
	inc de
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	inc c
	ld a, c
	cp PARTY_LENGTH
	jr nz, .loop
	ret

RestoreBattleHeldItems:
; After a battle, a POKéMON that went in holding an item and holds nothing now
; gets it back: used up (a berry, an X item) or taken by a foe's THIEF. What it
; took with THIEF itself, it keeps.
	ld hl, wPartyMon1Item
	ld de, wBattleHeldItems
	ld c, PARTY_LENGTH
.loop
	ld a, [hl]
	and a
	jr nz, .next
	ld a, [de]
	ld [hl], a
.next
	inc de
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ret

LimitedHeldItems:
; A team may hold only one of each of these (see CheckHeldItemLimit).
	db X_ATTACK, X_DEFEND, X_SPEED, X_SPECIAL, X_ACCURACY, DIRE_HIT, GUARD_SPEC
	db BERSERK_GENE, FOCUS_BAND, KINGS_ROCK, QUICK_CLAW
	db -1

IsLimitedHeldItem:
; Return carry if item a is one a team may hold only one of (a, bc, hl kept).
	push hl
	push bc
	ld c, a
	ld hl, LimitedHeldItems
.find
	ld a, [hli]
	cp -1
	jr z, .no
	cp c
	jr nz, .find
	ld a, c
	pop bc
	pop hl
	scf
	ret

.no
	ld a, c
	pop bc
	pop hl
	and a
	ret

CheckHeldItemLimit::
; c: a side (0: the player's POKéMON out, 1: the foe). Return its item's address
; in hl, and carry if that item is one a team may hold only one of and a teammate
; before it in the party holds one too: only the first counts. (The player's
; team as it went into the battle, see SaveBattleHeldItems; a wild POKéMON has no
; team.)
	push de
	ld a, c
	and a
	jr nz, .enemy
	ld hl, wBattleMonItem
	ld de, wBattleHeldItems
	ld a, [wCurBattleMon]
	ld b, a
	ld c, 1 ; (a byte for each)
	jr .got_side

.enemy
	ld hl, wEnemyMonItem
	ld a, [wBattleMode]
	dec a
	jr z, .no
	ld de, wOTPartyMon1Item
	ld a, [wCurOTMon]
	ld b, a
	ld c, PARTYMON_STRUCT_LENGTH
.got_side
	ld a, b
	and a
	jr z, .no ; (the first in the party)
	ld a, [hl]
	and a
	jr z, .no
	call IsLimitedHeldItem
	jr nc, .no
	push hl
	ld h, a
.teammate
	ld a, [de]
	cp h
	jr z, .yes
	ld a, e
	add c
	ld e, a
	adc d
	sub e
	ld d, a
	dec b
	jr nz, .teammate
	pop hl
.no
	pop de
	and a
	ret

.yes
	pop hl
	pop de
	scf
	ret

CheckTeamHoldsLimitedItem::
; Return carry if wCurItem is one a team may hold only one of and a POKéMON in
; the party other than wCurPartyMon holds one (see TryGiveItemToPartymon).
	ld a, [wCurItem]
	call IsLimitedHeldItem
	ret nc
	ld c, a
	ld hl, wPartyMon1Item
	ld a, [wPartyCount]
	and a
	ret z
	ld b, a
	ld e, 0
.loop
	ld a, [wCurPartyMon]
	cp e
	jr z, .next
	ld a, [hl]
	cp c
	jr z, .yes
.next
	ld a, l
	add PARTYMON_STRUCT_LENGTH
	ld l, a
	adc h
	sub l
	ld h, a
	inc e
	dec b
	jr nz, .loop
	and a
	ret

.yes
	scf
	ret

UserHeldFlags:
; hl: the user's wPlayerHeldFlags or wEnemyHeldFlags.
	ld hl, wPlayerHeldFlags
	ldh a, [hBattleTurn]
	and a
	ret z
	ld hl, wEnemyHeldFlags
	ret

CheckSpentMove::
; (BattleCommand_DoTurn, first: SLEEP TALK's and METRONOME's move goes no further)
; Return carry if the move the user is using fails: one of its own moves that raise
; its stats, used only as it comes in (see HandleEntryStatMoves), or a recovery move,
; PROTECT or DETECT that it can use once while it's out and has (see OnceOutFlag),
; brought back by ENCORE or SLEEP TALK. Else the once while out move is marked used
; now. (Not a move used by itself: see AutoMove_Run.)
	ld a, [wAutoMove]
	and a
	ret nz
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld b, a
	ldh a, [hBattleTurn]
	ld c, a
	call IsEntryStatMove
	jr nc, .not_boost
	ld hl, wBattleMonMoves
	ld a, c
	and a
	jr z, .got_moves
	ld hl, wEnemyMonMoves
.got_moves
	ld a, b
	ld c, NUM_MOVES
.knows
	cp [hl]
	scf
	ret z
	inc hl
	dec c
	jr nz, .knows
	ldh a, [hBattleTurn]
	ld c, a
.not_boost
	call OnceOutFlag
	ret nc
	ld c, a
	and [hl]
	scf
	ret nz
	ld a, c
	or [hl]
	ld [hl], a
	call IsRecoveryMove
	ret nc ; (PROTECT, DETECT)
	set FIELD2_RECOVERED_F, [hl] ; (the next one when it falls under half again)
	and a
	ret

MarkFirstAttack::
; (BattleCommand_DoTurn) For KING'S ROCK: whether the move the user is using is
; the first attack it's used since it came in.
	call UserHeldFlags
	res HELDFLAG_KINGS_ROCK_F, [hl]
	bit HELDFLAG_ATTACKED_F, [hl]
	ret nz
	ld a, BATTLE_VARS_MOVE_POWER
	call GetBattleVar
	and a
	ret z
	set HELDFLAG_ATTACKED_F, [hl]
	set HELDFLAG_KINGS_ROCK_F, [hl]
	ret

HeldKingsRock::
; (BattleCommand_ApplyDamage) KING'S ROCK: the first attack its holder uses
; since it came in makes the foe flinch, if it hits before the foe has moved.
	call UserHeldFlags
	bit HELDFLAG_KINGS_ROCK_F, [hl]
	ret z
	res HELDFLAG_KINGS_ROCK_F, [hl]
	ld a, [wAttackMissed]
	and a
	ret nz
	farcall GetUserItem
	ld a, b
	cp HELD_FLINCH
	ret nz
	farcall CheckSubstituteOpp
	ret nz
	farcall CheckOpponentWentFirst
	ret nz
	farcall EndRechargeOpp
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVarAddr
	set SUBSTATUS_FLINCHED, [hl]
	ret

ResetEntryHeldFlags::
; A POKéMON coming in by BATON PASS (the user's side): no moves or attacks since,
; for its QUICK CLAW and KING'S ROCK, its entry moves to come, its COUNTER and
; MIRROR COAT, its recovery move, and SPITE for both (see HandleAutoSpite).
	call UserHeldFlags
	ld a, [hl]
	and HELDFLAGS_ON_ENTRY
	ld [hl], a
	ld hl, wPlayerTurnsTaken
	ld de, wPlayerFieldFlags
	ldh a, [hBattleTurn]
	and a
	jr z, .got_turns
	ld hl, wEnemyTurnsTaken
	ld de, wEnemyFieldFlags
.got_turns
	xor a
	ld [hl], a
	ld [de], a
	inc de
	inc de
	assert wPlayerFieldFlags2 == wPlayerFieldFlags + 2 && wEnemyFieldFlags2 == wEnemyFieldFlags + 2
	ld [de], a ; (and its recovery move: see HandleAutoRecovery)
	ld [wPlayerSpited], a
	ld [wEnemySpited], a
	ret

HandleEntryTransform::
; TRANSFORM, as the latest games' IMPOSTER: a POKéMON that knows it turns into the
; foe as it comes in, before it does anything (each turn, see BattleTurn: one
; that hasn't moved since it came in). Not when it's already transformed, or the
; foe is, or is out of sight (FLY, DIG). Its entry moves come first.
; (A new turn: no one has had theirs yet, see MovedLastPower.)
	xor a
	ld [wTurnActed], a
	call HandleEntryStatMoves
	call HandleEntryMoves
	call HandleAutoRecovery ; (one that came in under half its HP)
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse
	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	xor a
	ldh [hBattleTurn], a
	ld a, [wPlayerTurnsTaken]
	ld hl, wBattleMonMoves
	jr .go

.enemy
	ld a, 1
	ldh [hBattleTurn], a
	ld a, [wEnemyTurnsTaken]
	ld hl, wEnemyMonMoves
.go
	and a
	ret nz
	ld b, NUM_MOVES
.find
	ld a, [hli]
	cpmove TRANSFORM
	jr z, .knows
	dec b
	jr nz, .find
	ret

.knows
	ld a, BATTLE_VARS_SUBSTATUS5
	call GetBattleVar
	bit SUBSTATUS_TRANSFORMED, a
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS5_OPP
	call GetBattleVar
	bit SUBSTATUS_TRANSFORMED, a
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret nz
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	ret z
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	ret z
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVarAddr
	ld a, [hl]
	push hl
	push af
	ldmove TRANSFORM
	ld [hl], a
	farcall BattleCommand_Transform
	pop af
	pop hl
	ld [hl], a
	ret

HandleEntryStatMoves:
; The status moves that raise the user's own stats (SWORDS DANCE, GROWTH, AMNESIA...,
; and FOCUS ENERGY) or lower the foe's (GROWL, LEER, SAND-ATTACK...), MIST and HAZE
; work as a POKéMON comes in, before its other entry moves (so a PSYCH UP takes them
; up): at the start of its first turn out, it uses each of them it knows with PP
; left (1 PP each, in the order it knows them), each once a battle
; (wPlayerStatMovesUsed: each POKéMON's, by move slot). Both sides' MIST first (to
; keep the other side's off), then the rest, then HAZE (only when a stat has been
; raised or lowered, on either side: it resets them all). BELLY DRUM only over half
; its HP (it would fail). They can't be chosen (see CantChooseMove;
; IsEntryStatMove).
	xor a ; (MIST)
	call .Phase
	ld a, 1 ; (the rest)
	call .Phase
	ld a, 2 ; (HAZE)
.Phase:
	ld [wEntryStatPhase], a
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse
	xor a
	call .Side
	ld a, 1
	jr .Side

.reverse
	ld a, 1
	call .Side
	xor a
	; fallthrough

.Side:
	ldh [hBattleTurn], a
	ld hl, wPlayerFieldFlags
	and a
	jr z, .got_flags
	ld hl, wEnemyFieldFlags
.got_flags
	bit FIELD_ENTRY_DONE_F, [hl]
	ret nz
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	ret z
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	ret z
	ld c, 0 ; (its first move)
.slot
	push bc
	call .Try
	pop bc
	inc c
	ld a, c
	cp NUM_MOVES
	jr nz, .slot
	ret

.Try:
; its move in slot c, if it's one of them, with PP left, not used this battle
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonMoves
	jr z, .got_moves
	ld hl, wEnemyMonMoves
.got_moves
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	ret z
	ld b, a
	ld de, wBattleMonPP - wBattleMonMoves
	assert wEnemyMonPP - wEnemyMonMoves == wBattleMonPP - wBattleMonMoves
	add hl, de
	ld a, [hl]
	and PP_MASK
	ret z
	push bc
	ldh a, [hBattleTurn]
	ld c, a
	call IsEntryStatMove
	pop bc
	ret nc
	call .UsedFlag
	ld e, a
	and [hl]
	ret nz
	push hl
	push de
	push bc
	call .WouldWork
	pop bc
	pop de
	pop hl
	ret nc
	ld a, e
	or [hl]
	ld [hl], a
	farcall AutoMove_Setup
	ret c
	ld de, 0 ; (its own effect script)
	farcall AutoMove_Run
	ret

.UsedFlag:
; hl: the POKéMON's byte in wPlayerStatMovesUsed or wEnemyStatMovesUsed (a wild one's:
; the first); a: the bit for its move slot c
	push bc
	ldh a, [hBattleTurn]
	and a
	ld hl, wPlayerStatMovesUsed
	ld a, [wCurBattleMon]
	jr z, .got_mon
	ld hl, wEnemyStatMovesUsed
	ld a, [wBattleMode]
	dec a
	ld a, 0
	jr z, .got_mon
	ld a, [wCurOTMon]
.got_mon
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	ld a, 1
	inc c
	jr .next_bit

.bit
	add a
.next_bit
	dec c
	jr nz, .bit
	ret

.WouldWork:
; carry if move b is one for this phase (wEntryStatPhase: 0 MIST, 1 the rest,
; 2 HAZE), unless it's BELLY DRUM and the user has half its HP or less, or HAZE and
; no stat has been raised or lowered
	ld l, b
	ld a, MOVE_EFFECT
	call GetMoveAttribute
	ld e, a
	ld c, 0
	cp EFFECT_MIST
	jr z, .got_phase
	ld c, 2
	cp EFFECT_RESET_STATS
	jr z, .got_phase
	ld c, 1
.got_phase
	ld a, [wEntryStatPhase]
	cp c
	jr z, .this_phase
	and a
	ret

.this_phase
	ld a, e
	cp EFFECT_RESET_STATS
	jr z, .haze
	cp EFFECT_BELLY_DRUM
	scf
	ret nz
	ld hl, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wEnemyMonHP
.got_hp
; (HP * 2 > max HP, the max HP after the HP)
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a
	sla e
	rl d
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, c
	sub e
	ld a, b
	sbc d
	ret

.haze
; (a stat level that isn't BASE_STAT_LEVEL, on either side)
	ld hl, wPlayerStatLevels
	call .Changed
	ret c
	ld hl, wEnemyStatLevels
.Changed:
	ld c, NUM_LEVEL_STATS
.level
	ld a, [hli]
	cp BASE_STAT_LEVEL
	scf
	ret nz
	dec c
	jr nz, .level
	and a
	ret

IsEntryStatMove:
; Return carry if move b is a status move that raises the user's own stats or
; lowers the foe's (EntryStatEffects), or CURSE when the user (c: 0, the player's
; POKéMON; 1, the foe's) isn't a GHOST. Keeps bc, de, hl.
	push hl
	push de
	push bc
	ld l, b
	ld a, MOVE_EFFECT
	call GetMoveAttribute
	cp EFFECT_CURSE
	jr z, .curse
	ld hl, EntryStatEffects
	ld de, 1
	call IsInArray
	jr .done

.curse
	ld hl, wBattleMonType1
	dec c
	inc c
	jr z, .got_types
	ld hl, wEnemyMonType1
.got_types
	ld a, [hli]
	cp GHOST
	jr z, .not
	ld a, [hl]
	cp GHOST
	jr z, .not
	scf
	jr .done

.not
	and a
.done
	pop bc
	pop de
	pop hl
	ret

EntryStatEffects:
; the user's: SWORDS DANCE, GROWTH, MEDITATE, SHARPEN, AGILITY, DOUBLE TEAM, MINIMIZE,
; HARDEN, WITHDRAW, DEFENSE CURL, BARRIER, ACID ARMOR, AMNESIA, BELLY DRUM, FOCUS
; ENERGY; the foe's: GROWL, CHARM, TAIL WHIP, LEER, SCREECH, STRING SHOT, COTTON
; SPORE, SCARY FACE, SAND-ATTACK, SMOKESCREEN, KINESIS, FLASH, SWEET SCENT; MIST and
; HAZE (see IsEntryStatMove)
	db EFFECT_ATTACK_UP
	db EFFECT_DEFENSE_UP
	db EFFECT_SPEED_UP
	db EFFECT_SP_ATK_UP
	db EFFECT_SP_DEF_UP
	db EFFECT_ACCURACY_UP
	db EFFECT_EVASION_UP
	db EFFECT_ATTACK_UP_2
	db EFFECT_DEFENSE_UP_2
	db EFFECT_SPEED_UP_2
	db EFFECT_SP_ATK_UP_2
	db EFFECT_SP_DEF_UP_2
	db EFFECT_ACCURACY_UP_2
	db EFFECT_EVASION_UP_2
	db EFFECT_DEFENSE_CURL
	db EFFECT_BELLY_DRUM
	db EFFECT_FOCUS_ENERGY
	db EFFECT_ATTACK_DOWN
	db EFFECT_DEFENSE_DOWN
	db EFFECT_SPEED_DOWN
	db EFFECT_SP_ATK_DOWN
	db EFFECT_SP_DEF_DOWN
	db EFFECT_ACCURACY_DOWN
	db EFFECT_EVASION_DOWN
	db EFFECT_ATTACK_DOWN_2
	db EFFECT_DEFENSE_DOWN_2
	db EFFECT_SPEED_DOWN_2
	db EFFECT_SP_ATK_DOWN_2
	db EFFECT_SP_DEF_DOWN_2
	db EFFECT_ACCURACY_DOWN_2
	db EFFECT_EVASION_DOWN_2
	db EFFECT_MIST
	db EFFECT_RESET_STATS ; HAZE
	db -1

HandleEntryMoves:
; SUNNY DAY, RAIN DANCE, SANDSTORM, HAIL, the terrains, FORESIGHT, FUTURE SIGHT,
; SPIKES, REFLECT, LIGHT SCREEN, SAFEGUARD, PSYCH UP, MEAN LOOK, SPIDER WEB and
; LOCK-ON work as a POKéMON comes in: at the start of its first turn out, it uses
; each of them it knows with PP left (taking their PP), before it does anything
; else. (Each side puts up each screen once a battle: not when one of its POKéMON
; has, see BattleCommand_Screen.)
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse
	call .player
	jr .enemy

.reverse
	call .enemy
	; fallthrough

.player
	xor a
	ldh [hBattleTurn], a
	ld hl, wPlayerFieldFlags
	jr .go

.enemy
	ld a, 1
	ldh [hBattleTurn], a
	ld hl, wEnemyFieldFlags
.go
	bit FIELD_ENTRY_DONE_F, [hl]
	ret nz
	set FIELD_ENTRY_DONE_F, [hl]
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	ret z
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	ret z
	ld hl, EntryMoves
.loop
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	and c
	inc a
	ret z ; (-1: the end)
	push hl
	ld h, b
	ld l, c
	call GetMoveIDFromIndex
	ld b, a
	call .Use
	pop hl
	jr .loop

.Use:
	ld a, b
	cpmove SANDSTORM
	jp z, .sandstorm
	cpmove HAIL
	jp z, .hail
	ld c, TERRAIN_ELECTRIC
	cpmove ELECTRIC_TERRAIN
	jp z, .terrain
	inc c
	cpmove GRASSY_TERRAIN
	jp z, .terrain
	inc c
	cpmove MISTY_TERRAIN
	jp z, .terrain
	inc c
	cpmove PSYCHIC_TERRAIN
	jp z, .terrain
	cpmove SPIKES
	jp z, .spikes
	cpmove MEAN_LOOK
	jp z, .mean_look
	cpmove SPIDER_WEB
	jp z, .mean_look
	cpmove REFLECT
	jr z, .reflect
	cpmove LIGHT_SCREEN
	jr z, .light_screen
	cpmove SAFEGUARD
	jr z, .safeguard
	cpmove PSYCH_UP
	jr z, .psych_up
	cpmove FUTURE_SIGHT
	jr nz, .use
; (not while one is on its way)
	ld hl, wPlayerFutureSightCount
	ldh a, [hBattleTurn]
	and a
	jr z, .future_sight
	ld hl, wEnemyFutureSightCount
.future_sight
	ld a, [hl]
	and a
	ret nz
.use
	farcall AutoMove_Setup
	ret c
	ld de, 0 ; (its own effect script)
	farcall AutoMove_Run
	ret

.reflect
	ld c, 1 << SCREENS_REFLECT
	jr .screen

.light_screen
	ld c, 1 << SCREENS_LIGHT_SCREEN
	jr .screen

.safeguard
	ld c, 1 << SCREENS_SAFEGUARD
.screen
; (not when its side has put it up this battle: it would fail)
	ld hl, wPlayerScreensUsed
	ldh a, [hBattleTurn]
	and a
	jr z, .got_used
	ld hl, wEnemyScreensUsed
.got_used
	ld a, [hl]
	and c
	ret nz
	jr .use

.psych_up
; (only when the foe has a stat that's gone up, to take up)
	ld hl, wEnemyStatLevels
	ldh a, [hBattleTurn]
	and a
	jr z, .got_levels
	ld hl, wPlayerStatLevels
.got_levels
	ld c, NUM_LEVEL_STATS
.raised
	ld a, [hli]
	cp BASE_STAT_LEVEL + 1
	jr nc, .use
	dec c
	jr nz, .raised
	ret

.mean_look
; (not when it has the foe trapped already)
	ld a, BATTLE_VARS_SUBSTATUS5
	call GetBattleVar
	bit SUBSTATUS_CANT_RUN, a
	ret nz
	jr .use

.spikes
; (not when the foe's side has as many layers as there can be)
	ld hl, wEnemySpikes
	ldh a, [hBattleTurn]
	and a
	jr z, .got_spikes
	ld hl, wPlayerSpikes
.got_spikes
	ld a, [hl]
	cp MAX_SPIKES
	ret nc
	jr .use

.sandstorm
; (not when it's up already: it would fail; nor HAIL, nor a terrain, c)
	ld c, WEATHER_SANDSTORM
	jr .weather

.hail
	ld c, WEATHER_HAIL
.weather
	ld a, [wBattleWeather]
	cp c
	ret z
	jr .use

.terrain
	ld a, [wBattleTerrain]
	cp c
	ret z
	jr .use

EntryMoves:
; in the order they're used (LOCK-ON last: the next attack's aim, see
; BattleCommand_CheckHit, is for an attack)
	dw SUNNY_DAY
	dw RAIN_DANCE
	dw SANDSTORM
	dw HAIL
	dw ELECTRIC_TERRAIN
	dw GRASSY_TERRAIN
	dw MISTY_TERRAIN
	dw PSYCHIC_TERRAIN
	dw FORESIGHT
	dw FUTURE_SIGHT
	dw SPIKES
	dw REFLECT
	dw LIGHT_SCREEN
	dw SAFEGUARD
	dw PSYCH_UP
	dw MEAN_LOOK
	dw SPIDER_WEB
	dw LOCK_ON
	dw -1

CountHitTaken::
; The target of the user's attack (not its SUBSTITUTE) takes wCurDamage: for
; HandleAutoCounter (wHitDamage) and RAGE (the times each POKéMON was hit).
	ld a, [wCurDamage]
	ld [wHitDamage], a
	ld b, a
	ld a, [wCurDamage + 1]
	ld [wHitDamage + 1], a
	or b
	ret z
	ldh a, [hBattleTurn]
	xor 1
	call TimesHit
	inc [hl]
	ret nz
	dec [hl] ; (it stops at 255)
	ret

TimesHit:
; hl: how many times the POKéMON out on side a (0: the player's) was hit
	and a
	ld hl, wPlayerTimesHit
	ld a, [wCurBattleMon]
	jr z, .got_side
	ld hl, wEnemyTimesHit
	ld a, [wCurOTMon]
.got_side
	ld c, a
	ld b, 0
	add hl, bc
	ret

DEF BASE_RAGE_POWER EQU 50
DEF MAX_RAGE_POWER EQU 250

GetRagePower::
; BattleCommand_RagePower: d = RAGE's power, as the latest games' RAGE FIST: 50,
; and 50 more for every time the user was hit this battle, up to 250. (bc and e
; are the damage stats: see BattleCommand_DamageStats)
	push bc
	ldh a, [hBattleTurn]
	call TimesHit
	ld a, [hl]
	cp (MAX_RAGE_POWER - BASE_RAGE_POWER) / BASE_RAGE_POWER
	jr c, .got_hits
	ld a, (MAX_RAGE_POWER - BASE_RAGE_POWER) / BASE_RAGE_POWER
.got_hits
	inc a
	ld b, a
	xor a
.loop
	add BASE_RAGE_POWER
	dec b
	jr nz, .loop
	ld d, a
	pop bc
	ret

FalseSwipeAgain::
; BattleCommand_SwipeAgain: FALSE SWIPE missed? It swipes again, and hits for
; double damage. (Not when the foe is protected, out of reach (FLY, DIG) or
; immune.)
	ld a, [wAttackMissed]
	and a
	ret z
	ld a, [wTypeModifier]
	and EFFECTIVENESS_MASK
	jr z, .missed
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_PROTECT, a
	jr nz, .missed
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	jr nz, .missed
	xor a
	ld [wAttackMissed], a
	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	jr nc, .doubled
	ld a, $ff
	ld [hli], a
	ld [hl], a
.doubled
	ld hl, SwipedAgainText
	jp StdBattleTextbox

.missed
; (no damage, as with any miss: BattleCommand_CheckHit kept it)
	xor a
	ld [wCurDamage], a
	ld [wCurDamage + 1], a
	ret

DoPlayerTurnAndCounter::
; The player's move, then the foe's COUNTER, MIRROR COAT or MIRROR MOVE (see
; HandleAutoCounter and HandleAutoMirrorMove).
	call ClearHitDamage
	ld hl, wTurnActed
	set 0, [hl]
	ld a, [wLastPlayerCounterMove]
	push af
	ld a, NOT_ACTED
	ld [wLastPlayerCounterMove], a
	farcall DoPlayerTurn
	pop bc
	ld hl, wLastPlayerCounterMove
	jr AfterTurn

DoEnemyTurnAndCounter::
; The foe's move, then the player's COUNTER, MIRROR COAT or MIRROR MOVE.
	call ClearHitDamage
	ld hl, wTurnActed
	set 1, [hl]
	ld a, [wLastEnemyCounterMove]
	push af
	ld a, NOT_ACTED
	ld [wLastEnemyCounterMove], a
	farcall DoEnemyTurn
	pop bc
	ld hl, wLastEnemyCounterMove
	; fallthrough

AfterTurn:
; hl: the last move of the side whose turn it was (still NOT_ACTED if it didn't
; use one: then it's back to b, as before)
	ld a, [hl]
	cp NOT_ACTED
	jr nz, .acted
	ld [hl], b
	call HandleAutoCounter
	call HandleAutoNightmare
	jr .recovery

.acted
	call HandleAutoCounter
	call HandleAutoDisable
	call HandleAutoMirrorMove
	call HandleAutoSpite
	call HandleAutoNightmare
.recovery
	call HandleAutoRecovery
	; fallthrough

HandleAutoEndOfTurn:
; SNORE and SPLASH work by themselves, at the end of each of its turns: a POKéMON
; that knows SNORE (with PP left) uses it while it's asleep; one that knows SPLASH
; uses it while it's awake (not frozen, nor out of sight: FLY, DIG).
	call CantGoOn
	ret nz
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	ldbmove SNORE
	and SLP_MASK
	jr nz, .use
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	bit FRZ, a
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret nz
	ldbmove SPLASH
.use
	farcall AutoMove_Setup
	ret c
	ld de, 0 ; (its own effect script)
	farcall AutoMove_Run
	ret

CantGoOn:
; Return nz if either POKéMON has fainted, or the battle is over (one fled: see
; BattleCommand_Teleport), so no move works by itself now.
	ld a, [wForcedSwitch]
	ld hl, wBattleEnded
	or [hl]
	ret nz
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	jr z, .fainted
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	jr z, .fainted
	xor a
	ret

.fainted
	inc a
	ret

HandleAutoSpite:
; SPITE works by itself: right after the foe used a move, a POKéMON that knows
; SPITE (with PP left) takes 4 PP from it, once for each of the foe's moves while
; both are out. Not if it's asleep or frozen, or the move has no PP left.
	call CantGoOn
	ret nz
; (as the other side)
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	call .Spite
	pop af
	ldh [hBattleTurn], a
	ret

.Spite:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP_MASK | 1 << FRZ
	ret nz
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	call GetBattleVar
	and a
	ret z
	cpmove STRUGGLE
	ret z
	ld b, a
; its slot in the foe's moves (c), with PP left
	ld hl, wEnemyMonMoves
	ldh a, [hBattleTurn]
	and a
	jr z, .got_moves
	ld hl, wBattleMonMoves
.got_moves
	ld c, 0
.find
	ld a, [hli]
	cp b
	jr z, .found
	inc c
	ld a, c
	cp NUM_MOVES
	jr c, .find
	ret

.found
	dec hl
	ld de, wBattleMonPP - wBattleMonMoves
	add hl, de
	ld a, [hl]
	and PP_MASK
	ret z
	ld a, 1
	inc c
.bit
	dec c
	jr z, .got_bit
	add a
	jr .bit
.got_bit
	ld e, a
	ld hl, wPlayerSpited
	ldh a, [hBattleTurn]
	and a
	jr z, .got_spited
	ld hl, wEnemySpited
.got_spited
	ld a, [hl]
	and e
	ret nz ; (that move's had it, since they're out)
	push de
	push hl
	ldbmove SPITE
	farcall AutoMove_Setup
	pop hl
	pop de
	ret c
	ld a, [hl]
	or e
	ld [hl], a
	ld de, 0 ; (its own effect script)
	farcall AutoMove_Run
	ret

HandleAutoNightmare:
; NIGHTMARE works by itself: at the end of each turn, while the foe is asleep (and
; not having one already), a POKéMON that knows NIGHTMARE (with PP left) gives it
; one. Not if it's asleep or frozen itself, or the foe is behind a SUBSTITUTE or
; out of sight (FLY, DIG). The side whose turn it was first.
	ldh a, [hBattleTurn]
	push af
	call .Nightmare
	ldh a, [hBattleTurn]
	xor 1
	ldh [hBattleTurn], a
	call .Nightmare
	pop af
	ldh [hBattleTurn], a
	ret

.Nightmare:
	call CantGoOn
	ret nz
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP_MASK | 1 << FRZ
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and SLP_MASK
	ret z
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_NIGHTMARE, a
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret nz
	ldbmove NIGHTMARE
	farcall AutoMove_Setup
	ret c
	ld de, 0 ; (its own effect script)
	farcall AutoMove_Run
	ret

HandleAutoCounter:
; COUNTER and MIRROR COAT work by themselves: right after an attack hit (the
; POKéMON, not its SUBSTITUTE: wHitDamage), its target hits back for twice the
; damage, if it knows the one for the attack's category (COUNTER for a physical
; one, MIRROR COAT for a special one) with PP left: each one once while the
; POKéMON is out, or every time if it has no attack to choose (CanChooseAnAttack).
; Not if it fainted, is asleep or frozen, or the attacker is immune or fainted.
	ld a, [wHitDamage]
	ld b, a
	ld a, [wHitDamage + 1]
	or b
	ret z
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_COUNTER
	ret z
	cp EFFECT_MIRROR_COAT
	ret z
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and ~TYPE_MASK
	ldbmove COUNTER
	cp PHYSICAL
	jr z, .got_move
	ldbmove MIRROR_COAT
	cp SPECIAL
	ret nz
.got_move
	call CantGoOn
	ret nz
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and SLP_MASK | 1 << FRZ
	ret nz
; (as the one hit)
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	call .Counter
	pop af
	ldh [hBattleTurn], a
	ret

.Counter:
	call AutoMoveFieldFlag
	and [hl]
	jr z, .not_yet
	call CanChooseAnAttack
	ret nz ; (it has, since it came in)
.not_yet
	farcall AutoMove_Setup
	ret c
	farcall BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	and a
	jr z, .immune
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld b, a
	call AutoMoveFieldFlag
	or [hl]
	ld [hl], a
; twice the damage
	ld hl, wHitDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a
	add hl, hl
	jr nc, .got_damage
	ld hl, $ffff
.got_damage
	ld a, h
	ld [wCurDamage], a
	ld a, l
	ld [wCurDamage + 1], a
	ld de, AutoCounter
	farcall AutoMove_Run
	ret

.immune
	farcall AutoMove_Restore
	ret

HandleAutoDisable:
; DISABLE works by itself: right after an attack hit a POKéMON (not its SUBSTITUTE:
; wHitDamage), one that knows DISABLE (with PP left) disables that attack (for four
; turns: see BattleCommand_Disable), once while it's out. Not if either fainted,
; it's asleep or frozen, or the attacker has a move disabled already, or the
; attack isn't one of its own moves (METRONOME's, MIRROR MOVE's) with PP left.
	ld a, [wHitDamage]
	ld b, a
	ld a, [wHitDamage + 1]
	or b
	ret z
	call CantGoOn
	ret nz
; (as the one hit)
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	call .Disable
	pop af
	ldh [hBattleTurn], a
	ret

.Disable:
	ld hl, wPlayerFieldFlags
	ld de, wEnemyDisableCount
	ld bc, wEnemyMonMoves
	ldh a, [hBattleTurn]
	and a
	jr z, .got_sides
	ld hl, wEnemyFieldFlags
	ld de, wPlayerDisableCount
	ld bc, wBattleMonMoves
.got_sides
	bit FIELD_DISABLE_F, [hl]
	ret nz ; (it has, since it came in)
	ld a, [de]
	and a
	ret nz ; (the attacker has one disabled already)
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP_MASK | 1 << FRZ
	ret nz
; the attack: one of the attacker's moves, with PP left
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	call GetBattleVar
	and a
	ret z
	cpmove STRUGGLE
	ret z
	ld d, a
	ld h, b
	ld l, c
	ld e, NUM_MOVES
.find
	ld a, [hli]
	cp d
	jr z, .found
	dec e
	jr nz, .find
	ret

.found
	dec hl
	ld bc, wBattleMonPP - wBattleMonMoves
	add hl, bc
	ld a, [hl]
	and PP_MASK
	ret z
	ldbmove DISABLE
	farcall AutoMove_Setup
	ret c
	ld hl, wPlayerFieldFlags
	ldh a, [hBattleTurn]
	and a
	jr z, .got_flags
	ld hl, wEnemyFieldFlags
.got_flags
	set FIELD_DISABLE_F, [hl]
	ld de, 0 ; (its own effect script)
	farcall AutoMove_Run
	ret

AutoMoveFieldFlag:
; hl: the user's wPlayerFieldFlags or wEnemyFieldFlags; a: the flag for move b
; (COUNTER, MIRROR COAT, MIRROR MOVE or MIMIC: once each while it's out)
	ld hl, wPlayerFieldFlags
	ldh a, [hBattleTurn]
	and a
	jr z, .got_flags
	ld hl, wEnemyFieldFlags
.got_flags
	ld a, b
	cpmove COUNTER
	ld a, 1 << FIELD_COUNTER_F
	ret z
	ld a, b
	cpmove MIRROR_COAT
	ld a, 1 << FIELD_MIRROR_COAT_F
	ret z
	ld a, b
	cpmove MIMIC
	ld a, 1 << FIELD_MIMIC_F
	ret z
	ld a, 1 << FIELD_MIRROR_MOVE_F
	ret

HandleAutoMirrorMove:
; MIRROR MOVE works by itself: right after the foe used a move, a POKéMON that
; knows MIRROR MOVE (with PP left) uses that move too, once while it's out, or
; every time if it has no attack to choose (CanChooseAnAttack). MIMIC works the
; same way (with MIRROR MOVE's script), when MIRROR MOVE doesn't. Not if either
; fainted, it's asleep, frozen or busy (charging, recharging, locked into a move),
; or the move is one it can't take up (MirrorMoveCant).
	call CantGoOn
	ret nz
; (as the other side)
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	call .Mirror
	pop af
	ldh [hBattleTurn], a
	ret

.Mirror:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP_MASK | 1 << FRZ
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and 1 << SUBSTATUS_BIDE | 1 << SUBSTATUS_RAMPAGE | 1 << SUBSTATUS_CHARGED | 1 << SUBSTATUS_UNDERGROUND | 1 << SUBSTATUS_FLYING
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVar
	bit SUBSTATUS_ROLLOUT, a
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_RECHARGE, a
	ret nz
; the foe's move
	ld a, BATTLE_VARS_LAST_COUNTER_MOVE_OPP
	call GetBattleVar
	and a
	ret z
	cpmove STRUGGLE
	ret z
	ld l, a
	ld a, MOVE_EFFECT
	call GetMoveAttribute
	ld hl, MirrorMoveCant
	ld de, 1
	call IsInArray
	ret c
; then, MIRROR MOVE, or else MIMIC
	ldbmove MIRROR_MOVE
	call .Usable
	jr nc, .use
	ldbmove MIMIC
	call .Usable
	ret c
.use
	push bc
	farcall AutoMove_Setup
	pop bc
	ret c
	call AutoMoveFieldFlag
	or [hl]
	ld [hl], a
; (the move it takes up runs as if charged, so no PP of its own: see ResetTurn;
; as it was after)
	ld hl, wPlayerCharging
	ldh a, [hBattleTurn]
	and a
	jr z, .got_charging
	ld hl, wEnemyCharging
.got_charging
	ld a, [hl]
	push af
	push hl
	ld de, MirrorMove ; (MIRROR MOVE's script, MIMIC's too)
	farcall AutoMove_Run
	pop hl
	pop af
	ld [hl], a
	ret

.Usable:
; Return nc if the user can use move b by itself now: it knows it with PP left,
; and hasn't used it since it came in (or has no attack to choose). Keeps b.
	call GuardMoveSlot
	ret c
	call AutoMoveFieldFlag
	and [hl]
	ret z
	call CanChooseAnAttack
	scf
	ret nz ; (it has, since it came in)
	and a
	ret

CanChooseAnAttack:
; Return nz if the user knows an attack (not a status move) that it can choose
; (not one that works by itself: see CantChooseMove), with PP left and not
; DISABLEd; z if it has none: then COUNTER, MIRROR COAT, MIRROR MOVE and MIMIC
; work every time, not once while it's out. Keeps bc.
	push bc
	ld hl, wBattleMonMoves
	ld a, [wDisabledMove]
	ld e, a
	ldh a, [hBattleTurn]
	ld c, a
	and a
	jr z, .got_moves
	ld hl, wEnemyMonMoves
	ld a, [wEnemyDisabledMove]
	ld e, a
.got_moves
	ld d, NUM_MOVES
.move
	ld a, [hli]
	and a
	jr z, .next
	cp e
	jr z, .next
	ld b, a
	push hl
	push de
	ld de, wBattleMonPP - wBattleMonMoves - 1
	add hl, de
	ld a, [hl]
	and PP_MASK
	jr z, .no
	ld l, b
	ld a, MOVE_TYPE
	call GetMoveAttribute
	and ~TYPE_MASK
	cp STATUS
	jr z, .no
	call CantChooseMove
	jr nz, .found
.no
	pop de
	pop hl
.next
	dec d
	jr nz, .move
	pop bc
	xor a
	ret

.found
	pop de
	pop hl
	pop bc
	or 1
	ret

MirrorMoveCant:
; moves MIRROR MOVE doesn't take up: ones that go on for turns, or work by
; themselves, or call another
	db EFFECT_FLY
	db EFFECT_ROLLOUT
	db EFFECT_RAMPAGE
	db EFFECT_BIDE
	db EFFECT_COUNTER
	db EFFECT_MIRROR_COAT
	db EFFECT_MIRROR_MOVE
	db EFFECT_MIMIC
	db EFFECT_FUTURE_SIGHT
	db EFFECT_METRONOME
	db EFFECT_SLEEP_TALK
	db -1

ClearHitDamage:
	xor a
	ld [wHitDamage], a
	ld [wHitDamage + 1], a
	ret

AutoPursuit::
; A POKéMON that knows PURSUIT (with PP left) hits a foe switching out with it, by
; itself (with PURSUIT's double damage), unless it's asleep or frozen. Return carry
; if it did. One that had chosen PURSUIT has used it then.
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP_MASK | 1 << FRZ
	ret nz ; (no carry)
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	push af
	ldbmove PURSUIT
	farcall AutoMove_Setup
	jr c, .none
	ld de, 0 ; (its own effect script)
	farcall AutoMove_Run
	pop af
	cpmove PURSUIT
	jr nz, .done
	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld [hl], CANNOT_MOVE
.done
	scf
	ret

.none
	pop af
	and a
	ret

PartyKnowsPayDay::
; Return carry if a POKéMON in the party (not an EGG) knows PAY DAY: then the
; battle's money is doubled (see WinTrainerBattle and CheckPayDay).
	ld hl, wPartyMon1Moves
	ld de, wPartySpecies
.mon
	ld a, [de]
	cp -1
	jr z, .none
	inc de
	cp EGG
	jr z, .next
	push hl
	ld b, NUM_MOVES
.move
	ld a, [hli]
	cpmove PAY_DAY
	jr z, .found
	dec b
	jr nz, .move
	pop hl
.next
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	jr .mon

.found
	pop hl
	scf
	ret

.none
	and a
	ret

SpikesFraction::
; bc: max HP (of the POKéMON coming in on the hBattleTurn side) -> what SPIKES do
; to it: 1/8 of it with one layer, 1/6 with two, 1/4 with three (at least 1)
	ld hl, wPlayerSpikes
	ldh a, [hBattleTurn]
	and a
	jr z, .got_layers
	ld hl, wEnemySpikes
.got_layers
	ld a, [hl]
	cp 3
	ld a, 4
	jr nc, .divide
	ld a, [hl]
	cp 2
	ld a, 6
	jr z, .divide
	ld a, 8
.divide
	ldh [hDivisor], a
	xor a
	ldh [hDividend + 0], a
	ldh [hDividend + 1], a
	ld a, b
	ldh [hDividend + 2], a
	ld a, c
	ldh [hDividend + 3], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	ld c, a
	or b
	ret nz
	inc c
	ret

MovedLastPower::
; FLAIL and REVERSAL: twice the power d when the user moves after the foe this
; turn (it's had its turn, or switched out: wTurnActed, wPlayerIsSwitching,
; wEnemyIsSwitching)
	push bc
	ld a, [wTurnActed]
	ld b, a
	ld hl, wEnemyIsSwitching
	ld c, 1 << 1 ; (the foe: the enemy)
	ldh a, [hBattleTurn]
	and a
	jr z, .got_foe
	ld hl, wPlayerIsSwitching
	ld c, 1 << 0
.got_foe
	ld a, b
	and c
	jr nz, .twice
	ld a, [hl]
	and a
	jr z, .done
.twice
	sla d
.done
	pop bc
	ret

CantChooseMove::
; b: a move; c: whose (0: the player's POKéMON, 1: the foe's). Return z if it can't
; be chosen: it works by itself (AutoMoves, and the moves that raise the user's
; stats: see HandleEntryStatMoves), or it can be used once while the POKéMON is out
; and has been (see OnceOutFlag). b and c are kept.
	ld a, b
	ld hl, AutoMoves
	call CheckMoveInList
	jr c, .cant
	call IsEntryStatMove
	jr c, .cant
	call OnceOutFlag
	jr nc, .can
	and [hl]
	jr nz, .cant
.can
	or 1
	ret

.cant
	xor a
	ret

IsOnceOutMove::
; Return carry if move b is one that can be used once while the POKéMON is out.
	ld c, 0
	; fallthrough

OnceOutFlag:
; Return carry if move b can be used once while the POKéMON is out (a recovery
; move, PROTECT or DETECT it knows, each one of its own: see HandleAutoRecovery and
; HandleAutoProtect): then hl is its side's field flags (c: 0, the player's; 1, the
; foe's) and a the flag for it. Keeps bc and de.
	call IsOnceOutEffect
	ret nc
	push de
	ld de, wBattleMonMoves
	ld hl, wPlayerFieldFlags2
	dec c
	inc c
	jr z, .got_moves
	ld de, wEnemyMonMoves
	ld hl, wEnemyFieldFlags2
.got_moves
	ld a, 1 << FIELD2_RECOVERY_F
.slot
	push af
	ld a, [de]
	inc de
	cp b
	jr z, .found_slot
	pop af
	add a
	cp 1 << (FIELD2_RECOVERY_F + NUM_MOVES)
	jr nz, .slot
	pop de
	and a ; (nc: one it doesn't know, as METRONOME's)
	ret

.found_slot
	pop af
	pop de
	scf
	ret

IsRecoveryMove:
; Return carry if move b is a recovery move (RecoveryEffects). Keeps bc, de, hl.
	push hl
	ld hl, RecoveryEffects
	jr IsMoveEffectIn

IsOnceOutEffect:
; Return carry if move b is one used once while the POKéMON is out: a recovery
; move, PROTECT or DETECT (OnceOutEffects). Keeps bc, de, hl.
	push hl
	ld hl, OnceOutEffects
	; fallthrough

IsMoveEffectIn:
; (hl, pushed: a list of effects) Return carry if move b's effect is in hl's list.
	push de
	push bc
	push hl
	ld l, b
	ld a, MOVE_EFFECT
	call GetMoveAttribute
	pop hl
	ld de, 1
	call IsInArray
	pop bc
	pop de
	pop hl
	ret

OnceOutEffects:
; PROTECT and DETECT (see HandleAutoProtect), then the recovery moves
	db EFFECT_PROTECT
RecoveryEffects:
; RECOVER, SOFTBOILED, MILK DRINK and REST; MORNING SUN; SYNTHESIS; MOONLIGHT
	db EFFECT_HEAL
	db EFFECT_MORNING_SUN
	db EFFECT_SYNTHESIS
	db EFFECT_MOONLIGHT
	db -1

HandleAutoRecovery:
; Recovery moves work by themselves too: once a POKéMON is under half its HP
; (whatever brought it there: an attack, recoil, poison, the weather...), if it
; knows one with PP left that it hasn't used since it came in (each one works once
; while it's out: see OnceOutFlag), it uses it (1 PP), unless it's asleep or
; frozen, or either POKéMON has fainted, or it chose one this turn and is still to
; move. One at a time: after one has healed it, the next waits until it's been
; back at half its HP or more and falls under half again (FIELD2_RECOVERED_F).
; REST last, and not when it would fail. The player's POKéMON first (the foe's,
; linked as the other side).
	ldh a, [hBattleTurn]
	push af
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .reverse
	xor a
	call .Side
	ld a, 1
	call .Side
	jr .done

.reverse
	ld a, 1
	call .Side
	xor a
	call .Side
.done
	pop af
	ldh [hBattleTurn], a
	ret

.Side:
	ldh [hBattleTurn], a
	call CantGoOn
	ret nz
	ld de, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld de, wEnemyMonHP
.got_hp
; under half its HP: HP * 2 < max HP
	ld a, [de]
	ld h, a
	inc de
	ld a, [de]
	ld l, a
	add hl, hl
	inc de ; (the max HP, after the HP)
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	ld c, a
	ld a, l
	sub c
	ld a, h
	sbc b
	jr c, .under_half
; (at half its HP or more: the next time it falls under half, it can heal again)
	call .Flags
	res FIELD2_RECOVERED_F, [hl]
	ret

.under_half
	call .Flags
	bit FIELD2_RECOVERED_F, [hl]
	ret nz
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP_MASK | 1 << FRZ
	ret nz
	call .ChoseOne
	ret z
	call .FindMove
	ret c
	ldh a, [hBattleTurn]
	ld c, a
	call OnceOutFlag ; (b: the move)
	or [hl]
	set FIELD2_RECOVERED_F, a
	ld [hl], a
	farcall AutoMove_Setup
	ret c
	ld de, 0 ; (its own effect script)
	farcall AutoMove_Run
	ret

.Flags:
; hl: its wPlayerFieldFlags2 or wEnemyFieldFlags2
	ld hl, wPlayerFieldFlags2
	ldh a, [hBattleTurn]
	and a
	ret z
	ld hl, wEnemyFieldFlags2
	ret

.ChoseOne:
; Return z if it chose a recovery move this turn and is still to use it: the foe
; has had its turn, it hasn't, and it isn't switching.
	ld a, [wTurnActed]
	and %11
	ld c, a
	ld b, %10 ; (the player's side: the foe has had its turn, it hasn't)
	ld hl, wCurPlayerMove
	ld de, wPlayerIsSwitching
	ldh a, [hBattleTurn]
	and a
	jr z, .got_choice
	ld b, %01
	ld hl, wCurEnemyMove
	ld de, wEnemyIsSwitching
.got_choice
	ld a, [de]
	and a
	jr nz, .no
	ld a, c
	cp b
	jr nz, .no
	ld b, [hl]
	call IsRecoveryMove
	jr nc, .no
	xor a
	ret

.no
	or 1
	ret

.FindMove:
; b: the first recovery move it knows with PP left that it hasn't used since it
; came in, not REST (REST if it's the only one, and won't fail); carry if none
	call .Flags
	ld d, [hl] ; (bit 0: its first move used)
	ld hl, wBattleMonMoves
	ldh a, [hBattleTurn]
	and a
	jr z, .got_moves
	ld hl, wEnemyMonMoves
.got_moves
	ld c, NUM_MOVES
	ld e, 0 ; (REST, if it can use it)
.move
	ld a, [hli]
	and a
	jr z, .next
	bit FIELD2_RECOVERY_F, d
	jr nz, .next
	ld b, a
	push hl
	push de
	ld de, wBattleMonPP - wBattleMonMoves - 1
	add hl, de
	ld a, [hl]
	pop de
	pop hl
	and PP_MASK
	jr z, .next
	call IsRecoveryMove
	jr nc, .next
	ld a, b
	cpmove REST
	jr z, .rest_known
	and a ; (nc: this one)
	ret

.rest_known
	ld e, b
.next
	srl d
	dec c
	jr nz, .move
	ld a, e
	and a
	scf
	ret z
	ld b, a
; (as RestFailsForTerrain, without its text: ELECTRIC or MISTY TERRAIN keeps it
; awake on the ground)
	ld a, [wBattleTerrain]
	cp TERRAIN_MISTY
	jr z, .terrain
	cp TERRAIN_ELECTRIC
	jr nz, .rest
.terrain
	push bc
	call IsUserGrounded
	pop bc
	scf
	ret z
.rest
	and a
	ret

AutoMoves:
; moves that work by themselves, so they can't be chosen (for the player, the foe
; and auto battle: see CantChooseMove)
	dw COUNTER      ; right after an attack: see HandleAutoCounter
	dw MIRROR_COAT
	dw DISABLE      ; (see HandleAutoDisable)
	dw MIRROR_MOVE  ; right after the foe's move: see HandleAutoMirrorMove
	dw MIMIC
	dw SPITE        ; (see HandleAutoSpite)
	dw FUTURE_SIGHT ; as it comes in: see HandleEntryMoves
	dw REFLECT
	dw LIGHT_SCREEN
	dw SAFEGUARD
	dw MEAN_LOOK
	dw SPIDER_WEB
	dw SNORE        ; at the end of its turn: see HandleAutoEndOfTurn
	dw SPLASH
	dw NIGHTMARE    ; when the foe is asleep: see HandleAutoNightmare
	dw CONVERSION   ; just before an attack's damage: see HandleAutoConversion
	dw CONVERSION2
	dw ENDURE       ; when an attack would make it faint: see HandleAutoEndure
	dw -1

HandleAutoProtect::
; (BattleCommand_CheckHit, as an attack is to hit; BattleCommand_AutoGuard) PROTECT
; and DETECT work by themselves: right before an attack (not a status move) hits a
; POKéMON (not its SUBSTITUTE), if it knows one with PP left that it hasn't used
; since it came in (each one works once while it's out: see OnceOutFlag), it uses
; it (1 PP) and the attack misses, unless it's asleep or frozen. (One chosen goes
; before any attack: see MovePriorities.) Return carry if it did: it's protected,
; for that move only (see EndAutoGuard).
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and ~TYPE_MASK
	cp STATUS
	jr z, .no
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	jr nz, .no
; (as the one attacked)
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	call .Protect
	pop bc
	ld a, b
	ldh [hBattleTurn], a
	ret nc
	call RestoreMoveName
	scf
	ret

.no
	and a
	ret

.Protect:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP_MASK | 1 << FRZ
	ret nz
; the first it knows
	ld hl, wBattleMonMoves
	ldh a, [hBattleTurn]
	and a
	jr z, .got_moves
	ld hl, wEnemyMonMoves
.got_moves
	ld e, NUM_MOVES
.find
	ld a, [hli]
	ld b, a
	push hl
	push de
	call .Usable
	pop de
	pop hl
	jr nc, .use
	dec e
	jr nz, .find
	and a
	ret

.use
; b: the move, c: its slot
	push bc
	ldh a, [hBattleTurn]
	ld c, a
	call OnceOutFlag
	or [hl]
	ld [hl], a
	pop bc
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	set SUBSTATUS_PROTECT, [hl]
	call UseAutoGuard
	scf
	ret

.Usable:
; Return nc, with c its slot, if move b is a PROTECT or DETECT the user knows with
; PP left, and hasn't used since it came in.
	ld a, b
	and a
	jr z, .cant
	ld l, b
	ld a, MOVE_EFFECT
	call GetMoveAttribute
	cp EFFECT_PROTECT
	jr nz, .cant
	ldh a, [hBattleTurn]
	ld c, a
	call OnceOutFlag
	jr nc, .cant ; (not its own: METRONOME's)
	and [hl]
	jr z, GuardMoveSlot
.cant
	scf
	ret

HandleAutoEndure::
; (BattleCommand_ApplyDamage) ENDURE works by itself: when an attack is to make a
; POKéMON faint (not its SUBSTITUTE), if it knows ENDURE with PP left, it uses it (1
; PP) and is left with 1 HP; once while it's out (FIELD_ENDURE_F), unless it's
; asleep or frozen. It lasts for that move only (see EndAutoGuard).
	ld a, [wAttackMissed]
	and a
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_ENDURE, a
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS4_OPP
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	ret nz
; would it faint? (the damage is at least its HP)
	ld hl, wEnemyMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wBattleMonHP
.got_hp
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, [wCurDamage + 1]
	sub c
	ld a, [wCurDamage]
	sbc b
	ret c
; (as the one attacked)
	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	call .Endure
	pop bc
	ld a, b
	ldh [hBattleTurn], a
	ret nc
	jp RestoreMoveName

.Endure:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and SLP_MASK | 1 << FRZ
	ret nz
	call UserFieldFlags
	bit FIELD_ENDURE_F, [hl]
	ret nz
	ldbmove ENDURE
	call GuardMoveSlot
	ccf
	ret nc
	call UserFieldFlags
	set FIELD_ENDURE_F, [hl]
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	set SUBSTATUS_ENDURE, [hl]
	call UseAutoGuard
	scf
	ret

GuardMoveSlot:
; c: the slot of the user's move b, if it has PP left (else carry). Keeps b.
	ld hl, wBattleMonMoves
	ldh a, [hBattleTurn]
	and a
	jr z, .got_moves
	ld hl, wEnemyMonMoves
.got_moves
	ld c, 0
.find
	ld a, [hli]
	cp b
	jr z, .found
	inc c
	ld a, c
	cp NUM_MOVES
	jr c, .find
	scf
	ret

.found
	push bc
	ld bc, wBattleMonPP - wBattleMonMoves - 1
	add hl, bc
	pop bc
	ld a, [hl]
	and PP_MASK
	ret nz
	scf
	ret

UseAutoGuard:
; The user uses PROTECT, DETECT or ENDURE (b, its move in slot c) by itself, for
; the move under way only (see EndAutoGuard): its PP, "<USER> used PROTECT!", and
; its animation.
	call SpendPP
	call UserFieldFlags
	set FIELD_AUTO_GUARD_F, [hl]
	ld a, b
	ld [wNamedObjectIndex], a
	push bc
	call GetMoveName
	call CopyName1
	ld hl, AutoGuardText
	call StdBattleTextbox
	pop bc
	ld a, b
	call GetMoveIndexFromID
	ld a, l
	ld [wFXAnimID], a
	ld a, h
	ld [wFXAnimID + 1], a
	xor a
	ld [wBattleAfterAnim], a
	ld a, [wBattleAnimParam]
	push af
	xor a
	ld [wBattleAnimParam], a
	farcall PlayBattleAnim
	pop af
	ld [wBattleAnimParam], a
	ret

EndAutoGuard::
; (DoMoveScript, as each move ends) A PROTECT, DETECT or ENDURE used by itself (see
; UseAutoGuard) was for that move only.
	ld hl, wPlayerFieldFlags
	ld de, wPlayerSubStatus1
	call .Side
	ld hl, wEnemyFieldFlags
	ld de, wEnemySubStatus1
.Side:
	bit FIELD_AUTO_GUARD_F, [hl]
	ret z
	res FIELD_AUTO_GUARD_F, [hl]
	ld a, [de]
	and ~(1 << SUBSTATUS_PROTECT | 1 << SUBSTATUS_ENDURE)
	ld [de], a
	ret

UserFieldFlags:
; hl: the user's wPlayerFieldFlags or wEnemyFieldFlags
	ld hl, wPlayerFieldFlags
	ldh a, [hBattleTurn]
	and a
	ret z
	ld hl, wEnemyFieldFlags
	ret

RestoreMoveName:
; (after another move's) the name of the move under way, as it was
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld [wNamedObjectIndex], a
	call GetMoveName
	jp CopyName1

HandleAutoConversion::
; (the stab and resettypematchup commands) CONVERSION and CONVERSION 2 work by
; themselves: just before an attack's damage, its target, if it knows one with PP
; left (taking 1), becomes a type picked at random that's better against it than
; what it is: with CONVERSION 2, one the attack doesn't affect, if there is one;
; else (and with CONVERSION) one that resists it. With both, CONVERSION 2 goes when
; there's a type the attack doesn't affect, else CONVERSION first. Not against
; STRUGGLE, or when the target is out of sight (FLY, DIG) or protected. The type
; lasts until it's switched out.
	ld a, [wAttackMissed]
	and a
	ret nz
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cpmove STRUGGLE
	ret z
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	ld b, a
	and ~TYPE_MASK
	cp STATUS
	ret z
	ld a, b
	and TYPE_MASK
	cp CURSE_TYPE
	ret z
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND
	ret nz
	ld a, BATTLE_VARS_SUBSTATUS1_OPP
	call GetBattleVar
	bit SUBSTATUS_PROTECT, a
	ret nz
	ld hl, wEnemyMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wBattleMonHP
.got_hp
	ld a, [hli]
	or [hl]
	ret z
; (does it know either?)
	ldbmove CONVERSION2
	call .Knows
	jr nc, .knows_one
	ldbmove CONVERSION
	call .Knows
	ret c
.knows_one
; the attack against its types as they are
	call .Types
	ld a, [hli]
	ld d, a
	ld e, [hl]
	push de
	farcall BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	ld [wConversionMatchup], a
; CONVERSION 2, to a type the attack doesn't affect
	ld d, 0
	call .Count
	and a
	jr z, .resist
	ld e, a
	ld a, [wConversionMatchup]
	and a
	jr z, .done ; (it doesn't already)
	ldbmove CONVERSION2
	call .Knows
	jr nc, .convert
.resist
; else, to one that resists it
	ld a, [wConversionMatchup]
	cp EFFECTIVE / 2 + 1
	jr c, .done ; (it resists it already)
	ld d, 1
	call .Count
	and a
	jr z, .done
	ld e, a
	ldbmove CONVERSION
	call .Knows
	jr nc, .convert
	ldbmove CONVERSION2
	call .Knows
	jr nc, .convert
.done
; (its types as they were)
	pop de
	call .Types
	ld a, d
	ld [hli], a
	ld [hl], e
	ret

.convert
; b: the move; c: its slot; d: which types; e: how many
	pop hl ; (its types as they were: they're gone)
	push bc
	ld c, e
.random
	call BattleRandom
	and %11111
	cp c
	jr nc, .random
	ld e, a
	call .Nth
	pop bc
	push af
	call .Types
	pop af
	ld [hli], a
	ld [hl], a
	push af
; as the one that knows it
	ldh a, [hBattleTurn]
	xor 1
	ldh [hBattleTurn], a
	call SpendPP
	ld a, b
	ld [wNamedObjectIndex], a
	call GetMoveName
	call CopyName1
	pop af
	ld [wNamedObjectIndex], a
	farcall GetTypeName
	ld hl, ConversionAutoText
	call StdBattleTextbox
	ldh a, [hBattleTurn]
	xor 1
	ldh [hBattleTurn], a
; (the attack's name, as it was)
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld [wNamedObjectIndex], a
	call GetMoveName
	jp CopyName1

.Types:
; hl: the target's types
	ld hl, wEnemyMonType1
	ldh a, [hBattleTurn]
	and a
	ret z
	ld hl, wBattleMonType1
	ret

.Knows:
; Return carry if the target doesn't know move b with PP left; else its slot in c.
	push de
	ld hl, wEnemyMonMoves
	ld de, wEnemyMonPP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_moves
	ld hl, wBattleMonMoves
	ld de, wBattleMonPP
.got_moves
	ld c, 0
.find
	ld a, [hli]
	cp b
	jr nz, .next
	ld a, [de]
	and PP_MASK
	jr nz, .known
.next
	inc de
	inc c
	ld a, c
	cp NUM_MOVES
	jr c, .find
	pop de
	scf
	ret

.known
	pop de
	and a
	ret

.Count:
; a: how many types the attack doesn't affect (d = 0), or resists (d = 1)
	ld e, -1
	call .Nth
	ld a, e
	cpl ; (-1 - e: how many it went by)
	ret

.Nth:
; a: type number e of those (d), from 0; or, with e = -1, e is -1 - how many
; there are
	push bc
	ld c, -1
.next_type
	inc c
	ld a, c
	cp TYPES_END
	jr nc, .end
	cp BIRD
	jr z, .next_type
	cp UNUSED_TYPES
	jr c, .try
	cp UNUSED_TYPES_END
	jr c, .next_type
.try
	call .Types
	ld a, c
	ld [hli], a
	ld [hl], a
	farcall BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	and a
	jr z, .immune
	cp EFFECTIVE
	jr nc, .next_type
	ld a, d
	and a
	jr z, .next_type
	jr .counts

.immune
	ld a, d
	and a
	jr nz, .next_type
.counts
	ld a, e
	and a
	jr z, .found
	dec e
	jr .next_type

.found
	ld a, c
.end
	pop bc
	ret

SpendPP:
; The user (hBattleTurn) uses 1 PP of its move in slot c: in battle, and in its
; party data (not when it's transformed, or the move isn't its own: MIMIC). bc is
; kept.
	push bc
	ld b, 0
	ld hl, wBattleMonPP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_pp
	ld hl, wEnemyMonPP
.got_pp
	add hl, bc
	dec [hl]
	ld a, BATTLE_VARS_SUBSTATUS5
	call GetBattleVar
	bit SUBSTATUS_TRANSFORMED, a
	jr nz, .done
; (the move, in battle)
	ld de, wBattleMonMoves - wBattleMonPP
	add hl, de
	ld a, [hl]
	push af
	push bc
	ldh a, [hBattleTurn]
	and a
	ld hl, wPartyMon1Moves
	ld a, [wCurBattleMon]
	jr z, .party
	ld hl, wWildMonMoves
	ld a, [wBattleMode]
	dec a
	jr z, .got_moves
	ld hl, wOTPartyMon1Moves
	ld a, [wCurOTMon]
.party
	call GetPartyLocation
.got_moves
	pop bc
	add hl, bc
	pop af
	cp [hl]
	jr nz, .done ; (not its own)
	ld de, MON_PP - MON_MOVES
	ldh a, [hBattleTurn]
	and a
	jr z, .got_offset
	ld a, [wBattleMode]
	dec a
	jr nz, .got_offset
	ld de, wWildMonPP - wWildMonMoves
.got_offset
	add hl, de
	ld a, [hl]
	and PP_MASK
	jr z, .done
	dec [hl]
.done
	pop bc
	ret

ChooseSketchMove::
; b: the foe's move the user (hBattleTurn) sketches (see BattleCommand_Sketch), or
; 0 if there's none it can (STRUGGLE, SKETCH, or ones it knows): the player
; chooses it, from a menu of the foe's moves; the foe sketches the player's move
; with the most power.
	ld hl, wEnemyMonMoves
	ldh a, [hBattleTurn]
	and a
	jr z, .got_moves
	ld hl, wBattleMonMoves
.got_moves
; the one it can with the most power: e (0: none), its power d
	ld de, 0
	ld c, NUM_MOVES
.best
	ld a, [hli]
	push hl
	push bc
	call .CanSketch
	jr c, .next_best
	ld b, a
	call .Power
	ld c, a
	ld a, e
	and a
	jr z, .take
	ld a, d
	cp c
	jr nc, .next_best
.take
	ld d, c
	ld e, b
.next_best
	pop bc
	pop hl
	dec c
	jr nz, .best
	ld b, e
	ld a, e
	and a
	ret z
	ldh a, [hBattleTurn]
	and a
	ret nz
; the player chooses
	ld hl, SketchWhichMoveText
	call StdBattleTextbox
.menu
	ld a, 1 ; (the foe's moves)
	ld [wMoveSelectionMenuType], a
	farcall MoveSelectionScreen
	xor a
	ld [wMoveSelectionMenuType], a
	ld a, [wMenuCursorY]
	ld c, a
	ld b, 0
	ld hl, wEnemyMonMoves
	add hl, bc
	ld a, [hl]
	call .CanSketch
	jr nc, .chosen
	ld [wNamedObjectIndex], a
	call GetMoveName
	ld hl, CantSketchThatText
	call StdBattleTextbox
	jr .menu

.chosen
	ld b, a
	ret

.CanSketch:
; Return carry if the user can't sketch move a. a is kept.
	and a
	jr z, .cant
	cpmove STRUGGLE
	jr z, .cant
	cpmove SKETCH
	jr z, .cant
	push hl
	push bc
	ld b, a
	ld hl, wBattleMonMoves
	ldh a, [hBattleTurn]
	and a
	jr z, .got_own
	ld hl, wEnemyMonMoves
.got_own
	ld c, NUM_MOVES
.known
	ld a, [hli]
	cp b
	jr z, .knows_it
	dec c
	jr nz, .known
	ld a, b
	pop bc
	pop hl
	and a
	ret

.knows_it
	ld a, b
	pop bc
	pop hl
.cant
	scf
	ret

.Power:
; a: the power of move b
	push hl
	push bc
	ld a, b
	ld l, a
	ld a, MOVE_POWER
	call GetMoveAttribute
	pop bc
	pop hl
	ret

CompareSpeeds::
; Compare the speed of the player's POKéMON with the foe's (see WeatherSpeed):
; z if they're the same, carry if the player's is slower.
	ld bc, wBattleMon
	call WeatherSpeed
	push de
	ld bc, wEnemyMon
	call WeatherSpeed
	pop hl
	ld a, h
	cp d
	ret nz
	ld a, l
	cp e
	ret

WeatherSpeed::
; bc: a battle struct. de: its speed, 1.5x (as one stage up) when the weather or
; the terrain raises it (see WeatherBoosts).
	ld hl, wBattleMonSpeed - wBattleMon
	add hl, bc
	ld a, [hli]
	ld d, a
	ld e, [hl]
	push de
	call WeatherRaisesSpeed
	pop de
	ret nc
	ld h, d
	ld l, e
	srl d
	rr e
	add hl, de
	ld d, h
	ld e, l
	ret

; (WeatherBoosts: a terrain's entries)
DEF BOOST_TERRAIN_F EQU 7
DEF BOOST_TERRAIN EQU 1 << BOOST_TERRAIN_F
	assert NUM_WEATHERS < BOOST_TERRAIN && NUM_TERRAINS < BOOST_TERRAIN

WeatherRaisesSpeed::
; Return carry if the weather or the terrain raises the SPEED of battle struct bc
; (WeatherBoosts).
	ld a, SPEED
	jr WeatherRaisesStat

WeatherRaisesDefense::
; The same, for the DEFENSE: in HAIL, an ICE type's.
	ld a, DEFENSE
	jr WeatherRaisesStat

WeatherRaisesDefendingStat::
; The same, for the stat battle struct bc defends with against the user's attack:
; its DEFENSE against a physical one, its SPCL.DEF against a special one (see
; WeatherSpclDef).
	ld hl, wPlayerMoveStructType
	ldh a, [hBattleTurn]
	and a
	jr z, .got_move
	ld hl, wEnemyMoveStructType
.got_move
	ld a, [hl]
	cp SPECIAL
	ld a, DEFENSE
	jr c, WeatherRaisesStat
	; fallthrough

WeatherRaisesSpclDef::
; The same, for the SPCL.DEF: in a sandstorm, a GROUND, ROCK or STEEL type's.
	ld a, SP_DEFENSE
	; fallthrough

WeatherRaisesStat:
; Return carry if the weather or the terrain raises stat a of battle struct bc, as
; one stage up (WeatherBoosts; one stage, even when both do).
	push af
	ld hl, wBattleMonType1 - wBattleMon
	add hl, bc
	ld a, [hli]
	ld d, a
	ld e, [hl]
	pop af
	ld b, a
	ld hl, WeatherBoosts
.loop
	ld a, [hli]
	cp -1
	ret z ; (nc)
; (a weather, or a terrain: BOOST_TERRAIN | it)
	ld c, a
	ld a, [wBattleWeather]
	bit BOOST_TERRAIN_F, c
	jr z, .got_field
	res BOOST_TERRAIN_F, c
	ld a, [wBattleTerrain]
.got_field
	cp c
	jr nz, .next
	ld a, [hli]
	cp d
	jr z, .type
	cp e
	jr nz, .next_stat
.type
	ld a, [hli]
	cp b
	jr nz, .loop
	scf
	ret

.next
	inc hl
.next_stat
	inc hl
	jr .loop

WeatherBoosts:
; the weather or the terrain, a type it favors, and the stat it raises for it (as
; one stage up)
	db WEATHER_SANDSTORM, GROUND, SP_DEFENSE
	db WEATHER_SANDSTORM, ROCK,   SP_DEFENSE
	db WEATHER_SANDSTORM, STEEL,  SP_DEFENSE
	db WEATHER_SANDSTORM, GROUND, SPEED
	db WEATHER_SANDSTORM, ROCK,   SPEED
	db WEATHER_SANDSTORM, STEEL,  SPEED
	db WEATHER_RAIN,      WATER,  SPEED
	db WEATHER_SUN,       GRASS,  SPEED
	db WEATHER_HAIL,      ICE,    DEFENSE
	db WEATHER_HAIL,      ICE,    SPEED
	db BOOST_TERRAIN | TERRAIN_ELECTRIC, ELECTRIC, SPEED
	db -1

StartFieldMove::
; (the startfield command) HAIL, or a terrain (which one: the move's type, see
; TypeTerrain), for five turns. A terrain takes another's place, and leaves the
; weather be. It fails when that one's up already.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_HAIL
	jr nz, .terrain
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	jr z, .failed
	ld a, WEATHER_HAIL
	ld [wBattleWeather], a
	ld a, 5
	ld [wWeatherCount], a
	ld hl, HailStartedText
	jr .started

.terrain
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	and TYPE_MASK
	call TypeTerrain
	ld hl, wBattleTerrain
	cp [hl]
	jr z, .failed
	ld [hl], a
	ld a, 5
	ld [wTerrainCount], a
	ld hl, TerrainStartedTexts
	call TerrainText
.started
	push hl
	farcall AnimateCurrentMove
	pop hl
	jp StdBattleTextbox

.failed
	farcall AnimateFailedMove
	ld hl, ButItFailedText
	jp StdBattleTextbox

TerrainText:
; hl: the text for wBattleTerrain in table hl
	ld a, [wBattleTerrain]
	dec a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

TerrainStartedTexts:
; entries correspond to TERRAIN_* constants
	table_width 2
	dw ElectricTerrainText
	dw GrassyTerrainText
	dw MistyTerrainText
	dw PsychicTerrainText
	assert_table_length NUM_TERRAINS

TerrainEndedTexts:
	table_width 2
	dw BattleText_ElectricTerrainEnded
	dw BattleText_GrassyTerrainEnded
	dw BattleText_MistyTerrainEnded
	dw BattleText_PsychicTerrainEnded
	assert_table_length NUM_TERRAINS

AITypeTerrain::
; (AI_Redundant) c: the terrain a terrain move of type b makes
	ld a, b
	; fallthrough

TypeTerrain::
; a = c = the terrain a terrain move of type a makes (TERRAIN_NONE: none)
	ld c, TERRAIN_ELECTRIC
	cp ELECTRIC
	jr z, .got_terrain
	inc c
	cp GRASS
	jr z, .got_terrain
	inc c
	cp FAIRY
	jr z, .got_terrain
	inc c
	cp PSYCHIC_TYPE
	jr z, .got_terrain
	ld c, TERRAIN_NONE
.got_terrain
	ld a, c
	ret

TerrainTypes:
; the type each terrain powers up (MISTY TERRAIN: none, see DoTerrainModifiers)
	table_width 1
	db ELECTRIC
	db GRASS
	db -1
	db PSYCHIC_TYPE
	assert_table_length NUM_TERRAINS

TerrainType::
; c: the type wBattleTerrain powers up (-1: none)
	ld a, [wBattleTerrain]
	dec a
	ld c, a
	ld b, 0
	ld hl, TerrainTypes
	add hl, bc
	ld c, [hl]
	ret

WeatherDamage::
; (HandleWeather) A SANDSTORM hurts each POKéMON but a GROUND, ROCK or STEEL type
; (1/8 of its max HP), HAIL each but an ICE type (1/16); not one underground (DIG).
	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	jr z, .go
	cp WEATHER_HAIL
	ret nz
.go
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .enemy_first
	call SetPlayerTurn
	call .Damage
	call SetEnemyTurn
	jr .Damage

.enemy_first
	call SetEnemyTurn
	call .Damage
	call SetPlayerTurn
	; fallthrough

.Damage:
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	bit SUBSTATUS_UNDERGROUND, a
	ret nz
	ld hl, wBattleMonType1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_types
	ld hl, wEnemyMonType1
.got_types
	ld de, .SandstormSpares
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	jr nz, .spares
	ld de, .HailSpares
.spares
	ld a, [de]
	inc de
	cp -1
	jr z, .hurt
	cp [hl]
	ret z
	inc hl
	cp [hl]
	dec hl
	ret z
	jr .spares

.hurt
	call .SwitchTurn
	xor a
	ld [wBattleAfterAnim], a
	ld de, ANIM_IN_SANDSTORM
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	jr nz, .got_anim
	ld de, ANIM_IN_HAIL
.got_anim
	farcall Call_PlayBattleAnim
	call .SwitchTurn
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	jr z, .hail
	farcall GetEighthMaxHP
	farcall SubtractHPFromUser
	ld hl, SandstormHitsText
	jp StdBattleTextbox

.hail
	farcall GetSixteenthMaxHP
	farcall SubtractHPFromUser
	ld hl, HailHitsText
	jp StdBattleTextbox

.SwitchTurn:
	ldh a, [hBattleTurn]
	xor 1
	ldh [hBattleTurn], a
	ret

.SandstormSpares:
	db ROCK, GROUND, STEEL, -1
.HailSpares:
	db ICE, -1

HandleTerrain::
; (HandleWeather, after the weather) GRASSY TERRAIN heals each POKéMON on the
; ground 1/16 of its max HP; then the terrain's turns run down.
	ld a, [wBattleTerrain]
	and a
	ret z
	cp TERRAIN_GRASSY
	jr nz, .count
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .enemy_first
	call SetPlayerTurn
	call .Heal
	call SetEnemyTurn
	call .Heal
	jr .count

.enemy_first
	call SetEnemyTurn
	call .Heal
	call SetPlayerTurn
	call .Heal
.count
	ld hl, wTerrainCount
	dec [hl]
	ret nz
	ld hl, TerrainEndedTexts
	call TerrainText
	xor a ; TERRAIN_NONE
	ld [wBattleTerrain], a
	jp StdBattleTextbox

.Heal:
	call IsUserGrounded
	ret nz
	ld hl, wBattleMonHP
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld hl, wEnemyMonHP
.got_hp
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	or b
	ret z ; (fainted)
	ld a, [hli]
	cp b
	jr nz, .heal
	ld a, [hl]
	cp c
	ret z ; (full)
.heal
	farcall GetSixteenthMaxHP
	ldh a, [hBattleTurn]
	xor 1
	ldh [hBattleTurn], a
	farcall RestoreHP
	ld hl, GrassyTerrainHealText
	jp StdBattleTextbox

IsTargetGrounded::
; Return z if the target is on the ground (see IsGrounded).
	ldh a, [hBattleTurn]
	xor 1
	jr IsGrounded

IsUserGrounded::
; Return z if the user is on the ground (see IsGrounded).
	ldh a, [hBattleTurn]
	; fallthrough

IsGrounded:
; Return z if the POKéMON out on side a (0: the player's) is on the ground, where
; the terrains work: not a FLYING type, and not up in the air (FLY).
	and a
	ld hl, wBattleMonType1
	ld a, [wPlayerSubStatus3]
	jr z, .got_side
	ld hl, wEnemyMonType1
	ld a, [wEnemySubStatus3]
.got_side
	bit SUBSTATUS_FLYING, a
	ret nz
	ld a, [hli]
	cp FLYING
	jr z, .in_the_air
	ld a, [hl]
	cp FLYING
	jr z, .in_the_air
	xor a
	ret

.in_the_air
	or 1
	ret

TerrainProtectsTarget::
; (BattleCommand_CheckSafeguard) Return nz, with its text in hl, if the terrain
; keeps the target from the user's status move (see TerrainProtectsSide).
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	ld c, a
	ldh a, [hBattleTurn]
	xor 1
	ld b, a
	; fallthrough

TerrainProtectsSide::
; Return nz, with its text in hl, if the terrain keeps the POKéMON out on side b
; (0: the player's), on the ground, from the status a move of effect c brings:
; MISTY TERRAIN from any (sleep, poison, paralysis, confusion), ELECTRIC TERRAIN
; from sleep. bc are kept.
	ld a, [wBattleTerrain]
	cp TERRAIN_MISTY
	ld hl, MistyTerrainProtectsText
	jr z, .grounded
	cp TERRAIN_ELECTRIC
	jr nz, .no
	ld a, c
	cp EFFECT_SLEEP
	jr nz, .no
	ld hl, ElectricTerrainProtectsText
.grounded
	push hl
	ld a, b
	call IsGrounded
	pop hl
	jr nz, .no
	or 1
	ret

.no
	xor a
	ret

MistyTerrainProtects::
; (SafeCheckSafeguard) Return nz if MISTY TERRAIN keeps the target, on the ground,
; from a status (an attack's added one, or confusion).
	ld a, [wBattleTerrain]
	cp TERRAIN_MISTY
	jr nz, .no
	call IsTargetGrounded
	jr nz, .no
	or 1
	ret

.no
	xor a
	ret

RestFailsForTerrain::
; (BattleCommand_Heal) Return carry if REST fails ("But it failed!") as ELECTRIC
; or MISTY TERRAIN keeps the user, on the ground, awake; else z and nc.
	ld a, [wBattleTerrain]
	cp TERRAIN_MISTY
	jr z, .terrain
	cp TERRAIN_ELECTRIC
	jr nz, .no
.terrain
	call IsUserGrounded
	jr nz, .no
	farcall AnimateFailedMove
	ld hl, ButItFailedText
	call StdBattleTextbox
	scf
	ret

.no
	xor a
	ret

PsychicTerrainBlocks::
; (BattleCommand_CheckHit) Return nz, with its text in hl, if PSYCHIC TERRAIN
; keeps the user's attack off the target, on the ground: an attack that goes first
; (QUICK ATTACK, MACH PUNCH, EXTREMESPEED).
	ld a, [wBattleTerrain]
	cp TERRAIN_PSYCHIC
	jr nz, .no
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_PRIORITY_HIT
	jr nz, .no
	call IsTargetGrounded
	jr nz, .no
	ld hl, PsychicTerrainProtectsText
	or 1
	ret

.no
	xor a
	ret

WeatherSureHit::
; (BattleCommand_CheckHit) Return z if the weather makes the user's move hit for
; sure: THUNDER in the rain, BLIZZARD in HAIL.
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_THUNDER
	jr nz, .blizzard
	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	ret

.blizzard
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cpmove BLIZZARD
	ret nz
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	ret
