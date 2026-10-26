	db 0 ; #306 (the species ID: see GetBaseData)

	db  85,  80,  70,  90, 135,  75
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, NORMAL ; type
	db 30 ; catch rate
	db 241 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_UNKNOWN ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/porygon_z/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	; tm/hm learnset
	tmhm TAKE_DOWN, DOUBLE_EDGE, ICE_BEAM, BLIZZARD, HYPER_BEAM, SOLARBEAM, THUNDERBOLT, THUNDER_WAVE, THUNDER, TOXIC, PSYCHIC_M, DOUBLE_TEAM, SWIFT, DREAM_EATER, FLASH, REST, TRI_ATTACK, SUBSTITUTE, THIEF, SNORE, PROTECT, ICY_WIND, ENDURE, SWAGGER, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, RAIN_DANCE, SUNNY_DAY, PSYCH_UP, SHADOW_BALL
	; end
