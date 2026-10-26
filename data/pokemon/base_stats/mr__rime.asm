	db 0 ; #311 (the species ID: see GetBaseData)

	db  80,  85,  75,  70, 110, 100
	;   hp  atk  def  spd  sat  sdf

	db ICE, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 182 ; base exp
	db NO_ITEM, MYSTERYBERRY ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 25 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/mr__rime/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_HUMANSHAPE, EGG_HUMANSHAPE ; egg groups

	; tm/hm learnset
	tmhm MEGA_PUNCH, ICE_PUNCH, MEGA_KICK, BODY_SLAM, ICE_BEAM, BLIZZARD, HYPER_BEAM, SOLARBEAM, THUNDERBOLT, THUNDER_WAVE, THUNDER, PSYCHIC_M, REFLECT, METRONOME, REST, SUBSTITUTE, THIEF, SNORE, PROTECT, ICY_WIND, ENDURE, ATTRACT, SLEEP_TALK, RAIN_DANCE, SUNNY_DAY, SHADOW_BALL
	; end
