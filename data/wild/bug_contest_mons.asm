MACRO contest_mon
; %, species (its 16-bit index), min, max
	db \1
	dw \2
	db \3, \4
ENDM

ContestMons:
	;   %, species,   min, max
	contest_mon 20, CATERPIE,    7, 18
	contest_mon 20, WEEDLE,      7, 18
	contest_mon 10, METAPOD,     9, 18
	contest_mon 10, KAKUNA,      9, 18
	contest_mon  5, BUTTERFREE, 12, 15
	contest_mon  5, BEEDRILL,   12, 15
	contest_mon 10, VENONAT,    10, 16
	contest_mon 10, PARAS,      10, 17
	contest_mon  5, SCYTHER,    13, 14
	contest_mon  5, PINSIR,     13, 14
	contest_mon -1, VENOMOTH,   30, 40