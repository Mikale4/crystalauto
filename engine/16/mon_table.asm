; 16-bit species indexes, after pokecrystal16 (https://github.com/vulcandth/pokecrystal16)
;
; Species have 16-bit indexes (the constants in constants/pokemon_constants.asm, what
; their data is in the order of), but memory and saves keep 8-bit IDs for them:
; wPokemonIndexTable has each ID's index (IDs $FD and up are special: EGG is $FD).
; An index is given an ID the first time it needs one (see GetPokemonIDFromIndex),
; and when every ID is in use, garbage collection takes back the ones nothing
; keeps (see MonIDPlaces).
;
; So the code never compares an ID with a species' constant (see the cpmon macro,
; IsMon and CheckMonInList), and data lists species by their indexes (dw).
; The boxes but the one out keep indexes (see SaveBox, LoadBox), in arrays of their
; own (sBox1PokemonIndexes...).
;
; The table is copied to SRAM as it changes, like the moves' (see
; engine/16/move_table.asm and SyncMonTableToSRAM).

REDEF ___conv_bitmap EQUS "wMonConversionBitmap"

DEF MON_TABLE_MAGIC_LENGTH EQU 3
DEF NUM_OLD_SAVE_POKEMON EQU CELEBI ; (a save from before 16-bit species: its IDs were the indexes)

_GetPokemonIndexFromID::
; in: a = ID; out: hl = index; preserves bc, de
	___conversion_table_load wPokemonIndexTable, MON_TABLE

_GetPokemonIDFromIndex::
; in: hl = index; out: a = ID; preserves bc, de
	push bc
	ldh a, [rSVBK]
	ld c, a
	ld a, BANK(wPokemonIndexTable)
	ldh [rSVBK], a
	ld a, [wPokemonIndexTableUsedSlots]
	ld b, a
	xor a
	ld [wMonTableChanged], a
	ld a, c
	ldh [rSVBK], a
	call StoreMonIndex
	push af
	ld a, BANK(wPokemonIndexTable)
	ldh [rSVBK], a
	ld a, [wMonTableChanged]
	and a
	jr nz, .collected
	ld a, [wPokemonIndexTableUsedSlots]
	cp b
	jr z, .done
; one new: just its entry
	pop af
	push af
	call SyncMonTableEntry
	jr .done

.collected
	call SyncMonTableToSRAM
.done
	ld a, c
	ldh [rSVBK], a
	pop af
	pop bc
	ret

StoreMonIndex:
	___conversion_table_store wPokemonIndexTable, MON_TABLE
	; fallthrough (the macro's .collect_garbage)

MonTableGarbageCollection:
; Free the IDs nothing keeps (see MonIDPlaces); with rSVBK =
; BANK(wPokemonIndexTable), which it keeps, and preserving de.
	push de
	___conversion_bitmap_initialize wPokemonIndexTable, MON_TABLE, .set_bit
	ldh a, [hSRAMBank]
	push af
	ld hl, MonIDPlaces
.place
	ld a, [hli]
	and a
	jr z, .places_done
	ld [wMonGCBank], a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld [wMonGCGroups], a
	ld a, [hli]
	ld [wMonGCGroupLength], a
	ld a, [hli]
	ld [wMonGCSkip], a
	push hl
	ld a, [wMonGCBank]
	bit MON_ID_PLACE_SRAM_F, a
	jr z, .group
	and $ff ^ (1 << MON_ID_PLACE_SRAM_F)
	call OpenSRAM
	ld a, BANK(wPokemonIndexTable)
	ld [wMonGCBank], a
.group
	ld a, [wMonGCGroupLength]
	ld [wMonGCCount], a
.id
	ld a, [wMonGCBank]
	ldh [rSVBK], a
	ld a, [de]
	ld c, a
	ld a, BANK(wPokemonIndexTable)
	ldh [rSVBK], a
	ld a, c
	call .set_bit
	inc de
	ld hl, wMonGCCount
	dec [hl]
	jr nz, .id
	ld a, [wMonGCSkip]
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	ld hl, wMonGCGroups
	dec [hl]
	jr nz, .group
	pop hl
	jr .place

.places_done
; and the box whose species bytes are read where it's kept, if any (see
; RefreshBoxSpecies)
	ld a, [wMonProtectedBox]
	and a
	jr z, .no_box
	call GetProtectedBoxPlace
	ld a, [hl]
	and a
	jr z, .no_box
	cp MONS_PER_BOX + 1
	jr nc, .no_box
	ld [wMonGCGroups], a
	ld [wMonGCCount], a
	ld d, h
	ld e, l
	push de
	inc de ; (its species list)
