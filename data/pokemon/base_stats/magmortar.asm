	db 0 ; #299 (the species ID: see GetBaseData)

	db  75,  95,  67,  83, 125,  95
	;   hp  atk  def  spd  sat  sdf

	db FIRE, FIRE ; type
	db 30 ; catch rate
	db 243 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F25 ; gender ratio
	db 100 ; unknown 1
	db 25 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/magmortar/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_HUMANSHAPE, EGG_HUMANSHAPE ; egg groups

	; tm/hm learnset
	tmhm MEGA_PUNCH, FIRE_PUNCH, THUNDERPUNCH, MEGA_KICK, HEADBUTT, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ROAR, FLAMETHROWER, HYPER_BEAM, STRENGTH, SOLARBEAM, THUNDERBOLT, EARTHQUAKE, TOXIC, PSYCHIC_M, DOUBLE_TEAM, METRONOME, FIRE_BLAST, REST, ROCK_SLIDE, SUBSTITUTE, THIEF, SNORE, CURSE, PROTECT, MUD_SLAP, ENDURE, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, SUNNY_DAY, ROCK_SMASH
	; end
