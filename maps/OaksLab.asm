	object_const_def
	const OAKSLAB_OAK
	const OAKSLAB_SCIENTIST1
	const OAKSLAB_SCIENTIST2
	const OAKSLAB_SCIENTIST3
	const OAKSLAB_BULBASAUR_BALL
	const OAKSLAB_CHARMANDER_BALL
	const OAKSLAB_SQUIRTLE_BALL

OaksLab_MapScripts:
	def_scene_scripts

	def_callbacks

OaksLabNoopScene: ; unreferenced
	end

Oak:
	faceplayer
	opentext
	checkevent EVENT_OPENED_MT_SILVER
	iftrue .CheckStarters
	checkevent EVENT_TALKED_TO_OAK_IN_KANTO
	iftrue .CheckBadges
	writetext OakWelcomeKantoText
	promptbutton
	setevent EVENT_TALKED_TO_OAK_IN_KANTO
.CheckBadges:
	checkevent EVENT_GOT_A_KANTO_STARTER
	iftrue .Badges
	writetext OakKantoStartersText
	promptbutton
.Badges:
	readvar VAR_BADGES
	ifequal NUM_BADGES, .OpenMtSilver
	ifequal NUM_JOHTO_BADGES, .Complain
	sjump .AhGood

.CheckPokedex:
	writetext OakLabDexCheckText
	waitbutton
	special ProfOaksPCBoot
	writetext OakLabGoodbyeText
	waitbutton
	closetext
	end

.OpenMtSilver:
	writetext OakOpenMtSilverText
	promptbutton
	setevent EVENT_OPENED_MT_SILVER
.CheckStarters:
; with all of KANTO's BADGES, every POKéMON on the table may go
	checkevent EVENT_GOT_BULBASAUR_FROM_OAK
	iffalse .StartersLeft
	checkevent EVENT_GOT_CHARMANDER_FROM_OAK
	iffalse .StartersLeft
	checkevent EVENT_GOT_SQUIRTLE_FROM_OAK
	iftrue .CheckPokedex
.StartersLeft:
	writetext OakKantoStartersAllText
	promptbutton
	sjump .CheckPokedex

.Complain:
	writetext OakNoKantoBadgesText
	promptbutton
	sjump .CheckPokedex

.AhGood:
	writetext OakYesKantoBadgesText
	promptbutton
	sjump .CheckPokedex

OaksLabBulbasaurBallScript:
	scall OaksLabStarterBallCheckScript
	refreshscreen
	pokepic BULBASAUR
	cry BULBASAUR
	waitbutton
	closepokepic
	opentext
	writetext OaksLabTakeBulbasaurText
	yesorno
	iffalse OaksLabStarterBallNoScript
	callasm CheckRoomForGiftMon
	iffalse OaksLabStarterBallNoRoomScript
	setmonval BULBASAUR
	scall OaksLabGiveStarterScript
	disappear OAKSLAB_BULBASAUR_BALL
	end

OaksLabCharmanderBallScript:
	scall OaksLabStarterBallCheckScript
	refreshscreen
	pokepic CHARMANDER
	cry CHARMANDER
	waitbutton
	closepokepic
	opentext
	writetext OaksLabTakeCharmanderText
	yesorno
	iffalse OaksLabStarterBallNoScript
	callasm CheckRoomForGiftMon
	iffalse OaksLabStarterBallNoRoomScript
	setmonval CHARMANDER
	scall OaksLabGiveStarterScript
	disappear OAKSLAB_CHARMANDER_BALL
	end

OaksLabSquirtleBallScript:
	scall OaksLabStarterBallCheckScript
	refreshscreen
	pokepic SQUIRTLE
	cry SQUIRTLE
	waitbutton
	closepokepic
	opentext
	writetext OaksLabTakeSquirtleText
	yesorno
	iffalse OaksLabStarterBallNoScript
	callasm CheckRoomForGiftMon
	iffalse OaksLabStarterBallNoRoomScript
	setmonval SQUIRTLE
	scall OaksLabGiveStarterScript
	disappear OAKSLAB_SQUIRTLE_BALL
	end

