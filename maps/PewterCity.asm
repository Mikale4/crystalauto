	object_const_def
	const PEWTERCITY_COOLTRAINER_F
	const PEWTERCITY_BUG_CATCHER
	const PEWTERCITY_GRAMPS
	const PEWTERCITY_FRUIT_TREE1
	const PEWTERCITY_FRUIT_TREE2
	const PEWTERCITY_SCIENTIST

PewterCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, PewterCityFlypointCallback

PewterCityFlypointCallback:
	setflag ENGINE_FLYPOINT_PEWTER
	endcallback

PewterCityCooltrainerFScript:
	jumptextfaceplayer PewterCityCooltrainerFText

PewterCityBugCatcherScript:
	jumptextfaceplayer PewterCityBugCatcherText

PewterCityGrampsScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_SILVER_WING
	iftrue .GotSilverWing
	writetext PewterCityGrampsText
	promptbutton
	verbosegiveitem SILVER_WING
	setevent EVENT_GOT_SILVER_WING
	closetext
	end

.GotSilverWing:
	writetext PewterCityGrampsText_GotSilverWing
	waitbutton
	closetext
	end

PewterCityFossilScientistScript:
; The PEWTER MUSEUM's scientist brings FOSSILS back to life (they're found in the
; RUINS OF ALPH's item rooms).
	faceplayer
	opentext
	checkitem HELIX_FOSSIL
	iftrue .Helix
	checkitem DOME_FOSSIL
	iftrue .Dome
	checkitem OLD_AMBER
	iftrue .Amber
	writetext PewterCityFossilScientistText
	waitbutton
	closetext
	end

.Helix:
	writetext PewterCityHelixFossilText
	yesorno
	iffalse .No
	callasm CheckRoomForGiftMon
	iffalse .NoRoom
	takeitem HELIX_FOSSIL
	setmonval OMANYTE
	sjump .Revive

.Dome:
	writetext PewterCityDomeFossilText
	yesorno
	iffalse .No
	callasm CheckRoomForGiftMon
	iffalse .NoRoom
	takeitem DOME_FOSSIL
	setmonval KABUTO
	sjump .Revive

.Amber:
	writetext PewterCityOldAmberText
	yesorno
	iffalse .No
	callasm CheckRoomForGiftMon
	iffalse .NoRoom
	takeitem OLD_AMBER
	setmonval AERODACTYL
.Revive:
	writetext PewterCityRevivingText
	waitbutton
	closetext
	special FadeOutToWhite
	playsound SFX_WARP_FROM
	waitsfx
	special FadeInFromWhite
	opentext
	getmonname STRING_BUFFER_3, 0
	writetext PewterCityRevivedText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke 0, 20
	closetext
	end

.No:
	writetext PewterCityFossilNoText
	waitbutton
	closetext
	end

.NoRoom:
	writetext PewterCityFossilNoRoomText
	waitbutton
	closetext
	end

PewterCitySign:
	jumptext PewterCitySignText

PewterGymSign:
	jumptext PewterGymSignText

PewterMuseumSign:
	jumptext PewterMuseumSignText

PewterCityMtMoonGiftShopSign:
	jumptext PewterCityMtMoonGiftShopSignText

PewterCityWelcomeSign:
	jumptext PewterCityWelcomeSignText

PewterCityPokecenterSign:
	jumpstd PokecenterSignScript

PewterCityMartSign:
	jumpstd MartSignScript

PewterCityFruitTree1:
	fruittree FRUITTREE_PEWTER_CITY_1

PewterCityFruitTree2:
	fruittree FRUITTREE_PEWTER_CITY_2

PewterCityCooltrainerFText:
	text "Have you visited"
	line "PEWTER GYM?"

	para "The LEADER uses"
	line "rock-type #MON."
	done

PewterCityBugCatcherText:
	text "At night, CLEFAIRY"
	line "come out to play"
	cont "at MT.MOON."

	para "But not every"
	line "night."
	done

