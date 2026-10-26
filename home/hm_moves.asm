; HM moves can't be forgotten

IsHM::
	cp HM01
	jr c, .NotHM
	scf
	ret
.NotHM:
	and a
	ret

IsHMMove::
; carry if move ID a is an HM's
	ld hl, .HMMoves
	jp CheckMoveInList

.HMMoves:
	dw CUT
	dw FLY
	dw SURF
	dw STRENGTH
	dw FLASH
	dw WATERFALL
	dw WHIRLPOOL
	dw -1 ; end