OaksLabStarterBallCheckScript:
; Go on only if the player may take one of PROF.OAK's KANTO POKéMON: after he
; offers them (on the first visit), one; with all of KANTO's BADGES, the rest.
	checkevent EVENT_TALKED_TO_OAK_IN_KANTO
	iffalse .NotOffered
	checkevent EVENT_GOT_A_KANTO_STARTER
	iffalse .Yes
	checkevent EVENT_OPENED_MT_SILVER
	iftrue .Yes
	opentext
	writetext OaksLabOnlyOneStarterText
	waitbutton
	closetext
	endall

.NotOffered:
	opentext
	writetext OaksLabStarterBallText
	waitbutton
	closetext
	endall

.Yes:
	end

OaksLabGiveStarterScript:
; The KANTO POKéMON whose ID is wScriptVar, at level 5
	getmonname STRING_BUFFER_3, 0
	writetext OaksLabReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke 0, 5
	setevent EVENT_GOT_A_KANTO_STARTER
	closetext
	end

OaksLabStarterBallNoScript:
	writetext OaksLabStarterBallNoText
	waitbutton
	closetext
	end

OaksLabStarterBallNoRoomScript:
	writetext OaksLabStarterBallNoRoomText
	waitbutton
	closetext
	end

OaksAssistant1Script:
	jumptextfaceplayer OaksAssistant1Text

OaksAssistant2Script:
	jumptextfaceplayer OaksAssistant2Text

OaksAssistant3Script:
	jumptextfaceplayer OaksAssistant3Text

OaksLabBookshelf:
	jumpstd DifficultBookshelfScript

OaksLabPoster1:
	jumptext OaksLabPoster1Text

OaksLabPoster2:
	jumptext OaksLabPoster2Text

OaksLabTrashcan:
	jumptext OaksLabTrashcanText

OaksLabPC:
	jumptext OaksLabPCText

OakWelcomeKantoText:
	text "OAK: Ah, <PLAY_G>!"
	line "It's good of you"

	para "to come all this"
	line "way to KANTO."

	para "What do you think"
	line "of the trainers"

	para "out here?"
	line "Pretty tough, huh?"
	done

OakKantoStartersText:
	text "Oh, and see those"
	line "# BALLS on my"
	cont "table?"

	para "They hold #MON"
	line "from KANTO, the"
	cont "kind I give to new"
	cont "trainers here."

	para "You won't find"
	line "them in the wild."

	para "Take one with you,"
	line "<PLAY_G>!"
	done

OakKantoStartersAllText:
	text "The #MON on my"
	line "table are yours,"
	cont "too."

	para "A trainer like you"
	line "should have them!"
	done

OaksLabStarterBallText:
	text "It's a # BALL."

	para "PROF.OAK must be"
	line "keeping it."
	done

OaksLabOnlyOneStarterText:
	text "OAK: One is enough"
	line "for now!"

	para "Come back with all"
	line "of KANTO's BADGES."
	done

OaksLabTakeBulbasaurText:
	text "OAK: BULBASAUR,"
	line "the grass #MON?"
	done

OaksLabTakeCharmanderText:
	text "OAK: CHARMANDER,"
	line "the fire #MON?"
	done

OaksLabTakeSquirtleText:
	text "OAK: SQUIRTLE,"
	line "the water #MON?"
	done

OaksLabReceivedStarterText:
	text "<PLAYER> received"
	line "@"
	text_ram wStringBuffer3
	text "!"
	done

OaksLabStarterBallNoText:
	text "OAK: Take your"
	line "time."
	done

OaksLabStarterBallNoRoomText:
	text "OAK: You have no"
	line "room for it, even"
	cont "in your PC!"
	done

OakLabDexCheckText:
	text "How is your #-"
	line "DEX coming?"

	para "Let's see…"
	done

OakLabGoodbyeText:
	text "If you're in the"
	line "area, I hope you"
	cont "come visit again."
	done

