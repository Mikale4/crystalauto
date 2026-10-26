; (the lowest 2^n - 1 that's at least HIGH(NUM_ATTACKS))
DEF METRONOME_HIGH_MASK = 0
rept 8
	if METRONOME_HIGH_MASK < HIGH(NUM_ATTACKS)
		DEF METRONOME_HIGH_MASK = METRONOME_HIGH_MASK * 2 + 1
	endc
endr

BattleCommand_Metronome:
	call ClearLastMove
	call CheckUserIsCharging
	jr nz, .charging

	ld a, [wBattleAnimParam]
	push af
	call BattleCommand_LowerSub
	pop af
	ld [wBattleAnimParam], a

.charging
	call LoadMoveAnim

.GetMove:
; a random move (an index from 1 to NUM_ATTACKS)
	call BattleRandom
	and METRONOME_HIGH_MASK
	ld h, a
	call BattleRandom
	ld l, a
	ld a, l
	sub LOW(NUM_ATTACKS)
	ld a, h
	sbc HIGH(NUM_ATTACKS)
	jr nc, .GetMove
	inc hl

; None of the moves in MetronomeExcepts.
	ld de, MetronomeExcepts
.excepts
	ld a, [de]
	inc de
	ld c, a
	ld a, [de]
	inc de
	ld b, a
	and c
	inc a
	jr z, .allowed ; -1: the end
	ld a, c
	cp l
	jr nz, .excepts
	ld a, b
	cp h
	jr nz, .excepts
	jr .GetMove

.allowed
; No moves the user already has.
	call GetMoveIDFromIndex
	call CheckUserMove
	jr z, .GetMove

	ld a, BATTLE_VARS_MOVE
	call GetBattleVarAddr
	ld [hl], b
	call UpdateMoveData
	jp ResetTurn

INCLUDE "data/moves/metronome_exception_moves.asm"
