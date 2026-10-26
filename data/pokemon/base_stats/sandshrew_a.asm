	db 0 ; #255 (the species ID: see GetBaseData)

	db  50,  75,  90,  40,  10,  35
	;   hp  atk  def  spd  sat  sdf

	db ICE, STEEL ; type
	db 255 ; catch rate
	db 60 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/sandshrew_a/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm ICE_PUNCH, SWORDS_DANCE, HEADBUTT, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ICE_BEAM, BLIZZARD, SEISMIC_TOSS, EARTHQUAKE, DIG, TOXIC, DOUBLE_TEAM, SWIFT, REST, ROCK_SLIDE, SUBSTITUTE, THIEF, SNORE, CURSE, PROTECT, ICY_WIND, ENDURE, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, SUNNY_DAY
	; end
