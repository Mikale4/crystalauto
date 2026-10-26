; RANDOMIZER mode, picked at the start of a new game after the difficulty (see
; ChooseRandomizer). Every wild Pokémon becomes another, picked by the game's own
; seed (wRandomizerSeed) from where it is met and what it was, so a route has the
; same Pokémon each time it's walked. Options also make trainers' Pokémon random,
; swap the legendaries among themselves and change ELM's three Pokémon.
;
; Wild and trainer Pokémon become one about as strong: a pick from the
; RANDOMIZER_WINDOW places either side of the one replaced, in RandomizerPool
; (sorted by base stat total; see tools/randomizer_pools.py). Legendaries and
; UNOWN are never picked: a legendary only swaps with another (LegendaryPool, a
; shuffle of it by the seed).
;
; Picks are made by hashing the seed with what the pick is for (RANDOM_*) and
; where: RandomizerHashStart, then RandomizerMix for each byte.

INCLUDE "data/randomizer/pools.asm"

LegendaryPool:
	dw ARTICUNO, ZAPDOS, MOLTRES, MEWTWO, MEW
	dw RAIKOU, ENTEI, SUICUNE, LUGIA, HO_OH, CELEBI
	dw ARTICUNO_G, ZAPDOS_G, MOLTRES_G
.End:
DEF NUM_LEGENDARIES EQU (LegendaryPool.End - LegendaryPool) / 2

StarterPool:
; for STARTERS_STARTERS
	dw BULBASAUR, CHARMANDER, SQUIRTLE
	dw CHIKORITA, CYNDAQUIL, TOTODILE
	dw PIKACHU, EEVEE
.End:
DEF NUM_STARTER_POOL EQU (StarterPool.End - StarterPool) / 2

JohtoStarterLines:
; STARTER_* x 3, by stage
	dw CHIKORITA, BAYLEEF, MEGANIUM
	dw CYNDAQUIL, QUILAVA, TYPHLOSION
	dw TOTODILE, CROCONAW, FERALIGATR
	dw -1
	assert NUM_STARTERS == 3

; Hashing

RandomizerHashStart:
; hl: the seed, mixed with a (RANDOM_*)
	push af
	ld a, [wRandomizerSeed]
	xor $5a
	ld l, a
	ld a, [wRandomizerSeed + 1]
	xor $c3
	ld h, a
	pop af
	; fallthrough

RandomizerMix:
; Mix byte a into the hash hl. Preserves bc and de.
	push de
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	call RandomizerXorShift
	ld a, l
	add h
	ld h, a
	call RandomizerXorShift
	pop de
	ret

RandomizerXorShift:
; hl: the next number of a 16-bit xorshift (7, 9, 8) after hl. Uses d.
; hl ^= hl << 7
	ld a, h
	rrca
	and $80
	ld d, a
	ld a, l
	srl a
	or d
	xor h
	ld h, a
	ld a, l
	rrca
	and $80
	xor l
	ld l, a
; hl ^= hl >> 9
	ld a, h
	srl a
	xor l
	ld l, a
; hl ^= hl << 8
	xor h
	ld h, a
	ret

RandomizerIndex:
; hl: a number from 0 to de - 1 (de: 1 to $8000), picked by the hash hl.
; Preserves de.
	push bc
; bc: the smallest 2^n - 1 that's at least de - 1
	dec de
	ld bc, 0
.mask
	ld a, c
	sub e
	ld a, b
	sbc d
	jr nc, .got_mask
	sla c
	rl b
	inc c
	jr .mask

.got_mask
	inc de
.try
	push hl
	ld a, l
	and c
	ld l, a
	ld a, h
	and b
	ld h, a
	ld a, l
	sub e
	ld a, h
	sbc d
	jr c, .ok
; too big: the hash's next number
	pop hl
	push de
	call RandomizerXorShift
	pop de
	jr .try

.ok
	pop af ; (the hash)
	pop bc
	ret

