	db 0 ; #253 (the species ID: see GetBaseData)

	db  75,  71,  70,  87,  40,  80
	;   hp  atk  def  spd  sat  sdf

	db DARK, NORMAL ; type
	db 127 ; catch rate
	db 145 ; base exp
	db NO_ITEM, PSNCUREBERRY ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 15 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/raticate_a/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm SWORDS_DANCE, HEADBUTT, ROAR, ICE_BEAM, BLIZZARD, HYPER_BEAM, DIG, TOXIC, DOUBLE_TEAM, REST, SUBSTITUTE, THIEF, SNORE, PROTECT, SLUDGE_BOMB, ICY_WIND, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, RAIN_DANCE, SUNNY_DAY, SHADOW_BALL
	; end