.box_list
	ld a, [de]
	call .set_bit
	inc de
	ld hl, wMonGCCount
	dec [hl]
	jr nz, .box_list
	pop hl
	ld de, sBoxMon1Species - sBox
	add hl, de
	ld d, h
	ld e, l
.box_mon
	ld a, [de]
	call .set_bit
	ld a, e
	add BOXMON_STRUCT_LENGTH
	ld e, a
	adc d
	sub e
	ld d, a
	ld hl, wMonGCGroups
	dec [hl]
	jr nz, .box_mon
.no_box
	pop af
	call OpenSRAM ; (as it was: closed if it was)
	___conversion_bitmap_free_unused wPokemonIndexTable, MON_TABLE
	ld a, TRUE
	ld [wMonTableChanged], a
	pop de
	ret

.set_bit
	___conversion_bitmap_set MON_TABLE

_LockPokemonID::
; in: h = ID (0 to clear), l = position (LOCKED_MON_ID_*)
	___conversion_table_lock_ID wPokemonIndexTable, MON_TABLE

DEF MON_ID_PLACE_SRAM_F EQU 7

MACRO mon_id_place
; the first ID, how many groups of IDs, how many IDs in a group (next to each
; other), from group to group; optionally, the SRAM symbol whose bank it's in
	if _NARG == 5
		db MON_IN_SRAM | BANK(\5)
	elif STRFIND("\1", "s") == 0
		db MON_IN_SRAM | BANK(\1)
	else
		db BANK(\1) + (BANK(\1) == 0) ; (WRAM0's 0: any WRAMX bank will do, but not 0, which ends the list)
	endc
	dw \1
	db \2, \3, (\4) - (\3)
ENDM

MACRO mon_ids
; the first ID, how many (next to each other); optionally, as mon_id_place's
	if _NARG == 3
		mon_id_place \1, 1, \2, \2, \3
	else
		mon_id_place \1, 1, \2, \2
	endc
ENDM

DEF MON_IN_SRAM EQU 1 << MON_ID_PLACE_SRAM_F

MACRO saved_mon_ids
; a save's (\1: sPokemonData or sBackupPokemonData)
	mon_ids \1 + (wPartySpecies - wPokemonData), PARTY_LENGTH, \1
	mon_id_place \1 + (wPartyMon1Species - wPokemonData), PARTY_LENGTH, 1, PARTYMON_STRUCT_LENGTH, \1
	mon_ids \1 + (wBreedMon1Species - wPokemonData), 1, \1
	mon_ids \1 + (wBreedMon2Species - wPokemonData), 1, \1
	mon_ids \1 + (wEggMonSpecies - wPokemonData), 1, \1
	mon_ids \1 + (wBugContestSecondPartySpecies - wPokemonData), 1, \1
	mon_ids \1 + (wContestMonSpecies - wPokemonData), 1, \1
	mon_id_place \1 + (wRoamMon1Species - wPokemonData), 3, 1, wRoamMon2 - wRoamMon1, \1
ENDM

MonIDPlaces:
; Everywhere that keeps species IDs, for garbage collection to keep them. (Places
; that only sometimes keep them are here too: what's there otherwise only keeps
; some IDs that could have been freed.)
	mon_ids wPartySpecies, PARTY_LENGTH
	mon_id_place wPartyMon1Species, PARTY_LENGTH, 1, PARTYMON_STRUCT_LENGTH
	mon_ids wOTPartySpecies, PARTY_LENGTH
	mon_id_place wOTPartyMon1Species, PARTY_LENGTH, 1, PARTYMON_STRUCT_LENGTH
	mon_ids wBreedMon1Species, 1
	mon_ids wBreedMon2Species, 1
	mon_ids wEggMonSpecies, 1
	mon_ids wBugContestSecondPartySpecies, 1
	mon_ids wContestMonSpecies, 1
	mon_id_place wRoamMon1Species, 3, 1, wRoamMon2 - wRoamMon1
	mon_ids wBufferMonSpecies, 1
	mon_ids wTempMonSpecies, 1
	mon_ids wBattleMonSpecies, 1
	mon_ids wEnemyMonSpecies, 1
	mon_ids wTempEnemyMonSpecies, 1
	mon_ids wTempBattleMonSpecies, 1
	mon_ids wTempWildMonSpecies, 1
	mon_ids wCurPartySpecies, 1
	mon_ids wCurSpecies, 1
	mon_ids wNamedObjectIndex, 1
	mon_ids wTempSpecies, 1
	mon_ids wBaseDexNo, 1
	mon_ids wEvolutionOldSpecies, 2 ; (and wEvolutionNewSpecies)
	mon_ids wPokeAnimSpecies, 1
	mon_ids wFollowerSpecies, 1
	mon_ids wDifficultySpecies, 1
	mon_ids wBossBattle, 1
	mon_ids wScriptVar, 1 ; (setmonval's)
	assert BOXLIST_SPECIES == 0
	mon_id_place wBillsPCPokemonList, MONS_PER_BOX_JP, 1, BOXLIST_SIZE ; (Bill's PC's)
	mon_id_place wBugContestFirstPlaceMon, 4, 1, wBugContestSecondPlaceMon - wBugContestFirstPlaceMon ; (and the temp)
	mon_ids wOddEggSpecies, 1
	mon_ids wPlayerTrademonSpecies, 1
	mon_ids wOTTrademonSpecies, 1
	mon_ids wLinkTradeSendmonSpecies, 2 ; (and wLinkTradeGetmonSpecies)
	mon_ids wStrengthSpecies, 1
	mon_id_place wBT_OTMon1Species, BATTLETOWER_PARTY_LENGTH, 1, wBT_OTMon2 - wBT_OTMon1
	mon_id_place wBT_OTTempMon1Species, BATTLETOWER_PARTY_LENGTH, 1, wBT_OTTempMon2 - wBT_OTTempMon1
	; the box out
	mon_ids sBoxSpecies, MONS_PER_BOX
	mon_id_place sBoxMon1Species, MONS_PER_BOX, 1, BOXMON_STRUCT_LENGTH
	; the BATTLE TOWER's last trainers' (so their next aren't the same)
	mon_ids sBTMonPrevTrainer1, BATTLETOWER_PARTY_LENGTH
	mon_ids sBTMonPrevPrevTrainer1, BATTLETOWER_PARTY_LENGTH
	; the saves (both: see SyncMonTableToSRAM)
	saved_mon_ids sPokemonData
	saved_mon_ids sBackupPokemonData
	db 0 ; end

SyncMonTableToSRAM:
; Copy wPokemonIndexTable's entries to SRAM, if they're this game's (see
; InitMonTable); with rSVBK = BANK(wPokemonIndexTable). Preserves bc, de.
	ld a, [wMonTableReady]
	and a
	ret z
	push bc
	push de
	ldh a, [hSRAMBank]
	push af
	ld a, BANK(sPokemonIndexTable)
	call OpenSRAM
	ld hl, MonTableMagic
	ld de, sPokemonIndexTableMagic
	ld bc, MON_TABLE_MAGIC_LENGTH
	call CopyBytes
	ld hl, wPokemonIndexTable
	ld de, sPokemonIndexTable
	ld bc, wPokemonIndexTableEntriesEnd - wPokemonIndexTable
	call CopyBytes
	pop af
	call OpenSRAM ; (as it was)
	pop de
	pop bc
	ret

SaveMonTable::
; (as the game's saved, though SRAM's table is kept the same as it changes)
	ldh a, [rSVBK]
	push af
	ld a, BANK(wPokemonIndexTable)
	ldh [rSVBK], a
	call SyncMonTableToSRAM
	pop af
	ldh [rSVBK], a
	ret

SyncMonTableEntry:
; Copy wPokemonIndexTable's first bytes and ID a's entry to SRAM, if it's this
; game's (see SyncMonTableToSRAM); with rSVBK = BANK(wPokemonIndexTable). Preserves
; bc, de.
	push de
	push bc
	ld c, a
	ld a, [wMonTableReady]
	and a
	jr z, .done
	ldh a, [hSRAMBank]
	ld b, a
	ld a, BANK(sPokemonIndexTable)
	call OpenSRAM
	ld a, [wPokemonIndexTableUsedSlots]
	ld [sPokemonIndexTable + (wPokemonIndexTableUsedSlots - wPokemonIndexTable)], a
	ld a, [wPokemonIndexTableLastAllocatedIndex]
	ld [sPokemonIndexTable + (wPokemonIndexTableLastAllocatedIndex - wPokemonIndexTable)], a
	ld a, c
	dec a
	ld l, a
	ld h, 0
	add hl, hl
	push hl
	ld de, wPokemonIndexTableEntries
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	push de
	ld de, sPokemonIndexTable + (wPokemonIndexTableEntries - wPokemonIndexTable)
	add hl, de
	pop de
	ld [hl], e
	inc hl
	ld [hl], d
	ld a, b
	call OpenSRAM ; (as it was)
.done
	pop bc
	pop de
	ret

; (1: from before MonTableGarbageCollection saw all of MonIDPlaces, see
; engine/16/repair_fused.asm)
DEF MON_TABLE_VERSION EQU 2

MonTableMagic:
	db "MN", MON_TABLE_VERSION
	assert @ - MonTableMagic == MON_TABLE_MAGIC_LENGTH

InitMonTable::
; At a new game, or the save's continue: wPokemonIndexTable as SRAM has it; or,
; with none, for the save SRAM has from before 16-bit species (its IDs are their
; indexes; its boxes get index arrays: see ConvertOldSaveSpecies); or for no save
; at all (empty).
	ldh a, [rSVBK]
	push af
	ld a, BANK(wPokemonIndexTable)
	ldh [rSVBK], a
	ld hl, wPokemonIndexTable
	ld bc, wPokemonIndexTableEnd - wPokemonIndexTable
	xor a
	ld [wMonTableReady], a
	ld [wMonProtectedBox], a
	ld [wMonRepairParty], a
	call ByteFill
	ld a, BANK(sPokemonIndexTableMagic)
	call OpenSRAM
	ld hl, sPokemonIndexTableMagic
	ld de, MonTableMagic
	ld c, MON_TABLE_MAGIC_LENGTH - 1
.check_magic
	ld a, [de]
	cp [hl]
	jr nz, .no_table
	inc de
	inc hl
	dec c
	jr nz, .check_magic
; its version: this one's, or 1's (to be repaired)
	ld a, [hl]
	cp MON_TABLE_VERSION
	jr z, .got_table
	cp 1
	jr nz, .no_table
	ld a, TRUE
	ld [wMonRepairParty], a
.got_table
	ld hl, sPokemonIndexTable
	ld de, wPokemonIndexTable
	ld bc, wPokemonIndexTableEntriesEnd - wPokemonIndexTable
	call CopyBytes
	call CloseSRAM
	ld a, [wMonRepairParty]
	and a
	jr z, .ready
	farcall RepairFusedBoxes ; (and the party once it's loaded: see Continue)
	jr .ready

.no_table
	call CloseSRAM
	call CheckOldSave ; (see engine/16/move_table.asm)
	jr nc, .ready
; every ID stands for the index it is
	ld hl, wPokemonIndexTableEntries
	ld c, 1
.identity
	ld a, c
	ld [hli], a
	ld [hl], 0
	inc hl
	inc c
	ld a, c
	cp NUM_OLD_SAVE_POKEMON + 1
	jr c, .identity
	ld a, NUM_OLD_SAVE_POKEMON
	ld [wPokemonIndexTableUsedSlots], a
	call ConvertOldSaveSpecies

.ready
	ld a, TRUE
	ld [wMonTableReady], a
	call SyncMonTableToSRAM
	pop af
	ldh [rSVBK], a
	ret

ConvertOldSaveSpecies:
; A save from before 16-bit species: every box gets its index array (an ID was
; the index), and the save's new Pokédex flags (see wPokedexCaughtExt) are none.
	ld hl, BoxIndexArrays
	ld c, NUM_BOXES
.box
	push bc
	ld a, [hli]
	call OpenSRAM
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a ; the box
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a ; its index array
	push hl
	ld a, [de]
	cp MONS_PER_BOX + 1
	jr c, .count_ok
	xor a
.count_ok
	ld [wMonGCCount], a
	ld hl, sBoxMon1Species - sBox
	add hl, de
	ld e, MONS_PER_BOX
.mon
	ld a, [wMonGCCount]
	and a
	jr z, .empty
	dec a
	ld [wMonGCCount], a
	ld a, [hl] ; (the species, as its index)
	jr .got_index

.empty
	xor a
.got_index
	ld [bc], a
	inc bc
	xor a
	ld [bc], a
	inc bc
	push de
	ld de, BOXMON_STRUCT_LENGTH
	add hl, de
	pop de
	dec e
	jr nz, .mon
	pop hl
	pop bc
	dec c
	jr nz, .box
; the new Pokédex flags
	ld a, BANK(sPokemonData)
	call OpenSRAM
	ld hl, sPokemonData + (wPokedexCaughtExt - wPokemonData)
	ld bc, wPokedexCaughtExtEnd - wPokedexCaughtExt
	xor a
	call ByteFill
	ld hl, sPokemonData + (wPokedexSeenExt - wPokemonData)
	ld bc, wPokedexSeenExtEnd - wPokedexSeenExt
	xor a
	call ByteFill
	ld a, BANK(sBackupPokemonData)
	call OpenSRAM
	ld hl, sBackupPokemonData + (wPokedexCaughtExt - wPokemonData)
	ld bc, wPokedexCaughtExtEnd - wPokedexCaughtExt
	xor a
	call ByteFill
	ld hl, sBackupPokemonData + (wPokedexSeenExt - wPokemonData)
	ld bc, wPokedexSeenExtEnd - wPokedexSeenExt
	xor a
	call ByteFill
	jp CloseSRAM

BoxIndexArrays::
; each box: its bank and place, then its index array's place (the same bank)
	table_width 5
for n, 1, NUM_BOXES + 1
	dba sBox{d:n}
	dw sBox{d:n}PokemonIndexes
	assert BANK(sBox{d:n}) == BANK(sBox{d:n}PokemonIndexes)
endr
	assert_table_length NUM_BOXES

GetBoxIndexArray:
; in: a = a box (0 to NUM_BOXES - 1); out: b = its index array's SRAM bank, de =
; the array; preserves c
	push hl
	ld l, a
	ld h, 0
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, de ; x 5
	ld de, BoxIndexArrays
	add hl, de
	ld b, [hl] ; (dba: the bank, then the box's place)
	inc hl
	inc hl
	inc hl
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	ret

SaveBoxSpeciesIndexes::
; Box wCurBox's index array from sBox (the box out, which keeps IDs): its
; POKéMON's species' 16-bit indexes (0 past its count).
	ldh a, [rSVBK]
	push af
	ld a, [wCurBox] ; (read before rSVBK changes)
	push af
	ld a, BANK(wBoxIndexBuffer)
	ldh [rSVBK], a
	ld a, BANK(sBox)
	call OpenSRAM
	ld a, [sBoxCount]
	cp MONS_PER_BOX + 1
	jr c, .count_ok
	xor a
.count_ok
	ld b, a
	ld c, 0
	ld de, wBoxIndexBuffer
.mon
	ld hl, 0
	ld a, c
	cp b
	jr nc, .got_index
	push bc
	push de
	ld hl, sBoxMon1Species
	ld bc, BOXMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hl]
	call _GetPokemonIndexFromID
	pop de
	pop bc
.got_index
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de
	inc c
	ld a, c
	cp MONS_PER_BOX
	jr c, .mon
; to the box's array
	pop af ; (wCurBox)
	call GetBoxIndexArray
	ld a, b
	call OpenSRAM
	ld hl, wBoxIndexBuffer
	ld bc, 2 * MONS_PER_BOX
	call CopyBytes
	call CloseSRAM
	pop af
	ldh [rSVBK], a
	ret

RefreshBoxSpecies::
; Box b (1 to NUM_BOXES): its species bytes, where it's kept, made the IDs of its
; species again (from its index array: what's there can be stale, see
; SaveBoxSpeciesIndexes), so they can be read; garbage collection keeps them
; (see wMonProtectedBox) till another box is. (For farcall; keeps SRAM as it was.)
	ldh a, [hSRAMBank]
	push af
	push bc
	push de
	push hl
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMonProtectedBox)
	ldh [rSVBK], a
	ld a, b
	and a
	jr z, .done
	cp NUM_BOXES + 1
	jr nc, .done
	ld [wMonProtectedBox], a
	dec a
	call GetBoxIndexArray ; b: the bank, de: the array
	ld a, b
	call OpenSRAM
	ld h, d
	ld l, e
	ld de, wBoxIndexBuffer
	ld bc, 2 * MONS_PER_BOX
	call CopyBytes
	call GetProtectedBoxPlace ; hl: the box
	ld a, [hl]
	and a
	jr z, .done
	cp MONS_PER_BOX + 1
	jr nc, .done
	ld b, a
; first, no IDs (so the stale ones don't keep theirs through garbage collection)
	push hl
	push bc
	ld de, sBoxMon1Species - sBox
	add hl, de
	ld de, BOXMON_STRUCT_LENGTH
.clear
	ld [hl], 0
	add hl, de
	dec b
	jr nz, .clear
	pop bc
	pop hl
	push hl
	push bc
	inc hl ; (its species list)
.clear_list
	ld a, [hl]
	cp EGG
	jr z, .clear_next
	ld [hl], 0
.clear_next
	inc hl
	dec b
	jr nz, .clear_list
	pop bc
	pop hl
; then each one's
	ld c, 0
.mon
	push bc
	push hl
	ld hl, wBoxIndexBuffer
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call _GetPokemonIDFromIndex
	ld e, a
	pop hl
	pop bc
	push bc
	push hl
	ld b, 0
	inc hl
	add hl, bc ; (its species list's)
	ld a, [hl]
	cp EGG
	jr z, .egg
	ld [hl], e
.egg
	pop hl
	push hl
	ld a, c
	ld bc, sBoxMon1Species - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	call AddNTimes
	ld [hl], e
	pop hl
	pop bc
	inc c
	ld a, c
	cp b
	jr c, .mon
.done
	pop af
	ldh [rSVBK], a
	pop hl
	pop de
	pop bc
	pop af
	call OpenSRAM ; (as it was)
	ret

GetProtectedBoxPlace:
; out: hl = the place of box wMonProtectedBox (1 to NUM_BOXES), with its SRAM
; open; preserves bc, de
	push bc
	ld a, [wMonProtectedBox]
	dec a
	ld l, a
	ld h, 0
	ld b, h
	ld c, l
	add hl, hl
	add hl, hl
	add hl, bc ; x 5
	ld bc, BoxIndexArrays
	add hl, bc
	ld a, [hli]
	call OpenSRAM
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc
	ret

_CountPokedexCaught::
; (see CountPokedexCaught)
	ld hl, wPokedexCaught
	ld bc, wPokedexCaughtExt
	jr CountPokedexFlags

_CountPokedexSeen::
; (see CountPokedexSeen)
	ld hl, wPokedexSeen
	ld bc, wPokedexSeenExt
CountPokedexFlags:
	ld de, 0
	push bc
	ld b, wEndPokedexCaught - wPokedexCaught
	call .count
	pop hl
	ld b, NUM_POKEDEX_EXT_BYTES
	call .count
	ld hl, wPokedexNumberBuffer
	ld a, d
	ld [hli], a
	ld [hl], e
	ld a, d
	and a
	ld a, e
	jr z, .got_count
	ld a, $ff
.got_count
	ld [wNumSetBits], a
	ret

.count
; de += the set bits of b bytes at hl
	ld a, [hli]
.bit
	and a
	jr z, .next
	srl a
	jr nc, .bit
	inc de
	jr .bit
.next
	dec b
	jr nz, .count
	ret
