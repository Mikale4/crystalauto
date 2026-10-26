	db 0 ; #258 (the species ID: see GetBaseData)

	db  73,  67,  75, 109,  81, 100
	;   hp  atk  def  spd  sat  sdf

	db ICE, FAIRY ; type
	db 75 ; catch rate
	db 177 ; base exp
	db BURNT_BERRY, BURNT_BERRY ; items
	db GENDER_F75 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/ninetales_a/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm HEADBUTT, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ROAR, ICE_BEAM, BLIZZARD, HYPER_BEAM, SOLARBEAM, DIG, TOXIC, DOUBLE_TEAM, REFLECT, SWIFT, DREAM_EATER, REST, SUBSTITUTE, SNORE, PROTECT, ICY_WIND, ENDURE, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, RAIN_DANCE, PSYCH_UP
	; end
