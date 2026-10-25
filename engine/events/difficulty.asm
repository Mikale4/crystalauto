; PalletToPewter's difficulties, picked at the end of PROF. OAK's speech (and
; asked once when continuing a game saved before there were any):
; - NORMAL: the journey as it was meant to be, but a GYM LEADER's whole team
;   (and the ELITE FOUR's, the CHAMPION's and RED's) stands at its ace's level.
; - HARD: every trainer's Pokémon are at least at the level cap (a leader's at
;   least two above it), as evolved as their level allows, and items can't be
;   used in battle.
; - EXTREME: HARD, plus six Pokémon for every trainer, with their best moves,
;   perfect DVs and held items, battling smarter. The player gets the
;   ENDLESS CANDY.
; (See engine/battle/difficulty_trainers.asm.)

GetDifficulty::
	ld a, [wDifficulty]
	and DIFFICULTY_MASK
	ret

ChooseDifficulty::
; PROF. OAK asks how tough a journey the player wants.
	ld hl, DifficultyAskText
	call PrintText
	ld hl, DifficultyMenuHeader
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ld a, [wMenuCursorY]
	dec a
	push af
	ld e, a
	ld d, 0
	ld hl, DifficultyDescriptionTexts
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	call YesNoBox
	pop bc
	jr c, ChooseDifficulty
	ld a, b
	set DIFFICULTY_CHOSEN_F, a
	ld [wDifficulty], a
	call GetDifficulty
	and a ; DIFFICULTY_NORMAL
	ret z
	ld hl, DifficultyHardItIsText
	cp DIFFICULTY_HARD
	jr z, .print
	ld hl, DifficultyExtremeItIsText
.print
	call PrintText
	call GetDifficulty
	cp DIFFICULTY_EXTREME
	ret nz
	jp GiveEndlessCandy

AskDifficultyIfUnset::
; Continuing a game saved before there were difficulties: PROF. OAK asks once.
	ld a, [wDifficulty]
	bit DIFFICULTY_CHOSEN_F, a
	ret nz
	xor a
	ld [wCurPartySpecies], a
	ld a, POKEMON_PROF
	ld [wTrainerClass], a
	farcall Intro_PrepTrainerPic
	ld b, SCGB_TRAINER_OR_MON_FRONTPIC_PALS
	call GetSGBLayout
	farcall Intro_RotatePalettesLeftFrontpic
	ld hl, DifficultyNewText
	call PrintText
	call ChooseDifficulty
	call RotateThreePalettesRight
	call ClearTilemap
	ret

DifficultyMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 10, 2, 19, 9
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP | STATICMENU_DISABLE_B ; flags
	db NUM_DIFFICULTIES ; items
	db "NORMAL@"
	db "HARD@"
	db "EXTREME@"

DifficultyNames:
	table_width 2
	dw .Normal
	dw .Hard
	dw .Extreme
	assert_table_length NUM_DIFFICULTIES

.Normal:  db "NORMAL@"
.Hard:    db "HARD@"
.Extreme: db "EXTREME@"

DifficultyDescriptionTexts:
	table_width 2
	dw .Normal
	dw .Hard
	dw .Extreme
	assert_table_length NUM_DIFFICULTIES

.Normal:
	text "NORMAL is the"
	line "journey as it was"
	cont "meant to be."

	para "Is that the one"
	line "for you?"
	done

.Hard:
	text "On HARD, trainers"
	line "are at the level"
	cont "cap, GYM LEADERS"
	cont "above it."

	para "Items can't be"
	line "used in battle."

	para "Is that the one"
	line "for you?"
	done

.Extreme:
	text "EXTREME is HARD,"
	line "and every trainer"
	cont "has six #MON"
	cont "with their best"
	cont "moves and items."

	para "Is that the one"
	line "for you?"
	done

DifficultyAskText:
	text "Before you go, how"
	line "tough a journey do"
	cont "you want?"
	done

DifficultyNewText:
	text "<PLAYER>! Before"
	line "you go on, how"
	cont "tough a journey do"
	cont "you want?"

	para "You can only pick"
	line "this once."
	prompt

DifficultyHardItIsText:
	text "HARD it is!"
	line "Trainers won't go"
	cont "easy on you."
	prompt

DifficultyExtremeItIsText:
	text "EXTREME it is!"
	line "Trainers won't go"
	cont "easy on you."
	prompt

CheckItemsAllowedInBattle::
; No items in battle, on any difficulty (but BALLs in the BUG-CATCHING
; CONTEST, and the DUDE's lesson; and BALLs at a beaten wild Pokémon have
; their own menu: see CaptureRule_ChooseBall). Return carry, and say so, if
; not allowed.
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	jr z, .allowed
	cp BATTLETYPE_TUTORIAL
	jr z, .allowed
	cp BATTLETYPE_DEBUG
	jr z, .allowed
	ld hl, NoItemsInBattleText
	call BattleTextbox
	scf
	ret

.allowed
	and a
	ret

NoItemsInBattleText:
	text "No items can be"
	line "used in battle!"
	prompt

TrainerCard_PrintLevelCapAndDifficulty::
	hlcoord 2, 14
	ld de, .LevelCapString
	call PlaceString
	call GetLevelCap
	cp MAX_LEVEL
	jr nc, .no_cap
	ld [wCurLevelCap], a
	hlcoord 15, 14
	ld de, wCurLevelCap
	lb bc, 1, 3
	call PrintNum
	jr .difficulty

.no_cap
	hlcoord 14, 14
	ld de, .NoneString
	call PlaceString
.difficulty
	call GetDifficulty
	ld e, a
	ld d, 0
	ld hl, DifficultyNames
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	hlcoord 2, 15
	jp PlaceString

.LevelCapString:
	db "LEVEL CAP@"

.NoneString:
	db "NONE@"

GiveEndlessCandy:
; EXTREME: a RARE CANDY that never runs out.
	ld a, ENDLESS_CANDY
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantityChange], a
	ld hl, wNumItems
	call ReceiveItem
	ld hl, ReceivedEndlessCandyText
	call PrintText
	ld de, SFX_KEY_ITEM
	call PlaySFX
	call WaitSFX
	ld hl, EndlessCandyExplainText
	jp PrintText

ReceivedEndlessCandyText:
	text "<PLAYER> received"
	line "the ENDLESSCANDY!"
	done

EndlessCandyExplainText:
	text "It never runs out."
	line "Use it again and"
	cont "again, right up to"
	cont "the level cap!"
	prompt
