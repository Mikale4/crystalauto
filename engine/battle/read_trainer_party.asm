ReadTrainerParty:
	ld a, [wInBattleTowerBattle]
	bit IN_BATTLE_TOWER_BATTLE_F, a
	ret nz

	ld a, [wLinkMode]
	and a
	ret nz

	ld hl, wOTPartyCount
	xor a
	ld [hli], a
	dec a
	ld [hl], a

	ld hl, wOTPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH * PARTY_LENGTH
	xor a
	call ByteFill

	farcall LoadBossParty
	ret c

	ld a, [wOtherTrainerClass]
	cp CAL
	jr nz, .not_cal2
	ld a, [wOtherTrainerID]
	cp CAL2
	jr z, .cal2
	ld a, [wOtherTrainerClass]
.not_cal2

	dec a
	ld c, a
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wOtherTrainerID]
	ld b, a
	call SkipTrainers

.skip_name
	ld a, [hli]
	cp '@'
	jr nz, .skip_name

	ld a, [hli]
	ld c, a
	ld [wTrainerPartyType], a
	ld b, 0
	ld d, h
	ld e, l
	ld hl, TrainerTypes
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld bc, .done
	push bc
	jp hl

.done
	call ComputeTrainerReward
	farcall DifficultyAdjustTrainerParty
	ret

.cal2
	ld a, TRAINERTYPE_MOVES
	ld [wTrainerPartyType], a
	ld a, BANK(sMysteryGiftTrainer)
	call OpenSRAM
	ld de, sMysteryGiftTrainer
	call TrainerType2
	call CloseSRAM
	jr .done

TrainerTypes:
; entries correspond to TRAINERTYPE_* constants
	table_width 2
	dw TrainerType1 ; level, species
	dw TrainerType2 ; level, species, moves
	dw TrainerType3 ; level, species, item
	dw TrainerType4 ; level, species, item, moves
	assert_table_length NUM_TRAINERTYPES

TrainerType1:
; normal (level, species)
	ld h, d
	ld l, e
.loop
	ld a, [hli]
	cp $ff
	ret z

	ld [wCurPartyLevel], a
	call ReadTrainerPartySpecies
	ld a, OTPARTYMON
	ld [wMonType], a
	push hl
	predef TryAddMonToParty
	pop hl
	jr .loop

TrainerType2:
; moves
	ld h, d
	ld l, e
.loop
	ld a, [hli]
	cp $ff
	ret z

	ld [wCurPartyLevel], a
	call ReadTrainerPartySpecies
	push af ; (carry: another in RANDOMIZER mode, which keeps the moves it knows)
	ld a, OTPARTYMON
	ld [wMonType], a

	push hl
	predef TryAddMonToParty
	pop hl
	pop af
	jr nc, .moves
	ld bc, NUM_MOVES * 2
	add hl, bc
	jr .loop

.moves
	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

	ld b, NUM_MOVES
.copy_moves
; (16-bit indexes)
	ld a, [hli]
	ld c, a
	ld a, [hli]
	push hl
	ld h, a
	ld l, c
	call GetMoveIDFromIndex
	pop hl
	ld [de], a
	inc de
	dec b
	jr nz, .copy_moves

	push hl

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Species
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, MON_PP
	add hl, de
	push hl
	ld hl, MON_MOVES
	add hl, de
	pop de

	ld b, NUM_MOVES
.copy_pp
	ld a, [hli]
	and a
	jr z, .copied_pp

	push hl
	push bc
	ld l, a
	ld a, MOVE_PP
	call GetMoveAttribute
	pop bc
	pop hl

	ld [de], a
	inc de
	dec b
	jr nz, .copy_pp
.copied_pp

	pop hl
	jr .loop

TrainerType3:
; item
	ld h, d
	ld l, e
.loop
	ld a, [hli]
	cp $ff
	ret z

	ld [wCurPartyLevel], a
	call ReadTrainerPartySpecies
	ld a, OTPARTYMON
	ld [wMonType], a
	push hl
	predef TryAddMonToParty
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	ld a, [hli]
	ld [de], a
	jr .loop

TrainerType4:
; item + moves
	ld h, d
	ld l, e
.loop
	ld a, [hli]
	cp $ff
	ret z

	ld [wCurPartyLevel], a
	call ReadTrainerPartySpecies
	push af ; (carry: another in RANDOMIZER mode, which keeps the moves it knows)

	ld a, OTPARTYMON
	ld [wMonType], a

	push hl
	predef TryAddMonToParty
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

	ld a, [hli]
	ld [de], a

	pop af
	jr nc, .moves
	ld bc, NUM_MOVES * 2
	add hl, bc
	jr .loop

