BattleCommand_GetMagnitude:
	push bc
	call BattleRandom
	ld b, a
	ld hl, MagnitudePower
.loop
	ld a, [hli]
	cp b
	jr nc, .ok
	inc hl
	inc hl
	jr .loop

.ok
	ld d, [hl]
	push de
	inc hl
	ld a, [hl]
	ld [wTextDecimalByte], a
	call BattleCommand_MoveDelay
; ("Magnitude 8!", or PSYWAVE's own: "Psywave 8!")
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cpmove PSYWAVE
	ld hl, MagnitudeText
	jr nz, .got_text
	ld hl, PsywaveText
.got_text
	call StdBattleTextbox
	pop de
	pop bc
	ret

INCLUDE "data/moves/magnitude_power.asm"
