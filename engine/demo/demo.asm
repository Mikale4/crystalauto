; The Demo, like PalletToPewter's (95_demo.js): a runner that plays the game by
; itself, with nothing but the buttons a player has. It holds the D-pad and
; presses A, B and START through GetJoypad, answering whatever is on screen,
; and walks where its plan (data/demo/plan.asm) says, finding the way on each
; map (DemoBuildFlow) and from map to map (data/demo/world.asm). Battles are
; auto battle's, as with the CONTINUOUS option.
; Choose DEMO on the title screen's menu. While it runs, START on the real pad
; stops it and hands the game to the player (its START menu has DEMO to hand it
; back), and SELECT changes its speed.

DemoJoypad::
; Called by GetJoypad while the Demo runs: hJoypadDown = its buttons.
	call DemoRequests
	ld a, [wDemoState]
	cp DEMO_RUNNING
	jr nz, .none
	ld a, [wDemoCtx]
	and LOW(~DEMOCTX_HELD)
	cp NUM_DEMOCTXS
	jr c, .ok
	xor a ; DEMOCTX_TEXT
.ok
	cp DEMOCTX_OVERWORLD
	jr z, .overworld
	ld hl, wDemoAway ; (something other than walking about asks)
	ld [hl], TRUE
.overworld
	ld hl, .Contexts
	call .Dispatch
; (what asks next says so again: anything else is text, unless it's held)
	ld hl, wDemoCtx
	bit DEMOCTX_HELD_F, [hl]
	jr nz, .held
	ld [hl], DEMOCTX_TEXT
.held
	ld a, [wDemoPad]
	ldh [hJoypadDown], a
	ret

.none
	xor a
	ld [wDemoPad], a
	ldh [hJoypadDown], a
	ret

.Dispatch:
	rst JumpTable
	ret

.Contexts:
; entries correspond to DEMOCTX_* constants
	table_width 2
	dw DemoText
	dw DemoOverworld
	dw DemoMenu
	dw DemoNaming
	dw DemoPartyMenu
	assert_table_length NUM_DEMOCTXS

DemoRequests:
; START on the real pad stops the Demo; SELECT changes its speed.
; (wDemoPadPressed: what the real pad held since last time, see UpdateJoypad)
	ld hl, wDemoPadPressed
	ld b, [hl]
	ld [hl], 0
	ld a, [wDemoPadLast]
	cpl
	and b
	ld c, a ; (pressed since)
	ld a, b
	ld [wDemoPadLast], a
	bit B_PAD_START, c
	jr nz, DemoStop
	bit B_PAD_SELECT, c
	ret z
	ld a, [wDemoSpeed]
	inc a
	cp NUM_DEMOSPEEDS
	jr c, .got_speed
	xor a
.got_speed
	ld [wDemoSpeed], a
	ret

DemoStop:
; Hand the game to the player.
	ld a, DEMO_STOPPED
	ld [wDemoState], a
	xor a
	ld [wDemoPad], a
	ld [wDemoPadPressed], a
	ld [wDemoGoal], a
	ret

DemoTap:
; Tap the buttons in a: hold them for DEMO_TAP_FRAMES, then let go as long.
; Return carry when it presses them.
	ld b, a
	ld a, [wDemoTapClock]
	ld c, a
	ldh a, [hVBlankCounter]
	sub c
	cp DEMO_TAP_FRAMES
	jr c, .wait
	ldh a, [hVBlankCounter]
	ld [wDemoTapClock], a
	ld a, [wDemoPad]
	and a
	jr nz, .let_go
	ld a, b
	ld [wDemoPad], a
	scf
	ret

.let_go
	xor a
	ld [wDemoPad], a
.wait
	and a
	ret

DemoHold:
; Hold the buttons in a.
	ld [wDemoPad], a
	ldh a, [hVBlankCounter]
	ld [wDemoTapClock], a
	ret

DemoText:
; Text, mostly: A moves it on.
	ld a, PAD_A
	jr DemoTap

DemoNaming:
; The naming screen: START goes to END, A ends it (with the name as it is).
	ldh a, [hVBlankCounter]
	and %10000
	ld a, PAD_START
	jr z, DemoTap
	ld a, PAD_A
	jr DemoTap

DemoMenu:
; A menu it knows (DemoMenus) its own way; else go to the item DemoMenuChoice
; wants, and choose it.
	ld hl, wMenuDataPointer
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ld a, [wMenuDataBank]
	ld c, a
	ld hl, DemoMenus
.find
	ld a, [hli]
	cp -1
	jr z, .other
	cp c
	jr nz, .next
	ld a, [hli]
	cp e
	jr nz, .next_high
	ld a, [hli]
	cp d
	jr nz, .next_handler
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.next
	inc hl
.next_high
	inc hl
.next_handler
	inc hl
	inc hl
	jr .find

.other
	call DemoMenuChoice
	ld b, a
	ld a, [wMenuCursorY]
	ld c, a
	ld a, b
	cp c
	jr nz, DemoMoveCursor
	ld a, PAD_A
	call DemoTap
	ret nc
	xor a ; (an answer the game asked for counts once)
	ld [wDemoAnswer], a
	ret

MACRO demo_menu
; menu data, the handler
	db BANK(\1)
	dw \1, \2
ENDM

DemoMenus:
	demo_menu CaptureBallMenuHeader.MenuData, DemoBallMenu
	demo_menu MenuHeader_Buy.MenuData, DemoBuyMenu
	demo_menu StartMenu.MenuData, DemoStartMenu
	demo_menu ItemsPocketMenuHeader.MenuData, DemoPackMenu
	demo_menu BallsPocketMenuHeader.MenuData, DemoPackMenu
	demo_menu KeyItemsPocketMenuHeader.MenuData, DemoPackMenu
	db -1

DemoMoveCursor:
; b: the item (1-based) to choose, c: the one the cursor is on. Tap the cursor
; toward it, or A on it.
	ld a, c
	cp b
	ld a, PAD_A
	jp z, DemoTap
	ld a, PAD_DOWN
	jp c, DemoTap
	ld a, PAD_UP
	jp DemoTap

DemoScrollTo:
; A scrolling menu of items: go to item a, and choose it. Return carry if the
; list doesn't have it.
	ld b, a
	ld a, [wMenuData_ScrollingMenuItemFormat]
	ld e, a ; (1 byte for each, or 2 with a quantity)
	ld hl, wMenuData_ItemsPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hli] ; (how many)
	and a
	jr z, .missing
	ld d, a
	ld c, 1
