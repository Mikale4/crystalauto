TMHMPocket:
	ld a, $1
	ldh [hInMenu], a
	call TMHM_PocketLoop
	ld a, $0
	ldh [hInMenu], a
	ret nc
	call PlaceHollowCursor
	call WaitBGMap
	ld a, [wCurItem] ; (the pocket's entry)
	ld c, a
	call TMHM_GetEntry
	bit GEN1_TM_ENTRY_F, a
	jr nz, .gen1
	ld [wCurItem], a
	dec a
	ld [wCurItemQuantity], a
	ld hl, wTMsHMs
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wItemQuantity], a
	call .ConvertItemToTMHMNumber
	scf
	ret

.gen1
; item GEN1_TM, and which in wCurGen1TM
	res GEN1_TM_ENTRY_F, a
	ld [wCurGen1TM], a
	ld a, 1
	ld [wItemQuantity], a
	xor a
	ld [wCurItemQuantity], a
	ld a, GEN1_TM
	ld [wCurItem], a
	scf
	ret

.ConvertItemToTMHMNumber:
	ld a, [wCurItem]
	ld c, a
	callfar GetNumberedTMHM
	ld a, c
	ld [wCurItem], a
	ret

ConvertCurItemIntoCurTMHM:
	ld a, [wCurItem]
	ld c, a
	callfar GetTMHMNumber
	ld a, c
	ld [wTempTMHM], a
	ret

GetTMHMItemMove:
	call ConvertCurItemIntoCurTMHM
	predef GetTMHMMove
	ret

AskTeachTMHM:
	ld hl, wOptions
	ld a, [hl]
	push af
	res NO_TEXT_SCROLL, [hl]
	ld a, [wCurItem]
	cp GEN1_TM
	jr z, .Gen1TM
	cp TM01
	jr c, .NotTMHM
	call GetTMHMItemMove
	ld a, [wTempTMHM]
.GotMove:
	ld [wPutativeTMHMMove], a
	call GetMoveName
	call CopyName1
	ld hl, BootedTMText ; Booted up a TM
	ld a, [wCurItem]
	cp HM01
	jr c, .TM
	ld hl, BootedHMText ; Booted up an HM
.TM:
	call PrintText
	ld hl, ContainedMoveText
	call PrintText
	call YesNoBox
.NotTMHM:
	pop bc
	ld a, b
	ld [wOptions], a
	ret

.Gen1TM:
	ld a, [wCurGen1TM]
	ld [wTempTMHM], a
	farcall GetGen1TMMove
	ld a, [wTempTMHM]
	jr .GotMove

ChooseMonToLearnTMHM:
	ld hl, wStringBuffer2
	ld de, wTMHMMoveNameBackup
	ld bc, MOVE_NAME_LENGTH - 1
	call CopyBytes
	call ClearBGPalettes
ChooseMonToLearnTMHM_NoRefresh:
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX
	ld a, PARTYMENUACTION_TEACH_TMHM
	ld [wPartyMenuActionText], a
.loopback
	farcall WritePartyMenuTilemap
	farcall PlacePartyMenuText
	call WaitBGMap
	call SetDefaultBGPAndOBP
	call DelayFrame
	farcall PartyMenuSelect
	push af
	ld a, [wCurPartySpecies]
	cp EGG
	pop bc ; now contains the former contents of af
	jr z, .egg
	push bc
	ld hl, wTMHMMoveNameBackup
	ld de, wStringBuffer2
	ld bc, MOVE_NAME_LENGTH - 1
	call CopyBytes
	pop af ; now contains the original contents of af
	ret

.egg
	push hl
	push de
	push bc
	push af
	ld de, SFX_WRONG
	call PlaySFX
	call WaitSFX
	pop af
	pop bc
	pop de
	pop hl
	jr .loopback

TeachTMHM:
	predef CanLearnTMHMMove

	push bc
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNickname
	pop bc

	ld a, c
	and a
	jr nz, .compatible
	push de
	ld de, SFX_WRONG
	call PlaySFX
	pop de
	ld hl, TMHMNotCompatibleText
	call PrintText
	jr .nope

.compatible
	callfar KnowsMove
	jr c, .nope

	predef LearnMove
	ld a, b
	and a
	jr z, .nope

	farcall StubbedTrainerRankings_TMsHMsTaught
	ld a, [wCurItem]
	call IsHM
	ret c

	ld c, HAPPINESS_LEARNMOVE
	callfar ChangeHappiness
	call ConsumeTM
	jr .learned_move

