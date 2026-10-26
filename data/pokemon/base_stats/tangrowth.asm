	db 0 ; #297 (the species ID: see GetBaseData)

	db 100, 100, 125,  50, 110,  50
	;   hp  atk  def  spd  sat  sdf

	db GRASS, GRASS ; type
	db 30 ; catch rate
	db 187 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/tangrowth/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_PLANT, EGG_PLANT ; egg groups

	; tm/hm learnset
	tmhm SWORDS_DANCE, CUT, HEADBUTT, BODY_SLAM, HYPER_BEAM, STRENGTH, SOLARBEAM, EARTHQUAKE, TOXIC, DOUBLE_TEAM, REFLECT, FLASH, REST, ROCK_SLIDE, SUBSTITUTE, THIEF, SNORE, PROTECT, SLUDGE_BOMB, MUD_SLAP, GIGA_DRAIN, ENDURE, SWAGGER, ATTRACT, SLEEP_TALK, RETURN, FRUSTRATION, HIDDEN_POWER, SUNNY_DAY, PSYCH_UP, ROCK_SMASH
	; end
