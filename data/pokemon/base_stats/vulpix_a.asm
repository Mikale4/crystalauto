	db 0 ; #257 (the species ID: see GetBaseData)

	db  38,  41,  40,  65,  50,  65
	;   hp  atk  def  spd  sat  sdf

	db ICE, ICE ; type
	db 190 ; catch rate
	db 60 ; base exp
	db BURNT_BERRY, BURNT_BERRY ; items
	db GENDER_F75 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/vulpix_a/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm HEADBUTT, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ROAR, ICE_BEAM, BLIZZARD, DIG, TOXIC, DOUBLE_TEAM, REFLECT, SWIFT, REST, SUBSTITUTE, SNORE, PROTECT, ICY_WIND, ENDURE, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, RAIN_DANCE, PSYCH_UP
	; end