.moves
	push hl
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl

	ld b, NUM_MOVES
.copy_moves
; (16-bit indexes)
	ld a, [hli]
	ld c, a
	ld a, [hli]
	push hl
	ld h, a
	ld l, c
	call GetMoveIDFromIndex
	pop hl
	ld [de], a
	inc de
	dec b
	jr nz, .copy_moves

	push hl

	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, MON_PP
	add hl, de

	push hl
	ld hl, MON_MOVES
	add hl, de
	pop de

	ld b, NUM_MOVES
.copy_pp
	ld a, [hli]
	and a
	jr z, .copied_pp

	push hl
	push bc
	ld l, a
	ld a, MOVE_PP
	call GetMoveAttribute
	pop bc
	pop hl

	ld [de], a
	inc de
	dec b
	jr nz, .copy_pp
.copied_pp

	pop hl
	jp .loop

ReadTrainerPartySpecies:
; wCurPartySpecies: the species at hl (its 16-bit index), which hl goes past.
; Return carry if RANDOMIZER mode makes it another (see RandomizeTrainerMon).
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld a, [wOTPartyCount]
	ldh [hRandomizerSlot], a
	farcall RandomizeTrainerMon
	push af
	ld h, d
	ld l, e
	call GetPokemonIDFromIndex
	ld [wCurPartySpecies], a
	pop af
	pop hl
	ret

ComputeTrainerReward:
	ld hl, hProduct
	xor a
	ld [hli], a
	ld [hli], a ; hMultiplicand + 0
	ld [hli], a ; hMultiplicand + 1
	ld a, [wEnemyTrainerBaseReward]
	ld [hli], a ; hMultiplicand + 2
	ld a, [wCurPartyLevel]
	ld [hl], a ; hMultiplier
	call Multiply
	ld hl, wBattleReward
	xor a
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	ret

Battle_GetTrainerName::
	ld a, [wBossBattle]
	and a
	jr z, .not_boss
	ld [wNamedObjectIndex], a
	jp GetPokemonName ; (see engine/battle/bosses.asm)

.not_boss
	ld a, [wInBattleTowerBattle]
	bit IN_BATTLE_TOWER_BATTLE_F, a
	ld hl, wOTPlayerName
	jp nz, CopyTrainerName

	ld a, [wOtherTrainerID]
	ld b, a
	ld a, [wOtherTrainerClass]
	ld c, a

GetTrainerName::
	ld a, c
	cp CAL
	jr nz, .not_cal2

	ld a, BANK(sMysteryGiftTrainerHouseFlag)
	call OpenSRAM
	ld a, [sMysteryGiftTrainerHouseFlag]
	and a
	call CloseSRAM
	jr z, .not_cal2

	ld a, BANK(sMysteryGiftPartnerName)
	call OpenSRAM
	ld hl, sMysteryGiftPartnerName
	call CopyTrainerName
	jp CloseSRAM

.not_cal2
	dec c
	push bc
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc

	call SkipTrainers
	; fallthrough

CopyTrainerName:
	ld de, wStringBuffer1
	push de
	ld bc, NAME_LENGTH
	call CopyBytes
	pop de
	ret

SkipTrainersFar::
; hl: trainer b (from 1) of the group at de
	ld h, d
	ld l, e
	; fallthrough

SkipTrainers:
; hl: trainer b (from 1) of the group at hl. (Their moves' 16-bit indexes can
; have $ff bytes, so a party's -1 end isn't searched for, but walked to.)
.next
	dec b
	ret z
.name
	ld a, [hli]
	cp '@'
	jr nz, .name
	ld a, [hli] ; TRAINERTYPE_*
	ld c, 3 ; level, species
	assert TRAINERTYPE_ITEM & TRAINERTYPE_ITEM_MOVES && !(TRAINERTYPE_MOVES & TRAINERTYPE_ITEM)
	bit 1, a ; TRAINERTYPE_ITEM or TRAINERTYPE_ITEM_MOVES
	jr z, .got_item
	inc c ; item
.got_item
	bit 0, a ; TRAINERTYPE_MOVES or TRAINERTYPE_ITEM_MOVES
	jr z, .mon
	ld a, c
	add NUM_MOVES * 2 ; moves
	ld c, a
.mon
	ld a, [hl]
	inc a
	jr z, .party_end ; (level -1)
	ld a, c
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	jr .mon

.party_end
	inc hl
	jr .next

IncompleteCopyNameFunction: ; unreferenced
; Copy of CopyTrainerName but without "call CopyBytes"
	ld de, wStringBuffer1
	push de
	ld bc, NAME_LENGTH
	pop de
	ret

INCLUDE "data/trainers/parties.asm"
