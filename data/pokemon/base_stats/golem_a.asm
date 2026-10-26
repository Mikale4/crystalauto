	db 0 ; #266 (the species ID: see GetBaseData)

	db  80, 120, 130,  45,  55,  65
	;   hp  atk  def  spd  sat  sdf

	db ROCK, ELECTRIC ; type
	db 45 ; catch rate
	db 223 ; base exp
	db EVERSTONE, HARD_STONE ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 15 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/golem_a/front.dimensions"
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_MINERAL, EGG_MINERAL ; egg groups

	; tm/hm learnset
	tmhm FIRE_PUNCH, THUNDERPUNCH, HEADBUTT, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, ROAR, FLAMETHROWER, HYPER_BEAM, SEISMIC_TOSS, THUNDERBOLT, THUNDER_WAVE, THUNDER, EARTHQUAKE, DIG, TOXIC, DOUBLE_TEAM, METRONOME, SELFDESTRUCT, FIRE_BLAST, EXPLOSION, REST, ROCK_SLIDE, SUBSTITUTE, SNORE, CURSE, PROTECT, MUD_SLAP, SANDSTORM, ENDURE, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, HIDDEN_POWER, SUNNY_DAY
	; end
