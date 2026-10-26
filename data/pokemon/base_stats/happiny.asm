	db 0 ; #290 (the species ID: see GetBaseData)

	db 100,   5,   5,  30,  15,  65
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, NORMAL ; type
	db 130 ; catch rate
	db 110 ; base exp
	db NO_ITEM, LUCKY_EGG ; items
	db GENDER_F100 ; gender ratio
	db 100 ; unknown 1
	db 40 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/happiny/front.dimensions"
	db GROWTH_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm HEADBUTT, TAKE_DOWN, FLAMETHROWER, SOLARBEAM, THUNDER_WAVE, TOXIC, PSYCHIC_M, DOUBLE_TEAM, METRONOME, FIRE_BLAST, DREAM_EATER, FLASH, REST, SUBSTITUTE, SNORE, PROTECT, MUD_SLAP, ICY_WIND, ENDURE, ROLLOUT, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, HIDDEN_POWER, RAIN_DANCE, SUNNY_DAY, PSYCH_UP, SHADOW_BALL
	; end