SimilarSpecies:
; de: a species about as strong as species de (16-bit indexes), picked by the
; hash hl from RandomizerPool. (de itself, if it isn't a species.)
	ld a, d
	or e
	ret z
	ld a, e
	sub LOW(NUM_POKEMON + 1)
	ld a, d
	sbc HIGH(NUM_POKEMON + 1)
	ret nc
	push hl
; bc: its place, less the window, within 0 and the last window's start
	ld hl, RandomizerRanks - 2
	add hl, de
	add hl, de
	ld a, [hli]
	sub RANDOMIZER_WINDOW
	ld c, a
	ld a, [hl]
	sbc 0
	ld b, a
	jr nc, .not_below
	ld bc, 0
.not_below
	ld a, c
	sub LOW(NUM_RANDOMIZER_POOL - 2 * RANDOMIZER_WINDOW)
	ld a, b
	sbc HIGH(NUM_RANDOMIZER_POOL - 2 * RANDOMIZER_WINDOW)
	jr c, .not_above
	ld bc, NUM_RANDOMIZER_POOL - (2 * RANDOMIZER_WINDOW + 1)
.not_above
	pop hl
	ld de, 2 * RANDOMIZER_WINDOW + 1
	call RandomizerIndex
	add hl, bc
	add hl, hl
	ld de, RandomizerPool
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ret

; Wild Pokémon

RandomizeWildIndexHere::
; RandomizeWildIndex in the map the player is in.
	push bc
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	call RandomizeWildIndex
	pop bc
	ret

RandomizeWildIndex::
; de: what the wild Pokémon de (a 16-bit index) met in slot hRandomizerSlot
; (WILDSLOT_* etc.) of map b, c (its group and number) is in RANDOMIZER mode.
; (The RUINS OF ALPH's UNOWN stay: they're the only ones, and their letters
; are part of the puzzles.) Preserves bc.
	ld a, [wRandomizer]
	bit RANDOMIZER_ON_F, a
	ret z
	ld a, e
	cp LOW(UNOWN)
	jr nz, .not_unown
	ld a, d
	cp HIGH(UNOWN)
	ret z
.not_unown
	push bc
	ld a, RANDOM_WILD
	call RandomizerHashStart
	ld a, b
	call RandomizerMix
	ld a, c
	call RandomizerMix
	ldh a, [hRandomizerSlot]
	call RandomizerMix
	ld a, e
	call RandomizerMix
	ld a, d
	call RandomizerMix
	call SimilarSpecies
	pop bc
	ret

LoadContestWildmon::
; wTempWildMonSpecies: the BUG-CATCHING CONTEST's Pokémon de (a 16-bit index),
; as it is in RANDOMIZER mode
	ld a, WILDSLOT_CONTEST
	ldh [hRandomizerSlot], a
	call RandomizeWildIndexHere
	ld h, d
	ld l, e
	call GetPokemonIDFromIndex
	ld [wTempWildMonSpecies], a
	ret

RandomizerRank::
; de: species de's place in RandomizerPool (where it would be, if it isn't there)
	ld a, d
	or e
	ret z
	ld hl, RandomizerRanks - 2
	add hl, de
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ret

; Trainers' Pokémon

RandomizeTrainerMon::
; de: what the Pokémon de (a 16-bit index) in slot hRandomizerSlot of the
; trainer being read (wOtherTrainerClass, wOtherTrainerID) is in RANDOMIZER mode,
; at wCurPartyLevel. Return carry if that's another.
	ld a, [wOtherTrainerClass]
	ld b, a
	ld a, [wOtherTrainerID]
	ld c, a
	; fallthrough

RandomizeTrainerIndex::
; The same, for trainer c of class b.
	ld a, [wRandomizer]
	bit RANDOMIZER_ON_F, a
	jr z, .same
; the rival keeps the line of the POKé BALL he took from ELM
	ld a, b
	cp RIVAL1
	jr z, .rival
	cp RIVAL2
	jr nz, .not_rival
.rival
	call RivalStarter
	ret c
	jr z, .same ; (his starter, which ELM had too)
.not_rival
	ld a, [wRandomizer]
	bit RANDOMIZER_TRAINERS_F, a
	jr z, .same
	push de
	ld a, RANDOM_TRAINER
	call RandomizerHashStart
	ld a, b
	call RandomizerMix
	ld a, c
	call RandomizerMix
	ldh a, [hRandomizerSlot]
	call RandomizerMix
	ld a, e
	call RandomizerMix
	ld a, d
	call RandomizerMix
	push bc
	call SimilarSpecies
	pop bc
	pop hl