.loop
	ld a, [hl]
	cp b
	jr z, .found
	ld a, l
	add e
	ld l, a
	adc h
	sub l
	ld h, a
	inc c
	dec d
	jr nz, .loop
.missing
	scf
	ret

.found
	ld b, c
	ld a, [wMenuScrollPosition]
	ld c, a
	ld a, [wMenuCursorY]
	add c
	ld c, a
	call DemoMoveCursor
	and a
	ret

DemoBuyMenu:
; A mart's list: the item the plan is buying (dbuy), while it wants more; else
; out.
	call DemoWantsItem
	ld a, PAD_B
	jp nc, DemoTap
	ld a, b
	call DemoScrollTo
	ret nc
	ld a, PAD_B
	jp DemoTap

DemoStartMenu:
; The START menu: the PACK, for an item to give (see DemoPackJob); else out.
	call DemoPackJob
	ld a, PAD_B
	jp nc, DemoTap
	ld hl, wMenuItemsList
	ld a, [hli]
	ld c, a
	ld b, 1
.find
	ld a, [hli]
	cp STARTMENUITEM_PACK
	jr z, .found
	inc b
	dec c
	jr nz, .find
	ld a, PAD_B
	jp DemoTap

.found
	ld a, [wMenuCursorY]
	ld c, a
	jp DemoMoveCursor

DemoPackMenu:
; A PACK pocket: over to the pocket with the item to give (see DemoPackJob), and
; on to it; else out of the PACK.
	call DemoPackJob
	ld b, a
	ld a, PAD_B
	jp nc, DemoTap
	push bc
	ld hl, wNumItems
	call DemoPocketCount
	ld c, ITEM_POCKET
	and a
	jr nz, .got_pocket
	ld hl, wNumBalls
	call DemoPocketCount
	ld c, BALL_POCKET
	and a
	jr nz, .got_pocket
	ld c, KEY_ITEM_POCKET
