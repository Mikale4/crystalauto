; The battle info screen: START in battle (see BattleInfoButton) shows both sides'
; stat changes; LEFT or RIGHT, the effects on the field with their turns left;
; START or B closes it.

DEF BATTLE_INFO_FOOTER_ROW EQU SCREEN_HEIGHT - 2

; BattleInfoFieldEffects kinds
	const_def
	const BATTLE_INFO_TURNS  ; its turns left
	const BATTLE_INFO_LAYERS ; how many layers
	const BATTLE_INFO_NONE   ; nothing to count

BattleInfoScreen::
; (not while the Demo plays: START stops it)
	ld a, [wDemoState]
	cp DEMO_RUNNING
	jr z, .done
	ldh a, [hBGMapMode]
	push af
	call LoadStandardMenuHeader
	xor a
	ld [wBattleInfoPage], a
.draw
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	lb bc, SCREEN_HEIGHT - 2, SCREEN_WIDTH - 2
	call Textbox
	ld a, [wBattleInfoPage]
	and a
	jr nz, .field
	call BattleInfo_Stats
	jr .drawn

.field
	call BattleInfo_Field
.drawn
	call ApplyTilemap
.loop
	call DelayFrame
	call GetJoypad
	ldh a, [hJoyPressed]
	and PAD_START | PAD_B
	jr nz, .close
	ldh a, [hJoyPressed]
	and PAD_LEFT | PAD_RIGHT
	jr z, .loop
	ld hl, wBattleInfoPage
	ld a, [hl]
	xor 1
	ld [hl], a
	jr .draw

.close
	call CloseWindow
	pop af
	ldh [hBGMapMode], a
.done
; (the START that opened or closed it is done with)
	ld hl, hJoypadSum
	res B_PAD_START, [hl]
	ret

BattleInfo_Stats:
; each stat's level: "+2", "-1", or "0" as it was (BASE_STAT_LEVEL)
	hlcoord 1, 1
	ld de, .TitleText
	call PlaceString
	hlcoord 1, 3
	ld de, .YoursText
	call PlaceString
	hlcoord 8, 3
	ld de, wBattleMonNickname
	call PlaceString
	hlcoord 1, 4
	ld de, .FoeText
	call PlaceString
	hlcoord 8, 4
	ld de, wEnemyMonNickname
	call PlaceString
	hlcoord 10, 6
	ld de, .HeaderText
	call PlaceString
	hlcoord 1, 7
	ld de, .StatNames
	ld c, 0
.stat
	push bc
	push hl
	call PlaceString
	inc de ; (the next name)
	pop hl
	pop bc
	push de
	push hl
	ld de, 12
	add hl, de
	ld de, wPlayerStatLevels
	call .Level
	pop hl
	push hl
	ld de, 16
	add hl, de
	ld de, wEnemyStatLevels
	call .Level
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop de
	inc c
	ld a, c
	cp EVASION + 1
	jr c, .stat
	hlcoord 1, BATTLE_INFO_FOOTER_ROW
	ld de, .FooterText
	jp PlaceString

.Level:
; hl: where (two tiles); de: the stat levels; c: which
	ld a, e
	add c
	ld e, a
	jr nc, .got_level
	inc d
.got_level
	ld a, [de]
	sub BASE_STAT_LEVEL
	jr z, .as_it_was
	jr nc, .up
	cpl
	inc a
	ld [hl], "-"
	jr .digit

.up
	ld [hl], "+"
.digit
	inc hl
	add "0"
	ld [hl], a
	ret

.as_it_was
	inc hl
	ld [hl], "0"
	ret

.TitleText:
	db "STAT CHANGES@"
.YoursText:
	db "YOURS:@"
.FoeText:
	db "FOE:@"
.HeaderText:
	db "YOURS FOE@"
.FooterText:
	db "START:close →FIELD@"

.StatNames:
; in the order of wPlayerStatLevels
	db "ATTACK@"
	db "DEFENSE@"
	db "SPEED@"
	db "SPCL.ATK@"
	db "SPCL.DEF@"
	db "ACCURACY@"
	db "EVASION@"

