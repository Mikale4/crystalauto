; PalletToPewter's capture rule: a wild Pokémon won't go in a ball while it can
; still battle. Once it's beaten (and the party has its EXP), it hangs on with
; 1 HP, worn out, and the player gets a few throws at it (3, plus one per
; badge) before it gets away. One-of-a-kind Pokémon (the ones hiding in TEAM
; ROCKET's base) don't run off: the player can throw as many as they like.
; A Pokémon that's caught comes out of its ball rested.

DEF CAPTURE_TRIES EQU 3
DEF CAPTURE_TRIES_UNLIMITED EQU -1

CaptureRule_CheckBall::
; Return carry if a ball can't be thrown at the wild Pokémon yet.
	ld a, [wBossBattle]
	and a
	jr nz, .boss
	ld a, [wBattleMode]
	dec a ; WILD_BATTLE?
	jr nz, .ok ; (trainers block BALLs themselves)
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jr z, .ok
	cp BATTLETYPE_DEBUG
	jr z, .ok
	ld a, [wCaptureFlags]
	bit CAPTURE_WORN_OUT_F, a
	jr nz, .ok
	ld hl, CaptureRuleStillBattlingText
	call PrintText
	scf
	ret

.boss
	ld hl, BossBallBlockedText_
	call PrintText
	scf
	ret

.ok
	and a
	ret

WildMonWornOut::
; Called once a wild Pokémon is beaten, before the battle ends.
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	ret z
	cp BATTLETYPE_DEBUG
	ret z

	call CaptureRule_HasRoom
	jp c, .no_room

; With continuous auto battle running, only stop for a Pokémon that
; isn't caught yet (its own species: a DITTO that TRANSFORMed is still one).
	ld a, [wAutoBattle]
	and a
	jr z, .worn_out
	ld a, [wTempEnemyMonSpecies]
	call CheckCaughtMon
	ret nz

.worn_out
	ld hl, wCaptureFlags
	set CAPTURE_WORN_OUT_F, [hl]
	xor a
	ld [wEnemyMonHP], a
	inc a
	ld [wEnemyMonHP + 1], a
	call CaptureRule_ShowWornOutMon
	ld hl, CaptureRuleWornOutText
	call BattleTextbox

	call CaptureRule_IsOneOff
	ld a, CAPTURE_TRIES_UNLIMITED
	jr c, .got_tries
	ld hl, wJohtoBadges
	ld b, 2 ; wJohtoBadges, wKantoBadges
	call CountSetBits
	add CAPTURE_TRIES
.got_tries
	ld [wCaptureTriesLeft], a

.loop
	call CaptureRule_ChooseBall
	jr c, .done
	call CaptureRule_Throw
	jr c, .done
	ld hl, wCaptureFlags
	set CAPTURE_TRIED_F, [hl]
	ld a, [wCaptureTriesLeft]
	cp CAPTURE_TRIES_UNLIMITED
	jr z, .loop
	dec a
	ld [wCaptureTriesLeft], a
	jr nz, .loop

; out of tries: it gets away
	call WaitSFX
	ld de, SFX_RUN
	call PlaySFX
	xor a
	ldh [hBGMapMode], a
	hlcoord 12, 0
	lb bc, 7, 7
	call ClearBox
	hlcoord 1, 0
	lb bc, 4, 10
	call ClearBox
	ld a, 1
	ldh [hBGMapMode], a
	call WaitSFX
	ld hl, CaptureRuleGotAwayText
	call BattleTextbox

.done
	ld hl, wCaptureFlags
	res CAPTURE_WORN_OUT_F, [hl]
	ret

.no_room
	ld hl, CaptureRuleNoRoomText
	jp BattleTextbox

CaptureRule_HasRoom:
; Return carry if the party and every box are full.
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	jr z, .room ; (the contest has a slot of its own)
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr c, .room
	farcall CheckRoomInBoxes ; (any box: the next with room takes it)
	jr c, .full
.room
	and a
	ret

.full
	scf
	ret

CaptureRule_IsOneOff:
; Return carry for a Pokémon that's the only one of its kind.
	ld a, [wBattleType]
	cp BATTLETYPE_TRAP ; (TEAM ROCKET's fake items)
	jr z, .one_off
	and a
	ret

.one_off
	scf
	ret

CaptureRule_ShowWornOutMon:
; The beaten Pokémon gets back up, with 1 HP.
	call WaitSFX
	xor a
	ldh [hBGMapMode], a
	farcall GetEnemyMonFrontpic
	xor a
	ldh [hGraphicStartTile], a
	hlcoord 12, 0
	lb bc, 7, 7
	predef PlaceGraphic
	farcall UpdateEnemyHUD
	ld a, 1
	ldh [hBGMapMode], a
	call WaitBGMap
	ld a, [wEnemyMonSpecies]
	call PlayMonCry
	ret

CaptureRule_ChooseBall:
; Ask which ball to throw. Return carry to leave it be.
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	jr z, .park_ball

	ld a, [wNumBalls]
	and a
	jr z, .no_balls
	call CaptureRule_PrintThrowPrompt
	ld hl, CaptureBallBoxMenuHeader
	call LoadMenuHeader
	hlcoord 5, 0
	lb bc, 10, 13
	call Textbox
	ld hl, CaptureBallMenuHeader
	call CopyMenuHeader
	ld a, [wBallsPocketCursor]
	ld [wMenuCursorPosition], a
	ld a, [wBallsPocketScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBallsPocketScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBallsPocketCursor], a
	call CloseWindow
	ld a, [wMenuJoypad]
	cp PAD_B
	jr z, .leave
	ld a, [wMenuSelection]
	cp -1
	jr z, .leave
	ld [wCurItem], a
	and a
	ret

.park_ball
	ld a, [wParkBallsRemaining]
	and a
	jr z, .no_balls
	call CaptureRule_PrintThrowPrompt
	call YesNoBox
	jr c, .leave
	ld a, PARK_BALL
	ld [wCurItem], a
	and a
	ret

.no_balls
	ld hl, CaptureRuleNoBallsText
	ld a, [wCaptureFlags]
	bit CAPTURE_TRIED_F, a
	jr z, .print
	ld hl, CaptureRuleOutOfBallsText
.print
	call BattleTextbox
.leave
	scf
	ret

CaptureRule_PrintThrowPrompt:
	ld hl, CaptureRuleThrowAtText
	ld a, [wCaptureTriesLeft]
	cp CAPTURE_TRIES_UNLIMITED
	jr z, .print
	ld hl, CaptureRuleThrowTriesText
	cp 1
	jr nz, .print
	ld hl, CaptureRuleThrowLastTryText
.print
	jp BattleTextbox

CaptureRule_Throw:
; Throw wCurItem. Return carry if the Pokémon was caught.
	ld a, [wPartyCount]
	push af
	ld a, [wCurItem]
	cp PARK_BALL
	call nz, LoadStandardMenuHeader ; (put away by PokeBallEffect)
	call DoItemEffect
	ld a, [wWildMon]
	and a
	jr nz, .caught

; It broke free: back to the battle screen, as after using a ball from the PACK.
	pop af
	xor a
	ldh [hBGMapMode], a
	farcall _LoadBattleFontsHPBar
	call ClearSprites
	ld a, [wBattleMonHP]
	ld b, a
	ld a, [wBattleMonHP + 1]
	or b
	jr z, .no_battle_mon ; (it fainted along with the wild Pokémon)
	farcall GetBattleMonBackpic
.no_battle_mon
	farcall GetEnemyMonFrontpic
	ld a, [wCurItem]
	cp PARK_BALL
	call nz, ExitMenu
	farcall UpdateBattleHUDs
	call WaitBGMap
	call LoadTilemapToTempTilemap
	call ClearWindowData
	farcall FinishBattleAnim
	and a
	ret

.caught
; The battle is over, as after catching with a ball from the PACK.
	pop af
	ld b, a
	ld a, [wPartyCount]
	cp b
	jr z, .not_in_party
; It comes out of its ball rested.
	dec a
	ld [wCurPartyMon], a
	farcall HealPartyMon
.not_in_party
	xor a
	ld [wWildMon], a
	ld a, [wBattleResult]
	and BATTLERESULT_BITMASK
	ld [wBattleResult], a ; WIN
	call ClearWindowData
	call SetDefaultBGPAndOBP
	scf
	ret

CaptureBallBoxMenuHeader:
; the framed box the ball list goes in, put back afterwards
	db MENU_BACKUP_TILES ; flags
	menu_coords 5, 0, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw NULL
	db 1 ; default option

CaptureBallMenuHeader:
	db 0 ; flags
	menu_coords 6, 1, SCREEN_WIDTH - 2, TEXTBOX_Y - 2
	dw .MenuData
	db 1 ; default option

.MenuData:: ; (the Demo knows the menu by it)
	db SCROLLINGMENU_CALL_FUNCTION1_CANCEL | SCROLLINGMENU_DISPLAY_ARROWS ; flags
	db 4, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; item format
	dbw 0, wNumBalls
	dba CaptureBallMenu_PlaceName
	dba PlaceMenuItemQuantity
	dba PlaceMenuItemQuantity ; unused (no SCROLLINGMENU_ENABLE_FUNCTION3)

CaptureBallMenu_PlaceName:
; The last entry is LEAVE instead of CANCEL.
	ld a, [wMenuSelection]
	cp -1
	jr z, .leave
	push de
	ld [wNamedObjectIndex], a
	call GetItemName
	pop hl
	jp PlaceString

.leave
	ld h, d
	ld l, e
	ld de, .LeaveString
	jp PlaceString

.LeaveString:
	db "LEAVE@"

CaptureRuleStillBattlingText:
	text "It's no use! It"
	line "can still battle."

	para "Beat it first,"
	line "then throw a BALL!"
	prompt

CaptureRuleWornOutText:
	text "Wild @"
	text_ram wEnemyMonNickname
	text_start
	line "is worn out!"

	para "It can't battle"
	line "any more."
	prompt

CaptureRuleThrowTriesText:
	text "Throw a BALL?"
	line "@"
	text_decimal wCaptureTriesLeft, 1, 2
	text " tries left."
	done

CaptureRuleThrowLastTryText:
	text "Throw a BALL?"
	line "Last try!"
	done

CaptureRuleThrowAtText:
	text "Throw a BALL at"
	line "@"
	text_ram wEnemyMonNickname
	text "?"
	done

CaptureRuleNoBallsText:
	text "You don't have any"
	line "BALLS to catch it"
	cont "with…"
	prompt

CaptureRuleOutOfBallsText:
	text "You're out of"
	line "BALLS!"
	prompt

CaptureRuleGotAwayText:
	text "Wild @"
	text_ram wEnemyMonNickname
	text_start
	line "got away!"
	prompt

CaptureRuleNoRoomText:
	text "There's no room"
	line "for it, even in"
	cont "the PC!"
	prompt

DudeBeatsWildMon::
; In the catching tutorial on ROUTE 29, the DUDE beats the wild Pokémon with a
; stone before he throws his ball (as PalletToPewter's OLD MAN does).
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	ret nz
	ld a, [wEnemyMonHP]
	and a
	jr nz, .beat_it
	ld a, [wEnemyMonHP + 1]
	cp 2
	ret c ; already worn out

.beat_it
	ld hl, DudeWatchCloselyText
	call BattleTextbox
; (not the ROCK THROW move's animation: after a move's, the HUDs are redrawn, and
; the player has no Pokémon out to draw)
	ld de, ANIM_DUDE_STONE
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a
	xor a
	ldh [hBattleTurn], a
	ld [wBattleAnimParam], a
	ld [wBattleAfterAnim], a
	predef PlayBattleAnim

; down to 1 HP
	ld hl, wEnemyMonMaxHP
	ld a, [hli]
	ld [wHPBuffer1 + 1], a
	ld a, [hl]
	ld [wHPBuffer1], a
	ld hl, wEnemyMonHP
	ld a, [hli]
	ld [wHPBuffer2 + 1], a
	ld a, [hl]
	ld [wHPBuffer2], a
	xor a
	ld [wEnemyMonHP], a
	ld [wHPBuffer3 + 1], a
	inc a
	ld [wEnemyMonHP + 1], a
	ld [wHPBuffer3], a
	hlcoord 2, 2
	xor a
	ld [wWhichHPBar], a
	predef AnimateHPBar
	farcall UpdateEnemyHUD
	ld hl, CaptureRuleWornOutText
	jp BattleTextbox

DudeWatchCloselyText:
	text "<PLAYER>: Watch"
	line "closely!"

	para "A wild #MON has"
	line "to be beaten"
	cont "first!"

	para "<PLAYER> threw a"
	line "stone!"
	prompt

GiveDudeMonCaughtDVs::
; After the tutorial, the RATTATA the player got from givepoke becomes the one
; the DUDE caught (wScriptVar: 0 = party, 1 = PC, 2 = not given).
	ld a, [wScriptVar]
	and a
	jr z, .party
	dec a
	ret nz
	ld a, BANK(sBoxMon1DVs)
	call OpenSRAM
	ld hl, sBoxMon1DVs
	ld a, [wDudeMonDVs]
	ld [hli], a
	ld a, [wDudeMonDVs + 1]
	ld [hl], a
	jp CloseSRAM

.party
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	ld a, MON_DVS
	call GetPartyParamLocation
	ld a, [wDudeMonDVs]
	ld [hli], a
	ld a, [wDudeMonDVs + 1]
	ld [hl], a
; its stats from those DVs
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurPartyLevel], a
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld d, h
	ld e, l
	push de
	ld a, MON_STAT_EXP - 1
	call GetPartyParamLocation
	ld b, TRUE
	predef CalcMonStats
	pop de
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a
	ret