.got_pocket
	ld a, [wCurPocket]
	cp c
	pop bc
	ld a, PAD_LEFT
	jp nc, .left_or_here
	ld a, PAD_RIGHT
	jp DemoTap

.left_or_here
	jp nz, DemoTap
	ld a, b
	call DemoScrollTo
	ret nc
	ld a, PAD_B
	jp DemoTap

DemoPartyMenu:
; The party menu: the POKéMON to give an item to (see DemoPackJob); else out.
	call DemoPackJob
	ld a, PAD_B
	jp nc, DemoTap
	ld b, c
	inc b
	ld a, [wMenuCursorY]
	ld c, a
	jp DemoMoveCursor

DemoPlanCommand:
; Return the plan's command in a, and hl: what follows it.
	ld hl, wDemoPlan
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hli]
	ret

DemoWantsItem:
; Return carry, and the item in b, if the plan is buying an item (dbuy) it has
; fewer of than it wants, and it has the money for one.
	call DemoPlanCommand
	cp DPLAN_BUY
	jr nz, .no
	ld a, [hli]
	ld b, a
	ld a, [hl]
	and a
	jr nz, .got_count
	push bc
	call DemoTeamSize
	pop bc
.got_count
	ld c, a
	push bc
	ld a, b
	call DemoCountItem
	pop bc
	cp c
	jr nc, .no
; the money for one
	ld a, [wCurItem]
	push af
	ld a, b
	ld [wCurItem], a
	farcall GetItemPrice
	pop af
	ld [wCurItem], a
	ld a, [wMoney]
	and a
	jr nz, .yes
	ld a, [wMoney + 1]
	cp d
	jr c, .no
	jr nz, .yes
	ld a, [wMoney + 2]
	cp e
	jr c, .no
.yes
	scf
	ret

.no
	and a
	ret

DemoPackJob:
; Return carry, the item in a and a POKéMON in c, if the plan is giving out an
; item (dgive), the PACK has one, and that POKéMON (not an egg) doesn't hold it.
	call DemoPlanCommand
	cp DPLAN_GIVE
	jr nz, .no
	ld a, [hl]
	push af
	call DemoPackCount
	and a
	jr z, .pop_no
	pop af
	push af
	call DemoGiveTarget
	jr nc, .pop_no
	pop af
	scf
	ret

.pop_no
	pop af
.no
	and a
	ret

DemoGiveTarget:
; Return carry, and in c the first POKéMON in the team (not an egg) that doesn't
; hold item a.
	ld b, a
	ld c, 0
	ld hl, wPartySpecies
	ld de, wPartyMon1Item
.loop
	ld a, [hli]
	cp -1
	jr z, .none
	cp EGG
	jr z, .next
	ld a, [de]
	cp b
	jr nz, .found
.next
	inc c
	ld a, e
	add PARTYMON_STRUCT_LENGTH
	ld e, a
	adc d
	sub e
	ld d, a
	jr .loop

.found
	scf
	ret

.none
	and a
	ret

DemoTeamSize:
; Return how many POKéMON are in the team (not eggs) in a.
	ld hl, wPartySpecies
	ld c, 0
.loop
	ld a, [hli]
	cp -1
	jr z, .done
	cp EGG
	jr z, .loop
	inc c
	jr .loop

.done
	ld a, c
	ret

DemoCountItem:
; Return in a how many of item a it has: in the PACK (its ITEMS and BALLS
; pockets), and held by the team.
	ld b, a
	call DemoPackCount
	ld c, a
	ld a, [wPartyCount]
	and a
	jr z, .done
	ld d, a
	ld hl, wPartyMon1Item
.held
	ld a, [hl]
	cp b
	jr nz, .next
	inc c
.next
	ld a, l
	add PARTYMON_STRUCT_LENGTH
	ld l, a
	adc h
	sub l
	ld h, a
	dec d
	jr nz, .held
.done
	ld a, c
	ret

DemoPackCount:
; Return in a how many of item a are in the PACK's ITEMS and BALLS pockets (b:
; the item).
	ld b, a
	ld hl, wNumItems
	call DemoPocketCount
	ld c, a
	ld hl, wNumBalls
	call DemoPocketCount
	add c
	ret

