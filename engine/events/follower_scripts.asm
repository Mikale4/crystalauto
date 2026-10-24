; Talking to the Pokémon followers (see engine/overworld/followers.asm),
; and renting a CHANSEY at a POKéMON CENTER.

DEF RENTAL_CHANSEY_5_PRICE  EQU 500
DEF RENTAL_CHANSEY_10_PRICE EQU 1000
DEF RENTAL_CHANSEY_15_PRICE EQU 1500

; LeadFollowerMood return values
	const_def
	const LEADMOOD_EXHAUSTED ; 0
	const LEADMOOD_UNWELL    ; 1
	const LEADMOOD_TRUSTING  ; 2
	const LEADMOOD_TROTTING  ; 3
	const LEADMOOD_SNIFFING  ; 4
	const LEADMOOD_READY     ; 5
	const LEADMOOD_CURIOUS   ; 6

LeadFollowerScript::
	callasm LeadFollowerMood
	opentext
	ifequal LEADMOOD_EXHAUSTED, .exhausted
	ifequal LEADMOOD_UNWELL, .unwell
	ifequal LEADMOOD_TRUSTING, .trusting
	ifequal LEADMOOD_TROTTING, .trotting
	ifequal LEADMOOD_SNIFFING, .sniffing
	ifequal LEADMOOD_READY, .ready
	writetext LeadFollowerCuriousText
	sjump .done

.exhausted
	writetext LeadFollowerExhaustedText
	sjump .done

.unwell
	writetext LeadFollowerUnwellText
	sjump .done

.trusting
	writetext LeadFollowerTrustingText
	sjump .done

.trotting
	writetext LeadFollowerTrottingText
	sjump .done

.sniffing
	writetext LeadFollowerSniffingText
	sjump .done

.ready
	writetext LeadFollowerReadyText
.done
	waitbutton
	closetext
	end

LeadFollowerMood:
; Play the lead Pokémon's cry, put its nickname in wStringBuffer1,
; and set wScriptVar to how it's doing.
	farcall GetLeadFollowerSpecies
	ret nc
	ld a, c
	ld [wCurPartyMon], a
	ld hl, wPartyMonNicknames
	call GetNickname
	ld a, [wCurPartyMon]
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	call PlayMonCry

; below 30% of its HP: exhausted
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld h, b
	ld l, c
	add hl, hl
	add hl, bc ; max HP * 3
	push hl
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld h, b
	ld l, c
	add hl, hl
	add hl, hl
	add hl, bc
	add hl, hl ; HP * 10
	pop bc
	ld a, l
	sub c
	ld a, h
	sbc b
	ld a, LEADMOOD_EXHAUSTED
	jr c, .done

	ld a, MON_STATUS
	call GetPartyParamLocation
	ld a, [hl]
	and a
	ld a, LEADMOOD_UNWELL
	jr nz, .done

; A Pokémon that likes you a lot may show it.
	call Random
	ld b, a
	ld a, MON_HAPPINESS
	call GetPartyParamLocation
	ld a, [hl]
	cp 200
	jr c, .not_trusting
	bit 7, b
	ld a, LEADMOOD_TRUSTING
	jr nz, .done
.not_trusting
	ld a, b
	and %11
	add LEADMOOD_TROTTING
.done
	ld [wScriptVar], a
	ret

RentalChanseyScript::
; Talking to the rented CHANSEY, or calling it with B.
	opentext
	cry CHANSEY
	callasm RentalChanseyCheckParty
	iffalse .perfect_shape
	writetext RentalChanseyAskText
	yesorno
	iffalse .done
	writetext RentalChanseySoftboiledText
	waitbutton
	closetext
	special FadeOutToWhite
	playmusic MUSIC_HEAL
	special HealParty
	pause 60
	special FadeInFromWhite
	special RestartMapMusic
	opentext
	writetext RentalChanseyHealedText
	callasm UseRentalChanseyHeal
	iftrue .wait_done
	waitbutton
	writetext RentalChanseyGoesHomeText
.wait_done
	waitbutton
.done
	closetext
	end

.perfect_shape
	writetext RentalChanseyPerfectShapeText
	waitbutton
	closetext
	end

RentalChanseyCheckParty:
; Set wScriptVar to TRUE if a party Pokémon is hurt, fainted, has a status
; condition or has used some PP.
	ld a, [wCurPartyMon]
	push af
	ld a, [wMenuCursorY]
	push af
	xor a
	ld [wScriptVar], a
	ld [wCurPartyMon], a
.loop
	ld a, [wPartyCount]
	ld b, a
	ld a, [wCurPartyMon]
	cp b
	jr nc, .done
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	cp EGG
	jr z, .next

	ld a, MON_STATUS
	call GetPartyParamLocation
	ld a, [hl]
	and a
	jr nz, .needs_healing
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	cp b
	jr nz, .needs_healing
	ld a, [hl]
	cp c
	jr nz, .needs_healing

	xor a
	ld [wMenuCursorY], a
.move_loop
	ld a, MON_MOVES
	call GetPartyParamLocation
	ld a, [wMenuCursorY]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next
	xor a ; PARTYMON
	ld [wMonType], a
	callfar GetMaxPPOfMove
	ld a, MON_PP
	call GetPartyParamLocation
	ld a, [wMenuCursorY]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	and PP_MASK
	ld hl, wTempPP
	cp [hl]
	jr c, .needs_healing
	ld hl, wMenuCursorY
	inc [hl]
	ld a, [hl]
	cp NUM_MOVES
	jr c, .move_loop

.next
	ld hl, wCurPartyMon
	inc [hl]
	jr .loop

.needs_healing
	ld a, TRUE
	ld [wScriptVar], a
