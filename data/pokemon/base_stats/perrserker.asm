	db 0 ; #308 (the species ID: see GetBaseData)

	db  70, 110, 100,  50,  50,  60
	;   hp  atk  def  spd  sat  sdf

	db STEEL, STEEL ; type
	db 90 ; catch rate
	db 154 ; base exp
	db NO_ITEM, METAL_COAT ; items
	db GENDER_F50 ; gender ratio
	db 100 ; unknown 1
	db 20 ; step cycles to hatch
	db 5 ; unknown 2
	INCBIN "gfx/pokemon/perrserker/front.dimensions"
	db GROWTH_MEDIUM_FAST ; growth rate
	dn EGG_GROUND, EGG_GROUND ; egg groups

	; tm/hm learnset
	tmhm PAY_DAY, SWORDS_DANCE, BODY_SLAM, TAKE_DOWN, DOUBLE_EDGE, HYPER_BEAM, THUNDERBOLT, THUNDER, DIG, METRONOME, REST, SUBSTITUTE, THIEF, SNORE, CURSE, PROTECT, ENDURE, ATTRACT, SLEEP_TALK, IRON_TAIL, RAIN_DANCE, SUNNY_DAY, SHADOW_BALL
	; end
