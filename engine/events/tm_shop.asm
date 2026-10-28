; TMs for sale: a mart's that sells only TMs (GOLDENROD DEPT. STORE 5F, CELADON
; DEPT. STORE 3F: see StandardMart.Buy) and the GAME CORNERs' TM prizes, shown as
; GEN 1's TM clerk shows his (see Gen1TMShop): "TM02 HEADBUTT" with its price (or
; BOUGHT) below, and the highlighted one's move's category, PP, power and
; accuracy in the box. A TM is never used up, so each sells one.

TMMartBuy::
; wCurMartCount: the mart's TMs (see FarReadMart), for money
	xor a
	ld [wTMShopCoins], a
	ld hl, wCurMartCount
	ld de, wMoveRelearnerCount
	ld a, [hli]
	ld [de], a
	inc de
.copy
	ld a, [hli]
	ld [de], a
	inc de
	cp -1
	jr nz, .copy
	jr TMShop

TMPrizes:
; wScriptVar: a GAME CORNER's TM prizes (TMPRIZES_*), for coins
	ld a, TRUE
	ld [wTMShopCoins], a
	call GetTMPrizes
	ld de, wMoveRelearnerMoves
	ld c, 0
.loop
	ld a, [hli]
	ld [de], a
	inc de
	cp -1
	jr z, .done
	inc hl ; (its coins)
	inc hl
	inc c
	jr .loop

.done
	ld a, c
	ld [wMoveRelearnerCount], a
	; fallthrough

TMShop:
	ld a, [wTMShopCoins]
	and a
	jr z, .which
	farcall DisplayCoinCaseBalance
.which
	ld hl, Gen1TMShop.WhichText
	call PrintText
	call ChooseTMForSale
	ret c
	ld [wTMShopItem], a
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr c, .had
; "MOVE costs ¥price. OK?" (or so many coins)
	ld a, [wTMShopItem]
	call GetTMForSaleMoveName
	ld a, [wTMShopItem]
	call GetTMForSalePrice
	ld hl, Gen1TMShop.CostText
	ld a, [wTMShopCoins]
	and a
	jr z, .got_cost_text
	ld hl, .CoinsCostText
.got_cost_text
	call PrintText
	call YesNoBox
	jr c, .next
	ld a, [wTMShopCoins]
	and a
	jr nz, .coins
	ld de, wMoney
	ld bc, hMoneyTemp
	farcall CompareMoney
	jr c, .no_money
	ld de, wMoney
	ld bc, hMoneyTemp
	farcall TakeMoney
	jr .give

.coins
	ld bc, hMoneyTemp
	farcall CheckCoins
	jr c, .no_coins
	ld bc, hMoneyTemp
	farcall TakeCoins
	farcall DisplayCoinCaseBalance
.give
	ld a, [wTMShopItem]
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantityChange], a
	ld hl, wNumItems
	call ReceiveItem
	call WaitSFX
	ld de, SFX_TRANSACTION
	call PlaySFX
	ld hl, Gen1TMShop.HereYouGoText
	call PrintText
	jr .next

.had
	ld hl, Gen1TMShop.HadText
	call PrintText
	jr .next

.no_money
	ld hl, Gen1TMShop.NoMoneyText
	call PrintText
	jr .next

.no_coins
	ld hl, .NoCoinsText
	call PrintText
.next
	call Call_ExitMenu
	jp TMShop

.CoinsCostText:
	text_ram wStringBuffer1
	text " is"
	line "@"
	text_decimal hMoneyTemp, 2, 4
	text " coins. OK?"
	done

.NoCoinsText:
	text "You don't have"
	line "enough coins."
	prompt

ChooseTMForSale:
; a: the TM chosen (its item), with the list still up (carry if none, the list
; gone)
	call LoadStandardMenuHeader
	xor a
	ld [wMenuScrollPosition], a
	inc a
	ld [wMenuCursorPosition], a
	ld hl, .MenuHeader
	ld a, [wTMShopCoins]
	and a
	jr z, .got_header
	ld hl, .CoinsMenuHeader
.got_header
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
; (as GEN 1's TM clerk's list: see ChooseGen1TM)
	db MENU_BACKUP_TILES ; flags
	menu_coords 1, 1, SCREEN_WIDTH - 2, TEXTBOX_Y - 2
	dw .MenuData
	db 1 ; default option

