; MINT: changes a POKéMON's nature, as the latest games' mints do (one item for all
; of them: you choose the nature from a list). The nature is kept in the POKéMON's
; stat exps' lowest bits (see GetMint in engine/pokemon/natures.asm). Sold by the
; vitamins in GOLDENROD and CELADON, and found under fruit trees.

ChooseMintNature::
; (MintEffect) e: the nature chosen from a list of them all, with the stats each
; raises and lowers (carry: none). The list takes over wCurItem and
; wCurItemQuantity: the MINT's are kept, to use it up.
	ld a, [wCurItem]
	push af
	ld a, [wCurItemQuantity]
	push af
	call .Choose
	pop bc
	ld a, b
	ld [wCurItemQuantity], a
	pop bc
	ld a, b
	ld [wCurItem], a
	ret

.Choose:
	ld hl, wMintNatureCount
	ld a, NUM_NATURES
	ld [hli], a
	xor a
.list
	ld [hli], a
	inc a
	cp NUM_NATURES
	jr nz, .list
	ld [hl], -1
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
	ld e, a
	push de
	call Call_ExitMenu
	pop de
	and a
	ret

.cancel
	call Call_ExitMenu
	scf
	ret

.MenuHeader:
; (as the MOVE REMINDER's: see ChooseRelearnerMove)
	db MENU_BACKUP_TILES ; flags
	menu_coords 1, 1, SCREEN_WIDTH - 2, TEXTBOX_Y - 2
	dw .MenuData
	db 1 ; default option

	db 0 ; unused

.MenuData:
	db SCROLLINGMENU_DISPLAY_ARROWS | SCROLLINGMENU_ENABLE_FUNCTION3 ; flags
	db 4, 0 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; item format
	dbw 0, wMintNatureCount
	dba .Nature
	dba NULL
	dba .Details

.Nature:
; its name
	push de
	ld a, [wMenuSelection]
	ld c, a
	ld de, wStringBuffer1
	farcall CopyNatureName
	pop hl
	ld de, wStringBuffer1
	jp PlaceString

.Details:
; the text box below the list: the stats the highlighted nature raises and lowers
	hlcoord TEXTBOX_X, TEXTBOX_Y
	lb bc, TEXTBOX_INNERH, TEXTBOX_INNERW
	call Textbox
	ld a, [wMenuSelection]
	cp -1
	ret z ; (CANCEL)
	ld b, 0
.fifths
	cp 5
	jr c, .got_stats
	sub 5
	inc b
	jr .fifths

.got_stats
; b: the stat it raises, a: the one it lowers (0-4: ATTACK-SPCL.DEF)
	cp b
	jr z, .neutral
	push af
	push bc
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY
	ld de, .UpText
	call PlaceString
	pop bc
	ld a, b
	hlcoord TEXTBOX_INNERX + 6, TEXTBOX_INNERY
	call .PlaceStat
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	ld de, .DownText
	call PlaceString
	pop af
	hlcoord TEXTBOX_INNERX + 6, TEXTBOX_INNERY + 2
	; fallthrough

.PlaceStat:
; a: a stat (0-4), at hl
	push hl
	ld hl, .StatNames
	call GetNthString
	ld d, h
	ld e, l
	pop hl
	jp PlaceString

.neutral
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY
	ld de, .NoChangeText
	jp PlaceString

.UpText:
	db "Up:@"

.DownText:
	db "Down:@"

.NoChangeText:
	db "No stat changes@"

.StatNames:
; (as the stats screen's)
	db "ATTACK@"
	db "DEFENSE@"
	db "SPEED@"
	db "SPCL.ATK@"
	db "SPCL.DEF@"
