; PalletToPewter's rules (see engine/events/difficulty.asm,
; engine/pokemon/level_caps.asm and engine/battle/capture_rule.asm)

; wDifficulty
	const_def
	const DIFFICULTY_NORMAL  ; 0
	const DIFFICULTY_HARD    ; 1
	const DIFFICULTY_EXTREME ; 2
DEF NUM_DIFFICULTIES EQU const_value
DEF DIFFICULTY_MASK EQU %11
DEF DIFFICULTY_CHOSEN_F EQU 7 ; asked once, even for saves from before difficulties

; Pokémon grow to CAP_BELOW levels below the strongest Pokémon of the next big battle
DEF CAP_BELOW EQU 2
DEF MIN_LEVEL_CAP EQU 5
DEF NUM_LEVEL_CAP_STEPS EQU 20 ; see LevelCapStepAces

; LevelCapStepFlags entries
DEF CAP_ENGINE_FLAG EQU $8000 ; an engine flag instead of an event flag
DEF CAP_OR EQU $fffe ; or these flags instead

; wCapFlags
DEF CAP_SHARING_F EQU 0 ; giving teammates the EXP Pokémon at the cap couldn't take

; HELD_ENTRY_BOOST params (see HandleHeldEntryItems)
	const_def
	const ENTRY_ATTACK     ; X ATTACK: +2
	const ENTRY_DEFENSE    ; X DEFEND: +2
	const ENTRY_SPEED      ; X SPEED: +2
	const ENTRY_SP_ATTACK  ; X SPECIAL: +2
	const ENTRY_SP_DEFENSE
	const ENTRY_ACCURACY   ; X ACCURACY: +2
	const ENTRY_FOCUS      ; DIRE HIT: pumped up (critical hits)
	const ENTRY_MIST       ; GUARD SPEC.: MIST
DEF NUM_ENTRY_BOOSTS EQU const_value