.done
	pop af
	ld [wMenuCursorY], a
	pop af
	ld [wCurPartyMon], a
	ret

UseRentalChanseyHeal:
; Set wScriptVar to the heals left.
	ld hl, wRentalChanseyHeals
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	ld a, [hl]
.done
	ld [wScriptVar], a
	ret

PokecenterChanseyScript::
; NURSE JOY's CHANSEY, beside her at the counter.
	opentext
	cry CHANSEY
	readmem wRentalChanseyHeals
	iftrue .already_rented
	writetext PokecenterChanseyText
	promptbutton
	writetext PokecenterChanseyRentText
	special PlaceMoneyTopRight
	loadmenu .MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .five
	ifequal 2, .ten
	ifequal 3, .fifteen
	writetext PokecenterChanseyNoText
	waitbutton
	closetext
	end

.five
	checkmoney YOUR_MONEY, RENTAL_CHANSEY_5_PRICE
	ifequal HAVE_LESS, .not_enough_money
	takemoney YOUR_MONEY, RENTAL_CHANSEY_5_PRICE
	setval 5
	sjump .rent

.ten
	checkmoney YOUR_MONEY, RENTAL_CHANSEY_10_PRICE
	ifequal HAVE_LESS, .not_enough_money
	takemoney YOUR_MONEY, RENTAL_CHANSEY_10_PRICE
	setval 10
	sjump .rent

.fifteen
	checkmoney YOUR_MONEY, RENTAL_CHANSEY_15_PRICE
	ifequal HAVE_LESS, .not_enough_money
	takemoney YOUR_MONEY, RENTAL_CHANSEY_15_PRICE
	setval 15
.rent
	callasm StartChanseyRental
	special PlaceMoneyTopRight
	playsound SFX_TRANSACTION
	waitsfx
	disappear LAST_TALKED
	playsound SFX_KEY_ITEM
	writetext PokecenterChanseyJoinedText
	waitsfx
	promptbutton
	writetext PokecenterChanseyHowToText
	waitbutton
	closetext
	end

.not_enough_money
	writetext PokecenterChanseyNoMoneyText
	waitbutton
	closetext
	end

.already_rented
	writetext PokecenterChanseyAlreadyRentedText
	waitbutton
	closetext
	end

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db " 5 HEALS     ¥{d:RENTAL_CHANSEY_5_PRICE}@"
	db "10 HEALS    ¥{d:RENTAL_CHANSEY_10_PRICE}@"
	db "15 HEALS    ¥{d:RENTAL_CHANSEY_15_PRICE}@"
	db "CANCEL@"

StartChanseyRental:
	ld a, [wScriptVar]
	ld [wRentalChanseyHeals], a
	ld a, [wMapGroup]
	ld [wRentalChanseyMapGroup], a
	ld a, [wMapNumber]
	ld [wRentalChanseyMapNumber], a
	ret

LeadFollowerExhaustedText:
	text_ram wStringBuffer1
	text " looks"
	line "exhausted…"

	para "It needs a rest at"
	line "a #MON CENTER."
	done

LeadFollowerUnwellText:
	text_ram wStringBuffer1
	text " doesn't"
	line "look so good…"
	done

LeadFollowerTrustingText:
	text_ram wStringBuffer1
	text " is"
	line "gazing at you."

	para "It seems to trust"
	line "you a lot."
	done

LeadFollowerTrottingText:
	text_ram wStringBuffer1
	text " is"
	line "happily trotting"
	cont "along."
	done

LeadFollowerSniffingText:
	text_ram wStringBuffer1
	text " is"
	line "sniffing the"
	cont "breeze."
	done

LeadFollowerReadyText:
	text_ram wStringBuffer1
	text " looks"
	line "ready for a"
	cont "battle!"
	done

LeadFollowerCuriousText:
	text_ram wStringBuffer1
	text " is"
	line "looking around"
	cont "curiously."
	done

RentalChanseyAskText:
	text "Have CHANSEY heal"
	line "your team?"
	cont "(Heals left: @"
	text_decimal wRentalChanseyHeals, 1, 2
	text ")"
	done

RentalChanseySoftboiledText:
	text "CHANSEY used"
	line "SOFTBOILED!"
	done

RentalChanseyHealedText:
	text "Your #MON were"
	line "restored to full"
	cont "health!"
	done

RentalChanseyGoesHomeText:
	text "CHANSEY looks worn"
	line "out…"

	para "CHANSEY waved"
	line "goodbye and headed"
	cont "back home to the"
	cont "#MON CENTER."
	done

RentalChanseyPerfectShapeText:
	text "CHANSEY: Chansey!"

	para "Your team is in"
	line "perfect shape."
	cont "(Heals left: @"
	text_decimal wRentalChanseyHeals, 1, 2
	text ")"
	done

PokecenterChanseyText:
	text "CHANSEY: Chansey!"

	para "It's NURSE JOY's"
	line "partner. It looks"
	cont "keen to see the"
	cont "world!"
	done

PokecenterChanseyRentText:
	text "Rent CHANSEY?"
	line "How many heals?"
	done

PokecenterChanseyNoText:
	text "CHANSEY: …Chansey."
	done

PokecenterChanseyNoMoneyText:
	text "You don't have"
	line "enough money."
	done

PokecenterChanseyJoinedText:
	text "CHANSEY joined"
	line "you!"
	done

PokecenterChanseyHowToText:
	text "Talk to CHANSEY"
	line "whenever your team"
	cont "needs a rest."

	para "Press the B Button"
	line "to call it over."
	done

PokecenterChanseyAlreadyRentedText:
	text "CHANSEY: Chaaan-"
	line "sey!"

	para "(Its friend is"
	line "already out"
	cont "traveling with"
	cont "you.)"
	done
