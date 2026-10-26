_BillsPC:
; the box screen (see engine/pokemon/box_screen.asm)
	call .CheckCanUsePC
	ret c
	call LoadStandardMenuHeader
	farcall BoxScreen
	push af
; (the map's blocks, then its tiles and palettes: the screen took their places)
	call ReturnToMapFromSubmenu
	call CloseSubmenu
	pop af
	jr nc, .done
; It changed the boxes or the party: the game's saved, for the boxes are kept
; in SRAM, and a box changed for another is put back there as it is (see
; SaveBox), so the save and the boxes stay in step. (Not before a first save:
; there's only the box out, which isn't kept till then.)
	ld a, [wSavedAtLeastOnce]
	and a
	jr z, .done
	farcall BoxScreenSaveGame
.done
	and a
	ret

.CheckCanUsePC:
	ld a, [wPartyCount]
	and a
	ret nz
	ld hl, .PCGottaHavePokemonText
	call MenuTextboxBackup
	scf
	ret

.PCGottaHavePokemonText:
	text_far _PCGottaHavePokemonText
	text_end

BillsPC_Deposit_CheckPartySize: ; unreferenced
	ld a, [wPartyCount]
	and a
	jr z, .no_mon
	cp 2
	jr c, .only_one_mon
	and a
	ret

.no_mon
	ld hl, .PCNoSingleMonText
	call MenuTextboxBackup
	scf
	ret

.only_one_mon
	ld hl, .PCCantDepositLastMonText
	call MenuTextboxBackup
	scf
	ret

.PCNoSingleMonText:
	text_far _PCNoSingleMonText
	text_end

.PCCantDepositLastMonText:
	text_far _PCCantDepositLastMonText
	text_end

CheckCurPartyMonFainted:
	ld hl, wPartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH
	ld b, $0
.loop
	ld a, [wCurPartyMon]
	cp b
	jr z, .skip
	ld a, [hli]
	or [hl]
	jr nz, .notfainted
	dec hl

.skip
	inc b
	ld a, [wPartyCount]
	cp b
	jr z, .done
	add hl, de
	jr .loop

.done
	scf
	ret

.notfainted
	and a
	ret

BillsPC_Withdraw_CheckPartySize: ; unreferenced
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr nc, .party_full
	and a
	ret

.party_full
	ld hl, PCCantTakeText
	call MenuTextboxBackup
	scf
	ret

PCCantTakeText:
	text_far _PCCantTakeText
	text_end

ClearPCItemScreen:
	call DisableSpriteUpdates
	xor a
	ldh [hBGMapMode], a
	call ClearBGPalettes
	call ClearSprites
	hlcoord 0, 0
	ld bc, SCREEN_AREA
	ld a, ' '
	call ByteFill
	hlcoord 0, 0
	lb bc, 10, 18
	call Textbox
	hlcoord 0, 12
	lb bc, 4, 18
	call Textbox
	call WaitBGMap2
	call SetDefaultBGPAndOBP
	ret

CopyBoxmonToTempMon:
	ld a, [wCurPartyMon]
	ld hl, sBoxMon1Species
	ld bc, BOXMON_STRUCT_LENGTH
	call AddNTimes
	ld de, wTempMonSpecies
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, BANK(sBoxMon1Species)
	call OpenSRAM
	call CopyBytes
	call CloseSRAM
	ret

LoadBoxMonListing: ; unreferenced
	ld a, [wCurBox]
	cp b
	jr z, .same_box
	ld a, b
	ld hl, .BoxAddresses
	ld bc, 3
	call AddNTimes
	ld a, [hli]
	push af
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	jr .okay

.same_box
	ld a, BANK(sBoxCount)
	ld hl, sBoxCount

.okay
	call OpenSRAM
	ld a, [hl]
	ld bc, sBoxMons - sBox
	add hl, bc
	ld b, a
	ld c, $0
	ld de, wBoxPartialData
	ld a, b
	and a
	jr z, .empty_box
.loop
	push hl
	push bc
	ld a, c
	ld bc, sBoxMon1Species - sBoxMons
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hl]
	ld [de], a
	inc de
	ld [wCurSpecies], a
	call GetBaseData
	pop bc
	pop hl

	push hl
	push bc
	ld a, c
	ld bc, sBoxMonNicknames - sBoxMons
	add hl, bc
	call SkipNames
	call CopyBytes
	pop bc
	pop hl

	push hl
	push bc
	ld a, c
	ld bc, MON_LEVEL
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hl]
	ld [de], a
	inc de
	pop bc
	pop hl

	push hl
	push bc
	ld a, c
	ld bc, MON_DVS
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hli]
	and $f0
	ld b, a
	ld a, [hl]
	and $f0
	swap a
	or b
	ld b, a
	ld a, [wBaseGender]
	cp b
	ld a, $1
	jr c, .okay2
	xor a
.okay2
	ld [de], a
	inc de
	pop bc
	pop hl

	inc c
	dec b
	jr nz, .loop
.empty_box
	call CloseSRAM
	ret

.BoxAddresses:
	table_width 3
for n, 1, NUM_BOXES + 1
	dba sBox{d:n}
endr
	assert_table_length NUM_BOXES
