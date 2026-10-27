; Natures, as in the latest games. A Pokémon's nature comes from its DVs, so it
; needs no room in the save. Each nature raises one stat (not HP) by 10% and
; lowers another by 10%, or (HARDY, DOCILE, SERIOUS, BASHFUL, QUIRKY) neither.
; Perfect DVs make a HARDY Pokémon. A MINT gives it another nature (see GetMint).

GetNature:
; hl: the DVs. Return the nature (0-24, the latest games' order) in a:
; (the DVs as a 16-bit number + 15) mod 25.
	push hl
	ld a, [hli]
	call .Mod25
	ld c, a
	add a
	add c
	add a ; x 6 (256 mod 25)
	ld c, a
	ld a, [hl]
	call .Mod25
	add c
	add 15
	call .Mod25
	pop hl
	ret

.Mod25:
	cp 25
	ret c
	sub 25
	jr .Mod25

GetNatureStats:
; a: a nature. Return the stat it raises in d and the one it lowers in e
; (0-4: ATTACK, DEFENSE, SPEED, SPCL.ATK, SPCL.DEF), the same one if neither.
	ld d, 0
.loop
	cp 5
	jr c, .done
	sub 5
	inc d
	jr .loop

.done
	ld e, a
	ret

GetDVsNature::
; de: a POKéMON's DVs, in its struct (a MINT's nature, if it has one: see
; GetMonNature). Return the nature in c, the stat it raises in d and the one it
; lowers in e (for farcall).
	ld h, d
	ld l, e
	call GetMonNature
	ld c, a
	jr GetNatureStats

GetMonNature:
; hl: a POKéMON's DVs, in its struct (its stat exp just before them). Return its
; nature in a: the one a MINT gave it, else its DVs'.
	call GetMint
	and a
	jr z, GetNature
	dec a
	ret

