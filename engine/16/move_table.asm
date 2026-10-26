; 16-bit move indexes, after pokecrystal16 (https://github.com/vulcandth/pokecrystal16)
;
; Moves have 16-bit indexes (the constants in constants/move_constants.asm, what
; move data is in the order of), but memory and saves keep 8-bit IDs for them:
; wMoveIndexTable has each ID's index. An index is given an ID the first time it
; needs one (see GetMoveIDFromIndex), and when every ID is in use, garbage
; collection takes back the ones nothing keeps (see MoveIDPlaces).
;
; So the code never compares an ID with a move's constant (see the cpmove macro,
; IsMove and CheckMoveInList), and data lists moves by their indexes (dw).
; The boxes but the one out keep indexes too (see BillsPC_ConvertBoxData).
;
; The table is copied to SRAM as it changes (see SyncMoveTableToSRAM): what the
; saves (both, and in SRAM, see MoveIDPlaces) keep is never taken back, so SRAM's
; table is always theirs.

INCLUDE "engine/16/macros.asm"

REDEF ___conv_bitmap EQUS "wConversionTableBitmap"

DEF MOVE_TABLE_MAGIC_LENGTH EQU 3

_GetMoveIndexFromID::
; in: a = ID; out: hl = index; preserves bc, de
	___conversion_table_load wMoveIndexTable, MOVE_TABLE

_GetMoveIDFromIndex::
; in: hl = index; out: a = ID; preserves bc, de
	push bc
	ldh a, [rSVBK]
	ld c, a
	ld a, BANK(wMoveIndexTable)
	ldh [rSVBK], a
	ld a, [wMoveIndexTableUsedSlots]
	ld b, a
	xor a
	ld [wMoveTableChanged], a
	ld a, c
	ldh [rSVBK], a
	call StoreMoveIndex
	push af
	ld a, BANK(wMoveIndexTable)
	ldh [rSVBK], a
	ld a, [wMoveTableChanged]
	and a
	jr nz, .collected
	ld a, [wMoveIndexTableUsedSlots]
	cp b
	jr z, .done
; one new: just its entry
	pop af
	push af
	call SyncMoveTableEntry
	jr .done

.collected
	call SyncMoveTableToSRAM
.done
	ld a, c
	ldh [rSVBK], a
	pop af
	pop bc
	ret

