	db 0 ; #269 (the species ID: see GetBaseData)

	db  90,  65,  65,  15,  40,  40
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC_TYPE, PSYCHIC_TYPE ; type
	db 190 ; catch rate
	db 63 ; base exp
	db NO_ITEM, KINGS_ROCK ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/slowpoke_g/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_MONSTER, EGG_WATER_1 ; egg groups

	; tm/hm learnset
	tmhm PAY_DAY, BODY_SLAM, TAKE_DOWN, FLAMETHROWER, SURF, ICE_BEAM, BLIZZARD, THUNDER_WAVE, EARTHQUAKE, DIG, PSYCHIC_M, FIRE_BLAST, WATERFALL, SWIFT, REST, TRI_ATTACK, SUBSTITUTE, SNORE, CURSE, PROTECT, ICY_WIND, ENDURE, ATTRACT, SLEEP_TALK, IRON_TAIL, RAIN_DANCE, SUNNY_DAY, PSYCH_UP, SHADOW_BALL, WHIRLPOOL
	; end
