	db 0 ; #314 (the species ID: see GetBaseData)

	db 130, 140, 105,  50,  45,  80
	;   hp  atk  def  spd  sat  sdf

	db GROUND, NORMAL ; type
	db 75 ; catch rate
	db 221 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/ursaluna/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm FIRE_PUNCH, ICE_PUNCH, THUNDERPUNCH, SWORDS_DANCE, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ROAR, HYPER_BEAM, EARTHQUAKE, DIG, METRONOME, SWIFT, REST, ROCK_SLIDE, SUBSTITUTE, THIEF, CURSE, PROTECT, ENDURE, SLEEP_TALK, RAIN_DANCE, SUNNY_DAY
	; end
