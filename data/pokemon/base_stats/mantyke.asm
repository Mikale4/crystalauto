	db 0 ; #292 (the species ID: see GetBaseData)

	db  45,  20,  50,  50,  60, 120
	;   hp  atk  def  spd  sat  sdf

	db WATER, FLYING ; type
	db 25 ; catch rate
	db 69 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 25 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/mantyke/front.dimensions"
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm HEADBUTT, SURF, ICE_BEAM, BLIZZARD, EARTHQUAKE, TOXIC, DOUBLE_TEAM, WATERFALL, SWIFT, REST, ROCK_SLIDE, SUBSTITUTE, SNORE, PROTECT, MUD_SLAP, ICY_WIND, ENDURE, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, HIDDEN_POWER, RAIN_DANCE, WHIRLPOOL
	; end
