	db 0 ; #277 (the species ID: see GetBaseData)

	db  90, 125,  90, 100,  85,  90
	;   hp  atk  def  spd  sat  sdf

	db FIGHTING, FLYING ; type
	db 3 ; catch rate
	db 255 ; base exp
	db NO_ITEM, NO_ITEM ; items
	db GENDER_UNKNOWN ; gender ratio
	db 100 ; unknown 1
	db 80 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/zapdos_g/front.dimensions"
	db GROWTH_SLOW ; growth rate
	dn EGG_NONE, EGG_NONE ; egg groups

	; tm/hm learnset
	tmhm FLY, MEGA_KICK, TAKE_DOWN, DOUBLE_EDGE, HYPER_BEAM, SWIFT, REST, SUBSTITUTE, SNORE, PROTECT, SANDSTORM, ENDURE, STEEL_WING, SLEEP_TALK, RAIN_DANCE, SUNNY_DAY
	; end
