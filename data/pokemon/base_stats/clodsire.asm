	db 0 ; #316 (the species ID: see GetBaseData)

	db 130,  75,  60,  20,  45, 100
	;   hp  atk  def  spd  sat  sdf

	db POISON, GROUND ; type
	db 90 ; catch rate
	db 151 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/clodsire/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_1, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, SURF, HYPER_BEAM, EARTHQUAKE, DIG, TOXIC, WATERFALL, REST, ROCK_SLIDE, SUBSTITUTE, CURSE, PROTECT, SLUDGE_BOMB, MUD_SLAP, SANDSTORM, ENDURE, SLEEP_TALK, RAIN_DANCE
	; end
