	db 0 ; #294 (the species ID: see GetBaseData)

	db  70,  70, 115,  60, 130,  90
	;   hp  atk  def  spd  sat  sdf

	db ELECTRIC, STEEL ; type
	db 30 ; catch rate
	db 241 ; base exp
	db MAGNET, METAL_COAT ; items
	db GENDER_UNKNOWN ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/magnezone/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	; tm/hm learnset
	tmhm BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, HYPER_BEAM, THUNDERBOLT, THUNDER_WAVE, THUNDER, TOXIC, DOUBLE_TEAM, REFLECT, SELFDESTRUCT, SWIFT, FLASH, EXPLOSION, REST, TRI_ATTACK, SUBSTITUTE, SNORE, PROTECT, SANDSTORM, ENDURE, ROLLOUT, SWAGGER, SLEEP_TALK, RETURN, FRUSTRATION, HIDDEN_POWER, RAIN_DANCE, SUNNY_DAY, PSYCH_UP
	; end
