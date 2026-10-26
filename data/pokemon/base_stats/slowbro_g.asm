	db 0 ; #270 (the species ID: see GetBaseData)

	db  95, 100,  95,  30, 100,  70
	;   hp  atk  def  spd  sat  sdf

	db POISON, PSYCHIC_TYPE ; type
	db 75 ; catch rate
	db 172 ; base exp
	db NO_ITEM, KINGS_ROCK ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/slowbro_g/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_MONSTER, EGG_WATER_1 ; egg groups

	; tm/hm learnset
	tmhm MEGA_PUNCH, PAY_DAY, ICE_PUNCH, MEGA_KICK, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, FLAMETHROWER, SURF, ICE_BEAM, BLIZZARD, HYPER_BEAM, THUNDER_WAVE, EARTHQUAKE, DIG, TOXIC, PSYCHIC_M, METRONOME, FIRE_BLAST, WATERFALL, SWIFT, REST, TRI_ATTACK, SUBSTITUTE, SNORE, CURSE, PROTECT, SLUDGE_BOMB, ICY_WIND, SANDSTORM, ENDURE, ATTRACT, SLEEP_TALK, IRON_TAIL, RAIN_DANCE, SUNNY_DAY, PSYCH_UP, SHADOW_BALL, WHIRLPOOL
	; end