; carry if another
	ld a, e
	cp l
	jr nz, .another
	ld a, d
	cp h
	jr nz, .another
.same
	and a
	ret

.another
	scf
	ret

RivalStarter:
; If de is in a Johto starter's line, return z, or carry with de the Pokémon at
; that stage of the line of the one ELM's POKé BALL has instead (as evolved as
; wCurPartyLevel allows). Return nz and nc otherwise.
	push bc
	ld hl, JohtoStarterLines
	lb bc, 0, 0 ; the line, the stage
.find
	ld a, [hli]
	cp e
	ld a, [hli]
	jr nz, .next
	cp d
	jr z, .found
.next
	cp -1
	jr z, .not_found
	inc c
	ld a, c
	cp 3
	jr c, .find
	ld c, 0
	inc b
	jr .find

.not_found
	pop bc
	or 1 ; nz, nc
	ret

.found
	ld a, [wRandomizer]
	and RANDOMIZER_STARTERS_MASK
	jr z, .original
	push bc
	ld c, b
	call GetStarterIndex
	pop bc
	ld a, c
	and a
	jr z, .done ; (the first stage)
; evolve no more than the stage, and only as far as the level allows
	push bc
	push de
	ld a, RANDOM_BRANCH
	call RandomizerHashStart
	ld a, b
	call RandomizerMix ; (which way at a branch)
	pop de
	push hl
	ld h, d
	ld l, e
	call GetPokemonIDFromIndex
	pop hl
	pop bc
	ld b, a
	ld e, l
	farcall FitStarterEvolution
	ld a, b
	call GetPokemonIndexFromID
	ld d, h
	ld e, l
.done
	pop bc
	scf
	ret

.original
	pop bc
	xor a ; z, nc
	ret

; Legendaries

RandomizeLegendaryIndex::
; de: what the legendary de (a 16-bit index) is in RANDOMIZER mode (de itself,
; if it isn't one or they aren't swapped). Preserves bc.
	ld a, [wRandomizer]
	bit RANDOMIZER_ON_F, a
	ret z
	bit RANDOMIZER_LEGENDARIES_F, a
	ret z
	push bc
	ld hl, LegendaryPool
	ld c, 0
.find
	ld a, [hli]
	cp e
	ld a, [hli]
	jr nz, .next
	cp d
	jr z, .found
.next
	inc c
	ld a, c
	cp NUM_LEGENDARIES
	jr c, .find
	pop bc
	ret

.found
	call ShuffledLegendary
	ld l, a
	ld h, 0
	add hl, hl
	ld de, LegendaryPool
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop bc
	ret

ShuffledLegendary:
; a: the place in LegendaryPool that place c gets in a shuffle of it by the seed.
; Each place in turn gets a random one of the places no place before it got.
	ld de, 0 ; (places given, as bits)
	ld b, 0
.loop
	push bc
	push de
	ld a, RANDOM_LEGENDARY
	call RandomizerHashStart
	ld a, b
	call RandomizerMix
	ld a, NUM_LEGENDARIES
	sub b
	ld e, a
	ld d, 0
	call RandomizerIndex ; (which of the places left)
	pop de
	call .NthFree
	pop bc
	push af
; give it
	ld hl, 1
	and a
	jr z, .got_bit
.shift
	add hl, hl
	dec a
	jr nz, .shift
.got_bit
	ld a, e
	or l
	ld e, a
	ld a, d
	or h
	ld d, a
	pop af
	ld l, a
	ld a, b
	cp c
	ld a, l
	ret z
	inc b
	jr .loop

.NthFree:
; a: the place of the (l + 1)th clear bit of de
	push de
	ld h, 0
.scan
	srl d
	rr e
	jr c, .taken
	ld a, l
	and a
	jr z, .found
	dec l
.taken
	inc h
	jr .scan

.found
	ld a, h
	pop de
	ret

; ELM's Pokémon

