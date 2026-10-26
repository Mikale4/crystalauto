	db 0 ; #286 (the species ID: see GetBaseData)

	db  60,  60,  60, 105, 105, 105
	;   hp  atk  def  spd  sat  sdf

	db GHOST, GHOST ; type
	db 45 ; catch rate
	db 173 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 25 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/mismagius/front.dimensions"
	db GROWTH_FAST ; growth rate
	dn EGG_INDETERMINATE, EGG_INDETERMINATE ; egg groups

	; tm/hm learnset
	tmhm HEADBUTT, HYPER_BEAM, THUNDERBOLT, THUNDER_WAVE, THUNDER, TOXIC, PSYCHIC_M, DOUBLE_TEAM, SWIFT, DREAM_EATER, FLASH, REST, SUBSTITUTE, THIEF, SNORE, CURSE, PROTECT, ICY_WIND, ENDURE, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, HIDDEN_POWER, RAIN_DANCE, SUNNY_DAY, PSYCH_UP, SHADOW_BALL
	; end
