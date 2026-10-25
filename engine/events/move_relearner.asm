; The MOVE REMINDER and the MOVE TUTOR, in every POKéMON CENTER, as in
; PalletToPewter. The reminder teaches a POKéMON any move it would have learned
; by its level; the tutor, its EGG moves (its first form's), and the three moves
; GOLDENROD's tutor teaches. Both are free.

MoveReminderScript:
	faceplayer
	opentext
	special MoveReminder
	waitbutton
	closetext
	end

MoveTutorScript:
	faceplayer
	opentext
	special PokecenterMoveTutor
	waitbutton
	closetext
	end

MoveReminder:
	ld hl, .IntroText
	call RelearnerChooseMon
	ret c
	call BuildReminderList
	jp TeachFromMoveList

.IntroText:
	text "I'm the MOVE"
	line "REMINDER!"

	para "I can make a"
	line "#MON remember a"
	cont "move it could have"
	cont "learned by now."

	para "Shall I help one"
	line "remember a move?"
	done

PokecenterMoveTutor:
	ld hl, .IntroText
	call RelearnerChooseMon
	ret c
	call BuildTutorList
	jp TeachFromMoveList

.IntroText:
	text "I'm the MOVE"
	line "TUTOR!"

	para "I teach #MON"
	line "moves they'd never"
	cont "learn by leveling."

	para "Shall I teach one"
	line "a move?"
	done

RelearnerChooseMon:
; Ask (text hl) whether to, then which POKéMON; carry if not (having said so).
	call PrintText
	call YesNoBox
	jr c, .declined
	ld hl, .WhichMonText
	call PrintText
	farcall SelectMonFromParty
	jr c, .declined
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	and a
	ret

.egg
	ld hl, .EggText
	call PrintText
	scf
	ret

.declined
	ld hl, RelearnerComeAgainText
	call PrintText
	scf
	ret

.WhichMonText:
	text "Which #MON?"
	prompt

.EggText:
	text "An EGG doesn't"
	line "know any moves!"
	done

RelearnerComeAgainText:
	text "Come back anytime!"
	done

TeachFromMoveList:
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNickname
	ld a, [wMoveRelearnerCount]
	and a
	jr z, .none
	ld hl, .WhichMoveText
	call PrintText
	call ChooseRelearnerMove
	jr c, .declined
	ld [wPutativeTMHMMove], a
	ld [wNamedObjectIndex], a
	call GetMoveName
	call CopyName1
	predef LearnMove
	ld a, b
	and a
	jr z, .declined
	ld hl, .ThereText
	jp PrintText

.declined
	ld hl, RelearnerComeAgainText
	jp PrintText

.none
	ld hl, .NoneText
	jp PrintText

.WhichMoveText:
	text "Which move should"
	line "@"
	text_ram wStringBuffer1
	text " learn?"
	done

.NoneText:
	text "There's no move I"
	line "can help @"
	text_ram wStringBuffer1
	cont "learn right now."
	done

.ThereText:
	text "There you go!"
	line "Come back anytime!"
	done

ChooseRelearnerMove:
; a: the move chosen from wMoveRelearnerMoves (carry if none)
	call LoadStandardMenuHeader
	xor a
	ld [wMenuScrollPosition], a
	inc a
	ld [wMenuCursorPosition], a
	ld hl, .MenuHeader
	call CopyMenuHeader
	xor a
	ldh [hBGMapMode], a
	call InitScrollingMenu
	call UpdateSprites
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp PAD_B
	jr z, .cancel
	ld a, [wMenuSelection]
	cp -1
	jr z, .cancel
	push af
	call Call_ExitMenu
	pop af
	and a
	ret

.cancel
	call Call_ExitMenu
	scf
	ret

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 4, 1, SCREEN_WIDTH - 1, 10
	dw .MenuData
	db 1 ; default option

	db 0 ; unused

.MenuData:
	db SCROLLINGMENU_DISPLAY_ARROWS ; flags
	db 4, 0 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; item format
	dbw 0, wMoveRelearnerCount
	dba .Move
	dba NULL
	dba NULL

.Move:
; its name, and its type below
	push de
	ld a, [wMenuSelection]
	ld [wNamedObjectIndex], a
	call GetMoveName
	pop hl
	push hl
	call PlaceString
	pop hl
	ld bc, SCREEN_WIDTH + 1
	add hl, bc
	ld a, [wMenuSelection]
	ld b, a
	predef PrintMoveType
	ret

BuildReminderList:
; The moves wCurPartyMon learns by level up, up to its level, that it doesn't know.
	call ClearMoveList
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, [hl]
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld b, 0
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	call GetFarWord
.evolutions
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	inc hl
	and a
	jr z, .learnset
	cp EVOLVE_STAT
	jr nz, .no_extra
	inc hl
.no_extra
	inc hl
	inc hl
	jr .evolutions

.learnset
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	and a
	ret z
	inc hl
	ld e, a ; level
	ld a, BANK("Evolutions and Attacks")
	call GetFarByte
	inc hl
	ld b, a
	ld a, d
	cp e
	jr c, .learnset ; (not at that level yet)
	ld a, b
	call AddToMoveList
	jr .learnset

BuildTutorList:
; The EGG moves of wCurPartyMon's first form, then the GOLDENROD tutor's moves it
; can learn, that it doesn't know.
	call ClearMoveList
	ld a, [wCurPartySpecies]
	push af
.first_form
	farcall GetPreEvolution
	jr c, .first_form
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld b, 0
	ld hl, EggMovePointers
	add hl, bc
	add hl, bc
	ld a, BANK(EggMovePointers)
	call GetFarWord
.egg_moves
	ld a, BANK("Egg Moves")
	call GetFarByte
	cp -1
	jr z, .tutor_moves
	inc hl
	call AddToMoveList
	jr .egg_moves

.tutor_moves
	pop af
	ld [wCurPartySpecies], a
	ld hl, .TutorMoves
.tutor_loop
	ld a, [hli]
	and a
	ret z
	ld [wPutativeTMHMMove], a
	push hl
	predef CanLearnTMHMMove
	ld a, c
	and a
	jr z, .next
	ld a, [wPutativeTMHMMove]
	call AddToMoveList
.next
	pop hl
	jr .tutor_loop

.TutorMoves:
	db MT01_MOVE, MT02_MOVE, MT03_MOVE
	db 0 ; end

ClearMoveList:
	xor a
	ld [wMoveRelearnerCount], a
	dec a
	ld [wMoveRelearnerMoves], a
	ret

AddToMoveList:
; Add move a to the list, unless wCurPartyMon knows it, it's listed already,
; or the list is full.
	and a
	ret z
	push hl
	push de
	push bc
	ld d, a
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld c, NUM_MOVES
.known
	ld a, [hli]
	cp d
	jr z, .done
	dec c
	jr nz, .known
	ld hl, wMoveRelearnerMoves
	ld a, [wMoveRelearnerCount]
	and a
	jr z, .add
	ld c, a
.listed
	ld a, [hli]
	cp d
	jr z, .done
	dec c
	jr nz, .listed
.add
	ld a, [wMoveRelearnerCount]
	cp MAX_RELEARNER_MOVES
	jr nc, .done
	inc a
	ld [wMoveRelearnerCount], a
	ld [hl], d
	inc hl
	ld [hl], -1
.done
	pop bc
	pop de
	pop hl
	ret
