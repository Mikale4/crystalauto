	db 0 ; #313 (the species ID: see GetBaseData)

	db  70, 130,  95,  85,  45,  75
	;   hp  atk  def  spd  sat  sdf

	db BUG, ROCK ; type
	db 25 ; catch rate
	db 175 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 25 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/kleavor/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	; tm/hm learnset
	tmhm SWORDS_DANCE, TAKE_DOWN, DOUBLE_EDGE, HYPER_BEAM, SWIFT, REST, ROCK_SLIDE, SUBSTITUTE, THIEF, PROTECT, SANDSTORM, ENDURE, SLEEP_TALK, SUNNY_DAY
	; end