OakOpenMtSilverText:
	text "OAK: Wow! That's"
	line "excellent!"

	para "You collected the"
	line "BADGES of GYMS in"
	cont "KANTO. Well done!"

	para "I was right in my"
	line "assessment of you."

	para "Tell you what,"
	line "<PLAY_G>. I'll make"

	para "arrangements so"
	line "that you can go to"
	cont "MT.SILVER."

	para "MT.SILVER is a big"
	line "mountain that is"

	para "home to many wild"
	line "#MON."

	para "It's too dangerous"
	line "for your average"

	para "trainer, so it's"
	line "off limits. But"

	para "we can make an"
	line "exception in your"
	cont "case, <PLAY_G>."

	para "Go up to INDIGO"
	line "PLATEAU. You can"

	para "reach MT.SILVER"
	line "from there."
	done

OakNoKantoBadgesText:
	text "OAK: Hmm? You're"
	line "not collecting"
	cont "KANTO GYM BADGES?"

	para "The GYM LEADERS in"
	line "KANTO are as tough"

	para "as any you battled"
	line "in JOHTO."

	para "I recommend that"
	line "you challenge"
	cont "them."
	done

OakYesKantoBadgesText:
	text "OAK: Ah, you're"
	line "collecting KANTO"
	cont "GYM BADGES."

	para "I imagine that"
	line "it's hard, but the"

	para "experience is sure"
	line "to help you."

	para "Come see me when"
	line "you get them all."

	para "I'll have a gift"
	line "for you."

	para "Keep trying hard,"
	line "<PLAY_G>!"
	done

OaksAssistant1Text:
	text "The PROF's #MON"
	line "TALK radio program"

	para "isn't aired here"
	line "in KANTO."

	para "It's a shame--I'd"
	line "like to hear it."
	done

OaksAssistant2Text:
	text "Thanks to your"
	line "work on the #-"
	cont "DEX, the PROF's"

	para "research is coming"
	line "along great."
	done

OaksAssistant3Text:
	text "Don't tell anyone,"
	line "but PROF.OAK'S"

	para "#MON TALK isn't"
	line "a live broadcast."
	done

OaksLabPoster1Text:
	text "Press START to"
	line "open the MENU."
	done

OaksLabPoster2Text:
	text "The SAVE option is"
	line "on the MENU."

	para "Use it in a timely"
	line "manner."
	done

OaksLabTrashcanText:
	text "There's nothing in"
	line "here…"
	done

OaksLabPCText:
	text "There's an e-mail"
	line "message on the PC."

	para "…"

	para "PROF.OAK, how is"
	line "your research"
	cont "coming along?"

	para "I'm still plugging"
	line "away."

	para "I heard rumors"
	line "that <PLAY_G> is"

	para "getting quite a"
	line "reputation."

	para "I'm delighted to"
	line "hear that."

	para "ELM in NEW BARK"
	line "TOWN 8-)"
	done

OaksLab_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 11, PALLET_TOWN, 3
	warp_event  5, 11, PALLET_TOWN, 3

	def_coord_events

	def_bg_events
	bg_event  6,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  7,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  8,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  9,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  0,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  1,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  2,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  3,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  6,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  7,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  8,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  9,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  4,  0, BGEVENT_READ, OaksLabPoster1
	bg_event  5,  0, BGEVENT_READ, OaksLabPoster2
	bg_event  9,  3, BGEVENT_READ, OaksLabTrashcan
	bg_event  0,  1, BGEVENT_READ, OaksLabPC

	def_object_events
	object_event  4,  2, SPRITE_OAK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Oak, -1
	object_event  1,  8, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OaksAssistant1Script, -1
	object_event  8,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OaksAssistant2Script, -1
	object_event  1,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OaksAssistant3Script, -1
	object_event  6,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OaksLabBulbasaurBallScript, EVENT_GOT_BULBASAUR_FROM_OAK
	object_event  7,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OaksLabCharmanderBallScript, EVENT_GOT_CHARMANDER_FROM_OAK
	object_event  8,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OaksLabSquirtleBallScript, EVENT_GOT_SQUIRTLE_FROM_OAK
