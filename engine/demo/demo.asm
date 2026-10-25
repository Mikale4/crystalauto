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
	jr DemoShowSign

DemoStop:
; Hand the game to the player (at the game's own speed).
	ld a, DEMO_STOPPED
	ld [wDemoState], a
	xor a
	ld [wDemoPad], a
	ld [wDemoPadPressed], a
	ld [wDemoGoal], a
	ld [wDemoSpeed], a
	; fallthrough

DemoShowSign:
; Show the Demo's sign on the next overworld frame (see PlaceMapNameSign).
	ld hl, wDemoSign
	set DEMOSIGN_PENDING_F, [hl]
	ret

ResumeDemo::
; Hand the game back to the Demo (the START menu's DEMO): its plan picks up
; wherever the game is.
	call InitDemo
	xor a
	ld [wDemoGoal], a
	ld [wDemoWait], a
	ld [wDemoAnswer], a
	ld [wDemoPad], a
	ld [wDemoSpeed], a
	ld [wDemoFlowKey], a ; (it works out its way again)
	dec a
	ld [wDemoPadLast], a ; (the buttons the player holds now aren't presses)
	ld a, DEMO_RUNNING
	ld [wDemoState], a
	jr DemoShowSign

DemoSetStatus:
; a: DSTATUS_*. Say so, on the sign if it's news.
	ld hl, wDemoStatus
	cp [hl]
	ret z
	ld [hl], a
	jr DemoShowSign

PlaceDemoSign::
; The Demo's sign, in the frame PlaceMapNameSign puts up: what it's doing and
; its speed, or (stopped) how to hand it back.
	ld a, [wDemoState]
	cp DEMO_RUNNING
	jr z, .running
	ld de, .Stopped
	hlcoord 0, 1
	call .Centered
	ld de, .HandBack
	jr .second_line

.running
	ld a, [wDemoStatus]
	cp NUM_DSTATUSES
	jr c, .got_status
	xor a
.got_status
	ld hl, DemoStatusTexts
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	hlcoord 0, 1
	call .Centered
	ld de, .Speed1
	ld a, [wDemoSpeed]
	and a
	jr z, .second_line
	ld de, .Speed2
.second_line
	hlcoord 0, 2
	; fallthrough

.Centered:
; Place string de centered on the row at hl.
	push de
	ld c, 0
.length
	ld a, [de]
	inc de
	cp '@'
	jr z, .got_length
	inc c
	jr .length

.got_length
	pop de
	ld a, SCREEN_WIDTH
	sub c
	srl a
	ld c, a
	ld b, 0
	add hl, bc
	jp PlaceString

.Stopped:  db "DEMO stopped@"
.HandBack: db "START menu: DEMO@"
.Speed1:   db "DEMO ×1 START:stop@"
.Speed2:   db "DEMO ×2 START:stop@"

DemoStatusTexts:
; entries correspond to DSTATUS_* constants
	table_width 2
	dw .Starting
	dw .Starter
	dw .Errand
	dw .BackToElm
	dw .Lesson
	dw .ToViolet
	dw .Healing
	dw .Falkner
	dw .Training
	dw .Catching
	dw .Shopping
	dw .Done
	dw .Giving
	dw .Exploring
	dw .SproutTower
	dw .SlowpokeWell
	dw .Bugsy
	dw .Farfetchd
	dw .Moves
	assert_table_length NUM_DSTATUSES

.Starting:  db "Off on a journey@"
.Starter:   db "To get a POKéMON@"
.Errand:    db "To MR.POKéMON's@"
.BackToElm: db "Back to PROF.ELM@"
.Lesson:    db "A catching lesson@"
.ToViolet:  db "Getting ready@"
.Healing:   db "To a POKéMON CENTER@"
.Falkner:   db "FALKNER's GYM@"
.Training:  db "Training@"
.Catching:  db "Catching a team@"
.Shopping:  db "Shopping@"
.Done:      db "That's all for now@"
.Giving:    db "Giving out items@"
.Exploring: db "Looking around@"
.SproutTower: db "SPROUT TOWER@"
.SlowpokeWell: db "SLOWPOKE WELL@"
.Bugsy:     db "BUGSY's GYM@"
.Farfetchd: db "Finding FARFETCH'D@"
.Moves:     db "Learning moves@"

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
	demo_menu ChooseRelearnerMove.MenuData, DemoRelearnerMenu
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
; The party menu: the POKéMON to teach a move to (see DemoTutorJob), or to give
; an item to (see DemoPackJob); else out.
	call DemoTutorJob
	jr c, .got_mon
	call DemoPackJob
	ld a, PAD_B
	jp nc, DemoTap
.got_mon
	ld b, c
	inc b
	ld a, [wMenuCursorY]
	ld c, a
	jp DemoMoveCursor

DemoRelearnerMenu:
; The MOVE REMINDER's or the MOVE TUTOR's list: the move to teach (see
; DemoTutorJob); else out.
	call DemoTutorJob
	ld a, PAD_B
	jp nc, DemoTap
	ld a, b
	call DemoScrollTo
	ret nc
	ld a, PAD_B
	jp DemoTap

DemoTutorJob:
; Return carry, the POKéMON (from 0) in c and the move in b, if the plan is
; teaching moves (dtutor).
	call DemoPlanCommand
	cp DPLAN_TUTOR
	jr nz, .no
	ldh a, [rWBK]
	push af
	ld a, BANK(wDemoTutorMon)
	ldh [rWBK], a
	ld a, [wDemoTutorMon]
	ld c, a
	ld a, [wDemoTutorMove]
	ld b, a
	pop af
	ldh [rWBK], a
	scf
	ret

.no
	and a
	ret

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
; Return carry, and in c the POKéMON in the team (not an egg) to give item a to:
; the first that holds nothing, else the first that holds something else (not
; one a team may hold only one of). None if one a team may hold only one of is
; held already.
	ld b, a
	call IsLimitedHeldItem
	jr nc, .not_limited
	call DemoCountItem.Team
	and a
	ret nz ; (nc)
.not_limited
	ld e, 0 ; (anything else held: no)
	call .Find
	ret c
	ld e, 1 ; (anything else held: yes)
	; fallthrough

.Find:
; b: the item; e: whether a POKéMON holding something else will do.
	ld c, 0
	ld hl, wPartySpecies
.loop
	ld a, [hli]
	cp -1
	jr z, .none
	cp EGG
	jr z, .next
	push hl
	ld a, c
	ld hl, wPartyMon1Item
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	pop bc
	ld a, [hl]
	pop hl
	and a
	jr z, .found
	cp b
	jr z, .next
	call IsLimitedHeldItem
	jr c, .next
	ld a, e
	and a
	jr nz, .found
.next
	inc c
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
	jr .count_held

.Team:
; (b: the item) how many the team holds
	xor a
.count_held
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
; A beaten wild POKéMON: a BALL at it if the plan is catching (dcatch, dteam)
; and wants it, it hasn't caught one yet and the team has room (and, till the
; first POKéMON the plan wants is caught, only that one), else LEAVE it be.
	call DemoPlanCommand
	cp DPLAN_CATCH
	jr z, .catching
	cp DPLAN_TEAM
	ld a, PAD_B
	jp nz, DemoTap
.catching
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
	dw DemoPlan_Sweep
	dw DemoPlan_Retry
	dw DemoPlan_Push
	dw DemoPlan_TalkFrom
	dw DemoPlan_Farfetchd
	dw DemoPlan_Tutor
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
	push hl
	call DemoSetStatus
	pop hl
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
	; fallthrough

DemoTalkAt:
; (d, e): a cell. Walk up to it, face it and press A (as DemoTalkTo).
	ld a, d
	ld [wDemoGoalX], a
	ld a, e
	ld [wDemoGoalY], a
	ld a, DGOAL_FACE
	ld [wDemoGoal], a
	call DemoWalk
	ret nc
	; fallthrough

DemoPressToTalk:
; Facing it: press A (as DemoTalkTo).
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

DemoPlan_TalkFrom:
; dtalkfrom n, DIR: talk to map object n facing that way (from its other side).
	pop hl
	push hl
	inc hl
	ld a, [hli]
	ld b, [hl]
	call DemoTalkFrom
	pop hl
	ret nc
	inc hl
	inc hl
	inc hl
	jp DemoNextCommand

DemoPlan_Farfetchd:
; dfarfetchd: talk to ILEX FOREST's FARFETCH'D (object 1) from the side that
; sends it on toward the CHARCOAL KILN (see IlexForestFarfetchdScript).
	pop hl
	push hl
	ld a, [wFarfetchdPosition]
	ld e, a
	ld d, 0
	ld hl, .Sides - 1
	add hl, de
	ld b, [hl]
	ld a, 1 ; ILEXFOREST_FARFETCHD
	call DemoTalkFrom
	pop hl
	ret nc
	inc hl
	jp DemoNextCommand

.Sides:
; the way to face it at positions 1 to 10 (where walls allow)
	db UP, UP, DOWN, RIGHT, DOWN, LEFT, UP, DOWN, LEFT, UP

DemoPlan_Tutor:
; dtutor: teach the team what the MOVE REMINDER and the MOVE TUTOR (in every
; POKéMON CENTER) have that auto battle would have it learn, one move a visit
; to the nearest POKéMON CENTER, through their menus (see DemoTutorJob; auto
; battle chooses what to forget). What to teach is worked out again after each
; visit (DemoTutorChoose).
	pop hl
	push hl
	ld a, BANK(wDemoTutorFor)
	ldh [rWBK], a
	ld a, [wDemoTutorFor]
	cp l
	jr nz, .choose
	ld a, [wDemoTutorFor + 1]
	cp h
	jr z, .chosen
.choose
	ld a, [wDemoTutorCount]
	cp DEMO_MAX_TUTORING
	jr nc, .done
	ld a, l
	ld [wDemoTutorFor], a
	ld a, h
	ld [wDemoTutorFor + 1], a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	call DemoTutorChoose
	jr nc, .done
.chosen
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld a, DSTATUS_MOVES
	call DemoSetStatus
	farcall DemoNearestCenter
	jr c, .done
	push bc ; (b: the MOVE REMINDER)
	ld d, h
	ld e, l
	farcall DemoKeyMap
	call DemoTravel
	pop bc
	jr nc, .walking
	ld a, BANK(wDemoTutorWho)
	ldh [rWBK], a
	ld a, [wDemoTutorWho]
	add b
	ld b, a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld a, b
	call DemoTalkTo
	jr nc, .walking
; (been to them: what's next is worked out again)
	ld a, BANK(wDemoTutorFor)
	ldh [rWBK], a
	xor a
	ld [wDemoTutorFor], a
	ld [wDemoTutorFor + 1], a
	ld hl, wDemoTutorCount
	inc [hl]
	ld a, BANK(wXCoord)
	ldh [rWBK], a
.walking
	pop hl
	and a
	ret

.done
	ld a, BANK(wDemoTutorFor)
	ldh [rWBK], a
	xor a
	ld [wDemoTutorFor], a
	ld [wDemoTutorFor + 1], a
	ld [wDemoTutorCount], a
	ld [wDemoTutorDone], a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	pop hl
	inc hl
	jp DemoNextCommand

DemoTutorChoose:
; What to teach next (wDemoTutorMon, Move and Who): the first move, of the first
; POKéMON's MOVE REMINDER's list then its MOVE TUTOR's, that auto battle would
; have it learn (AutoLearn_WouldLearn). Return carry if there's one. (It's slow:
; it skips the POKéMON it found nothing for before, see wDemoTutorDone.)
	ld a, [wCurPartyMon]
	push af
	ld a, [wCurPartySpecies]
	push af
	ld c, 0
.mon
	ld a, [wPartyCount]
	cp c
	jr z, .none
	call .Done
	jr nz, .next_mon
	ld hl, wPartySpecies
	ld b, 0
	add hl, bc
	ld a, [hl]
	cp EGG
	jr z, .next_mon
	ld [wCurPartySpecies], a
	ld a, c
	ld [wCurPartyMon], a
	push bc
	farcall BuildReminderList
	ld e, 0 ; (the MOVE REMINDER)
	call .Try
	jr c, .found
	farcall BuildTutorList
	ld e, 1 ; (the MOVE TUTOR)
	call .Try
	jr c, .found
	pop bc
; (nothing for this one)
	call .Done
	ld a, BANK(wDemoTutorDone)
	ldh [rWBK], a
	ld a, [wDemoTutorDone]
	or b
	ld [wDemoTutorDone], a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
.next_mon
	inc c
	jr .mon

.Done:
; Return in b POKéMON c's bit, and nz if wDemoTutorDone has it (c kept).
	ld a, c
	ld b, 1
	and a
	jr z, .got_bit
.shift
	sla b
	dec a
	jr nz, .shift
.got_bit
	ld a, BANK(wDemoTutorDone)
	ldh [rWBK], a
	ld a, [wDemoTutorDone]
	and b
	push af
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	pop af
	ret

.none
	pop af
	ld [wCurPartySpecies], a
	pop af
	ld [wCurPartyMon], a
	and a
	ret

.found
; a: the move; e: who; c (on the stack): the POKéMON
	pop bc
	ld b, a
	ld a, BANK(wDemoTutorMon)
	ldh [rWBK], a
	ld a, c
	ld [wDemoTutorMon], a
	ld a, b
	ld [wDemoTutorMove], a
	ld a, e
	ld [wDemoTutorWho], a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	pop af
	ld [wCurPartySpecies], a
	pop af
	ld [wCurPartyMon], a
	scf
	ret

.Try:
; Return carry and the move in a if auto battle would have the POKéMON learn a
; move of the list (wMoveRelearnerMoves) (e kept).
	ld a, [wMoveRelearnerCount]
	and a
	ret z
	ld b, a
	ld hl, wMoveRelearnerMoves
.try
	ld a, [hli]
	ld [wPutativeTMHMMove], a
	push hl
	push bc
	push de
	farcall AutoLearn_WouldLearn
	pop de
	pop bc
	pop hl
	jr c, .would
	dec b
	jr nz, .try
	and a
	ret

.would
	dec hl
	ld a, [hl]
	scf
	ret

DemoTalkFrom:
; a: a map object; b: a direction. Walk to its other side, face it that way and
; press A. Return carry once that has started something (as DemoTalkTo), or if
; it isn't here.
	push bc
	call DemoGetObjectCell
	pop bc
	ret c
	ld a, b
	and a ; DOWN: from above
	jr nz, .not_down
	dec e
	jr .got_cell
.not_down
	dec a ; UP: from below
	jr nz, .not_up
	inc e
	jr .got_cell
.not_up
	dec a ; LEFT: from the right
	jr nz, .right
	inc d
	jr .got_cell
.right
	dec d
.got_cell
	push bc
	ld a, d
	ld [wDemoGoalX], a
	ld a, e
	ld [wDemoGoalY], a
	ld a, DGOAL_CELL
	ld [wDemoGoal], a
	call DemoWalk
	pop bc
	ret nc
	ld a, [wPlayerDirection]
	rrca
	rrca
	and %11
	cp b
	jp z, DemoPressToTalk
	ld a, b
	call DemoDirPad
	call DemoHold
	and a
	ret

DemoPlan_Push:
; dpush n, DIR: push map object n (a boulder) one cell that way: from the cell
; behind it, with STRENGTH (A on it first, if it isn't on yet: the game asks).
	pop hl
	push hl
	inc hl
	ld a, [hli]
	ld c, [hl]
	push bc
	call DemoGetObjectCell
	pop bc
	jr c, .done ; (gone: down a hole)
	ld a, BANK(wDemoPushX)
	ldh [rWBK], a
	ld a, [wDemoWait]
	and a
	jr nz, .started
	inc a
	ld [wDemoWait], a
	ld a, d
	ld [wDemoPushX], a
	ld a, e
	ld [wDemoPushY], a
.started
	ld a, [wDemoPushX]
	cp d
	jr nz, .moved
	ld a, [wDemoPushY]
	cp e
	jr nz, .moved
	ld a, BANK(wXCoord)
	ldh [rWBK], a
; the cell behind it
	ld a, c
	and a ; DOWN
	jr nz, .not_down
	dec e
	jr .behind
.not_down
	dec a ; UP
	jr nz, .not_up
	inc e
	jr .behind
.not_up
	dec a ; LEFT
	jr nz, .right
	inc d
	jr .behind
.right
	dec d
.behind
	push bc
	ld a, d
	ld [wDemoGoalX], a
	ld a, e
	ld [wDemoGoalY], a
	ld a, DGOAL_CELL
	ld [wDemoGoal], a
	call DemoWalk
	pop bc
	jr nc, .not_yet
	ld a, [wPlayerDirection]
	rrca
	rrca
	and %11
	cp c
	jr nz, .hold ; (face it)
	ld a, [wBikeFlags]
	bit BIKEFLAGS_STRENGTH_ACTIVE_F, a
	jr nz, .hold ; (push)
	ldh a, [hJoyDown]
	and PAD_A
	ld a, PAD_A
	jr z, .pad
	xor a ; (a fresh press)
.pad
	ld [wDemoPad], a
	jr .not_yet

.hold
	ld a, c
	call DemoDirPad
	call DemoHold
.not_yet
	pop hl
	and a
	ret

.moved
	ld a, BANK(wXCoord)
	ldh [rWBK], a
.done
	xor a
	ld [wDemoPad], a
	pop hl
	inc hl
	inc hl
	inc hl
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

DemoPlan_Sweep:
; dsweep MAP: go to that map and see to everything on it there is to do (its
; item balls, hidden items and trainers: DemoTargets) that it can get to now.
	pop hl
	push hl
	inc hl
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld a, [wMapGroup]
	cp b
	jr nz, .away
	ld a, [wMapNumber]
	cp c
	jr nz, .away
	call DemoHealingNow
	jr c, .heal
	call DemoSweepStep
	jr nc, .walking
	pop hl
	ld de, 3
	add hl, de
	jp DemoNextCommand

.away
	push bc
	call DemoSweepLeft
	call DemoHealingNow
	pop bc
	jr c, .heal
	call DemoTravel
	jr .walking

.heal
	call DemoHealUp
.walking
	pop hl
	and a
	ret

DemoPlan_Retry:
; dretry: try again what it left for now (DemoSkipTarget) and the links it found
; no way through.
	call DemoForgetBlocked
	ld a, BANK(wDemoSkipped)
	ldh [rWBK], a
	ld hl, wDemoSkipped
	ld bc, (NUM_DEMO_TARGETS + 7) / 8
	xor a
	call ByteFill
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	pop hl
	inc hl
	jp DemoNextCommand

DemoSweepStep:
; On the map it's sweeping: on to the nearest target still to do, and see to it.
; Return carry once there's none it can get to.
	ld a, [wDemoSweepTarget + 1]
	inc a
	jr nz, .act
; seek: next to the nearest
	ld a, DGOAL_SWEEP
	ld [wDemoGoal], a
	xor a
	ld [wDemoGoalX], a
	ld [wDemoGoalY], a
	call DemoWalk
	jr c, .arrived
	ld a, [wXCoord]
	ld d, a
	ld a, [wYCoord]
	ld e, a
	call DemoFlowAt
	cp DFLOW_UNREACHED
	jr nz, .seeking
; none it can get to (or people in the way: it looks twice)
	ld a, [wDemoStuck]
	cp DEMO_STUCK_FRAMES - 1
	jr nz, .seeking
	ld hl, wDemoWait
	inc [hl]
	ld a, [hl]
	cp 2
	jr c, .seeking
	xor a
	ld [hl], a
	ld [wDemoPad], a
	scf
	ret

.seeking
	and a
	ret

.arrived
; which is it next to?
	xor a
	ld [wDemoWait], a
	call DemoSweepNextTo
	jr c, .chose
	xor a
	ld [wDemoFlowKey], a ; (it's moved: look again)
	and a
	ret

.chose
	ld a, e
	ld [wDemoSweepTarget], a
	ld a, d
	ld [wDemoSweepTarget + 1], a
	and a
	ret

.act
; see to it: face it and press A (items are picked up, trainers battled)
	ld a, [wDemoSweepTarget]
	ld e, a
	ld a, [wDemoSweepTarget + 1]
	ld d, a
	push de
	call DemoTargetOpen
	pop de
	jr nc, .seen_to
	push de
	ld d, b
	ld e, c
	call DemoTalkAt
	pop de
	ret nc
; (it's been seen to; if it's still to do, it can't be now: leave it be)
	push de
	call DemoTargetOpen
	pop de
	call c, DemoSkipTarget
.seen_to
	ld a, -1
	ld [wDemoSweepTarget], a
	ld [wDemoSweepTarget + 1], a
	xor a
	ld [wDemoFlowKey], a
	ld [wDemoWait], a
	and a
	ret

DemoSweepLeft:
; Off the map it's sweeping: the target it was seeing to, if still to do, it
; leaves be for now; so does a trainer that's beaten its team (the battle lost,
; wTempTrainerEventFlag).
	ld a, [wDemoSweepTarget + 1]
	inc a
	jr z, .trainer
	ld a, [wDemoSweepTarget]
	ld e, a
	ld a, [wDemoSweepTarget + 1]
	ld d, a
	push de
	call DemoTargetOpen
	pop de
	call c, DemoSkipTarget
	ld a, -1
	ld [wDemoSweepTarget], a
	ld [wDemoSweepTarget + 1], a
.trainer
	ld a, [wBattleResult]
	and ~BATTLERESULT_BITMASK
	cp LOSE
	ret nz
	call DemoPlanMapTargets ; (the sweep's map)
	ret c
.find
	push bc
	push de
	call DemoTargetOpen
	pop de
	jr nc, .next
	push de
	farcall DemoGetTarget
	ld a, h
	cp DTARGET_TRAINER
	jr nz, .not_it
	ld a, [wTempTrainerEventFlag]
	cp e
	jr nz, .not_it
	ld a, [wTempTrainerEventFlag + 1]
	cp d
	jr nz, .not_it
	pop de
	call DemoSkipTarget
	pop bc
	ret

.not_it
	pop de
.next
	pop bc
	inc de
	dec c
	jr nz, .find
	ret

DemoPlanMapTargets:
; The targets of the map of the plan's command (dsweep): the first in de and how
; many in c; carry if none.
	call DemoPlanCommand
	ld a, [hli]
	ld b, a
	ld c, [hl]
	farcall DemoMapKey
	ret c
	ld d, h
	ld e, l
	farcall DemoMapTargets
	ld a, c
	and a
	ret nz
	scf
	ret

DemoCurMapTargets:
; The targets of the map the player is on: the first in de and how many in c;
; carry if none.
	farcall DemoCurMapKey
	ret c
	ld d, h
	ld e, l
	farcall DemoMapTargets
	ld a, c
	and a
	ret nz
	scf
	ret

DemoSweepNextTo:
; Return carry and in de the target still to do the player is next to (or across
; a counter from).
	call DemoCurMapTargets
	ccf
	ret nc
.loop
	push bc
	push de
	call DemoTargetOpen
	jr nc, .next
	ld a, [wXCoord]
	sub b
	jr nc, .dx
	cpl
	inc a
.dx
	ld d, a
	ld a, [wYCoord]
	sub c
	jr nc, .dy
	cpl
	inc a
.dy
	ld e, a
	add d
	cp 1
	jr z, .next_to
	cp 2
	jr nz, .next
	ld a, d
	and a
	jr z, .next_to ; (across a counter, maybe)
	ld a, e
	and a
	jr z, .next_to
.next
	pop de
	pop bc
	inc de
	dec c
	jr nz, .loop
	and a
	ret

.next_to
	pop de
	pop bc
	scf
	ret

DemoTargetOpen::
; de: a DemoTargets index. Return carry, and its cell in b, c, if it's still to
; do (its event flag isn't set, it's there, and it isn't being left for now).
	push de
	call DemoTargetSkipped
	pop de
	jr c, .no
	farcall DemoGetTarget
	push bc
	push hl
	call DemoCheckEvent
	pop hl
	pop bc
	jr nz, .no ; (done)
	ld a, h
	cp DTARGET_HIDDEN
	jr z, .yes ; (b, c: x, y)
	ld a, b
	call DemoGetObjectCell
	jr c, .no ; (not on the map now)
	ld b, d
	ld c, e
.yes
	scf
	ret

.no
	and a
	ret

DemoTargetSkipped:
; de: a DemoTargets index. Return carry if it's being left for now.
	call DemoSkipBit
	ld a, BANK(wDemoSkipped)
	ldh [rWBK], a
	ld a, [hl]
	and b
	ld b, a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld a, b
	and a
	ret z
	scf
	ret

DemoSkipTarget:
; de: a DemoTargets index. Leave it be for now (till dretry).
	call DemoSkipBit
	ld a, BANK(wDemoSkipped)
	ldh [rWBK], a
	ld a, [hl]
	or b
	ld [hl], a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ret

DemoSkipBit:
; de: a DemoTargets index. Return its wDemoSkipped byte in hl and bit in b.
	ld a, e
	and 7
	ld b, 1
	jr z, .got_bit
.shift
	sla b
	dec a
	jr nz, .shift
.got_bit
	srl d
	rr e
	srl d
	rr e
	srl d
	rr e
	ld hl, wDemoSkipped
	add hl, de
	ret

DemoBattleInGrass:
; hl: a map. Have the team healed if it's worn down (and once it's on its way, till
; it is); else walk about in the map's grass.
	push hl
	call DemoHealingNow
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

DemoHealingNow:
; Return carry if the team is worn down (DemoTeamLow), or on its way to be healed.
	ld a, BANK(wDemoHealing)
	ldh [rWBK], a
	ld a, [wDemoHealing]
	ld b, a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld a, b
	and a
	jp z, DemoTeamLow
	scf
	ret

DemoHealUp:
; Have the team healed at the nearest POKéMON CENTER. Return carry once it's
; healthy (or there's no POKéMON CENTER to go to); the status it had before
; it set off is back then.
	call DemoTeamHurt
	jr nc, .healed
	ld a, BANK(wDemoHealing)
	ldh [rWBK], a
	ld a, [wDemoHealing]
	and a
	jr nz, .on_its_way
	ld a, [wDemoStatus]
	inc a
	ld [wDemoHealing], a
.on_its_way
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld a, DSTATUS_HEALING
	call DemoSetStatus
	farcall DemoNearestCenter
	jr c, .none
	push bc ; (c: the nurse)
	ld d, h
	ld e, l
	farcall DemoKeyMap
	call DemoTravel
	pop bc
	ret nc
	ld a, c
	call DemoTalkTo
	and a
	ret

.none
.healed
	ld a, BANK(wDemoHealing)
	ldh [rWBK], a
	ld a, [wDemoHealing]
	ld b, a
	xor a
	ld [wDemoHealing], a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld a, b
	and a
	jr z, .done
	dec a
	call DemoSetStatus
.done
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
	ld a, -1
	ld [wDemoSweepTarget], a
	ld [wDemoSweepTarget + 1], a
	ld a, BANK(wDemoHealing)
	ldh [rWBK], a
	xor a
	ld [wDemoHealing], a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	; fallthrough

DemoForgetBlocked:
; No link between maps is blocked (as far as it knows).
	ldh a, [rWBK]
	push af
	ld a, BANK(wDemoBlocked)
	ldh [rWBK], a
	ld hl, wDemoBlocked
	ld bc, 4 * DEMO_MAX_BLOCKED
	ld a, -1
	call ByteFill
	xor a
	ld [wDemoBlockedNext], a
	ld [wDemoBlockedCount], a
	farcall DemoForgetRoutes
	pop af
	ldh [rWBK], a
	ret

INCLUDE "engine/demo/demo_walk.asm"
INCLUDE "data/demo/plan.asm"
