	db 0 ; #279 (the species ID: see GetBaseData)

	db  73,  84,  78,  95, 119,  85
	;   hp  atk  def  spd  sat  sdf

	db FIRE, GHOST ; type
	db 45 ; catch rate
	db 240 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/typhlosion_h/front.dimensions"
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm FIRE_PUNCH, THUNDERPUNCH, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ROAR, FLAMETHROWER, HYPER_BEAM, SOLARBEAM, EARTHQUAKE, DIG, FIRE_BLAST, SWIFT, REST, ROCK_SLIDE, SUBSTITUTE, CURSE, PROTECT, ENDURE, SLEEP_TALK, IRON_TAIL, SUNNY_DAY, SHADOW_BALL, ROCK_SMASH
	; end
