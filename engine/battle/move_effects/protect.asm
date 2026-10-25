BattleCommand_Protect:
	call ProtectChance
	ret c

	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	set SUBSTATUS_PROTECT, [hl]

	call AnimateCurrentMove

	ld hl, ProtectedItselfText
	jp StdBattleTextbox

ProtectChance:
	ld de, wPlayerProtectCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_count
	ld de, wEnemyProtectCount
.got_count

	call CheckOpponentWentFirst
	jr nz, .failed

; Can't have a substitute.

	ld a, BATTLE_VARS_SUBSTATUS4
	call GetBattleVar
	bit SUBSTATUS_SUBSTITUTE, a
	jr nz, .failed

; A third of the chance of a successful Protect for each consecutive use (as in
; the latest games).

	ld b, $ff
	ld a, [de]
	ld c, a
.loop
	ld a, c
	and a
	jr z, .done
	dec c

	ld a, b
	ld b, -1
.third
	inc b
	sub 3
	jr nc, .third
	ld a, b
	and a
	jr nz, .loop
	jr .failed
.done

.rand
	call BattleRandom
	and a
	jr z, .rand

	dec a
	cp b
	jr nc, .failed

; Another consecutive Protect use.

	ld a, [de]
	inc a
	ld [de], a

	and a
	ret

.failed
	xor a
	ld [de], a
	call AnimateFailedMove
	call PrintButItFailed
	scf
	ret
