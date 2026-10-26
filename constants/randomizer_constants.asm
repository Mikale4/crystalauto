; RANDOMIZER mode (see engine/events/randomizer.asm)

; wRandomizer
DEF RANDOMIZER_ON_F          EQU 0 ; wild Pokémon are random
DEF RANDOMIZER_TRAINERS_F    EQU 1 ; so are trainers' Pokémon
DEF RANDOMIZER_LEGENDARIES_F EQU 2 ; legendaries swap with other legendaries
DEF RANDOMIZER_STARTERS_MASK EQU %11000 ; ELM's three Pokémon: STARTERS_*
DEF RANDOMIZER_STARTERS_SHIFT EQU 3

	const_def
	const STARTERS_ORIGINAL ; 0: CHIKORITA, CYNDAQUIL and TOTODILE
	const STARTERS_STARTERS ; 1: three of StarterPool
	const STARTERS_ANY      ; 2: any three Pokémon
DEF NUM_STARTER_MODES EQU const_value

; ELM's POKé BALLs (GetStarterSpecies), in JohtoStarterLines' order
	const_def
	const STARTER_GRASS ; 0: CHIKORITA's
	const STARTER_FIRE  ; 1: CYNDAQUIL's
	const STARTER_WATER ; 2: TOTODILE's
DEF NUM_STARTERS EQU const_value

; a wild or trainer Pokémon is picked from RandomizerPool within this many
; places of where the one it replaces would be (by base stat total)
DEF RANDOMIZER_WINDOW EQU 15

; what a pick is for (the first byte hashed with the seed)
	const_def 1
	const RANDOM_WILD      ; grass, caves, water, fishing, trees, rocks, the contest
	const RANDOM_TRAINER   ; a trainer's Pokémon
	const RANDOM_LEGENDARY ; a legendary
	const RANDOM_STARTER   ; one of ELM's
	const RANDOM_BRANCH    ; which way the rival's starter evolves

; hRandomizerSlot for RANDOM_WILD: grass and caves are the time of day x
; NUM_GRASSMON + the slot; these, then the slot
DEF WILDSLOT_WATER   EQU $40
DEF WILDSLOT_FISH    EQU $60 ; + the rod
DEF WILDSLOT_TREE    EQU $70 ; + the tree's table (TREEMON_SCORE_*)
DEF WILDSLOT_ROCK    EQU $78
DEF WILDSLOT_CONTEST EQU $80
