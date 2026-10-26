FixedDamageRolls:
; SONICBOOM, SEISMIC TOSS, DRAGON RAGE, NIGHT SHADE (EFFECT_STATIC_DAMAGE): fixed
; damage, rolled as MAGNITUDE's power is (see BattleCommand_ConstantDamage)
	; chance, damage
	db   5 percent + 1,  20 ; 5%
	db  15 percent,      35 ; 10%
	db  35 percent,      50 ; 20%
	db  65 percent + 1,  60 ; 30%
	db  85 percent + 1,  70 ; 20%
	db  95 percent,      85 ; 10%
	db 100 percent,     100 ; 5%
