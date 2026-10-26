; PalletToPewter's level caps (Kanto Squad's rule): Pokémon only grow to
; CAP_BELOW levels below the strongest Pokémon of the next big battle, and the
; cap never goes back down. Once RED is beaten there is no cap. EXP that a
; Pokémon at the cap can't take is shared among its teammates that can.
;
; The battles are steps, in story order. Where Crystal lets the player take
; them in any order (CHUCK, JASMINE, PRYCE and TEAM ROCKET's hideout; the RADIO
; TOWER; KANTO's GYMS), they make one step, whose ace is the strongest of them.
; wLevelCapStep counts the steps done. It only goes up, so the ELITE FOUR's
; flags, which are cleared whenever the player comes back to INDIGO PLATEAU,
; don't bring the cap back down, and a step counts as done once any later step
; is (so saves from before the level caps start in the right place). A step whose
; ace is no stronger than one already beaten doesn't hold the cap back: the cap
; is for the next step that raises it (see GetNextCapStep).

LevelCapStepAces:
; the level of each step's strongest Pokémon
	table_width 1
	db  5 ; your rival (CHERRYGROVE CITY)
	db  9 ; FALKNER's PIDGEOTTO
	db 16 ; BUGSY's SCYTHER
	db 16 ; your rival (AZALEA TOWN)
	db 20 ; WHITNEY's MILTANK
	db 20 ; SUDOWOODO
	db 22 ; your rival (BURNED TOWER)
	db 25 ; MORTY's GENGAR
	db 35 ; JASMINE's STEELIX (with CHUCK, PRYCE, the red GYARADOS and the hideout)
	db 36 ; the EXECUTIVEs' GOLBAT (the RADIO TOWER)
	db 40 ; CLAIR's KINGDRA
	db 38 ; your rival (VICTORY ROAD)
	db 42 ; WILL's XATU
	db 44 ; KOGA's CROBAT
	db 46 ; BRUNO's MACHAMP
	db 47 ; KAREN's HOUNDOOM
	db 50 ; LANCE's DRAGONITE
	db 50 ; BLAINE's RAPIDASH (KANTO's GYMS)
	db 58 ; BLUE's GYARADOS
	db 81 ; RED's PIKACHU
	assert_table_length NUM_LEVEL_CAP_STEPS

LevelCapStepFlags:
; flags that mark each step done: all of them, or all of those after CAP_OR
	table_width 2
	dw .Rival1
	dw .Falkner
	dw .Bugsy
	dw .Rival2
	dw .Whitney
	dw .Sudowoodo
	dw .Rival3
	dw .Morty
	dw .MidJohto
	dw .RadioTower
	dw .Clair
	dw .Rival5
	dw .Will
	dw .Koga
	dw .Bruno
	dw .Karen
	dw .Lance
	dw .Kanto
	dw .Blue
	dw .Red
	assert_table_length NUM_LEVEL_CAP_STEPS

.Rival1:     dw EVENT_BEAT_RIVAL_IN_CHERRYGROVE, CAP_OR, EVENT_GAVE_MYSTERY_EGG_TO_ELM, -1
.Falkner:    dw CAP_ENGINE_FLAG | ENGINE_ZEPHYRBADGE, -1
.Bugsy:      dw CAP_ENGINE_FLAG | ENGINE_HIVEBADGE, -1
.Rival2:     dw EVENT_BEAT_RIVAL_IN_AZALEA, CAP_OR, EVENT_GOT_HM01_CUT, -1
.Whitney:    dw CAP_ENGINE_FLAG | ENGINE_PLAINBADGE, -1
.Sudowoodo:  dw EVENT_FOUGHT_SUDOWOODO, -1
.Rival3:     dw EVENT_BEAT_RIVAL_IN_BURNED_TOWER, CAP_OR, EVENT_RELEASED_THE_BEASTS, -1
.Morty:      dw CAP_ENGINE_FLAG | ENGINE_FOGBADGE, -1
.MidJohto:   dw CAP_ENGINE_FLAG | ENGINE_STORMBADGE, CAP_ENGINE_FLAG | ENGINE_MINERALBADGE, CAP_ENGINE_FLAG | ENGINE_GLACIERBADGE, -1
.RadioTower: dw EVENT_CLEARED_RADIO_TOWER, -1
.Clair:      dw EVENT_BEAT_CLAIR, CAP_OR, CAP_ENGINE_FLAG | ENGINE_RISINGBADGE, -1
.Rival5:     dw EVENT_BEAT_RIVAL_IN_VICTORY_ROAD, -1
.Will:       dw EVENT_BEAT_ELITE_4_WILL, -1
.Koga:       dw EVENT_BEAT_ELITE_4_KOGA, -1
.Bruno:      dw EVENT_BEAT_ELITE_4_BRUNO, -1
.Karen:      dw EVENT_BEAT_ELITE_4_KAREN, -1
.Lance:      dw EVENT_BEAT_CHAMPION_LANCE, CAP_OR, EVENT_BEAT_ELITE_FOUR, -1
.Kanto:
	dw CAP_ENGINE_FLAG | ENGINE_BOULDERBADGE, CAP_ENGINE_FLAG | ENGINE_CASCADEBADGE
	dw CAP_ENGINE_FLAG | ENGINE_THUNDERBADGE, CAP_ENGINE_FLAG | ENGINE_RAINBOWBADGE
	dw CAP_ENGINE_FLAG | ENGINE_SOULBADGE, CAP_ENGINE_FLAG | ENGINE_MARSHBADGE
	dw CAP_ENGINE_FLAG | ENGINE_VOLCANOBADGE, -1
