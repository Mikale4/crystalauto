BattleCommand_Safeguard:
; (once a battle for each side, as REFLECT and LIGHT SCREEN: wPlayerScreensUsed)
	ld hl, wPlayerScreens
	ld de, wPlayerSafeguardCount
	ld bc, wPlayerScreensUsed
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyScreens
	ld de, wEnemySafeguardCount
	ld bc, wEnemyScreensUsed
.ok
	bit SCREENS_SAFEGUARD, [hl]
	jr nz, .failed
	ld a, [bc]
	bit SCREENS_SAFEGUARD, a
	jr nz, .failed
	set SCREENS_SAFEGUARD, a
	ld [bc], a
	set SCREENS_SAFEGUARD, [hl]
	ld a, 5
	ld [de], a
	call AnimateCurrentMove
	ld hl, CoveredByVeilText
	jp StdBattleTextbox

.failed
	call AnimateFailedMove
	jp PrintButItFailed
