CanLearnTMHMMove:
; c: whether wCurPartySpecies can learn move wPutativeTMHMMove (an ID) by TM, HM
; or tutor
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld hl, wBaseTMHM
	push hl
	push de

	ld a, [wPutativeTMHMMove]
	call GetMoveIndexFromID
	ld d, h
	ld e, l
	ld c, 0
	ld hl, TMHMMoves
.loop
	ld a, [hli]
	ld b, a
	or [hl]
	jr z, .end
	ld a, [hli]
	cp d
	jr nz, .next
	ld a, b
	cp e
	jr z, .found
.next
	inc c
	jr .loop

.found
	pop de
	pop hl
	ld b, CHECK_FLAG
	push de
	ld d, 0
	predef SmallFarFlagAction
	pop de
	ret

.end
	pop de
	pop hl
	ld c, 0
	ret

GetTMHMMove:
; wTempTMHM: TM/HM/tutor number wTempTMHM's move (its ID)
	ld a, [wTempTMHM]
	dec a
	ld hl, TMHMMoves
	ld b, 0
	ld c, a
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call GetMoveIDFromIndex
	ld [wTempTMHM], a
	ret

GetGen1TMMove:
; wTempTMHM: GEN 1's TM wTempTMHM's move (its ID: see Gen1TMMoves)
	ld a, [wTempTMHM]
	dec a
	ld hl, Gen1TMMoves
	ld b, 0
	ld c, a
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call GetMoveIDFromIndex
	ld [wTempTMHM], a
	ret

INCLUDE "data/moves/tmhm_moves.asm"
