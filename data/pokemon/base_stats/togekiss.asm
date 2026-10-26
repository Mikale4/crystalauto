	db 0 ; #300 (the species ID: see GetBaseData)

	db  85,  50,  95,  80, 120, 115
	;   hp  atk  def  spd  sat  sdf

	db FAIRY, FLYING ; type
	db 30 ; catch rate
	db 245 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F12_5 ; gender ratio
	db 100 ; unknown 1
	db 10 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/togekiss/front.dimensions"
	db GROWTH_FAST ; growth rate
	dn EGG_FLYING, EGG_FAIRY ; egg groups

	; tm/hm learnset
	tmhm MEGA_PUNCH, FLY, MEGA_KICK, HEADBUTT, BODY_SLAM, FLAMETHROWER, HYPER_BEAM, SOLARBEAM, THUNDER_WAVE, TOXIC, PSYCHIC_M, DOUBLE_TEAM, REFLECT, METRONOME, FIRE_BLAST, SWIFT, DREAM_EATER, SKY_ATTACK, FLASH, REST, TRI_ATTACK, SUBSTITUTE, SNORE, PROTECT, MUD_SLAP, ENDURE, ROLLOUT, SWAGGER, STEEL_WING, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, HIDDEN_POWER, RAIN_DANCE, SUNNY_DAY, PSYCH_UP, SHADOW_BALL, ROCK_SMASH
	; end
