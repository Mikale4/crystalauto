; The box screen once put POKéMON in boxes that were full (a species byte of 0 in a
; box's species list ended it early, so the box looked less full: see
; BoxScreen_BoxCount). A 21st POKéMON went past the box's end: its OT name over
; the first's nickname, its data over the first OT names, and its species list's
; end over the first's species; with its count saved as 21, SaveBox left its index
; array all 0 and its moves IDs. Each continue, before the box out is loaded (see
; Continue), every box is made sound again, and then the party (see
; SanitizeParty).

DEF REPAIR_BANK       EQUS "wStringBuffer2"     ; the box's SRAM bank
DEF REPAIR_BOX        EQUS "wStringBuffer2 + 1" ; (dw) the box
DEF REPAIR_INDEXES    EQUS "wStringBuffer2 + 3" ; (dw) its index array
DEF REPAIR_OVERFLOW   EQUS "wStringBuffer2 + 5" ; its count was more than MONS_PER_BOX
DEF REPAIR_MON        EQUS "wStringBuffer2 + 6" ; its POKéMON looked at
DEF REPAIR_BOXES_LEFT EQUS "wStringBuffer2 + 7"
DEF REPAIR_RESTAT     EQUS "wStringBuffer2"     ; (SanitizeParty) its stats are to be worked out again

SanitizeBoxes::
; (the player's ID and name, to know their POKéMON's OT names: see SanitizeBox)
	ld a, BANK(sPlayerData)
	call OpenSRAM
	ld hl, sPlayerData
	ld de, wPlayerData
	ld bc, wPlayerName + NAME_LENGTH - wPlayerData
	call CopyBytes
	ld de, SanitizeBox
	call .EachBox
; then their levels (which can give species IDs: so once every box's species are
; known, the IDs in them no longer needed)
	ld de, SanitizeBoxLevels
.EachBox:
	ld hl, SanitizeBoxPlaces
	ld a, NUM_BOXES
.box
	ld [REPAIR_BOXES_LEFT], a
	ld a, [hli]
	ld [REPAIR_BANK], a
	ld a, [hli]
	ld [REPAIR_BOX], a
	ld a, [hli]
	ld [REPAIR_BOX + 1], a
	ld a, [hli]
	ld [REPAIR_INDEXES], a
	ld a, [hli]
	ld [REPAIR_INDEXES + 1], a
	push hl
	push de
	call .Call
	pop de
	pop hl
	ld a, [REPAIR_BOXES_LEFT]
	dec a
	jr nz, .box
	jp CloseSRAM

.Call:
	push de
	ret

SanitizeBoxPlaces:
; each box: its bank, its place, its index array's place
	table_width 5
for n, 1, NUM_BOXES + 1
	db BANK(sBox{d:n})
	dw sBox{d:n}, sBox{d:n}PokemonIndexes
	assert BANK(sBox{d:n}) == BANK(sBox{d:n}PokemonIndexes)
endr
	assert_table_length NUM_BOXES

SanitizeBox:
; No more than MONS_PER_BOX; each POKéMON's species in the index array (from its
; nickname if a species' name, or its species byte or its species list's, as IDs:
; none, it's taken out); its species list ended after them; their names ended.
; One whose count was too big: its first POKéMON's nickname and the first OT names
; (the player's POKéMON's) made again, and its moves made indexes (from IDs).
	call RepairOpenBox
	xor a
	ld [REPAIR_OVERFLOW], a
	ld a, [hl]
	cp MONS_PER_BOX + 1
	jr c, .count_ok
	ld [hl], MONS_PER_BOX
	ld a, TRUE
	ld [REPAIR_OVERFLOW], a
; (the first nickname: the 21st's OT name, so no species' name)
	ld hl, sBoxMonNicknames - sBox
	xor a
	call RepairBoxPlace
	ld [hl], '@'
	call .OTNames
.count_ok
	xor a
.mon
	ld [REPAIR_MON], a
	call RepairBoxCount
	ld b, a
	ld a, [REPAIR_MON]
	cp b
	jr nc, .indexes_done
	call SanitizeBoxMonIndex
	ld a, [REPAIR_MON]
	jr c, .mon ; (taken out: the next is in its place)
	inc a
	jr .mon

