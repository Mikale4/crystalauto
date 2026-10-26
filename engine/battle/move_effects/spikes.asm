BattleCommand_Spikes:
; As in the latest games, the foe's side takes up to MAX_SPIKES layers (see
; SpikesFraction).
	ld hl, wEnemyScreens
	ld de, wEnemySpikes
	ldh a, [hBattleTurn]
	and a
	jr z, .got_screens
	ld hl, wPlayerScreens
	ld de, wPlayerSpikes
.got_screens

; Fails if there are as many layers as there can be.

	ld a, [de]
	cp MAX_SPIKES
	jr nc, .failed

	inc a
	ld [de], a
	set SCREENS_SPIKES, [hl]

	call AnimateCurrentMove

	ld hl, SpikesText
	jp StdBattleTextbox

.failed
	jp FailMove
