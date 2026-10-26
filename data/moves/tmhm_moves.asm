; The add_tm, add_hm, and add_mt macros in constants/item_constants.asm simultaneously
; define constants for the item IDs and for the corresponding move values.

TMHMMoves:
; entries correspond to *_TMNUM constants (see constants/item_constants.asm)
	table_width 2 ; (the moves' 16-bit indexes)

; TMs
for n, 1, NUM_TMS + 1
	dw TM{02d:n}_MOVE
endr
	assert_table_length NUM_TMS

; HMs
for n, 1, NUM_HMS + 1
	dw HM{02d:n}_MOVE
endr
	assert_table_length NUM_TMS + NUM_HMS

; Move tutors
DEF n = 1
for n, 1, NUM_TUTORS + 1
	dw MT{02d:n}_MOVE
endr
	assert_table_length NUM_TMS + NUM_HMS + NUM_TUTORS

; GEN 1 TMs' moves no TM, HM or tutor above teaches (see add_g1tm)
for n, 1, NUM_GEN1_TM_MOVES + 1
	dw G1MV{02d:n}_MOVE
endr
	assert_table_length NUM_TM_HM_TUTOR

	dw 0 ; end

Gen1TMMoves:
; GEN 1's TM01-TM50 (see add_g1tm)
	table_width 2 ; (the moves' 16-bit indexes)
for n, 1, NUM_TMS + 1
	dw G1TM{02d:n}_MOVE
endr
	assert_table_length NUM_TMS
