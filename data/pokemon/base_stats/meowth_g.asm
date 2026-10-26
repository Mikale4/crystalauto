	db 0 ; #260 (the species ID: see GetBaseData)

	db  50,  65,  55,  40,  40,  40
	;   hp  atk  def  spd  sat  sdf

	db STEEL, STEEL ; type
	db 255 ; catch rate
	db 58 ; base exp
	db NO_ITEM, QUICK_CLAW ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/meowth_g/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm PAY_DAY, SWORDS_DANCE, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, THUNDERBOLT, THUNDER, DIG, METRONOME, REST, SUBSTITUTE, THIEF, SNORE, CURSE, PROTECT, ENDURE, ATTRACT, SLEEP_TALK, IRON_TAIL, RAIN_DANCE, SUNNY_DAY, SHADOW_BALL
	; end
