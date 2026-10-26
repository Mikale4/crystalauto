IsInArray::
; Find value a for every de bytes in array hl.
; Return index in b and carry if found.

	ld b, 0
	ld c, a
.loop
	ld a, [hl]
	cp -1
	jr z, .NotInArray
	cp c
	jr z, .InArray
	inc b
	add hl, de
	jr .loop

.NotInArray:
	and a
	ret

.InArray:
	scf
	ret

FindSpeciesInArray::
; Find species ID a's index in array hl: entries of de bytes, each starting with
; a species' index (dw), ending in -1. Return carry and hl at its entry if found;
; preserves bc, de.
	push bc
	push hl
	call GetPokemonIndexFromID
	ld b, h
	ld c, l
	pop hl
.loop
	ld a, [hli]
	cp c
	jr z, .check_high
	inc a
	jr nz, .next
	ld a, [hl]
	inc a
	jr z, .no ; -1: the end
.next
	dec hl
	add hl, de
	jr .loop

.check_high
	ld a, [hl]
	cp b
	jr nz, .next
	dec hl
	pop bc
	scf
	ret

.no
	dec hl
	pop bc
	and a
	ret

SkipNames::
; Skip a names.
	ld bc, NAME_LENGTH
	and a
	ret z
.loop
	add hl, bc
	dec a
	jr nz, .loop
	ret

AddNTimes::
; Add bc * a to hl.
	and a
	ret z
.loop
	add hl, bc
	dec a
	jr nz, .loop
	ret
