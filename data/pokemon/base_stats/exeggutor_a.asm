	db 0 ; #272 (the species ID: see GetBaseData)

	db  95, 105,  85,  45, 125,  75
	;   hp  atk  def  spd  sat  sdf

	db GRASS, DRAGON ; type
	db 45 ; catch rate
	db 186 ; base exp
	db SILVER_LEAF, GOLD_LEAF ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/exeggutor_a/front.dimensions"
	db GROWTH_SLOW ; growth rate
	dn EGG_PLANT, EGG_PLANT ; egg groups

	; tm/hm learnset
	tmhm SWORDS_DANCE, HEADBUTT, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, FLAMETHROWER, HYPER_BEAM, MEGA_DRAIN, SOLARBEAM, EARTHQUAKE, TOXIC, PSYCHIC_M, TELEPORT, DOUBLE_TEAM, REFLECT, SELFDESTRUCT, DREAM_EATER, EXPLOSION, REST, SUBSTITUTE, THIEF, SNORE, CURSE, PROTECT, SLUDGE_BOMB, GIGA_DRAIN, ENDURE, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, SUNNY_DAY, PSYCH_UP
	; end
