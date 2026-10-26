	db 0 ; #282 (the species ID: see GetBaseData)

	db  65,  95,  85,  85,  55,  55
	;   hp  atk  def  spd  sat  sdf

	db DARK, POISON ; type
	db 45 ; catch rate
	db 88 ; base exp
	db NO_ITEM, POISON_BARB ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/qwilfish_h/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_WATER_2, EGG_WATER_2 ; egg groups

	; tm/hm learnset
	tmhm SWORDS_DANCE, TAKE_DOWN, DOUBLE_EDGE, SURF, ICE_BEAM, BLIZZARD, TOXIC, WATERFALL, SWIFT, REST, SUBSTITUTE, CURSE, PROTECT, SLUDGE_BOMB, ICY_WIND, ENDURE, SLEEP_TALK, RAIN_DANCE, SHADOW_BALL
	; end
