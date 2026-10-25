; The Demo's plan (see engine/demo/demo.asm): what to do, in order. Each step
; checks what's already done, so the plan picks up wherever the game is.

MACRO dstatus ; DSTATUS_*: what it says it's doing
	db DPLAN_STATUS, \1
ENDM

MACRO dtravel ; MAP: walk there
	db DPLAN_TRAVEL
	map_id \1
ENDM

MACRO dgoto ; x, y: walk to that cell of this map
	db DPLAN_GOTO, \1, \2
ENDM

MACRO dtalk ; n: talk to map object n (its object_event, counting from 1)
	db DPLAN_TALK, \1
ENDM

MACRO duntil ; EVENT, label: back to the label until the event flag is set
	db DPLAN_UNTIL
	dw \1, \2
ENDM

MACRO dskipif ; EVENT, label: on to the label if the event flag is set
	db DPLAN_SKIP_IF
	dw \1, \2
ENDM

MACRO dskipifnot ; EVENT, label: on to the label if it isn't
	db DPLAN_SKIP_IFNOT
	dw \1, \2
ENDM

MACRO djump ; label
	db DPLAN_JUMP
	dw \1
ENDM

MACRO dface ; DIR
	db DPLAN_FACE, \1
ENDM

MACRO dpress ; PAD_*
	db DPLAN_PRESS, \1
ENDM

MACRO dstep ; DIR: one step that way
	db DPLAN_STEP, \1
ENDM

MACRO dheal ; heal up at the nearest POKéMON CENTER, if the team needs it
	db DPLAN_HEAL
ENDM

MACRO dgrind ; MAP: battle in its grass until the team is at the level cap
	db DPLAN_GRIND
	map_id \1
ENDM

MACRO dcatch ; SPECIES, MAP: battle in the map's grass until one is caught
	db DPLAN_CATCH, \1
	map_id \2
ENDM

MACRO dbuy ; N, MAP: buy POKé BALLS at its mart, up to N
	db DPLAN_BUY, \1
	map_id \2
ENDM

MACRO dend
	db DPLAN_END
ENDM

DemoPlan:
	dstatus DSTATUS_STARTING
; your first POKéMON
	dskipif EVENT_GOT_A_POKEMON_FROM_ELM, .GotStarter
	dstatus DSTATUS_STARTER
.Starter:
	dtravel ELMS_LAB
	dtalk 3 ; CYNDAQUIL's BALL
	duntil EVENT_GOT_A_POKEMON_FROM_ELM, .Starter
.GotStarter:
; MR. POKéMON's egg
	dskipif EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON, .GotEgg
	dstatus DSTATUS_ERRAND
.Egg:
	dtravel MR_POKEMONS_HOUSE
	dtalk 1 ; MR. POKéMON
	duntil EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON, .Egg
.GotEgg:
; back to ELM (the rival waits in CHERRYGROVE CITY)
	dskipif EVENT_GAVE_MYSTERY_EGG_TO_ELM, .GaveEgg
	dstatus DSTATUS_BACK_TO_ELM
.GiveEgg:
	dtravel ELMS_LAB
	dtalk 1 ; ELM
	duntil EVENT_GAVE_MYSTERY_EGG_TO_ELM, .GiveEgg
.GaveEgg:
; the DUDE's lesson on ROUTE 29 (the aide hands over POKé BALLS on the way out)
	dskipif EVENT_LEARNED_TO_CATCH_POKEMON, .Learned
	dstatus DSTATUS_LESSON
.Lesson:
	dtravel ROUTE_29
	dgoto 53, 8
	duntil EVENT_LEARNED_TO_CATCH_POKEMON, .Lesson
.Learned:
; VIOLET CITY's GYM, with a GEODUDE (it shrugs off the birds' attacks), once the
; team is at the level cap
	dskipif EVENT_BEAT_FALKNER, .BeatFalkner
	dstatus DSTATUS_SHOPPING
	dbuy 10, CHERRYGROVE_MART
	dstatus DSTATUS_CATCHING
	dcatch GEODUDE, ROUTE_46
	dstatus DSTATUS_TRAINING
	dgrind ROUTE_31
.Falkner:
	dstatus DSTATUS_TO_VIOLET
	dheal
	dstatus DSTATUS_FALKNER
	dtravel VIOLET_GYM
; the GYM's trainers first, then (healed again) FALKNER
	dskipif EVENT_BEAT_BIRD_KEEPER_ROD, .BeatRod
	dtalk 2 ; ROD
	djump .Falkner
.BeatRod:
	dskipif EVENT_BEAT_BIRD_KEEPER_ABE, .BeatAbe
	dtalk 3 ; ABE
	djump .Falkner
.BeatAbe:
	dtalk 1 ; FALKNER
	dskipif EVENT_BEAT_FALKNER, .BeatFalkner
	djump .Falkner
.BeatFalkner:
	dstatus DSTATUS_DONE
	dend

DemoWantedMons:
; what the Demo throws its BALLS at (once each): a GEODUDE, and a team of POKéMON
; that can fight (not the cocoons)
	db GEODUDE
	db SPEAROW
	db PIDGEY
	db SENTRET
	db HOOTHOOT
	db HOPPIP
	db BELLSPROUT
	db -1
