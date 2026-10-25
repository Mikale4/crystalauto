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
	cp STRUGGLE
	jr z, .struggle
	cp DOUBLE_EDGE
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
; BattleCommand_LowKick: d = LOW KICK's power, by the target's weight (its
; POKéDEX weight): from 20 for under 10 kg to 120 for 200 kg and over.
; (Keeps bc, the attack and defense, and e, the level.)
	ld hl, wEnemyMonSpecies
	ldh a, [hBattleTurn]
	and a
	jr z, .got_target
	ld hl, wBattleMonSpecies
.got_target
	push bc
	push de
	ld b, [hl]
	farcall GetDexEntryPointer
; past the species name
	ld h, d
	ld l, e
.skip_name
	ld a, b
	call GetFarByte
	inc hl
	cp '@'
	jr nz, .skip_name
; past the height, to the weight (in tenths of a pound)
	inc hl
	inc hl
	ld a, b
	call GetFarWord
	ld de, LowKickPowers
.loop
	ld a, [de]
	inc de
	cp -1
	jr z, .got_power
	ld c, a
	ld a, [de]
	inc de
	ld b, a ; bc: this weight
	ld a, l
	sub c
	ld a, h
	sbc b
	jr c, .got_power ; (lighter than this)
	inc de
	jr .loop

.got_power
	ld a, [de]
	pop de
	pop bc
	ld d, a
	ret

LowKickPowers:
; weight (in tenths of a pound) it's lighter than, power
	dw  221 ;  10 kg
	db 20
	dw  552 ;  25 kg
	db 40
	dw 1103 ;  50 kg
	db 60
	dw 2205 ; 100 kg
	db 80
	dw 4410 ; 200 kg
	db 100
	db -1, 120

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
	cp DRAINING_KISS
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
; for its QUICK CLAW and KING'S ROCK, its entry moves to come, and its COUNTER
; and MIRROR COAT.
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
	ret

HandleEntryTransform::
; TRANSFORM, as the latest games' IMPOSTER: a POKéMON that knows it turns into the
; foe as it comes in, before it does anything (each turn, see BattleTurn: one
; that hasn't moved since it came in). Not when it's already transformed, or the
; foe is, or is out of sight (FLY, DIG). Its entry moves come first.
	call HandleEntryMoves
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
	cp TRANSFORM
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
	ld [hl], TRANSFORM
	farcall BattleCommand_Transform
	pop af
	pop hl
	ld [hl], a
	ret

HandleEntryMoves:
; SUNNY DAY, RAIN DANCE, SANDSTORM, FORESIGHT, FUTURE SIGHT and LOCK-ON work as a
; POKéMON comes in: at the start of its first turn out, it uses each of them it
; knows with PP left (taking their PP), before it does anything else.
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
	cp -1
	ret z
	push hl
	ld b, a
	call .Use
	pop hl
	jr .loop

.Use:
	ld a, b
	cp FUTURE_SIGHT
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

EntryMoves:
; in the order they're used (LOCK-ON last: the next attack's aim, see
; BattleCommand_CheckHit, is for an attack)
	db SUNNY_DAY
	db RAIN_DANCE
	db SANDSTORM
	db FORESIGHT
	db FUTURE_SIGHT
	db LOCK_ON
	db -1

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
; The player's move, then the foe's COUNTER or MIRROR COAT (see HandleAutoCounter).
	call ClearHitDamage
	farcall DoPlayerTurn
	jr HandleAutoCounter

DoEnemyTurnAndCounter::
; The foe's move, then the player's COUNTER or MIRROR COAT (see HandleAutoCounter).
	call ClearHitDamage
	farcall DoEnemyTurn
	; fallthrough

HandleAutoCounter:
; COUNTER and MIRROR COAT work by themselves: right after an attack hit (the
; POKéMON, not its SUBSTITUTE: wHitDamage), its target hits back for twice the
; damage, if it knows the one for the attack's category (COUNTER for a physical
; one, MIRROR COAT for a special one). They have no PP: each one hits back once
; while the POKéMON is out. Not if it fainted, is asleep or frozen, or the
; attacker is immune or fainted.
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
	ld b, COUNTER
	cp PHYSICAL
	jr z, .got_move
	ld b, MIRROR_COAT
	cp SPECIAL
	ret nz
.got_move
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	ret z
	ld hl, wEnemyMonHP
	ld a, [hli]
	or [hl]
	ret z
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
	call .Used
	and [hl]
	ret nz ; (it has, since it came in)
	farcall AutoMove_Setup
	ret c
	farcall BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	and a
	jr z, .immune
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld b, a
	call .Used
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

.Used:
; hl: the user's wPlayerFieldFlags or wEnemyFieldFlags; a: the flag for move b
	ld hl, wPlayerFieldFlags
	ldh a, [hBattleTurn]
	and a
	jr z, .got_flags
	ld hl, wEnemyFieldFlags
.got_flags
	ld a, b
	cp COUNTER
	ld a, 1 << FIELD_COUNTER_F
	ret z
	ld a, 1 << FIELD_MIRROR_COAT_F
	ret

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
	ld b, PURSUIT
	farcall AutoMove_Setup
	jr c, .none
	ld de, 0 ; (its own effect script)
	farcall AutoMove_Run
	pop af
	cp PURSUIT
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
