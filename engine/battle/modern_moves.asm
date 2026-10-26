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
; the first attack it's used since it came in. (And a move it can use once while
; it's out has been: see OnceOutMoves.)
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld b, a
	ldh a, [hBattleTurn]
	ld c, a
	call OnceOutFlag
	jr nc, .not_once
	or [hl]
	ld [hl], a
.not_once
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
; MIRROR COAT, and SPITE for both (see HandleAutoSpite).
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
; SUNNY DAY, RAIN DANCE, SANDSTORM, FORESIGHT, FUTURE SIGHT, SPIKES, SAFEGUARD,
; PSYCH UP, MEAN LOOK, SPIDER WEB and LOCK-ON work as a POKéMON comes in: at the
; start of its first turn out, it uses each of them it knows with PP left (taking
; their PP), before it does anything else.
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
	cp SPIKES
	jr z, .spikes
	cp MEAN_LOOK
	jr z, .mean_look
	cp SPIDER_WEB
	jr z, .mean_look
	cp SAFEGUARD
	jr z, .safeguard
	cp PSYCH_UP
	jr z, .psych_up
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

.safeguard
; (not when it's up already)
	ld hl, wPlayerScreens
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wEnemyScreens
.got_screens
	bit SCREENS_SAFEGUARD, [hl]
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

EntryMoves:
; in the order they're used (LOCK-ON last: the next attack's aim, see
; BattleCommand_CheckHit, is for an attack)
	db SUNNY_DAY
	db RAIN_DANCE
	db SANDSTORM
	db FORESIGHT
	db FUTURE_SIGHT
	db SPIKES
	db SAFEGUARD
	db PSYCH_UP
	db MEAN_LOOK
	db SPIDER_WEB
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
	jr HandleAutoEndOfTurn

.acted
	call HandleAutoCounter
	call HandleAutoMirrorMove
	call HandleAutoSpite
	call HandleAutoNightmare
	; fallthrough

HandleAutoEndOfTurn:
; SNORE and SPLASH work by themselves, at the end of each of its turns: a POKéMON
; that knows SNORE (with PP left) uses it while it's asleep; one that knows SPLASH
; uses it while it's awake (not frozen, nor out of sight: FLY, DIG).
	call CantGoOn
	ret nz
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	ld b, SNORE
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
	ld b, SPLASH
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
	cp STRUGGLE
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
	ld b, SPITE
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
	ld b, NIGHTMARE
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
; POKéMON is out. Not if it fainted, is asleep or frozen, or the attacker is
; immune or fainted.
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

AutoMoveFieldFlag:
; hl: the user's wPlayerFieldFlags or wEnemyFieldFlags; a: the flag for move b
; (COUNTER, MIRROR COAT or MIRROR MOVE: once each while it's out)
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
	ld a, b
	cp MIRROR_COAT
	ld a, 1 << FIELD_MIRROR_COAT_F
	ret z
	ld a, 1 << FIELD_MIRROR_MOVE_F
	ret

HandleAutoMirrorMove:
; MIRROR MOVE works by itself: right after the foe used a move, a POKéMON that
; knows MIRROR MOVE (with PP left) uses that move too, once while it's out. Not if
; either fainted, it's asleep, frozen or busy (charging, recharging, locked into a
; move), or the move is one it can't take up (MirrorMoveCant).
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
	ld b, MIRROR_MOVE
	call AutoMoveFieldFlag
	and [hl]
	ret nz ; (it has, since it came in)
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
	cp STRUGGLE
	ret z
	dec a
	ld hl, Moves + MOVE_EFFECT
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld hl, MirrorMoveCant
	ld de, 1
	call IsInArray
	ret c
; then, MIRROR MOVE
	ld b, MIRROR_MOVE
	farcall AutoMove_Setup
	ret c
	ld b, MIRROR_MOVE
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
	ld de, 0 ; (its own effect script)
	farcall AutoMove_Run
	pop hl
	pop af
	ld [hl], a
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
	cp PAY_DAY
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
; be chosen: it works by itself (AutoMoves), or it can be used once while the
; POKéMON is out and has been (OnceOutMoves). b and c are kept.
	push bc
	ld a, b
	ld hl, AutoMoves
	ld de, 1
	call IsInArray
	pop bc
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
; Return carry if move b can be used once while the POKéMON is out (OnceOutMoves):
; then hl is its side's field flags (c: 0, the player's; 1, the foe's) and a the
; flag for it.
	ld hl, OnceOutMoves
.loop
	ld a, [hli]
	cp -1
	ret z ; (nc)
	cp b
	jr z, .found
	inc hl
	jr .loop

.found
	ld a, [hl]
	ld hl, wPlayerFieldFlags
	dec c
	inc c
	jr z, .got_flags
	ld hl, wEnemyFieldFlags
.got_flags
	scf
	ret

AutoMoves:
; moves that work by themselves, so they can't be chosen (for the player, the foe
; and auto battle: see CantChooseMove)
	db COUNTER      ; right after an attack: see HandleAutoCounter
	db MIRROR_COAT
	db MIRROR_MOVE  ; right after the foe's move: see HandleAutoMirrorMove
	db SPITE        ; (see HandleAutoSpite)
	db FUTURE_SIGHT ; as it comes in: see HandleEntryMoves
	db SAFEGUARD
	db MEAN_LOOK
	db SPIDER_WEB
	db SNORE        ; at the end of its turn: see HandleAutoEndOfTurn
	db SPLASH
	db NIGHTMARE    ; when the foe is asleep: see HandleAutoNightmare
	db CONVERSION   ; just before an attack's damage: see HandleAutoConversion
	db CONVERSION2
	db -1

OnceOutMoves:
; moves that can be used once while the POKéMON is out (see MarkFirstAttack), and
; their FIELD_*_F flags
	db SWORDS_DANCE, 1 << FIELD_SWORDS_DANCE_F
	db GROWTH,       1 << FIELD_GROWTH_F
	db AMNESIA,      1 << FIELD_AMNESIA_F
	db -1

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
	cp STRUGGLE
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
	ld b, CONVERSION2
	call .Knows
	jr nc, .knows_one
	ld b, CONVERSION
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
	ld b, CONVERSION2
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
	ld b, CONVERSION
	call .Knows
	jr nc, .convert
	ld b, CONVERSION2
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
	cp STRUGGLE
	jr z, .cant
	cp SKETCH
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
	dec a
	ld hl, Moves + MOVE_POWER
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop bc
	pop hl
	ret
