; Pokémon followers: the party's lead Pokémon walks behind the player, and a
; CHANSEY rented at a POKéMON CENTER walks behind it.
;
; A follower is an object struct with no map object (its OBJECT_MAP_OBJECT_INDEX
; is -1), so it never takes one of the map's object slots. SPRITEMOVEDATA_FOLLOWER
; tells it apart from other objects, and its sprite tells which follower it is.
;
; Each follower has a queue of the tiles its leader left (the player for the lead
; Pokémon, the lead Pokémon for the CHANSEY) and walks into them in turn, at its
; leader's speed. A hidden follower stands on the player's tile: it comes out on
; the tile its leader leaves. Followers hide after warps and while surfing, and
; the player walks through them.

	assert FOLLOWER_LEAD == 0 && NUM_FOLLOWERS == 2

UpdateFollowers::
; Called every overworld frame, before the objects step.
	ldh a, [hMapObjectIndex]
	push af
	ldh a, [hObjectStructIndex]
	push af
	ld a, FOLLOWER_LEAD
	call UpdateFollower
	ld a, FOLLOWER_CHANSEY
	call UpdateFollower
	ld hl, wFollowerFlags
	res FOLLOWERS_CONNECTION_F, [hl]
	pop af
	ldh [hObjectStructIndex], a
	pop af
	ldh [hMapObjectIndex], a
	ret

UpdateFollower:
	ld [wCurFollower], a
	call IsFollowerWanted
	jr nz, .wanted
	ld a, [wCurFollower]
	call FindFollowerStruct
	ret nc
	call DeleteMapObject
	ld a, [wCurFollower]
	jp ClearFollowerQueue

.wanted
	ld a, [wCurFollower]
	call FindFollowerStruct
	jp nc, SpawnFollower
	ldh [hMapObjectIndex], a
	ld hl, wFollowerFlags
	bit FOLLOWERS_CONNECTION_F, [hl]
	call nz, PlaceFollowerAfterConnection
	ld a, [wCurFollower]
	and a ; FOLLOWER_LEAD
	call z, .UpdateLeadSpecies

	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit INVISIBLE_F, [hl]
	jr nz, .follow_player

; Followers hide while the player surfs.
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .hide
	cp PLAYER_SURF_PIKA
	jr z, .hide

; A follower that stands still hides when someone else steps onto its tile.
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld a, [hl]
	cp STEP_TYPE_FROM_MOVEMENT
	ret nz
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld e, [hl]
	push bc
	call IsObjectOnFollowerTile
	pop bc
	ret nc
.hide
	ld a, [wCurFollower]
	jp HideFollower

.follow_player
; A hidden follower stays on the player's tile.
	ld a, [wPlayerLastMapX]
	ld d, a
	ld a, [wPlayerLastMapY]
	ld e, a
	jp SetFollowerCoords

.UpdateLeadSpecies:
	push bc
	call GetLeadFollowerSpecies
	ld hl, wFollowerSpecies
	cp [hl]
	jr z, .same_species
	ld [hl], a
	farcall ReloadFollowerSpriteGFX
	pop bc
	ld a, FOLLOWER_LEAD
	jp SetFollowerPalette

.same_species
	pop bc
	ret

SpawnFollower:
	call FindFirstEmptyObjectStruct
	ret nc
	ldh [hMapObjectIndex], a ; GetSpriteVTile ignores hMapObjectIndex 0
	push hl
	ld a, [wCurFollower]
	and a ; FOLLOWER_LEAD
	jr nz, .got_species
	call GetLeadFollowerSpecies
	ld hl, wFollowerSpecies
	cp [hl]
	jr z, .got_species
	ld [hl], a
	farcall ReloadFollowerSpriteGFX
