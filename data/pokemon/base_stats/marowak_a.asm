	db 0 ; #273 (the species ID: see GetBaseData)

	db  60,  80, 110,  45,  50,  80
	;   hp  atk  def  spd  sat  sdf

	db FIRE, GHOST ; type
	db 75 ; catch rate
	db 149 ; base exp
	db NO_ITEM, THICK_CLUB ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/marowak_a/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_MONSTER, EGG_MONSTER ; egg groups

	; tm/hm learnset
	tmhm MEGA_PUNCH, FIRE_PUNCH, THUNDERPUNCH, SWORDS_DANCE, MEGA_KICK, HEADBUTT, BODY_SLAM, FLAMETHROWER, ICE_BEAM, BLIZZARD, HYPER_BEAM, SEISMIC_TOSS, THUNDERBOLT, THUNDER, EARTHQUAKE, DIG, TOXIC, DOUBLE_TEAM, FIRE_BLAST, SWIFT, DREAM_EATER, REST, ROCK_SLIDE, SUBSTITUTE, THIEF, SNORE, PROTECT, ICY_WIND, SANDSTORM, ENDURE, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, RAIN_DANCE, SUNNY_DAY, SHADOW_BALL
	; end