BattleInfo_Field:
; the weather, then what's on each side (BattleInfoFieldEffects), with the turns
; each has left; as many as there's room for
	hlcoord 1, 1
	ld de, .TitleText
	call PlaceString
	hlcoord 14, 1
	ld de, .TurnsText
	call PlaceString
	hlcoord 1, BATTLE_INFO_FOOTER_ROW
	ld de, .FooterText
	call PlaceString
	hlcoord 1, 3
	ld a, [wBattleWeather]
	and a
	jr z, .no_weather
	dec a
	push hl
	ld e, a
	ld d, 0
	ld hl, .WeatherNames
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	push hl
	call PlaceString
	pop hl
	ld de, wWeatherCount
	call .Turns
	ld de, SCREEN_WIDTH
	add hl, de
; (whose stat it raises: see WeatherBoosts)
	ld bc, wBattleMon
	ld de, .YoursBoostText
	call .WeatherBoost
	ld bc, wEnemyMon
	ld de, .FoesBoostText
	call .WeatherBoost
	ld de, SCREEN_WIDTH
	add hl, de
.no_weather
	ld de, .YourSideText
	ld bc, BattleInfoFieldEffects.Player
	call .Side
	ld de, SCREEN_WIDTH
	add hl, de
	ld de, .FoeSideText
	ld bc, BattleInfoFieldEffects.Enemy
	; fallthrough

