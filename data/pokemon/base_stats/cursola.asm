	db 0 ; #309 (the species ID: see GetBaseData)

	db  60,  95,  50,  30, 145, 130
	;   hp  atk  def  spd  sat  sdf

	db GHOST, GHOST ; type
	db 30 ; catch rate
	db 179 ; base exp
	db NO_ITEM, HARD_STONE ; items
	db GENDER_F75 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/cursola/front.dimensions"
	db GROWTH_FAST ; growth rate
	dn EGG_WATER_1, EGG_WATER_3 ; egg groups

	; tm/hm learnset
	tmhm BODY_SLAM, SURF, ICE_BEAM, BLIZZARD, HYPER_BEAM, EARTHQUAKE, DIG, PSYCHIC_M, REFLECT, SELFDESTRUCT, REST, ROCK_SLIDE, SUBSTITUTE, SNORE, PROTECT, ICY_WIND, SANDSTORM, GIGA_DRAIN, ENDURE, ATTRACT, SLEEP_TALK, RAIN_DANCE, SUNNY_DAY, SHADOW_BALL, WHIRLPOOL
	; end
