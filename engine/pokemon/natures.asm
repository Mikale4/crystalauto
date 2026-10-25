; Natures, as in the latest games. A Pokémon's nature comes from its DVs, so it
; needs no room in the save. Each nature raises one stat (not HP) by 10% and
; lowers another by 10%, or (HARDY, DOCILE, SERIOUS, BASHFUL, QUIRKY) neither.
; Perfect DVs make a HARDY Pokémon.

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
; de: the DVs. Return the nature in c, the stat it raises in d and the one it
; lowers in e (for farcall).
	ld h, d
	ld l, e
	call GetNature
	ld c, a
	jr GetNatureStats

ApplyNature:
; For CalcMonStatC. c: the stat (STAT_HP-STAT_SDEF); hl: the DVs. The stat in
; hMultiplicand + 1 (2 bytes) grows by 10% if the nature raises it, or shrinks
; by 10% if it lowers it (rounding down; no higher than MAX_STAT_VALUE).
	ld a, c
	sub STAT_ATK
	ret c ; (HP)
	ld b, a
	call GetNature
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
