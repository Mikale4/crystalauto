_DisappearUser:
	xor a
	ldh [hBGMapMode], a
	ldh a, [hBattleTurn]
	and a
	jr z, .player
	call GetEnemyFrontpicCoords
	jr .okay
.player
	call GetPlayerBackpicCoords
.okay
	call ClearBox
	jr FinishAppearDisappearUser

_AppearUserRaiseSub:
	farcall BattleCommand_RaiseSubNoAnim
	jr AppearUser

_AppearUserLowerSub:
	farcall BattleCommand_LowerSubNoAnim

AppearUser:
	xor a
	ldh [hBGMapMode], a
	ldh a, [hBattleTurn]
	and a
	jr z, .player
	call GetEnemyFrontpicCoords
	xor a
	jr .okay
.player
	call GetPlayerBackpicCoords
	ld a, $31
.okay
	ldh [hGraphicStartTile], a
	predef PlaceGraphic
FinishAppearDisappearUser:
	ld a, $1
	ldh [hBGMapMode], a
	ret

GetEnemyFrontpicCoords:
	hlcoord 12, 0
	lb bc, 7, 7
	ret

GetPlayerBackpicCoords:
	hlcoord 2, 6
	lb bc, 6, 6
	ret

DoWeatherModifiers:
; (then the terrain's: DoTerrainModifiers)
	call .Weather
	jp DoTerrainModifiers

.Weather:
	ld de, WeatherTypeModifiers
	ld a, [wBattleWeather]
	ld b, a
	ld a, [wCurType]
	ld c, a

.CheckWeatherType:
	ld a, [de]
	inc de
	cp -1
	jr z, .done_weather_types

	cp b
	jr nz, .NextWeatherType

	ld a, [de]
	cp c
	jr z, .ApplyModifier

.NextWeatherType:
	inc de
	inc de
	jr .CheckWeatherType

.done_weather_types
	ld de, WeatherMoveModifiers

	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	ld c, a

.CheckWeatherMove:
	ld a, [de]
	inc de
	cp -1
	ret z

	cp b
	jr nz, .NextWeatherMove

	ld a, [de]
	cp c
	jr z, .ApplyModifier

.NextWeatherMove:
	inc de
	inc de
	jr .CheckWeatherMove

.ApplyModifier:
	inc de
	ld a, [de]
	; fallthrough

ApplyDamageModifier:
; wCurDamage = wCurDamage * a / 10 (at least 1)
	ldh [hMultiplier], a
	xor a
	ldh [hMultiplicand + 0], a
	ld hl, wCurDamage
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hl]
	ldh [hMultiplicand + 2], a

	call Multiply

	ld a, 10
	ldh [hDivisor], a
	ld b, 4
	call Divide

	ldh a, [hQuotient + 1]
	and a
	ld bc, -1
	jr nz, .Update

	ldh a, [hQuotient + 2]
	ld b, a
	ldh a, [hQuotient + 3]
	ld c, a
	or b
	jr nz, .Update

	ld bc, 1

.Update:
	ld a, b
	ld [wCurDamage], a
	ld a, c
	ld [wCurDamage + 1], a

.done
	ret

INCLUDE "data/battle/weather_modifiers.asm"

DoTerrainModifiers:
; As in the latest games, but 1.5x: ELECTRIC, GRASSY and PSYCHIC TERRAIN power up
; their type's moves (TerrainType) from a POKéMON on the ground. MISTY TERRAIN
; halves DRAGON moves against a POKéMON on the ground, and GRASSY TERRAIN halves
; EARTHQUAKE and MAGNITUDE.
	ld a, [wBattleTerrain]
	and a
	ret z
	cp TERRAIN_MISTY
	jr z, .misty
	cp TERRAIN_GRASSY
	jr nz, .power_up
	ld a, BATTLE_VARS_MOVE_ANIM
	call GetBattleVar
	cpmove EARTHQUAKE
	jr z, .halve
	cpmove MAGNITUDE
	jr z, .halve
.power_up
	farcall TerrainType
	ld a, [wCurType]
	cp c
	ret nz
	farcall IsUserGrounded
	ret nz
	ld a, MORE_EFFECTIVE
	jp ApplyDamageModifier

.misty
	ld a, [wCurType]
	cp DRAGON
	ret nz
.halve
	farcall IsTargetGrounded
	ret nz
	ld a, NOT_VERY_EFFECTIVE
	jp ApplyDamageModifier

DoBadgeTypeBoosts:
	ld a, [wLinkMode]
	and a
	ret nz

	ld a, [wInBattleTowerBattle]
	and a
	ret nz

	ldh a, [hBattleTurn]
	and a
	ret nz

	push de
	push bc

	ld hl, BadgeTypeBoosts

	ld a, [wKantoBadges]
	ld b, a
	ld a, [wJohtoBadges]
	ld c, a

.CheckBadge:
	ld a, [hl]
	cp -1
	jr z, .done

	srl b
	rr c
	jr nc, .NextBadge

	ld a, [wCurType]
	cp [hl]
	jr z, .ApplyBoost

.NextBadge:
	inc hl
	jr .CheckBadge

.ApplyBoost:
	ld a, [wCurDamage]
	ld h, a
	ld d, a
	ld a, [wCurDamage + 1]
	ld l, a
	ld e, a

	srl d
	rr e
	srl d
	rr e
	srl d
	rr e

	ld a, e
	or d
	jr nz, .done_min
	ld e, 1

.done_min
	add hl, de
	jr nc, .Update

	ld hl, $ffff

.Update:
	ld a, h
	ld [wCurDamage], a
	ld a, l
	ld [wCurDamage + 1], a

.done
	pop bc
	pop de
	ret

INCLUDE "data/types/badge_type_boosts.asm"