.Side:
; hl: the row; de: its heading; bc: its effects. hl: the row after.
	call .Room
	ret nc
	push bc
	push hl
	call PlaceString
	pop hl
	pop bc
	ld de, SCREEN_WIDTH
	add hl, de
	push hl ; (to see if anything's there)
.effect
	ld a, [bc]
	inc bc
	ld e, a
	ld a, [bc]
	inc bc
	ld d, a ; (where it's kept)
	inc a ; (-1: the end)
	jr z, .side_done
	ld a, [bc]
	inc bc
	and a
	jr z, .any
	push hl
	ld h, d
	ld l, e
	and [hl] ; (its bit)
	pop hl
	jr .got_effect

.any
	ld a, [de]
	and a
.got_effect
	jr nz, .on
.skip_entry
; (the rest of the entry)
	inc bc
	inc bc
	inc bc
	inc bc
	inc bc
	jr .effect

.on
	call .Room
	jr nc, .skip_entry
	ld a, [bc] ; (its kind)
	inc bc
	push af
	ld a, [bc]
	inc bc
	ld e, a
	ld a, [bc]
	inc bc
	ld d, a ; (its count)
	push de
	ld a, [bc]
	inc bc
	ld e, a
	ld a, [bc]
	inc bc
	ld d, a ; (its name)
	push bc
	push hl
	inc hl
	call PlaceString
	pop hl
	pop bc
	pop de
	pop af
	push bc
	cp BATTLE_INFO_LAYERS
	jr z, .layers
	cp BATTLE_INFO_NONE
	jr z, .next_effect
	call .Turns
	jr .next_effect

.layers
	push hl
	ld bc, 9
	add hl, bc
	ld [hl], "×"
	inc hl
	ld a, [de]
	add "0"
	ld [hl], a
	pop hl
.next_effect
	pop bc
	ld de, SCREEN_WIDTH
	add hl, de
	jr .effect

.side_done
; (nothing: say so)
	pop de
	ld a, e
	cp l
	ret nz
	ld a, d
	cp h
	ret nz
	call .Room
	ret nc
	push hl
	inc hl
	ld de, .NoneText
	call PlaceString
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	ret

.WeatherBoost:
; Each stat the weather raises for battle struct bc, said (de: the texts for SPEED,
; then for SPCL.DEF) a row each from row hl. hl: the row after.
	push bc
	push de
	push hl
	farcall WeatherRaisesSpeed
	pop hl
	pop de
	pop bc
	call c, .Say
.skip
	ld a, [de]
	inc de
	cp "@"
	jr nz, .skip
	push de
	push hl
	farcall WeatherRaisesSpclDef
	pop hl
	pop de
	ret nc
	; fallthrough

.Say:
	push de
	push hl
	inc hl
	call PlaceString
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	pop de
	ret

.Room:
; Return carry if row hl is above the footer.
	ld a, l
	sub LOW(wTilemap + BATTLE_INFO_FOOTER_ROW * SCREEN_WIDTH)
	ld a, h
	sbc HIGH(wTilemap + BATTLE_INFO_FOOTER_ROW * SCREEN_WIDTH)
	ret

.Turns:
; de: the turns left, at the end of row hl
	push hl
	push bc
	ld bc, 15
	add hl, bc
	lb bc, 1, 3
	call PrintNum
	pop bc
	pop hl
	ret

.TitleText:
	db "FIELD@"
.TurnsText:
	db "TURNS@"
.YourSideText:
	db "YOUR SIDE@"
.FoeSideText:
	db "FOE'S SIDE@"
.NoneText:
	db "none@"
.YoursBoostText:
	db "YOURS: SPEED +1@"
	db "YOURS: SP.DEF +1@"
.FoesBoostText:
	db "FOE'S: SPEED +1@"
	db "FOE'S: SP.DEF +1@"
.FooterText:
	db "START:close ←STATS@"

.WeatherNames:
; WEATHER_RAIN, WEATHER_SUN, WEATHER_SANDSTORM
	dw .RainText
	dw .SunText
	dw .SandstormText

.RainText:
	db "RAIN@"
.SunText:
	db "SUN@"
.SandstormText:
	db "SANDSTORM@"

MACRO battle_info_effect
; where it's kept, its bit (0: any but 0), its kind, its count, its name
	dw \1
	db \2, \3
	dw \4, \5
ENDM

BattleInfoFieldEffects:
.Player:
	battle_info_effect wPlayerScreens, 1 << SCREENS_REFLECT, BATTLE_INFO_TURNS, wPlayerReflectCount, .ReflectText
	battle_info_effect wPlayerScreens, 1 << SCREENS_LIGHT_SCREEN, BATTLE_INFO_TURNS, wPlayerLightScreenCount, .LightScreenText
	battle_info_effect wPlayerScreens, 1 << SCREENS_SAFEGUARD, BATTLE_INFO_TURNS, wPlayerSafeguardCount, .SafeguardText
	battle_info_effect wPlayerSubStatus4, 1 << SUBSTATUS_MIST, BATTLE_INFO_NONE, 0, .MistText
	battle_info_effect wPlayerSpikes, 0, BATTLE_INFO_LAYERS, wPlayerSpikes, .SpikesText
	battle_info_effect wEnemyFutureSightCount, 0, BATTLE_INFO_TURNS, wEnemyFutureSightCount, .FutureSightText ; (coming at this side)
	battle_info_effect wPlayerSubStatus1, 1 << SUBSTATUS_PERISH, BATTLE_INFO_TURNS, wPlayerPerishCount, .PerishSongText
	dw -1

.Enemy:
	battle_info_effect wEnemyScreens, 1 << SCREENS_REFLECT, BATTLE_INFO_TURNS, wEnemyReflectCount, .ReflectText
	battle_info_effect wEnemyScreens, 1 << SCREENS_LIGHT_SCREEN, BATTLE_INFO_TURNS, wEnemyLightScreenCount, .LightScreenText
	battle_info_effect wEnemyScreens, 1 << SCREENS_SAFEGUARD, BATTLE_INFO_TURNS, wEnemySafeguardCount, .SafeguardText
	battle_info_effect wEnemySubStatus4, 1 << SUBSTATUS_MIST, BATTLE_INFO_NONE, 0, .MistText
	battle_info_effect wEnemySpikes, 0, BATTLE_INFO_LAYERS, wEnemySpikes, .SpikesText
	battle_info_effect wPlayerFutureSightCount, 0, BATTLE_INFO_TURNS, wPlayerFutureSightCount, .FutureSightText
	battle_info_effect wEnemySubStatus1, 1 << SUBSTATUS_PERISH, BATTLE_INFO_TURNS, wEnemyPerishCount, .PerishSongText
	dw -1

.ReflectText:
	db "REFLECT@"
.LightScreenText:
	db "LIGHT SCREEN@"
.SafeguardText:
	db "SAFEGUARD@"
.MistText:
	db "MIST@"
.SpikesText:
	db "SPIKES@"
.FutureSightText:
	db "FUTURE SIGHT@"
.PerishSongText:
	db "PERISH SONG@"