PewterCityGrampsText:
	text "Ah, you came all"
	line "the way out here"
	cont "from JOHTO?"

	para "That brings back"
	line "memories. When I"

	para "was young, I went"
	line "to JOHTO to train."

	para "You remind me so"
	line "much of what I was"

	para "like as a young"
	line "man."

	para "Here. I want you"
	line "to have this item"
	cont "I found in JOHTO."
	done

PewterCityGrampsText_GotSilverWing:
	text "Going to new, un-"
	line "known places and"
	cont "seeing new people…"

	para "Those are the joys"
	line "of travel."
	done

PewterCitySignText:
	text "PEWTER CITY"
	line "A Stone Gray City"
	done

PewterGymSignText:
	text "PEWTER CITY"
	line "#MON GYM"
	cont "LEADER: BROCK"

	para "The Rock Solid"
	line "#MON Trainer"
	done

PewterMuseumSignText:
	text "There's a notice"
	line "here…"

	para "PEWTER MUSEUM OF"
	line "SCIENCE is closed"
	cont "for renovations…"

	para "Our scientist will"
	line "revive FOSSILS"
	cont "outside meanwhile."
	done

PewterCityFossilScientistText:
	text "The MUSEUM may be"
	line "closed, but my lab"
	cont "isn't!"

	para "I can bring a"
	line "FOSSIL back to"
	cont "life!"

	para "They say FOSSILS"
	line "turn up in the"
	cont "RUINS OF ALPH."
	done

PewterCityHelixFossilText:
	text "That's a HELIX"
	line "FOSSIL! It's from"
	cont "an OMANYTE."

	para "Shall I bring it"
	line "back to life?"
	done

PewterCityDomeFossilText:
	text "That's a DOME"
	line "FOSSIL! It's from"
	cont "a KABUTO."

	para "Shall I bring it"
	line "back to life?"
	done

PewterCityOldAmberText:
	text "That's OLD AMBER!"
	line "There's AERODACTYL"
	cont "DNA in it."

	para "Shall I bring it"
	line "back to life?"
	done

PewterCityRevivingText:
	text "Leave it to me!"
	line "Here goes…"
	done

PewterCityRevivedText:
	text "It's alive!"

	para "<PLAYER> received"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

PewterCityFossilNoText:
	text "Come back if you"
	line "change your mind."
	done

PewterCityFossilNoRoomText:
	text "You've no room for"
	line "a #MON, even in"
	cont "your PC!"
	done

PewterCityMtMoonGiftShopSignText:
	text "There's a notice"
	line "here…"

	para "MT.MOON GIFT SHOP"
	line "NOW OPEN!"
	done

PewterCityWelcomeSignText:
	text "WELCOME TO"
	line "PEWTER CITY!"
	done

PewterCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 29, 13, PEWTER_NIDORAN_SPEECH_HOUSE, 1
	warp_event 16, 17, PEWTER_GYM, 1
	warp_event 23, 17, PEWTER_MART, 2
	warp_event 13, 25, PEWTER_POKECENTER_1F, 1
	warp_event  7, 29, PEWTER_SNOOZE_SPEECH_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 25, 23, BGEVENT_READ, PewterCitySign
	bg_event 11, 17, BGEVENT_READ, PewterGymSign
	bg_event 15,  9, BGEVENT_READ, PewterMuseumSign
	bg_event 33, 19, BGEVENT_READ, PewterCityMtMoonGiftShopSign
	bg_event 19, 29, BGEVENT_READ, PewterCityWelcomeSign
	bg_event 14, 25, BGEVENT_READ, PewterCityPokecenterSign
	bg_event 24, 17, BGEVENT_READ, PewterCityMartSign

	def_object_events
	object_event 19, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PewterCityCooltrainerFScript, -1
	object_event 14, 29, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, PewterCityBugCatcherScript, -1
	object_event 29, 17, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PewterCityGrampsScript, -1
	object_event 32,  3, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PewterCityFruitTree1, -1
	object_event 30,  3, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PewterCityFruitTree2, -1
	object_event 16, 10, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PewterCityFossilScientistScript, -1
