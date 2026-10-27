; PalletToPewter's boss Pokémon (77_bosses.js): the one-of-a-kind Pokémon met in
; the story don't fight alone. Each brings five allies that suit it (and answer
; its team's weaknesses). They come at the player one at a time, then the boss
; joins the fight itself. Beaten, the boss decides to join the player: no BALL
; needed. On NORMAL the allies are two levels under the boss; on HARD and
; EXTREME they're at the level cap, and the boss at least two above it.
;
; Under the hood a boss battle is a trainer battle (so the allies come in one by
; one, there's no running away and the AI picks their moves). It borrows
; BOSS_TRAINER_CLASS for anything it doesn't change itself: its party, name,
; picture and palette are the boss's, its AI doesn't switch or use items, and
; it has texts of its own. wBossBattle holds the boss's species until the
; battle ends.

DEF BOSS_TRAINER_CLASS EQU POKEMANIAC
DEF NUM_BOSS_ALLIES EQU 5

BossTeams:
; the boss, then its allies (each evolves as far as its level allows; 16-bit indexes)
	dw SUDOWOODO, GEODUDE,   ONIX,      BELLSPROUT, HOPPIP,    PINECO     ; rocks and trees
	dw LAPRAS,    SHELLDER,  SEEL,      WOOPER,     ZUBAT,     SLOWPOKE   ; UNION CAVE's waters
	dw GYARADOS,  MAGIKARP,  WOOPER,    POLIWAG,    TENTACOOL, GOLDEEN    ; the LAKE OF RAGE
	dw ELECTRODE, VOLTORB,   MAGNEMITE, PIKACHU,    ZUBAT,     KOFFING    ; the hideout's generator
	dw SNORLAX,   SLOWBRO,   WIGGLYTUFF, LICKITUNG, HYPNO,     KANGASKHAN ; (PalletToPewter's)
	dw SUICUNE,   STARYU,    SEEL,      WOOPER,     HORSEA,    SMOOCHUM   ; the north wind
	dw RAIKOU,    ELEKID,    JOLTEON,   CHINCHOU,   MAREEP,    HOPPIP     ; thunder
	dw ENTEI,     GROWLITHE, MAGBY,     HOUNDOUR,   VULPIX,    EXEGGCUTE  ; the volcano
	dw LUGIA,     HORSEA,    CHINCHOU,  MANTINE,    SLOWPOKE,  SKARMORY   ; the sea's guardian
	dw HO_OH,     FLAREON,   VAPOREON,  JOLTEON,    ESPEON,    UMBREON    ; the KIMONO GIRLS' EEVEE
	dw CELEBI,    PINECO,    ODDISH,    FARFETCH_D, HERACROSS, HOOTHOOT   ; ILEX FOREST
	dw ARTICUNO_G, MR__MIME_G, SLOWPOKE_G, PONYTA_G, NATU,      GIRAFARIG ; GALAR's psychic wind
	dw ZAPDOS_G,  FARFETCH_D_G, MACHOP,  MANKEY,     HERACROSS, TYROGUE    ; GALAR's kicking thunder
	dw MOLTRES_G, MURKROW,   SNEASEL,   HOUNDOUR,   MEOWTH_A,  RATTATA_A  ; GALAR's dark fire
	dw ARTICUNO,  SEEL,      SHELLDER,  SWINUB,     SNEASEL,   DELIBIRD   ; SEAFOAM's ice
	dw ZAPDOS,    PIKACHU,   MAGNEMITE, ELEKID,     MAREEP,    DODUO      ; the POWER PLANT
	dw MOLTRES,   PONYTA,    SLUGMA,    MAGBY,      SPEAROW,   SANDSHREW  ; VICTORY ROAD's fire
	dw MEWTWO,    ABRA,      GASTLY,    DROWZEE,    CHANSEY,   DITTO      ; CERULEAN CAVE's
	dw MEW,       GRIMER,    KOFFING,   PONYTA,     VULPIX,    MAGBY      ; the burned mansion's
	dw -1

FindBossTeam:
; Return carry and hl at the team of boss a.
	ld hl, BossTeams
	ld de, 2 * (1 + NUM_BOSS_ALLIES)
	jp FindSpeciesInArray

FindBattleBossTeam:
; Return carry and hl at the team of the boss in battle, a: the team's own boss,
; or the legendary RANDOMIZER mode put in its place (see BeginBossBattle).
	call GetPokemonIndexFromID
	ld b, h
	ld c, l
	ld hl, BossTeams
.loop
	ld a, [hli]
	ld e, a
	ld a, [hld]
	ld d, a
	and e
	inc a
	ret z ; (-1: nc)
	push hl
	farcall RandomizeLegendaryIndex
	pop hl
	ld a, e
	cp c
	jr nz, .next
	ld a, d
	cp b
	jr nz, .next
	scf
	ret

.next
	ld de, 2 * (1 + NUM_BOSS_ALLIES)
	add hl, de
	jr .loop

BeginBossBattle::
; Before the enemy is set up: is this a scripted wild battle with a boss?
	xor a
	ld [wBossBattle], a
	ld a, [wBattleScriptFlags]
	cp 1 << BATTLESCRIPT_SCRIPTED_F ; (scripted, wild)
	ret nz
	ld a, [wOtherTrainerClass]
	and a
	ret nz
	ld a, [wTempWildMonSpecies]
	call FindBossTeam
	ret nc
; RANDOMIZER mode can put another legendary in the boss's place (with the
; team's own allies: FindBattleBossTeam finds them)
	ld a, [wTempWildMonSpecies]
	call GetPokemonIndexFromID
	ld d, h
	ld e, l
	farcall RandomizeLegendaryIndex
	ld h, d
	ld l, e
	call GetPokemonIDFromIndex
	ld [wTempWildMonSpecies], a
	ld [wBossBattle], a
	ld a, [wCurPartyLevel]
	ld [wBossBaseLevel], a
	ld a, BOSS_TRAINER_CLASS
	ld [wOtherTrainerClass], a
	ld a, 1
	ld [wOtherTrainerID], a
	ret

LoadBossParty::
; ReadTrainerParty: return carry with the boss's team made, if it's a boss.
	ld a, [wBossBattle]
	and a
	ret z

; levels
	ld a, [wBossBaseLevel]
	ld b, a
	call GetDifficulty
	and a ; DIFFICULTY_NORMAL
	jr z, .normal
	call GetDifficultyLevelCap
	ld c, a
	add CAP_BELOW
	cp b
	jr c, .boss_level_ok
	ld b, a ; at least two above the cap
.boss_level_ok
	ld a, b
	cp MAX_LEVEL + 1
	jr c, .boss_level_capped
	ld b, MAX_LEVEL
.boss_level_capped
	ld a, b
	sub CAP_BELOW
	cp c
	jr nc, .got_levels
	ld a, c ; at the cap
	jr .got_levels

.normal
	ld a, b
	sub CAP_BELOW
	jr c, .min_level
	cp MIN_LEVEL
	jr nc, .got_levels
.min_level
	ld a, MIN_LEVEL
.got_levels
	push bc ; b: the boss's level
	ld [wCurPartyLevel], a

; the allies
	ld a, [wBossBattle]
	call FindBattleBossTeam
	inc hl
	inc hl
	ld c, 0
.ally_loop
	push bc
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call GetPokemonIDFromIndex
	push af
	ld a, [wBossBattle]
	call GetPokemonIndexFromID
	ld a, l ; (the boss's index)
	add c
	swap a
	add c
	ld e, a ; which way it evolves
	pop af
	call FitEvolution
	ld [wCurPartySpecies], a
	call .AddMon
	pop hl
	pop bc
	inc hl
	inc hl
	inc c
	ld a, c
	cp NUM_BOSS_ALLIES
	jr nz, .ally_loop

; the boss itself, last
	pop bc
	ld a, b
	ld [wCurPartyLevel], a
	ld a, [wBossBattle]
	ld [wCurPartySpecies], a
	call .AddMon
	ld a, [wBattleType]
	cp BATTLETYPE_FORCESHINY
	jr nz, .not_shiny
	ld a, ATKDEFDV_SHINY
	ld [hli], a
	ld a, SPDSPCDV_SHINY
	ld [hld], a
.not_shiny
	ld a, [wBattleType]
	cp BATTLETYPE_FORCEITEM
	jr nz, .no_item
	ld bc, MON_ITEM - MON_DVS
	add hl, bc
	ld a, [wBaseItem1]
	ld [hl], a
.no_item
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	call RecalcOTPartyMonStats
	call GetDifficulty
	cp DIFFICULTY_EXTREME
	call z, ExtremeBossParty
	scf
	ret

.AddMon:
; Add wCurPartySpecies at wCurPartyLevel, with DVs of its own.
; Return hl at its DVs.
	ld a, OTPARTYMON
	ld [wMonType], a
	predef TryAddMonToParty
	ld a, [wOTPartyCount]
	dec a
	ld hl, wOTPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	push hl
	ld bc, MON_DVS
	add hl, bc
	call Random
	ld [hli], a
	call Random
	ld [hld], a
	pop de
	push hl
	ld h, d
	ld l, e
	call RecalcOTPartyMonStats
	pop hl
	ret

BossTrainerAttributes::
; No trainer uses items in battle (no one can: see CheckItemsAllowedInBattle),
; and a boss gives no prize money.
	xor a
	ld [wEnemyTrainerItem1], a
	ld [wEnemyTrainerItem2], a
	ld a, [wBossBattle]
	and a
	ret z
	xor a
	ld [wEnemyTrainerBaseReward], a
	ret

BossNextMon::
; The boss's allies come out in order, and the boss last.
; Return carry and its index in b, if it's a boss battle.
	ld a, [wBossBattle]
	and a
	ret z
	ld hl, wOTPartyMon1HP
	ld de, PARTYMON_STRUCT_LENGTH
	ld b, 0
.loop
	ld a, [hli]
	or [hl]
	dec hl
	jr nz, .found
	add hl, de
	inc b
	ld a, [wOTPartyCount]
	cp b
	jr nz, .loop
	ld b, 0
.found
	scf
	ret

BossBattleText::
; de: one of the game's battle texts. Return in hl the text to show instead in
; a boss battle (or de itself).
	ld h, d
	ld l, e
	ld a, [wBossBattle]
	and a
	ret z
	ld bc, -WantsToBattleText
	add hl, bc
	ld a, h
	or l
	ld hl, BossAttacksText
	ret z
	ld h, d
	ld l, e
	ld bc, -BattleText_TheresNoEscapeFromTrainerBattle
	add hl, bc
	ld a, h
	or l
	ld hl, BossNoEscapeText
	ret z
	ld h, d
	ld l, e
	ld bc, -BattleText_EnemySentOut
	add hl, bc
	ld a, h
	or l
	jr z, .sent_out
	ld h, d
	ld l, e
	ret

.sent_out
	ld a, [wCurOTMon]
	and a
	ld hl, BossFirstAllyText
	ret z
	inc a
	ld b, a
	ld a, [wOTPartyCount]
	cp b
	ld hl, BossJoinsTheFightText
	ret z
	ld hl, BossAllyRushesInText
	ret

GetBossDVsPointer::
; bc: the boss's DVs (for its palette in the picture before and after).
	ld a, [wOTPartyCount]
	and a
	jr z, .none
	dec a
	ld hl, wOTPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld b, h
	ld c, l
	ret

.none
	ld bc, wEnemyMonDVs
	ret

GetAIMoveWeights::
; hl: the AI layers to use (in BANK(TrainerClassAttributes)).
	ld a, [wBossBattle]
	and a
	jr nz, .smart
	call GetDifficulty
	cp DIFFICULTY_EXTREME
	jr z, .smart
	ld hl, TrainerClassAttributes + TRNATTR_AI_MOVE_WEIGHTS
	ld a, [wInBattleTowerBattle]
	bit IN_BATTLE_TOWER_BATTLE_F, a
	ret nz ; (the first class's, for every Battle Tower trainer)
	ld a, [wTrainerClass]
	dec a
	ld bc, NUM_TRAINER_ATTRIBUTES
	jp AddNTimes

.smart
	ld hl, PalletToPewterAIMoveWeights
	ret

GetAIItemSwitchAttributes::
; hl: whether and how the AI switches (in BANK(TrainerClassAttributes)).
	ld a, [wBossBattle]
	and a
	jr nz, .boss
	ld hl, TrainerClassAttributes + TRNATTR_AI_ITEM_SWITCH
	ld a, [wInBattleTowerBattle]
	and a
	ret nz
	ld a, [wTrainerClass]
	dec a
	ld bc, NUM_TRAINER_ATTRIBUTES
	jp AddNTimes

.boss
	ld hl, PalletToPewterAIBossItemSwitch
	ret

BossJoins::
; The player beat the boss: it joins them. Return carry if it was a boss battle.
	ld a, [wBossBattle]
	and a
	ret z
; it gets back up
	farcall BattleWinSlideInEnemyTrainerFrontpic
	ld c, 40
	call DelayFrames
	ld hl, BossGetsBackUpText
	call BattleTextbox
	ld a, [wBossBattle]
	call PlayMonCry
	call WaitSFX
	ld de, SFX_CAUGHT_MON
	call PlaySFX
	call WaitSFX
	ld hl, BossJoinsYouText
	call BattleTextbox

	ld a, [wBossBattle]
	ld [wCurPartySpecies], a
	ld [wTempSpecies], a
	ld a, [wEnemyMonLevel]
	ld [wCurPartyLevel], a
	ld a, [wBossBattle] ; (ILEX FOREST's boss, whoever RANDOMIZER mode made it)
	call FindBattleBossTeam
	ld a, [hli]
	cp LOW(CELEBI)
	jr nz, .not_celebi
	ld a, [hl]
	cp HIGH(CELEBI)
	jr nz, .not_celebi
	ld hl, wBattleResult
	set BATTLERESULT_CAUGHT_CELEBI, [hl]
.not_celebi

; the POKéDEX
	ld a, [wBossBattle]
	call CheckCaughtMon
	ld a, c
	push af
	ld a, [wBossBattle]
	call SetSeenAndCaughtMon
	pop af
	and a
	jr nz, .skip_pokedex
	call CheckReceivedDex
	jr z, .skip_pokedex
	ld hl, BossNewDexDataText
	call BattleTextbox
	call ClearSprites
	ld a, [wBossBattle]
	ld [wTempSpecies], a
	predef NewPokedexEntry
.skip_pokedex

	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr z, .to_pc

; to the party, rested
	xor a ; PARTYMON
	ld [wMonType], a
	call ClearSprites
	predef TryAddMonToParty
	farcall SetCaughtData
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	farcall HealPartyMon
	ld a, [wBossBattle]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, BossNicknameText
	call PrintText
	call YesNoBox
	jp c, .done
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	push de
	xor a ; PARTYMON
	ld [wMonType], a
	ld b, NAME_MON
	farcall NamingScreen
	call RotateThreePalettesRight
	call LoadStandardFont
	pop hl
	ld de, wStringBuffer1
	call InitName
	jr .done

.to_pc
	call ClearSprites
	predef SendMonIntoBox
	jr nc, .done ; (no room at all)
	farcall SetBoxMonCaughtData
	farcall CheckRoomInBoxes ; (BILL calls only when every box is full)
	jr nc, .box_not_full
	ld hl, wBattleResult
	set BATTLERESULT_BOX_FULL, [hl]
.box_not_full
	ld a, [wBossBattle]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, BossNicknameText
	call PrintText
	call YesNoBox
	jr c, .sent_to_pc
	xor a
	ld [wCurPartyMon], a
	ld a, BOXMON
	ld [wMonType], a
	ld de, wMonOrItemNameBuffer
	ld b, NAME_MON
	farcall NamingScreen
	ld a, BANK(sBoxMonNicknames)
	call OpenSRAM
	ld hl, wMonOrItemNameBuffer
	ld de, sBoxMonNicknames
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ld hl, sBoxMonNicknames
	ld de, wStringBuffer1
	call InitName
	call CloseSRAM
	call RotateThreePalettesRight
	call LoadStandardFont
.sent_to_pc
	farcall GetCurBoxName
	ld hl, BossSentToPCText
	call PrintText
.done
	scf
	ret

BossAttacksText_:
	text_ram wStringBuffer1
	text " and"
	line "its allies attack!"
	prompt

BossFirstAllyText_:
	text_ram wEnemyMonNickname
	text_start
	line "comes first!"
	done

BossAllyRushesInText_:
	text_ram wEnemyMonNickname
	text_start
	line "rushes in!"
	done

BossJoinsTheFightText_:
	text_ram wStringBuffer1
	text " joins"
	line "the fight itself!"
	done

BossNoEscapeText_:
	text "There's no running"
	line "away now!"
	prompt

BossBallBlockedText_:
	text "It won't go in a"
	line "BALL!"

	para "Beat it, and see"
	line "what it does…"
	prompt

BossGetsBackUpText:
	text_ram wEnemyMonNickname
	text " slowly"
	line "gets back up…"

	para "It looks at"
	line "<PLAYER> for a"
	cont "long moment."
	prompt

BossJoinsYouText:
	text_ram wEnemyMonNickname
	text " has"
	line "decided to join"
	cont "<PLAYER>!"
	prompt

BossNewDexDataText:
	text_ram wEnemyMonNickname
	text "'s data"
	line "was newly added to"
	cont "the #DEX."
	prompt

BossNicknameText:
	text "Give a nickname to"
	line "@"
	text_ram wEnemyMonNickname
	text "?"
	done

BossSentToPCText:
	text_ram wEnemyMonNickname
	text " was"
	line "sent to @"
	text_ram wStringBuffer2
	text "."
	prompt

CheckBeastsWillBattle::
; RAIKOU and ENTEI won't battle until SUICUNE has joined the player
; (see maps/BurnedTowerB1F.asm).
	ld de, SUICUNE
	call CheckCaughtMonIndex
	ld a, c
	and a
	jr z, .done
	ld a, TRUE
.done
	ld [wScriptVar], a
	ret
