	db 0 ; #276 (the species ID: see GetBaseData)

	db  90,  85,  85,  95, 125, 100
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC_TYPE, FLYING ; type
	db 3 ; catch rate
	db 255 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 80 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/articuno_g/front.dimensions"
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm FLY, TAKE_DOWN, HYPER_BEAM, PSYCHIC_M, REFLECT, SWIFT, REST, SUBSTITUTE, SNORE, PROTECT, ENDURE, STEEL_WING, SLEEP_TALK, RAIN_DANCE, SUNNY_DAY, SHADOW_BALL
	; end
