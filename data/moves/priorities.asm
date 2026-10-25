MovePriorities:
; moves that go before or after others (the rest: 0), as in the latest games
; (COUNTER and MIRROR COAT work by themselves: see HandleAutoCounter)
	db PROTECT,       4
	db DETECT,        4
	db ENDURE,        4
	db EXTREMESPEED,  2
	db QUICK_ATTACK,  1
	db BIDE,          1
	db MACH_PUNCH,    1
	db VITAL_THROW,  -1
	db WHIRLWIND,    -6
	db ROAR,         -6
	db TELEPORT,     -6
	db -1
