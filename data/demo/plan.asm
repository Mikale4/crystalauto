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
	dsweep GOLDENROD_CITY
; the BICYCLE
	dskipif EVENT_GOT_BICYCLE, .GotBike
.Bike:
	dtravel GOLDENROD_BIKE_SHOP
	dtalk 1 ; the clerk
	duntil EVENT_GOT_BICYCLE, .Bike
.GotBike:
	dsweep ROUTE_35
	dsweep NATIONAL_PARK
; WHITNEY, with the team at the level cap; she cries, and once she's done (a
; step onto (8, 5) brings her friend) she hands over the badge and TM45
	dskipif EVENT_GOT_TM45_ATTRACT, .GotPlainBadge
	dskipif EVENT_BEAT_WHITNEY, .BeatWhitney
	dstatus DSTATUS_TRAINING
	dgrind ROUTE_35
.Whitney:
	dtutor
	dstatus DSTATUS_WHITNEY
	dheal
	dsweep GOLDENROD_GYM
	dheal
	dtravel GOLDENROD_GYM
	dtalk 1 ; WHITNEY
	dskipif EVENT_BEAT_WHITNEY, .BeatWhitney
	djump .Whitney
.BeatWhitney:
	dtravel GOLDENROD_GYM
	dgoto 8, 6
	dgoto 8, 5
	dtalk 1 ; WHITNEY
	duntil EVENT_GOT_TM45_ATTRACT, .BeatWhitney
.GotPlainBadge:
; the SQUIRTBOTTLE: FLORIA by the odd tree on ROUTE 36, then at her sister's
; FLOWER SHOP, where her sister gives it
	dskipif EVENT_GOT_SQUIRTBOTTLE, .GotSquirtbottle
	dstatus DSTATUS_SQUIRTBOTTLE
.Floria:
	dskipif EVENT_MET_FLORIA, .MetFloria
	dtravel ROUTE_36
	dtalk 8 ; FLORIA
	duntil EVENT_MET_FLORIA, .Floria
.MetFloria:
	dskipif EVENT_TALKED_TO_FLORIA_AT_FLOWER_SHOP, .FloriaAtShop
	dtravel GOLDENROD_FLOWER_SHOP
	dtalk 2 ; FLORIA
	duntil EVENT_TALKED_TO_FLORIA_AT_FLOWER_SHOP, .MetFloria
.FloriaAtShop:
	dtravel GOLDENROD_FLOWER_SHOP
	dtalk 1 ; her sister
	duntil EVENT_GOT_SQUIRTBOTTLE, .FloriaAtShop
.GotSquirtbottle:
; the odd tree: water from the SQUIRTBOTTLE (YES), and it's a SUDOWOODO
	dskipif EVENT_FOUGHT_SUDOWOODO, .FoughtSudowoodo
.Sudowoodo:
	dtutor
	dstatus DSTATUS_SUDOWOODO
	dheal
	dtravel ROUTE_36
	dtalk 3 ; SUDOWOODO
	duntil EVENT_FOUGHT_SUDOWOODO, .Sudowoodo
.FoughtSudowoodo:
	dstatus DSTATUS_EXPLORING
	dsweep ROUTE_36
	dsweep ROUTE_37
	dsweep ECRUTEAK_CITY
