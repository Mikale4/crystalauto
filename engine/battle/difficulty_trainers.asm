; How the difficulty changes trainers' teams, once ReadTrainerParty has made
; them (PalletToPewter's 85_difficulty.js; see engine/events/difficulty.asm):
; - NORMAL: a leader's whole team stands at its ace's level.
; - HARD and EXTREME: every Pokémon is at least at the level cap (a leader's at
;   least two above it, and at its ace's level), as evolved as that level
;   allows: level evolutions at their level, the others (stones and the items
;   that took a trade) at the level ItemEvolutionLevels gives for the line.
;   Where a line branches, each trainer's Pokémon goes its own way.
; - EXTREME: see engine/battle/extreme_trainers.asm.
; Leaders are the GYM LEADERS, the ELITE FOUR, the CHAMPION and RED.

DEF ITEM_EVO_LV EQU 30 ; (for a line ItemEvolutionLevels doesn't have)

DifficultyAdjustTrainerParty::
	ld a, [wOTPartyCount]
	and a
	ret z
	xor a
	ld [wDifficultyLeader], a
	call IsLeaderTrainer
	jr nc, .not_leader
	ld a, TRUE
	ld [wDifficultyLeader], a
.not_leader
	call GetTrainerPartyAce
	ld b, a ; ace
	call GetDifficulty
	and a ; DIFFICULTY_NORMAL
	jr nz, .hard
; NORMAL: only leaders, at their ace's level
	ld a, [wDifficultyLeader]
	and a
	ret z
	ld a, b
	jr .got_floor

.hard
	call GetDifficultyLevelCap
	ld c, a
	ld a, [wDifficultyLeader]
	and a
	ld a, c
	jr z, .got_floor
	add CAP_BELOW
	cp b
	jr nc, .got_floor
	ld a, b
.got_floor
	cp MAX_LEVEL + 1
	jr c, .floor_ok
	ld a, MAX_LEVEL
.floor_ok
	ld [wDifficultyFloor], a

	ld c, 0
.loop
	push bc
	ld a, c
	ld hl, wOTPartyMon1Level
	call GetOTPartyMonParam
	ld a, [wDifficultyFloor]
	ld b, a
	ld a, [hl]
	cp b
	jr nc, .got_level
	ld a, b
.got_level
	ld [wCurPartyLevel], a
	pop bc
	push bc
	ld a, c
	ld hl, wOTPartyMon1Species
	call GetOTPartyMonParam
	ld a, [hl]
	ld [wCurPartySpecies], a
	call GetDifficulty
	and a ; DIFFICULTY_NORMAL
	jr z, .update
	pop bc
	push bc
	call GetTrainerMonSeed
	ld e, a
	ld a, [wCurPartySpecies]
	call FitEvolution
	ld [wCurPartySpecies], a
.update
	pop bc
	push bc
	ld a, c
	call UpdateOTPartyMon
	pop bc
	inc c
	ld a, [wOTPartyCount]
	cp c
	jr nz, .loop
	call GetDifficulty
	cp DIFFICULTY_EXTREME
	jp z, ExtremeTrainerParty
; held items (no one can use items in battle): on NORMAL, a leader's ace holds
; one; on HARD, every leader's Pokémon and every other trainer's ace
	ld b, a
	ld a, [wDifficultyLeader]
	and a
	jr z, .not_leader_items
	ld a, b
	and a ; DIFFICULTY_NORMAL
	jr z, .ace_item
	ld c, 0
.item_loop
	push bc
	ld a, c
	call GiveTrainerHeldItem ; (the same bank: a is the slot)
	pop bc
	inc c
	ld a, [wOTPartyCount]
	cp c
	jr nz, .item_loop
	ret

.not_leader_items
	ld a, b
	and a ; DIFFICULTY_NORMAL
	ret z
.ace_item
	call GetTrainerPartyAceSlot
	call GiveTrainerHeldItem ; (the same bank: a is the slot)
	ret

GetOTPartyMonParam:
; hl: the param in wOTPartyMon1; a: which mon
	ld bc, PARTYMON_STRUCT_LENGTH
	jp AddNTimes

IsLeaderTrainer::
; Return carry for a GYM LEADER, the ELITE FOUR, the CHAMPION and RED.
	ld a, [wOtherTrainerClass]
	ld hl, LeaderTrainerClasses
	ld de, 1
	jp IsInArray

LeaderTrainerClasses:
	db FALKNER, WHITNEY, BUGSY, MORTY, PRYCE, JASMINE, CHUCK, CLAIR
	db BROCK, MISTY, LT_SURGE, ERIKA, JANINE, SABRINA, BLAINE, BLUE
	db WILL, KOGA, BRUNO, KAREN, CHAMPION, RED
	db -1

GetTrainerPartyAce:
; The highest level in the trainer's team, as made.
	ld hl, wOTPartyMon1Level
	ld a, [wOTPartyCount]
	ld c, a
	ld b, 0
	ld de, PARTYMON_STRUCT_LENGTH
.loop
	ld a, [hl]
	cp b
	jr c, .next
	ld b, a
.next
	add hl, de
	dec c
	jr nz, .loop
	ld a, b
	ret

GetTrainerPartyAceSlot:
; a: the slot of the trainer's highest-level Pokémon (the last, on a tie).
	ld hl, wOTPartyMon1Level
	lb bc, 0, 0 ; b: the best level, c: its slot
	ld a, [wOTPartyCount]
	ld e, a ; (count down)
	ld d, 0 ; (the slot)
.loop
	ld a, [hl]
	cp b
	jr c, .next
	ld b, a
	ld c, d
.next
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	inc d
	dec e
	jr nz, .loop
	ld a, c
	ret

GetTrainerMonSeed:
; A number of the trainer's own for its Pokémon in slot c, to pick branches by.
	ld a, [wOtherTrainerClass]
	ld b, a
	ld a, [wOtherTrainerID]
	add a
	add a
	add b
	add c
	add c
	add c
	swap a
	xor b
	ret

FitStarterEvolution::
; (for the rival's starter in RANDOMIZER mode) b: species b as evolved as
; wCurPartyLevel allows, but no more than c (1-3) times; e picks the way.
	ld a, b
	ld d, c
	call FitEvolutionStages
	ld b, a
	ret

FitEvolution::
; Return in a the furthest that species a evolves to by level wCurPartyLevel;
; e picks the way at each branch.
	ld d, 3 ; (no line evolves more than twice)
FitEvolutionStages::
; The same, but evolving no more than d (1-3) times.
	ld [wDifficultySpecies], a
.next_stage
	push de
	ld a, [wDifficultySpecies]
	call GetEvosPointer
; count the ways it can evolve
	push hl
	ld c, 0
.count
	call .GetEvoByte
	and a
	jr z, .counted
	inc c
	call .SkipEvolution
	jr .count

.counted
	pop hl
	ld a, c
	and a
	jr z, .done_pop
; which way: e mod c
	pop de
	push de
	ld a, e
.mod
	cp c
	jr c, .got_way
	sub c
	jr .mod

.got_way
	ld b, a
	inc b
.find
	dec b
	jr z, .found
	call .GetEvoByte
	call .SkipEvolution
	jr .find

.found
	call .GetEvoByte
	ld b, a ; type
	call .GetEvoByte
	ld c, a ; param
	ld a, b
	cp EVOLVE_STAT
	call z, .SkipByte
	call .GetEvoByte
	push af
	call .GetEvoByte
	ld h, a
	pop af
	ld l, a
	push hl ; the species it evolves into (its index)
; the level it needs
	ld a, b
	cp EVOLVE_LEVEL
	ld a, c
	jr z, .got_level
	ld a, b
	cp EVOLVE_STAT
	ld a, c
	jr z, .got_level
; (an item, a trade, friendship: by the line, see ItemEvolutionLevels)
	push de
	ld a, [wDifficultySpecies]
	ld hl, ItemEvolutionLevels
	ld de, 3
	call FindSpeciesInArray
	pop de
	ld a, ITEM_EVO_LV
	jr nc, .got_level
	inc hl
	inc hl
	ld a, [hl]
.got_level
	ld b, a
	ld a, [wCurPartyLevel]
	cp b
	jr c, .too_low
	pop hl
	call GetPokemonIDFromIndex
	ld [wDifficultySpecies], a
	pop de
	srl e ; (another way at the next branch)
	dec d
	jp nz, .next_stage
	jr .done

.too_low
	pop hl
.done_pop
	pop de
.done
	ld a, [wDifficultySpecies]
	ret

.GetEvoByte:
	ld a, BANK(EvosAttacksPointers)
	call GetFarByte
	inc hl
	ret

.SkipEvolution:
; (past the type a)
	cp EVOLVE_STAT
	call z, .SkipByte
	inc hl ; (the parameter)
	inc hl ; (the species: a 16-bit index)
.SkipByte:
	inc hl
	ret

ItemEvolutionLevels:
; The level a trainer's Pokémon evolves at, by a stone or an item that took a
; trade (see FitEvolution): about where its line's level evolutions would put it.
; first evolutions
	dwb SUNKERN,    20
	dwb PIKACHU,    24
	dwb STARYU,     24
	dwb CLEFAIRY,   26
	dwb JIGGLYPUFF, 26
	dwb EEVEE,      26
	dwb VULPIX,     28
	dwb SHELLDER,   28
	dwb GROWLITHE,  30
	dwb ONIX,       30
	dwb EXEGGCUTE,  30
	dwb SCYTHER,    30
	dwb PORYGON,    30
	dwb SLOWPOKE,   37 ; (as SLOWBRO)
	dwb MIME_JR,     18 ; (as MR. MIME)
	dwb SANDSHREW_A, 22 ; (as SANDSHREW)
	dwb VULPIX_A,    28
	dwb CUBONE,      28 ; (as MAROWAK)
	dwb GROWLITHE_H, 30
	dwb QWILFISH_H,  30
	dwb SNEASEL,     30
	dwb GLIGAR,      30
	dwb MISDREAVUS,  30
	dwb MURKROW,     30
	dwb KOFFING,     35 ; (as WEEZING)
	dwb SLOWPOKE_G,  37 ; (as SLOWBRO)
; to a third form
	dwb TOGETIC,    36
	dwb QUILAVA,    36 ; (as TYPHLOSION)
	dwb GRAVELER_A, 36
	dwb URSARING,   40
	dwb MAGNETON,   40
	dwb ELECTABUZZ, 45
	dwb MAGMAR,     45
	dwb PORYGON2,   45
	dwb RHYDON,     55
	dwb GLOOM,      30
	dwb WEEPINBELL, 30
	dwb NIDORINA,   32
	dwb NIDORINO,   32
	dwb POLIWHIRL,  34
	dwb KADABRA,    36
	dwb MACHOKE,    36
	dwb GRAVELER,   36
	dwb HAUNTER,    36
	dwb SEADRA,     40
	dw -1

GetEvosPointer:
; hl: species a's evolutions and moves; preserves de
	ld b, a
	farcall GetEvolutionsPointer
	ret

UpdateOTPartyMon::
; Make the trainer's Pokémon in slot a the wCurPartySpecies at wCurPartyLevel.
	ld [wDifficultySlot], a
	ld hl, wOTPartySpecies
	ld e, a
	ld d, 0
	add hl, de
	ld a, [wCurPartySpecies]
	ld [hl], a
	ld a, [wDifficultySlot]
	ld hl, wOTPartyMon1
	call GetOTPartyMonParam
	push hl
	ld a, [wCurPartySpecies]
	ld [hl], a ; MON_SPECIES
	ld [wCurSpecies], a
	call GetBaseData
	pop hl
	push hl
	ld bc, MON_LEVEL
	add hl, bc
	ld a, [wCurPartyLevel]
	ld [hl], a

; level-up moves, unless the trainer picked its moves
	ld a, [wTrainerPartyType]
	bit 0, a ; TRAINERTYPE_MOVES or TRAINERTYPE_ITEM_MOVES
	jr nz, .moves_done
	pop hl
	push hl
	ld bc, MON_MOVES
	add hl, bc
	push hl
	xor a
rept NUM_MOVES
	ld [hli], a
endr
	ld [wSkipMovesBeforeLevelUp], a
	ld [wEvolutionOldSpecies], a
	pop de
	push de
	predef FillMoves
	pop hl
	call SetFullPP
.moves_done

; EXP for its level
	ld a, [wCurPartyLevel]
	ld d, a
	farcall CalcExpAtLevel
	pop hl
	push hl
	ld bc, MON_EXP
	add hl, bc
	ldh a, [hProduct + 1]
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a

; stats, at full HP
	pop hl
	push hl
	call RecalcOTPartyMonStats

; its name
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld a, [wDifficultySlot]
	ld hl, wOTPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	pop hl
	ret

RecalcOTPartyMonStats::
; The trainer's Pokémon at hl (base data loaded): stats from its level and DVs.
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
	predef CalcMonStats
	pop hl
	push hl
	ld bc, MON_MAXHP
	add hl, bc
	ld a, [hli]
	ld c, [hl]
	ld b, a
	pop hl
	push hl
	ld de, MON_HP
	add hl, de
	ld a, b
	ld [hli], a
	ld [hl], c
	pop hl
	ret

SetFullPP::
; hl: a Pokémon's moves; give each its full PP.
	ld b, NUM_MOVES
.loop
	ld a, [hl]
	push hl
	push bc
	ld de, MON_PP - MON_MOVES
	add hl, de
	push hl
	and a
	jr z, .no_move
	ld l, a
	ld a, MOVE_PP
	call GetMoveAttribute
.no_move
	pop hl
	ld [hl], a
	pop bc
	pop hl
	inc hl
	dec b
	jr nz, .loop
	ret
