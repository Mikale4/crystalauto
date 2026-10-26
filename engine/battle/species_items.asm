CheckSpeciesItem:
; carry if held item c is made for species b (an ID): see SpeciesItems; preserves
; bc, de
	push de
	ld a, b
	call GetPokemonIndexFromID
	ld d, h
	ld e, l
	ld hl, SpeciesItems
.loop
	ld a, [hli]
	cp -1
	jr z, .done ; (no carry)
	cp c
	ld a, [hli]
	jr nz, .next
	cp e
	jr nz, .next
	ld a, [hl]
	cp d
	jr z, .yes
.next
	inc hl
	jr .loop

.yes
	scf
.done
	pop de
	ret

INCLUDE "data/items/species_items.asm"
