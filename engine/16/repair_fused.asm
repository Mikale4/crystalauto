; Saves from before MonTableGarbageCollection saw all of MonIDPlaces (it stopped at
; the first place in WRAM0, so the box out, the saves and more weren't kept) can
; have POKéMON whose species ID was taken back and given to another species while
; they were in a box: they turned into that species. One that was never given a
; nickname still has its own species' name, so it gets that species back. This is
; done once, when such a save is continued (see InitMonTable and Continue).
; (In the same bank as PokemonNames, to read them.)

RepairFusedBoxes:
; Every box's POKéMON, in its index array (so the box is loaded as repaired).
	ld hl, BoxIndexArrays
	ld c, NUM_BOXES
.box
	push bc
	ld a, BANK(BoxIndexArrays)
	call GetFarByte
	inc hl
	call OpenSRAM
	call .FarWord
	ld d, b
	ld e, c ; the box
	call .FarWord ; bc: its index array
	push hl
	ld a, [de]
	cp MONS_PER_BOX + 1
	jr nc, .box_done
	and a
	jr z, .box_done
	push af ; (how many)
	xor a
.mon
	push af
	push de
	push bc
	call .Mon
	pop bc
	pop de
	pop af
	inc a
	pop hl
	push hl
	cp h
	jr c, .mon
	pop af
.box_done
	pop hl
	pop bc
	dec c
	jr nz, .box
	jp CloseSRAM

.FarWord:
; bc: the word at BANK(BoxIndexArrays):hl, and hl past it
	ld a, BANK(BoxIndexArrays)
	call GetFarByte
	ld c, a
	inc hl
	ld a, BANK(BoxIndexArrays)
	call GetFarByte
	ld b, a
	inc hl
	ret

.Mon:
; the box de's POKéMON a (its index array at bc)
	ld l, a
	ld h, 0
	push hl
	add hl, de
	inc hl ; (its species list's)
	ld a, [hl]
	pop hl
	cp EGG
	ret z
	push hl
	add hl, hl
	add hl, bc
	ld b, h
	ld c, l ; its index
	pop hl
	ld a, l
	ld hl, sBoxMonNicknames - sBox
	add hl, de
	push bc
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	pop bc
	push bc
	ld a, [bc]
	ld e, a
	inc bc
	ld a, [bc]
	ld d, a
	call FindFusedSpecies
	pop hl
	ret nc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

RepairFusedParty::
; The party's POKéMON, if the save needs it (see InitMonTable): their species, and
; their stats worked out again.
	ldh a, [rSVBK]
	push af
	ld a, BANK(wMonRepairParty)
	ldh [rSVBK], a
	ld a, [wMonRepairParty]
	ld b, a
	xor a
	ld [wMonRepairParty], a
	pop af
	ldh [rSVBK], a
	ld a, b
	and a
	ret z
	xor a
.mon
	ld [wCurPartyMon], a
	ld hl, wPartyCount
	cp [hl]
	ret nc
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	cp EGG
	jp z, .next
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Species
	call GetPartyLocation
	ld a, [hl]
	call GetPokemonIndexFromID
	ld d, h
	ld e, l
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	call FindFusedSpecies
	jr nc, .next
	ld h, d
	ld l, e
	call GetPokemonIDFromIndex
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	ld c, a
	ld a, [wCurPartyMon]
	ld e, a
	ld d, 0
	ld hl, wPartySpecies
	add hl, de
	ld [hl], c
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Species
	call GetPartyLocation
	ld a, [wCurSpecies]
	ld [hl], a
; its stats, for its species (and its HP no more than its max)
	push hl
	call GetBaseData
	pop bc
	ld hl, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a
	ld hl, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	ld hl, MON_STAT_EXP - 1
	add hl, bc
	push bc
	ld b, TRUE
	predef CalcMonStats
	pop bc
	ld hl, MON_HP
	add hl, bc
	ld d, h
	ld e, l
	ld hl, MON_MAXHP
	add hl, bc
	ld a, [de] ; (HP - max HP, big-endian)
	cp [hl]
	jr c, .next
	jr nz, .max_hp
	inc de
	inc hl
	ld a, [de]
	cp [hl]
	dec de
	dec hl
	jr c, .next
	jr z, .next
.max_hp
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
.next
	ld a, [wCurPartyMon]
	inc a
	jp .mon

FindSpeciesByName::
; (FindFusedSpecies for farcall: the nickname in wStringBuffer1)
	ld hl, wStringBuffer1
	jr FindFusedSpecies

GetSpeciesNameFromIndex::
; wStringBuffer1: the name of species de (a 16-bit index; 0, EGG's), as a nickname
	call FindFusedSpecies.NameOf
	ld hl, wStringBuffer1
	ld c, MON_NAME_LENGTH - 1
.copy
	ld a, [de]
	ld [hli], a
	inc de
	dec c
	jr nz, .copy
	ld [hl], '@'
	ret

FindFusedSpecies:
; Carry if the nickname at hl isn't the name of species de (a 16-bit index) but is
; another's: de, that species (the first, for names forms share).
	push hl
	ld a, d
	or e
	jr z, .search
	ld a, LOW(NUM_POKEMON)
	sub e
	ld a, HIGH(NUM_POKEMON)
	sbc d
	jr c, .search ; (none it could be)
	call .NameOf
	call .SameName
	jr z, .no
.search
	ld de, 1
.next_name
	pop hl
	push hl
	push de
	call .NameOf
	call .SameName
	pop de
	jr z, .found
	inc de
	ld a, LOW(NUM_POKEMON)
	sub e
	ld a, HIGH(NUM_POKEMON)
	sbc d
	jr nc, .next_name
.no
	pop hl
	and a
	ret

.found
	pop hl
	scf
	ret

.NameOf:
; de: species de's name (keeps hl)
	push hl
	ld h, d
	ld l, e
	dec hl
	ld d, h
	ld e, l
	add hl, hl
	add hl, hl
	add hl, de
	add hl, hl ; x (MON_NAME_LENGTH - 1)
	ld de, PokemonNames
	add hl, de
	ld d, h
	ld e, l
	pop hl
	ret

.SameName:
; z if the nickname at hl is the name at de
	assert MON_NAME_LENGTH - 1 == 10
	ld c, MON_NAME_LENGTH - 1
.char
	ld a, [de]
	cp [hl]
	ret nz
	cp '@'
	ret z
	inc de
	inc hl
	dec c
	jr nz, .char
	ld a, [hl] ; (a name ten long: the nickname ends there too)
	cp '@'
	ret