GetStarterIndex:
; de: the species (16-bit index) in ELM's POKé BALL c (STARTER_*). In
; RANDOMIZER mode the three are different: start + c x step, through the pool.
	ld a, [wRandomizer]
	and RANDOMIZER_STARTERS_MASK
	jr nz, .random
	ld hl, JohtoStarterLines
	ld b, 0
	ld a, c
	add a
	add c ; x 3 (stages)
	ld c, a
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ret

.random
	cp STARTERS_STARTERS << RANDOMIZER_STARTERS_SHIFT
	ld de, NUM_STARTER_POOL
	jr z, .got_pool
	ld de, NUM_POKEMON
.got_pool
	push de
; the start: 0 to n - 1
	ld a, RANDOM_STARTER
	call RandomizerHashStart
	xor a
	call RandomizerMix
	call RandomizerIndex
	push hl
; the step: 1 to (n - 1) / 2, so the three are different
	ld a, RANDOM_STARTER
	call RandomizerHashStart
	ld a, 1
	call RandomizerMix
	push hl
	ld h, d
	ld l, e
	dec hl
	srl h
	rr l
	ld d, h
	ld e, l
	pop hl
	call RandomizerIndex
	inc hl
; start + c x step
	ld d, h
	ld e, l
	pop hl
	inc c
.add_step
	dec c
	jr z, .added
	add hl, de
	jr .add_step

.added
	pop de ; n
; within 0 to n - 1
.mod
	ld a, l
	sub e
	ld a, h
	sbc d
	jr c, .got_place
	ld a, l
	sub e
	ld l, a
	ld a, h
	sbc d
	ld h, a
	jr .mod

.got_place
	ld a, e
	cp LOW(NUM_STARTER_POOL)
	jr nz, .any
	ld a, d
	cp HIGH(NUM_STARTER_POOL)
	jr nz, .any
	add hl, hl
	ld de, StarterPool
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	ret

.any
	inc hl ; (indexes from 1)
	ld d, h
	ld e, l
	ret

GetStarterSpecies::
; special: wScriptVar: the species in ELM's POKé BALL wScriptVar (STARTER_*),
; with its name in wStringBuffer3 and its type (in small letters) in
; wStringBuffer4.
	ld a, [wScriptVar]
	ld c, a
	; fallthrough

LoadStarterSpecies::
; The same for POKé BALL c.
	call GetStarterIndex
	ld h, d
	ld l, e
	call GetPokemonIDFromIndex
	ld [wScriptVar], a
	ld [wNamedObjectIndex], a
	ld [wCurSpecies], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wStringBuffer3
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	call GetBaseData
	ld a, [wBaseType1]
	ld [wNamedObjectIndex], a
	farcall GetTypeName
	ld hl, wStringBuffer1
	ld de, wStringBuffer4
.small_letters
	ld a, [hli]
	cp 'A'
	jr c, .letter_ok
	cp 'Z' + 1
	jr nc, .letter_ok
	add 'a' - 'A'
.letter_ok
	ld [de], a
	inc de
	cp '@'
	jr nz, .small_letters
	ret

; The new game's question and options

ChooseRandomizer::
; After the difficulty, PROF. OAK asks whether the player wants RANDOMIZER mode.
	xor a
	ld [wRandomizer], a
	ld hl, RandomizerAskText
	call PrintText
	ld hl, RandomizerMenuHeader
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ld a, [wMenuCursorY]
	dec a
	ret z ; NO
	call RandomizerOptions
; back to the player's picture
	call RotateThreePalettesRight
	call ClearTilemap
	call LoadFontsExtra
	call WaitBGMap
	xor a
	ld [wCurPartySpecies], a
	farcall DrawIntroPlayerPic
	ld b, SCGB_TRAINER_OR_MON_FRONTPIC_PALS
	call GetSGBLayout
	call RotateThreePalettesLeft
; the seed: when the player got here, more or less
	call Random
	ld b, a
	ldh a, [rDIV]
	xor b
	ld [wRandomizerSeed], a
	call Random
	ld b, a
	ld a, [wPlayerID]
	xor b
	ld [wRandomizerSeed + 1], a
	ld hl, RandomizerItIsText
	jp PrintText

RandomizerMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 14, 7, 19, 11
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_DISABLE_B ; flags
	db 2 ; items
	db "NO@"
	db "YES@"

	const_def
	const RANDOPT_TRAINERS    ; 0
	const RANDOPT_LEGENDARIES ; 1
	const RANDOPT_STARTERS    ; 2
	const RANDOPT_DONE        ; 3
DEF NUM_RANDOPTS EQU const_value

RandomizerOptions:
; The options on a screen of their own: UP and DOWN pick a line, LEFT, RIGHT and
; A change it, and A on DONE (or START) is done. wJumptableIndex: the line.
	ld a, 1 << RANDOMIZER_ON_F
	ld [wRandomizer], a
	ld hl, hInMenu
	ld a, [hl]
	push af
	ld [hl], TRUE
	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	xor a
	ldh [hBGMapMode], a
	ld [wJumptableIndex], a
	hlcoord 0, 0
	ld b, 11
	ld c, SCREEN_WIDTH - 2
	call Textbox
	hlcoord 0, 13
	ld b, 3
	ld c, SCREEN_WIDTH - 2
	call Textbox
	hlcoord 2, 1
	ld de, RandomizerOptionsString
	call PlaceString
	call .Draw
	ld a, 1
	ldh [hBGMapMode], a
	call WaitBGMap
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	call SetDefaultBGPAndOBP

.loop
	call JoyTextDelay
	ldh a, [hJoyPressed]
	bit B_PAD_START, a
	jr nz, .done
	bit B_PAD_UP, a
	jr nz, .up
	bit B_PAD_DOWN, a
	jr nz, .down
	bit B_PAD_LEFT, a
	jr nz, .left
	and PAD_RIGHT | PAD_A
	jr z, .loop
; RIGHT or A
	ld a, [wJumptableIndex]
	cp RANDOPT_DONE
	jr z, .done
	ld c, 1
	jr .change

.left
	ld a, [wJumptableIndex]
	cp RANDOPT_DONE
	jr z, .loop
	ld c, -1
.change
	call .Change
	jr .redraw

.up
	ld a, [wJumptableIndex]
	and a
	jr nz, .up_ok
	ld a, NUM_RANDOPTS
.up_ok
	dec a
	jr .moved

.down
	ld a, [wJumptableIndex]
	inc a
	cp NUM_RANDOPTS
	jr c, .moved
	xor a
.moved
	ld [wJumptableIndex], a
.redraw
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	call .Draw
	call WaitBGMap
	jr .loop

.done
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	pop af
	ldh [hInMenu], a
	ret

.Change:
; the option on line a, one way (c: 1) or the other (c: -1)
	cp RANDOPT_STARTERS
	jr z, .starters
	ld b, 1 << RANDOMIZER_TRAINERS_F
	and a ; RANDOPT_TRAINERS
	jr z, .toggle
	ld b, 1 << RANDOMIZER_LEGENDARIES_F
.toggle
	ld a, [wRandomizer]
	xor b
	ld [wRandomizer], a
	ret

.starters
	ld a, [wRandomizer]
	and RANDOMIZER_STARTERS_MASK
	rept RANDOMIZER_STARTERS_SHIFT
	rrca
	endr
	add c
	cp NUM_STARTER_MODES
	jr c, .starters_ok
	xor a
	bit 7, c
	jr z, .starters_ok
	ld a, NUM_STARTER_MODES - 1
.starters_ok
	rept RANDOMIZER_STARTERS_SHIFT
	rlca
	endr
	ld b, a
	ld a, [wRandomizer]
	and ~RANDOMIZER_STARTERS_MASK
	or b
	ld [wRandomizer], a
	ret

.Draw:
; the settings, the cursor and what the line under it means
	ld a, [wRandomizer]
	bit RANDOMIZER_TRAINERS_F, a
	ld de, RandomizerOffString
	jr z, .trainers
	ld de, RandomizerOnString
.trainers
	hlcoord 11, 6
	call PlaceString
	ld a, [wRandomizer]
	bit RANDOMIZER_LEGENDARIES_F, a
	ld de, RandomizerOffString
	jr z, .legendaries
	ld de, RandomizerOnString