.nope
	and a
	ret

.didnt_use ; unreferenced
	ld a, 2
	ld [wItemEffectSucceeded], a
.learned_move
	scf
	ret

BootedTMText:
	text_far _BootedTMText
	text_end

BootedHMText:
	text_far _BootedHMText
	text_end

ContainedMoveText:
	text_far _ContainedMoveText
	text_end

TMHMNotCompatibleText:
	text_far _TMHMNotCompatibleText
	text_end

TMHM_PocketLoop:
	xor a
	ldh [hBGMapMode], a
	call TMHM_DisplayPocketItems
	ld a, 2
	ld [w2DMenuCursorInitY], a
	ld a, 7
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 5
	sub d
	inc a
	cp 6
	jr nz, .okay
	dec a
.okay
	ld [w2DMenuNumRows], a
	ld a, $c
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a
	ld a, PAD_A | PAD_B | PAD_CTRL_PAD
	ld [wMenuJoypadFilter], a
	ld a, [wTMHMPocketCursor]
	inc a
	ld [wMenuCursorY], a
	ld a, $1
	ld [wMenuCursorX], a
	jr TMHM_ShowTMMoveDescription

TMHM_JoypadLoop:
	call TMHM_DisplayPocketItems
	call StaticMenuJoypad
	ld b, a
	ld a, [wMenuCursorY]
	dec a
	ld [wTMHMPocketCursor], a
	xor a
	ldh [hBGMapMode], a
	ld a, [w2DMenuFlags2]
	bit _2DMENU_EXITING_F, a
	jp nz, TMHM_ScrollPocket
	ld a, b
	ld [wMenuJoypad], a
	bit B_PAD_A, a
	jp nz, TMHM_ChooseTMorHM
	bit B_PAD_B, a
	jp nz, TMHM_ExitPack
	bit B_PAD_RIGHT, a
	jp nz, TMHM_ExitPocket
	bit B_PAD_LEFT, a
	jp nz, TMHM_ExitPocket
TMHM_ShowTMMoveDescription:
	call TMHM_CheckHoveringOverCancel
	jp nc, TMHM_ExitPocket
	hlcoord 0, 12
	ld b, 4
	ld c, SCREEN_WIDTH - 2
	call Textbox
	ld a, [wCurItem]
	cp NUM_TMHM_POCKET_ENTRIES + 1
	jr nc, TMHM_JoypadLoop
	ld c, a
	call TMHM_GetEntryMove
	ld [wCurSpecies], a
	hlcoord 1, 14
	call PrintMoveDescription
	jp TMHM_JoypadLoop

TMHM_ChooseTMorHM:
	call TMHM_PlaySFX_ReadText2
	call CountTMsHMs ; This stores the count to wTempTMHM.
	ld a, [wMenuCursorY]
	dec a
	ld b, a
	ld a, [wTMHMPocketScrollPosition]
	add b
	ld b, a
	ld a, [wTempTMHM]
	cp b
	jr z, _TMHM_ExitPack ; our cursor was hovering over CANCEL
TMHM_CheckHoveringOverCancel:
	call TMHM_GetCurrentPocketPosition
	ld a, [wMenuCursorY]
	ld b, a
.loop
	inc c
	ld a, c
	cp NUM_TMHM_POCKET_ENTRIES + 1
	jr nc, .okay
	call TMHM_EntryQuantity
	jr z, .loop
	dec b
	jr nz, .loop
	ld a, c
.okay
	ld [wCurItem], a
	cp -1
	ret

TMHM_ExitPack:
	call TMHM_PlaySFX_ReadText2
_TMHM_ExitPack:
	ld a, PAD_B
	ld [wMenuJoypad], a
	and a
	ret

TMHM_ExitPocket:
	and a
	ret

TMHM_ScrollPocket:
	ld a, b
	bit B_PAD_DOWN, a
	jr nz, .down
	ld hl, wTMHMPocketScrollPosition
	ld a, [hl]
	and a
	jp z, TMHM_JoypadLoop
	dec [hl]
	call TMHM_DisplayPocketItems
	jp TMHM_ShowTMMoveDescription