StoreMoveIndex:
	___conversion_table_store wMoveIndexTable, MOVE_TABLE
	; fallthrough (the macro's .collect_garbage)

MoveTableGarbageCollection:
; Free the IDs nothing keeps (see MoveIDPlaces); with rSVBK = BANK(wMoveIndexTable),
; which it keeps, and preserving de.
	push de
	___conversion_bitmap_initialize wMoveIndexTable, MOVE_TABLE, .set_bit
	ldh a, [hSRAMBank]
	push af
	ld hl, MoveIDPlaces
.place
	ld a, [hli]
	and a
	jr z, .places_done
	ld [wMoveGCBank], a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld [wMoveGCGroups], a
	ld a, [hli]
	ld [wMoveGCGroupLength], a
	ld a, [hli]
	ld [wMoveGCSkip], a
	push hl
	ld a, [wMoveGCBank]
	bit MOVE_ID_PLACE_SRAM_F, a
	jr z, .group
	and $ff ^ (1 << MOVE_ID_PLACE_SRAM_F)
	call OpenSRAM
	ld a, BANK(wMoveIndexTable)
	ld [wMoveGCBank], a
.group
	ld a, [wMoveGCGroupLength]
	ld [wMoveGCCount], a
.id
	ld a, [wMoveGCBank]
	ldh [rSVBK], a
	ld a, [de]
	ld c, a
	ld a, BANK(wMoveIndexTable)
	ldh [rSVBK], a
	ld a, c
	call .set_bit
	inc de
	ld hl, wMoveGCCount
	dec [hl]
	jr nz, .id
	ld a, [wMoveGCSkip]
	add e
	ld e, a
	adc d
	sub e
	ld d, a
	ld hl, wMoveGCGroups
	dec [hl]
	jr nz, .group
	pop hl
	jr .place

.places_done
	pop af
	call OpenSRAM ; (as it was: closed if it was)
	___conversion_bitmap_free_unused wMoveIndexTable, MOVE_TABLE
	ld a, TRUE
	ld [wMoveTableChanged], a
	pop de
	ret

.set_bit
	___conversion_bitmap_set MOVE_TABLE

_LockMoveID::
; in: h = ID (0 to clear), l = position (LOCKED_MOVE_ID_*)
	___conversion_table_lock_ID wMoveIndexTable, MOVE_TABLE

DEF MOVE_ID_PLACE_SRAM_F EQU 7

MACRO move_id_place
; where (a WRAM bank, or SRAM | an SRAM bank), the first ID, how many groups
; of IDs, how many IDs in a group (next to each other), from group to group
	db \1
	dw \2
	db \3, \4, (\5) - (\4)
ENDM

MACRO move_ids
; where, the first ID, how many (next to each other)
	move_id_place \1, \2, 1, \3, \3
ENDM

DEF IN_SRAM EQU 1 << MOVE_ID_PLACE_SRAM_F

MACRO saved_move_ids
; a save's (\1: sPokemonData or sBackupPokemonData)
	move_id_place IN_SRAM | BANK(\1), \1 + (wPartyMon1Moves - wPokemonData), PARTY_LENGTH, NUM_MOVES, PARTYMON_STRUCT_LENGTH
	move_ids IN_SRAM | BANK(\1), \1 + (wBreedMon1Moves - wPokemonData), NUM_MOVES
	move_ids IN_SRAM | BANK(\1), \1 + (wBreedMon2Moves - wPokemonData), NUM_MOVES
	move_ids IN_SRAM | BANK(\1), \1 + (wEggMonMoves - wPokemonData), NUM_MOVES
	move_ids IN_SRAM | BANK(\1), \1 + (wContestMonMoves - wPokemonData), NUM_MOVES
ENDM

MoveIDPlaces:
; Everywhere that keeps move IDs, for garbage collection to keep them. (Places
; that only sometimes keep them are here too: what's there otherwise only keeps
; some IDs that could have been freed.)
	move_id_place 1, wPartyMon1Moves, PARTY_LENGTH, NUM_MOVES, PARTYMON_STRUCT_LENGTH
	move_id_place 1, wOTPartyMon1Moves, PARTY_LENGTH, NUM_MOVES, PARTYMON_STRUCT_LENGTH
	move_ids 1, wBreedMon1Moves, NUM_MOVES
	move_ids 1, wBreedMon2Moves, NUM_MOVES
	move_ids 1, wEggMonMoves, NUM_MOVES
	move_ids 1, wContestMonMoves, NUM_MOVES
	move_ids 1, wBufferMonMoves, NUM_MOVES
	move_ids 1, wTempMonMoves, NUM_MOVES
	move_ids 1, wBattleMonMoves, NUM_MOVES
	move_ids 1, wEnemyMonMoves, NUM_MOVES
	move_ids 1, wWildMonMoves, NUM_MOVES
	move_ids 1, wPlayerUsedMoves, NUM_MOVES
	move_ids 1, wListMoves_MoveIndicesBuffer, NUM_MOVES
	move_ids 1, wOddEggMoves, NUM_MOVES
	move_ids 1, wNamedObjectIndex, 1
	move_ids 1, wCurSpecies, 1
	move_ids 1, wCurPlayerMove, 1
	move_ids 1, wCurEnemyMove, 1
	move_ids 1, wDisabledMove, 1
	move_ids 1, wEnemyDisabledMove, 1
	move_ids 1, wUnusedPlayerLockedMove, 1
	move_ids 1, wLastPlayerMove, 1
	move_ids 1, wLastEnemyMove, 1
	move_ids 1, wLastPlayerCounterMove, 1
	move_ids 1, wLastEnemyCounterMove, 1
	move_ids 1, wPlayerTrappingMove, 1
	move_ids 1, wEnemyTrappingMove, 1
	move_ids 1, wPlayerMoveStructAnimation, 1
	move_ids 1, wEnemyMoveStructAnimation, 1
	move_ids 1, wPutativeTMHMMove, 1
	move_ids 1, wTempTMHM, 1
	move_ids 1, wMenuSelection, 1
	; auto battle (see engine/battle/auto_battle.asm and AutoMove)
	move_ids 1, wABMove + MOVE_ANIM, 1
	move_ids 1, wABFoeMoves, NUM_MOVES
	move_ids 1, wABCandidateMoves, NUM_MOVES
	move_ids 1, wAutoMoveBackup + 1, 2 ; (the move, and its struct's MOVE_ANIM)
	; EXTREME trainers' movesets as they're worked out (see engine/battle/extreme_trainers.asm)
	move_ids 1, wBattleScriptBuffer, 27
	; the move reminder and tutor (see engine/events/move_relearner.asm)
	move_ids 1, wMoveRelearnerMoves, MAX_RELEARNER_MOVES
	; the Demo (see engine/demo/demo.asm)
	move_ids BANK(wDemoTutorMove), wDemoTutorMove, 1
	; the Battle Tower's trainer
	move_id_place 1, wBT_OTTempMon1Moves, BATTLETOWER_PARTY_LENGTH, NUM_MOVES, wBT_OTTempMon2 - wBT_OTTempMon1
	move_id_place BANK(wBT_OTMon1Moves), wBT_OTMon1Moves, BATTLETOWER_PARTY_LENGTH, NUM_MOVES, wBT_OTMon2 - wBT_OTMon1
	; the box out
	move_id_place IN_SRAM | BANK(sBox), sBoxMon1Moves, MONS_PER_BOX, NUM_MOVES, BOXMON_STRUCT_LENGTH
	; the saves (both: see SyncMoveTableToSRAM)
	saved_move_ids sPokemonData
	saved_move_ids sBackupPokemonData
	db 0 ; end

SyncMoveTableToSRAM:
; Copy wMoveIndexTable's entries to SRAM, if they're this game's (see
; InitMoveTable); with rSVBK = BANK(wMoveIndexTable). Preserves bc, de.
	ld a, [wMoveTableReady]
	and a
	ret z
	push bc
	push de
	ldh a, [hSRAMBank]
	push af
	ld a, BANK(sMoveIndexTable)
	call OpenSRAM
	ld hl, MoveTableMagic
	ld de, sMoveIndexTableMagic
	ld bc, MOVE_TABLE_MAGIC_LENGTH
	call CopyBytes
	ld hl, wMoveIndexTable
	ld de, sMoveIndexTable
	ld bc, wMoveIndexTableEntriesEnd - wMoveIndexTable
	call CopyBytes
	pop af
	call OpenSRAM ; (as it was)
	pop de
	pop bc
	ret

SaveMoveTable::
; (as the game's saved, though SRAM's table is kept the same as it changes)
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMoveIndexTable)
	ldh [rSVBK], a
	call SyncMoveTableToSRAM
	pop af
	ldh [rSVBK], a
	ret