.got_species
	ld a, [wCurFollower]
	call GetFollowerSprite
	ld [wTempObjectCopySprite], a
	call GetSpriteVTile
	jr c, .no_sprite
	ld [wTempObjectCopySpriteVTile], a
	ld a, -1
	ld [wTempObjectCopyMapObjectIndex], a
	ld a, [wCurFollower]
	call GetFollowerPalette
	ld [wTempObjectCopyPalette], a
	ld a, SPRITEMOVEDATA_FOLLOWER
	ld [wTempObjectCopyMovement], a
	xor a
	ld [wTempObjectCopyRange], a
	ld [wTempObjectCopyRadius], a
	ld a, [wPlayerLastMapX]
	ld [wTempObjectCopyX], a
	ld a, [wPlayerLastMapY]
	ld [wTempObjectCopyY], a
	pop de
	push de
	farcall CopyTempObjectToObjectStruct
	pop bc
	ld a, [wCurFollower]
	call ClearFollowerQueue
	ld hl, wFollowerFlags
	bit FOLLOWERS_CONNECTION_F, [hl]
	jr nz, PlaceFollowerAfterConnection
	ld hl, OBJECT_FLAGS1
	add hl, bc
	set INVISIBLE_F, [hl]
	ret

.no_sprite
	pop hl
	ret

PlaceFollowerAfterConnection:
; Right after a map connection, follower [wCurFollower] (object struct bc)
; stands where it was next to the player.
	ld a, [wCurFollower]
	ld e, a
	ld d, 0
	ld hl, wFollowerConnectionOffsets
	add hl, de
	add hl, de
	ld a, [hli]
	cp $80
	jr z, .hidden
	ld d, a
	ld a, [wPlayerMapX]
	add d
	ld d, a
	ld a, [wPlayerMapY]
	add [hl]
	ld e, a
	ld hl, OBJECT_FLAGS1
	add hl, bc
	res INVISIBLE_F, [hl]
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_RESET
	jp SetFollowerCoords

.hidden
	ld a, [wCurFollower]
	jp HideFollower

IsObjectOnFollowerTile:
; Return carry if an object other than the player and the followers
; is on tile (d, e), or stepping off it.
	ld bc, wObject1Struct
	ld a, 1
.loop
	ldh [hObjectStructIndex], a
	call DoesObjectHaveASprite
	jr z, .next
	ld hl, OBJECT_MOVEMENT_TYPE
	add hl, bc
	ld a, [hl]
	cp SPRITEMOVEDATA_FOLLOWER
	jr z, .next
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit EMOTE_OBJECT_F, [hl]
	jr nz, .next
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	cp d
	jr nz, .last_coords
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	cp e
	jr z, .yes
.last_coords
	ld hl, OBJECT_LAST_MAP_X
	add hl, bc
	ld a, [hl]
	cp d
	jr nz, .next
	ld hl, OBJECT_LAST_MAP_Y
	add hl, bc
	ld a, [hl]
	cp e
	jr z, .yes
.next
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hObjectStructIndex]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr c, .loop
	and a
	ret

.yes
	scf
	ret

IsFollowerWanted:
; Return nz if follower [wCurFollower] should be out on this map.
	ld a, [wLinkMode]
	and a
	jr nz, .no
	ld a, [wMapGroup]
	ld d, a
	ld a, [wMapNumber]
	ld e, a
	ld hl, NoFollowerMaps
.loop
	ld a, [hli]
	cp -1
	jr z, .allowed
	cp d
	ld a, [hli]
	jr nz, .loop
	cp e
	jr nz, .loop
.no
	xor a
	ret

.allowed
	ld a, [wCurFollower]
	and a ; FOLLOWER_LEAD
	jr nz, .chansey
	call GetLeadFollowerSpecies
	and a
	ret

.chansey
	ld a, [wRentalChanseyHeals]
	and a
	ret

NoFollowerMaps:
	map_id TRADE_CENTER
	map_id COLOSSEUM
	map_id TIME_CAPSULE
	map_id MOBILE_TRADE_ROOM
	map_id MOBILE_BATTLE_ROOM
	map_id BATTLE_TOWER_BATTLE_ROOM
	map_id BATTLE_TOWER_ELEVATOR
	map_id BATTLE_TOWER_HALLWAY
	db -1 ; end

GetLeadFollowerSpecies::
; Find the first party Pokémon that isn't an egg or fainted: return carry,
; its species in a and its party index in c. Return a = 0 if there is none.
	ld hl, wPartySpecies
	ld de, wPartyMon1HP
	ld c, 0
.loop
	ld a, [wPartyCount]
	cp c
	jr z, .none
	ld a, [hli]
	cp EGG
	jr z, .next
	ld b, a
	ld a, [de]
	inc de
	push hl
	ld h, d
	ld l, e
	or [hl]
	pop hl
	dec de
	jr nz, .found
