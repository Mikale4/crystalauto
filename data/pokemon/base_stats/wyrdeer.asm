	db 0 ; #312 (the species ID: see GetBaseData)

	db 103, 105,  72,  65, 105,  75
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, PSYCHIC_TYPE ; type
	db 30 ; catch rate
	db 241 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/wyrdeer/front.dimensions"
	db GROWTH_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ROAR, HYPER_BEAM, SOLARBEAM, THUNDERBOLT, THUNDER_WAVE, THUNDER, EARTHQUAKE, DIG, PSYCHIC_M, REFLECT, SWIFT, REST, SUBSTITUTE, THIEF, CURSE, PROTECT, ENDURE, SLEEP_TALK, RAIN_DANCE, SUNNY_DAY, PSYCH_UP, SHADOW_BALL
	; end
