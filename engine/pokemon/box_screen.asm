; BILL's PC as in the latest games: one screen, with the box's POKéMON as icons in
; a grid (5 by 4), the party beside it, and above them the one under the cursor
; (its pic, name, level, types, item and nature). Pick a POKéMON up and put it
; down anywhere: elsewhere in its box, in another box, or in the party; put it on
; another POKéMON and the two change places.
;
; The icons are drawn into the background (VRAM bank 1), 20 pixels apart, each in
; its color (BoxIconColors): see BoxScreen_DrawIcons. The cursor and the POKéMON
; held are sprites. A box is changed by making it the box out, as BILL's PC
; always did (BoxScreen_SetCurBox); after any change the game's saved on leaving
; (see _BillsPC).

; a POKéMON put aside (wBoxScreenStash1, wBoxScreenStash2), by its indexes
rsreset
DEF BOXSTASH_SPECIES     rw ; (EGG's, for an egg)
DEF BOXSTASH_MON         rb BOXMON_STRUCT_LENGTH ; (its moves' indexes, as the boxes keep them)
DEF BOXSTASH_MON_SPECIES rw
DEF BOXSTASH_NICKNAME    rb MON_NAME_LENGTH
DEF BOXSTASH_OT          rb NAME_LENGTH
DEF BOXSTASH_LENGTH EQU _RS
	assert wBoxScreenStash2 - wBoxScreenStash1 == BOXSTASH_LENGTH

BoxScreen:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ld a, [wStateFlags]
	push af
	xor a
	ld [wStateFlags], a
	ldh a, [hInMenu]
	push af
	ld a, TRUE
	ldh [hInMenu], a
	xor a
	ldh [hMapAnims], a
	call BoxScreen_InitRAM
	call BoxScreen_InitScreen
.loop
	call JoyTextDelay
	call BoxScreen_Joypad
	jr c, .done
	call BoxScreen_ShowCursorMon
	call BoxScreen_UpdateSprites
	call DelayFrame
	jr .loop

.done
	call ClearSprites
	pop af
	ldh [hInMenu], a
	pop af
	ld [wStateFlags], a
	pop af
	ld [wOptions], a
; carry if anything changed
	ld a, [wBoxScreenChanged]
	and a
	ret z
	scf
	ret

BoxScreen_InitRAM:
	ld hl, wBillsPCData
	ld bc, wBillsPCDataEnd - wBillsPCData
	xor a
	call ByteFill
	ld a, [wCurBox]
	inc a
	ld [wBoxScreenBox], a
	ld a, BOXZONE_BOX
	ld [wBoxScreenZone], a
	ret

BoxScreen_InitScreen:
; (again after the stats screen or the naming screen)
	xor a
	ldh [hBGMapMode], a
	call ClearBGPalettes
	call ClearSprites
	hlcoord 0, 0
	ld bc, SCREEN_AREA
	ld a, ' '
	call ByteFill
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_AREA
	xor a
	call ByteFill
	farcall BillsPC_InitGFX ; (the fonts, and the item and arrow tiles)
	ld de, BoxCursorGFX
	ld hl, vTiles0 tile BOXSCREEN_CURSOR_TILE
	lb bc, BANK(BoxCursorGFX), 1
	call Get2bpp
	ld a, [wBoxScreenHeld]
	and a
	call nz, BoxScreen_LoadHeldGFX
; the canvas: each tile its own (in VRAM bank 1)
	hlcoord 0, BOXSCREEN_CANVAS_Y
	ld b, BOXSCREEN_CANVAS_TILES
	xor a
.canvas
	ld [hli], a
	inc a
	dec b
	jr nz, .canvas
	call BoxScreen_DrawIcons
	call BoxScreen_DrawHeader
	ld a, -1
	ld [wBoxScreenShown], a
	call BoxScreen_ShowCursorMon
	call BoxScreen_SetPalettes
	call WaitBGMap2
	ret

; the icons

BoxScreen_LoadBoxList:
; The shown box's POKéMON's species in wBillsPCPokemonList (see
; CopyBoxmonSpecies), and how many in wBoxScreenCount.
	ld a, [wBoxScreenBox]
	ld b, a
	dec a
	ld hl, wCurBox
	cp [hl]
	ld a, NUM_BOXES + 1 ; (the box out)
	jr z, .got_box
	ld a, [wSavedAtLeastOnce]
	and a
	jr z, .empty ; (the boxes aren't made yet)
	ld a, b
.got_box
	ld [wBillsPC_LoadedBox], a
	farcall CopyBoxmonSpecies
	ld a, [wBillsPC_NumMonsInBox]
	dec a ; (its CANCEL)
	ld [wBoxScreenCount], a
	ret

.empty
	ld a, -1
	ld [wBillsPCPokemonList], a
	xor a
	ld [wBoxScreenCount], a
	ret

BoxScreen_DrawIcons:
; The shown box's and the party's icons, but the POKéMON held's
	call BoxScreen_LoadBoxList
	ldh a, [rWBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rWBK], a
	ld hl, wDecompressScratch
	ld bc, BOXSCREEN_CANVAS_TILES tiles
	xor a
	call ByteFill
	pop af
	ldh [rWBK], a
	hlcoord 0, BOXSCREEN_CANVAS_Y, wAttrmap
	ld bc, BOXSCREEN_CANVAS_TILES
	ld a, OAM_BANK1 | BOXPAL_GRAY
	call ByteFill
; the box's
	ld c, 0
.box
	ld a, [wBoxScreenCount]
	cp c
	jr z, .party
	push bc
	ld b, c
	ld a, BOXZONE_BOX
	call BoxScreen_IsHeld
	jr z, .next_box
	ld a, c
	call BoxScreen_BoxSpecies
	push af
	ld a, c
	call BoxScreen_BoxCellXY
	pop af
	call BoxScreen_DrawIcon
.next_box
	pop bc
	inc c
	jr .box

.party
	ld c, 0
.party_loop
	ld a, [wPartyCount]
	cp c
	jr z, .done
	push bc
	ld b, c
	ld a, BOXZONE_PARTY
	call BoxScreen_IsHeld
	jr z, .next_party
	ld a, c
	call BoxScreen_PartyCellXY
	ld hl, wPartySpecies
	ld b, 0
	add hl, bc
	ld a, [hl]
	call BoxScreen_DrawIcon
.next_party
	pop bc
	inc c
	jr .party_loop

.done
	jp BoxScreen_TransferCanvas

BoxScreen_IsHeld:
; z if the POKéMON at zone a, index b (of the shown box) is the one held
	ld hl, wBoxScreenHeld
	cp [hl]
	ret nz
	cp BOXZONE_PARTY
	jr z, .index
	ld a, [wBoxScreenBox]
	ld hl, wBoxScreenHeldBox
	cp [hl]
	ret nz
.index
	ld a, [wBoxScreenHeldIndex]
	cp b
	ret

BoxScreen_BoxSpecies:
; a: the shown box's POKéMON a's species (EGG for an egg)
	ld e, a
	ld d, 0
	ld hl, wBillsPCPokemonList + BOXLIST_SPECIES
rept BOXLIST_SIZE
	add hl, de
endr
	ld a, [hl]
	ret

BoxScreen_BoxCellXY:
; d, e: where the box's place a is in the canvas (pixels)
	ld e, BOXSCREEN_BOX_Y
.row
	cp BOX_COLS
	jr c, .got_row
	sub BOX_COLS
	push af
	ld a, e
	add BOXSCREEN_ICON_PITCH
	ld e, a
	pop af
	jr .row
.got_row
	ld d, BOXSCREEN_BOX_X
.col
	and a
	ret z
	dec a
	push af
	ld a, d
	add BOXSCREEN_ICON_PITCH
	ld d, a
	pop af
	jr .col

BoxScreen_PartyCellXY:
; d, e: where the party's place a is in the canvas (pixels)
	ld e, BOXSCREEN_PARTY_Y
	ld d, BOXSCREEN_PARTY_X
.row
	cp BOXSCREEN_PARTY_COLS
	jr c, .got_row
	sub BOXSCREEN_PARTY_COLS
	push af
	ld a, e
	add BOXSCREEN_ICON_PITCH
	ld e, a
	pop af
	jr .row
.got_row
	and a
	ret z
	ld a, d
	add BOXSCREEN_PARTY_PITCH_X
	ld d, a
	ret

BoxScreen_DrawIcon:
; species a's icon at d, e in the canvas, in its color
	push de
	ld [wTempIconSpecies], a
	call BoxScreen_GetIconColor
	pop de
	push de
	call BoxScreen_ColorCell
	farcall LoadBoxScreenIcon
	pop de
	jp BoxScreen_Blit

BoxScreen_GetIconColor:
; a: species [wTempIconSpecies]'s color (BOXPAL_*)
	ld a, [wTempIconSpecies]
	ld hl, BoxIconColors
	ld bc, 1
	call GetSpeciesTableEntry
	ld a, [hl]
	ret

BoxScreen_ColorCell:
; The attributes of the canvas's tiles of the icon at d, e: color a, VRAM bank 1.
	or OAM_BANK1
	ld [wBoxScreenRowBytes], a
; its first tile's
	ld a, e
	srl a
	srl a
	srl a
	ld l, a
	ld h, 0
	ld b, h
	ld c, l
	add hl, hl
	add hl, hl
	add hl, bc
	add hl, hl
	add hl, hl ; x SCREEN_WIDTH
	ld a, d
	srl a
	srl a
	srl a
	ld c, a
	ld b, 0
	add hl, bc
	ld bc, wAttrmap + BOXSCREEN_CANVAS_Y * SCREEN_WIDTH
	add hl, bc
; how many rows and columns: 2, or 3 if not on a tile
	ld a, e
	and 7
	ld b, 2
	jr z, .got_rows
	inc b
.got_rows
	ld a, d
	and 7
	ld c, 2
	jr z, .got_cols
	inc c
.got_cols
	ld a, [wBoxScreenRowBytes]
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

BoxScreen_Blit:
; The icon in wBoxScreenIconBuffer (its first frame) into the canvas at d, e
; (d mod 8 is 0 or 4).
	ldh a, [rWBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rWBK], a
	ld b, 0
.row
	push bc
	push de
; its row b's two tiles' bytes
	ld a, b
	and %1000
	add a
	add a ; (the tiles below: 2 tiles further)
	ld c, a
	ld a, b
	and %111
	add a
	add c
	ld l, a
	ld h, 0
	ld bc, wBoxScreenIconBuffer
	add hl, bc
	ld a, [hli]
	ld [wBoxScreenRowBytes], a
	ld a, [hl]
	ld [wBoxScreenTarget + 1], a
	ld bc, 1 tiles - 1
	add hl, bc
	ld a, [hli]
	ld [wBoxScreenRowBytes + 2], a
	ld a, [hl]
	ld [wBoxScreenRowBytes + 3], a
	pop de
	pop bc
	push bc
	push de
	ld a, e
	add b
	ld e, a
	call BoxScreen_CanvasAddress
	ld a, d
	and 7
	jr nz, .shifted
	ld a, [wBoxScreenRowBytes]
	or [hl]
	ld [hli], a
	ld a, [wBoxScreenTarget + 1]
	or [hl]
	ld [hl], a
	ld bc, 1 tiles - 1
	add hl, bc
	ld a, [wBoxScreenRowBytes + 2]
	or [hl]
	ld [hli], a
	ld a, [wBoxScreenRowBytes + 3]
	or [hl]
	ld [hl], a
	jr .next

.shifted
; (4 pixels right: over three tiles)
	ld a, [wBoxScreenRowBytes]
	swap a
	and $0f
	or [hl]
	ld [hli], a
	ld a, [wBoxScreenTarget + 1]
	swap a
	and $0f
	or [hl]
	ld [hl], a
	ld bc, 1 tiles - 1
	add hl, bc
	ld a, [wBoxScreenRowBytes]
	swap a
	and $f0
	ld c, a
	ld a, [wBoxScreenRowBytes + 2]
	swap a
	and $0f
	or c
	or [hl]
	ld [hli], a
	ld a, [wBoxScreenTarget + 1]
	swap a
	and $f0
	ld c, a
	ld a, [wBoxScreenRowBytes + 3]
	swap a
	and $0f
	or c
	or [hl]
	ld [hl], a
	ld bc, 1 tiles - 1
	add hl, bc
	ld a, [wBoxScreenRowBytes + 2]
	swap a
	and $f0
	or [hl]
	ld [hli], a
	ld a, [wBoxScreenRowBytes + 3]
	swap a
	and $f0
	or [hl]
	ld [hl], a
.next
	pop de
	pop bc
	inc b
	ld a, b
	cp 16
	jp nz, .row
	pop af
	ldh [rWBK], a
	ret

BoxScreen_CanvasAddress:
; hl: the canvas's bytes of pixel row e in tile column d / 8
	ld a, e
	and %11111000
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl ; x 8
	ld b, h
	ld c, l
	add hl, hl
	add hl, hl ; x 32
	add hl, bc ; x 40: (the row) x SCREEN_WIDTH tiles
	ld a, d
	and %11111000
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc ; (the column) x 1 tile
	ld a, e
	and 7
	add a
	ld c, a
	add hl, bc
	ld bc, wDecompressScratch
	add hl, bc
	ret

BoxScreen_TransferCanvas:
; The canvas's tiles to VRAM bank 1 (tiles $00-$c7)
	ldh a, [rLCDC]
	bit B_LCDC_ENABLE, a
	jr z, .lcd_off
	ld hl, wDecompressScratch
	ld de, vTiles5 tile $00
	ld c, $40
	call BoxScreen_HDMA
	ld hl, wDecompressScratch + $40 tiles
	ld de, vTiles5 tile $40
	ld c, $40
	call BoxScreen_HDMA
	ld hl, wDecompressScratch + $80 tiles
	ld de, vTiles4 tile $00
	ld c, BOXSCREEN_CANVAS_TILES - $80
	jp BoxScreen_HDMA

.lcd_off
	ldh a, [rWBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rWBK], a
	ld a, 1
	ldh [rVBK], a
	ld hl, wDecompressScratch
	ld de, vTiles5 tile $00
	ld bc, $80 tiles
	call CopyBytes
	ld hl, wDecompressScratch + $80 tiles
	ld de, vTiles4 tile $00
	ld bc, (BOXSCREEN_CANVAS_TILES - $80) tiles
	call CopyBytes
	xor a
	ldh [rVBK], a
	pop af
	ldh [rWBK], a
	ret

BoxScreen_HDMA:
; c (at most 127) tiles from WRAM bank 6's hl to VRAM bank 1's de, by HBlank DMA
; (as HDMATransfer_WaitForScanline128; VRAM bank 1 only while interrupts are off,
; for VBlank's BG map updates take whichever is in)
	ldh a, [rWBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rWBK], a
	ldh a, [rVBK]
	push af
	ld a, h
	ldh [rVDMA_SRC_HIGH], a
	ld a, l
	and $f0
	ldh [rVDMA_SRC_LOW], a
	ld a, d
	and $1f
	ldh [rVDMA_DEST_HIGH], a
	ld a, e
	and $f0
	ldh [rVDMA_DEST_LOW], a
	ld a, c
	dec c
	or $80
	ld e, a
	ld a, $7f
	sub c
	ld d, a
.ly_loop
	ldh a, [rLY]
	cp d
	jr nc, .ly_loop
	di
	ld a, 1
	ldh [rVBK], a
.rstat_loop_1
	ldh a, [rSTAT]
	and STAT_MODE
	jr nz, .rstat_loop_1
.rstat_loop_2
	ldh a, [rSTAT]
	and STAT_MODE
	jr z, .rstat_loop_2
	ld a, e
	ldh [rVDMA_LEN], a
	ldh a, [rLY]
	inc c
	ld hl, rLY
.final_ly_loop
	cp [hl]
	jr z, .final_ly_loop
	ld a, [hl]
	dec c
	jr nz, .final_ly_loop
	ld hl, rVDMA_LEN
	res 7, [hl]
	pop af
	ldh [rVBK], a
	ei
	pop af
	ldh [rWBK], a
	ret

BoxScreen_LoadHeldGFX:
; the POKéMON held's icon (both frames) for its sprite, and its color
	call BoxScreen_HeldSpecies
	ld [wTempIconSpecies], a
	call BoxScreen_GetIconColor
	ld [wBoxScreenHeldColor], a
	farcall LoadBoxScreenIcon ; (wCurIcon)
	farcall LoadBoxScreenHeldIcon
	ret

BoxScreen_HeldSpecies:
; a: the POKéMON held's species (EGG for an egg)
	ld a, [wBoxScreenHeld]
	cp BOXZONE_PARTY
	ld a, [wBoxScreenHeldIndex]
	jr z, .party
	ld c, a
	ld a, [wBoxScreenHeldBox]
	ld b, a
	jp BoxScreen_GetBoxSpecies

.party
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	ret

BoxScreen_GetBoxSpecies:
; a: box b's (1 to NUM_BOXES) POKéMON c's species (EGG for an egg)
	ld a, [wBoxScreenBox]
	cp b
	jr nz, .other
	ld a, c
	jp BoxScreen_BoxSpecies

.other
	ld a, [wCurBox]
	inc a
	cp b
	jr z, .out
	push bc
	farcall RefreshBoxSpecies
	farcall GetBoxPointer ; b: its bank, hl: it
	ld a, b
	call OpenSRAM
	pop bc
	inc hl ; (its species list)
.got_list
	ld b, 0
	add hl, bc
	ld a, [hl]
	jp CloseSRAM

.out
	ld a, BANK(sBoxSpecies)
	call OpenSRAM
	ld hl, sBoxSpecies
	jr .got_list

; the header and the panel

BoxScreen_DrawHeader:
; (on the box's wallpaper)
	hlcoord 0, BOXSCREEN_CANVAS_Y - 1, wAttrmap
	ld bc, SCREEN_WIDTH
	ld a, BOXPAL_GRAY
	call ByteFill
	hlcoord 0, BOXSCREEN_CANVAS_Y - 1
	ld bc, SCREEN_WIDTH
	ld a, ' '
	call ByteFill
	hlcoord 0, BOXSCREEN_CANVAS_Y - 1
	ld [hl], $5f ; ◀
	hlcoord 12, BOXSCREEN_CANVAS_Y - 1
	ld [hl], $5e ; ▶
	ld a, [wBoxScreenBox]
	dec a
	call BoxScreen_GetBoxName
; centered between the arrows
	push de
	ld c, 0
.length
	ld a, [de]
	cp '@'
	jr z, .got_length
	inc de
	inc c
	jr .length
.got_length
	ld a, 11
	sub c
	srl a
	inc a
	ld c, a
	ld b, 0
	hlcoord 0, BOXSCREEN_CANVAS_Y - 1
	add hl, bc
	pop de
	call PlaceString
	hlcoord 14, BOXSCREEN_CANVAS_Y - 1
	ld de, .Party
	jp PlaceString

.Party:
	db "PARTY@"

BoxScreen_GetBoxName:
; de: box a's (0 to NUM_BOXES - 1) name
	ld hl, wBoxNames
	ld bc, BOX_NAME_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ret

BoxScreen_CursorPlace:
; a: the cursor's zone; b: its box (0 for the party); c: its index there (0 on the
; header)
	ld a, [wBoxScreenZone]
	cp BOXZONE_PARTY
	jr z, .party
	cp BOXZONE_HEADER
	ld c, 0
	jr z, .got_index
	ld a, [wBoxScreenRow]
	ld c, a
	add a
	add a
	add c ; x BOX_COLS
	ld c, a
	ld a, [wBoxScreenCol]
	add c
	ld c, a
.got_index
	ld a, [wBoxScreenBox]
	ld b, a
	ld a, [wBoxScreenZone]
	ret

.party
	ld a, [wBoxScreenRow]
	add a ; x BOXSCREEN_PARTY_COLS
	ld c, a
	ld a, [wBoxScreenCol]
	add c
	ld c, a
	ld b, 0
	ld a, BOXZONE_PARTY
	ret

BoxScreen_CursorMonSpecies:
; a: the species of the POKéMON at the cursor (EGG for an egg), or 0 if none
	call BoxScreen_CursorPlace
	cp BOXZONE_HEADER
	jr z, .none
	cp BOXZONE_PARTY
	jr z, .party
	ld a, [wBoxScreenCount]
	cp c
	jr z, .none
	jr c, .none
	ld a, c
	jp BoxScreen_BoxSpecies

.party
	ld a, [wPartyCount]
	cp c
	jr z, .none
	jr c, .none
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	ret

.none
	xor a
	ret

BoxScreen_PanelPlace:
; a, b, c: where the POKéMON the panel shows is: the one at the cursor (see
; BoxScreen_CursorPlace), or if there's none there, the one held
	call BoxScreen_CursorMonSpecies
	and a
	jp nz, BoxScreen_CursorPlace
	ld a, [wBoxScreenHeld]
	and a
	jp z, BoxScreen_CursorPlace
	ld a, [wBoxScreenHeldBox]
	ld b, a
	ld a, [wBoxScreenHeldIndex]
	ld c, a
	ld a, [wBoxScreenHeld]
	ret

BoxScreen_ShownSpecies:
; a: the species of the POKéMON the panel shows (wBoxScreenShown; EGG for an
; egg), or 0 if there's none
	ld hl, wBoxScreenShown
	ld a, [hli]
	ld b, [hl]
	inc hl
	ld c, [hl]
	cp BOXZONE_PARTY
	jr z, .party
	ld a, [wBoxScreenBox]
	cp b
	jp nz, BoxScreen_GetBoxSpecies ; (the one held, from another box)
	ld a, [wBoxScreenCount]
	cp c
	jr z, .none
	jr c, .none
	ld a, c
	jp BoxScreen_BoxSpecies

.party
	ld a, [wPartyCount]
	cp c
	jr z, .none
	jr c, .none
	ld hl, wPartySpecies
	ld b, 0
	add hl, bc
	ld a, [hl]
	ret

.none
	xor a
	ret

BoxScreen_ShowCursorMon:
; The panel: the POKéMON at the cursor, or held (or the box's name and count), if
; that's changed.
	call BoxScreen_PanelPlace
	ld hl, wBoxScreenShown
	cp [hl]
	jr nz, .changed
	inc hl
	ld a, b
	cp [hl]
	jr nz, .changed
	inc hl
	ld a, c
	cp [hl]
	ret z
.changed
	call BoxScreen_PanelPlace
	ld hl, wBoxScreenShown
	ld [hli], a
	ld a, b
	ld [hli], a
	ld [hl], c
	xor a
	ldh [hBGMapMode], a
	call BoxScreen_ClearPanel
	ld a, [wBoxScreenShown]
	cp BOXZONE_HEADER
	jp z, .box_info
	call BoxScreen_ShownSpecies
	and a
	jp z, .done
	ld [wTempSpecies], a
	call BoxScreen_LoadShownMonData
; its pic
	hlcoord 0, 0
	xor a
	ld b, 7
.pic_row
	ld c, 7
	push af
	push hl
.pic_col
	ld [hli], a
	add 7
	dec c
	jr nz, .pic_col
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop af
	inc a
	dec b
	jr nz, .pic_row
	hlcoord 0, 0, wAttrmap
	lb bc, 7, 7
	ld a, BOXPAL_MON
	call BoxScreen_FillAttrs
	ld a, [wTempSpecies]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld hl, wTempMonDVs
	predef GetUnownLetter
	call GetBaseData
	ld de, vTiles2 tile $00
	predef GetMonFrontpic
	farcall LoadBoxScreenMonPalette
	farcall ApplyPals
	ld a, TRUE
	ldh [hCGBPalUpdate], a
; its name, level, gender, types, item and nature
	hlcoord 8, 0
	ld de, wStringBuffer1
	call PlaceString
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .done
	hlcoord 8, 1
	call PrintLevel
	ld a, TEMPMON
	ld [wMonType], a
	farcall GetGender
	jr c, .no_gender
	ld a, '♂'
	jr nz, .gender
	ld a, '♀'
.gender
	hlcoord 13, 1
	ld [hl], a
.no_gender
	hlcoord 8, 2
	predef PrintMonTypes
	ld a, [wTempMonItem]
	and a
	jr z, .no_item
	ld [wNamedObjectIndex], a
	call GetItemName
	hlcoord 8, 4
	call PlaceString
.no_item
	ld de, wTempMonDVs
	farcall GetNatureName
	hlcoord 8, 5
	ld de, wStringBuffer1
	call PlaceString
.done
; (the attributes: a frame for the palettes, if they changed, for VBlank does
; nothing else then, and one for each third of the screen)
	ld a, 2
	ldh [hBGMapMode], a
	ld c, 4
	call DelayFrames
	ld a, 1
	ldh [hBGMapMode], a
	ret

.box_info
	ld a, [wBoxScreenBox]
	dec a
	call BoxScreen_GetBoxName
	hlcoord 8, 0
	call PlaceString
	hlcoord 8, 2
	ld de, .PokemonString
	call PlaceString
	ld a, [wBoxScreenCount]
	ld [wTextDecimalByte], a
	hlcoord 13, 2
	ld de, wTextDecimalByte
	lb bc, 1, 2
	call PrintNum
	ld de, .OutOf
	call PlaceString
	hlcoord 8, 4
	ld [hl], $5f ; ◀
	inc hl
	ld [hl], $5e ; ▶
	inc hl
	ld de, .BoxesString
	call PlaceString
	hlcoord 8, 6
	ld de, .OptionsString
	call PlaceString
	jr .done

.PokemonString:
	db "<PK><MN>@"
.OutOf:
	db "/{d:MONS_PER_BOX}@"
.BoxesString:
	db ": BOXES@"
.OptionsString:
	db "A: OPTIONS@"

BoxScreen_ClearPanel:
	hlcoord 0, 0
	ld bc, (BOXSCREEN_CANVAS_Y - 1) * SCREEN_WIDTH
	ld a, ' '
	call ByteFill
	hlcoord 0, 0, wAttrmap
	ld bc, (BOXSCREEN_CANVAS_Y - 1) * SCREEN_WIDTH
	xor a ; BOXPAL_TEXT
	jp ByteFill

BoxScreen_ClearPanelText:
	hlcoord 8, 0
	lb bc, BOXSCREEN_CANVAS_Y - 1, SCREEN_WIDTH - 8
	jp ClearBox

BoxScreen_FillAttrs:
; b rows of c attributes a at hl
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

BoxScreen_LoadCursorMonData:
; (the POKéMON at the cursor's: see BoxScreen_LoadShownMonData)
	call BoxScreen_CursorPlace
	ld hl, wBoxScreenShown
	ld [hli], a
	ld a, b
	ld [hli], a
	ld [hl], c
	; fallthrough

BoxScreen_LoadShownMonData:
; The level, item and DVs (wTempMon*) of the POKéMON the panel shows
; (wBoxScreenShown), and its nickname (wStringBuffer1).
	ld hl, wBoxScreenShown
	ld a, [hli]
	ld b, [hl]
	inc hl
	ld c, [hl]
	cp BOXZONE_PARTY
	jr z, .party
	push bc
	ld a, [wCurBox]
	inc a
	cp b
	jr z, .out
	farcall GetBoxPointer ; b: its bank, hl: it
	ld a, b
	jr .got_box

.out
	ld hl, sBox
	ld a, BANK(sBox)
.got_box
	call OpenSRAM
	pop bc
	push bc
	ld de, sBoxMons - sBox
	add hl, de
	ld a, c
	ld bc, BOXMON_STRUCT_LENGTH
	call AddNTimes
	call .Copy
	call CloseSRAM
	pop bc
	jp BoxScreen_GetBoxNickname

.party
	ld a, c
	push bc
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	call .Copy
	pop bc
	ld a, c
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	jp CopyBytes

.Copy:
; from the struct at hl
	push hl
	ld bc, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [wTempMonLevel], a
	pop hl
	push hl
	ld bc, MON_ITEM
	add hl, bc
	ld a, [hl]
	ld [wTempMonItem], a
	pop hl
	ld bc, MON_DVS
	add hl, bc
	ld a, [hli]
	ld [wTempMonDVs], a
	ld a, [hl]
	ld [wTempMonDVs + 1], a
	ret

BoxScreen_GetBoxNickname:
; box b's (1 to NUM_BOXES) POKéMON c's nickname to wStringBuffer1
	ld a, b
	dec a
	ld hl, wCurBox
	cp [hl]
	jr z, .out
	push bc
	farcall GetBoxPointer
	ld de, sBoxMonNicknames - sBox
	add hl, de
	ld a, b
	pop bc
	jr .got

.out
	ld hl, sBoxMonNicknames
	ld a, BANK(sBox)
.got
	call OpenSRAM
	ld a, c
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	ld de, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ld a, '@'
	ld [wStringBuffer1 + MON_NAME_LENGTH - 1], a
	jp CloseSRAM

BoxScreen_SetPalettes:
	ldh a, [rWBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rWBK], a
	ld hl, BoxScreenTextPalette
	ld de, wBGPals1 palette BOXPAL_TEXT
	ld bc, 1 palettes
	call CopyBytes
; the icons' colors: the box's wallpaper, the color's two, black
	ld a, [wBoxScreenBox]
	dec a
	add a
	ld c, a
	ld b, 0
	ld hl, BoxWallpapers
	add hl, bc
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, BoxIconPalettes
	ld de, wBGPals1 palette BOXPAL_RED
	ld a, NUM_BOX_ICON_COLORS
.icons
	push af
	ld a, b
	ld [de], a
	inc de
	ld a, c
	ld [de], a
	inc de
	push bc
	ld bc, 2 * COLOR_SIZE
	call CopyBytes
	pop bc
	xor a
	ld [de], a
	inc de
	ld [de], a
	inc de
	pop af
	dec a
	jr nz, .icons
; the cursor's, and the POKéMON held's
	ld hl, BoxCursorPalette
	ld de, wOBPals1 palette 0
	ld bc, 1 palettes
	call CopyBytes
	ld a, [wBoxScreenHeldColor]
	sub BOXPAL_RED
	jr nc, .held_color
	xor a
.held_color
	add a
	add a
	ld c, a
	ld b, 0
	ld hl, BoxIconPalettes
	add hl, bc
	ld de, wOBPals1 palette 1 + COLOR_SIZE
	ld bc, 2 * COLOR_SIZE
	call CopyBytes
	xor a
	ld [de], a
	inc de
	ld [de], a
	pop af
	ldh [rWBK], a
	farcall ApplyPals
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

; the cursor and the POKéMON held

BoxScreen_UpdateSprites:
	ld hl, wBoxScreenFrame
	inc [hl]
	call BoxScreen_CursorRect
; (its corners close in a pixel, every other 16 frames)
	ld a, [wBoxScreenFrame]
	and %10000
	jr z, .got_bob
	ld a, 1
.got_bob
	ld [wBoxScreenRowBytes], a
	ld hl, wShadowOAMSprite00
; top left
	ld a, e
	add OAM_Y_OFS - 3
	call .AddBob
	ld [hli], a
	ld a, d
	add OAM_X_OFS - 3
	call .AddBob
	ld [hli], a
	ld a, BOXSCREEN_CURSOR_TILE
	ld [hli], a
	xor a
	ld [hli], a
; top right
	ld a, e
	add OAM_Y_OFS - 3
	call .AddBob
	ld [hli], a
	ld a, d
	add b
	add OAM_X_OFS - 5
	call .SubBob
	ld [hli], a
	ld a, BOXSCREEN_CURSOR_TILE
	ld [hli], a
	ld a, OAM_XFLIP
	ld [hli], a
; bottom left
	ld a, e
	add c
	add OAM_Y_OFS - 5
	call .SubBob
	ld [hli], a
	ld a, d
	add OAM_X_OFS - 3
	call .AddBob
	ld [hli], a
	ld a, BOXSCREEN_CURSOR_TILE
	ld [hli], a
	ld a, OAM_YFLIP
	ld [hli], a
; bottom right
	ld a, e
	add c
	add OAM_Y_OFS - 5
	call .SubBob
	ld [hli], a
	ld a, d
	add b
	add OAM_X_OFS - 5
	call .SubBob
	ld [hli], a
	ld a, BOXSCREEN_CURSOR_TILE
	ld [hli], a
	ld a, OAM_XFLIP | OAM_YFLIP
	ld [hli], a
; the POKéMON held, above the cursor's place
	ld a, [wBoxScreenHeld]
	and a
	jr z, .hide_held
	ld a, [wBoxScreenZone]
	cp BOXZONE_HEADER
	jr nz, .held_place
	ld d, TILE_WIDTH ; (by the box's name, after its arrow)
.held_place
	ld a, [wBoxScreenFrame]
	and %10000
	ld b, BOXSCREEN_HELD_TILE
	jr z, .got_frame
	ld b, BOXSCREEN_HELD_TILE + 4
.got_frame
	ld a, e
	add OAM_Y_OFS - 7
	ld e, a
	ld a, d
	add OAM_X_OFS
	ld d, a
	ld c, d
	ld a, e
	call .Held ; top left
	ld a, d
	add TILE_WIDTH
	ld c, a
	ld a, e
	call .Held ; top right
	ld c, d
	ld a, e
	add TILE_WIDTH
	call .Held ; bottom left
	ld a, d
	add TILE_WIDTH
	ld c, a
	ld a, e
	add TILE_WIDTH
	jp .Held ; bottom right

.Held:
; a sprite at a, c: tile b (then the next), OBJ palette 1
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
	inc b
	ld a, 1
	ld [hli], a
	ret

.hide_held
	ld b, 4
.hide
	ld a, OAM_YCOORD_HIDDEN
	ld [hli], a
	inc hl
	inc hl
	inc hl
	dec b
	jr nz, .hide
	ret

.AddBob:
	push hl
	ld hl, wBoxScreenRowBytes
	add [hl]
	pop hl
	ret

.SubBob:
	push hl
	ld hl, wBoxScreenRowBytes
	sub [hl]
	pop hl
	ret

BoxScreen_CursorRect:
; d, e: where the cursor is on the screen (pixels); b, c: how wide, how high
	ld a, [wBoxScreenZone]
	cp BOXZONE_HEADER
	jr z, .header
	cp BOXZONE_PARTY
	jr z, .party
	ld a, [wBoxScreenRow]
	ld b, a
	ld a, BOXSCREEN_BOX_Y + BOXSCREEN_CANVAS_Y * TILE_WIDTH
	call .Pitch
	ld e, a
	ld a, [wBoxScreenCol]
	ld b, a
	ld a, BOXSCREEN_BOX_X
	call .Pitch
	ld d, a
	lb bc, 16, 16
	ret

.party
	ld a, [wBoxScreenRow]
	ld b, a
	ld a, BOXSCREEN_PARTY_Y + BOXSCREEN_CANVAS_Y * TILE_WIDTH
	call .Pitch
	ld e, a
	ld d, BOXSCREEN_PARTY_X
	ld a, [wBoxScreenCol]
	and a
	jr z, .party_x
	ld d, BOXSCREEN_PARTY_X + BOXSCREEN_PARTY_PITCH_X
.party_x
	lb bc, 16, 16
	ret

.header
; (the box's name, between the arrows)
	lb de, TILE_WIDTH, (BOXSCREEN_CANVAS_Y - 1) * TILE_WIDTH
	lb bc, 11 * TILE_WIDTH, TILE_WIDTH
	ret

.Pitch:
; a + 20 * b
	inc b
.loop
	dec b
	ret z
	add BOXSCREEN_ICON_PITCH
	jr .loop

; the controls

BoxScreen_Joypad:
; carry: leave
	ld hl, hJoyPressed
	ld a, [hl]
	and PAD_B
	jr nz, .b
	ld a, [hl]
	and PAD_A
	jr nz, .a
	ld a, [hl]
	and PAD_SELECT
	jr nz, .select
	ldh a, [hJoyLast]
	bit B_PAD_UP, a
	jp nz, BoxScreen_PressUp
	bit B_PAD_DOWN, a
	jp nz, BoxScreen_PressDown
	bit B_PAD_LEFT, a
	jp nz, BoxScreen_PressLeft
	bit B_PAD_RIGHT, a
	jp nz, BoxScreen_PressRight
	and a
	ret

.b
	ld a, [wBoxScreenHeld]
	and a
	jr z, .leave
	call BoxScreen_PutBack
	and a
	ret

.leave
	scf
	ret

.a
	ld a, [wBoxScreenHeld]
	and a
	jp nz, BoxScreen_Drop
	ld a, [wBoxScreenZone]
	cp BOXZONE_HEADER
	jp z, BoxScreen_HeaderMenu
	call BoxScreen_CursorMonSpecies
	and a
	ret z
	jp BoxScreen_MonMenu

.select
; (quickly: pick up or put down)
	ld a, [wBoxScreenHeld]
	and a
	jp nz, BoxScreen_Drop
	ld a, [wBoxScreenZone]
	cp BOXZONE_HEADER
	ret z
	call BoxScreen_CursorMonSpecies
	and a
	ret z
	jp BoxScreen_PickUp

BoxScreen_PressUp:
	ld a, [wBoxScreenZone]
	cp BOXZONE_HEADER
	jr z, .done
	ld a, [wBoxScreenRow]
	and a
	jr z, .header
	dec a
	ld [wBoxScreenRow], a
	jr .done

.header
	ld a, [wBoxScreenZone]
	cp BOXZONE_BOX
	ld a, BOX_COLS - 1
	jr nz, .got_col
	ld a, [wBoxScreenCol]
.got_col
	ld [wBoxScreenBoxCol], a
	ld a, BOXZONE_HEADER
	ld [wBoxScreenZone], a
.done
	and a
	ret

BoxScreen_PressDown:
	ld a, [wBoxScreenZone]
	cp BOXZONE_HEADER
	jr z, .from_header
	cp BOXZONE_PARTY
	ld b, BOX_ROWS - 1
	jr nz, .got_last
	ld b, BOXSCREEN_PARTY_ROWS - 1
.got_last
	ld a, [wBoxScreenRow]
	cp b
	jr nc, .done
	inc a
	ld [wBoxScreenRow], a
	jr .done

.from_header
	ld a, BOXZONE_BOX
	ld [wBoxScreenZone], a
	xor a
	ld [wBoxScreenRow], a
	ld a, [wBoxScreenBoxCol]
	ld [wBoxScreenCol], a
.done
	and a
	ret

BoxScreen_PressLeft:
	ld a, [wBoxScreenZone]
	cp BOXZONE_HEADER
	jr z, .previous_box
	cp BOXZONE_PARTY
	jr z, .party
	ld a, [wBoxScreenCol]
	and a
	jr z, .previous_box_edge
	dec a
	ld [wBoxScreenCol], a
	jr .done

.previous_box_edge
	ld a, BOX_COLS - 1
	ld [wBoxScreenCol], a
.previous_box
	ld a, -1
	jp BoxScreen_ChangeBox

.party
	ld a, [wBoxScreenCol]
	and a
	jr z, .to_box
	dec a
	ld [wBoxScreenCol], a
	jr .done

.to_box
	ld a, BOXZONE_BOX
	ld [wBoxScreenZone], a
	ld a, BOX_COLS - 1
	ld [wBoxScreenCol], a
.done
	and a
	ret

BoxScreen_PressRight:
	ld a, [wBoxScreenZone]
	cp BOXZONE_HEADER
	jr z, .next_box
	cp BOXZONE_PARTY
	jr z, .party
	ld a, [wBoxScreenCol]
	cp BOX_COLS - 1
	jr nc, .to_party
	inc a
	ld [wBoxScreenCol], a
	jr .done

.to_party
	ld a, BOXZONE_PARTY
	ld [wBoxScreenZone], a
	xor a
	ld [wBoxScreenCol], a
	ld a, [wBoxScreenRow]
	cp BOXSCREEN_PARTY_ROWS
	jr c, .done
	ld a, BOXSCREEN_PARTY_ROWS - 1
	ld [wBoxScreenRow], a
	jr .done

.party
	ld a, [wBoxScreenCol]
	and a
	jr nz, .next_box_edge
	inc a
	ld [wBoxScreenCol], a
	jr .done

.next_box_edge
	ld a, BOXZONE_BOX
	ld [wBoxScreenZone], a
	xor a
	ld [wBoxScreenCol], a
.next_box
	ld a, 1
	jp BoxScreen_ChangeBox

.done
	and a
	ret

BoxScreen_ChangeBox:
; show the box a (+1 or -1) away
	ld b, a
	ld a, [wSavedAtLeastOnce]
	and a
	jr z, .not_saved
	ld a, [wBoxScreenBox]
	add b
	jr nz, .not_below
	ld a, NUM_BOXES
.not_below
	cp NUM_BOXES + 1
	jr c, .got_box
	ld a, 1
.got_box
	ld [wBoxScreenBox], a
	call BoxScreen_Redraw
	and a
	ret

.not_saved
	ld de, BoxScreenSaveFirstText
	call BoxScreen_Message
	and a
	ret

BoxScreen_Redraw:
; after the box shown or what's in it changed
	call BoxScreen_DrawIcons
	call BoxScreen_DrawHeader
	call BoxScreen_SetPalettes
	ld a, -1
	ld [wBoxScreenShown], a
	call BoxScreen_ShowCursorMon
	jp WaitBGMap2

; picking up and putting down

BoxScreen_PickUp:
; the POKéMON at the cursor
	call BoxScreen_CursorPlace
	ld [wBoxScreenHeld], a
	ld a, b
	ld [wBoxScreenHeldBox], a
	ld a, c
	ld [wBoxScreenHeldIndex], a
	call BoxScreen_LoadHeldGFX
	call BoxScreen_SetPalettes
	call BoxScreen_DrawIcons
	ld a, -1 ; (the panel again, and the icons' colors with it)
	ld [wBoxScreenShown], a
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	and a
	ret

BoxScreen_PutBack:
	xor a
	ld [wBoxScreenHeld], a
	call BoxScreen_DrawIcons
	ld a, -1
	ld [wBoxScreenShown], a
	and a
	ret

BoxScreen_Drop:
; Put the POKéMON held down at the cursor (on the header: after the shown box's
; last): there, or in the place of the POKéMON there, which takes the held one's.
	call BoxScreen_CursorPlace
	cp BOXZONE_HEADER
	jr nz, .got_place
	ld a, [wBoxScreenCount]
	ld c, a
	ld a, BOXZONE_BOX
.got_place
; (wBoxScreenTarget: its zone, box and index, and TRUE if a POKéMON is there)
	ld hl, wBoxScreenTarget
	ld [hli], a
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	call BoxScreen_TargetCount
	ld hl, wBoxScreenTarget + 2
	cp [hl]
	ld a, FALSE
	jr c, .got_occupied
	jr z, .got_occupied
	ld a, TRUE
.got_occupied
	ld [wBoxScreenTarget + 3], a
; the same place: just put it back
	ld a, [wBoxScreenHeld]
	ld hl, wBoxScreenTarget
	cp [hl]
	jr nz, .move
	ld a, [wBoxScreenHeldBox]
	inc hl
	cp [hl]
	jr nz, .move
	ld a, [wBoxScreenHeldIndex]
	inc hl
	cp [hl]
	jp z, BoxScreen_PutBack
.move
	ld a, [wBoxScreenHeld]
	cp BOXZONE_PARTY
	jr z, .from_party
	ld a, [wBoxScreenTarget]
	cp BOXZONE_PARTY
	jr z, .box_to_party
	call BoxScreen_BoxToBox
	jr .moved

.box_to_party
	call BoxScreen_BoxToParty
	jr .moved

.from_party
	ld a, [wBoxScreenTarget]
	cp BOXZONE_PARTY
	jr z, .party_to_party
	call BoxScreen_PartyToBox
	jr .moved

.party_to_party
	call BoxScreen_PartyToParty
.moved
	jr c, .not_moved ; (it's still held)
	xor a
	ld [wBoxScreenHeld], a
	call BoxScreen_Changed
	ld de, SFX_SWITCH_POKEMON
	call PlaySFX
	call BoxScreen_Redraw
.not_moved
	and a
	ret

BoxScreen_Changed:
	ld a, TRUE
	ld [wBoxScreenChanged], a
	ret

BoxScreen_TargetCount:
; a: how many POKéMON are where the POKéMON held is going
	ld a, [wBoxScreenTarget]
	cp BOXZONE_PARTY
	ld a, [wPartyCount]
	ret z
	ld a, [wBoxScreenCount]
	ret

; (each of these: carry if it can't be done, having said why)

BoxScreen_BoxToBox:
	ld a, [wBoxScreenHeldBox]
	ld hl, wBoxScreenTarget + 1
	cp [hl]
	jr nz, .other_box
; the same box: they change places, or it goes after the last
	dec a
	ld e, a
	call BoxScreen_SetCurBox
	ld a, [wBoxScreenTarget + 3]
	and a
	jr z, .to_end
	ld a, [wBoxScreenHeldIndex]
	ld b, a
	ld a, [wBoxScreenTarget + 2]
	ld c, a
	call BoxScreen_SwapInBox
	and a
	ret

.to_end
	ld a, [wBoxScreenHeldIndex]
	call BoxScreen_TakeFromBox
	ld a, BANK(sBoxCount)
	call OpenSRAM
	ld a, [sBoxCount]
	call CloseSRAM
	call BoxScreen_PutIntoBox
	and a
	ret

.other_box
	ld a, [wBoxScreenTarget + 3]
	and a
	jr nz, .swap
	ld a, [wBoxScreenCount]
	cp MONS_PER_BOX
	jp nc, BoxScreen_BoxIsFull
	ld a, [wBoxScreenHeldBox]
	dec a
	ld e, a
	call BoxScreen_SetCurBox
	ld a, [wBoxScreenHeldIndex]
	call BoxScreen_TakeFromBox
	ld a, [wBoxScreenTarget + 1]
	dec a
	ld e, a
	call BoxScreen_SetCurBox
	ld a, [wBoxScreenCount]
	call BoxScreen_PutIntoBox
	and a
	ret

.swap
	ld a, [wBoxScreenHeldBox]
	dec a
	ld e, a
	call BoxScreen_SetCurBox
	ld a, [wBoxScreenHeldIndex]
	call BoxScreen_TakeFromBox
	ld de, wBoxScreenStash1
	call BoxScreen_Stash
	ld a, [wBoxScreenTarget + 1]
	dec a
	ld e, a
	call BoxScreen_SetCurBox
	ld a, [wBoxScreenTarget + 2]
	call BoxScreen_TakeFromBox
	ld de, wBoxScreenStash2
	call BoxScreen_Stash
	ld hl, wBoxScreenStash1
	call BoxScreen_Unstash
	ld a, [wBoxScreenTarget + 2]
	call BoxScreen_PutIntoBox
	ld a, [wBoxScreenHeldBox]
	dec a
	ld e, a
	call BoxScreen_SetCurBox
	ld hl, wBoxScreenStash2
	call BoxScreen_Unstash
	ld a, [wBoxScreenHeldIndex]
	call BoxScreen_PutIntoBox
	and a
	ret

BoxScreen_BoxToParty:
	ld a, [wBoxScreenTarget + 3]
	and a
	jr nz, .swap
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jp nc, BoxScreen_PartyIsFull
	ld a, [wBoxScreenHeldBox]
	dec a
	ld e, a
	call BoxScreen_SetCurBox
	ld a, [wBoxScreenHeldIndex]
	call BoxScreen_TakeFromBox
	ld a, [wPartyCount]
	call BoxScreen_PutIntoParty
	and a
	ret

.swap
; the party's POKéMON goes to the box, in the held one's place
	ld a, [wBoxScreenTarget + 2]
	call BoxScreen_CheckPartyMail
	ret c
	call BoxScreen_HeldSpecies
	cp EGG
	jr nz, .swap_ok
	ld a, [wBoxScreenTarget + 2]
	call BoxScreen_CheckPartyLeaves
	ret c
.swap_ok
	ld a, [wBoxScreenHeldBox]
	dec a
	ld e, a
	call BoxScreen_SetCurBox
	ld a, [wBoxScreenHeldIndex]
	call BoxScreen_TakeFromBox
	ld de, wBoxScreenStash1
	call BoxScreen_Stash
	ld a, [wBoxScreenTarget + 2]
	call BoxScreen_TakeFromParty
	ld a, [wBoxScreenHeldIndex]
	call BoxScreen_PutIntoBox
	ld hl, wBoxScreenStash1
	call BoxScreen_Unstash
	ld a, [wBoxScreenTarget + 2]
	call BoxScreen_PutIntoParty
	and a
	ret

BoxScreen_PartyToBox:
	ld a, [wBoxScreenHeldIndex]
	call BoxScreen_CheckPartyMail
	ret c
	ld a, [wBoxScreenTarget + 3]
	and a
	jr nz, .swap
	ld a, [wBoxScreenHeldIndex]
	call BoxScreen_CheckPartyLeaves
	ret c
	ld a, [wBoxScreenCount]
	cp MONS_PER_BOX
	jp nc, BoxScreen_BoxIsFull
	ld a, [wBoxScreenTarget + 1]
	dec a
	ld e, a
	call BoxScreen_SetCurBox
	ld a, [wBoxScreenHeldIndex]
	call BoxScreen_TakeFromParty
	ld a, [wBoxScreenCount]
	call BoxScreen_PutIntoBox
	and a
	ret

.swap
; the box's POKéMON goes to the party, in the held one's place
	ld a, [wBoxScreenTarget + 2]
	call BoxScreen_BoxSpecies
	cp EGG
	jr nz, .swap_ok
	ld a, [wBoxScreenHeldIndex]
	call BoxScreen_CheckPartyLeaves
	ret c
.swap_ok
	ld a, [wBoxScreenTarget + 1]
	dec a
	ld e, a
	call BoxScreen_SetCurBox
	ld a, [wBoxScreenTarget + 2]
	call BoxScreen_TakeFromBox
	ld de, wBoxScreenStash1
	call BoxScreen_Stash
	ld a, [wBoxScreenHeldIndex]
	call BoxScreen_TakeFromParty
	ld a, [wBoxScreenTarget + 2]
	call BoxScreen_PutIntoBox
	ld hl, wBoxScreenStash1
	call BoxScreen_Unstash
	ld a, [wBoxScreenHeldIndex]
	call BoxScreen_PutIntoParty
	and a
	ret

BoxScreen_PartyToParty:
	ld a, [wBoxScreenTarget + 3]
	and a
	jr z, .to_end
	ld a, [wBoxScreenHeldIndex]
	ld b, a
	ld a, [wBoxScreenTarget + 2]
	ld c, a
	call BoxScreen_SwapPartyMons
	and a
	ret

.to_end
	ld a, [wBoxScreenHeldIndex]
.bubble
	ld b, a
	inc a
	ld c, a
	ld a, [wPartyCount]
	cp c
	ret z ; (nc)
	call BoxScreen_SwapPartyMons
	ld a, c
	jr .bubble

; the rules

BoxScreen_CheckPartyLeaves:
; carry if the party's POKéMON a can't leave it: there'd be no POKéMON left that
; can battle (an EGG can't)
	ld [wCurPartyMon], a
	ld a, [wPartyCount]
	cp 2
	jr c, .last
	farcall CheckCurPartyMonFainted
	ret nc
	ld de, BoxScreenNoMoreUsableText
	jr .no

.last
	ld de, BoxScreenLastMonText
.no
	call BoxScreen_Message
	scf
	ret

BoxScreen_CheckPartyMail:
; carry if the party's POKéMON a holds MAIL (it can't go in a box)
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, [hl]
	farcall ItemIsMail
	ret nc
	ld de, BoxScreenRemoveMailText
	call BoxScreen_Message
	scf
	ret

BoxScreen_BoxIsFull:
	ld de, BoxScreenBoxFullText
	call BoxScreen_Message
	scf
	ret

BoxScreen_PartyIsFull:
	ld de, BoxScreenPartyFullText
	call BoxScreen_Message
	scf
	ret

; moving them (as BILL's PC's MOVE PKMN did)

BoxScreen_SetCurBox:
; Make box e (0 to NUM_BOXES - 1) the box out (the one that was is kept where it
; belongs: see SaveBox).
	ld a, [wCurBox]
	cp e
	ret z
	farcall MoveMonWOMail_SaveGame
	ret

BoxScreen_TakeFromBox:
; the box out's POKéMON a to wBufferMon (and wCurPartySpecies, its nickname and
; OT), out of the box
	ld [wCurPartyMon], a
	ld c, a
	ld b, 0
	ld a, BANK(sBox)
	call OpenSRAM
	ld hl, sBoxSpecies
	add hl, bc
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld a, c
	ld hl, sBoxMonNicknames
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	ld de, wBufferMonNickname
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ld a, [wCurPartyMon]
	ld hl, sBoxMonOTs
	ld bc, NAME_LENGTH
	call AddNTimes
	ld de, wBufferMonOT
	ld bc, NAME_LENGTH
	call CopyBytes
	ld a, [wCurPartyMon]
	ld hl, sBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
	call AddNTimes
	ld de, wBufferMon
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	call CloseSRAM
	farcall CalcBufferMonStats
	ld a, REMOVE_BOX
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromPartyOrBox
	ret

BoxScreen_TakeFromParty:
; the party's POKéMON a to wBufferMon (and so on), out of the party (its MAIL's
; place too)
	ld [wCurPartyMon], a
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld a, c
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	ld de, wBufferMonNickname
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ld a, [wCurPartyMon]
	ld hl, wPartyMonOTs
	ld bc, NAME_LENGTH
	call AddNTimes
	ld de, wBufferMonOT
	ld bc, NAME_LENGTH
	call CopyBytes
	ld a, [wCurPartyMon]
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld de, wBufferMon
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	farcall RemoveMonFromPartyOrBox
	ret

BoxScreen_PutIntoBox:
; wBufferMon (and so on) into the box out, as its POKéMON a
	ld [wCurPartyMon], a
	farcall InsertPokemonIntoBox
	ret

BoxScreen_PutIntoParty:
; wBufferMon (and so on) into the party, as its POKéMON a (after its last, then
; moved there, so each POKéMON's MAIL stays with it)
	push af
	ld a, [wPartyCount]
	ld [wCurPartyMon], a
	farcall InsertPokemonIntoParty
	pop af
	ld c, a
	ld a, [wPartyCount]
	dec a
.bubble
	cp c
	ret z
	ld b, a
	dec b
	push bc
	push af
	ld c, a
	call BoxScreen_SwapPartyMons
	pop af
	pop bc
	dec a
	jr .bubble

BoxScreen_SwapPartyMons:
; the party's POKéMON b and c change places (with their MAIL); keeps bc
	push bc
	ld a, b
	ld [wSwitchMonFrom], a
	ld a, c
	ld [wSwitchMonTo], a
	farcall _SwitchPartyMons.SwapMonAndMail
	pop bc
	ret

BoxScreen_SwapInBox:
; the box out's POKéMON b and c change places
	ld a, BANK(sBox)
	call OpenSRAM
	ld hl, sBoxSpecies
	ld a, 1
	call .Swap
	ld hl, sBoxMons
	ld a, BOXMON_STRUCT_LENGTH
	call .Swap
	ld hl, sBoxMonOTs
	ld a, NAME_LENGTH
	call .Swap
	ld hl, sBoxMonNicknames
	ld a, MON_NAME_LENGTH
	call .Swap
	jp CloseSRAM

.Swap:
; entries b and c (a bytes each) of the table at hl
	push bc
	ld [wBoxScreenRowBytes], a
	push hl
	ld a, b
	ld b, 0
	ld c, a
	ld a, [wBoxScreenRowBytes]
	call .Entry
	ld d, h
	ld e, l
	pop hl
	pop bc
	push bc
	ld a, c
	ld b, 0
	ld c, a
	ld a, [wBoxScreenRowBytes]
	call .Entry
	ld a, [wBoxScreenRowBytes]
	ld c, a
.swap_loop
	ld a, [de]
	ld b, [hl]
	ld [hli], a
	ld a, b
	ld [de], a
	inc de
	dec c
	jr nz, .swap_loop
	pop bc
	ret

.Entry:
; hl + bc x a
	and a
	ret z
	push de
	ld d, h
	ld e, l
	ld h, 0
	ld l, h
.times
	add hl, bc
	dec a
	jr nz, .times
	add hl, de
	pop de
	ret

BoxScreen_Stash:
; wBufferMon (with wCurPartySpecies, its nickname and OT) to the stash at de, by
; their indexes (its IDs could be taken back while it's there: see engine/16)
	push de
	ld a, [wCurPartySpecies]
	call GetPokemonIndexFromID
	pop de
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de
	push de
	ld hl, wBufferMon
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	pop hl ; (its struct in the stash)
	push de
	push hl
	ld d, h
	ld e, l
	farcall BillsPC_ConvertMonAtDEToBoxMon
	pop hl
	ld a, [hl] ; (its species)
	call GetPokemonIndexFromID
	pop de
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	inc de
	ld hl, wBufferMonNickname
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ld hl, wBufferMonOT
	ld bc, NAME_LENGTH
	jp CopyBytes

BoxScreen_Unstash:
; the stash at hl back to wBufferMon (and so on)
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld h, d
	ld l, e
	call GetPokemonIDFromIndex
	ld [wCurPartySpecies], a
	pop hl
	ld de, wBufferMon
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld h, d
	ld l, e
	call GetPokemonIDFromIndex
	ld [wBufferMonSpecies], a
	ld de, wBufferMon
	farcall BillsPC_ConvertMonAtDEToPartyMon
	pop hl
	ld de, wBufferMonNickname
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ld de, wBufferMonOT
	ld bc, NAME_LENGTH
	call CopyBytes
	farcall CalcBufferMonStats
	ret

; the menus

BoxScreen_MonMenu:
	ld hl, .Items
	call BoxScreen_PanelMenu
	jr c, .done
	and a
	jp z, BoxScreen_PickUp
	dec a
	jp z, BoxScreen_Summary
	dec a
	jp z, BoxScreen_TakeItem
	dec a
	jp z, BoxScreen_Release
.done
	and a
	ret

.Items:
	db "MOVE@"
	db "SUMMARY@"
	db "ITEM@"
	db "RELEASE@"
	db "CANCEL@"
	db -1

BoxScreen_HeaderMenu:
	ld hl, .Items
	call BoxScreen_PanelMenu
	jr c, .done
	and a
	jr nz, .done
; RENAME
	ld b, NAME_BOX
	ld de, wBoxNameBuffer
	farcall NamingScreen
	ld a, [wBoxScreenBox]
	dec a
	call BoxScreen_GetBoxName
	ld hl, wBoxNameBuffer
	ld c, BOX_NAME_LENGTH - 1
	call InitString
	ld a, [wBoxScreenBox]
	dec a
	call BoxScreen_GetBoxName
	ld h, d
	ld l, e
	ld de, wBoxNameBuffer
	call CopyName2
	call BoxScreen_Changed
	call BoxScreen_InitScreen
.done
	and a
	ret

.Items:
	db "RENAME@"
	db "CANCEL@"
	db -1

BoxScreen_PanelMenu:
; The items at hl ("…@", then -1) in the panel; the one chosen in a, carry if B.
	push hl
	xor a
	ldh [hBGMapMode], a
	call BoxScreen_ClearPanelText
	pop de
	ld b, 0
	hlcoord 10, 0
.place
	ld a, [de]
	cp -1
	jr z, .placed
	push bc
	push hl
	call PlaceString
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	inc de
	inc b
	jr .place

.placed
	ld a, b
	ld [wBoxScreenRowBytes + 2], a ; (how many)
	xor a
	ld [wBoxScreenRowBytes + 3], a ; (which)
	ld a, 1
	ldh [hBGMapMode], a
.loop
	hlcoord 9, 0
	ld bc, SCREEN_WIDTH
	ld a, [wBoxScreenRowBytes + 2]
	ld d, a
	ld e, 0
.cursor
	ld a, [wBoxScreenRowBytes + 3]
	cp e
	ld a, ' '
	jr nz, .got_cursor
	ld a, '▶'
.got_cursor
	ld [hl], a
	add hl, bc
	inc e
	dec d
	jr nz, .cursor
	call BoxScreen_UpdateSprites
	call DelayFrame
	call JoyTextDelay
	ldh a, [hJoyPressed]
	bit B_PAD_A, a
	jr nz, .a
	bit B_PAD_B, a
	jr nz, .b
	ldh a, [hJoyLast]
	bit B_PAD_UP, a
	jr nz, .up
	bit B_PAD_DOWN, a
	jr nz, .down
	jr .loop

.up
	ld hl, wBoxScreenRowBytes + 3
	ld a, [hl]
	and a
	jr nz, .up_ok
	ld a, [wBoxScreenRowBytes + 2]
.up_ok
	dec a
	ld [hl], a
	jr .loop

.down
	ld hl, wBoxScreenRowBytes + 3
	ld a, [hl]
	inc a
	ld [hl], a
	ld hl, wBoxScreenRowBytes + 2
	cp [hl]
	jr c, .loop
	xor a
	ld [wBoxScreenRowBytes + 3], a
	jr .loop

.a
	ld a, -1
	ld [wBoxScreenShown], a
	ld a, [wBoxScreenRowBytes + 3]
	and a
	ret

.b
	ld a, -1
	ld [wBoxScreenShown], a
	scf
	ret

BoxScreen_Message:
; Message de in the panel, till A or B (or a while).
	push de
	xor a
	ldh [hBGMapMode], a
	call BoxScreen_ClearPanelText
	pop de
	hlcoord 8, 0
	call PlaceString
	ld a, 1
	ldh [hBGMapMode], a
	ld de, SFX_WRONG
	call PlaySFX
BoxScreen_WaitMessage:
	ld c, 90
.loop
	push bc
	call BoxScreen_UpdateSprites
	call DelayFrame
	call JoyTextDelay
	pop bc
	ldh a, [hJoyPressed]
	and PAD_A | PAD_B
	jr nz, .done
	dec c
	jr nz, .loop
.done
	ld a, -1
	ld [wBoxScreenShown], a
	ret

; what the menu does

BoxScreen_Summary:
	call BoxScreen_CursorPlace
	push bc
	cp BOXZONE_PARTY
	ld a, 0 ; (the party)
	jr z, .got_list
	ld a, b
	dec a
	ld hl, wCurBox
	cp [hl]
	ld a, NUM_BOXES + 1 ; (the box out)
	jr z, .got_list
	ld a, b
.got_list
	ld [wBillsPC_LoadedBox], a
	farcall CopyBoxmonSpecies
	pop bc
	ld a, c
	ld [wBillsPC_ScrollPosition], a
	xor a
	ld [wBillsPC_CursorPosition], a
	ld a, 5
	ld [wBillsPC_NumMonsOnScreen], a
	call ClearSprites
	farcall BillsPC_StatsScreen
; the cursor where the stats screen ended
	ld a, [wBillsPC_ScrollPosition]
	ld hl, wBillsPC_CursorPosition
	add [hl]
	ld c, a
	ld a, [wBoxScreenZone]
	cp BOXZONE_PARTY
	ld b, BOXSCREEN_PARTY_COLS
	jr z, .got_cols
	ld b, BOX_COLS
.got_cols
	ld a, c
	ld c, 0
.row
	cp b
	jr c, .got_row
	sub b
	inc c
	jr .row
.got_row
	ld [wBoxScreenCol], a
	ld a, c
	ld [wBoxScreenRow], a
	call BoxScreen_InitScreen
	and a
	ret

BoxScreen_Release:
	call BoxScreen_CursorMonSpecies
	cp EGG
	jr nz, .not_egg
	ld de, BoxScreenNoReleasingEggsText
	call BoxScreen_Message
	and a
	ret

.not_egg
	ld [wTempSpecies], a
	call BoxScreen_CursorPlace
	cp BOXZONE_PARTY
	jr nz, .ask
	ld a, c
	push bc
	call BoxScreen_CheckPartyMail
	pop bc
	jr c, .no
	ld a, c
	push bc
	call BoxScreen_CheckPartyLeaves
	pop bc
	jr c, .no
.ask
	ld hl, .YesNo
	call BoxScreen_PanelMenu
	jr c, .no
	and a ; NO
	jr z, .no
	call BoxScreen_LoadCursorMonData ; (its nickname)
	ld a, [wTempSpecies]
	call PlayMonCry
	xor a
	ldh [hBGMapMode], a
	call BoxScreen_ClearPanelText
	ld de, BoxScreenByeText
	hlcoord 8, 0
	call PlaceString
	hlcoord 8, 2
	ld de, wStringBuffer1
	call PlaceString
	ld a, 1
	ldh [hBGMapMode], a
	call BoxScreen_WaitMessage
	call BoxScreen_CursorPlace
	cp BOXZONE_PARTY
	jr z, .party
	push bc
	ld a, b
	dec a
	ld e, a
	call BoxScreen_SetCurBox
	pop bc
	ld a, REMOVE_BOX
	jr .remove

.party
	xor a ; REMOVE_PARTY
.remove
	ld [wPokemonWithdrawDepositParameter], a
	ld a, c
	ld [wCurPartyMon], a
	farcall RemoveMonFromPartyOrBox
	call BoxScreen_Changed
	call BoxScreen_Redraw
.no
	and a
	ret

.YesNo:
	db "KEEP IT@"
	db "RELEASE@"
	db -1

BoxScreen_TakeItem:
	call BoxScreen_CursorPlace
	cp BOXZONE_PARTY
	jr z, .party
	push bc
	ld a, b
	dec a
	ld e, a
	call BoxScreen_SetCurBox
	pop bc
	ld a, c
	ld hl, sBoxMon1Item
	ld bc, BOXMON_STRUCT_LENGTH
	call AddNTimes
	ld a, BANK(sBox)
	call OpenSRAM
	ld a, [hl]
	call CloseSRAM
	jr .got_item

.party
	ld a, c
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hl]
.got_item
	push hl
	and a
	jr z, .nothing
	ld [wCurItem], a
	ld d, a
	push de
	farcall ItemIsMail
	pop de
	jr c, .mail
	ld a, 1
	ld [wItemQuantityChange], a
	ld hl, wNumItems
	call ReceiveItem
	jr nc, .bag_full
	pop hl
	ld a, BANK(sBox)
	call OpenSRAM ; (for a box's; harmless for the party's)
	xor a
	ld [hl], a
	call CloseSRAM
	call BoxScreen_Changed
	ld a, [wCurItem]
	ld [wNamedObjectIndex], a
	call GetItemName
	xor a
	ldh [hBGMapMode], a
	call BoxScreen_ClearPanelText
	ld de, BoxScreenTookText
	hlcoord 8, 0
	call PlaceString
	hlcoord 8, 2
	ld de, wStringBuffer1
	call PlaceString
	ld a, 1
	ldh [hBGMapMode], a
	ld de, SFX_ITEM
	call PlaySFX
	call BoxScreen_WaitMessage
	and a
	ret

.nothing
	pop hl
	ld de, BoxScreenNotHoldingText
	jr .say

.mail
	pop hl
	ld de, BoxScreenMailItemText
	jr .say

.bag_full
	pop hl
	ld de, BoxScreenPackFullText
.say
	call BoxScreen_Message
	and a
	ret

BoxScreenSaveFirstText:
	db   "SAVE first"
	next "to use the"
	next "other BOXES.@"

BoxScreenLastMonText:
	db   "It's your"
	next "last <PK><MN>!@"

BoxScreenNoMoreUsableText:
	db   "No more"
	next "usable <PK><MN>!@"

BoxScreenRemoveMailText:
	db   "Remove its"
	next "MAIL first!@"

BoxScreenBoxFullText:
	db   "The BOX is"
	next "full!@"

BoxScreenPartyFullText:
	db   "The party's"
	next "full!@"

BoxScreenNoReleasingEggsText:
	db   "No releasing"
	next "EGGS!@"

BoxScreenByeText:
	db "Bye-bye,@"

BoxScreenTookText:
	db "Took the@"

BoxScreenNotHoldingText:
	db   "It isn't"
	next "holding"
	next "anything.@"

BoxScreenMailItemText:
	db   "Take MAIL"
	next "from the"
	next "party menu.@"

BoxScreenPackFullText:
	db   "No room in"
	next "the PACK!@"

; colors

BoxScreenTextPalette:
	RGB 31, 31, 31
	RGB 21, 21, 21
	RGB 10, 10, 10
	RGB 00, 00, 00

BoxIconPalettes:
; each icon color's light and dark (BOXPAL_RED onward)
	table_width 2 * COLOR_SIZE
	RGB 31, 20, 16, 26, 05, 03 ; red
	RGB 17, 23, 31, 04, 09, 24 ; blue
	RGB 17, 28, 13, 03, 16, 05 ; green
	RGB 31, 26, 09, 22, 12, 03 ; yellow
	RGB 29, 19, 28, 18, 07, 20 ; purple
	RGB 25, 25, 26, 12, 12, 14 ; gray
	assert_table_length NUM_BOX_ICON_COLORS

BoxWallpapers:
; each box's background
	table_width COLOR_SIZE
	RGB 27, 30, 31
	RGB 27, 31, 27
	RGB 31, 29, 25
	RGB 30, 28, 31
	RGB 31, 31, 25
	RGB 25, 31, 30
	RGB 31, 27, 28
	RGB 29, 30, 26
	RGB 27, 28, 31
	RGB 31, 30, 27
	RGB 28, 31, 31
	RGB 30, 27, 29
	RGB 29, 31, 25
	RGB 29, 29, 29
	assert_table_length NUM_BOXES

BoxCursorPalette:
	RGB 31, 31, 31
	RGB 31, 23, 00
	RGB 31, 31, 31
	RGB 07, 04, 00

BoxCursorGFX:
INCBIN "gfx/pc/box_cursor.2bpp"

INCLUDE "data/pokemon/icon_colors.asm"
