	db 0 ; #284 (the species ID: see GetBaseData)

	db  50,  20,  40,  20,  20,  40
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, FAIRY ; type
	db 150 ; catch rate
	db 38 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/azurill/front.dimensions"
	db GROWTH_FAST ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm HEADBUTT, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, SURF, ICE_BEAM, BLIZZARD, TOXIC, MIMIC, DOUBLE_TEAM, DEFENSE_CURL, WATERFALL, SWIFT, REST, SUBSTITUTE, SNORE, PROTECT, MUD_SLAP, ICY_WIND, ENDURE, ROLLOUT, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, IRON_TAIL, HIDDEN_POWER, RAIN_DANCE, WHIRLPOOL
	; end