.CoinsMenuHeader:
; (three rows, under the COIN CASE's balance)
	db MENU_BACKUP_TILES ; flags
	menu_coords 1, 3, SCREEN_WIDTH - 2, TEXTBOX_Y - 2
	dw .CoinsMenuData
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

.CoinsMenuData:
	db SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_FUNCTION3 ; flags
	db 3, 0 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; item format
	dbw 0, wMoveRelearnerCount
	dba .TM
	dba NULL
	dba .Details

.TM:
; "TM02 HEADBUTT", and below, its price (or that it's had)
	push de
	ld a, [wMenuSelection]
	ld [wCurItem], a
	farcall ConvertCurItemIntoCurTMHM
	pop hl
	push hl
	ld [hl], 'T'
	inc hl
	ld [hl], 'M'
	inc hl
	ld de, wTempTMHM
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ld a, [wMenuSelection]
	call GetTMForSaleMoveName
	pop hl
	push hl
	ld bc, 5
	add hl, bc
	call PlaceString
	pop hl
	ld bc, SCREEN_WIDTH + 5
	add hl, bc
	ld a, [wMenuSelection]
	ld [wCurItem], a
	push hl
	ld hl, wNumItems
	call CheckItem
	pop hl
	jr c, .had
	push hl
	ld a, [wMenuSelection]
	call GetTMForSalePrice
	pop hl
	ld a, [wTMShopCoins]
	and a
	jr nz, .coins
	ld [hl], '¥'
	inc hl
	ld de, hMoneyTemp
	lb bc, PRINTNUM_LEFTALIGN | 3, 6
	jp PrintNum

.coins
	ld de, hMoneyTemp
	lb bc, PRINTNUM_LEFTALIGN | 2, 4
	call PrintNum
	inc hl
	ld de, .CoinsString
	jp PlaceString

.had
	ld de, ChooseGen1TM.HadString
	jp PlaceString

.CoinsString:
	db "COINS@"

.Details:
; the text box below: the highlighted TM's move's category, PP, power and
; accuracy (as GEN 1's TM clerk's)
	ld a, [wMenuSelection]
	cp -1
	jp z, ChooseRelearnerMove.Details ; (CANCEL)
	push af
	ld [wCurItem], a
	farcall GetTMHMItemMove
	ld a, [wTempTMHM]
	ld [wMenuSelection], a
	call ChooseRelearnerMove.Details
	pop af
	ld [wMenuSelection], a
	ret

GetTMForSaleMoveName:
; de: the name of TM item a's move (in wStringBuffer1)
	ld [wCurItem], a
	farcall GetTMHMItemMove
	ld a, [wTempTMHM]
	ld [wNamedObjectIndex], a
	jp GetMoveName

GetTMForSalePrice:
; hMoneyTemp: TM item a's price, big-endian: three bytes of money (its price in
; the PACK), or two of coins (its prize table's)
	ld [wCurItem], a
	ld b, a
	ld a, [wTMShopCoins]
	and a
	jr nz, .coins
	farcall GetItemPrice
	xor a
	ldh [hMoneyTemp], a
	ld a, d
	ldh [hMoneyTemp + 1], a
	ld a, e
	ldh [hMoneyTemp + 2], a
	ret

.coins
	call GetTMPrizes
.find
	ld a, [hli]
	cp b
	jr z, .found
	inc hl
	inc hl
	jr .find

.found
	ld a, [hli]
	ldh [hMoneyTemp + 1], a
	ld a, [hl]
	ldh [hMoneyTemp], a
	ret

GetTMPrizes:
; hl: GAME CORNER wScriptVar's TM prizes (TMPRIZES_*)
	ld a, [wScriptVar]
	add a
	ld e, a
	ld d, 0
	ld hl, TMPrizeTables
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

TMPrizeTables:
; each: TM, coins (TMPRIZES_*)
	table_width 2
	dw .Goldenrod
	dw .Celadon
	assert_table_length NUM_TMPRIZES

.Goldenrod:
	dbw TM_THUNDER,    5500
	dbw TM_BLIZZARD,   5500
	dbw TM_FIRE_BLAST, 5500
	db -1 ; end

.Celadon:
	dbw TM_DOUBLE_TEAM, 1500
	dbw TM_PSYCHIC_M,   3500
	dbw TM_HYPER_BEAM,  7500
	db -1 ; end