.Blue:       dw CAP_ENGINE_FLAG | ENGINE_EARTHBADGE, -1
.Red:        dw EVENT_BEAT_RED, -1

LevelCapStepTexts:
; who stands in the way of a higher cap
	table_width 2
	dw .Rival
	dw .Falkner
	dw .Bugsy
	dw .Rival
	dw .Whitney
	dw .Sudowoodo
	dw .Rival
	dw .Morty
	dw .MidJohto
	dw .RadioTower
	dw .Clair
	dw .Rival
	dw .Will
	dw .Koga
	dw .Bruno
	dw .Karen
	dw .Lance
	dw .Kanto
	dw .Blue
	dw .Red
	assert_table_length NUM_LEVEL_CAP_STEPS

.Rival:
	text "It goes up once"
	line "you've battled"
	cont "<RIVAL>."
	prompt

.Falkner:
	text "It goes up once"
	line "you beat FALKNER."
	prompt

.Bugsy:
	text "It goes up once"
	line "you beat BUGSY."
	prompt

.Whitney:
	text "It goes up once"
	line "you beat WHITNEY."
	prompt

.Sudowoodo:
	text "It goes up once"
	line "you deal with the"
	cont "odd tree on ROUTE"
	cont "36."
	prompt

.Morty:
	text "It goes up once"
	line "you beat MORTY."
	prompt

.MidJohto:
	text "It goes up once"
	line "you beat CHUCK,"
	cont "JASMINE and PRYCE."
	prompt

.RadioTower:
	text "It goes up once"
	line "TEAM ROCKET is"
	cont "out of the RADIO"
	cont "TOWER."
	prompt

.Clair:
	text "It goes up once"
	line "you beat CLAIR."
	prompt

.Will:
	text "It goes up once"
	line "you beat WILL."
	prompt

.Koga:
	text "It goes up once"
	line "you beat KOGA."
	prompt

.Bruno:
	text "It goes up once"
	line "you beat BRUNO."
	prompt

.Karen:
	text "It goes up once"
	line "you beat KAREN."
	prompt

.Lance:
	text "It goes up once"
	line "you beat LANCE."
	prompt

.Kanto:
	text "It goes up once"
	line "you beat KANTO's"
	cont "other GYM LEADERS."
	prompt

.Blue:
	text "It goes up once"
	line "you beat BLUE."
	prompt

.Red:
	text "It goes up once"
	line "you beat RED."
	prompt

GetLevelCap::
; Return the level cap in a: MAX_LEVEL once every step is done.
	push bc
	push de
	push hl
	call UpdateLevelCapStep
	call GetNextCapStep
	cp NUM_LEVEL_CAP_STEPS
	ld a, MAX_LEVEL
	jr nc, .done
; the strongest ace up to and including that step (its own)
	call GetNextCapStep
	inc a
	ld c, a
	call GetHighestCapAce
.done
	pop hl
	pop de
	pop bc
	ret

