; GEN 1's TMs, for sale (see add_g1tm and wGen1TMs): GOLDENROD DEPT. STORE 5F's
; clerk sells the plainer ones, CELADON DEPT. STORE 3F's the rest, at RED and
; BLUE's prices. Like the TMs here, one is never used up.

Gen1TMShop:
; wScriptVar: which shop (GEN1TMSHOP_*)
	ld hl, .IntroText
	call PrintText
.loop
	call BuildGen1TMShopList
	ld hl, .WhichText
	call PrintText
	call ChooseGen1TM
	jr c, .done
	ld [wCurGen1TM], a
	call CheckGen1TMHad
	jr nz, .had
; "MOVE costs ¥price. OK?"
	ld a, [wCurGen1TM]
	call GetGen1TMShopMoveName
	ld a, [wCurGen1TM]
	call GetGen1TMPrice
	ld hl, .CostText
	call PrintText
	call YesNoBox
	jr c, .next
	ld de, wMoney
	ld bc, hMoneyTemp
	farcall CompareMoney
	jr c, .no_money
	ld de, wMoney
	ld bc, hMoneyTemp
	farcall TakeMoney
	ld a, [wCurGen1TM]
	dec a
	ld e, a
	ld d, 0
	ld hl, wGen1TMs
	ld b, SET_FLAG
	call FlagAction
	call WaitSFX
	ld de, SFX_TRANSACTION
	call PlaySFX
	ld hl, .HereYouGoText
	call PrintText
	jr .next

.had
	ld hl, .HadText
	call PrintText
	jr .next

.no_money
	ld hl, .NoMoneyText
	call PrintText
.next
	call Call_ExitMenu
	jr .loop

.done
	ld hl, .ComeAgainText
	jp PrintText

.IntroText:
	text "Welcome! I sell"
	line "TMs from long ago:"
	cont "GEN 1's!"

	para "They never wear"
	line "out, either."
	prompt

.WhichText:
	text "Which TM would"
	line "you like?"
	done

.CostText:
	text_ram wStringBuffer1
	text " is"
	line "¥@"
	text_decimal hMoneyTemp, 3, 6
	text ". OK?"
	done

.HereYouGoText:
	text "Here you go!"
	prompt

.HadText:
	text "You have that one"
	line "already!"
	prompt

.NoMoneyText:
	text "You don't have"
	line "enough money."
	prompt

.ComeAgainText:
	text "Please come again!"
	done

BuildGen1TMShopList:
; wMoveRelearnerMoves: shop wScriptVar's TMs (their numbers)
	ld a, [wScriptVar]
	add a
	ld c, a
	ld b, 0
	ld hl, Gen1TMShops
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wMoveRelearnerMoves
	ld c, 0
.loop
	ld a, [hli]
	ld [de], a
	inc de
	cp -1
	jr z, .done
	inc c
	jr .loop

.done
	ld a, c
	ld [wMoveRelearnerCount], a
	ret

ChooseGen1TM:
; a: the TM chosen (its number), with the list still up (carry if none, the
; list gone)
	call LoadStandardMenuHeader
	xor a
	ld [wMenuScrollPosition], a
	inc a
	ld [wMenuCursorPosition], a
	ld hl, .MenuHeader
	call CopyMenuHeader
	xor a
	ldh [hBGMapMode], a
	call InitScrollingMenu
	call UpdateSprites
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp PAD_B
	jr z, .cancel
	ld a, [wMenuSelection]
	cp -1
	jr z, .cancel
	and a
	ret

.cancel
	call Call_ExitMenu
	scf
	ret

