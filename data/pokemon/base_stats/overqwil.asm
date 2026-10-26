	db 0 ; #315 (the species ID: see GetBaseData)

	db  85, 115,  95,  85,  65,  65
	;   hp  atk  def  spd  sat  sdf

	db DARK, POISON ; type
	db 135 ; catch rate
	db 173 ; base exp
	db POISON_BARB, POISON_BARB ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/overqwil/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_2, EGG_WATER_2 ; egg groups

	; tm/hm learnset
	tmhm SWORDS_DANCE, TAKE_DOWN, DOUBLE_EDGE, SURF, ICE_BEAM, BLIZZARD, HYPER_BEAM, TOXIC, WATERFALL, REST, SUBSTITUTE, CURSE, PROTECT, SLUDGE_BOMB, ICY_WIND, ENDURE, SLEEP_TALK, RAIN_DANCE, SHADOW_BALL
	; end
