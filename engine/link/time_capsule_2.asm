ConvertMon_2to1:
; Takes the Gen 2 Pokemon number stored in wTempSpecies,
; finds it in the Pokered_MonIndices table,
; and returns its index in wTempSpecies (0 if it isn't there).
	push bc
	push de
	push hl
	ld a, [wTempSpecies]
	call GetPokemonIndexFromID
	ld b, h
	ld c, l
	ld e, 0
	ld hl, Pokered_MonIndices
.loop
	inc e
	ld a, e
	cp NUM_GEN1_ORDER_MONS + 1
	jr nc, .not_found
	ld a, [hli]
	cp c
	ld a, [hli]
	jr nz, .loop
	cp b
	jr nz, .loop
	ld a, e
	jr .done

.not_found
	xor a
.done
	ld [wTempSpecies], a
	pop hl
	pop de
	pop bc
	ret

ConvertMon_1to2:
; Takes the Gen 1 Pokemon number stored in wTempSpecies
; and returns the corresponding value from Pokered_MonIndices in wTempSpecies.
	push bc
	push hl
	ld a, [wTempSpecies]
	dec a
	ld hl, Pokered_MonIndices
	ld b, 0
	ld c, a
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call GetPokemonIDFromIndex
	ld [wTempSpecies], a
	pop hl
	pop bc
	ret

INCLUDE "data/pokemon/gen1_order.asm"