.next
	push hl
	ld hl, PARTYMON_STRUCT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	pop hl
	inc c
	jr .loop

.found
	ld a, b
	scf
	ret

.none
	xor a
	ret

GetFollowerSprite:
	and a ; FOLLOWER_LEAD
	ld a, SPRITE_FOLLOWER
	ret z
	ld a, SPRITE_RENTAL_CHANSEY
	ret

GetFollowerPalette:
; Return the palette of follower a: the CHANSEY is pink,
; the lead Pokémon gets the color of its first type.
	and a ; FOLLOWER_LEAD
	ld a, PAL_OW_PINK
	ret nz
	push bc
	ld a, [wFollowerSpecies]
	and a
	jr z, .done
	dec a
	ld hl, BaseData + BASE_TYPES
	ld bc, BASE_DATA_SIZE
	call AddNTimes
	ld a, BANK(BaseData)
	call GetFarByte
	ld c, a
	ld b, 0
	ld hl, FollowerTypePalettes
	add hl, bc
	ld a, [hl]
.done
	pop bc
	ret

FollowerTypePalettes:
; entries correspond to types (see constants/type_constants.asm)
	table_width 1
	db PAL_OW_BROWN ; NORMAL
	db PAL_OW_BROWN ; FIGHTING
	db PAL_OW_BLUE  ; FLYING
	db PAL_OW_PINK  ; POISON
	db PAL_OW_ROCK  ; GROUND
	db PAL_OW_ROCK  ; ROCK
	db PAL_OW_BLUE  ; BIRD
	db PAL_OW_GREEN ; BUG
	db PAL_OW_PINK  ; GHOST
	db PAL_OW_EMOTE ; STEEL
rept UNUSED_TYPES_END - UNUSED_TYPES
	db PAL_OW_BROWN ; unused types and CURSE_TYPE
endr
	db PAL_OW_RED   ; FIRE
	db PAL_OW_BLUE  ; WATER
	db PAL_OW_GREEN ; GRASS
	db PAL_OW_ROCK  ; ELECTRIC
	db PAL_OW_PINK  ; PSYCHIC_TYPE
	db PAL_OW_BLUE  ; ICE
	db PAL_OW_BLUE  ; DRAGON
	db PAL_OW_BROWN ; DARK
	assert_table_length TYPES_END

SetFollowerPalette:
; Give follower a (object struct bc) its palette.
	call GetFollowerPalette
	ld d, a
	ld hl, OBJECT_PALETTE
	add hl, bc
	ld a, [hl]
	and ~OAM_PALETTE
	or d
	ld [hl], a
	ret

FindFollowerStruct:
; Find the object struct of follower a.
; If it has one, return carry, the struct in bc and its index in a.
; Preserves de.
	push de
	call GetFollowerSprite
	ld e, a
	ld bc, wObject1Struct
	ld d, 1
.loop
	ld hl, OBJECT_MOVEMENT_TYPE
	add hl, bc
	ld a, [hl]
	cp SPRITEMOVEDATA_FOLLOWER
	jr nz, .next
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	cp e
	jr z, .found
.next
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	inc d
	ld a, d
	cp NUM_OBJECT_STRUCTS
	jr c, .loop
	pop de
	and a
	ret

.found
	ld a, d
	pop de
	scf
	ret

GetFollowerKind:
; If object struct bc is a follower, return carry and which follower it is in a.
	ld hl, OBJECT_MOVEMENT_TYPE
	add hl, bc
	ld a, [hl]
	cp SPRITEMOVEDATA_FOLLOWER
	jr nz, .no
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	cp SPRITE_FOLLOWER
	ld a, FOLLOWER_LEAD
	scf
	ret z
	ld a, FOLLOWER_CHANSEY
	ret

.no
	and a
	ret

HideFollower:
; Hide follower a (object struct bc) on the player's tile.
; The CHANSEY hides with the lead Pokémon it follows.
	push af
	call ClearFollowerQueue
	ld hl, OBJECT_FLAGS1
	add hl, bc
	set INVISIBLE_F, [hl]
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_RESET
	ld a, [wPlayerLastMapX]
	ld d, a
	ld a, [wPlayerLastMapY]
	ld e, a
	call SetFollowerCoords
	pop af
	and a ; FOLLOWER_LEAD
	ret nz
	ld a, FOLLOWER_CHANSEY
	call FindFollowerStruct
	ret nc
	ld a, FOLLOWER_CHANSEY
	jr HideFollower

