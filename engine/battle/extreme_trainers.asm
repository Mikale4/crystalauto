; EXTREME trainers (PalletToPewter's 85_extreme.js): every trainer brings six
; Pokémon (but the rival's first battle stays his one starter). Their own are
; joined by others that fit who they are (ExtremeTeamPools), at the trainer's
; level and as evolved as that allows, but only as strong as the level makes
; fair: base stats that add up to no more than 300 + 6 x the level (or they join
; as an earlier form, or not at all). Every one has its best moveset, perfect
; DVs and a held item that suits it, no two the same on one team, and they
; battle smarter (see GetAIMoveWeights). Boss Pokémon get the movesets and DVs.
;
; The best moveset is worked out from the moves a Pokémon learns by its level and
; the TMs, HMs and tutor moves a player could have by then (by badges): its three
; strongest attacks of different types, then its best support move, or another
; attack.

; scratch space while a team is made (at the start of a battle)
DEF wXChosen EQUS "(wBattleScriptBuffer)"      ; NUM_MOVES moves picked so far
DEF wXNumChosen EQUS "(wBattleScriptBuffer + 4)"
DEF wXPass EQUS "(wBattleScriptBuffer + 5)"  ; XPASS_*
DEF wXBestMove EQUS "(wBattleScriptBuffer + 6)"
DEF wXBestScore EQUS "(wBattleScriptBuffer + 7)"  ; big-endian
DEF wXBadges EQUS "(wBattleScriptBuffer + 9)"
DEF wXPoolStart EQUS "(wBattleScriptBuffer + 11)" ; 2 bytes
DEF wXPoolSize EQUS "(wBattleScriptBuffer + 13)"
DEF wXPoolIndex EQUS "(wBattleScriptBuffer + 14)"
DEF wXTries EQUS "(wBattleScriptBuffer + 15)"
DEF wXSlot EQUS "(wBattleScriptBuffer + 16)"
DEF wXPoolMon EQUS "(wBattleScriptBuffer + 17)"
DEF wXMoveType EQUS "(wBattleScriptBuffer + 18)"
DEF wXMove EQUS "(wBattleScriptBuffer + 19)"
DEF wXLap EQUS "(wBattleScriptBuffer + 20)"
DEF wXExplicit EQUS "(wBattleScriptBuffer + 21)" ; choosing from wXCandidates only
DEF wXCandidates EQUS "(wBattleScriptBuffer + 22)" ; NUM_MOVES + 1 moves

	const_def
	const XPASS_NEW_TYPE ; an attack of a type not picked yet
	const XPASS_SUPPORT  ; a move from ExtremeSupportMoves
	const XPASS_ATTACK   ; any attack
	const XPASS_ANY      ; any move at all

ExtremeTrainerParty::
; After HARD's changes: fill the team to six, then give each its best set.
	call CountBadgesForTMs
	ld a, [wOtherTrainerClass]
	cp RIVAL1
	jr nz, .fill
	ld a, [wOtherTrainerID]
	cp RIVAL1_1_TOTODILE + 1 ; (RIVAL1_1_*: the first battle)
	jr c, .sets
.fill
	call FillExtremeTeam
.sets
	xor a
	ld [wXSlot], a
.loop
	ld a, [wXSlot]
	call ExtremeMonSet
	ld a, [wXSlot]
	call GiveExtremeHeldItem
	ld hl, wXSlot
	inc [hl]
	ld a, [wOTPartyCount]
	cp [hl]
	jr nz, .loop
	ret

ExtremeBossParty::
; A boss and its allies on EXTREME: best movesets, perfect DVs (but the red
; GYARADOS stays red) and held items.
	call CountBadgesForTMs
	xor a
	ld [wXSlot], a
.loop
	ld a, [wXSlot]
	inc a
	ld b, a
	ld a, [wOTPartyCount]
	cp b
	jr nz, .perfect
	ld a, [wBattleType]
	cp BATTLETYPE_FORCESHINY
	jr z, .keep_dvs
.perfect
	ld a, [wXSlot]
	call SetPerfectDVs
.keep_dvs
	ld a, [wXSlot]
	call ExtremeMonMoves
	ld a, [wXSlot]
	call GiveExtremeHeldItem
	ld hl, wXSlot
	inc [hl]
	ld a, [wOTPartyCount]
	cp [hl]
	jr nz, .loop
	ret

GetEnemyMonTrainerDVs::
; LoadEnemyMon: bc = the DVs of the trainer's Pokémon in slot wCurPartyMon. A
; boss's and EXTREME trainers' Pokémon have their own; others have their class's.
	ld a, [wBossBattle]
	and a
	jr nz, .own
	call GetDifficulty
	cp DIFFICULTY_EXTREME
	jr z, .own
	farcall GetTrainerDVs
	ret

.own
	push hl
	ld a, [wCurPartyMon]
	ld hl, wOTPartyMon1DVs
	call GetPartyLocation
	ld b, [hl]
	inc hl
	ld c, [hl]
	pop hl
	ret

CountBadgesForTMs:
	ld hl, wJohtoBadges
	ld b, 2 ; wJohtoBadges, wKantoBadges
	call CountSetBits
	ld [wXBadges], a
	ret

ExtremeMonSet:
; The trainer's Pokémon in slot a: perfect DVs and its best moves.
	push af
	call SetPerfectDVs
	pop af
	; fallthrough

ExtremeMonMoves:
; The trainer's Pokémon in slot a: its best moves, full PP and stats.
	push af
	ld hl, wOTPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	pop af
	push hl
	ld e, a
	ld d, 0
	ld hl, wOTPartySpecies
	add hl, de
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData
	pop hl
	push hl
	ld bc, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a
	call PickBestMoves
	pop hl
	push hl
	ld bc, MON_MOVES
	add hl, bc
	ld de, wXChosen
	ld c, NUM_MOVES
.copy
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .copy
	pop hl
	push hl
	ld bc, MON_MOVES
	add hl, bc
	call SetFullPP
	pop hl
	jp RecalcOTPartyMonStats

SetPerfectDVs:
; The trainer's Pokémon in slot a gets the best DVs (15 in every stat).
	ld hl, wOTPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret

; Filling the team

FillExtremeTeam:
	ld a, [wOTPartyCount]
	cp PARTY_LENGTH
	ret nc
	call GetExtremeTeamPool
	ld a, l
	ld [wXPoolStart], a
	ld a, h
	ld [wXPoolStart + 1], a
	ld c, 0
.count
; (16-bit indexes, ending in -1)
	ld a, [hli]
	and [hl]
	inc hl
	inc a
	jr z, .counted
	inc c
	jr .count

.counted
	ld a, c
	ld [wXPoolSize], a
	and a
	ret z
; start somewhere of the trainer's own
	ld c, 0
	call GetTrainerMonSeed
	ld b, a
	ld a, [wXPoolSize]
	ld c, a
	ld a, b
.mod
	cp c
	jr c, .got_start
	sub c
	jr .mod

.got_start
	ld [wXPoolIndex], a
	xor a
	ld [wXLap], a
.lap
	ld a, [wXPoolSize]
	ld [wXTries], a
.loop
	ld a, [wOTPartyCount]
	cp PARTY_LENGTH
	ret nc
	ld a, [wXTries]
	and a
	jr z, .next_lap
	dec a
	ld [wXTries], a
; this pool entry, and the next one next time
	ld a, [wXPoolStart]
	ld l, a
	ld a, [wXPoolStart + 1]
	ld h, a
	ld a, [wXPoolIndex]
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld a, [wOTPartyCount]
	ldh [hRandomizerSlot], a
	farcall RandomizeTrainerMon
	ld h, d
	ld l, e
	call GetPokemonIDFromIndex
	ld [wXPoolMon], a
	ld a, [wXPoolIndex]
	inc a
	ld hl, wXPoolSize
	cp [hl]
	jr c, .next_index_ok
	xor a
.next_index_ok
	ld [wXPoolIndex], a
	call ChooseExtremeForm
	jr nc, .loop
; not one the team has already
	ld a, [wCurPartySpecies]
	ld hl, wOTPartySpecies
	ld de, 1
	call IsInArray
	jr c, .loop
	ld a, OTPARTYMON
	ld [wMonType], a
	predef TryAddMonToParty
	jr .loop

.next_lap
; if the team still isn't full, go round again, letting any of them join
	ld a, [wXLap]
	and a
	ret nz
	inc a
	ld [wXLap], a
	jr .lap

ChooseExtremeForm:
; wCurPartySpecies: wXPoolMon as evolved as wDifficultyFloor allows. Return carry
; if it can join: the first time round, only when its first form (wXPoolMon) is
; no stronger than is fair for the level, so a SNORLAX waits; then it's as evolved
; as the level allows, whatever that makes it (no level 14 KAKUNA).
	ld a, [wDifficultyFloor]
	ld [wCurPartyLevel], a
	ld a, [wXLap]
	and a
	jr nz, .fair
	ld a, [wXPoolMon]
	call IsFairForLevel
	ret nc
.fair
	ld a, [wOTPartyCount]
	ld c, a
	call GetTrainerMonSeed
	ld e, a
	ld a, [wXPoolMon]
	call FitEvolution
	ld [wCurPartySpecies], a
	scf
	ret

IsFairForLevel:
; Return carry if species a isn't too strong for wCurPartyLevel: its base stats
; add up to no more than 300 + 6 x the level.
	ld [wCurSpecies], a
	call GetBaseData
	ld hl, wBaseStats
	ld de, 0
	ld c, NUM_STATS
.add_stats
	ld a, [hli]
	add e
	ld e, a
	jr nc, .no_carry
	inc d
.no_carry
	dec c
	jr nz, .add_stats
; 300 + 6 x level
	ld a, [wCurPartyLevel]
	ld l, a
	ld h, 0
	add hl, hl
	ld b, h
	ld c, l
	add hl, hl
	add hl, bc ; x 6
	ld bc, 300
	add hl, bc
; fair if the stats are no more than that
	ld a, l
	sub e
	ld a, h
	sbc d
	ccf
	ret

GetExtremeTeamPool:
; hl: the Pokémon that join a trainer of wOtherTrainerClass.
	ld a, [wOtherTrainerClass]
	dec a
	ld e, a
	ld d, 0
	ld hl, ExtremeTeamPools
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

; Best movesets

PickBestMoves:
; wXChosen: the best moves for wCurPartySpecies (base data loaded) at
; wCurPartyLevel.
	xor a
	ld [wXExplicit], a
	ld hl, wXChosen
rept NUM_MOVES
	ld [hli], a
endr
	ld [wXNumChosen], a
PickBestMovesFrom:
; (the same, after the wXNumChosen moves already in wXChosen; with wXExplicit,
; from the moves in wXCandidates)
; up to three attacks of different types
	ld a, XPASS_NEW_TYPE
	ld [wXPass], a
	ld b, 3
.attacks
	push bc
	call PickBestMove
	pop bc
	jr nc, .support
	dec b
	jr nz, .attacks
.support
	ld a, XPASS_SUPPORT
	ld [wXPass], a
	call PickBestMove
; then any attack, then anything at all
	ld a, XPASS_ATTACK
	ld [wXPass], a
.more_attacks
	ld a, [wXNumChosen]
	cp NUM_MOVES
	ret nc
	call PickBestMove
	jr c, .more_attacks
	ld a, XPASS_ANY
	ld [wXPass], a
.anything
	ld a, [wXNumChosen]
	cp NUM_MOVES
	ret nc
	call PickBestMove
	jr c, .anything
	ret

PickBestMove:
; Pick the best move for wXPass among those it can have, if there's room.
; Return carry if one was picked.
	ld a, [wXNumChosen]
	cp NUM_MOVES
	ret nc
	xor a
	ld [wXBestMove], a
	ld [wXBestScore], a
	ld [wXBestScore + 1], a
	call ForEachCandidateMove
	ld a, [wXBestMove]
	and a
	ret z
	ld hl, wXChosen
	ld a, [wXNumChosen]
	ld e, a
	ld d, 0
	add hl, de
	ld a, [wXBestMove]
	ld [hl], a
	ld hl, wXNumChosen
	inc [hl]
	scf
	ret

ForEachCandidateMove:
; ConsiderMove each move the Pokémon learns by its level, and each TM, HM and
; tutor move it can learn that a player with wXBadges could have (or with
; wXExplicit, each move in wXCandidates).
	ld a, [wXExplicit]
	and a
	jr z, .learnable
	ld hl, wXCandidates
	ld c, NUM_MOVES + 1
.explicit
	ld a, [hli]
	push hl
	push bc
	call ConsiderMove
	pop bc
	pop hl
	dec c
	jr nz, .explicit
	ret

.learnable
	ld a, [wCurPartySpecies]
	ld b, a
	farcall GetLearnsetPointer

.learnset
; (level, then the move's 16-bit index)
	ld a, BANK(EvosAttacksPointers)
	call GetFarByte
	inc hl
	and a
	jr z, .tmhm
	ld b, a
	ld a, [wCurPartyLevel]
	cp b
	jr c, .tmhm ; (learnsets are in level order)
	ld a, BANK(EvosAttacksPointers)
	call GetFarByte
	inc hl
	ld c, a
	ld a, BANK(EvosAttacksPointers)
	call GetFarByte
	inc hl
	push hl
	ld h, a
	ld l, c
	call GetMoveIDFromIndex
	call ConsiderMove
	pop hl
	jr .learnset

.tmhm
	ld c, 0
.tmhm_loop
	push bc
	ld hl, TMHMBadgesNeeded
	ld b, 0
	add hl, bc
	ld a, [wXBadges]
	cp [hl]
	jr c, .tmhm_next
	pop bc
	push bc
	ld hl, wBaseTMHM
	ld b, CHECK_FLAG
	ld d, 0
	predef SmallFarFlagAction
	ld a, c
	and a
	jr z, .tmhm_next
	pop bc
	push bc
	ld hl, TMHMMoves
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, BANK(TMHMMoves)
	call GetFarWord
	call GetMoveIDFromIndex
	call ConsiderMove
.tmhm_next
	pop bc
	inc c
	ld a, c
	cp NUM_TM_HM_TUTOR
	jr nz, .tmhm_loop
	ret

ConsiderMove:
; Score move a for wXPass, and keep it if it's the best so far.
	and a
	ret z
	ld b, a
; not one picked already
	ld hl, wXChosen
	ld c, NUM_MOVES
.chosen
	ld a, [hli]
	cp b
	ret z
	dec c
	jr nz, .chosen
	ld a, b
	ld [wXMove], a
	ld a, [wXPass]
	cp XPASS_SUPPORT
	jr z, .support
	cp XPASS_ANY
	jr z, .any
	call AttackScore
	ld a, d
	or e
	ret z ; (not an attack)
	ld a, [wXPass]
	cp XPASS_NEW_TYPE
	jr nz, .compare
; not a type it has an attack of already
	push de
	ld a, [wXMove]
	ld c, MOVE_TYPE
	call GetXMoveAttr
	and TYPE_MASK
	ld b, a
	ld hl, wXChosen
	ld c, NUM_MOVES
.types
	ld a, [hli]
	and a
	jr z, .next_type
	push bc
	push hl
	ld c, MOVE_TYPE
	call GetXMoveAttr
	and TYPE_MASK
	pop hl
	pop bc
	cp b
	jr z, .same_type
.next_type
	dec c
	jr nz, .types
	pop de
	jr .compare

.same_type
	pop de
	ret

.support
	call SupportScore
	jr .compare

.any
	ld de, 1
.compare
; keep it if de > the best score
	ld a, [wXBestScore]
	cp d
	jr c, .better
	ret nz
	ld a, [wXBestScore + 1]
	cp e
	ret nc
.better
	ld a, d
	ld [wXBestScore], a
	ld a, e
	ld [wXBestScore + 1], a
	ld a, [wXMove]
	ld [wXBestMove], a
	ret

GetXMoveAttr:
; a: attribute c of move a
	ld l, a
	ld a, c
	jp GetMoveAttribute

AttackScore:
; de: how good wXMove is as an attack for this Pokémon (0 if it isn't one):
; power x its matching attack stat / 8, x 1.5 for its own type, x accuracy,
; adjusted for moves that hit more than once, take a turn to charge, and so on.
	ld a, [wXMove]
	ld c, MOVE_POWER
	call GetXMoveAttr
	cp 2
	jp c, .none
	ldh [hMultiplier], a
	ld a, [wXMove]
	ld c, MOVE_EFFECT
	call GetXMoveAttr
	ld hl, AttackEffectScores
	ld de, 2
	call IsInArray
	ld b, 2 ; (x 2/2)
	jr nc, .got_effect
	inc hl
	ld b, [hl]
	ld a, b
	and a
	jr z, .none
.got_effect
	push bc
; the attack stat its category uses
	ld a, [wXMove]
	ld c, MOVE_TYPE
	call GetXMoveAttr
	ld b, a
	and TYPE_MASK
	ld [wXMoveType], a
	ld a, b
	cp SPECIAL
	ld a, [wBaseAttack]
	jr c, .got_stat
	ld a, [wBaseSpecialAttack]
.got_stat
	ldh [hMultiplicand + 2], a
	xor a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	call Multiply
; / 8
	ldh a, [hProduct + 2]
	ld d, a
	ldh a, [hProduct + 3]
	ld e, a
	srl d
	rr e
	srl d
	rr e
	srl d
	rr e
; its own type: x 1.5
	ld a, [wXMoveType]
	ld hl, wBaseType1
	cp [hl]
	jr z, .stab
	inc hl
	cp [hl]
	jr nz, .no_stab
.stab
	ld h, d
	ld l, e
	srl h
	rr l
	add hl, de
	ld d, h
	ld e, l
.no_stab
; x accuracy / 256
	ld a, [wXMove]
	ld c, MOVE_ACC
	call GetXMoveAttr
	ldh [hMultiplier], a
	call .MultiplyDE
	ldh a, [hProduct + 1]
	ld d, a
	ldh a, [hProduct + 2]
	ld e, a
; the effect: x b / 2
	pop bc
	ld a, b
	cp 2
	ret z
	ldh [hMultiplier], a
	call .MultiplyDE
	ldh a, [hProduct + 1]
	srl a
	ldh a, [hProduct + 2]
	rra
	ld d, a
	ldh a, [hProduct + 3]
	rra
	ld e, a
	ret

.none
	ld de, 0
	ret

.MultiplyDE:
; hProduct = de x hMultiplier
	xor a
	ldh [hMultiplicand + 0], a
	ld a, d
	ldh [hMultiplicand + 1], a
	ld a, e
	ldh [hMultiplicand + 2], a
	jp Multiply

AttackEffectScores:
; effect, x / 2 (0: not worth picking as an attack)
	db EFFECT_MULTI_HIT,        6
	db EFFECT_DOUBLE_HIT,       4
	db EFFECT_POISON_MULTI_HIT, 4
	db EFFECT_TRIPLE_KICK,      4
	db EFFECT_HYPER_BEAM,       1
	db EFFECT_SKY_ATTACK,       1
	db EFFECT_FLY,              1
	db EFFECT_FUTURE_SIGHT,     1
	db EFFECT_ROLLOUT,          1
	db EFFECT_FURY_CUTTER,      1
	db EFFECT_FALSE_SWIPE,      1
	db EFFECT_RAMPAGE,          1 ; (x 3/4 would be fairer, but it confuses)
	db EFFECT_RECOIL_HIT,       1
	db EFFECT_JUMP_KICK,        1
	db EFFECT_TRAP_TARGET,      1
	db EFFECT_SELFDESTRUCT,     0
	db EFFECT_DREAM_EATER,      0
	db EFFECT_SNORE,            0
	db EFFECT_OHKO,             0
	db EFFECT_SUPER_FANG,       0
	db EFFECT_STATIC_DAMAGE,    0
	db EFFECT_LEVEL_DAMAGE,     0
	db EFFECT_PSYWAVE,          0
	db EFFECT_COUNTER,          0
	db EFFECT_MIRROR_COAT,      0
	db EFFECT_BIDE,             0
	db EFFECT_HIDDEN_POWER,     0
	db EFFECT_RETURN,           0
	db EFFECT_FRUSTRATION,      0
	db EFFECT_PRESENT,          0
	db EFFECT_MAGNITUDE,        0
	db EFFECT_BEAT_UP,          0
	db -1

SupportScore:
; de: how good wXMove is as a support move (0 if it isn't one): the earlier in
; ExtremeSupportMoves, the better.
	ld a, [wXMove]
	call GetMoveIndexFromID
	ld d, h
	ld e, l
	ld hl, ExtremeSupportMoves
	ld b, 0
.find
	ld a, [hli]
	ld c, a
	ld a, [hli]
	cp HIGH(-1)
	jr nz, .not_end
	ld a, c
	cp LOW(-1)
	jr z, .none
	ld a, HIGH(-1)
.not_end
	cp d
	jr nz, .next
	ld a, c
	cp e
	jr z, .found
.next
	inc hl
	inc b
	jr .find

.found
	dec hl ; (then inc hl: its flag)
	ld a, 64
	sub b ; (b: its place in the list)
	ld e, a
	ld d, 0
	inc hl
	ld a, [hl]
	and a
	ret z ; (for any Pokémon)
	ld b, a
	ld a, [wBaseSpecialAttack]
	ld c, a
	ld a, [wBaseAttack]
	cp c ; carry: its Special Attack is the stronger
	ld a, SUPPORT_PHYSICAL
	jr nc, .attacker
	ld a, SUPPORT_SPECIAL
.attacker
	cp b
	ret z
.none
	ld de, 0
	ret

	const_def 1
	const SUPPORT_PHYSICAL ; for a Pokémon whose Attack is its stronger
	const SUPPORT_SPECIAL  ; for one whose Special Attack is

ExtremeSupportMoves:
; best first
	dwb SPORE,         0
	dwb SLEEP_POWDER,  0
	dwb HYPNOSIS,      0
	dwb LOVELY_KISS,   0
	dwb THUNDER_WAVE,  0
	dwb STUN_SPORE,    0
	dwb GLARE,         0
	dwb SWORDS_DANCE,  SUPPORT_PHYSICAL
	dwb BELLY_DRUM,    SUPPORT_PHYSICAL
	dwb CURSE,         SUPPORT_PHYSICAL
	dwb RECOVER,       0
	dwb SOFTBOILED,    0
	dwb MILK_DRINK,    0
	dwb MOONLIGHT,     0
	dwb MORNING_SUN,   0
	dwb SYNTHESIS,     0
	dwb AMNESIA,       SUPPORT_SPECIAL
	dwb GROWTH,        SUPPORT_SPECIAL
	dwb TOXIC,         0
	dwb LEECH_SEED,    0
	dwb CONFUSE_RAY,   0
	dwb SPIKES,        0
	dwb AGILITY,       0
	dwb REST,          0
	dwb REFLECT,       0
	dwb LIGHT_SCREEN,  0
	dwb BARRIER,       0
	dwb SUBSTITUTE,    0
	dwb SCARY_FACE,    0 ; (the foe's stats, two stages down)
	dwb CHARM,         0
	dwb SCREECH,       0
	dwb COTTON_SPORE,  0
	dw -1

TMHMBadgesNeeded:
; how many badges a player would have by the time they could get each TM, HM and
; tutor move
	table_width 1
	db 5 ; TM01 DYNAMICPUNCH (CHUCK's wife)
	db 2 ; TM02 HEADBUTT (ILEX FOREST)
	db 9 ; TM03 CURSE (CELADON CITY)
	db 2 ; TM04 ROLLOUT (ROUTE 35)
	db 1 ; TM05 ROAR (ROUTE 32)
	db 9 ; TM06 TOXIC (JANINE)
	db 9 ; TM07 ZAP CANNON (POWER PLANT)
	db 3 ; TM08 ROCK SMASH (ROUTE 36)
	db 9 ; TM09 PSYCH UP (SAFFRON CITY)
	db 4 ; TM10 HIDDEN POWER (LAKE OF RAGE)
	db 3 ; TM11 SUNNY DAY (RADIO TOWER)
	db 2 ; TM12 SWEET SCENT (ILEX FOREST)
	db 4 ; TM13 SNORE (MOOMOO FARM)
	db 9 ; TM14 BLIZZARD (CELADON DEPT. STORE)
	db 9 ; TM15 HYPER BEAM (CELADON DEPT. STORE)
	db 7 ; TM16 ICY WIND (PRYCE)
	db 3 ; TM17 PROTECT (GOLDENROD DEPT. STORE)
	db 2 ; TM18 RAIN DANCE (SLOWPOKE WELL)
	db 9 ; TM19 GIGA DRAIN (ERIKA)
	db 3 ; TM20 ENDURE (BURNED TOWER)
	db 3 ; TM21 FRUSTRATION (GOLDENROD DEPT. STORE)
	db 8 ; TM22 SOLARBEAM (ROUTE 27)
	db 5 ; TM23 IRON TAIL (OLIVINE LIGHTHOUSE)
	db 8 ; TM24 DRAGONBREATH (CLAIR)
	db 9 ; TM25 THUNDER (CELADON DEPT. STORE)
	db 8 ; TM26 EARTHQUAKE (VICTORY ROAD)
	db 3 ; TM27 RETURN (GOLDENROD DEPT. STORE)
	db 3 ; TM28 DIG (NATIONAL PARK)
	db 9 ; TM29 PSYCHIC (SAFFRON CITY)
	db 4 ; TM30 SHADOW BALL (MORTY)
	db 1 ; TM31 MUD-SLAP (FALKNER)
	db 3 ; TM32 DOUBLE TEAM (GOLDENROD GAME CORNER)
	db 3 ; TM33 ICE PUNCH (GOLDENROD DEPT. STORE)
	db 5 ; TM34 SWAGGER (OLIVINE LIGHTHOUSE)
	db 3 ; TM35 SLEEP TALK (GOLDENROD GAME CORNER)
	db 6 ; TM36 SLUDGE BOMB (TEAM ROCKET's hideout)
	db 8 ; TM37 SANDSTORM (ROUTE 27)
	db 9 ; TM38 FIRE BLAST (CELADON DEPT. STORE)
	db 1 ; TM39 SWIFT (UNION CAVE)
	db 4 ; TM40 DEFENSE CURL (MT. MORTAR)
	db 3 ; TM41 THUNDERPUNCH (GOLDENROD DEPT. STORE)
	db 9 ; TM42 DREAM EATER (VIRIDIAN CITY)
	db 6 ; TM43 DETECT (LAKE OF RAGE)
	db 7 ; TM44 REST (ICE PATH)
	db 3 ; TM45 ATTRACT (WHITNEY)
	db 6 ; TM46 THIEF (TEAM ROCKET's hideout)
	db 9 ; TM47 STEEL WING (ROUTE 28)
	db 3 ; TM48 FIRE PUNCH (GOLDENROD DEPT. STORE)
	db 2 ; TM49 FURY CUTTER (BUGSY)
	db 1 ; TM50 NIGHTMARE (ROUTE 31)
	db 2 ; HM01 CUT
	db 5 ; HM02 FLY
	db 4 ; HM03 SURF
	db 5 ; HM04 STRENGTH
	db 1 ; HM05 FLASH
	db 6 ; HM06 WHIRLPOOL
	db 7 ; HM07 WATERFALL
	db 9 ; FLAMETHROWER (the GOLDENROD tutor, after the ELITE FOUR)
	db 9 ; THUNDERBOLT
	db 9 ; ICE BEAM
; GEN 1's TMs (see add_g1tm): GOLDENROD DEPT. STORE's, or CELADON DEPT. STORE's
	db 3 ; MEGA PUNCH (GEN 1's TM01)
	db 3 ; RAZOR WIND (TM02)
	db 9 ; SWORDS DANCE (TM03)
	db 3 ; WHIRLWIND (TM04)
	db 3 ; MEGA KICK (TM05)
	db 9 ; HORN DRILL (TM07)
	db 9 ; BODY SLAM (TM08)
	db 3 ; TAKE DOWN (TM09)
	db 9 ; DOUBLE-EDGE (TM10)
	db 3 ; BUBBLEBEAM (TM11)
	db 3 ; WATER GUN (TM12)
	db 3 ; PAY DAY (TM16)
	db 3 ; SUBMISSION (TM17)
	db 3 ; COUNTER (TM18)
	db 3 ; SEISMIC TOSS (TM19)
	db 3 ; RAGE (TM20)
	db 3 ; MEGA DRAIN (TM21)
	db 3 ; DRAGON RAGE (TM23)
	db 9 ; FISSURE (TM27)
	db 3 ; TELEPORT (TM30)
	db 3 ; MIMIC (TM31)
	db 3 ; REFLECT (TM33)
	db 3 ; BIDE (TM34)
	db 3 ; METRONOME (TM35)
	db 9 ; SELFDESTRUCT (TM36)
	db 3 ; EGG BOMB (TM37)
	db 3 ; SKULL BASH (TM40)
	db 9 ; SOFTBOILED (TM41)
	db 9 ; SKY ATTACK (TM43)
	db 3 ; THUNDER WAVE (TM45)
	db 3 ; PSYWAVE (TM46)
	db 9 ; EXPLOSION (TM47)
	db 9 ; ROCK SLIDE (TM48)
	db 3 ; TRI ATTACK (TM49)
	db 9 ; SUBSTITUTE (TM50)
	assert_table_length NUM_TM_HM_TUTOR

; Auto battle's choice when a Pokémon learns a fifth move

AutoLearn_Active::
; Return carry if auto battle is deciding: in a battle, or while the Demo plays
; (see engine/demo/demo.asm).
	ld a, [wDemoState]
	cp DEMO_RUNNING
	jr z, .yes
	ld a, [wBattleMode]
	and a
	ret z
	ld a, [wAutoBattle]
	and a
	ret z
.yes
	scf
	ret

AutoLearn_WouldLearn::
; Return carry if auto battle would have wCurPartyMon learn wPutativeTMHMMove:
; it's in the best set of four from its moves and that one (and, while it has
; room for more moves, it's an attack).
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Moves + NUM_MOVES - 1
	call GetPartyLocation
	ld a, [hl]
	and a
	jr nz, .full
	ld a, [wPutativeTMHMMove]
	ld l, a
	ld a, MOVE_POWER
	call GetMoveAttribute
	and a
	ret z ; (nc)
.full
	call AutoLearn_Choose
	ld a, c
	cp NUM_MOVES + 1
	ret ; (carry if 1-4)

AutoLearn_ForgetChoice::
; ForgetMove: c = 0 to ask the player; with auto battle on in a battle (or the
; Demo playing), 1-4 to forget that move for wPutativeTMHMMove, or NUM_MOVES + 1
; not to learn it: the best set of four from the Pokémon's moves and the new
; one (as EXTREME's trainers pick theirs).
	ld c, 0
	call AutoLearn_Active
	ret nc
AutoLearn_Choose:
	ld a, [wCurSpecies]
	push af
	ld a, [wCurPartySpecies]
	push af
; the Pokémon (wCurPartyMon)
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Species
	call GetPartyLocation
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData
; the candidates: its moves and the new one
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Moves
	call GetPartyLocation
	ld de, wXCandidates
	ld bc, NUM_MOVES
	call CopyBytes
	ld a, [wPutativeTMHMMove]
	ld [de], a
; (no move has to stay: HM moves too can go, as in PalletToPewter)
	xor a
	ld [wXNumChosen], a
	ld hl, wXChosen
rept NUM_MOVES
	ld [hli], a
endr
; the best set
	ld a, TRUE
	ld [wXExplicit], a
	call PickBestMovesFrom
	xor a
	ld [wXExplicit], a
; is the new move in it?
	ld a, [wPutativeTMHMMove]
	call .IsChosen
	ld c, NUM_MOVES + 1
	jr nc, .done
; then forget the first of its moves that isn't
	ld hl, wXCandidates
	ld c, 0
.forget_loop
	ld a, [hli]
	push hl
	push bc
	call .IsChosen
	pop bc
	pop hl
	jr nc, .forget
	inc c
	ld a, c
	cp NUM_MOVES
	jr c, .forget_loop
	ld c, NUM_MOVES + 1 ; (can't happen)
	jr .done

.forget
	inc c
.done
	pop af
	ld [wCurPartySpecies], a
	pop af
	ld [wCurSpecies], a
	push bc
	call GetBaseData
	pop bc
	ret

.IsChosen:
; Return carry if move a is in wXChosen.
	ld hl, wXChosen
	ld b, NUM_MOVES
.loop
	cp [hl]
	jr z, .yes
	inc hl
	dec b
	jr nz, .loop
	and a
	ret

.yes
	scf
	ret

; Held items

GiveTrainerHeldItem::
GiveExtremeHeldItem:
; The trainer's Pokémon in slot a gets an item that suits it, if it has none,
; and nobody else on the team has that item: the X item for its best attack's
; category (X ATTACK or X SPECIAL: used up for +2 when it comes in), else its
; type's booster, else one of ExtremeOtherItems.
	ld [wXSlot], a
	ld hl, wOTPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hl]
	and a
	ret nz
	push hl
	call .BestAttack
	ld a, [wXBestMove]
	and a
	jr z, .others
; the X item for its category
	ld c, MOVE_TYPE
	call GetXMoveAttr
	and ~TYPE_MASK
	cp SPECIAL
	ld a, X_SPECIAL
	jr z, .got_x_item
	ld a, X_ATTACK
.got_x_item
	call .TryItem
	jr c, .got_item
; its type's booster
	ld a, [wXBestMove]
	ld c, MOVE_TYPE
	call GetXMoveAttr
	and TYPE_MASK
	ld hl, TypeBoostingItems
	ld de, 2
	call IsInArray
	jr nc, .others
	inc hl
	ld a, [hl]
	call .TryItem
	jr c, .got_item
.others
	ld hl, ExtremeOtherItems
.other_loop
	ld a, [hli]
	cp -1
	jr z, .no_item
	push hl
	call .TryItem
	pop hl
	jr nc, .other_loop
.got_item
	pop hl
	ld [hl], a
	ret

.no_item
	pop hl
	ret

.BestAttack:
; wXBestMove: its best attack (by AttackScore; 0 if it has none).
	ld a, [wXSlot]
	ld e, a
	ld d, 0
	ld hl, wOTPartySpecies
	add hl, de
	ld a, [hl]
	ld [wCurSpecies], a
	call GetBaseData
	xor a
	ld [wXBestMove], a
	ld [wXBestScore], a
	ld [wXBestScore + 1], a
	ld a, [wXSlot]
	ld hl, wOTPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld c, NUM_MOVES
.best_loop
	ld a, [hli]
	and a
	jr z, .best_next
	push hl
	push bc
	ld [wXMove], a
	call AttackScore
	ld a, [wXBestScore]
	cp d
	jr c, .best_better
	jr nz, .best_done
	ld a, [wXBestScore + 1]
	cp e
	jr nc, .best_done
.best_better
	ld a, d
	ld [wXBestScore], a
	ld a, e
	ld [wXBestScore + 1], a
	ld a, [wXMove]
	ld [wXBestMove], a
.best_done
	pop bc
	pop hl
.best_next
	dec c
	jr nz, .best_loop
	ret

.TryItem:
; Return carry (and a: item a) if no Pokémon on the team holds item a yet.
	ld b, a
	ld hl, wOTPartyMon1Item
	ld de, PARTYMON_STRUCT_LENGTH
	ld a, [wOTPartyCount]
	ld c, a
.check
	ld a, [hl]
	cp b
	jr z, .taken
	add hl, de
	dec c
	jr nz, .check
	ld a, b
	scf
	ret

.taken
	and a
	ret

TypeBoostingItems:
	db NORMAL,       PINK_BOW
	db FIGHTING,     BLACKBELT_I
	db FLYING,       SHARP_BEAK
	db POISON,       POISON_BARB
	db GROUND,       SOFT_SAND
	db ROCK,         HARD_STONE
	db BUG,          SILVERPOWDER
	db GHOST,        SPELL_TAG
	db STEEL,        METAL_COAT
	db FIRE,         CHARCOAL
	db WATER,        MYSTIC_WATER
	db GRASS,        MIRACLE_SEED
	db ELECTRIC,     MAGNET
	db PSYCHIC_TYPE, TWISTEDSPOON
	db ICE,          NEVERMELTICE
	db DRAGON,       DRAGON_SCALE ; (DRAGON_FANG does nothing in this game)
	db DARK,         BLACKGLASSES
	db FAIRY,        POLKADOT_BOW
	db -1

ExtremeOtherItems:
	db LEFTOVERS
	db X_SPEED ; (used up for +2 when it comes in)
	db X_DEFEND
	db DIRE_HIT
	db QUICK_CLAW
	db KINGS_ROCK
	db SCOPE_LENS
	db BRIGHTPOWDER
	db GOLD_BERRY
	db MIRACLEBERRY
	db FOCUS_BAND
	db X_ACCURACY
	db GUARD_SPEC
	db MINT_BERRY
	db -1

INCLUDE "data/trainers/extreme_pools.asm"
