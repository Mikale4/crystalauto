PrintItemDescription:
; Print the description for item [wCurSpecies] at de.

	ld a, [wCurSpecies]
	cp GEN1_TM
	jr z, .gen1_tm
	cp TM01
	jr c, .not_a_tm

	ld [wCurItem], a
	push de
	farcall GetTMHMItemMove
	pop hl
.tm_move
	ld a, [wTempTMHM]
	ld [wCurSpecies], a
	predef PrintMoveDescription
	ret

.gen1_tm
; (which: wCurGen1TM)
	push de
	ld a, [wCurGen1TM]
	ld [wTempTMHM], a
	farcall GetGen1TMMove
	pop hl
	jr .tm_move

.not_a_tm
	push de
	ld hl, ItemDescriptions
	ld a, [wCurSpecies]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	jp PlaceString

INCLUDE "data/items/descriptions.asm"
