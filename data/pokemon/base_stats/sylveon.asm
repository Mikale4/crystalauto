	db 0 ; #307 (the species ID: see GetBaseData)

	db  95,  65,  65,  60, 110, 130
	;   hp  atk  def  spd  sat  sdf

	db FAIRY, FAIRY ; type
	db 45 ; catch rate
	db 184 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 35 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/sylveon/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm PAY_DAY, CUT, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ROAR, HYPER_BEAM, DIG, TOXIC, PSYCHIC_M, DOUBLE_TEAM, REFLECT, SWIFT, FLASH, REST, SUBSTITUTE, SNORE, CURSE, PROTECT, ENDURE, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, RAIN_DANCE, SUNNY_DAY, PSYCH_UP, SHADOW_BALL
	; end
