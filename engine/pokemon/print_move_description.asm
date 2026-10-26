PrintMoveDescription:
; (wCurSpecies: the move's ID)
	push hl
	ld a, [wCurSpecies]
	call GetMoveIndexFromID
	dec hl
	add hl, hl
	ld de, MoveDescriptions
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	jp PlaceString

INCLUDE "data/moves/descriptions.asm"