.indexes_done
; the species list: none 0 or -1 (RefreshBoxSpecies gives them their IDs), then
; its end
	ld hl, sBoxSpecies - sBox
	xor a
	call RepairBoxPlace
	call RepairBoxCount
	ld c, a
	and a
	jr z, .list_end
.list
	ld a, [hl]
	and a
	jr z, .list_fill
	inc a
	jr nz, .list_next
.list_fill
	ld [hl], 1
.list_next
	inc hl
	dec c
	jr nz, .list
.list_end
	ld [hl], -1
; the names end by their last character
	xor a
.names
	ld [REPAIR_MON], a
	call RepairBoxCount
	ld b, a
	ld a, [REPAIR_MON]
	cp b
	jr nc, .names_done
	ld hl, sBoxMonNicknames - sBox + MON_NAME_LENGTH - 1
	ld bc, MON_NAME_LENGTH
	call RepairBoxPlace
	ld [hl], '@'
	ld a, [REPAIR_MON]
	ld hl, sBoxMonOTs - sBox + NAME_LENGTH - 1
	ld bc, NAME_LENGTH
	call RepairBoxPlace
	ld [hl], '@'
	ld a, [REPAIR_MON]
	inc a
	jr .names

.names_done
	ld a, [REPAIR_OVERFLOW]
	and a
	ret z
; the first's nickname (if it was made none above): its species' name
	call RepairBoxCount
	and a
	ret z
	ld hl, sBoxMonNicknames - sBox
	xor a
	call RepairBoxPlace
	ld a, [hl]
	cp '@'
	jr nz, .moves
	push hl
	ld de, 0 ; (EGG's)
	ld hl, sBoxSpecies - sBox
	xor a
	call RepairBoxPlace
	ld a, [hl]
	cp EGG
	jr z, .got_name
	xor a
	ld [REPAIR_MON], a
	call RepairIndexPlace
	ld a, [hli]
	ld d, [hl]
	ld e, a
.got_name
	farcall GetSpeciesNameFromIndex
	pop de
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
.moves
	ld a, [REPAIR_BANK]
	ld b, a
	ld a, [REPAIR_BOX]
	ld e, a
	ld a, [REPAIR_BOX + 1]
	ld d, a
	ld c, 0
	farcall BillsPC_ConvertBoxData
	jp RepairOpenBox

.OTNames:
; the first three's OT names (the 21st's data is there): the player's, if theirs
	xor a
.ot_name
	ld [REPAIR_MON], a
	ld hl, sBoxMon1ID - sBox
	ld bc, BOXMON_STRUCT_LENGTH
	call RepairBoxPlace
	ld a, [wPlayerID]
	cp [hl]
	jr nz, .next_ot_name
	inc hl
	ld a, [wPlayerID + 1]
	cp [hl]
	jr nz, .next_ot_name
	ld a, [REPAIR_MON]
	ld hl, sBoxMonOTs - sBox
	ld bc, NAME_LENGTH
	call RepairBoxPlace
	ld d, h
	ld e, l
	ld hl, wPlayerName
	ld bc, NAME_LENGTH
	call CopyBytes
.next_ot_name
	ld a, [REPAIR_MON]
	inc a
	cp 3
	jr c, .ot_name
	ret

