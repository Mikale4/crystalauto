; The Demo (see engine/demo/demo.asm)

DEF DEMO_ON_TITLE EQU 0 ; (not on the title menu until it's finished)

; wDemoState
	const_def
	const DEMO_OFF     ; 0
	const DEMO_RUNNING ; 1
	const DEMO_STOPPED ; 2 (the player plays its game; it can carry on)

; wDemoCtx: what is waiting for input (set just before it reads the pad)
	const_def
	const DEMOCTX_TEXT      ; 0: anything else (text, mostly): tap A
	const DEMOCTX_OVERWORLD ; 1: the player can walk: the plan
	const DEMOCTX_MENU      ; 2: a menu (Menu_WasButtonPressed)
	const DEMOCTX_NAMING    ; 3: the naming screen
	const DEMOCTX_PARTY     ; 4: the party menu (PartyMenuSelect)
DEF NUM_DEMOCTXS EQU const_value
; a context with this bit stays until what set it is done (not just one read)
DEF DEMOCTX_HELD_F EQU 7
DEF DEMOCTX_HELD EQU 1 << DEMOCTX_HELD_F

; wDemoSpeed
	const_def
	const DEMOSPEED_1X ; 0
	const DEMOSPEED_2X ; 1
DEF NUM_DEMOSPEEDS EQU const_value

; wDemoSign
DEF DEMOSIGN_PENDING_F EQU 0 ; show the Demo's sign on the next overworld frame
DEF DEMOSIGN_SHOWING_F EQU 1 ; the sign up is the Demo's

; how long the Demo holds a tapped button, and lets go between taps (frames)
DEF DEMO_TAP_FRAMES EQU 3

; demo plan commands (see macros/scripts/demo.asm)
	const_def
	const DPLAN_END       ; 00
	const DPLAN_STATUS    ; 01
	const DPLAN_TRAVEL    ; 02
	const DPLAN_GOTO      ; 03
	const DPLAN_TALK      ; 04
	const DPLAN_UNTIL     ; 05
	const DPLAN_SKIP_IF   ; 06
	const DPLAN_JUMP      ; 07
	const DPLAN_FACE      ; 08
	const DPLAN_PRESS     ; 09
	const DPLAN_STEP      ; 0a
	const DPLAN_HEAL      ; 0b
	const DPLAN_SKIP_IFNOT ; 0c
	const DPLAN_GRIND     ; 0d
	const DPLAN_CATCH     ; 0e
	const DPLAN_BUY       ; 0f
	const DPLAN_GIVE      ; 10
	const DPLAN_TEAM      ; 11
DEF NUM_DPLANS EQU const_value

; wDemoGoal: what the Demo is walking to
	const_def
	const DGOAL_NONE   ; 0
	const DGOAL_CELL   ; 1: stand on (x, y)
	const DGOAL_WARP   ; 2: go through the warp at (x, y)
	const DGOAL_EDGE   ; 3: walk off the map's edge (direction in wDemoGoalArg)
	const DGOAL_FACE   ; 4: stand next to (x, y) facing it
	const DGOAL_GRASS  ; 5: walk about in the map's grass

; world exits (see data/demo/world.asm)
	const_def
	const DEXIT_WARP  ; 0
	const DEXIT_NORTH ; 1
	const DEXIT_SOUTH ; 2
	const DEXIT_WEST  ; 3
	const DEXIT_EAST  ; 4

; the flow field: each cell's way to the goal (a direction), or one of these
DEF DFLOW_UNREACHED EQU $ff
DEF DFLOW_GOAL      EQU $fe

DEF DEMO_QUEUE_SIZE EQU $200 ; cells
DEF DEMO_MAX_WORLD_MAPS EQU 128
DEF DEMO_MAX_BLOCKED EQU 8
DEF DEMO_TEAM_MINUTES EQU 15 ; (of play time: see DemoTimeUp)

; wDemoStatus: what the Demo says it's doing (DemoStatusTexts)
	const_def
	const DSTATUS_STARTING    ; 0
	const DSTATUS_STARTER     ; 1
	const DSTATUS_ERRAND      ; 2
	const DSTATUS_BACK_TO_ELM ; 3
	const DSTATUS_LESSON      ; 4
	const DSTATUS_TO_VIOLET   ; 5
	const DSTATUS_HEALING     ; 6
	const DSTATUS_FALKNER     ; 7
	const DSTATUS_TRAINING    ; 8
	const DSTATUS_CATCHING    ; 9
	const DSTATUS_SHOPPING    ; 10
	const DSTATUS_DONE        ; 11
	const DSTATUS_GIVING      ; 12
DEF NUM_DSTATUSES EQU const_value
