CountSetBits::
; Count the number of set bits in b bytes starting from hl.
; Return in a, c and [wNumSetBits].
	ld c, 0
.next
	ld a, [hli]
	ld e, a
	ld d, 8

.count
	srl e
	ld a, 0
	adc c
	ld c, a
	dec d
	jr nz, .count

	dec b
	jr nz, .next

	ld a, c
	ld [wNumSetBits], a
	ret

GetWeekday::
	ld a, [wCurDay]
.mod
	sub 7
	jr nc, .mod
	add 7
	ret

; The Pokédex flags are by species index: wPokedexCaught and wPokedexSeen have
; indexes 1 to 256's, wPokedexCaughtExt and wPokedexSeenExt the ones after.

SetSeenAndCaughtMon::
; species ID a
	call GetPokemonFlagIndex
	push de
	call SetSeenMonIndex
	pop de
SetCaughtMonIndex::
; species index de
	ld hl, wPokedexCaught
	ld bc, wPokedexCaughtExt
	ld a, SET_FLAG
	jr PokedexFlagAction

SetSeenMon::
	call GetPokemonFlagIndex
SetSeenMonIndex::
	ld hl, wPokedexSeen
	ld bc, wPokedexSeenExt
	ld a, SET_FLAG
	jr PokedexFlagAction

CheckCaughtMon::
; nz if species ID a is caught
	call GetPokemonFlagIndex
CheckCaughtMonIndex::
; nz if species index de is caught
	ld hl, wPokedexCaught
	ld bc, wPokedexCaughtExt
	ld a, CHECK_FLAG
	jr PokedexFlagAction

CheckSeenMon::
	call GetPokemonFlagIndex
CheckSeenMonIndex::
	ld hl, wPokedexSeen
	ld bc, wPokedexSeenExt
	ld a, CHECK_FLAG
	; fallthrough

PokedexFlagAction::
; action a on species index de's flag (hl: the flags of indexes 1 to 256, bc:
; the ones after); a = c = the flag (CHECK_FLAG), z if it's clear
	dec de
	inc d
	dec d
	jr z, .got_flags
	dec d
	ld h, b
	ld l, c
.got_flags
	ld b, a
	call FlagAction
	ld a, c
	and a
	ret

GetPokemonFlagIndex:
	call GetPokemonIndexFromID
	ld d, h
	ld e, l
	ret

CountPokedexCaught::
; out: de = how many species are caught (and big-endian in wPokedexNumberBuffer);
; a = [wNumSetBits] = that, up to 255
	farcall _CountPokedexCaught
	ld a, [wNumSetBits]
	ret

CountPokedexSeen::
; out: de = how many species are seen (as CountPokedexCaught's)
	farcall _CountPokedexSeen
	ld a, [wNumSetBits]
	ret

GetPokedexNumber::
; in: a = species ID; out: hl = its Pokédex number (big-endian in
; wPokedexNumberBuffer too); preserves bc, de
	call GetPokemonIndexFromID
	ld a, h
	ld [wPokedexNumberBuffer], a
	ld a, l
	ld [wPokedexNumberBuffer + 1], a
	ret