GetNextCapStep:
; a: the next step that raises the cap: the first that isn't done whose ace is
; stronger than any done step's (so beating BUGSY raises it, though the next
; step, your rival in AZALEA TOWN, has an ace no stronger than his); or
; NUM_LEVEL_CAP_STEPS if there's none.
	ld a, [wLevelCapStep]
	cp NUM_LEVEL_CAP_STEPS
	ret nc
	ld c, a
	ld hl, LevelCapStepAces
	ld b, 0 ; (the strongest done step's ace)
	and a
	jr z, .find
.done_steps
	ld a, [hli]
	cp b
	jr c, .next_done
	ld b, a
.next_done
	dec c
	jr nz, .done_steps
.find
; hl: the first step not done's ace
	ld a, [wLevelCapStep]
	ld c, a
.step
	ld a, [hli]
	cp b
	jr z, .no_higher
	jr nc, .found
.no_higher
	inc c
	ld a, c
	cp NUM_LEVEL_CAP_STEPS
	jr c, .step
	ret

.found
	ld a, c
	ret

GetLevelCapInB::
; GetLevelCap, for farcall: the level cap in b.
	call GetLevelCap
	ld b, a
	ret

GetDifficultyLevelCap::
; The level HARD and EXTREME trainers fight at: the level cap, or once there's
; none, the last one there was.
	call GetLevelCap
	cp MAX_LEVEL
	ret c
	push bc
	push de
	push hl
	ld c, NUM_LEVEL_CAP_STEPS
	call GetHighestCapAce
	pop hl
	pop de
	pop bc
	ret

GetHighestCapAce:
; Return in a the highest ace of the first c steps, less CAP_BELOW, at least
; MIN_LEVEL_CAP.
	ld hl, LevelCapStepAces
	ld b, 0
.loop
	ld a, [hli]
	cp b
	jr c, .next
	ld b, a
.next
	dec c
	jr nz, .loop
	ld a, b
	sub CAP_BELOW
	jr c, .min
	cp MIN_LEVEL_CAP
	ret nc
.min
	ld a, MIN_LEVEL_CAP
	ret

UpdateLevelCapStep:
; Count every step up to the last one that's done as done.
	ld c, NUM_LEVEL_CAP_STEPS
.loop
	ld a, [wLevelCapStep]
	cp c
	ret nc ; (already counted)
	dec c
	push bc
	ld a, c
	call IsLevelCapStepDone
	pop bc
	jr nc, .loop
	ld a, c
	inc a
	ld [wLevelCapStep], a
	ret

IsLevelCapStepDone:
; Return carry if step a is done.
	ld e, a
	ld d, 0
	ld hl, LevelCapStepFlags
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
.new_set
	ld e, TRUE ; every flag so far is set
.loop
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	and c
	inc a ; -1?
	jr z, .end
	ld a, b
	cp HIGH(CAP_OR)
	jr nz, .flag
	ld a, c
	cp LOW(CAP_OR)
	jr nz, .flag
; CAP_OR: the set before it is enough
	ld a, e
	and a
	jr z, .new_set
	scf
	ret

.flag
	push de
	push hl
	ld d, b
	ld e, c
	bit 7, d ; HIGH(CAP_ENGINE_FLAG)
	jr nz, .engine_flag
	ld b, CHECK_FLAG
	call EventFlagAction
	jr .checked

.engine_flag
	res 7, d
	ld b, CHECK_FLAG
	farcall EngineFlagAction
.checked
	pop hl
	pop de
	ld a, c
	and a
	jr nz, .loop
	ld e, FALSE
	jr .loop

.end
	ld a, e
	and a
	ret z
	scf
	ret

PrintLevelCapStepText:
; Who stands in the way of a higher cap (nothing once there's no cap).
	call UpdateLevelCapStep
	call GetNextCapStep
	cp NUM_LEVEL_CAP_STEPS
	ret nc
	ld e, a
	ld d, 0
	ld hl, LevelCapStepTexts
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp PrintText

; EXP in battle (see GiveExperiencePoints and
; UpdateBattleStateAndExperienceAfterEnemyFaint)

LevelCap_BeginExp::
	call GetLevelCap
	ld [wCurLevelCap], a
	xor a
	ld [wCapFlags], a
	ld [wCapExcessExp], a
	ld [wCapExcessExp + 1], a
	ret

LevelCap_LoadShareExp::
; While sharing, each teammate gets wCapShareExp.
	xor a
	ldh [hQuotient + 0], a
	ldh [hQuotient + 1], a
	ld [wStringBuffer2 + 2], a ; not boosted
	ld a, [wCapShareExp]
	ldh [hQuotient + 2], a
	ld a, [wCapShareExp + 1]
	ldh [hQuotient + 3], a
	ret

LevelCap_ClampExp::
; The party mon at bc is about to get the EXP in hQuotient + 2..3. Lower that
; to what the level cap leaves room for, and keep the rest to share.
; Return z if there's nothing left to give.
	push bc
	ldh a, [hQuotient + 2]
	ld d, a
	ldh a, [hQuotient + 3]
	ld e, a
	push de ; the full amount
	ld a, [wCurLevelCap]
	cp MAX_LEVEL
	jr nc, .give_all
	ld hl, MON_LEVEL
	add hl, bc
	cp [hl]
	jr z, .no_room
	jr c, .no_room

; room = EXP at the cap - EXP now
	push bc
	ld hl, MON_SPECIES
	add hl, bc
	ld a, [hl]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wCurLevelCap]
	ld d, a
	farcall CalcExpAtLevel
	pop bc
	ld hl, MON_EXP + 2
	add hl, bc
	ldh a, [hProduct + 3]
	sub [hl]
	ld e, a
	dec hl
	ldh a, [hProduct + 2]
	sbc [hl]
	ld d, a
	dec hl
	ldh a, [hProduct + 1]
	sbc [hl]
	jr c, .no_room
	jr nz, .give_all ; (more than 65535 to go)
	pop hl ; the full amount
	push hl
; the smaller of the two
	ld a, h
	cp d
	jr c, .give_all
	jr nz, .clamp
	ld a, l
	cp e
	jr c, .give_all
	jr z, .give_all
.clamp
	pop hl
	push de
	ld a, l
	sub e
	ld e, a
	ld a, h
	sbc d
	ld d, a
	call .AddToExcess
	pop de
	jr .store

.no_room
	pop de
	call .AddToExcess
	ld de, 0
	jr .store

.give_all
	pop de
.store
	xor a
	ldh [hQuotient + 0], a
	ldh [hQuotient + 1], a
	ld a, d
	ldh [hQuotient + 2], a
	ld a, e
	ldh [hQuotient + 3], a
	or d
	jr nz, .done
; nothing: a Pokémon that battled hears about it
	ld a, [wCapFlags]
	bit CAP_SHARING_F, a
	jr nz, .quiet
	ld a, [wGivingExperienceToExpShareHolders]
	and a
	jr nz, .quiet
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNickname
	ld hl, LevelCapReachedText
	call BattleTextbox
.quiet
	xor a
.done
	pop bc
	ret

.AddToExcess:
	ld hl, wCapExcessExp + 1
	ld a, [hl]
	add e
	ld [hld], a
	ld a, [hl]
	adc d
	ld [hl], a
	ret nc
	ld a, $ff
	ld [hli], a
	ld [hl], a
	ret

LevelCap_ShareExcess::
; Share the EXP Pokémon at the cap couldn't take among the teammates that can
; still grow (as GiveExperiencePoints does for EXP SHARE holders).
	ld a, [wCapExcessExp]
	ld b, a
	ld a, [wCapExcessExp + 1]
	or b
	ret z
; who can take some: not fainted, not an egg, below the cap
	ld a, [wCurLevelCap]
	ld e, a
	ld hl, wPartyMon1HP
	ld bc, wPartySpecies
	ld d, 0 ; flags
	ld a, 1
.loop
	push af
	ld a, [bc]
	cp -1
	jr z, .counted
	cp EGG
	jr z, .next
	push hl
	ld a, [hli]
	or [hl]
	pop hl
	jr z, .next
	push hl
	push bc
	ld bc, MON_LEVEL - MON_HP
	add hl, bc
	pop bc
	ld a, [hl]
	pop hl
	cp e
	jr nc, .next
	pop af
	push af
	or d
	ld d, a
.next
	inc bc
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	pop af
	add a
	jr .loop

.counted
	pop af
	ld a, d
	and a
	ret z
; each one's share
	ld [wBattleParticipantsNotFainted], a
	ld c, 0
.count
	srl a
	jr nc, .not_set
	inc c
.not_set
	and a
	jr nz, .count
	xor a
	ldh [hDividend + 0], a
	ldh [hDividend + 1], a
	ld a, [wCapExcessExp]
	ldh [hDividend + 2], a
	ld a, [wCapExcessExp + 1]
	ldh [hDividend + 3], a
	ld a, c
	ldh [hDivisor], a
	ld b, 4
	call Divide
	ldh a, [hQuotient + 2]
	ld [wCapShareExp], a
	ld b, a
	ldh a, [hQuotient + 3]
	ld [wCapShareExp + 1], a
	or b
	ret z
	ld hl, wCapFlags
	set CAP_SHARING_F, [hl]
	farcall GiveExperiencePoints
	ld hl, wCapFlags
	res CAP_SHARING_F, [hl]
	ret

LevelCapReachedText:
	text_ram wStringBuffer1
	text " is at"
	line "the level cap!"
	prompt

CapBreedMonLevel::
; A Day-Care Pokémon that came in at level b has the EXP for level d: it only
; grows up to the level cap.
	call GetLevelCap
	cp b
	jr nc, .got_limit
	ld a, b ; (it came in above the cap)
.got_limit
	cp d
	ret nc
	ld d, a
	ret

CheckLevelCapForCandy::
; Return carry (and say so) if the party mon wCurPartyMon can't grow any more.
	call GetLevelCap
	ld b, a
	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	cp b
	ccf
	ret nc
	ld a, b
	ld [wCurLevelCap], a
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNickname
	ld hl, LevelCapCandyText
	call PrintText
	call PrintLevelCapStepText
	scf
	ret

LevelCapCandyText:
	text_ram wStringBuffer1
	text " is at"
	line "the level cap,"
	cont "Lv.@"
	text_decimal wCurLevelCap, 1, 3
	text "."
	prompt