SyncMoveTableEntry:
; Copy wMoveIndexTable's first bytes and ID a's entry to SRAM, if it's this
; game's (see SyncMoveTableToSRAM); with rSVBK = BANK(wMoveIndexTable). Preserves
; bc, de.
	push de
	push bc
	ld c, a
	ld a, [wMoveTableReady]
	and a
	jr z, .done
	ldh a, [hSRAMBank]
	ld b, a
	ld a, BANK(sMoveIndexTable)
	call OpenSRAM
	ld a, [wMoveIndexTableUsedSlots]
	ld [sMoveIndexTable + (wMoveIndexTableUsedSlots - wMoveIndexTable)], a
	ld a, [wMoveIndexTableLastAllocatedIndex]
	ld [sMoveIndexTable + (wMoveIndexTableLastAllocatedIndex - wMoveIndexTable)], a
	ld a, c
	dec a
	ld l, a
	ld h, 0
	add hl, hl
	push hl
	ld de, wMoveIndexTableEntries
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	push de
	ld de, sMoveIndexTable + (wMoveIndexTableEntries - wMoveIndexTable)
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

MoveTableMagic:
	db "MV", 1
	assert @ - MoveTableMagic == MOVE_TABLE_MAGIC_LENGTH

InitMoveTable::
; At a new game, or the save's continue: wMoveIndexTable as SRAM has it; or, with
; none, for the save SRAM has from before 16-bit moves (its IDs are their indexes;
; its boxes get the 16-bit indexes: see ConvertOldSaveBoxes); or for no save at
; all (empty).
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMoveIndexTable)
	ldh [rSVBK], a
	ld hl, wMoveIndexTable
	ld bc, wMoveIndexTableEnd - wMoveIndexTable
	xor a
	ld [wMoveTableReady], a
	call ByteFill
	ld a, BANK(sMoveIndexTableMagic)
	call OpenSRAM
	ld hl, sMoveIndexTableMagic
	ld de, MoveTableMagic
	ld c, MOVE_TABLE_MAGIC_LENGTH
