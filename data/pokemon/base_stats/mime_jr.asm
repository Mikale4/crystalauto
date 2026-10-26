	db 0 ; #289 (the species ID: see GetBaseData)

	db  20,  25,  45,  60,  70,  90
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC_TYPE, FAIRY ; type
	db 145 ; catch rate
	db 62 ; base exp
	db NO_ITEM, MYSTERYBERRY ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 25 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/mime_jr/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm HEADBUTT, SOLARBEAM, THUNDERBOLT, THUNDER_WAVE, THUNDER, TOXIC, PSYCHIC_M, DOUBLE_TEAM, REFLECT, DREAM_EATER, FLASH, REST, SUBSTITUTE, THIEF, SNORE, PROTECT, MUD_SLAP, ICY_WIND, ENDURE, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, HIDDEN_POWER, RAIN_DANCE, SUNNY_DAY, PSYCH_UP, SHADOW_BALL
	; end
