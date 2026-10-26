MovePriorities:
; moves that go before or after others (the rest: 0), as in the latest games
; (COUNTER and MIRROR COAT work by themselves: see HandleAutoCounter)
	dwb PROTECT,       4
	dwb DETECT,        4
	dwb ENDURE,        4
	dwb EXTREMESPEED,  2
	dwb QUICK_ATTACK,  1
	dwb BIDE,          1
	dwb MACH_PUNCH,    1
	dwb VITAL_THROW,  -1
	dwb WHIRLWIND,    -6
	dwb ROAR,         -6
	dwb TELEPORT,     -6
	dw -1