.check_magic
	ld a, [de]
	cp [hl]
	jr nz, .no_table
	inc de
	inc hl
	dec c
	jr nz, .check_magic
	ld hl, sMoveIndexTable
	ld de, wMoveIndexTable
	ld bc, wMoveIndexTableEntriesEnd - wMoveIndexTable
	call CopyBytes
	call CloseSRAM
	jr .ready

.no_table
	call CloseSRAM
	call CheckOldSave
	jr nc, .ready
; every ID stands for the index it is
	ld hl, wMoveIndexTableEntries
	ld c, 1
.identity
	ld a, c
	ld [hli], a
	ld [hl], 0
	inc hl
	inc c
	ld a, c
	cp MOVE_TABLE_ENTRIES + 1
	jr c, .identity
	ld a, MOVE_TABLE_ENTRIES
	ld [wMoveIndexTableUsedSlots], a
	call ConvertOldSaveBoxes

.ready
	ld a, TRUE
	ld [wMoveTableReady], a
	call SyncMoveTableToSRAM
	pop af
	ldh [rSVBK], a
	ret

CheckOldSave:
; carry if SRAM has a save (or its backup)
	ld a, BANK(sCheckValue1) ; aka BANK(sCheckValue2)
	call OpenSRAM
	ld a, [sCheckValue1]
	cp SAVE_CHECK_VALUE_1
	jr nz, .backup
	ld a, [sCheckValue2]
	cp SAVE_CHECK_VALUE_2
	jr z, .yes
.backup
	ld a, BANK(sBackupCheckValue1) ; aka BANK(sBackupCheckValue2)
	call OpenSRAM
	ld a, [sBackupCheckValue1]
	cp SAVE_CHECK_VALUE_1
	jr nz, .no
	ld a, [sBackupCheckValue2]
	cp SAVE_CHECK_VALUE_2
	jr nz, .no
.yes
	call CloseSRAM
	scf
	ret

.no
	call CloseSRAM
	and a
	ret

ConvertOldSaveBoxes:
; The boxes (all of them: the box out is loaded from its as the game's loaded)
; keep their moves' 16-bit indexes, the high bits in their PP (see
; BillsPC_ConvertBoxData): before 16-bit moves, an ID was the index, so those are 0.
	ld hl, .Boxes
	ld c, NUM_BOXES
.box
	push bc
	ld a, [hli]
	call OpenSRAM
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld a, [de]
	and a
	jr z, .next_box
	cp MONS_PER_BOX + 1
	jr nc, .next_box
	ld b, a
	ld hl, sBoxMon1PP - sBox
	add hl, de
	ld de, BOXMON_STRUCT_LENGTH - NUM_MOVES
.mon
	ld c, NUM_MOVES
.pp
	ld a, [hl]
	and PP_UP_MASK
	ld [hli], a
	dec c
	jr nz, .pp
	add hl, de
	dec b
	jr nz, .mon
.next_box
	pop hl
	pop bc
	dec c
	jr nz, .box
	jp CloseSRAM

.Boxes:
	table_width 3
for n, 1, NUM_BOXES + 1
	dba sBox{d:n}
endr
	assert_table_length NUM_BOXES

_GetMoveAddress::
; in: a = ID; out: hl = its data in Moves (without MOVE_ANIM); preserves bc, de
	push de
	call _GetMoveIndexFromID
	dec hl
	assert MOVE_LENGTH - 1 == 6
	ld d, h
	ld e, l
	add hl, hl
	add hl, de
	add hl, hl
	ld de, Moves
	add hl, de
	pop de
	ret

_GetMoveAttribute::
; in: a = attribute (MOVE_EFFECT, MOVE_POWER...), l = ID; out: a; preserves bc, de
	push bc
	ld c, a
	ld a, l
	inc c
	dec c
	jr z, .done ; MOVE_ANIM: the ID
	call _GetMoveAddress
	dec c ; (no MOVE_ANIM)
	ld b, 0
	add hl, bc
	ld a, [hl]
.done
	pop bc
	ret

_GetMoveName::
; in: a = ID; copy its name to wStringBuffer1
	call _GetMoveIndexFromID
	ld b, h
	ld c, l
	ld hl, MoveNames
.next
	ld a, b
	or c
	jr z, .copy
	dec bc
	ld a, b
	or c
	jr z, .copy
.skip
	ld a, [hli]
	cp '@'
	jr nz, .skip
	jr .next

.copy
	ld de, wStringBuffer1
	ld bc, MOVE_NAME_LENGTH
	jp CopyBytes
