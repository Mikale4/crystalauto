	db 0 ; #302 (the species ID: see GetBaseData)

	db  65, 110, 130,  95,  60,  65
	;   hp  atk  def  spd  sat  sdf

	db GRASS, GRASS ; type
	db 45 ; catch rate
	db 184 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F12_5 ; gender ratio
	db 100 ; unknown 1
	db 35 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/leafeon/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm PAY_DAY, SWORDS_DANCE, HEADBUTT, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ROAR, HYPER_BEAM, STRENGTH, SOLARBEAM, DIG, TOXIC, DOUBLE_TEAM, SWIFT, FLASH, REST, SUBSTITUTE, SNORE, CURSE, PROTECT, MUD_SLAP, GIGA_DRAIN, ENDURE, SWAGGER, FURY_CUTTER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, RAIN_DANCE, SUNNY_DAY, SHADOW_BALL, ROCK_SMASH
	; end