SanitizeBoxMonIndex:
; The box's POKéMON REPAIR_MON's index, if it has none; carry if none could be
; found (it's taken out).
	call RepairIndexPlace
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call RepairCheckIndex
	ret nc
; its nickname, if a species' name
	ld a, [REPAIR_MON]
	ld hl, sBoxMonNicknames - sBox
	ld bc, MON_NAME_LENGTH
	call RepairBoxPlace
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ld de, 0
	farcall FindSpeciesByName
	jr c, .got_index
; its species byte, as the IDs were
	ld a, [REPAIR_MON]
	ld hl, sBoxMon1Species - sBox
	ld bc, BOXMON_STRUCT_LENGTH
	call RepairBoxPlace
	ld a, [hl]
	call .FromID
	jr nc, .got_index
; its species list's
	ld a, [REPAIR_MON]
	ld hl, sBoxSpecies - sBox
	ld bc, 1
	call RepairBoxPlace
	ld a, [hl]
	cp EGG
	jr z, .none
	call .FromID
	jr nc, .got_index
.none
	call RemoveRepairBoxMon
	scf
	ret

.got_index
	call RepairIndexPlace
	ld [hl], e
	inc hl
	ld [hl], d
	and a
	ret

.FromID:
; de: species ID a's index; carry if it's no species'
	call GetPokemonIndexFromID
	ld d, h
	ld e, l
	jp RepairCheckIndex

RemoveRepairBoxMon:
; The box's POKéMON REPAIR_MON out of it (those after it go up a place).
	ld hl, 0
	xor a
	call RepairBoxPlace
	dec [hl]
	ld hl, sBoxSpecies - sBox
	ld bc, 1
	ld e, MONS_PER_BOX + 1 ; (and its end)
	call .Shift
	ld hl, sBoxMons - sBox
	ld bc, BOXMON_STRUCT_LENGTH
	ld e, MONS_PER_BOX
	call .Shift
	ld hl, sBoxMonOTs - sBox
	ld bc, NAME_LENGTH
	ld e, MONS_PER_BOX
	call .Shift
	ld hl, sBoxMonNicknames - sBox
	ld bc, MON_NAME_LENGTH
	ld e, MONS_PER_BOX
	call .Shift
	call RepairIndexPlace
	ld bc, 2
	ld e, MONS_PER_BOX
	jr .ShiftAt

.Shift:
; e things bc long at the box's place hl: those after REPAIR_MON's go up a place
	ld a, [REPAIR_MON]
	call RepairBoxPlace
.ShiftAt:
; (hl: REPAIR_MON's)
	ld a, [REPAIR_MON]
	inc a
	cp e
	ret nc ; (none after it)
	ld d, a
	ld a, e
	sub d ; (how many after it)
	push hl
	add hl, bc
	push hl
	ld hl, 0
	call AddNTimes
	ld b, h
	ld c, l
	pop hl
	pop de
	jp CopyBytes

SanitizeBoxLevels:
; Each of the box's POKéMON's level: if not 1 to MAX_LEVEL, its EXP's.
	xor a
.mon
	ld [REPAIR_MON], a
	call RepairOpenBox
	call RepairBoxCount
	ld b, a
	ld a, [REPAIR_MON]
	cp b
	ret nc
	ld hl, sBoxMon1Level - sBox
	ld bc, BOXMON_STRUCT_LENGTH
	call RepairBoxPlace
	ld a, [hl]
	and a
	jr z, .level
	cp MAX_LEVEL + 1
	jr c, .next
.level
	ld a, [REPAIR_MON]
	ld hl, sBoxMon1Exp - sBox
	ld bc, BOXMON_STRUCT_LENGTH
	call RepairBoxPlace
	ld de, wTempMonExp
	ld bc, 3
	call CopyBytes
	call RepairIndexPlace
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call GetPokemonIDFromIndex
	ld [wTempMonSpecies], a
	farcall CalcLevel
	call RepairOpenBox ; (garbage collection could have closed it)
	ld a, [REPAIR_MON]
	ld hl, sBoxMon1Level - sBox
	ld bc, BOXMON_STRUCT_LENGTH
	call RepairBoxPlace
	ld [hl], d
.next
	ld a, [REPAIR_MON]
	inc a
	jr .mon

RepairOpenBox:
; The box's SRAM open; hl: the box
	ld a, [REPAIR_BANK]
	call OpenSRAM
	ld hl, REPAIR_BOX
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

RepairBoxCount:
; a: the box's count (keeps bc, de, hl)
	push hl
	ld hl, REPAIR_BOX
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	pop hl
	ret

RepairBoxPlace:
; hl: the box's place hl, then the a'th thing bc long there (keeps bc, de)
	push de
	push af
	ld a, [REPAIR_BOX]
	ld e, a
	ld a, [REPAIR_BOX + 1]
	ld d, a
	add hl, de
	pop af
	pop de
	jp AddNTimes

RepairIndexPlace:
; hl: the place of the box's POKéMON REPAIR_MON's index (keeps bc, de)
	ld hl, REPAIR_INDEXES
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [REPAIR_MON]
	add a
	add l
	ld l, a
	ret nc
	inc h
	ret

RepairCheckIndex:
; carry if de is no species' index (1 to NUM_POKEMON)
	ld a, d
	or e
	scf
	ret z
	ld a, LOW(NUM_POKEMON)
	sub e
	ld a, HIGH(NUM_POKEMON)
	sbc d
	ret

SanitizeParty::
; The party made sound: no more than PARTY_LENGTH, then its species list's end;
; each POKéMON's species byte one (from its nickname if a species' name, or its
; species list's), and its species list's the same (an EGG's aside); its level 1
; to MAX_LEVEL (its EXP's), and its stats then; its HP no more than its max; its
; names ended.
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH + 1
	jr c, .count_ok
	ld a, PARTY_LENGTH
	ld [hl], a
.count_ok
	ld c, a
	ld b, 0
	inc hl
	add hl, bc
	ld [hl], -1
	xor a
.mon
	ld [wCurPartyMon], a
	ld hl, wPartyCount
	cp [hl]
	ret nc
	call .Mon
	ld a, [wCurPartyMon]
	inc a
	jr .mon

.Mon:
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames + MON_NAME_LENGTH - 1
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	ld [hl], '@'
	ld a, [wCurPartyMon]
	ld hl, wPartyMonOTs + NAME_LENGTH - 1
	ld bc, NAME_LENGTH
	call AddNTimes
	ld [hl], '@'
	xor a
	ld [REPAIR_RESTAT], a
; its species byte
	call .StructSpecies
	call GetPokemonIndexFromID
	ld d, h
	ld e, l
	call RepairCheckIndex
	jr nc, .got_species
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ld de, 0
	farcall FindSpeciesByName
	jr c, .new_species
	call .ListSpecies
	cp EGG
	ret z ; (none to be had)
	call GetPokemonIndexFromID
	ld d, h
	ld e, l
	call RepairCheckIndex
	ret c ; (none to be had)
.new_species
	ld h, d
	ld l, e
	call GetPokemonIDFromIndex
	push af
	call .StructSpecies
	pop af
	ld [hl], a
	ld a, TRUE
	ld [REPAIR_RESTAT], a
.got_species
; its species list's (an EGG's aside)
	call .ListSpecies
	cp EGG
	jr z, .level
	push hl
	call .StructSpecies
	pop hl
	ld [hl], a
.level
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Level
	call GetPartyLocation
	ld a, [hl]
	and a
	jr z, .new_level
	cp MAX_LEVEL + 1
	jr c, .got_level
.new_level
	push hl
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Exp
	call GetPartyLocation
	ld de, wTempMonExp
	ld bc, 3
	call CopyBytes
	call .StructSpecies
	ld [wTempMonSpecies], a
	farcall CalcLevel
	pop hl
	ld [hl], d
	ld a, TRUE
	ld [REPAIR_RESTAT], a
.got_level
	ld a, [REPAIR_RESTAT]
	and a
	jr z, .hp
; its stats
	call .StructSpecies
	ld [wCurSpecies], a
	push hl
	call GetBaseData
	pop bc
	ld hl, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a
	ld hl, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	ld hl, MON_STAT_EXP - 1
	add hl, bc
	ld b, TRUE
	predef CalcMonStats
.hp
; its HP no more than its max
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1HP
	call GetPartyLocation
	ld d, h
	ld e, l
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1MaxHP
	call GetPartyLocation
	ld a, [de] ; (HP - max HP, big-endian)
	cp [hl]
	ret c
	jr nz, .max_hp
	inc de
	inc hl
	ld a, [de]
	cp [hl]
	dec de
	dec hl
	ret c
	ret z
.max_hp
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret

.StructSpecies:
; hl: its species byte; a: it
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Species
	call GetPartyLocation
	ld a, [hl]
	ret

.ListSpecies:
; hl: its species list's place; a: it
	ld a, [wCurPartyMon]
	ld e, a
	ld d, 0
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
	ret
