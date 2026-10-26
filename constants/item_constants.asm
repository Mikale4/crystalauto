; item ids
; indexes for:
; - ItemNames (see data/items/names.asm)
; - ItemDescriptions (see data/items/descriptions.asm)
; - ItemAttributes (see data/items/attributes.asm)
; - ItemEffects (see engine/items/item_effects.asm)
	const_def
	const NO_ITEM      ; 00
	const MASTER_BALL  ; 01
	const ULTRA_BALL   ; 02
	const BRIGHTPOWDER ; 03
	const GREAT_BALL   ; 04
	const POKE_BALL    ; 05
	const TOWN_MAP     ; 06
	const BICYCLE      ; 07
	const MOON_STONE   ; 08
	const ANTIDOTE     ; 09
	const BURN_HEAL    ; 0a
	const ICE_HEAL     ; 0b
	const AWAKENING    ; 0c
	const PARLYZ_HEAL  ; 0d
	const FULL_RESTORE ; 0e
	const MAX_POTION   ; 0f
	const HYPER_POTION ; 10
	const SUPER_POTION ; 11
	const POTION       ; 12
	const ESCAPE_ROPE  ; 13
	const REPEL        ; 14
	const MAX_ELIXER   ; 15
	const FIRE_STONE   ; 16
	const THUNDERSTONE ; 17
	const WATER_STONE  ; 18
	const LINKING_CORD ; 19 (formerly unused: evolves POKéMON that evolved by trade)
	const HP_UP        ; 1a
	const PROTEIN      ; 1b
	const IRON         ; 1c
	const CARBOS       ; 1d
	const LUCKY_PUNCH  ; 1e
	const CALCIUM      ; 1f
	const RARE_CANDY   ; 20
	const X_ACCURACY   ; 21
	const LEAF_STONE   ; 22
	const METAL_POWDER ; 23
	const NUGGET       ; 24
	const POKE_DOLL    ; 25
	const FULL_HEAL    ; 26
	const REVIVE       ; 27
	const MAX_REVIVE   ; 28
	const GUARD_SPEC   ; 29
	const SUPER_REPEL  ; 2a
	const MAX_REPEL    ; 2b
	const DIRE_HIT     ; 2c
	const ITEM_2D      ; 2d
	const FRESH_WATER  ; 2e
	const SODA_POP     ; 2f
	const LEMONADE     ; 30
	const X_ATTACK     ; 31
	const ITEM_32      ; 32
	const X_DEFEND     ; 33
	const X_SPEED      ; 34
	const X_SPECIAL    ; 35
	const COIN_CASE    ; 36
	const ITEMFINDER   ; 37
	const POKE_FLUTE   ; 38
	const EXP_SHARE    ; 39
	const OLD_ROD      ; 3a
	const GOOD_ROD     ; 3b
	const SILVER_LEAF  ; 3c
	const SUPER_ROD    ; 3d
	const PP_UP        ; 3e
	const ETHER        ; 3f
	const MAX_ETHER    ; 40
	const ELIXER       ; 41
	const RED_SCALE    ; 42
	const SECRETPOTION ; 43
	const S_S_TICKET   ; 44
	const MYSTERY_EGG  ; 45
	const CLEAR_BELL   ; 46
	const SILVER_WING  ; 47
	const MOOMOO_MILK  ; 48
	const QUICK_CLAW   ; 49
	const PSNCUREBERRY ; 4a
	const GOLD_LEAF    ; 4b
	const SOFT_SAND    ; 4c
	const SHARP_BEAK   ; 4d
	const PRZCUREBERRY ; 4e
	const BURNT_BERRY  ; 4f
	const ICE_BERRY    ; 50
	const POISON_BARB  ; 51
	const KINGS_ROCK   ; 52
	const BITTER_BERRY ; 53
	const MINT_BERRY   ; 54
	const RED_APRICORN ; 55
	const TINYMUSHROOM ; 56
	const BIG_MUSHROOM ; 57
	const SILVERPOWDER ; 58
	const BLU_APRICORN ; 59
	const ITEM_5A      ; 5a
	const AMULET_COIN  ; 5b
	const YLW_APRICORN ; 5c
	const GRN_APRICORN ; 5d
	const CLEANSE_TAG  ; 5e
	const MYSTIC_WATER ; 5f
	const TWISTEDSPOON ; 60
	const WHT_APRICORN ; 61
	const BLACKBELT_I  ; 62
	const BLK_APRICORN ; 63
	const ITEM_64      ; 64
	const PNK_APRICORN ; 65
	const BLACKGLASSES ; 66
	const SLOWPOKETAIL ; 67
	const PINK_BOW     ; 68
	const STICK        ; 69
	const SMOKE_BALL   ; 6a
	const NEVERMELTICE ; 6b
	const MAGNET       ; 6c
	const MIRACLEBERRY ; 6d
	const PEARL        ; 6e
	const BIG_PEARL    ; 6f
	const EVERSTONE    ; 70
	const SPELL_TAG    ; 71
	const RAGECANDYBAR ; 72
	const GS_BALL      ; 73
	const BLUE_CARD    ; 74
	const MIRACLE_SEED ; 75
	const THICK_CLUB   ; 76
	const FOCUS_BAND   ; 77
	const ITEM_78      ; 78
	const ENERGYPOWDER ; 79
	const ENERGY_ROOT  ; 7a
	const HEAL_POWDER  ; 7b
	const REVIVAL_HERB ; 7c
	const HARD_STONE   ; 7d
	const LUCKY_EGG    ; 7e
	const CARD_KEY     ; 7f
	const MACHINE_PART ; 80
	const EGG_TICKET   ; 81
	const LOST_ITEM    ; 82
	const STARDUST     ; 83
	const STAR_PIECE   ; 84
	const BASEMENT_KEY ; 85
	const PASS         ; 86
	const ITEM_87      ; 87
	const ITEM_88      ; 88
	const ENDLESS_CANDY ; 89 (formerly unused, see engine/events/difficulty.asm)
	const CHARCOAL     ; 8a
	const BERRY_JUICE  ; 8b
	const SCOPE_LENS   ; 8c
	const ITEM_8D      ; 8d
	const ITEM_8E      ; 8e
	const METAL_COAT   ; 8f
	const DRAGON_FANG  ; 90
	const ITEM_91      ; 91
	const LEFTOVERS    ; 92
	const ITEM_93      ; 93
	const ITEM_94      ; 94
	const ITEM_95      ; 95
	const MYSTERYBERRY ; 96
	const DRAGON_SCALE ; 97
	const BERSERK_GENE ; 98
	const ITEM_99      ; 99
	const ITEM_9A      ; 9a
	const ITEM_9B      ; 9b
	const SACRED_ASH   ; 9c
	const HEAVY_BALL   ; 9d
	const FLOWER_MAIL  ; 9e
	const LEVEL_BALL   ; 9f
	const LURE_BALL    ; a0
	const FAST_BALL    ; a1
	const ITEM_A2      ; a2
	const LIGHT_BALL   ; a3
	const FRIEND_BALL  ; a4
	const MOON_BALL    ; a5
	const LOVE_BALL    ; a6
	const NORMAL_BOX   ; a7
	const GORGEOUS_BOX ; a8
	const SUN_STONE    ; a9
	const POLKADOT_BOW ; aa
	const ITEM_AB      ; ab
	const UP_GRADE     ; ac
	const BERRY        ; ad
	const GOLD_BERRY   ; ae
	const SQUIRTBOTTLE ; af
	const ITEM_B0      ; b0
	const PARK_BALL    ; b1
	const RAINBOW_WING ; b2
	const ITEM_B3      ; b3
	const BRICK_PIECE  ; b4
	const SURF_MAIL    ; b5
	const LITEBLUEMAIL ; b6
	const PORTRAITMAIL ; b7
	const LOVELY_MAIL  ; b8
	const EON_MAIL     ; b9
	const MORPH_MAIL   ; ba
	const BLUESKY_MAIL ; bb
	const MUSIC_MAIL   ; bc
	const MIRAGE_MAIL  ; bd
	const GEN1_TM      ; be (one of GEN 1's TMs: see wCurGen1TM)
DEF NUM_ITEMS EQU const_value - 1

DEF __tmhm_value__ = 1

MACRO add_tmnum
	DEF \1_TMNUM EQU __tmhm_value__
	DEF __tmhm_value__ += 1
ENDM

MACRO add_tm
; Defines three constants:
; - TM_\1: the item id, starting at $bf
; - \1_TMNUM: the learnable TM/HM flag, starting at 1
; - TM##_MOVE: alias for the move id, equal to the value of \1
	const TM_\1
	DEF TM{02d:__tmhm_value__}_MOVE = \1
	add_tmnum \1
ENDM

; see data/moves/tmhm_moves.asm for moves
DEF TM01 EQU const_value
	add_tm DYNAMICPUNCH ; bf
	add_tm HEADBUTT     ; c0
	add_tm CURSE        ; c1
	add_tm ROLLOUT      ; c2
	const ITEM_C3       ; c3
	add_tm ROAR         ; c4
	add_tm TOXIC        ; c5
	add_tm ZAP_CANNON   ; c6
	add_tm ROCK_SMASH   ; c7
	add_tm PSYCH_UP     ; c8
	add_tm HIDDEN_POWER ; c9
	add_tm SUNNY_DAY    ; ca
	add_tm SWEET_SCENT  ; cb
	add_tm SNORE        ; cc
	add_tm BLIZZARD     ; cd
	add_tm HYPER_BEAM   ; ce
	add_tm ICY_WIND     ; cf
	add_tm PROTECT      ; d0
	add_tm RAIN_DANCE   ; d1
	add_tm GIGA_DRAIN   ; d2
	add_tm ENDURE       ; d3
	add_tm FRUSTRATION  ; d4
	add_tm SOLARBEAM    ; d5
	add_tm IRON_TAIL    ; d6
	add_tm DRAGONBREATH ; d7
	add_tm THUNDER      ; d8
	add_tm EARTHQUAKE   ; d9
	add_tm RETURN       ; da
	add_tm DIG          ; db
	const ITEM_DC       ; dc
	add_tm PSYCHIC_M    ; dd
	add_tm SHADOW_BALL  ; de
	add_tm MUD_SLAP     ; df
	add_tm DOUBLE_TEAM  ; e0
	add_tm ICE_PUNCH    ; e1
	add_tm SWAGGER      ; e2
	add_tm SLEEP_TALK   ; e3
	add_tm SLUDGE_BOMB  ; e4
	add_tm SANDSTORM    ; e5
	add_tm FIRE_BLAST   ; e6
	add_tm SWIFT        ; e7
	add_tm DEFENSE_CURL ; e8
	add_tm THUNDERPUNCH ; e9
	add_tm DREAM_EATER  ; ea
	add_tm DETECT       ; eb
	add_tm REST         ; ec
	add_tm ATTRACT      ; ed
	add_tm THIEF        ; ee
	add_tm STEEL_WING   ; ef
	add_tm FIRE_PUNCH   ; f0
	add_tm FURY_CUTTER  ; f1
	add_tm NIGHTMARE    ; f2
DEF NUM_TMS EQU __tmhm_value__ - 1

MACRO add_hm
; Defines three constants:
; - HM_\1: the item id, starting at $f3
; - \1_TMNUM: the learnable TM/HM flag, starting at 51
; - HM##_MOVE: alias for the move id, equal to the value of \1
	const HM_\1
	DEF HM_VALUE = __tmhm_value__ - NUM_TMS
	DEF HM{02d:HM_VALUE}_MOVE = \1
	add_tmnum \1
ENDM

DEF HM01 EQU const_value
	add_hm CUT          ; f3
	add_hm FLY          ; f4
	add_hm SURF         ; f5
	add_hm STRENGTH     ; f6
	add_hm FLASH        ; f7
	add_hm WHIRLPOOL    ; f8
	add_hm WATERFALL    ; f9
DEF NUM_HMS EQU __tmhm_value__ - NUM_TMS - 1

MACRO add_mt
; Defines two constants:
; - \1_TMNUM: the learnable TM/HM flag, starting at 58
; - MT##_MOVE: alias for the move id, equal to the value of \1
	DEF MT_VALUE = __tmhm_value__ - NUM_TMS - NUM_HMS
	DEF MT{02d:MT_VALUE}_MOVE = \1
	add_tmnum \1
ENDM

DEF MT01 EQU const_value
	add_mt FLAMETHROWER
	add_mt THUNDERBOLT
	add_mt ICE_BEAM
DEF NUM_TUTORS = __tmhm_value__ - NUM_TMS - NUM_HMS - 1

; GEN 1's TMs (RED, BLUE and YELLOW's TM01-TM50): the ones whose move isn't this
; game's TM's of the same number are TMs of their own here, "(GEN 1)" (see
; wGen1TMs and engine/items/tmhm.asm). Each defines G1TM##_MOVE; and, for a move
; no TM, HM or tutor here teaches, its learnable flag \1_TMNUM (after the tutors')
; and G1MV##_MOVE.
DEF __g1tm_value__ = 1
DEF NUM_GEN1_TM_MOVES = 0
MACRO add_g1tm
	DEF G1TM{02d:__g1tm_value__}_MOVE = \1
	DEF __g1tm_value__ += 1
	if !DEF(\1_TMNUM)
		DEF NUM_GEN1_TM_MOVES += 1
		DEF G1MV{02d:NUM_GEN1_TM_MOVES}_MOVE = \1
		add_tmnum \1
	endc
ENDM

	add_g1tm MEGA_PUNCH   ; TM01
	add_g1tm RAZOR_WIND   ; TM02
	add_g1tm SWORDS_DANCE ; TM03
	add_g1tm WHIRLWIND    ; TM04
	add_g1tm MEGA_KICK    ; TM05
	add_g1tm TOXIC        ; TM06
	add_g1tm HORN_DRILL   ; TM07
	add_g1tm BODY_SLAM    ; TM08
	add_g1tm TAKE_DOWN    ; TM09
	add_g1tm DOUBLE_EDGE  ; TM10
	add_g1tm BUBBLEBEAM   ; TM11
	add_g1tm WATER_GUN    ; TM12
	add_g1tm ICE_BEAM     ; TM13
	add_g1tm BLIZZARD     ; TM14
	add_g1tm HYPER_BEAM   ; TM15
	add_g1tm PAY_DAY      ; TM16
	add_g1tm SUBMISSION   ; TM17
	add_g1tm COUNTER      ; TM18
	add_g1tm SEISMIC_TOSS ; TM19
	add_g1tm RAGE         ; TM20
	add_g1tm MEGA_DRAIN   ; TM21
	add_g1tm SOLARBEAM    ; TM22
	add_g1tm DRAGON_RAGE  ; TM23
	add_g1tm THUNDERBOLT  ; TM24
	add_g1tm THUNDER      ; TM25
	add_g1tm EARTHQUAKE   ; TM26
	add_g1tm FISSURE      ; TM27
	add_g1tm DIG          ; TM28
	add_g1tm PSYCHIC_M    ; TM29
	add_g1tm TELEPORT     ; TM30
	add_g1tm MIMIC        ; TM31
	add_g1tm DOUBLE_TEAM  ; TM32
	add_g1tm REFLECT      ; TM33
	add_g1tm BIDE         ; TM34
	add_g1tm METRONOME    ; TM35
	add_g1tm SELFDESTRUCT ; TM36
	add_g1tm EGG_BOMB     ; TM37
	add_g1tm FIRE_BLAST   ; TM38
	add_g1tm SWIFT        ; TM39
	add_g1tm SKULL_BASH   ; TM40
	add_g1tm SOFTBOILED   ; TM41
	add_g1tm DREAM_EATER  ; TM42
	add_g1tm SKY_ATTACK   ; TM43
	add_g1tm REST         ; TM44
	add_g1tm THUNDER_WAVE ; TM45
	add_g1tm PSYWAVE      ; TM46
	add_g1tm EXPLOSION    ; TM47
	add_g1tm ROCK_SLIDE   ; TM48
	add_g1tm TRI_ATTACK   ; TM49
	add_g1tm SUBSTITUTE   ; TM50
	assert __g1tm_value__ - 1 == NUM_TMS

; how many GEN 1 TMs are TMs of their own (their numbers' moves differ)
DEF NUM_GEN1_ONLY_TMS = 0
for n, 1, NUM_TMS + 1
	if G1TM{02d:n}_MOVE != TM{02d:n}_MOVE
		DEF NUM_GEN1_ONLY_TMS += 1
	endc
endr

DEF NUM_TM_HM_TUTOR EQU NUM_TMS + NUM_HMS + NUM_TUTORS + NUM_GEN1_TM_MOVES

; the TM pocket's entries (see TMHMPocketEntries): a TM or HM's number, or GEN 1's
; TM's with GEN1_TM_ENTRY_F
DEF NUM_TMHM_POCKET_ENTRIES EQU NUM_TMS + NUM_GEN1_ONLY_TMS + NUM_HMS
DEF GEN1_TM_ENTRY_F EQU 7

	const ITEM_FA       ; fa

DEF USE_SCRIPT_VAR EQU $00
DEF ITEM_FROM_MEM  EQU $ff

; leftovers from red
DEF SAFARI_BALL    EQU $08 ; MOON_STONE
DEF MOON_STONE_RED EQU $0a ; BURN_HEAL
DEF FULL_HEAL_RED  EQU $34 ; X_SPEED
