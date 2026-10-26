	db 0 ; #254 (the species ID: see GetBaseData)

	db  60,  85,  50, 110,  95,  85
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, PSYCHIC_TYPE ; type
	db 75 ; catch rate
	db 218 ; base exp
	db NO_ITEM, BERRY ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 10 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/raichu_a/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_FAIRY ; egg groups

	; tm/hm learnset
	tmhm MEGA_PUNCH, PAY_DAY, THUNDERPUNCH, MEGA_KICK, HEADBUTT, BODY_SLAM, TAKE_DOWN, SURF, HYPER_BEAM, SEISMIC_TOSS, THUNDERBOLT, THUNDER_WAVE, THUNDER, DIG, TOXIC, PSYCHIC_M, TELEPORT, DOUBLE_TEAM, REFLECT, SWIFT, REST, SUBSTITUTE, THIEF, SNORE, PROTECT, ENDURE, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, RAIN_DANCE
	; end