GetMint:
; A MINT's nature is kept in the lowest bit of each of the POKéMON's 5 stat exps
; (HP's is bit 0): no room in the save, and at most 1 stat exp less or more.
; hl: its DVs, in its struct. Return the nature + 1 in a, or 0 if it has none
; (none from a MINT is 0; more than NUM_NATURES isn't one either). Keeps bc, hl.
	push hl
	push bc
	dec hl ; (SPECIAL's stat exp's low byte, just before the DVs)
	assert MON_DVS == MON_SPC_EXP + 2
	lb bc, NUM_EXP_STATS, 0
.bit
	ld a, [hld]
	dec hl
	rra ; (its lowest bit)
	rl c
	dec b
	jr nz, .bit
	ld a, c
	cp NUM_NATURES + 1
	jr c, .done
	xor a
.done
	pop bc
	pop hl
	ret

SetMint:
; hl: a POKéMON's DVs, in its struct; a: a nature + 1 (0: none). It's kept in its
; stat exps' lowest bits (see GetMint). Keeps bc, hl.
	push hl
	push bc
	dec hl
	ld c, a
	sla c
	sla c
	sla c ; (bit 4, SPECIAL's, first)
	ld b, NUM_EXP_STATS
.bit
	ld a, [hl]
	and ~1
	sla c
	adc 0
	ld [hld], a
	dec hl
	dec b
	jr nz, .bit
	pop bc
	pop hl
	ret

GiveMintNature:
; (MintEffect) The POKéMON chosen (wCurPartyMon) gets nature e from a MINT: carry
; if it has that one already. Then its name is in wStringBuffer2 (its stats are
; still to be worked out again).
	push de
	ld a, MON_DVS
	call GetPartyParamLocation
	pop de
	call GetMonNature
	cp e
	scf
	ret z
	call GetNature
	cp e
	ld a, 0 ; (its own again: no MINT's)
	jr z, .set
	ld a, e
	inc a
.set
	call SetMint
	ld c, e
	ld de, wStringBuffer2
	farcall CopyNatureName
	and a
	ret

ClearOldMintBits::
; On CONTINUE, a game saved before there were MINTs gets every POKéMON's stat
; exps' lowest bits cleared (the party's, the DAY-CARE's, every box's), so that
; none looks as if a MINT gave it a nature (once: NEW GAME sets the flag too).
	ld de, EVENT_MINT_BITS_CLEARED
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	ret nz
	ld de, EVENT_MINT_BITS_CLEARED
	ld b, SET_FLAG
	call EventFlagAction
	ld hl, wPartyMon1DVs
	ld a, [wPartyCount]
	ld bc, PARTYMON_STRUCT_LENGTH
	call .Clear
	ld hl, wBreedMon1DVs
	ld a, 1
	call .Clear
	ld hl, wBreedMon2DVs
	ld a, 1
	call .Clear
	ld hl, .Boxes
	ld e, NUM_BOXES + 1
.box
	ld a, [hli]
	call OpenSRAM
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	ld a, [bc] ; (its count)
	cp MONS_PER_BOX + 1
	jr c, .count
	ld a, MONS_PER_BOX
.count
	push hl
	ld hl, sBoxMon1DVs - sBox
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	call .Clear
	pop hl
	call CloseSRAM
	dec e
	jr nz, .box
	ret

.Clear:
; a POKéMON at hl (its DVs) and a - 1 more every bc
	and a
	ret z
.mon
	push af
	xor a
	call SetMint
	add hl, bc
	pop af
	dec a
	jr nz, .mon
	ret

.Boxes:
; the box out, then every box: its bank and place
	db BANK(sBox)
	dw sBox
for n, 1, NUM_BOXES + 1
	db BANK(sBox{d:n})
	dw sBox{d:n}
	assert sBox{d:n}Mon1DVs - sBox{d:n} == sBoxMon1DVs - sBox
endr

ApplyNature:
; For CalcMonStatC. c: the stat (STAT_HP-STAT_SDEF); b: whether its stat exp
; counts (a POKéMON's own, so the nature is its MINT's if it has one: see
; GetMonNature); hl: the DVs. The stat in hMultiplicand + 1 (2 bytes) grows by
; 10% if the nature raises it, or shrinks by 10% if it lowers it (rounding down;
; no higher than MAX_STAT_VALUE).
	ld a, c
	sub STAT_ATK
	ret c ; (HP)
	ld e, b
	ld b, a
	ld a, e
	and a
	jr z, .dvs
	call GetMonNature
	jr .got_nature

.dvs
	call GetNature
.got_nature
	call GetNatureStats
	ld a, d
	cp e
	ret z ; (neither)
	ld a, b
	cp d
	ld a, 11
	jr z, .apply
	ld a, b
	cp e
	ret nz
	ld a, 9
.apply
	ldh [hMultiplier], a
	xor a
	ldh [hMultiplicand + 0], a
	call Multiply
	ld a, 10
	ldh [hDivisor], a
	ld b, 4
	call Divide
; (hQuotient + 2 is hMultiplicand + 1)
	ldh a, [hQuotient + 2]
	cp HIGH(MAX_STAT_VALUE)
	ret c
	jr nz, .max
	ldh a, [hQuotient + 3]
	cp LOW(MAX_STAT_VALUE) + 1
	ret c
.max
	ld a, HIGH(MAX_STAT_VALUE)
	ldh [hQuotient + 2], a
	ld a, LOW(MAX_STAT_VALUE)
	ldh [hQuotient + 3], a
	ret

ApplyNaturesToOldSave::
; On CONTINUE, a game saved before there were natures gets its party's stats
; recalculated with them (once). Pokémon in boxes and the DAY-CARE get theirs
; when they're taken out, as always.
	ld de, EVENT_NATURES_IN_STATS
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	ret nz
	ld de, EVENT_NATURES_IN_STATS
	ld b, SET_FLAG
	call EventFlagAction
	ld a, [wPartyCount]
	and a
	ret z
	ld c, 0
.loop
	push bc
	ld a, c
	ld hl, wPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [hl] ; MON_SPECIES
	and a
	jr z, .next
	ld [wCurSpecies], a
	push hl
	call GetBaseData
	pop hl
	push hl
	ld bc, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a
	pop hl
	push hl
	ld bc, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	push hl
	ld bc, MON_STAT_EXP - 1
	add hl, bc
	ld b, TRUE
	call CalcMonStats
	pop hl
; (its HP stays, no higher than its max HP)
	ld bc, MON_HP
	add hl, bc
	ld d, h
	ld e, l
	ld bc, MON_MAXHP - MON_HP
	add hl, bc
	ld a, [de]
	cp [hl]
	jr c, .next
	jr nz, .max_hp
	inc de
	inc hl
	ld a, [de]
	cp [hl]
	jr c, .next
	dec de
	dec hl
.max_hp
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
.next
	pop bc
	inc c
	ld a, [wPartyCount]
	cp c
	jr nz, .loop
	ret
