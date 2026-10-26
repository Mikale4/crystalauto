TreeMons:
; entries correspond to TREEMON_SET_* constants
	table_width 2
	dw TreeMonSet_None
	dw TreeMonSet_Canyon
	dw TreeMonSet_Town
	dw TreeMonSet_Route
	dw TreeMonSet_Kanto
	dw TreeMonSet_Lake
	dw TreeMonSet_Forest
	dw TreeMonSet_Rock
	assert_table_length NUM_TREEMON_SETS
	dw TreeMonSet_None ; unused

; Two tables each (common, rare).
; Structure:
;	treemon %, species, level

MACRO treemon
	db \1
	dw \2 ; (its 16-bit index)
	db \3
ENDM

TreeMonSet_None:
; no encounter data

TreeMonSet_Canyon:
; common
	treemon 50, SPEAROW,    10
	treemon 15, SPEAROW,    10
	treemon 15, SPEAROW,    10
	treemon 10, AIPOM,      10
	treemon  5, AIPOM,      10
	treemon  5, AIPOM,      10
	db -1
; rare
	treemon 50, SPEAROW,    10
	treemon 15, HERACROSS,  10
	treemon 15, HERACROSS,  10
	treemon 10, AIPOM,      10
	treemon  5, AIPOM,      10
	treemon  5, AIPOM,      10
	db -1

TreeMonSet_Town:
; common
	treemon 50, SPEAROW,    10
	treemon 15, EKANS,      10
	treemon 15, SPEAROW,    10
	treemon 10, AIPOM,      10
	treemon  5, AIPOM,      10
	treemon  5, AIPOM,      10
	db -1
; rare
	treemon 50, SPEAROW,    10
	treemon 15, HERACROSS,  10
	treemon 15, HERACROSS,  10
	treemon 10, AIPOM,      10
	treemon  5, AIPOM,      10
	treemon  5, AIPOM,      10
	db -1

TreeMonSet_Route:
; common
	treemon 50, HOOTHOOT,   10
	treemon 15, SPINARAK,   10
	treemon 15, LEDYBA,     10
	treemon 10, EXEGGCUTE,  10
	treemon  5, EXEGGCUTE,  10
	treemon  5, EXEGGCUTE,  10
	db -1
; rare
	treemon 50, HOOTHOOT,   10
	treemon 15, PINECO,     10
	treemon 15, PINECO,     10
	treemon 10, EXEGGCUTE,  10
	treemon  5, EXEGGCUTE,  10
	treemon  5, MUNCHLAX,   10
	db -1

TreeMonSet_Kanto:
; common
	treemon 50, HOOTHOOT,   10
	treemon 15, EKANS,      10
	treemon 15, HOOTHOOT,   10
	treemon 10, EXEGGCUTE,  10
	treemon  5, EXEGGCUTE,  10
	treemon  5, EXEGGCUTE,  10
	db -1
; rare
	treemon 50, HOOTHOOT,   10
	treemon 15, PINECO,     10
	treemon 15, PINECO,     10
	treemon 10, EXEGGCUTE,  10
	treemon  5, EXEGGCUTE,  10
	treemon  5, MUNCHLAX,   10
	db -1

TreeMonSet_Lake:
; common
	treemon 50, HOOTHOOT,   10
	treemon 15, VENONAT,    10
	treemon 15, HOOTHOOT,   10
	treemon 10, EXEGGCUTE,  10
	treemon  5, EXEGGCUTE,  10
	treemon  5, EXEGGCUTE,  10
	db -1
; rare
	treemon 50, HOOTHOOT,   10
	treemon 15, PINECO,     10
	treemon 15, PINECO,     10
	treemon 10, EXEGGCUTE,  10
	treemon  5, EXEGGCUTE,  10
	treemon  5, EXEGGCUTE,  10
	db -1

TreeMonSet_Forest:
; common
	treemon 50, HOOTHOOT,   10
	treemon 15, PINECO,     10
	treemon 15, PINECO,     10
	treemon 10, NOCTOWL,    10
	treemon  5, BUTTERFREE, 10
	treemon  5, BEEDRILL,   10
	db -1
; rare
	treemon 50, HOOTHOOT,   10
	treemon 15, CATERPIE,   10
	treemon 15, WEEDLE,     10
	treemon 10, MUNCHLAX,   10
	treemon  5, METAPOD,    10
	treemon  5, KAKUNA,     10
	db -1

TreeMonSet_Rock:
	treemon 70, KRABBY,     15
	treemon 20, BONSLY,     15
	treemon 10, SHUCKLE,    15
	db -1