SetFollowerCoords:
; Put object struct bc on tile (d, e).
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld [hl], d
	ld hl, OBJECT_LAST_MAP_X
	add hl, bc
	ld [hl], d
	ld hl, OBJECT_INIT_X
	add hl, bc
	ld [hl], d
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld [hl], e
	ld hl, OBJECT_LAST_MAP_Y
	add hl, bc
	ld [hl], e
	ld hl, OBJECT_INIT_Y
	add hl, bc
	ld [hl], e
; same as CopyTempObjectToObjectStruct
	ld a, [wXCoord]
	ld l, a
	ld a, d
	sub l
	and $f
	swap a
	ld hl, wPlayerBGMapOffsetX
	sub [hl]
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld [hl], a
	ld a, [wYCoord]
	ld l, a
	ld a, e
	sub l
	and $f
	swap a
	ld hl, wPlayerBGMapOffsetY
	sub [hl]
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld [hl], a
	xor a
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	ld [hli], a
	ld [hl], a ; OBJECT_SPRITE_Y_OFFSET
	ret

GetFollowerQueue:
; Return the queue length of follower a in hl, followed by its queue.
	ld hl, wFollower0QueueLength
	and a ; FOLLOWER_LEAD
	ret z
	ld hl, wFollower1QueueLength
	ret

ClearFollowerQueue:
	call GetFollowerQueue
	ld [hl], 0
	ret

PushFollowerQueue:
; Add tile (d, e) and speed [wFollowerStepSpeed] to follower a's queue.
; Return carry if the queue is full.
	call GetFollowerQueue
	ld a, [hl]
	cp FOLLOWER_QUEUE_LENGTH
	ccf
	ret c
	inc [hl]
	inc hl
	push bc
	ld c, a
	add a
	add c ; FOLLOWER_QUEUE_ENTRY_SIZE
	ld c, a
	ld b, 0
	add hl, bc
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld a, [wFollowerStepSpeed]
	ld [hl], a
	pop bc
	and a
	ret

PopFollowerQueue:
; Take the oldest tile off follower a's queue: return carry, the tile in de and its speed in a.
; Return no carry if the queue is empty.
	call GetFollowerQueue
	ld a, [hl]
	and a
	ret z
	dec [hl]
	inc hl
	push bc
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a
	ld a, [hli]
	push af
	push de
	ld d, h
	ld e, l
	ld hl, -FOLLOWER_QUEUE_ENTRY_SIZE
	add hl, de
	ld b, h
	ld c, l
	ld h, d
	ld l, e
	ld d, b
	ld e, c
	ld c, (FOLLOWER_QUEUE_LENGTH - 1) * FOLLOWER_QUEUE_ENTRY_SIZE
.shift
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .shift
	pop de
	pop af
	pop bc
	scf
	ret

FollowerLeaderMoved:
; The leader of follower a (object struct bc) is leaving tile (d, e)
; at speed [wFollowerStepSpeed].
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit INVISIBLE_F, [hl]
	jr nz, .come_out
	push af
	call PushFollowerQueue
	pop hl
	ret nc
; It's too far behind.
	ld a, h
	jp HideFollower

.come_out
; A hidden follower comes out on that tile, unless the player is stepping
; onto it (they walked through the lead Pokémon) or it's water.
	ld a, [wPlayerMapX]
	cp d
	jr nz, .not_player
	ld a, [wPlayerMapY]
	cp e
	jr nz, .not_player
	ld a, [wPlayerLastMapX]
	cp d
	ret nz
	ld a, [wPlayerLastMapY]
	cp e
	ret nz
.not_player
	ld a, [wPlayerState]
	cp PLAYER_SURF
	ret z
	cp PLAYER_SURF_PIKA
	ret z
	push bc
	push de
	call GetCoordTileCollision
	call GetTilePermission
	pop de
	pop bc
	cp WATER_TILE
	ret z
	ld hl, OBJECT_FLAGS1
	add hl, bc
	res INVISIBLE_F, [hl]
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_RESET
	jp SetFollowerCoords

