; How the difficulty changes trainers' teams, once ReadTrainerParty has made
; them (PalletToPewter's 85_difficulty.js; see engine/events/difficulty.asm):
; - NORMAL: a leader's whole team stands at its ace's level.
; - HARD and EXTREME: every Pokémon is at least at the level cap (a leader's at
;   least two above it, and at its ace's level), as evolved as that level
;   allows: level evolutions at their level, stone ones from STONE_EVO_LV,
;   trade ones from TRADE_EVO_LV and friendship ones from FRIENDSHIP_EVO_LV.
;   Where a line branches, each trainer's Pokémon goes its own way.
; - EXTREME: see engine/battle/extreme_trainers.asm.
; Leaders are the GYM LEADERS, the ELITE FOUR, the CHAMPION and RED.

DEF STONE_EVO_LV EQU 20
DEF TRADE_EVO_LV EQU 34
DEF FRIENDSHIP_EVO_LV EQU 30

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
	ret nz
	jp ExtremeTrainerParty

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
	cp EVOLVE_STAT
	call z, .SkipByte
	call .SkipByte
	call .SkipByte
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
	cp EVOLVE_STAT
	call z, .SkipByte
	call .SkipByte
	call .SkipByte
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
	push af ; the species it evolves into
; the level it needs
	ld a, b
	cp EVOLVE_LEVEL
	ld a, c
	jr z, .got_level
	ld a, b
	cp EVOLVE_STAT
	ld a, c
	jr z, .got_level
	ld a, b
	cp EVOLVE_ITEM
	ld a, STONE_EVO_LV
	jr z, .got_level
	ld a, b
	cp EVOLVE_TRADE
	ld a, TRADE_EVO_LV
	jr z, .got_level
	ld a, FRIENDSHIP_EVO_LV
.got_level
	ld b, a
	ld a, [wCurPartyLevel]
	cp b
	jr c, .too_low
	pop af
	ld [wDifficultySpecies], a
	pop de
	srl e ; (another way at the next branch)
	dec d
	jr nz, .next_stage
	jr .done

.too_low
	pop af
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

.SkipByte:
	inc hl
	ret

GetEvosPointer:
; hl: species a's evolutions and moves
	dec a
	ld c, a
	ld b, 0
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	call GetFarWord
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
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
.no_move
	pop hl
	ld [hl], a
	pop bc
	pop hl
	inc hl
	dec b
	jr nz, .loop
	ret
