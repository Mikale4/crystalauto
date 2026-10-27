	object_const_def
	const SILVERCAVEITEMROOMS_POKE_BALL1
	const SILVERCAVEITEMROOMS_POKE_BALL2
	const SILVERCAVEITEMROOMS_MEWTWO

SilverCaveItemRooms_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, SilverCaveItemRoomsMewtwoCallback

SilverCaveItemRoomsMaxRevive:
	itemball MAX_REVIVE

SilverCaveItemRoomsFullRestore:
	itemball FULL_RESTORE

SilverCaveItemRoomsMewtwoCallback:
; MEWTWO waits deep in MT.SILVER once RED is beaten, till it joins the player
	disappear SILVERCAVEITEMROOMS_MEWTWO
	checkevent EVENT_BEAT_RED
	iffalse .Done
	checkevent EVENT_FOUGHT_MEWTWO
	iftrue .Done
	appear SILVERCAVEITEMROOMS_MEWTWO
.Done:
	endcallback

SilverCaveItemRoomsMewtwoScript:
; a boss (see engine/battle/bosses.asm)
	opentext
	writetext SilverCaveItemRoomsMewtwoText
	cry MEWTWO
	waitsfx
	closetext
	loadwildmon MEWTWO, 70
	startbattle
	ifequal LOSE, .Lost
	disappear SILVERCAVEITEMROOMS_MEWTWO
	setevent EVENT_FOUGHT_MEWTWO
.Lost:
	reloadmapafterbattle
	end

SilverCaveItemRoomsMewtwoText:
	text "A #MON made by"
	line "people, hiding"
	cont "from them…"

	para "MEWTWO is glaring"
	line "at <PLAYER>!"
	done

SilverCaveItemRooms_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 13,  3, SILVER_CAVE_ROOM_2, 3
	warp_event  7, 15, SILVER_CAVE_ROOM_2, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  6,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SilverCaveItemRoomsMaxRevive, EVENT_SILVER_CAVE_ITEM_ROOMS_MAX_REVIVE
	object_event 15, 11, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SilverCaveItemRoomsFullRestore, EVENT_SILVER_CAVE_ITEM_ROOMS_FULL_RESTORE
	object_event 17, 10, SPRITE_MEWTWO, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, SilverCaveItemRoomsMewtwoScript, EVENT_SILVER_CAVE_MEWTWO
