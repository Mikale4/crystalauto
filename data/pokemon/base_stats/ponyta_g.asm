	db 0 ; #267 (the species ID: see GetBaseData)

	db  50,  85,  55,  90,  65,  65
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 190 ; catch rate
	db 82 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/ponyta_g/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm BODY_SLAM, PSYCHIC_M, SWIFT, REST, SUBSTITUTE, SNORE, PROTECT, ENDURE, ATTRACT, SLEEP_TALK, IRON_TAIL
	; end
