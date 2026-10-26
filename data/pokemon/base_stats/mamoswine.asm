	db 0 ; #305 (the species ID: see GetBaseData)

	db 110, 130,  80,  80,  70,  60
	;   hp  atk  def  spd  sat  sdf

	db ICE, GROUND ; type
	db 50 ; catch rate
	db 239 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/mamoswine/front.dimensions"
	db GROWTH_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm HEADBUTT, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ROAR, ICE_BEAM, BLIZZARD, HYPER_BEAM, STRENGTH, EARTHQUAKE, DIG, TOXIC, DOUBLE_TEAM, REFLECT, REST, ROCK_SLIDE, SUBSTITUTE, SNORE, CURSE, PROTECT, MUD_SLAP, ICY_WIND, SANDSTORM, ENDURE, SWAGGER, FURY_CUTTER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, HIDDEN_POWER, RAIN_DANCE, ROCK_SMASH
	; end
