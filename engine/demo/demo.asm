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
	cp NUM_DEMOCTXS
	jr c, .ok
	xor a ; DEMOCTX_TEXT
.ok
	ld hl, .Contexts
	call .Dispatch
; (what asks next says so again: anything else is text)
	xor a ; DEMOCTX_TEXT
	ld [wDemoCtx], a
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
; Go to the item the menu wants (see DemoMenuChoice), and choose it.
	call DemoMenuChoice
	ld b, a
	ld a, [wMenuCursorY]
	cp b
	jr z, .choose
	ld a, PAD_DOWN
	jp c, DemoTap
	ld a, PAD_UP
	jp DemoTap

.choose
	ld a, PAD_A
	call DemoTap
	ret nc
	xor a ; (an answer the game asked for counts once)
	ld [wDemoAnswer], a
	ret

DemoMenuChoice:
; Return the item (1-based) to choose in the menu that's up.
; YES or NO:
	ld hl, wMenuDataPointer
	ld a, [hli]
	cp LOW(YesNoMenuHeader.MenuData)
	jr nz, .not_yes_no
	ld a, [hl]
	cp HIGH(YesNoMenuHeader.MenuData)
	jr z, DemoYesOrNo
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
; anything else: the first item
	ld a, 1
	ret

.NewName: db "NEW NAME@"
.Normal:  db "NORMAL@"

DemoMenuIs:
; Return z if the menu's first item is the string at de.
	ld hl, wMenuDataPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl ; (flags)
	inc hl ; (the number of items)
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
	ld a, [wDemoWait]
	and a
	jr nz, .done
	inc hl
	ld a, [hl]
	call DemoTalkTo
	jr nc, .walking
	ld a, 1
	ld [wDemoWait], a
.walking
	pop hl
	and a
	ret

.done
	pop hl
	inc hl
	inc hl
	jp DemoNextCommand

DemoTalkTo:
; a: a map object. Walk up to it, face it and press A. Return carry once A is
; pressed (or if it isn't here).
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
; facing it: A (a fresh press)
	ldh a, [hJoyDown]
	and PAD_A
	jr nz, .let_go
	ld a, PAD_A
	ld [wDemoPad], a
	scf
	ret

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
	call DemoTeamLow
	jr nc, .fit
	call DemoHealUp
	jr .walking

.fit
	pop hl
	push hl
	inc hl
	ld a, [hli]
	ld b, a
	ld c, [hl]
	call DemoTravel
	jr nc, .walking
	ld a, DGOAL_GRASS
	ld [wDemoGoal], a
	xor a
	ld [wDemoGoalX], a
	ld [wDemoGoalY], a
	call DemoWalk
.walking
	pop hl
	and a
	ret

.done
	pop hl
	inc hl
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