.legendaries
	hlcoord 11, 8
	call PlaceString
	call .StarterMode
	ld hl, RandomizerStarterStrings
	call .Pointer
	hlcoord 11, 10
	call PlaceString
; the cursor (rows 5, 7, 9 and 11)
	hlcoord 1, 5
	ld bc, SCREEN_WIDTH * 2
	ld e, 0
.cursor_loop
	ld [hl], ' '
	ld a, [wJumptableIndex]
	cp e
	jr nz, .no_cursor
	ld [hl], '▶'
.no_cursor
	add hl, bc
	inc e
	ld a, e
	cp NUM_RANDOPTS
	jr c, .cursor_loop
; what it means
	hlcoord 1, 14
	lb bc, 3, SCREEN_WIDTH - 2
	call ClearBox
	ld a, [wJumptableIndex]
	ld hl, RandomizerTrainerTexts
	cp RANDOPT_TRAINERS
	jr z, .on_off
	ld hl, RandomizerLegendaryTexts
	cp RANDOPT_LEGENDARIES
	jr z, .on_off
	ld de, RandomizerDoneText
	cp RANDOPT_DONE
	jr z, .place_text
	call .StarterMode
	ld hl, RandomizerStarterTexts
	call .Pointer
	jr .place_text

.on_off
	ld a, [wJumptableIndex]
	ld b, 1 << RANDOMIZER_TRAINERS_F
	and a
	jr z, .got_bit
	ld b, 1 << RANDOMIZER_LEGENDARIES_F
.got_bit
	ld a, [wRandomizer]
	and b
	jr z, .off
	ld a, 1
.off
	call .Pointer
.place_text
	hlcoord 1, 14
	jp PlaceString

.StarterMode:
	ld a, [wRandomizer]
	and RANDOMIZER_STARTERS_MASK
	rept RANDOMIZER_STARTERS_SHIFT
	rrca
	endr
	ret

.Pointer:
; de: pointer a in the table at hl
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ret

RandomizerOptionsString:
	db "RANDOMIZER MODE<LF>"
	db "<LF>"
	db "WILD #MON<LF>"
	db "        :RANDOM<LF>"
	db "TRAINERS<LF>"
	db "        :<LF>"
	db "LEGENDARIES<LF>"
	db "        :<LF>"
	db "ELM'S #MON<LF>"
	db "        :<LF>"
	db "DONE@"

RandomizerOffString: db "OFF     @"
RandomizerOnString:  db "ON      @"

RandomizerStarterStrings:
	table_width 2
	dw .Original
	dw .Starters
	dw .Any
	assert_table_length NUM_STARTER_MODES

.Original: db "SAME    @"
.Starters: db "STARTERS@"
.Any:      db "ANY     @"

RandomizerTrainerTexts:
	dw .Off
	dw .On

.Off:
	db "Trainers keep<LF>"
	db "their own #MON.@"

.On:
	db "Trainers' #MON<LF>"
	db "are random too,<LF>"
	db "about as strong.@"

RandomizerLegendaryTexts:
	dw .Off
	dw .On

.Off:
	db "Legendary #MON<LF>"
	db "stay as they are.@"

.On:
	db "Each legendary<LF>"
	db "#MON is another<LF>"
	db "legendary #MON.@"

RandomizerStarterTexts:
	table_width 2
	dw .Original
	dw .Starters
	dw .Any
	assert_table_length NUM_STARTER_MODES

.Original:
	db "ELM has CHIKORITA,<LF>"
	db "CYNDAQUIL and<LF>"
	db "TOTODILE.@"

.Starters:
	db "Starters from<LF>"
	db "KANTO and JOHTO,<LF>"
	db "PIKACHU and EEVEE.@"

.Any:
	db "Any three #MON,<LF>"
	db "even legendaries!@"

RandomizerDoneText:
	db "Wild #MON are<LF>"
	db "always random,<LF>"
	db "about as strong.@"

RandomizerAskText:
	text "And do you want a"
	line "RANDOMIZER"
	cont "journey?"

	para "The wild #MON"
	line "you meet will all"
	cont "be a surprise!"
	done

RandomizerItIsText:
	text "RANDOMIZER it is!"
	line "Who knows what"
	cont "you'll meet?"
	prompt
