; As in the latest games, a POKéMON sent to the PC when the box out is full goes
; to the next box with room: that box becomes the box out (see SendMonIntoBox).

CheckRoomInBoxes::
; Return carry if there's no room in any box (before a first save, there's only
; the box out).
	ld a, BANK(sBoxCount)
	call OpenSRAM
	ld a, [sBoxCount]
	call CloseSRAM
	cp MONS_PER_BOX
	jr nc, .full
	and a
	ret

.full
	call NextBoxWithRoom
	ccf
	ret

CheckRoomForGiftMon::
; (callasm) wScriptVar: TRUE if a POKéMON given would have somewhere to go (the
; party, or a box)
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr c, .room
	call CheckRoomInBoxes
	ld a, FALSE
	jr c, .done
.room
	ld a, TRUE
.done
	ld [wScriptVar], a
	ret

MakeRoomInBoxOut::
; If the box out is full, make the next box with room the box out (the full one
; is put back where it belongs, as BILL's PC always did). Return carry if there's
; none.
	ld a, BANK(sBoxCount)
	call OpenSRAM
	ld a, [sBoxCount]
	call CloseSRAM
	cp MONS_PER_BOX
	ccf
	ret nc
	call NextBoxWithRoom
	ccf
	ret c
	ld e, a
; (SaveBox and LoadBox go through wBoxPartialData, where a battle keeps its own
; things: they're kept in WRAM bank 6 meanwhile)
	push de
	ld hl, wBoxPartialData
	ld bc, wDecompressScratch
	call .Copy
	pop de
	farcall MoveMonWOMail_SaveGame
	ld hl, wDecompressScratch
	ld bc, wBoxPartialData
	call .Copy
	and a
	ret

.Copy:
; wBoxPartialData's size from hl to bc, with WRAM bank 6 in
	ldh a, [rWBK]
	push af
	ld a, BANK(wDecompressScratch)
	ldh [rWBK], a
	ld d, b
	ld e, c
	ld bc, wBoxPartialDataEnd - wBoxPartialData
	call CopyBytes
	pop af
	ldh [rWBK], a
	ret

NextBoxWithRoom:
; Return carry, and a: the next box after the box out (0 to NUM_BOXES - 1, going
; round) that isn't full, if there's one.
	ld a, [wSavedAtLeastOnce]
	and a
	ret z ; (nc: the boxes aren't made yet)
	ld a, [wCurBox]
	ld c, NUM_BOXES - 1
.next
	inc a
	cp NUM_BOXES
	jr c, .got_box
	xor a
.got_box
	push af
	push bc
	inc a
	ld b, a
	farcall GetBoxPointer ; b: its bank, hl: it
	ld a, b
	call OpenSRAM
	ld a, [hl] ; (its count)
	call CloseSRAM
	pop bc
	cp MONS_PER_BOX
	jr c, .found
	pop af
	dec c
	jr nz, .next
	and a
	ret

.found
	pop af
	scf
	ret

GetCurBoxName::
; wStringBuffer2: the box out's name
	ld a, [wCurBox]
	ld hl, wBoxNames
	ld bc, BOX_NAME_LENGTH
	call AddNTimes
	ld de, wStringBuffer2
	ld bc, BOX_NAME_LENGTH
	jp CopyBytes
