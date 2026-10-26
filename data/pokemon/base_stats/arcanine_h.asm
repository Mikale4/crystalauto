	db 0 ; #263 (the species ID: see GetBaseData)

	db  95, 115,  80,  90,  95,  80
	;   hp  atk  def  spd  sat  sdf

	db FIRE, ROCK ; type
	db 75 ; catch rate
	db 194 ; base exp
	db ICE_BERRY, ICE_BERRY ; items
	db GENDER_F25 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/arcanine_h/front.dimensions"
	db GROWTH_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ROAR, FLAMETHROWER, HYPER_BEAM, SOLARBEAM, DIG, FIRE_BLAST, SWIFT, REST, ROCK_SLIDE, SUBSTITUTE, THIEF, PROTECT, SANDSTORM, ENDURE, SLEEP_TALK, IRON_TAIL, SUNNY_DAY, ROCK_SMASH
	; end