; the BURNED TOWER: the rival (then the floor gives way), and the three beasts
; in the basement (MORTY's GYM opens after)
	dskipif EVENT_RELEASED_THE_BEASTS, .ReleasedBeasts
	dstatus DSTATUS_TRAINING
	dgrind ROUTE_37
.BurnedTower:
	dskipif EVENT_BEAT_RIVAL_IN_BURNED_TOWER, .FellThrough
	dtutor
	dstatus DSTATUS_BURNED_TOWER
	dheal
	dtravel BURNED_TOWER_1F
	dgoto 11, 9
	djump .BurnedTower
.FellThrough:
	dstatus DSTATUS_BURNED_TOWER
	dtravel BURNED_TOWER_B1F
	dgoto 10, 6
	duntil EVENT_RELEASED_THE_BEASTS, .FellThrough
.ReleasedBeasts:
	dstatus DSTATUS_EXPLORING
	dsweep BURNED_TOWER_B1F
	dsweep BURNED_TOWER_1F
; MORTY, with the team at the level cap
	dskipif EVENT_BEAT_MORTY, .BeatMorty
	dstatus DSTATUS_TRAINING
	dgrind ROUTE_38
.Morty:
	dtutor
	dstatus DSTATUS_MORTY
	dheal
	dsweep ECRUTEAK_GYM
	dheal
	dtravel ECRUTEAK_GYM
	dtalk 1 ; MORTY
	dskipif EVENT_BEAT_MORTY, .BeatMorty
	djump .Morty
.BeatMorty:
; HM03 SURF: the DANCE THEATER's KIMONO GIRLS, then the gentleman
	dskipif EVENT_GOT_HM03_SURF, .GotSurf
	dstatus DSTATUS_KIMONO_GIRLS
.Kimono:
	dheal
	dsweep DANCE_THEATER
	dtravel DANCE_THEATER
	dtalk 6 ; the gentleman
	duntil EVENT_GOT_HM03_SURF, .Kimono
.GotSurf:
	dstatus DSTATUS_EXPLORING
	dsweep ROUTE_38
	dsweep ROUTE_39
	dsweep OLIVINE_CITY
; HM04 STRENGTH, from the sailor in OLIVINE's CAFE
	dskipif EVENT_GOT_HM04_STRENGTH, .GotStrength
.Strength:
	dtravel OLIVINE_CAFE
	dtalk 1 ; the sailor
	duntil EVENT_GOT_HM04_STRENGTH, .Strength
.GotStrength:
; the LIGHTHOUSE: JASMINE, at the top with the sick AMPHAROS
	dskipif EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS, .JasmineExplained
	dstatus DSTATUS_LIGHTHOUSE
	dsweep OLIVINE_LIGHTHOUSE_1F
	dsweep OLIVINE_LIGHTHOUSE_2F
	dsweep OLIVINE_LIGHTHOUSE_3F
	dsweep OLIVINE_LIGHTHOUSE_4F
	dsweep OLIVINE_LIGHTHOUSE_5F
.Lighthouse:
	dheal
	dtravel OLIVINE_LIGHTHOUSE_6F
	dtalk 1 ; JASMINE
	duntil EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS, .Lighthouse
.JasmineExplained:
; the team at the level cap for the next three GYMS (CHUCK, JASMINE, PRYCE)
	dskipif EVENT_BEAT_CHUCK, .BeatChuck
	dstatus DSTATUS_TRAINING
	dgrind ROUTE_39
; across the sea to CIANWOOD CITY, and CHUCK: his half of the GYM is behind
; boulders (the middle one, pushed up twice, opens it; they're back each time
; the player comes in)
	dstatus DSTATUS_EXPLORING
	dsweep ROUTE_40
	dsweep ROUTE_41
	dsweep CIANWOOD_CITY
.Chuck:
	dtutor
	dstatus DSTATUS_CHUCK
	dheal
	dtravel CIANWOOD_GYM
	dpush 8, UP
	dpush 8, UP
	dsweep CIANWOOD_GYM
	dheal
	dtravel CIANWOOD_GYM
	dpush 8, UP
	dpush 8, UP
	dtalk 1 ; CHUCK
	dskipif EVENT_BEAT_CHUCK, .BeatChuck
	djump .Chuck
.BeatChuck:
; HM02 FLY from CHUCK's wife, and the SECRETPOTION from the PHARMACY
	dskipif EVENT_GOT_HM02_FLY, .GotFly
.Fly:
	dtravel CIANWOOD_CITY
	dtalk 10 ; CHUCK's wife
	duntil EVENT_GOT_HM02_FLY, .Fly
.GotFly:
	dskipif EVENT_GOT_SECRETPOTION_FROM_PHARMACY, .GotSecretpotion
	dstatus DSTATUS_LIGHTHOUSE
.Secretpotion:
	dtravel CIANWOOD_PHARMACY
	dtalk 1 ; the pharmacist
	duntil EVENT_GOT_SECRETPOTION_FROM_PHARMACY, .Secretpotion
.GotSecretpotion:
; the medicine for AMPHAROS (YES): JASMINE goes back to her GYM
	dskipif EVENT_JASMINE_RETURNED_TO_GYM, .JasmineBack
	dstatus DSTATUS_LIGHTHOUSE
.Medicine:
	dheal
	dtravel OLIVINE_LIGHTHOUSE_6F
	dtalk 1 ; JASMINE
	duntil EVENT_JASMINE_RETURNED_TO_GYM, .Medicine
.JasmineBack:
	dskipif EVENT_BEAT_JASMINE, .BeatJasmine
.Jasmine:
	dtutor
	dstatus DSTATUS_JASMINE
	dheal
	dsweep OLIVINE_GYM
	dheal
	dtravel OLIVINE_GYM
	dtalk 1 ; JASMINE
	dskipif EVENT_BEAT_JASMINE, .BeatJasmine
	djump .Jasmine
.BeatJasmine:
; on east to MAHOGANY TOWN, and north to the LAKE OF RAGE: its red GYARADOS (on
; the water: gone once it's beaten), then LANCE (YES: he's off to the ROCKETS'
; hideout)
	dstatus DSTATUS_EXPLORING
	dsweep ROUTE_42
	dsweep MAHOGANY_TOWN
	dsweep ROUTE_43
	dsweep LAKE_OF_RAGE
	dskipif EVENT_DECIDED_TO_HELP_LANCE, .HelpingLance
	dstatus DSTATUS_LAKE_OF_RAGE
.RedGyarados:
	dskipif EVENT_LAKE_OF_RAGE_RED_GYARADOS, .Lance
	dtutor
	dheal
	dtravel LAKE_OF_RAGE
	dtalk 9 ; the red GYARADOS
	djump .RedGyarados
.Lance:
	dtravel LAKE_OF_RAGE
	dtalk 1 ; LANCE
	duntil EVENT_DECIDED_TO_HELP_LANCE, .Lance
.HelpingLance:
; the ROCKETS' hideout, under MAHOGANY's shop: its trainers and items, then on
; B3F the two grunts' passwords (a word each, after the battle), the boss's
; door, the boss and its MURKROW; then on B2F the door to the transmitter, its
; boss, and the three ELECTRODE powering it (there's no leaving till they're
; beaten)
	dskipif EVENT_CLEARED_ROCKET_HIDEOUT, .ClearedHideout
	dstatus DSTATUS_HIDEOUT
	dheal
	dsweep TEAM_ROCKET_BASE_B1F
	dsweep TEAM_ROCKET_BASE_B2F
	dsweep TEAM_ROCKET_BASE_B3F
.Slowpoketail:
	dskipif EVENT_LEARNED_SLOWPOKETAIL, .RaticateTail
	dtravel TEAM_ROCKET_BASE_B3F
	dtalk 4 ; the ROCKET girl
	djump .Slowpoketail
.RaticateTail:
	dskipif EVENT_LEARNED_RATICATE_TAIL, .OfficeDoor
	dtravel TEAM_ROCKET_BASE_B3F
	dtalk 5 ; the ROCKET
	djump .RaticateTail
.OfficeDoor:
	dskipif EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE, .OfficeOpen
	dtravel TEAM_ROCKET_BASE_B3F
	dgoto 8, 10 ; (the rival, the first time)
	dgoto 10, 10
	dface UP
	dpress PAD_A
	djump .OfficeDoor
.OfficeOpen:
	dskipif EVENT_BEAT_ROCKET_EXECUTIVEM_4, .BeatExecutive
	dheal
	dtravel TEAM_ROCKET_BASE_B3F
	dgoto 10, 8
	djump .OfficeOpen
.BeatExecutive:
	dskipif EVENT_LEARNED_HAIL_GIOVANNI, .HailGiovanni
	dtravel TEAM_ROCKET_BASE_B3F
	dtalk 3 ; the MURKROW
	djump .BeatExecutive
.HailGiovanni:
	dskipif EVENT_OPENED_DOOR_TO_ROCKET_HIDEOUT_TRANSMITTER, .TransmitterOpen
	dtravel TEAM_ROCKET_BASE_B2F
	dgoto 14, 13
	dface UP
	dpress PAD_A
	djump .HailGiovanni
.TransmitterOpen:
	dskipif EVENT_BEAT_ROCKET_EXECUTIVEF_2, .Electrodes
	dheal
	dtravel TEAM_ROCKET_BASE_B2F
	dgoto 14, 11
	djump .TransmitterOpen
.Electrodes:
	dtravel TEAM_ROCKET_BASE_B2F
	dtalk 5 ; an ELECTRODE
	dtalk 6
	dtalk 7
	duntil EVENT_CLEARED_ROCKET_HIDEOUT, .Electrodes
.ClearedHideout:
; PRYCE (across his GYM's ice)
	dskipif EVENT_BEAT_PRYCE, .BeatPryce
.Pryce:
	dtutor
	dstatus DSTATUS_PRYCE
	dheal
	dsweep MAHOGANY_GYM
	dheal
	dtravel MAHOGANY_GYM
	dtalk 1 ; PRYCE
	dskipif EVENT_BEAT_PRYCE, .BeatPryce
	djump .Pryce
.BeatPryce:
; GOLDENROD's RADIO TOWER, taken over by the ROCKETS: their fake director on 5F
; (the BASEMENT KEY), the UNDERGROUND's locked door, the switches that open the
; way to the warehouse (3, then 2, then 1), the real director there (the CARD
; KEY), the card slot on 3F, and the ROCKETS' boss on 5F
	dskipif EVENT_CLEARED_RADIO_TOWER, .ClearedRadioTower
	dstatus DSTATUS_RADIO_TOWER
.FakeDirector:
	dskipif EVENT_BEAT_ROCKET_EXECUTIVEM_3, .BasementKey
	dtutor
	dheal
	dsweep RADIO_TOWER_1F
	dsweep RADIO_TOWER_2F
	dsweep RADIO_TOWER_3F
	dsweep RADIO_TOWER_4F
	dheal
	dtravel RADIO_TOWER_5F
	dgoto 0, 3
	djump .FakeDirector
.BasementKey:
	dskipif EVENT_USED_BASEMENT_KEY, .BasementOpen
	dtravel GOLDENROD_UNDERGROUND
	dgoto 18, 7
	dface UP
	dpress PAD_A
	djump .BasementKey
.BasementOpen:
	dskipif EVENT_RECEIVED_CARD_KEY, .GotCardKey
	dheal
	dsweep GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES
.Switch3:
	dskipif EVENT_SWITCH_3, .Switch2
	dtravel GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES
	dgoto 2, 2
	dface UP
	dpress PAD_A
	djump .Switch3
.Switch2:
	dskipif EVENT_SWITCH_2, .Switch1
	dtravel GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES
	dgoto 10, 2
	dface UP
	dpress PAD_A
	djump .Switch2
.Switch1:
	dskipif EVENT_SWITCH_1, .CardKey
	dtravel GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES
	dgoto 16, 2
	dface UP
	dpress PAD_A
	djump .Switch1
.CardKey:
	dheal
	dsweep GOLDENROD_UNDERGROUND_WAREHOUSE
	dtravel GOLDENROD_UNDERGROUND_WAREHOUSE
	dtalk 4 ; the director
	duntil EVENT_RECEIVED_CARD_KEY, .BasementOpen
.GotCardKey:
	dskipif EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER, .CardKeyUsed
	dtravel RADIO_TOWER_3F
	dgoto 14, 3
	dface UP
	dpress PAD_A
	djump .GotCardKey
.CardKeyUsed:
	dtutor
	dheal
	dsweep RADIO_TOWER_3F
	dsweep RADIO_TOWER_4F
	dsweep RADIO_TOWER_5F
	dheal
	dtravel RADIO_TOWER_5F
	dgoto 16, 5
	duntil EVENT_CLEARED_RADIO_TOWER, .CardKeyUsed
.ClearedRadioTower:
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
