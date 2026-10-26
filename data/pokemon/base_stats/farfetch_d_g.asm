	db 0 ; #271 (the species ID: see GetBaseData)

	db  52,  95,  55,  55,  58,  62
	;   hp  atk  def  spd  sat  sdf

	db FIGHTING, FIGHTING ; type
	db 45 ; catch rate
	db 132 ; base exp
	db STICK, STICK ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/farfetch_d_g/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_FLYING, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm SWORDS_DANCE, BODY_SLAM, REST, SUBSTITUTE, SNORE, PROTECT, ENDURE, STEEL_WING, ATTRACT, SLEEP_TALK, SUNNY_DAY
	; end
