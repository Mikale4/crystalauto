
; Moves' data, and the 8-bit IDs moves' and species' 16-bit indexes have, are in
; "Move Data" (see engine/16/move_table.asm and engine/16/mon_table.asm): these
; reach them from any bank.

GetMoveIndexFromID::
; in: a = 8-bit move ID; out: hl = its 16-bit index; preserves bc, de
	push de
	ld de, _GetMoveIndexFromID
	jr MoveDataCallPopDE

GetMoveIDFromIndex::
; in: hl = 16-bit move index; out: a = its 8-bit ID (given it one if it had none); preserves bc, de
	push de
	ld de, _GetMoveIDFromIndex
	jr MoveDataCallPopDE

GetPokemonIndexFromID::
; in: a = 8-bit species ID; out: hl = its 16-bit index; preserves bc, de
	push de
	ld de, _GetPokemonIndexFromID
	jr MoveDataCallPopDE

GetPokemonIDFromIndex::
; in: hl = 16-bit species index; out: a = its 8-bit ID (given it one if it had none); preserves bc, de
	push de
	ld de, _GetPokemonIDFromIndex
	jr MoveDataCallPopDE

LockPokemonID::
; in: h = species ID (0 to clear), l = position (LOCKED_MON_ID_*)
	push de
	ld de, _LockPokemonID
	jr MoveDataCallPopDE

GetMoveAttribute::
; in: a = an attribute (MOVE_EFFECT, MOVE_POWER...), l = move ID; out: a = the move's; preserves bc, de
	push de
	ld de, _GetMoveAttribute
	; fallthrough

MoveDataCallPopDE:
	call MoveDataCall
	pop de
	ret

GetMoveData::
; Copy move a's struct to de (MOVE_LENGTH bytes: its MOVE_ANIM is a, its ID).
	ld [de], a
	inc de
	push de
	ld de, _GetMoveAddress
	call MoveDataCall
	pop de
	ld a, BANK(Moves)
	ld bc, MOVE_LENGTH - 1
	jp FarCopyBytes

GetMoveName::
; Move [wNamedObjectIndex]'s name in wStringBuffer1, at de; preserves bc, hl
	push hl
	push bc
	ld a, [wNamedObjectIndex]
	ld [wCurSpecies], a
	ld de, _GetMoveName
	call MoveDataCall
	pop bc
	pop hl
	ld de, wStringBuffer1
	ret

MoveDataCall:
; Call de in "Move Data" with a, bc and hl, returning them.
	ldh [hTempBank], a
	ldh a, [hROMBank]
	push af
	ld a, BANK(_GetMoveIndexFromID)
	rst Bankswitch
	ldh a, [hTempBank]
	call .de
	ldh [hTempBank], a
	pop af
	rst Bankswitch
	ldh a, [hTempBank]
	ret

.de
	push de
	ret

IsMon::
; z if species ID a is the species whose index is the dw after the call (which it
; returns past: see the cpmon macro); preserves a, bc, de, hl
	push hl
	push de
	push af
	call GetPokemonIndexFromID
	jr IsIndex

IsMove::
; z if move ID a is the move whose index is the dw after the call (which it
; returns past: see the cpmove macro); preserves a, bc, de, hl
	push hl
	push de
	push af
	call GetMoveIndexFromID
IsIndex:
	ld d, h
	ld e, l
	ld hl, sp + 6 ; the return address: the index to compare
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hli]
	xor e
	ld e, a
	ld a, [hli]
	xor d
	or e
	ld e, a ; 0: the same move
	ld a, l
	ld d, h
	ld hl, sp + 6
	ld [hli], a
	ld [hl], d
	ld hl, sp + 0 ; the flags that pop af returns
	ld a, [hl]
	res 7, a ; Z
	inc e
	dec e
	jr nz, .done
	set 7, a
.done
	ld [hl], a
	pop af
	pop de
	pop hl
	ret

CheckMonInList::
; carry if species ID a's index is in list hl (dw, ending in -1); preserves a, bc, de, hl
	push hl
	push bc
	push de
	push af
	push hl
	call GetPokemonIndexFromID
	jr CheckIndexInList

CheckMoveInList::
; carry if move ID a's index is in list hl (dw, ending in -1); preserves a, bc, de, hl
	push hl
	push bc
	push de
	push af
	push hl
	call GetMoveIndexFromID
CheckIndexInList:
	ld d, h
	ld e, l
	pop hl
.loop
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	and c
	inc a
	jr z, .no ; -1: the end
	ld a, c
	cp e
	jr nz, .loop
	ld a, b
	cp d
	jr nz, .loop
	pop af
	scf
	jr .done

.no
	pop af
	and a
.done
	pop de
	pop bc
	pop hl
	ret

IsMoveInFarList::
; carry if move index de is in list a:hl (dw, ending in -1); preserves bc, de, hl
	push hl
	push bc
	ld b, a
	ldh a, [hROMBank]
	ld c, a
	ld a, b
	rst Bankswitch
.loop
	ld a, [hli]
	ld b, a
	ld a, [hli]
	cp d
	jr nz, .next
	ld a, b
	cp e
	jr z, .yes
	ld a, d
.next
	and b
	inc a
	jr nz, .loop ; (-1: the end)
	ld a, c
	rst Bankswitch
	pop bc
	pop hl
	and a
	ret

.yes
	ld a, c
	rst Bankswitch
	pop bc
	pop hl
	scf
	ret

CheckMoveIDValid::
; carry if move ID a is a move's (its index from 1 to NUM_ATTACKS); preserves a,
; bc, de, hl
	push hl
	push af
	call GetMoveIndexFromID
	ld a, h
	or l
	jr z, .no
	ld a, l
	sub LOW(NUM_ATTACKS + 1)
	ld a, h
	sbc HIGH(NUM_ATTACKS + 1)
	jr nc, .no
	pop hl
	ld a, h
	pop hl
	scf
	ret

.no
	pop hl
	ld a, h
	pop hl
	and a
	ret