.down
	call TMHM_GetCurrentPocketPosition
	ld b, 5
.loop
	inc c
	ld a, c
	cp NUM_TMHM_POCKET_ENTRIES + 1
	jp nc, TMHM_JoypadLoop
	call TMHM_EntryQuantity
	jr z, .loop
	dec b
	jr nz, .loop
	ld hl, wTMHMPocketScrollPosition
	inc [hl]
	call TMHM_DisplayPocketItems
	jp TMHM_ShowTMMoveDescription

TMHM_DisplayPocketItems:
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jp z, Tutorial_TMHMPocket

	hlcoord 5, 2
	lb bc, 10, 15
	ld a, ' '
	call ClearBox
	call TMHM_GetCurrentPocketPosition
	ld d, $5
.loop2
	inc c
	ld a, c
	cp NUM_TMHM_POCKET_ENTRIES + 1
	jp nc, .NotTMHM
	call TMHM_EntryQuantity
	jr z, .loop2
	ld b, a
	push de
	push bc
	call TMHMPocket_GetCurrentLineCoord
	pop bc
	push bc
; its number
	push hl
	call TMHM_GetEntry
	res GEN1_TM_ENTRY_F, a
	cp NUM_TMS + 1
	jr nc, .HM
	ld [wTempTMHM], a
	ld de, wTempTMHM
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	jr .okay

.HM:
	sub NUM_TMS
	ld [wTempTMHM], a
	ld [hl], 'H'
	inc hl
	ld de, wTempTMHM
	lb bc, PRINTNUM_LEFTALIGN | 1, 2
	call PrintNum
.okay
; its move
	pop hl
	pop bc
	push bc
	push hl
	call TMHM_GetEntryMove
	ld [wNamedObjectIndex], a
	ld [wPutativeTMHMMove], a
	call GetMoveName
	pop hl
	push hl
	ld bc, 3
	add hl, bc
	call PlaceString
	pop hl
; below: which GEN's (when both have a TM of its number); no count, as a TM never
; runs out
	pop bc
	push bc
	ld de, SCREEN_WIDTH + 3
	add hl, de
	call TMHM_PlaceEntryGen
	pop bc
	pop de
	dec d
	jp nz, .loop2
	jr .done

.NotTMHM:
	call TMHMPocket_GetCurrentLineCoord
	inc hl
	inc hl
	inc hl
	push de
	ld de, TMHM_CancelString
	call PlaceString
	pop de
.done
	ret

TMHM_PlaceEntryGen:
; At hl, "GEN 1" or "GEN 2" if TM pocket entry c is a TM of a number both GENs have
; TMs of; preserves bc, hl
	call TMHM_GetEntry
	ld de, .Gen1String
	bit GEN1_TM_ENTRY_F, a
	jr nz, .place
; (GEN 1's TM of the number is the entry before)
	set GEN1_TM_ENTRY_F, a
	ld e, a
	push bc
	dec c
	call TMHM_GetEntry
	pop bc
	cp e
	ret nz
	ld de, .Gen2String
.place
	push hl
	push bc
	call PlaceString
	pop bc
	pop hl
	ret

.Gen1String:
	db "GEN 1@"
.Gen2String:
	db "GEN 2@"

TMHM_GetEntry:
; a: TM pocket entry c's (see TMHMPocketEntries); preserves bc, de, hl
	push hl
	push bc
	ld b, 0
	ld hl, TMHMPocketEntries - 1
	add hl, bc
	ld a, [hl]
	pop bc
	pop hl
	ret

TMHM_EntryQuantity:
; a: how many of TM pocket entry c's TM or HM there are (of GEN 1's TM, 1 or 0); z
; if none; preserves bc, de, hl
	push hl
	push de
	push bc
	call TMHM_GetEntry
	bit GEN1_TM_ENTRY_F, a
	jr nz, .gen1
	ld hl, wTMsHMs - 1
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	jr .done

.gen1
	res GEN1_TM_ENTRY_F, a
	call CheckGen1TM
	ld a, c
	and a
	jr z, .done
	ld a, 1
.done
	pop bc
	pop de
	pop hl
	and a
	ret

TMHM_GetEntryMove:
; a: TM pocket entry c's move (its ID); preserves bc, de, hl
	push hl
	push de
	push bc
	call TMHM_GetEntry
	bit GEN1_TM_ENTRY_F, a
	res GEN1_TM_ENTRY_F, a
	ld [wTempTMHM], a
	jr nz, .gen1
	predef GetTMHMMove
	jr .done

