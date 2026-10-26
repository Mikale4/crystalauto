LoadWildMonData:
	call _GrassWildmonLookup
	jr c, .copy
	ld hl, wMornEncounterRate
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	jr .done_copy

.copy
	inc hl
	inc hl
	ld de, wMornEncounterRate
	ld bc, 3
	call CopyBytes
.done_copy
	call _WaterWildmonLookup
	ld a, 0
	jr nc, .no_copy
	inc hl
	inc hl
	ld a, [hl]
.no_copy
	ld [wWaterEncounterRate], a
	ret

FindNest:
; Parameters:
; e: 0 = Johto, 1 = Kanto
; wNamedObjectIndex: species
	hlcoord 0, 0
	ld bc, SCREEN_AREA
	xor a
	call ByteFill
	ld a, [wNamedObjectIndex]
	call GetPokemonIndexFromID
	ld b, h
	ld c, l ; (the species' index, for .SearchMapForMon)
	call .TargetRank
	ld a, e
	and a
	jr nz, .kanto
	decoord 0, 0
	ld hl, JohtoGrassWildMons
	call .FindGrass
	ld hl, JohtoWaterWildMons
	call .FindWater
	call .RoamMon1
	call .RoamMon2
	ret

.kanto
	decoord 0, 0
	ld hl, KantoGrassWildMons
	call .FindGrass
	ld hl, KantoWaterWildMons
	jp .FindWater

.FindGrass:
	ld a, [hl]
	cp -1
	ret z
	push bc
	push hl
	ld a, [hli]
	ldh [hMathBuffer], a ; (the map, while bc is the species)
	ld a, [hli]
	ldh [hMathBuffer + 1], a
	inc hl
	inc hl
	inc hl
	xor a ; (the morning's first slot)
	ldh [hRandomizerSlot], a
	ld a, NUM_GRASSMON * 3
	call .SearchMapForMon
	jr nc, .next_grass
	ld [de], a
	inc de

.next_grass
	pop hl
	ld bc, GRASS_WILDDATA_LENGTH
	add hl, bc
	pop bc
	jr .FindGrass

.FindWater:
	ld a, [hl]
	cp -1
	ret z
	push bc
	push hl
	ld a, [hli]
	ldh [hMathBuffer], a
	ld a, [hli]
	ldh [hMathBuffer + 1], a
	inc hl
	ld a, WILDSLOT_WATER
	ldh [hRandomizerSlot], a
	ld a, NUM_WATERMON
	call .SearchMapForMon
	jr nc, .next_water
	ld [de], a
	inc de

.next_water
	pop hl
	ld bc, WATER_WILDDATA_LENGTH
	add hl, bc
	pop bc
	jr .FindWater

.SearchMapForMon:
; (species index bc, in a of hl's wild Pokémon, the first in slot
; hRandomizerSlot of the map in hMathBuffer)
	inc hl
.ScanMapLoop:
	push af
	push de ; (the nests found)
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call .Randomized
	ld a, e
	cp c
	jr nz, .next_mon
	ld a, d
	cp b
	jr nz, .next_mon
	pop de
	jr .found

.next_mon
	pop de
	ldh a, [hRandomizerSlot]
	inc a
	ldh [hRandomizerSlot], a
	inc hl
	pop af
	dec a
	jr nz, .ScanMapLoop
	and a
	ret

.TargetRank:
; RANDOMIZER mode: hMathBuffer + 2: species bc's place in RandomizerPool
	ld a, [wRandomizer]
	bit RANDOMIZER_ON_F, a
	ret z
	push bc
	push de
	ld d, b
	ld e, c
	farcall RandomizerRank
	ld a, e
	ldh [hMathBuffer + 2], a
	ld a, d
	ldh [hMathBuffer + 3], a
	pop de
	pop bc
	ret

.Randomized:
; de: what wild Pokémon de is in RANDOMIZER mode, or 0 if it can't be species
; bc: only one about as strong can (see SimilarSpecies), which saves time.
	ld a, [wRandomizer]
	bit RANDOMIZER_ON_F, a
	ret z
	push bc
	push hl
	push de
	farcall RandomizerRank
	ldh a, [hMathBuffer + 2]
	sub e
	ld l, a
	ldh a, [hMathBuffer + 3]
	sbc d
	ld h, a
	jr nc, .got_distance
	ld a, l
	cpl
	ld l, a
	ld a, h
	cpl
	ld h, a
	inc hl
.got_distance
	pop de
	ld a, h
	and a
	jr nz, .too_far
	ld a, l
	cp 2 * RANDOMIZER_WINDOW + 1
	jr nc, .too_far
	call RandomizeWildmonInMap
	pop hl
	pop bc
	ret

.too_far
	ld de, 0
	pop hl
	pop bc
	ret

.found
	pop af
	ldh a, [hMathBuffer]
	ld b, a
	ldh a, [hMathBuffer + 1]
	ld c, a
	jp .AppendNest

.AppendNest:
	push de
	call GetWorldMapLocation
	ld c, a
	hlcoord 0, 0
	ld de, SCREEN_AREA
.AppendNestLoop:
	ld a, [hli]
	cp c
	jr z, .found_nest
	dec de
	ld a, e
	or d
	jr nz, .AppendNestLoop
	ld a, c
	pop de
	scf
	ret

.found_nest
	pop de
	and a
	ret

.RoamMon1:
	ld a, [wRoamMon1Species]
	ld b, a
	ld a, [wNamedObjectIndex]
	cp b
	ret nz
	ld a, [wRoamMon1MapGroup]
	ld b, a
	ld a, [wRoamMon1MapNumber]
	ld c, a
	call .AppendNest
	ret nc
	ld [de], a
	inc de
	ret

.RoamMon2:
	ld a, [wRoamMon2Species]
	ld b, a
	ld a, [wNamedObjectIndex]
	cp b
	ret nz
	ld a, [wRoamMon2MapGroup]
	ld b, a
	ld a, [wRoamMon2MapNumber]
	ld c, a
	call .AppendNest
	ret nc
	ld [de], a
	inc de
	ret

TryWildEncounter::
; Try to trigger a wild encounter.
	call .EncounterRate
	jr nc, .no_battle
	call ChooseWildEncounter
	jr nz, .no_battle
	call CheckRepelEffect
	jr nc, .no_battle
	xor a
	ret

.no_battle
	xor a ; BATTLETYPE_NORMAL
	ld [wTempWildMonSpecies], a
	ld [wBattleType], a
	ld a, 1
	and a
	ret

.EncounterRate:
	call GetMapEncounterRate
	call ApplyMusicEffectOnEncounterRate
	call ApplyCleanseTagEffectOnEncounterRate
	call Random
	cp b
	ret

GetMapEncounterRate:
	ld hl, wMornEncounterRate
	call CheckOnWater
	ld a, wWaterEncounterRate - wMornEncounterRate
	jr z, .ok
	ld a, [wTimeOfDay]
.ok
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	ret

ApplyMusicEffectOnEncounterRate::
; Pokemon March and Ruins of Alph signal double encounter rate.
; Pokemon Lullaby halves encounter rate.
	ld a, [wMapMusic]
	cp MUSIC_POKEMON_MARCH
	jr z, .double
	cp MUSIC_RUINS_OF_ALPH_RADIO
	jr z, .double
	cp MUSIC_POKEMON_LULLABY
	ret nz
	srl b
	ret

.double
	sla b
	ret

ApplyCleanseTagEffectOnEncounterRate::
; Cleanse Tag halves encounter rate.
	ld hl, wPartyMon1Item
	ld de, PARTYMON_STRUCT_LENGTH
	ld a, [wPartyCount]
	ld c, a
.loop
	ld a, [hl]
	cp CLEANSE_TAG
	jr z, .cleansetag
	add hl, de
	dec c
	jr nz, .loop
	ret

.cleansetag
	srl b
	ret

ChooseWildEncounter:
	call LoadWildMonDataPointer
	jp nc, .nowildbattle
	call CheckEncounterRoamMon
	jp c, .startwildbattle

	inc hl
	inc hl
	inc hl
	call CheckOnWater
	ld de, WaterMonProbTable
	jr z, .watermon
	inc hl
	inc hl
	ld a, [wTimeOfDay]
	ld bc, NUM_GRASSMON * WILDMON_LENGTH
	call AddNTimes
	ld de, GrassMonProbTable

.watermon
; hl contains the pointer to the wild mon data, let's save that to the stack
	push hl
.randomloop
	call Random
	cp 100
	jr nc, .randomloop
	inc a ; 1 <= a <= 100
	ld b, a
	ld h, d
	ld l, e
; This next loop chooses which mon to load up.
.prob_bracket_loop
	ld a, [hli]
	cp b
	jr nc, .got_it
	inc hl
	jr .prob_bracket_loop

.got_it
	ld c, [hl]
	ld b, 0
	pop hl
	add hl, bc ; this selects our mon
	ld a, [hli]
	ld b, a
; If the Pokemon is encountered by surfing, we need to give the levels some variety.
	call CheckOnWater
	jr nz, .ok
; Check if we buff the wild mon, and by how much.
	call Random
	cp 35 percent
	jr c, .ok
	inc b
	cp 65 percent
	jr c, .ok
	inc b
	cp 85 percent
	jr c, .ok
	inc b
	cp 95 percent
	jr c, .ok
	inc b
; Store the level
.ok
	ld a, b
	ld [wCurPartyLevel], a
	ld a, [hli]
	ld h, [hl]
	ld l, a ; (the species' index)
	call ValidateTempWildMonSpecies
	jr c, .nowildbattle
	call .Randomize

	call GetPokemonIDFromIndex
	cpmon UNOWN
	jr nz, .done

	push af
	ld a, [wUnlockedUnowns]
	and a
	jr z, .nowildbattle_pop
	pop af

.done
	jr .loadwildmon

.nowildbattle_pop
	pop af
.nowildbattle
	ld a, 1
	and a
	ret

.loadwildmon
	ld [wTempWildMonSpecies], a

.startwildbattle
	xor a
	ret

.Randomize:
; hl: what it is in RANDOMIZER mode (c: its slot's offset in the table). Its
; slot: the time of day x NUM_GRASSMON + the slot, or WILDSLOT_WATER + the slot.
	push hl
	call CheckOnWater
	ld a, WILDSLOT_WATER
	jr z, .got_slot_base
	assert NUM_GRASSMON == 7
	ld a, [wTimeOfDay]
	ld e, a
	add a
	add a
	add a
	sub e
.got_slot_base
	ld e, a
	ld a, c
.slot_loop
	sub WILDMON_LENGTH
	jr c, .got_slot
	inc e
	jr .slot_loop

.got_slot
	ld a, e
	pop hl
	; fallthrough

RandomizeWildmonHere:
; hl: what the wild Pokémon hl (its index) in slot a of the player's map is in
; RANDOMIZER mode (see RandomizeWildIndex)
	ldh [hRandomizerSlot], a
	push bc
	push de
	ld d, h
	ld e, l
	farcall RandomizeWildIndexHere
	ld h, d
	ld l, e
	pop de
	pop bc
	ret

RandomizeWildmonInMap:
; de: what the wild Pokémon de (its index) in slot hRandomizerSlot of the map in
; hMathBuffer (its group and number) is in RANDOMIZER mode
	push bc
	push hl
	ldh a, [hMathBuffer]
	ld b, a
	ldh a, [hMathBuffer + 1]
	ld c, a
	farcall RandomizeWildIndex
	pop hl
	pop bc
	ret

INCLUDE "data/wild/probabilities.asm"

CheckRepelEffect::
; If there is no active Repel, there's no need to be here.
	ld a, [wRepelEffect]
	and a
	jr z, .encounter
; Get the first Pokemon in your party that isn't fainted.
	ld hl, wPartyMon1HP
	ld bc, PARTYMON_STRUCT_LENGTH - 1
.loop
	ld a, [hli]
	or [hl]
	jr nz, .ok
	add hl, bc
	jr .loop

.ok
; to PartyMonLevel
rept 4
	dec hl
endr

	ld a, [wCurPartyLevel]
	cp [hl]
	jr nc, .encounter
	and a
	ret

.encounter
	scf
	ret

LoadWildMonDataPointer:
	call CheckOnWater
	jr z, _WaterWildmonLookup

_GrassWildmonLookup:
	ld hl, SwarmGrassWildMons
	ld bc, GRASS_WILDDATA_LENGTH
	call _SwarmWildmonCheck
	ret c
	ld hl, JohtoGrassWildMons
	ld de, KantoGrassWildMons
	call _JohtoWildmonCheck
	ld bc, GRASS_WILDDATA_LENGTH
	jr _NormalWildmonOK

_WaterWildmonLookup:
	ld hl, SwarmWaterWildMons
	ld bc, WATER_WILDDATA_LENGTH
	call _SwarmWildmonCheck
	ret c
	ld hl, JohtoWaterWildMons
	ld de, KantoWaterWildMons
	call _JohtoWildmonCheck
	ld bc, WATER_WILDDATA_LENGTH
	jr _NormalWildmonOK

_JohtoWildmonCheck:
	call IsInJohto
	and a
	ret z
	ld h, d
	ld l, e
	ret

_SwarmWildmonCheck:
	call CopyCurrMapDE
	push hl
	ld hl, wSwarmFlags
	bit SWARMFLAGS_DUNSPARCE_SWARM_F, [hl]
	pop hl
	jr z, .CheckYanma
	ld a, [wDunsparceMapGroup]
	cp d
	jr nz, .CheckYanma
	ld a, [wDunsparceMapNumber]
	cp e
	jr nz, .CheckYanma
	call LookUpWildmonsForMapDE
	jr nc, .noSwarm
	scf
	ret

.CheckYanma:
	push hl
	ld hl, wSwarmFlags
	bit SWARMFLAGS_YANMA_SWARM_F, [hl]
	pop hl
	jr z, .noSwarm
	ld a, [wYanmaMapGroup]
	cp d
	jr nz, .noSwarm
	ld a, [wYanmaMapNumber]
	cp e
	jr nz, .noSwarm
	call LookUpWildmonsForMapDE
	jr nc, .noSwarm
	scf
	ret

.noSwarm:
	and a
	ret

_NormalWildmonOK:
	call CopyCurrMapDE
	jr LookUpWildmonsForMapDE

CopyCurrMapDE:
	ld a, [wMapGroup]
	ld d, a
	ld a, [wMapNumber]
	ld e, a
	ret

LookUpWildmonsForMapDE:
.loop
	push hl
	ld a, [hl]
	inc a
	jr z, .nope
	ld a, d
	cp [hl]
	jr nz, .next
	inc hl
	ld a, e
	cp [hl]
	jr z, .yup

.next
	pop hl
	add hl, bc
	jr .loop

.nope
	pop hl
	and a
	ret

.yup
	pop hl
	scf
	ret

InitRoamMons:
; RAIKOU and ENTEI don't roam any more: they wait in the BURNED TOWER (see
; maps/BurnedTowerB1F.asm). Continuing a game saved while they roamed calls
; this too, to stop them.
	xor a
	ld [wRoamMon1Species], a
	ld [wRoamMon2Species], a
	ld [wRoamMon1HP], a
	ld [wRoamMon2HP], a
	ld a, GROUP_N_A
	ld [wRoamMon1MapGroup], a
	ld [wRoamMon2MapGroup], a
	ld a, MAP_N_A
	ld [wRoamMon1MapNumber], a
	ld [wRoamMon2MapNumber], a
	ret

CheckEncounterRoamMon:
	push hl
; Don't trigger an encounter if we're on water.
	call CheckOnWater
	jr z, .DontEncounterRoamMon
; Load the current map group and number to de
	call CopyCurrMapDE
; Randomly select a beast.
	call Random
	cp 100 ; 25/64 chance
	jr nc, .DontEncounterRoamMon
	and %00000011 ; Of that, a 3/4 chance.  Running total: 75/256, or around 29.3%.
	jr z, .DontEncounterRoamMon
	dec a ; 1/3 chance that it's Entei, 1/3 chance that it's Raikou
; Compare its current location with yours
	ld hl, wRoamMon1MapGroup
	ld c, a
	ld b, 0
	ld a, 7 ; length of the roam_struct
	call AddNTimes
	ld a, d
	cp [hl]
	jr nz, .DontEncounterRoamMon
	inc hl
	ld a, e
	cp [hl]
	jr nz, .DontEncounterRoamMon
; We've decided to take on a beast, so stage its information for battle.
	dec hl
	dec hl
	dec hl
	ld a, [hli]
	ld [wTempWildMonSpecies], a
	ld a, [hl]
	ld [wCurPartyLevel], a
	ld a, BATTLETYPE_ROAMING
	ld [wBattleType], a

	pop hl
	scf
	ret

.DontEncounterRoamMon:
	pop hl
	and a
	ret

UpdateRoamMons:
	ld a, [wRoamMon1MapGroup]
	cp GROUP_N_A
	jr z, .SkipRaikou
	ld b, a
	ld a, [wRoamMon1MapNumber]
	ld c, a
	call .Update
	ld a, b
	ld [wRoamMon1MapGroup], a
	ld a, c
	ld [wRoamMon1MapNumber], a

.SkipRaikou:
	ld a, [wRoamMon2MapGroup]
	cp GROUP_N_A
	jr z, .SkipEntei
	ld b, a
	ld a, [wRoamMon2MapNumber]
	ld c, a
	call .Update
	ld a, b
	ld [wRoamMon2MapGroup], a
	ld a, c
	ld [wRoamMon2MapNumber], a

.SkipEntei:
	ld a, [wRoamMon3MapGroup]
	cp GROUP_N_A
	jr z, .Finished
	ld b, a
	ld a, [wRoamMon3MapNumber]
	ld c, a
	call .Update
	ld a, b
	ld [wRoamMon3MapGroup], a
	ld a, c
	ld [wRoamMon3MapNumber], a

.Finished:
	jp _BackUpMapIndices

.Update:
	ld hl, RoamMaps
.loop
; Are we at the end of the table?
	ld a, [hl]
	cp -1
	ret z
; Is this the correct entry?
	ld a, b
	cp [hl]
	jr nz, .next
	inc hl
	ld a, c
	cp [hl]
	jr z, .yes
; We don't have the correct entry yet, so let's continue.  A 0 terminates each entry.
.next
	ld a, [hli]
	and a
	jr nz, .next
	jr .loop

; We have the correct entry now, so let's choose a random map from it.
.yes
	inc hl
	ld d, h
	ld e, l
.update_loop
	ld h, d
	ld l, e
; Choose which map to warp to.
	call Random
	and %00011111 ; 1/8n chance it moves to a completely random map, where n is the number of roaming connections from the current map.
	jr z, JumpRoamMon
	and %11
	cp [hl]
	jr nc, .update_loop ; invalid index, try again
	inc hl
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [wRoamMons_LastMapGroup]
	cp [hl]
	jr nz, .done
	inc hl
	ld a, [wRoamMons_LastMapNumber]
	cp [hl]
	jr z, .update_loop
	dec hl

.done
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ret

JumpRoamMons:
	ld a, [wRoamMon1MapGroup]
	cp GROUP_N_A
	jr z, .SkipRaikou
	call JumpRoamMon
	ld a, b
	ld [wRoamMon1MapGroup], a
	ld a, c
	ld [wRoamMon1MapNumber], a

.SkipRaikou:
	ld a, [wRoamMon2MapGroup]
	cp GROUP_N_A
	jr z, .SkipEntei
	call JumpRoamMon
	ld a, b
	ld [wRoamMon2MapGroup], a
	ld a, c
	ld [wRoamMon2MapNumber], a

.SkipEntei:
	ld a, [wRoamMon3MapGroup]
	cp GROUP_N_A
	jr z, .Finished
	call JumpRoamMon
	ld a, b
	ld [wRoamMon3MapGroup], a
	ld a, c
	ld [wRoamMon3MapNumber], a

.Finished:
	jp _BackUpMapIndices

JumpRoamMon:
.loop
	ld hl, RoamMaps
.innerloop1
	; 0-15 are all valid indexes into RoamMaps,
	; so this retry loop is unnecessary
	; since NUM_ROAMMON_MAPS happens to be 16
	call Random
	maskbits NUM_ROAMMON_MAPS
	cp NUM_ROAMMON_MAPS
	jr nc, .innerloop1
	inc a
	ld b, a
.innerloop2 ; Loop to get hl to the address of the chosen roam map.
	dec b
	jr z, .ok
.innerloop3 ; Loop to skip the current roam map, which is terminated by a 0.
	ld a, [hli]
	and a
	jr nz, .innerloop3
	jr .innerloop2
; Check to see if the selected map is the one the player is currently in.  If so, try again.
.ok
	ld a, [wMapGroup]
	cp [hl]
	jr nz, .done
	inc hl
	ld a, [wMapNumber]
	cp [hl]
	jr z, .loop
	dec hl
; Return the map group and number in bc.
.done
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ret

_BackUpMapIndices:
	ld a, [wRoamMons_CurMapNumber]
	ld [wRoamMons_LastMapNumber], a
	ld a, [wRoamMons_CurMapGroup]
	ld [wRoamMons_LastMapGroup], a
	ld a, [wMapNumber]
	ld [wRoamMons_CurMapNumber], a
	ld a, [wMapGroup]
	ld [wRoamMons_CurMapGroup], a
	ret

INCLUDE "data/wild/roammon_maps.asm"

ValidateTempWildMonSpecies:
; carry unless hl is a species' index (1 to NUM_POKEMON)
	ld a, h
	or l
	jr z, .nowildmon
	ld a, l
	sub LOW(NUM_POKEMON + 1)
	ld a, h
	sbc HIGH(NUM_POKEMON + 1)
	ccf
	ret

.nowildmon
	scf
	ret

; Finds a rare wild Pokemon in the route of the trainer calling, then checks if it's been Seen already.
; The trainer will then tell you about the Pokemon if you haven't seen it.
RandomUnseenWildMon:
	farcall GetCallerLocation
	ld d, b
	ld e, c
	ld hl, JohtoGrassWildMons
	ld bc, GRASS_WILDDATA_LENGTH
	call LookUpWildmonsForMapDE
	jr c, .GetGrassmon
	ld hl, KantoGrassWildMons
	call LookUpWildmonsForMapDE
	jr nc, .done

.GetGrassmon:
; (fixed: for the time of day, not always the morning)
	ld a, [hli]
	ldh [hMathBuffer], a ; (the map, for RANDOMIZER mode)
	ld a, [hld]
	ldh [hMathBuffer + 1], a
	ld bc, 5 ; past the map and the encounter rates
	add hl, bc
	ld a, [wTimeOfDay]
	ld bc, NUM_GRASSMON * WILDMON_LENGTH
	call AddNTimes
	push hl
	ld bc, 4 * WILDMON_LENGTH + 1 ; the 5th wild Pokemon's species
	add hl, bc
.randloop1
	call Random
	and %11
	jr z, .randloop1
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
; We now have the pointer to one of the last (rarest) three wild Pokemon found in that area.
	ld a, c
	add 4 ; (its slot)
	call SetPhoneWildmonSlot
	ld a, [hli]
	ld d, [hl]
	ld e, a ; Contains the species index of this rare Pokemon
	pop hl
	inc hl ; Species index of the most common Pokemon on that route
	ld b, 4
.loop2
	ld a, [hli]
	cp e ; Compare this most common Pokemon with the rare one stored in de.
	ld a, [hli]
	jr nz, .next
	cp d
	jr z, .done
.next
	inc hl
	dec b
	jr nz, .loop2
; This Pokemon truly is rare.
	call RandomizeWildmonInMap
	push de
	call CheckSeenMonIndex
	pop hl
	jr nz, .done
; Since we haven't seen it, have the caller tell us about it.
	push hl
	ld de, wStringBuffer1
	call CopyName1
	pop hl
	call GetPokemonIDFromIndex
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, .JustSawSomeRareMonText
	call PrintText
	xor a
	ld [wScriptVar], a
	ret

.done
	ld a, $1
	ld [wScriptVar], a
	ret

.JustSawSomeRareMonText:
	text_far _JustSawSomeRareMonText
	text_end

RandomPhoneWildMon:
	farcall GetCallerLocation
	ld d, b
	ld e, c
	ld hl, JohtoGrassWildMons
	ld bc, GRASS_WILDDATA_LENGTH
	call LookUpWildmonsForMapDE
	jr c, .ok
	ld hl, KantoGrassWildMons
	call LookUpWildmonsForMapDE

.ok
	ld a, [hli]
	ldh [hMathBuffer], a ; (the map, for RANDOMIZER mode)
	ld a, [hld]
	ldh [hMathBuffer + 1], a
	ld bc, 5 + 0 * WILDMON_LENGTH
	add hl, bc
	ld a, [wTimeOfDay]
	inc a
	ld bc, NUM_GRASSMON * WILDMON_LENGTH
.loop
	dec a
	jr z, .done
	add hl, bc
	jr .loop

.done
	call Random
	and %11
	ld c, a
	call SetPhoneWildmonSlot
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	inc hl
	ld a, [hli]
	ld d, [hl]
	ld e, a
	call RandomizeWildmonInMap
	ld h, d
	ld l, e
	call GetPokemonIDFromIndex
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wStringBuffer4
	ld bc, MON_NAME_LENGTH
	jp CopyBytes

SetPhoneWildmonSlot:
; hRandomizerSlot: grass slot a at this time of day
	push bc
	ld b, a
	ld a, [wTimeOfDay]
	ld c, a
	add a
	add a
	add a
	sub c ; x NUM_GRASSMON
	add b
	ldh [hRandomizerSlot], a
	pop bc
	ret

RandomPhoneMon:
; Get a random monster owned by the trainer who's calling.
	farcall GetCallerLocation
	ld a, d
	ldh [hMathBuffer], a ; (the trainer, for RANDOMIZER mode)
	ld a, e
	ldh [hMathBuffer + 1], a
	ld hl, TrainerGroups
	ld a, d
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, BANK(TrainerGroups)
	call GetFarWord
	ld b, e
	ld d, h
	ld e, l
	farcall SkipTrainersFar

.skip_name
	ld a, BANK(Trainers)
	call GetFarByte
	inc hl
	cp '@'
	jr nz, .skip_name

	ld a, BANK(Trainers)
	call GetFarByte
	inc hl
	ld bc, 1 + 2 ; level, species (16-bit indexes, as the moves)
	cp TRAINERTYPE_NORMAL
	jr z, .got_mon_length
	ld bc, 1 + 2 + NUM_MOVES * 2 ; level, species, moves
	cp TRAINERTYPE_MOVES
	jr z, .got_mon_length
	ld bc, 1 + 2 + 1 ; level, species, item
	cp TRAINERTYPE_ITEM
	jr z, .got_mon_length
	; TRAINERTYPE_ITEM_MOVES
	ld bc, 1 + 2 + 1 + NUM_MOVES * 2 ; level, species, item, moves
.got_mon_length

	ld e, 0
	push hl
.count_mon
	inc e
	add hl, bc
	ld a, BANK(Trainers)
	call GetFarByte
	cp -1
	jr nz, .count_mon
	pop hl

.rand
	call Random
	maskbits PARTY_LENGTH
	cp e
	jr nc, .rand
	ldh [hRandomizerSlot], a

	inc a
.get_mon
	dec a
	jr z, .got_mon
	add hl, bc
	jr .get_mon
.got_mon

	inc hl ; species
	ld a, BANK(Trainers)
	call GetFarWord
	ld d, h
	ld e, l
	ldh a, [hMathBuffer]
	ld b, a
	ldh a, [hMathBuffer + 1]
	ld c, a
	farcall RandomizeTrainerIndex
	ld h, d
	ld l, e
	call GetPokemonIDFromIndex
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wStringBuffer4
	ld bc, MON_NAME_LENGTH
	jp CopyBytes

INCLUDE "data/wild/johto_grass.asm"
INCLUDE "data/wild/johto_water.asm"
INCLUDE "data/wild/kanto_grass.asm"
INCLUDE "data/wild/kanto_water.asm"
INCLUDE "data/wild/swarm_grass.asm"
INCLUDE "data/wild/swarm_water.asm"
