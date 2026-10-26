	db 0 ; #274 (the species ID: see GetBaseData)

	db  65,  90, 120,  60,  85,  70
	;   hp  atk  def  spd  sat  sdf

	db POISON, FAIRY ; type
	db 60 ; catch rate
	db 172 ; base exp
	db NO_ITEM, SMOKE_BALL ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/weezing_g/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_INDETERMINATE, EGG_INDETERMINATE ; egg groups

	; tm/hm learnset
	tmhm BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, FLAMETHROWER, HYPER_BEAM, THUNDERBOLT, THUNDER, TOXIC, SELFDESTRUCT, FIRE_BLAST, REST, SUBSTITUTE, THIEF, SNORE, CURSE, PROTECT, SLUDGE_BOMB, ENDURE, ATTRACT, SLEEP_TALK, RAIN_DANCE, SUNNY_DAY, SHADOW_BALL
	; end
