	db 0 ; #304 (the species ID: see GetBaseData)

	db  75,  95, 125,  95,  45,  75
	;   hp  atk  def  spd  sat  sdf

	db GROUND, FLYING ; type
	db 30 ; catch rate
	db 179 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/gliscor/front.dimensions"
	db GROWTH_MEDIUM_SLOW ; growth rate
	dn EGG_BUG, EGG_BUG ; egg groups

	; tm/hm learnset
	tmhm SWORDS_DANCE, CUT, HEADBUTT, TAKE_DOWN, DOUBLE_EDGE, HYPER_BEAM, STRENGTH, EARTHQUAKE, DIG, TOXIC, DOUBLE_TEAM, SWIFT, SKY_ATTACK, REST, ROCK_SLIDE, SUBSTITUTE, THIEF, SNORE, PROTECT, SLUDGE_BOMB, MUD_SLAP, SANDSTORM, ENDURE, SWAGGER, FURY_CUTTER, STEEL_WING, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, RAIN_DANCE, SUNNY_DAY, ROCK_SMASH
	; end