.MenuHeader:
; (as the MOVE REMINDER's list: see ChooseRelearnerMove)
	db MENU_BACKUP_TILES ; flags
	menu_coords 1, 1, SCREEN_WIDTH - 2, TEXTBOX_Y - 2
	dw .MenuData
	db 1 ; default option

	db 0 ; unused

.MenuData:
	db SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_FUNCTION3 ; flags
	db 4, 0 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; item format
	dbw 0, wMoveRelearnerCount
	dba .TM
	dba NULL
	dba .Details

.TM:
; "TM01 MEGA PUNCH", and below, its price (or that it's had)
	push de
	ld h, d
	ld l, e
	ld [hl], 'T'
	inc hl
	ld [hl], 'M'
	inc hl
	ld de, wMenuSelection
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ld a, [wMenuSelection]
	call GetGen1TMShopMoveName
	pop hl
	push hl
	ld bc, 5
	add hl, bc
	call PlaceString
	pop hl
	ld bc, SCREEN_WIDTH + 5
	add hl, bc
	ld a, [wMenuSelection]
	call CheckGen1TMHad
	jr nz, .had
	push hl
	ld a, [wMenuSelection]
	call GetGen1TMPrice
	pop hl
	ld [hl], '¥'
	inc hl
	ld de, hMoneyTemp
	lb bc, PRINTNUM_LEFTALIGN | 3, 6
	jp PrintNum

.had
	ld de, .HadString
	jp PlaceString

.HadString:
	db "BOUGHT@"

.Details:
; the text box below: the highlighted TM's move's category, PP, power and
; accuracy (as the MOVE REMINDER's)
	ld a, [wMenuSelection]
	cp -1
	jp z, ChooseRelearnerMove.Details ; (CANCEL)
	push af
	ld [wTempTMHM], a
	farcall GetGen1TMMove
	ld a, [wTempTMHM]
	ld [wMenuSelection], a
	call ChooseRelearnerMove.Details
	pop af
	ld [wMenuSelection], a
	ret

GetGen1TMShopMoveName:
; de: the name of GEN 1's TM a's move (in wStringBuffer1)
	ld [wTempTMHM], a
	farcall GetGen1TMMove
	ld a, [wTempTMHM]
	ld [wNamedObjectIndex], a
	jp GetMoveName

CheckGen1TMHad:
; nz if GEN 1's TM a is had; preserves hl
	push hl
	dec a
	ld e, a
	ld d, 0
	ld hl, wGen1TMs
	ld b, CHECK_FLAG
	call FlagAction
	pop hl
	ld a, c
	and a
	ret

GetGen1TMPrice:
; hMoneyTemp: GEN 1's TM a's price (big-endian)
	dec a
	ld c, a
	ld b, 0
	ld hl, Gen1TMPrices
	add hl, bc
	ld b, [hl] ; (thousands)
	ld hl, 0
	ld de, 1000
.thousands
	add hl, de
	dec b
	jr nz, .thousands
	xor a
	ldh [hMoneyTemp], a
	ld a, h
	ldh [hMoneyTemp + 1], a
	ld a, l
	ldh [hMoneyTemp + 2], a
	ret

Gen1TMShops:
; the TMs each shop sells (GEN1TMSHOP_*)
	table_width 2
	dw .Goldenrod
	dw .Celadon
	assert_table_length NUM_GEN1TMSHOPS

.Goldenrod:
	db 1, 2, 4, 5, 9, 11, 12, 16, 17, 18, 19, 20, 21, 23, 30, 31, 33, 34, 35, 37, 40, 45, 46, 49
	db -1 ; end
.Celadon:
	db 3, 7, 8, 10, 13, 24, 27, 36, 41, 43, 47, 48, 50
	db -1 ; end

Gen1TMPrices:
; GEN 1's TMs' prices, in thousands (as in RED and BLUE)
	table_width 1
	db 3 ; TM01
	db 2 ; TM02
	db 2 ; TM03
	db 1 ; TM04
	db 3 ; TM05
	db 4 ; TM06
	db 2 ; TM07
	db 4 ; TM08
	db 3 ; TM09
	db 4 ; TM10
	db 2 ; TM11
	db 1 ; TM12
	db 4 ; TM13
	db 5 ; TM14
	db 5 ; TM15
	db 5 ; TM16
	db 3 ; TM17
	db 2 ; TM18
	db 3 ; TM19
	db 2 ; TM20
	db 5 ; TM21
	db 5 ; TM22
	db 5 ; TM23
	db 2 ; TM24
	db 5 ; TM25
	db 4 ; TM26
	db 5 ; TM27
	db 2 ; TM28
	db 4 ; TM29
	db 1 ; TM30
	db 2 ; TM31
	db 1 ; TM32
	db 1 ; TM33
	db 2 ; TM34
	db 4 ; TM35
	db 2 ; TM36
	db 2 ; TM37
	db 5 ; TM38
	db 2 ; TM39
	db 4 ; TM40
	db 2 ; TM41
	db 2 ; TM42
	db 5 ; TM43
	db 2 ; TM44
	db 2 ; TM45
	db 4 ; TM46
	db 3 ; TM47
	db 4 ; TM48
	db 4 ; TM49
	db 2 ; TM50
	assert_table_length NUM_TMS
