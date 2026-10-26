AI_Redundant:
; Check if move effect c will fail because it's already been used.
; Return z if the move is a good choice.
; Return nz if the move is a bad choice.
	ld a, c
	ld de, 3
	ld hl, .Moves
	call IsInArray
	jp nc, .NotRedundant
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Moves:
	dbw EFFECT_HEAL,         .Heal
	dbw EFFECT_LIGHT_SCREEN, .LightScreen
	dbw EFFECT_MIST,         .Mist
	dbw EFFECT_FOCUS_ENERGY, .FocusEnergy
	dbw EFFECT_CONFUSE,      .Confuse
	dbw EFFECT_TRANSFORM,    .Transform
	dbw EFFECT_REFLECT,      .Reflect
	dbw EFFECT_SUBSTITUTE,   .Substitute
	dbw EFFECT_LEECH_SEED,   .LeechSeed
	dbw EFFECT_DISABLE,      .Disable
	dbw EFFECT_ENCORE,       .Encore
	dbw EFFECT_SNORE,        .Snore
	dbw EFFECT_SLEEP_TALK,   .SleepTalk
	dbw EFFECT_MEAN_LOOK,    .MeanLook
	dbw EFFECT_NIGHTMARE,    .Nightmare
	dbw EFFECT_SPIKES,       .Spikes
	dbw EFFECT_FORESIGHT,    .Foresight
	dbw EFFECT_PERISH_SONG,  .PerishSong
	dbw EFFECT_SANDSTORM,    .Sandstorm
	dbw EFFECT_ATTRACT,      .Attract
	dbw EFFECT_SAFEGUARD,    .Safeguard
	dbw EFFECT_RAIN_DANCE,   .RainDance
	dbw EFFECT_SUNNY_DAY,    .SunnyDay
	dbw EFFECT_TELEPORT,     .Teleport
	dbw EFFECT_MORNING_SUN,  .MorningSun
	dbw EFFECT_SYNTHESIS,    .Synthesis
	dbw EFFECT_MOONLIGHT,    .Moonlight
	dbw EFFECT_SWAGGER,      .Swagger
	dbw EFFECT_FUTURE_SIGHT, .FutureSight
	dbw EFFECT_HAIL,         .Hail
	dbw EFFECT_TERRAIN,      .Terrain
	db -1

.LightScreen:
	ld a, [wEnemyScreens]
	bit SCREENS_LIGHT_SCREEN, a
	ret

.Mist:
	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_MIST, a
	ret

.FocusEnergy:
	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_FOCUS_ENERGY, a
	ret

.Confuse:
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_CONFUSED, a
	ret nz
	ld a, [wPlayerScreens]
	bit SCREENS_SAFEGUARD, a
	ret nz
	ld b, 0 ; (the player's side; MISTY TERRAIN: see TerrainProtectsSide)
	farcall TerrainProtectsSide
	ret

.Transform:
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_TRANSFORMED, a
	ret

.Reflect:
	ld a, [wEnemyScreens]
	bit SCREENS_REFLECT, a
	ret

.Substitute:
	ld a, [wEnemySubStatus4]
	bit SUBSTATUS_SUBSTITUTE, a
	ret

.LeechSeed:
	ld a, [wPlayerSubStatus4]
	bit SUBSTATUS_LEECH_SEED, a
	ret

.Disable:
	ld a, [wPlayerDisableCount]
	and a
	ret

.Encore:
	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_ENCORED, a
	ret

.Snore:
.SleepTalk:
	ld a, [wEnemyMonStatus]
	and SLP_MASK
	jr z, .Redundant
	jr .NotRedundant

.MeanLook:
	ld a, [wEnemySubStatus5]
	bit SUBSTATUS_CANT_RUN, a
	ret

.Nightmare:
; BUG: AI does not discourage Nightmare if the player has any status condition (see docs/bugs_and_glitches.md)
	ld a, [wBattleMonStatus]
	and a
	jr z, .Redundant
	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_NIGHTMARE, a
	ret

.Spikes:
; (as many layers as there can be)
	ld a, [wPlayerSpikes]
	cp MAX_SPIKES
	jr nc, .Redundant
	xor a
	ret

.Foresight:
	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_IDENTIFIED, a
	ret

.PerishSong:
	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_PERISH, a
	ret

.Sandstorm:
	ld a, [wBattleWeather]
	cp WEATHER_SANDSTORM
	jr z, .Redundant
	jr .NotRedundant

.Attract:
; (whatever their genders)
	ld a, [wPlayerSubStatus1]
	bit SUBSTATUS_IN_LOVE, a
	ret

.Safeguard:
	ld a, [wEnemyScreens]
	bit SCREENS_SAFEGUARD, a
	ret

.RainDance:
	ld a, [wBattleWeather]
	cp WEATHER_RAIN
	jr z, .Redundant
	jr .NotRedundant

.SunnyDay:
	ld a, [wBattleWeather]
	cp WEATHER_SUN
	jr z, .Redundant
	jr .NotRedundant

.Swagger:
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_CONFUSED, a
	ret nz
	ld b, 0 ; (the player's side; MISTY TERRAIN: see TerrainProtectsSide)
	ld c, EFFECT_CONFUSE
	farcall TerrainProtectsSide
	ret

.FutureSight:
; BUG: AI does not discourage Future Sight when it's already been used (see docs/bugs_and_glitches.md)
	ld a, [wEnemyScreens]
	bit SCREENS_UNUSED, a
	ret

.Heal:
.MorningSun:
.Synthesis:
.Moonlight:
	farcall AICheckEnemyMaxHP
	jr nc, .NotRedundant

.Teleport:
.Redundant:
	ld a, 1
	and a
	ret

.NotRedundant:
	xor a
	ret

.Hail:
	ld a, [wBattleWeather]
	cp WEATHER_HAIL
	jr z, .Redundant
	jr .NotRedundant

.Terrain:
; (the one that's up already: see TypeTerrain)
	ld a, [wEnemyMoveStruct + MOVE_TYPE]
	and TYPE_MASK
	ld b, a
	farcall AITypeTerrain
	ld a, [wBattleTerrain]
	cp c
	jr z, .Redundant
	jr .NotRedundant
