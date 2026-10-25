; Phone trips: when a trainer calls to ask for a rematch, the player can go
; there now, and is put in front of them (see data/phone/trip_destinations.asm).

DEF PHONE_TRIP_F EQU 7 ; wCurCaller: this caller asked for a rematch
DEF PHONE_TRIP_DESTINATION_SIZE EQU 5 ; map group, number, x, y, facing

MarkPhoneTrip:
; (at the end of PhoneScript_WantsToBattle_Male/Female)
	ld hl, wCurCaller
	set PHONE_TRIP_F, [hl]
	ret

PhoneScript_OfferTrip:
; (at the end of Script_ReceivePhoneCall)
	callasm CheckPhoneTrip
	iffalse .done
	opentext
	writetext PhoneTripText
	yesorno
	iffalse .no
	closetext
	playsound SFX_WARP_TO
	callasm PhoneTripFadeOut
	waitsfx
	farscall Script_AbortBugContest
	loadvar VAR_MOVEMENT, PLAYER_NORMAL
	callasm PhoneTrip
	newloadmap MAPSETUP_PHONE_TRIP
	end

.no
	closetext
.done
	end

PhoneTripText:
	text "Go to @"
	text_ram wStringBuffer3
	text " at"
	line "@"
	text_ram wStringBuffer5
	text " now?"
	done

CheckPhoneTrip:
; wScriptVar: whether the caller asked for a rematch, and waits where a trip
; can go (and the Demo isn't playing)
	xor a
	ld [wScriptVar], a
	ld hl, wCurCaller
	bit PHONE_TRIP_F, [hl]
	res PHONE_TRIP_F, [hl]
	ret z
	ld a, [wDemoState]
	cp DEMO_RUNNING
	ret z ; (the Demo keeps to its plan)
	call PhoneTripDestination
	ld a, [hl]
	and a
	ret z
	ld a, TRUE
	ld [wScriptVar], a
	ret

PhoneTrip:
; warp to the cell in front of the caller, facing them
	call PhoneTripDestination
	ld a, [hli]
	ld [wMapGroup], a
	ld a, [hli]
	ld [wMapNumber], a
	ld a, [hli]
	ld [wXCoord], a
	ld a, [hli]
	ld [wYCoord], a
	ld b, [hl]
	ld a, [wPlayerSpriteSetupFlags]
	and ~PLAYERSPRITESETUP_FACING_MASK
	set PLAYERSPRITESETUP_CUSTOM_FACING_F, a
	or b
	ld [wPlayerSpriteSetupFlags], a
	ld a, SPAWN_N_A
	ld [wDefaultSpawnpoint], a
	ret

PhoneTripDestination:
; hl = the caller's entry in PhoneTripDestinations
	ld a, [wCurCaller]
	ld hl, PhoneTripDestinations
	ld bc, PHONE_TRIP_DESTINATION_SIZE
	jp AddNTimes

PhoneTripArrives:
; (map setup) in from black, with a chime
	ld de, SFX_WARP_FROM
	call PlaySFX
	ld c, 4
.fade
	push bc
	ld a, c
	call PhoneTripShade
	ld c, 4
	call DelayFrames
	pop bc
	dec c
	jr nz, .fade
	xor a
	jp PhoneTripShade

PhoneTripFadeOut:
; from the map to black
	ld c, 1
.fade
	push bc
	ld a, c
	call PhoneTripShade
	ld c, 4
	call DelayFrames
	pop bc
	inc c
	ld a, c
	cp 5 + 1 ; (31 >> 5 is 0)
	jr c, .fade
	ret

PhoneTripShade:
; The palettes on screen are the map's (wBGPals1 and wOBPals1), each color's
; red, green and blue halved a times.
	ld c, a
	ldh a, [rWBK]
	push af
	ld a, BANK(wBGPals1)
	ldh [rWBK], a
	ld hl, wBGPals1
	ld de, wBGPals2
	ld b, (wBGPals2 - wBGPals1) / PAL_COLOR_SIZE
.color
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	push bc
	ld b, c
	inc b
	jr .next

.halve
	ld a, [de]
	srl a
	ld [de], a
	dec de
	ld a, [de]
	rra
	and LOW(%0011110111101111)
	ld [de], a
	inc de
	ld a, [de]
	and HIGH(%0011110111101111)
	ld [de], a
.next
	dec b
	jr nz, .halve
	pop bc
	inc de
	dec b
	jr nz, .color
	pop af
	ldh [rWBK], a
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

INCLUDE "data/phone/trip_destinations.asm"
