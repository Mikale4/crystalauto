	db 0 ; #303 (the species ID: see GetBaseData)

	db  65,  60, 110,  65, 130,  95
	;   hp  atk  def  spd  sat  sdf

	db ICE, ICE ; type
	db 45 ; catch rate
	db 184 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 35 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/glaceon/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm PAY_DAY, HEADBUTT, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ROAR, ICE_BEAM, BLIZZARD, HYPER_BEAM, STRENGTH, DIG, TOXIC, DOUBLE_TEAM, SWIFT, REST, SUBSTITUTE, SNORE, CURSE, PROTECT, MUD_SLAP, ICY_WIND, ENDURE, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, RAIN_DANCE, SUNNY_DAY, SHADOW_BALL, ROCK_SMASH
	; end