DemoPocketCount:
; Return in a how many of item b the pocket at hl (count, then item and quantity
; for each) has.
	ld a, [hli]
	and a
	ret z
	ld e, a
.loop
	ld a, [hli]
	cp b
	jr z, .found
	inc hl
	dec e
	jr nz, .loop
	xor a
	ret

.found
	ld a, [hl]
	ret

DemoBallMenu:
; A beaten wild POKéMON: a BALL at it if the plan wants it, it hasn't caught one
; yet and the team has room (and, till the first POKéMON the plan wants is
; caught, only that one), else LEAVE it be.
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	ld a, PAD_B
	jp nc, DemoTap
	ld a, [wEnemyMonSpecies]
	dec a
	call CheckCaughtMon
	ld a, PAD_B
	jp nz, DemoTap
	ld a, [DemoWantedMons]
	dec a
	call CheckCaughtMon
	ld a, [DemoWantedMons]
	ld hl, wEnemyMonSpecies
	jr nz, .any_wanted
	cp [hl]
	ld a, PAD_B
	jp nz, DemoTap
	jr .throw

.any_wanted
	ld a, [hl]
	ld hl, DemoWantedMons
	ld de, 1
	call IsInArray
	ld a, PAD_B
	jp nc, DemoTap
.throw
; (the BALL the cursor is on; up from LEAVE)
	ld a, [wMenuScrollPosition]
	ld b, a
	ld a, [wMenuCursorY]
	add b
	ld b, a
	ld a, [wNumBalls]
	cp b
	ld a, PAD_A
	jp nc, DemoTap
	ld a, PAD_UP
	jp DemoTap

DemoMenuChoice:
; Return the item (1-based) to choose in the menu that's up.
; YES or NO:
	ld hl, wMenuDataPointer
	ld a, [hli]
	cp LOW(YesNoMenuHeader.MenuData)
	jr nz, .not_yes_no
	ld a, [hl]
	cp HIGH(YesNoMenuHeader.MenuData)
	jp z, DemoYesOrNo
.not_yes_no
; the player's name: the first of the names it offers (after NEW NAME)
	ld de, .NewName
	call DemoMenuIs
	ld a, 2
	ret z
; the difficulty: NORMAL
	ld de, .Normal
	call DemoMenuIs
	ld a, 1
	ret z
; a mart: BUY while the plan is buying something (dbuy), else QUIT
	ld de, .Buy
	call DemoMenuIs
	jr nz, .not_mart
	call DemoWantsItem
	ld a, 1
	ret c
	ld a, 3
	ret

.not_mart
; an item's menu in the PACK, for an item to give (see DemoPackJob): GIVE
	call DemoPackJob
	jr nc, .first
	ld de, .Give
	call DemoMenuFind
	ret nc

.first
; anything else: the first item
	ld a, 1
	ret

.NewName: db "NEW NAME@"
.Normal:  db "NORMAL@"
.Buy:     db "BUY@"
.Give:    db "GIVE@"

DemoMenuFind:
; Return in a the item (1-based) of the menu that's up that's the string at de;
; carry if none is.
	ld hl, wMenuDataPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl ; (flags)
	ld a, [wMenuDataBank]
	call GetFarByte
	inc hl
	ld c, a ; (the number of items)
	ld b, 1
.item
	push bc
	push de
	push hl
	call DemoMenuIs.compare
	pop hl
	pop de
	pop bc
	ld a, b
	ret z
; on to the next item
.skip
	ld a, [wMenuDataBank]
	call GetFarByte
	inc hl
	cp '@'
	jr nz, .skip
	inc b
	dec c
	jr nz, .item
	scf
	ret

DemoMenuIs:
; Return z if the menu's first item is the string at de.
	ld hl, wMenuDataPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl ; (flags)
	inc hl ; (the number of items)
.compare
	ld a, [wMenuDataBank]
	ld b, a
.loop
	ld a, [de]
	cp '@'
	ret z
	ld a, b
	call GetFarByte
	ld c, a
	ld a, [de]
	cp c
	ret nz
	inc hl
	inc de
	jr .loop

DemoYesOrNo:
; YES (1) or NO (2): what wDemoAnswer says (it says NO to a nickname), else YES.
	ld a, [wDemoAnswer]
	and a
	ret nz
	inc a
	ret