ApplyMovementToFollowers:
; Object struct bc is starting movement a. If it's the player taking a step,
; the lead Pokémon follows (or the CHANSEY, if there's no lead Pokémon out).
	ld e, a
	ldh a, [hMapObjectIndex]
	and a ; the player's object struct
	ret nz
	ld a, e
	cp movement_slow_step
	ret c
	cp movement_fast_jump_step + NUM_DIRECTIONS
	ret nc
; The steps come in groups of four directions: slow, normal and fast in turn.
	sub movement_slow_step
	rrca
	rrca
	and %00111111
.mod3
	cp STEP_BIKE + 1
	jr c, .got_speed
	sub STEP_BIKE + 1
	jr .mod3
.got_speed
	ld [wFollowerStepSpeed], a
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld e, [hl]
	push bc
	ld a, FOLLOWER_LEAD
	call FindFollowerStruct
	ld a, FOLLOWER_LEAD
	jr c, .got_follower
	ld a, FOLLOWER_CHANSEY
	call FindFollowerStruct
	ld a, FOLLOWER_CHANSEY
	jr nc, .done
.got_follower
	call FollowerLeaderMoved
.done
	pop bc
	ret

MovementFunction_Follower:
	call GetFollowerKind
	ld [wCurFollower], a
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit INVISIBLE_F, [hl]
	jp nz, .stand

.next
	ld a, [wCurFollower]
	call PopFollowerQueue
	jp nc, .stand
	ld [wFollowerStepSpeed], a
; Don't walk into the player.
	ld a, [wPlayerMapX]
	cp d
	jr nz, .not_player
	ld a, [wPlayerMapY]
	cp e
	jr z, .lost
.not_player
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, d
	sub [hl]
	ld d, a
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, e
	sub [hl]
	ld e, a
	or d
	jr z, .next ; already there

	ld a, d
	and a
	jr z, .vertical
	ld a, e
	and a
	jr nz, .lost
	ld a, d
	ld d, RIGHT
	cp 1
	jr z, .step
	cp 2
	jr z, .jump
	ld d, LEFT
	cp -1
	jr z, .step
	cp -2
	jr z, .jump
	jr .lost

.vertical
	ld a, e
	ld d, DOWN
	cp 1
	jr z, .step
	cp 2
	jr z, .jump
	ld d, UP
	cp -1
	jr z, .step
	cp -2
	jr z, .jump
.lost
; It got separated from its leader.
	ld a, [wCurFollower]
	jp HideFollower

.step
	call .GetSpeed
	or d
	call NormalStep
	jr .moved

.jump
; Hop down a ledge.
	ld a, STEP_WALK
	ld [wFollowerStepSpeed], a
	call .GetSpeed
	or d
	call JumpStep

.moved
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_FOLLOWER
; The CHANSEY follows the lead Pokémon.
	ld a, [wCurFollower]
	and a ; FOLLOWER_LEAD
	ret nz
	ld hl, OBJECT_LAST_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_LAST_MAP_Y
	add hl, bc
	ld e, [hl]
	push bc
	ld a, FOLLOWER_CHANSEY
	call FindFollowerStruct
	ld a, FOLLOWER_CHANSEY
	call c, FollowerLeaderMoved
	pop bc
	ret

.stand
	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_FOLLOWER
	ret

.GetSpeed:
; Return the step speed in a, shifted into OBJECT_WALKING's speed bits.
; A follower that is more than a step behind hurries.
	ld a, [wCurFollower]
	call GetFollowerQueue
	ld a, [hl]
	and a
	ld a, [wFollowerStepSpeed]
	jr z, .got_speed
	cp STEP_BIKE
	jr nc, .got_speed
	inc a
	ld [wFollowerStepSpeed], a
.got_speed
	add a
	add a
	ret

UnfreezeFollowers::
; applymovement freezes every other object; when the player still moves,
; so do their followers.
	ld a, [wPlayerStruct + OBJECT_FLAGS2]
	bit FROZEN_F, a
	ret nz
	ld a, FOLLOWER_LEAD
	call .Unfreeze
	ld a, FOLLOWER_CHANSEY
.Unfreeze:
	call FindFollowerStruct
	ret nc
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res FROZEN_F, [hl]
	ret

FreeFollowerStruct::
; Make room for a map object: remove a follower (the CHANSEY first).
; Return carry if one was removed. Preserves bc and de.
	push bc
	push de
	ld a, FOLLOWER_CHANSEY
	call FindFollowerStruct
	jr c, .found
	ld a, FOLLOWER_LEAD
	call FindFollowerStruct
	jr nc, .done
.found
	call DeleteMapObject
	scf
.done
	pop de
	pop bc
	ret

_ClearObjectStructs::
; Clear every object struct but the player's.
; Pokémon followers stay through a map connection.
	ld hl, wObject1Struct
	ld c, NUM_OBJECT_STRUCTS - 1
.loop
	ldh a, [hMapEntryMethod]
	cp MAPSETUP_CONNECTION
	jr nz, .clear
	push hl
	ld de, OBJECT_MOVEMENT_TYPE
	add hl, de
	ld a, [hl]
	pop hl
	cp SPRITEMOVEDATA_FOLLOWER
	jr z, .next
.clear
	push bc
	push hl
	ld bc, OBJECT_LENGTH
	xor a
	call ByteFill
	pop hl
	pop bc
.next
	ld de, OBJECT_LENGTH
	add hl, de
	dec c
	jr nz, .loop
	ret

SaveFollowerConnectionOffsets::
; The player is walking onto a connected map: remember where the followers are.
	ld hl, wFollowerFlags
	set FOLLOWERS_CONNECTION_F, [hl]
	ld a, FOLLOWER_LEAD
	call .Save
	ld a, FOLLOWER_CHANSEY
.Save:
	ld e, a
	ld d, 0
	ld hl, wFollowerConnectionOffsets
	add hl, de
	add hl, de
	push hl
	call FindFollowerStruct
	pop de
	jr nc, .hidden
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit INVISIBLE_F, [hl]
	jr nz, .hidden
	ld a, [wPlayerMapX]
	ld l, a
	push hl
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	pop hl
	sub l
	ld [de], a
	inc de
	ld a, [wPlayerMapY]
	ld l, a
	push hl
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	pop hl
	sub l
	ld [de], a
	ret

.hidden
	ld a, $80
	ld [de], a
	ret

FollowersLoadMapObjects::
; The map's objects are being loaded.
	ldh a, [hMapEntryMethod]
	cp MAPSETUP_CONNECTION
	jr z, .connection
	ld hl, wFollowerFlags
	res FOLLOWERS_CONNECTION_F, [hl]
.connection
	xor a
	ld [wFollower0QueueLength], a
	ld [wFollower1QueueLength], a

; The POKéMON CENTER the rented CHANSEY came from doesn't show its CHANSEY.
	ld b, RESET_FLAG
	ld a, [wRentalChanseyHeals]
	and a
	jr z, .got_flag
	ld a, [wMapGroup]
	ld hl, wRentalChanseyMapGroup
	cp [hl]
	jr nz, .got_flag
	ld a, [wMapNumber]
	inc hl
	cp [hl]
	jr nz, .got_flag
	ld b, SET_FLAG
.got_flag
	ld de, EVENT_RENTAL_CHANSEY_FROM_HERE
	jp EventFlagAction

TryTalkToFollower::
; If object struct bc is a follower, start its script and return carry.
	call GetFollowerKind
	ret nc
	push af
; It turns to face the player.
	ld a, [wPlayerDirection]
	and %00001100
	xor %00000100 ; the opposite direction
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld [hl], a
	pop af
	and a ; FOLLOWER_LEAD
	ld a, BANK(LeadFollowerScript)
	ld hl, LeadFollowerScript
	jr z, .got_script
	ld a, BANK(RentalChanseyScript)
	ld hl, RentalChanseyScript
.got_script
	call CallScript
	scf
	ret

CallRentalChansey::
; Pressing B calls the rented CHANSEY over. Return carry if it came.
	ld a, [wRentalChanseyHeals]
	and a
	ret z
	ld a, FOLLOWER_CHANSEY
	call FindFollowerStruct
	ret nc
	ld a, BANK(RentalChanseyScript)
	ld hl, RentalChanseyScript
	call CallScript
	scf
	ret
