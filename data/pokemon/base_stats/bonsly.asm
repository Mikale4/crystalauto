	db 0 ; #288 (the species ID: see GetBaseData)

	db  50,  80,  95,  10,  10,  45
	;   hp  atk  def  spd  sat  sdf

	db ROCK, ROCK ; type
	db 255 ; catch rate
	db 58 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/bonsly/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm HEADBUTT, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, EARTHQUAKE, DIG, TOXIC, DOUBLE_TEAM, SELFDESTRUCT, EXPLOSION, REST, ROCK_SLIDE, SUBSTITUTE, THIEF, SNORE, CURSE, PROTECT, MUD_SLAP, SANDSTORM, ENDURE, ROLLOUT, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, HIDDEN_POWER, SUNNY_DAY, PSYCH_UP
	; end