.gen1
	farcall GetGen1TMMove
.done
	pop bc
	pop de
	pop hl
	ld a, [wTempTMHM]
	ret

CheckGen1TM::
; c: nonzero if GEN 1's TM a is had (see wGen1TMs)
	dec a
	ld e, a
	ld d, 0
	ld hl, wGen1TMs
	ld b, CHECK_FLAG
	jp FlagAction

	db 0 ; (entry 0: none)
TMHMPocketEntries:
; The TM pocket's order (from entry 1): by number, GEN 1's TM before this game's
; when their moves differ; then the HMs. Each is a TM or HM's number (as wTMsHMs
; has them), or with GEN1_TM_ENTRY_F, GEN 1's TM's.
	table_width 1
for n, 1, NUM_TMS + 1
	if G1TM{02d:n}_MOVE != TM{02d:n}_MOVE
		db 1 << GEN1_TM_ENTRY_F | n
	endc
	db n
endr
for n, NUM_TMS + 1, NUM_TMS + NUM_HMS + 1
	db n
endr
	assert_table_length NUM_TMHM_POCKET_ENTRIES

TMHMPocket_GetCurrentLineCoord:
	hlcoord 5, 0
	ld bc, 2 * SCREEN_WIDTH
	ld a, 6
	sub d
	ld e, a
	; AddNTimes
.loop
	add hl, bc
	dec e
	jr nz, .loop
	ret

PlaceMoveNameAfterTMHMName: ; unreferenced
; Similar to a part of TMHM_DisplayPocketItems.
	pop hl
	ld bc, 3
	add hl, bc
	predef GetTMHMMove
	ld a, [wTempTMHM]
	ld [wPutativeTMHMMove], a
	call GetMoveName
	push hl
	call PlaceString
	pop hl
	ret

TMHM_CancelString:
	db "CANCEL@"

TMHM_GetCurrentPocketPosition:
; c: the pocket's entry before the first one shown (wTMHMPocketScrollPosition had
; ones are scrolled past)
	ld a, [wTMHMPocketScrollPosition]
	ld b, a
	inc b
	ld c, 0
.loop
	inc c
	ld a, c
	cp NUM_TMHM_POCKET_ENTRIES + 1
	jr nc, .done
	call TMHM_EntryQuantity
	jr z, .loop
	dec b
	jr nz, .loop
.done
	dec c
	ret

Tutorial_TMHMPocket:
	hlcoord 9, 3
	push de
	ld de, TMHM_CancelString
	call PlaceString
	pop de
	ret

TMHM_PlaySFX_ReadText2:
	push de
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	pop de
	ret

VerboseReceiveTMHM: ; unreferenced
	call ConvertCurItemIntoCurTMHM
	call .CheckHaveRoomForTMHM
	ld hl, .NoRoomTMHMText
	jr nc, .print
	ld hl, .ReceivedTMHMText
.print
	jp PrintText

.NoRoomTMHMText:
	text_far _NoRoomTMHMText
	text_end

.ReceivedTMHMText:
	text_far _ReceivedTMHMText
	text_end

.CheckHaveRoomForTMHM:
	ld a, [wTempTMHM]
	dec a
	ld hl, wTMsHMs
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	inc a
	cp MAX_ITEM_STACK + 1
	ret nc
	ld [hl], a
	ret

ConsumeTM:
; (TMs are never used up, as in PalletToPewter)
	ret

	call ConvertCurItemIntoCurTMHM
	ld a, [wTempTMHM]
	dec a
	ld hl, wTMsHMs
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	and a
	ret z
	dec a
	ld [hl], a
	ret nz
	ld a, [wTMHMPocketScrollPosition]
	and a
	ret z
	dec a
	ld [wTMHMPocketScrollPosition], a
	ret

CountTMsHMs:
; wTempTMHM: how many of the pocket's entries are had
	ld b, 0
	ld c, 0
.loop
	inc c
	ld a, c
	cp NUM_TMHM_POCKET_ENTRIES + 1
	jr nc, .done
	call TMHM_EntryQuantity
	jr z, .loop
	inc b
	jr .loop

.done
	ld a, b
	ld [wTempTMHM], a
	ret
