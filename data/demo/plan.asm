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

MACRO dbuy ; ITEM, N, MAP: buy the item at its mart till it has N (0: one each)
	db DPLAN_BUY, \1, \2
	map_id \3
ENDM

MACRO dteam ; N, MAP: battle in the map's grass until the team has N POKéMON
	db DPLAN_TEAM, \1
	map_id \2
ENDM

MACRO dsweep ; MAP: go there and see to everything on it (items, trainers)
	db DPLAN_SWEEP
	map_id \1
ENDM

MACRO dretry ; whatever it left for now (out of reach, or too strong), try again
	db DPLAN_RETRY
ENDM

MACRO dgive ; ITEM: give it to each POKéMON in the team that doesn't hold one
	db DPLAN_GIVE, \1
ENDM

MACRO dpush ; n, DIR: push map object n (a boulder) one cell that way, with STRENGTH
	db DPLAN_PUSH, \1, \2
ENDM

MACRO dtalkfrom ; n, DIR: talk to map object n facing that way
	db DPLAN_TALK_FROM, \1, \2
ENDM

MACRO dfarfetchd ; ILEX FOREST's FARFETCH'D: one step on toward the CHARCOAL KILN
	db DPLAN_FARFETCHD
ENDM

MACRO dtutor ; teach the team the best moves a POKéMON CENTER's MOVE REMINDER and TUTOR have
	db DPLAN_TUTOR
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
; what there is on the way (items, trainers)
	dstatus DSTATUS_EXPLORING
	dsweep ROUTE_29
	dsweep ROUTE_30
	dsweep ROUTE_31
; VIOLET CITY's GYM, with a GEODUDE (it shrugs off the birds' attacks), once the
; team is at the level cap
	dskipif EVENT_BEAT_FALKNER, .BeatFalkner
	dstatus DSTATUS_SHOPPING
	dbuy POKE_BALL, 7, CHERRYGROVE_MART ; (one for each it catches, and a couple over)
	dstatus DSTATUS_CATCHING
	dcatch GEODUDE, ROUTE_46
; a team of five (room for the EGG ELM's AIDE brings after FALKNER), from
; wherever there's something it hasn't caught (for a while on each map: which
; POKéMON are out depends on the time of day)
	dteam PARTY_LENGTH - 1, ROUTE_46
	dteam PARTY_LENGTH - 1, ROUTE_29
	dteam PARTY_LENGTH - 1, ROUTE_31
	dstatus DSTATUS_TRAINING
	dgrind ROUTE_31
.Falkner:
; the moves the MOVE REMINDER and TUTOR have for the team (FLAMETHROWER, ...)
	dtutor
	dstatus DSTATUS_TO_VIOLET
	dheal
; X items for the team to hold (FALKNER's birds are two levels up; each is used
; up as its holder comes in, and back after the battle; a team holds one of each)
	dstatus DSTATUS_SHOPPING
	dbuy X_ATTACK, 1, VIOLET_MART
	dbuy X_DEFEND, 1, VIOLET_MART
	dbuy X_SPEED, 1, VIOLET_MART
	dstatus DSTATUS_GIVING
	dgive X_ATTACK
	dgive X_DEFEND
	dgive X_SPEED
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
; (lost: a team of five for the next try, if it isn't one yet)
	dstatus DSTATUS_CATCHING
	dteam PARTY_LENGTH - 1, ROUTE_31
	dteam PARTY_LENGTH - 1, ROUTE_29
	djump .Falkner
.BeatFalkner:
; SPROUT TOWER: its SAGES, and FLASH from its ELDER
	dskipif EVENT_GOT_HM05_FLASH, .GotFlash
	dstatus DSTATUS_SPROUT_TOWER
	dheal
	dsweep SPROUT_TOWER_1F
	dsweep SPROUT_TOWER_2F
	dsweep SPROUT_TOWER_3F
.Flash:
	dheal
	dtravel SPROUT_TOWER_3F
	dtalk 3 ; SAGE LI (a battle, then FLASH)
	duntil EVENT_GOT_HM05_FLASH, .Flash
.GotFlash:
; the EGG from ELM's AIDE, in VIOLET's POKéMON CENTER once ELM has called (he
; calls when the player is outside); the way south (ROUTE 32) is open after
	dskipif EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE, .GotTogepiEgg
	dstatus DSTATUS_ERRAND
.TogepiEgg:
	dtravel VIOLET_CITY
	dgoto 18, 20
	dtravel VIOLET_POKECENTER_1F
	dtalk 5 ; ELM's AIDE
	duntil EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE, .TogepiEgg
.GotTogepiEgg:
; on to AZALEA TOWN
	dstatus DSTATUS_EXPLORING
	dsweep ROUTE_32
	dsweep UNION_CAVE_1F
	dsweep ROUTE_33
; KURT, and the SLOWPOKE WELL (beating its ROCKETS sends the player to KURT's)
	dskipif EVENT_CLEARED_SLOWPOKE_WELL, .ClearedWell
	dstatus DSTATUS_SLOWPOKE_WELL
.Kurt:
	dskipif EVENT_AZALEA_TOWN_SLOWPOKETAIL_ROCKET, .WellOpen
	dtravel KURTS_HOUSE
	dtalk 1 ; KURT (he hurries off to the WELL)
	duntil EVENT_AZALEA_TOWN_SLOWPOKETAIL_ROCKET, .Kurt
.WellOpen:
	dheal
	dsweep SLOWPOKE_WELL_B1F
	duntil EVENT_CLEARED_SLOWPOKE_WELL, .WellOpen
.ClearedWell:
	dskipif EVENT_KURT_GAVE_YOU_LURE_BALL, .GotLureBall
.LureBall:
	dtravel KURTS_HOUSE
	dtalk 1 ; KURT
	duntil EVENT_KURT_GAVE_YOU_LURE_BALL, .LureBall
.GotLureBall:
; BUGSY, with the team at the level cap
	dskipif EVENT_BEAT_BUGSY, .BeatBugsy
	dstatus DSTATUS_TRAINING
	dgrind ROUTE_33
.Bugsy:
	dtutor
	dstatus DSTATUS_BUGSY
	dheal
	dtravel AZALEA_GYM
	dsweep AZALEA_GYM
	dheal
	dtravel AZALEA_GYM
	dtalk 1 ; BUGSY
	dskipif EVENT_BEAT_BUGSY, .BeatBugsy
	djump .Bugsy
.BeatBugsy:
; the CHARCOAL KILN's FARFETCH'D, and HM01 CUT for finding it
	dskipif EVENT_GOT_HM01_CUT, .GotCut
	dstatus DSTATUS_FARFETCHD
.Herd:
	dskipif EVENT_HERDED_FARFETCHD, .Herded
	dtravel ILEX_FOREST
	dfarfetchd
	djump .Herd
.Herded:
	dtravel ILEX_FOREST
	dtalk 3 ; the CHARCOAL KILN's master
	duntil EVENT_GOT_HM01_CUT, .Herded
.GotCut:
	dstatus DSTATUS_EXPLORING
	dsweep ILEX_FOREST
	dsweep ROUTE_34
	dstatus DSTATUS_DONE
	dend

DemoWantedMons:
; what the Demo throws its BALLS at (once each): a GEODUDE, and a team of POKéMON
; that can fight (not the cocoons, nor HOPPIP: no attack till level 10)
	db GEODUDE
	db SPEAROW
	db PIDGEY
	db SENTRET
	db HOOTHOOT
	db BELLSPROUT
	db LEDYBA
	db SPINARAK
	db -1
