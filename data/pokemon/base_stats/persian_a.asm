	db 0 ; #261 (the species ID: see GetBaseData)

	db  65,  60,  60, 115,  75,  65
	;   hp  atk  def  spd  sat  sdf

	db DARK, DARK ; type
	db 90 ; catch rate
	db 154 ; base exp
	db NO_ITEM, QUICK_CLAW ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/persian_a/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm PAY_DAY, HEADBUTT, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ROAR, HYPER_BEAM, THUNDERBOLT, THUNDER_WAVE, THUNDER, DIG, TOXIC, DOUBLE_TEAM, SWIFT, DREAM_EATER, REST, SUBSTITUTE, THIEF, SNORE, CURSE, PROTECT, ICY_WIND, ENDURE, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, RAIN_DANCE, SUNNY_DAY, PSYCH_UP, SHADOW_BALL
	; end
