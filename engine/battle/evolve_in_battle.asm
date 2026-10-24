; Party Pokémon that reach their evolution level in battle evolve right
; away, instead of when the battle is won (see ExitBattle).

EvolveInBattle:
; Called after the party has gained experience for a fainted foe.
	ld a, [wLinkMode]
	and a
	ret nz

	ld a, [wEvolvableFlags]
	and a
	ret z

	ld a, [wCurPartyMon]
	push af

; Remember what the evolution sequence changes.
	ld a, [wCurBattleMon]
	ld [wCurPartyMon], a
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld b, [hl]
	ld a, [wPlayerHPPal]
	ld c, a
	push bc
	ld hl, wMusicID
	ld a, [hli]
	ld d, [hl]
	ld e, a
	push de

	call LoadStandardMenuHeader ; back up the battle screen
	xor a
	ld [wForceEvolution], a
	predef EvolveAfterBattle
; Each level-up gets one chance to evolve, like after a battle,
; so canceling isn't asked again once the battle is over.
	xor a
	ld [wEvolvableFlags], a

	pop de
	pop bc
	ld a, [wMonTriedToEvolve]
	and a
	jr nz, .restore_battle

	call ExitMenu
	jr .done

.restore_battle
	push de
	ld a, c
	ld [wPlayerHPPal], a
	ld a, [wCurBattleMon]
	ld [wCurPartyMon], a
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	cp b
	call nz, UpdateEvolvedBattleMon

	call ClearSprites
	call ClearPalettes
	call DelayFrame
	callfar LoadBattleFontsHPBar
	callfar GetBattleMonBackpic
	call ExitMenu
	callfar EmptyBattleTextbox
	ld hl, wBattleMonHP
	ld a, [hli]
	or [hl]
	jr z, .fainted
	callfar UpdatePlayerHUD
.fainted
	call ApplyTilemap
	call LoadTilemapToTempTilemap
	ld b, SCGB_BATTLE_COLORS
	call GetSGBLayout
	call SetDefaultBGPAndOBP
	call DelayFrame

	pop de
	call PlayMusic

.done
	pop af
	ld [wCurPartyMon], a
	ret

UpdateEvolvedBattleMon:
; Copy the evolved Pokémon in battle back from its party data,
; the way a level-up does, keeping its stat changes.
	ld a, MON_HP
	call GetPartyParamLocation
	ld de, wBattleMonHP
	ld bc, PARTYMON_STRUCT_LENGTH - MON_HP
	call CopyBytes

	ld a, [wPlayerSubStatus5]
	bit SUBSTATUS_TRANSFORMED, a
	jr nz, .transformed

	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wBattleMonSpecies], a
	ld [wTempBattleMonSpecies], a
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wBaseType1]
	ld [wBattleMonType1], a
	ld a, [wBaseType2]
	ld [wBattleMonType2], a

	ld hl, wPartyMonNicknames
	ld a, [wCurBattleMon]
	call SkipNames
	ld de, wBattleMonNickname
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	ld hl, wBattleMonAttack
	ld de, wPlayerStats
	ld bc, PARTYMON_STRUCT_LENGTH - MON_ATK
	call CopyBytes

.transformed
	xor a ; FALSE
	ld [wApplyStatLevelMultipliersToEnemy], a
	callfar ApplyStatLevelMultiplierOnAllStats
	callfar ApplyStatusEffectOnPlayerStats
	callfar BadgeStatBoosts
	ret
