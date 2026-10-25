; Loading a map's graphics with the LCD on (for a phone trip: see
; engine/phone/phone_trip.asm). The screen turns white while the LCD is off,
; and a phone trip goes through black, so this copies to VRAM by HBlank DMA
; (16 bytes each line the LCD draws) instead, while every palette is black.

LoadMapGraphicsWithLCDOn:
; (map setup) LoadMapGraphics, then LoadMapTimeOfDay
	call LoadMapTileset
	farcall RefreshSprites.Refresh
	ld hl, wSpriteFlags
	set SPRITES_LCD_ON_COPY_F, [hl]
	call LoadUsedSpritesGFX
	ld hl, wSpriteFlags
	res SPRITES_LCD_ON_COPY_F, [hl]
	ld de, LoadOverworldFont.OverworldFontGFX
	ld hl, vTiles1
	lb bc, BANK(LoadOverworldFont.OverworldFontGFX), $80
	call Copy2bppWithLCDOn
	ld de, LoadOverworldFont.OverworldFontSpaceGFX
	ld hl, vTiles2 tile ' '
	lb bc, BANK(LoadOverworldFont.OverworldFontSpaceGFX), 1
	call Copy2bppWithLCDOn
	call LoadFontsExtra

; as LoadTilesetGFX
	ld hl, wTilesetAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wTilesetBank]
	ld e, a
	ldh a, [rWBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rWBK], a
	ld a, e
	ld de, wDecompressScratch
	call FarDecompress
	ld de, wDecompressScratch
	ld hl, vTiles2
	ld c, $60
	call HBlankDMA
	ldh a, [rVBK]
	push af
	ld a, BANK(vTiles5)
	ldh [rVBK], a
	ld de, wDecompressScratch + $60 tiles
	ld hl, vTiles5
	ld c, $60
	call HBlankDMA
	pop af
	ldh [rVBK], a
	pop af
	ldh [rWBK], a
	ld a, [wMapTileset]
	cp TILESET_JOHTO
	jr z, .roof
	cp TILESET_JOHTO_MODERN
	jr z, .roof
	cp TILESET_BATTLE_TOWER_OUTSIDE
	jr nz, .no_roof
.roof
	call .Roof
.no_roof
	xor a
	ldh [hTileAnimFrame], a
	ldh [hMapAnims], a

; as LoadMapTimeOfDay
	ld hl, wStateFlags
	res TEXT_STATE_F, [hl]
	ld a, TRUE
	ld [wSpriteUpdatesEnabled], a
	farcall ReplaceTimeOfDayPals
	farcall UpdateTimeOfDayPal
	call LoadOverworldTilemapAndAttrmapPals
	ld a, HIGH(vTilemap0)
	ld [wBGMapAnchor + 1], a
	xor a ; LOW(vTilemap0)
	ld [wBGMapAnchor], a
	ldh [hSCY], a
	ldh [hSCX], a
	farcall ApplyBGMapAnchorToObjects
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
	ldh a, [rWBK]
	push af
	ld a, BANK(wScratchTilemap)
	ldh [rWBK], a
	ldh a, [rVBK]
	push af
	ld a, 1
	ldh [rVBK], a
	xor a
	call .ClearBGMap
	xor a
	ldh [rVBK], a
	ld a, '■'
	call .ClearBGMap
	pop af
	ldh [rVBK], a
	pop af
	ldh [rWBK], a
	pop af
	ldh [hBGMapMode], a
	ld a, LOW(vTilemap0)
	ldh [hBGMapAddress], a
	ld a, HIGH(vTilemap0)
	ldh [hBGMapAddress + 1], a
	farcall HDMATransferAttrmapAndTilemapToWRAMBank3
	ret

.ClearBGMap:
; fill vTilemap0 (in this VRAM bank) with a
	ld hl, wScratchTilemap
	ld bc, vTilemap1 - vTilemap0
	call ByteFill
	ld de, wScratchTilemap
	ld hl, vTilemap0
	ld c, (vTilemap1 - vTilemap0) / TILE_SIZE
	jr HBlankDMA

.Roof:
; as LoadMapGroupRoof
	ld a, [wMapGroup]
	ld e, a
	ld d, 0
	ld hl, MapGroupRoofs
	add hl, de
	ld a, BANK(MapGroupRoofs)
	call GetFarByte
	cp -1
	ret z
	ld hl, Roofs
	ld bc, ROOF_LENGTH tiles
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, vTiles2 tile $0a
	lb bc, BANK(Roofs), ROOF_LENGTH
	; fallthrough

Copy2bppWithLCDOn:
; As Get2bpp (c tiles from b:de to hl), through WRAM and HBlank DMA. (Much
; quicker than waiting for VBlank, as Get2bpp does with the LCD on.)
	ldh a, [rWBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rWBK], a
	push hl
	push bc
	ld a, b
	ld h, d
	ld l, e
	ld de, wDecompressScratch
	push af
	ld a, c
	swap a
	ld b, a
	and $f0
	ld c, a
	ld a, b
	and $0f
	ld b, a ; bc = c tiles
	pop af
	call FarCopyBytes
	pop bc
	pop hl
	ld de, wDecompressScratch
	call HBlankDMA
	pop af
	ldh [rWBK], a
	ret

HBlankDMA:
; Copy c tiles (16 bytes each) from de (in WRAM or ROM) to hl (in VRAM), 16 bytes
; each HBlank. de and hl are multiples of 16.
.loop
	ld a, c
	cp $80 + 1
	jr c, .last
	push bc
	ld c, $80
	call .Transfer
	pop bc
	ld a, c
	sub $80
	ld c, a
	ld a, d
	add HIGH($80 tiles)
	ld d, a
	ld a, h
	add HIGH($80 tiles)
	ld h, a
	jr .loop

.last
	and a
	ret z
.Transfer:
	ld a, d
	ldh [rVDMA_SRC_HIGH], a
	ld a, e
	ldh [rVDMA_SRC_LOW], a
	ld a, h
	ldh [rVDMA_DEST_HIGH], a
	ld a, l
	ldh [rVDMA_DEST_LOW], a
	ld a, c
	dec a
	or $80 ; HBlank DMA
	ldh [rVDMA_LEN], a
.wait
	ldh a, [rVDMA_LEN]
	inc a ; (reads $ff once done)
	jr nz, .wait
	ret
