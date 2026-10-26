	db 0 ; #293 (the species ID: see GetBaseData)

	db  70, 120,  65, 125,  45,  85
	;   hp  atk  def  spd  sat  sdf

	db DARK, ICE ; type
	db 45 ; catch rate
	db 179 ; base exp
	db NO_ITEM, QUICK_CLAW ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/weavile/front.dimensions"
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm MEGA_PUNCH, ICE_PUNCH, SWORDS_DANCE, CUT, MEGA_KICK, HEADBUTT, TAKE_DOWN, SURF, ICE_BEAM, BLIZZARD, HYPER_BEAM, STRENGTH, DIG, TOXIC, DOUBLE_TEAM, REFLECT, METRONOME, SWIFT, DREAM_EATER, REST, SUBSTITUTE, THIEF, SNORE, PROTECT, MUD_SLAP, ICY_WIND, ENDURE, SWAGGER, FURY_CUTTER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, RAIN_DANCE, SUNNY_DAY, PSYCH_UP, SHADOW_BALL, ROCK_SMASH, WHIRLPOOL
	; end
