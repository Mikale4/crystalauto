_GiveOddEgg:
	; Figure out which egg to give.

	; Compare a random word to probabilities out of $ffff.
	call Random
	ld hl, OddEggProbabilities
	ld c, 0
	ld b, c
.loop
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a

	; Break on $ffff.
	ld a, d
	cp HIGH($ffff)
	jr nz, .not_done
	ld a, e
	cp LOW($ffff)
	jr z, .done
.not_done

	; Break when the random word <= the next probability in de.
	ldh a, [hRandomSub]
	cp d
	jr c, .done
	jr z, .ok
	jr .next
.ok
	ldh a, [hRandomAdd]
	cp e
	jr c, .done
	jr z, .done
.next
	inc bc
	jr .loop
.done

	ld hl, OddEggs
	ld a, ODD_EGG_LENGTH
	call AddNTimes

	; Writes to wOddEgg and wOddEggName (the data has its species' and moves'
	; 16-bit indexes: the struct, their IDs)
	ld de, wOddEgg
	ld a, [hli]
	push hl
	ld h, [hl]
	ld l, a
	call GetPokemonIDFromIndex
	pop hl
	inc hl
	ld [de], a
	inc de
	ld bc, MON_MOVES - MON_ITEM
	call CopyBytes
	ld b, NUM_MOVES
.moves
	push bc
	ld a, [hli]
	ld c, a
	ld a, [hli]
	push hl
	ld h, a
	ld l, c
	call GetMoveIDFromIndex
	pop hl
	ld [de], a
	inc de
	pop bc
	dec b
	jr nz, .moves
	ld bc, NICKNAMED_MON_STRUCT_LENGTH - MON_MOVES - NUM_MOVES
	call CopyBytes

	ld a, EGG_TICKET
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantityChange], a
	ld a, -1
	ld [wCurItemQuantity], a
	ld hl, wNumItems
	call TossItem

	; load species in wMobileMonSpecies
	ld a, EGG
	ld [wMobileMonMiscSpecies], a

	; load pointer to (wMobileMonSpecies - 1) in wMobileMonSpeciesPointer
	ld a, LOW(wMobileMonMiscSpecies - 1)
	ld [wMobileMonSpeciesPointer], a
	ld a, HIGH(wMobileMonMiscSpecies - 1)
	ld [wMobileMonSpeciesPointer + 1], a
	; load pointer to wOddEgg in wMobileMonStructPointer
	ld a, LOW(wOddEgg)
	ld [wMobileMonStructPointer], a
	ld a, HIGH(wOddEgg)
	ld [wMobileMonStructPointer + 1], a

	; load Odd Egg Name in wTempOddEggNickname
	ld hl, .Odd
	ld de, wTempOddEggNickname
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	; load pointer to wTempOddEggNickname in wMobileMonOTPointer
	ld a, LOW(wTempOddEggNickname)
	ld [wMobileMonOTPointer], a
	ld a, HIGH(wTempOddEggNickname)
	ld [wMobileMonOTPointer + 1], a
	; load pointer to wOddEggName in wMobileMonNicknamePointer
	ld a, LOW(wOddEggName)
	ld [wMobileMonNicknamePointer], a
	ld a, HIGH(wOddEggName)
	ld [wMobileMonNicknamePointer + 1], a
	farcall AddMobileMonToParty
	ret

.Odd:
	dname "ODD", MON_NAME_LENGTH + 1

INCLUDE "data/events/odd_eggs.asm"
