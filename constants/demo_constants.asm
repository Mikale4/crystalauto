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
	const DEMOCTX_POKEGEAR  ; 5: the POKéGEAR
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
	const DPLAN_SWEEP     ; 12
	const DPLAN_RETRY     ; 13
	const DPLAN_PUSH      ; 14
	const DPLAN_TALK_FROM ; 15
	const DPLAN_FARFETCHD ; 16
	const DPLAN_TUTOR     ; 17
	const DPLAN_ANSWERS   ; 18
	const DPLAN_FLUTE     ; 19
	const DPLAN_TALK_AT   ; 1a
	const DPLAN_SKIP_IF_MAP ; 1b
DEF NUM_DPLANS EQU const_value

; wDemoGoal: what the Demo is walking to
	const_def
	const DGOAL_NONE   ; 0
	const DGOAL_CELL   ; 1: stand on (x, y)
	const DGOAL_WARP   ; 2: go through the warp at (x, y)
	const DGOAL_EDGE   ; 3: walk off the map's edge (direction in wDemoGoalArg)
	const DGOAL_FACE   ; 4: stand next to (x, y) facing it
	const DGOAL_GRASS  ; 5: walk about in the map's grass
	const DGOAL_SWEEP  ; 6: next to the nearest of the map's targets still to do (DemoTargetOpen)

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
DEF NUM_DEMO_WORLD_MAPS EQU 388 ; (every map: see data/demo/world.asm)
DEF NUM_DEMO_NODES EQU 693 ; (see data/demo/world_nodes.asm)
DEF DEMO_MAX_START_NODES EQU 24

; DemoNodeEdges kinds: each edge is its kind, the warp (from 1) or direction, the
; node it leads to (dw), the field moves it needs (DEMOFIELD_* bits)
	const_def
	const DEDGE_WARP ; 0: through a warp of the map
	const DEDGE_EDGE ; 1: off the map's edge (UP, DOWN, LEFT, RIGHT)
	const DEDGE_WALK ; 2: to another region of the map
DEF DEMO_EDGE_LENGTH EQU 5

; wDemoSearchFor: what DemoNodeSearch is looking for
	const_def
	const DEMOSEARCH_MAP    ; 0: a map (wDemoRouteTo)
	const DEMOSEARCH_CENTER ; 1: a POKéMON CENTER
DEF NUM_DEMO_TARGETS EQU 592

; DemoTargets kinds
	const_def
	const DTARGET_ITEMBALL ; 0: an item ball (its object)
	const DTARGET_HIDDEN   ; 1: a hidden item (its x, y)
	const DTARGET_TRAINER  ; 2: a trainer (its object)
DEF DEMO_MAX_BLOCKED EQU 32

; wDemoFieldMoves: what the team can get past (see DemoFieldMoves)
DEF DEMOFIELD_CUT_F        EQU 0 ; CUT trees
DEF DEMOFIELD_SURF_F       EQU 1 ; water
DEF DEMOFIELD_WHIRLPOOL_F  EQU 2 ; whirlpools
DEF DEMOFIELD_WATERFALL_F  EQU 3 ; waterfalls (up them)
DEF DEMOFIELD_ROCK_SMASH_F EQU 4 ; rocks
DEF DEMO_TEAM_MINUTES EQU 15 ; (of play time: see DemoTimeUp)
DEF DEMO_ENGINE_FLAG EQU $8000 ; (in a plan's flag: an engine flag, see DemoCheckEvent)
DEF DEMO_POKE_FLUTE_KNOB EQU 78 ; the radio's tuning for the POKé FLUTE channel (see RadioChannels)
DEF DEMO_MAX_TUTORING EQU 24 ; visits to the MOVE REMINDER and TUTOR for a dtutor (see DemoPlan_Tutor)

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
	const DSTATUS_EXPLORING   ; 13
	const DSTATUS_SPROUT_TOWER ; 14
	const DSTATUS_SLOWPOKE_WELL ; 15
	const DSTATUS_BUGSY       ; 16
	const DSTATUS_FARFETCHD   ; 17
	const DSTATUS_MOVES       ; 18
	const DSTATUS_WHITNEY     ; 19
	const DSTATUS_SQUIRTBOTTLE ; 20
	const DSTATUS_SUDOWOODO   ; 21
	const DSTATUS_BURNED_TOWER ; 22
	const DSTATUS_MORTY       ; 23
	const DSTATUS_KIMONO_GIRLS ; 24
	const DSTATUS_LIGHTHOUSE  ; 25
	const DSTATUS_CHUCK       ; 26
	const DSTATUS_JASMINE     ; 27
	const DSTATUS_LAKE_OF_RAGE ; 28
	const DSTATUS_HIDEOUT     ; 29
	const DSTATUS_PRYCE       ; 30
	const DSTATUS_RADIO_TOWER ; 31
	const DSTATUS_CLAIR       ; 32
	const DSTATUS_DRAGONS_DEN ; 33
	const DSTATUS_VICTORY_ROAD ; 34
	const DSTATUS_ELITE_FOUR  ; 35
	const DSTATUS_SS_AQUA     ; 36
	const DSTATUS_LTSURGE     ; 37
	const DSTATUS_SABRINA     ; 38
	const DSTATUS_ERIKA       ; 39
	const DSTATUS_POWER_PLANT ; 40
	const DSTATUS_MISTY       ; 41
	const DSTATUS_JANINE      ; 42
	const DSTATUS_SNORLAX     ; 43
	const DSTATUS_BROCK       ; 44
	const DSTATUS_BLAINE      ; 45
	const DSTATUS_BLUE        ; 46
	const DSTATUS_RED         ; 47
DEF NUM_DSTATUSES EQU const_value
