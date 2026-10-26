	db 0 ; #301 (the species ID: see GetBaseData)

	db  86,  76,  86,  95, 116,  56
	;   hp  atk  def  spd  sat  sdf

	db BUG, FLYING ; type
	db 30 ; catch rate
	db 180 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/yanmega/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	; tm/hm learnset
	tmhm SWORDS_DANCE, HEADBUTT, TAKE_DOWN, DOUBLE_EDGE, HYPER_BEAM, SOLARBEAM, TOXIC, PSYCHIC_M, DOUBLE_TEAM, SWIFT, DREAM_EATER, FLASH, REST, SUBSTITUTE, THIEF, SNORE, PROTECT, MUD_SLAP, GIGA_DRAIN, ENDURE, SWAGGER, STEEL_WING, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, HIDDEN_POWER, SUNNY_DAY, PSYCH_UP, SHADOW_BALL
	; end
