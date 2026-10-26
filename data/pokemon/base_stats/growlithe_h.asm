	db 0 ; #262 (the species ID: see GetBaseData)

	db  60,  75,  45,  55,  65,  50
	;   hp  atk  def  spd  sat  sdf

	db FIRE, ROCK ; type
	db 190 ; catch rate
	db 70 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F25 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/growlithe_h/front.dimensions"
	db GROWTH_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ROAR, FLAMETHROWER, DIG, FIRE_BLAST, SWIFT, REST, ROCK_SLIDE, SUBSTITUTE, PROTECT, SANDSTORM, ENDURE, SLEEP_TALK, IRON_TAIL, SUNNY_DAY, ROCK_SMASH
	; end