DemoOverworld:
; The player can walk: on with the plan (a few of its commands at most, if
; they're done at once).
	ld b, 8
.loop
	push bc
	call DemoRunCommand
	pop bc
	ret nc
	dec b
	jr nz, .loop
	ret

DemoRunCommand:
; Return carry if the command is done (wDemoPlan: the next one).
	ld hl, wDemoPlan
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	cp NUM_DPLANS
	ret nc
	push hl
	ld e, a
	ld d, 0
	ld hl, .Commands
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl ; (the command's address on the stack)

.Commands:
; entries correspond to DPLAN_* constants
	table_width 2
	dw DemoPlan_End
	dw DemoPlan_Status
	dw DemoPlan_Travel
	dw DemoPlan_Goto
	dw DemoPlan_Talk
	dw DemoPlan_Until
	dw DemoPlan_SkipIf
	dw DemoPlan_Jump
	dw DemoPlan_Face
	dw DemoPlan_Press
	dw DemoPlan_Step
	dw DemoPlan_Heal
	dw DemoPlan_SkipIfNot
	dw DemoPlan_Grind
	dw DemoPlan_Catch
	dw DemoPlan_Buy
	dw DemoPlan_Give
	dw DemoPlan_Team
	assert_table_length NUM_DPLANS

DemoNextCommand:
; hl: the next command. Return carry.
	ld a, l
	ld [wDemoPlan], a
	ld a, h
	ld [wDemoPlan + 1], a
	xor a
	ld [wDemoWait], a
	ld [wDemoGoal], a
	ld [wDemoAnswer], a
	call DemoPlayMinutes
	ldh a, [rWBK]
	push af
	ld a, BANK(wDemoTimer)
	ldh [rWBK], a
	ld a, l
	ld [wDemoTimer], a
	ld a, h
	ld [wDemoTimer + 1], a
	pop af
	ldh [rWBK], a
	scf
	ret

DemoPlan_End:
; Nothing more to do.
	pop hl
	xor a
	ld [wDemoPad], a
	ret ; (nc)

DemoPlan_Status:
; dstatus DSTATUS_*
	pop hl
	inc hl
	ld a, [hli]
	ld [wDemoStatus], a
	jp DemoNextCommand

DemoPlan_Travel:
; dtravel MAP: walk to that map.
	pop hl
	push hl
	inc hl
	ld a, [hli]
	ld b, a
	ld c, [hl]
	call DemoTravel
	pop hl
	ret nc
	inc hl
	inc hl
	inc hl
	jp DemoNextCommand

DemoPlan_Goto:
; dgoto x, y: walk to that cell of this map.
	pop hl
	push hl
	inc hl
	ld a, [hli]
	ld [wDemoGoalX], a
	ld a, [hl]
	ld [wDemoGoalY], a
	ld a, DGOAL_CELL
	ld [wDemoGoal], a
	call DemoWalk
	pop hl
	ret nc
	inc hl
	inc hl
	inc hl
	jp DemoNextCommand

DemoPlan_Talk:
; dtalk n: walk up to map object n, face it and press A (then whatever that
; starts plays out).
	pop hl
	push hl
	inc hl
	ld a, [hl]
	call DemoTalkTo
	pop hl
	ret nc
	inc hl
	inc hl
	jp DemoNextCommand

DemoTalkTo:
; a: a map object. Walk up to it, face it and press A. Return carry once that
; has started something (text or a menu has asked for buttons since: else it
; presses again), or if it isn't here.
	call DemoGetObjectCell
	ret c
	ld a, d
	ld [wDemoGoalX], a
	ld a, e
	ld [wDemoGoalY], a
	ld a, DGOAL_FACE
	ld [wDemoGoal], a
	call DemoWalk
	ret nc
; facing it
	ld a, [wDemoWait]
	and a
	jr z, .press
	ld a, [wDemoAway]
	and a
	jr z, .press ; (nothing came of it: again)
	xor a
	ld [wDemoWait], a
	scf
	ret

.press
; A (a fresh press)
	xor a
	ld [wDemoWait], a
	ldh a, [hJoyDown]
	and PAD_A
	jr nz, .let_go
	ld a, PAD_A
	ld [wDemoPad], a
	ld a, TRUE
	ld [wDemoWait], a
	xor a
	ld [wDemoAway], a
	ret ; (nc)

.let_go
	xor a
	ld [wDemoPad], a
	ret ; (nc)

DemoPlan_Until:
; duntil EVENT, label: on if the event flag is set; else back to the label.
	pop hl
	push hl
	inc hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	call DemoCheckEvent
	pop hl
	jr nz, .set
	inc hl
	inc hl
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp DemoNextCommand

.set
	ld de, 5
	add hl, de
	jp DemoNextCommand

DemoPlan_SkipIf:
; dskipif EVENT, label: to the label if the event flag is set.
	pop hl
	push hl
	inc hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	call DemoCheckEvent
	pop hl
	jr z, DemoPlan_SkipIfNot.next
DemoPlan_SkipIf_Jump:
	inc hl
	inc hl
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp DemoNextCommand

DemoPlan_SkipIfNot:
; dskipifnot EVENT, label: to the label if the event flag isn't set.
	pop hl
	push hl
	inc hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	call DemoCheckEvent
	pop hl
	jr z, DemoPlan_SkipIf_Jump
.next
	ld de, 5
	add hl, de
	jp DemoNextCommand

DemoPlan_Jump:
; djump label
	pop hl
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp DemoNextCommand

DemoPlan_Face:
; dface DIR: turn that way.
	pop hl
	push hl
	inc hl
	ld b, [hl]
	ld a, [wPlayerDirection]
	rrca
	rrca
	and %11
	cp b
	jr z, .facing
	ld a, b
	call DemoDirPad
	call DemoHold
	pop hl
	and a
	ret

.facing
	pop hl
	inc hl
	inc hl
	jp DemoNextCommand

DemoPlan_Press:
; dpress PAD_*: press those buttons once.
	pop hl
	ldh a, [hJoyDown]
	and a
	jr z, .press
	xor a
	ld [wDemoPad], a
	ret ; (nc: a fresh press next time)

.press
	inc hl
	ld a, [hli]
	ld [wDemoPad], a
	jp DemoNextCommand

DemoPlan_Step:
; dstep DIR: walk that way until the player moves (or the map changes).
	pop hl
	push hl
	ld a, [wDemoWait]
	and a
	jr nz, .walking
	inc a
	ld [wDemoWait], a
	ld a, [wXCoord]
	ld [wDemoLastX], a
	ld a, [wYCoord]
	ld [wDemoLastY], a
.walking
	ld a, [wXCoord]
	ld b, a
	ld a, [wDemoLastX]
	cp b
	jr nz, .moved
	ld a, [wYCoord]
	ld b, a
	ld a, [wDemoLastY]
	cp b
	jr nz, .moved
	inc hl
	ld a, [hl]
	call DemoDirPad
	call DemoHold
	pop hl
	and a
	ret

.moved
	pop hl
	inc hl
	inc hl
	jp DemoNextCommand

DemoPlan_Heal:
; dheal: if the team is hurt, have it healed at the nearest POKéMON CENTER.
	pop hl
	push hl
	call DemoHealUp
	pop hl
	ret nc
	inc hl
	jp DemoNextCommand

DemoPlan_Grind:
; dgrind MAP: battle in that map's grass until the team is at the level cap
; (healing whenever it's worn down).
	pop hl
	push hl
	call DemoTeamAtCap
	jr c, .done
	pop hl
	push hl
	inc hl
	call DemoBattleInGrass
	pop hl
	and a
	ret

.done
	pop hl
	inc hl
	inc hl
	inc hl
	jp DemoNextCommand

DemoPlan_Catch:
; dcatch SPECIES, MAP: battle in that map's grass until one is caught (the
; BALL menu throws at what DemoWantedMons lists).
	pop hl
	push hl
	inc hl
	ld a, [hli]
	push hl
	dec a
	call CheckCaughtMon
	pop hl
	jr nz, DemoPlan_Team.done
	call DemoBattleInGrass
	pop hl
	and a
	ret

DemoPlan_Team:
; dteam N, MAP: battle in that map's grass until the team has N POKéMON (the
; BALL menu throws at what DemoWantedMons lists), or for DEMO_TEAM_MINUTES at most.
	pop hl
	push hl
	inc hl
	ld a, [wPartyCount]
	cp [hl]
	jr nc, .done
	inc hl
	push hl
	call DemoTimeUp
	pop hl
	jr c, .done
	call DemoBattleInGrass
	pop hl
	and a
	ret

.done
	pop hl
	ld de, 4
	add hl, de
	jp DemoNextCommand

DemoBattleInGrass:
; hl: a map. Have the team healed if it's worn down; else walk about in the
; map's grass.
	push hl
	call DemoTeamLow
	pop hl
	jp c, DemoHealUp
	ld a, [hli]
	ld b, a
	ld c, [hl]
	call DemoTravel
	ret nc
	ld a, DGOAL_GRASS
	ld [wDemoGoal], a
	xor a
	ld [wDemoGoalX], a
	ld [wDemoGoalY], a
	jp DemoWalk

DemoTimeUp:
; Return carry once the command has run DEMO_TEAM_MINUTES of play time (since
; DemoNextCommand started it: wDemoTimer).
	call DemoPlayMinutes
	ldh a, [rWBK]
	push af
	ld a, BANK(wDemoTimer)
	ldh [rWBK], a
	ld a, [wDemoTimer]
	ld e, a
	ld a, [wDemoTimer + 1]
	ld d, a
	pop af
	ldh [rWBK], a
	ld a, l
	sub e
	ld l, a
	ld a, h
	sbc d
	ld h, a
	ld a, l
	sub DEMO_TEAM_MINUTES
	ld a, h
	sbc 0
	ccf
	ret

DemoPlayMinutes:
; Return the play time in minutes in hl.
	ld a, [wGameTimeHours]
	ld d, a
	ld a, [wGameTimeHours + 1]
	ld e, a
	ld hl, 0
	ld a, 60
.hours
	add hl, de
	dec a
	jr nz, .hours
	ld a, [wGameTimeMinutes]
	ld e, a
	ld d, 0
	add hl, de
	ret

DemoPlan_Buy:
; dbuy ITEM, N, MAP: buy the item at that map's mart until it has N (in the PACK
; and held by the team; 0: one for each POKéMON in the team), as the money goes.
	pop hl
	push hl
	call DemoWantsItem
	jr nc, .done
	pop hl
	push hl
	inc hl
	inc hl
	inc hl
	ld a, [hli]
	ld b, a
	ld c, [hl]
	call DemoTravel
	jr nc, .walking
	ld a, 1 ; (the clerk)
	call DemoTalkTo
	jr c, .done ; (it's been to the clerk)
.walking
	pop hl
	and a
	ret

.done
	pop hl
	ld de, 5
	add hl, de
	jp DemoNextCommand

DemoPlan_Give:
; dgive ITEM: give the item to each POKéMON in the team (not eggs) that doesn't
; hold it, while the PACK has one: START, then the menus do it (see DemoPackJob).
	pop hl
	push hl
	call DemoPackJob
	jr nc, .done
	ld a, [wDemoWait] ; (how many times it's tried)
	cp 8
	jr nc, .done
	ldh a, [hJoyDown]
	and PAD_START
	jr nz, .let_go
	ld a, PAD_START
	ld [wDemoPad], a
	ld hl, wDemoWait
	inc [hl]
	pop hl
	and a
	ret

.let_go
	xor a
	ld [wDemoPad], a
	pop hl
	ret ; (nc)

.done
	pop hl
	inc hl
	inc hl
	jp DemoNextCommand

DemoHealUp:
; Have the team healed at the nearest POKéMON CENTER. Return carry once it's
; healthy (or there's no POKéMON CENTER to go to).
	call DemoTeamHurt
	ccf
	ret c
	ld a, DSTATUS_HEALING
	ld [wDemoStatus], a
	call DemoNearestCenter
	cp -1
	jr z, .none
	call DemoWorldMapID
	call DemoTravel
	ret nc
	ld a, 1 ; (the nurse)
	call DemoTalkTo
	and a
	ret

.none
	scf
	ret

DemoTeamHurt:
; Return carry if a POKéMON in the team (not an egg) has lost HP or has a
; status problem.
	ld hl, wPartySpecies
	ld de, wPartyMon1
.loop
	ld a, [hli]
	cp -1
	ret z ; (nc)
	cp EGG
	jr z, .next
	push hl
	ld hl, MON_STATUS
	add hl, de
	ld a, [hl]
	and a
	jr nz, .hurt
	ld hl, MON_HP
	add hl, de
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, MON_MAXHP
	add hl, de
	ld a, [hli]
	cp b
	jr nz, .hurt
	ld a, [hl]
	cp c
	jr nz, .hurt
	pop hl
.next
	ld a, e
	add PARTYMON_STRUCT_LENGTH
	ld e, a
	adc d
	sub e
	ld d, a
	jr .loop

.hurt
	pop hl
	scf
	ret

DemoTeamLow:
; Return carry if the team (not counting eggs) is down to a third of its HP.
	ld hl, wPartySpecies
	ld de, wPartyMon1
	ld bc, 0 ; (3 x HP - max HP, so far)
.loop
	ld a, [hli]
	cp -1
	jr z, .done
	cp EGG
	jr z, .next
	push hl
	push de
	ld hl, MON_HP
	add hl, de
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld h, b
	ld l, c
	add hl, de
	add hl, de
	add hl, de
	ld b, h
	ld c, l
	pop de
	push de
	ld hl, MON_MAXHP
	add hl, de
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld a, c
	sub e
	ld c, a
	ld a, b
	sbc d
	ld b, a
	pop de
	pop hl
.next
	ld a, e
	add PARTYMON_STRUCT_LENGTH
	ld e, a
	adc d
	sub e
	ld d, a
	jr .loop

.done
	bit 7, b ; (below 0: low)
	jr z, .fine
	scf
	ret

.fine
	and a
	ret

DemoTeamAtCap:
; Return carry if every POKéMON in the team (not eggs) is at the level cap.
	farcall GetLevelCapInB
	ld hl, wPartySpecies
	ld de, wPartyMon1Level
.loop
	ld a, [hli]
	cp -1
	jr z, .yes
	cp EGG
	jr z, .next
	ld a, [de]
	cp b
	jr c, .below
.next
	ld a, e
	add PARTYMON_STRUCT_LENGTH
	ld e, a
	adc d
	sub e
	ld d, a
	jr .loop

.yes
	scf
	ret

.below
	and a
	ret

DemoCheckEvent:
; de: an event flag. Return nz if it's set.
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	ret

DemoGetObjectCell:
; a: a map object (1 for the map's first object_event). Return its cell in d, e,
; or carry if it isn't on the map (its event flag hides it).
	ld hl, wMapObjects
	ld bc, MAPOBJECT_LENGTH
	call AddNTimes
	push hl
	ld bc, MAPOBJECT_EVENT_FLAG
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, d
	and e
	inc a
	jr z, .shown ; (-1: always)
	call DemoCheckEvent
	jr z, .shown
	pop hl
	scf
	ret

.shown
	pop hl
	ld a, [hl] ; MAPOBJECT_OBJECT_STRUCT_ID
	cp -1
	jr z, .home
	ld hl, wObjectStructs
	ld bc, OBJECT_LENGTH
	call AddNTimes
	ld bc, OBJECT_MAP_X
	add hl, bc
	ld a, [hli]
	sub 4
	ld d, a
	ld a, [hl]
	sub 4
	ld e, a
	and a
	ret

.home
; (not out yet: where it stands)
	ld bc, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, [hli]
	sub 4
	ld e, a
	ld a, [hl]
	sub 4
	ld d, a
	and a
	ret

InitDemo::
; A new Demo: its plan from the start.
	ld a, LOW(DemoPlan)
	ld [wDemoPlan], a
	ld a, HIGH(DemoPlan)
	ld [wDemoPlan + 1], a
	; fallthrough

DemoForgetBlocked:
; No link between maps is blocked (as far as it knows).
	ldh a, [rWBK]
	push af
	ld a, BANK(wDemoBlocked)
	ldh [rWBK], a
	ld hl, wDemoBlocked
	ld bc, 2 * DEMO_MAX_BLOCKED
	ld a, -1
	call ByteFill
	xor a
	ld [wDemoBlockedNext], a
	pop af
	ldh [rWBK], a
	ret

INCLUDE "engine/demo/demo_walk.asm"
INCLUDE "data/demo/world.asm"
INCLUDE "data/demo/plan.asm"
