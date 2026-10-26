	db 0 ; #268 (the species ID: see GetBaseData)

	db  65, 100,  70, 105,  80,  80
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC_TYPE, FAIRY ; type
	db 60 ; catch rate
	db 175 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/rapidash_g/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm PAY_DAY, SWORDS_DANCE, BODY_SLAM, HYPER_BEAM, PSYCHIC_M, SWIFT, REST, SUBSTITUTE, SNORE, PROTECT, ENDURE, ATTRACT, SLEEP_TALK, IRON_TAIL
	; end
