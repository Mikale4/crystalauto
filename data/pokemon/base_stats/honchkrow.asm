	db 0 ; #287 (the species ID: see GetBaseData)

	db 100, 125,  52,  71, 105,  52
	;   hp  atk  def  spd  sat  sdf

	db DARK, FLYING ; type
	db 30 ; catch rate
	db 177 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/honchkrow/front.dimensions"
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_FLYING, EGG_FLYING ; egg groups

	; tm/hm learnset
	tmhm FLY, TAKE_DOWN, DOUBLE_EDGE, HYPER_BEAM, THUNDER_WAVE, TOXIC, PSYCHIC_M, DOUBLE_TEAM, SWIFT, DREAM_EATER, SKY_ATTACK, REST, SUBSTITUTE, THIEF, SNORE, PROTECT, MUD_SLAP, ICY_WIND, ENDURE, SWAGGER, STEEL_WING, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, HIDDEN_POWER, RAIN_DANCE, SUNNY_DAY, PSYCH_UP, SHADOW_BALL
	; end
