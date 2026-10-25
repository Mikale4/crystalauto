; The Demo's walking: a flow field over the map to its goal, worked out from
; the goal back (so every cell knows its way, even after a detour or a battle),
; and the way from map to map (engine/demo/demo_world.asm).
;
; While it works, w3_d000 holds each cell's collision (COLL_WALL where it can't
; stand: walls, water, pits, people) and w4_d000 each cell's way to the goal
; (a direction, DFLOW_GOAL or DFLOW_UNREACHED). A cell's index is
; y * wDemoGridW + x, in steps. These two WRAM banks are only used by mobile
; features and the BATTLE TOWER, which the Demo never goes near.

	assert LOW(w3_d000) == 0 && LOW(w4_d000) == 0, \
		"the Demo's map banks must start on a page"

DEF DEMO_STUCK_FRAMES EQU 60 ; overworld frames without a step before it looks again

DemoWalk:
; Walk to the goal (wDemoGoal, wDemoGoalX, wDemoGoalY). Return carry once
; there: on the cell, or facing what it's to face. (A warp or an edge is never
; "there": it leaves the map.)
	call DemoCheckFlow
	ld a, [wXCoord]
	ld d, a
	ld a, [wYCoord]
	ld e, a
	call DemoFlowAt
	cp DFLOW_GOAL
	jr z, .at_goal
	cp DFLOW_UNREACHED
	jr z, .no_way
	ld b, a
	push bc
	call DemoObstacleAhead
	pop bc
	jr c, .field_move
	ld a, b
	call DemoDirPad
	call DemoHold
	jp DemoCheckStuck

.field_move
; face it, then A (the game asks whether to use the move: YES)
	ld a, [wPlayerDirection]
	rrca
	rrca
	and %11
	cp b
	jr z, .press_a
	ld a, b
	call DemoDirPad
	call DemoHold
	jp DemoCheckStuck

.press_a
	ldh a, [hJoyDown]
	and PAD_A
	ld a, PAD_A
	jr z, .a
	xor a ; (a fresh press each time)
.a
	ld [wDemoPad], a
	jp DemoCheckStuck

.no_way
; (people in the way, maybe: it looks again in a while; if there's still no way
; to a cell or something to face, it goes round to where there is one, if it
; can: DemoStartHop)
	xor a
	ld [wDemoPad], a
	ld a, [wDemoStuck]
	cp DEMO_STUCK_FRAMES - 1
	jp nz, DemoCheckStuck
	ld a, [wDemoGoal]
	cp DGOAL_CELL
	jr z, .no_way_again
	cp DGOAL_FACE
	jp nz, DemoCheckStuck
.no_way_again
	ld a, BANK(wDemoNoWay)
	ldh [rWBK], a
	ld a, [wDemoTravelling]
	ld b, a
	ld hl, wDemoNoWay
	inc [hl]
	ld c, [hl]
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld a, b
	and a
	jp nz, DemoCheckStuck ; (DemoBlockLink sees to that)
	ld a, c
	cp 2
	call nc, DemoStartHop
	jp DemoCheckStuck

.at_goal
	xor a
	ld [wDemoStuck], a
	ld a, [wDemoGoal]
	cp DGOAL_CELL
	jr z, .there
	cp DGOAL_GRASS
	jr z, .grass
	cp DGOAL_FACE
	jr z, .face
	cp DGOAL_SWEEP
	jr z, .there
	cp DGOAL_EDGE
	jr z, .edge
; a warp: go through it
	ld a, [wXCoord]
	add 4
	ld d, a
	ld a, [wYCoord]
	add 4
	ld e, a
	call GetCoordTileCollision
	call DemoCarpetDir
	jr c, .hold_dir
; (it's on the warp it came in by: off it, and back on)
	call DemoOffGoalDir
	jr .hold_dir

.edge
	ld a, [wDemoGoalX]
.hold_dir
	call DemoDirPad
	call DemoHold
	and a
	ret

.grass
; on to another grass cell, any way it can (and for a while the same way)
	ld a, [wDemoPad]
	and PAD_CTRL_PAD
	jr z, .new_dir
	call Random
	cp 20 percent
	jr nc, .same_dir
.new_dir
	call Random
	and %11
	ld b, NUM_DIRECTIONS
.try_dir
	push af
	push bc
	call DemoGrassThatWay
	pop bc
	jr c, .grass_dir
	pop af
	inc a
	and %11
	dec b
	jr nz, .try_dir
; (no more grass next to it: off it, and back on, for another try)
	call DemoOffGoalDir
	jr .hold_dir

.grass_dir
	pop af
	jr .hold_dir

.same_dir
	ld a, [wDemoPad]
	and a
	ret ; (nc)

.there
	xor a
	ld [wDemoPad], a
	scf
	ret

.face
; turn to face the goal (next to it, or across a counter)
	call DemoDirToGoal
	ld b, a
	ld a, [wPlayerDirection]
	rrca
	rrca
	and %11
	cp b
	jr z, .there
	ld a, b
	jr .hold_dir

DemoObstacleAhead:
; b: the way the flow goes. Return carry if what's that way needs a field move
; first: a CUT tree, water (while it isn't surfing), a whirlpool, a waterfall to
; go up, or a rock to smash.
	ld a, [wXCoord]
	ld d, a
	ld a, [wYCoord]
	ld e, a
	ld a, b
	and a ; DOWN
	jr nz, .not_down
	inc e
	jr .got_cell
.not_down
	dec a ; UP
	jr nz, .not_up
	dec e
	jr .got_cell
.not_up
	dec a ; LEFT
	jr nz, .right
	dec d
	jr .got_cell
.right
	inc d
.got_cell
	push bc
	push de
	ld a, d
	add 4
	ld d, a
	ld a, e
	add 4
	ld e, a
	call GetCoordTileCollision
	pop de
	pop bc
	cp COLL_CUT_TREE
	jr z, .yes
	cp COLL_CUT_TREE_1A
	jr z, .yes
	cp COLL_WHIRLPOOL
	jr z, .yes
	cp COLL_WHIRLPOOL_2C
	jr z, .yes
	cp COLL_WATERFALL
	jr z, .waterfall
	push bc
	push de
	call GetTilePermission
	pop de
	pop bc
	and $f
	cp WATER_TILE
	jr nz, .rock
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .no
	cp PLAYER_SURF_PIKA
	jr z, .no
.yes
	scf
	ret

.waterfall
	ld a, b
	cp UP
	jr z, .yes
.no
	and a
	ret

.rock
; a rock to smash there?
	ld a, d
	add 4
	ld d, a
	ld a, e
	add 4
	ld e, a
	ld hl, wObjectStructs + OBJECT_LENGTH ; (not the player)
	ld c, NUM_OBJECT_STRUCTS - 1
.object
	ld a, [hl] ; OBJECT_SPRITE
	cp SPRITE_ROCK
	jr nz, .next_object
	push hl
	ld a, l
	add OBJECT_MAP_X
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [hli]
	cp d
	jr nz, .not_there
	ld a, [hl]
	cp e
	jr nz, .not_there
	pop hl
	scf
	ret

.not_there
	pop hl
.next_object
	push bc
	ld bc, OBJECT_LENGTH
	add hl, bc
	pop bc
	dec c
	jr nz, .object
	and a
	ret

DemoFieldMoves:
; wDemoFieldMoves: what the team can get past, as the game checks it (someone
; knows the move, or the PACK has its HM or TM; and the badge for it).
	ld c, 0 ; (the flags)
	ld b, 1 ; (this move's)
	ld hl, .Moves
.loop
	ld a, [hli]
	and a
	jr z, .done
	push hl
	push bc
	ld d, a
	farcall CheckPartyMove
	pop bc
	pop hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	jr c, .next
	ld a, d
	and e
	inc a
	jr z, .yes ; (no badge needed)
	push hl
	push bc
	ld b, CHECK_FLAG
	farcall EngineFlagAction
	ld a, c
	pop bc
	pop hl
	and a
	jr z, .next
.yes
	ld a, c
	or b
	ld c, a
.next
	sla b
	jr .loop

.done
	ld a, BANK(wDemoFieldMoves)
	ldh [rWBK], a
	ld a, c
	ld [wDemoFieldMoves], a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ret

.Moves:
; in DEMOFIELD_* order: the move, and the badge it needs
	db CUT
	dw ENGINE_HIVEBADGE
	db SURF
	dw ENGINE_FOGBADGE
	db WHIRLPOOL
	dw ENGINE_GLACIERBADGE
	db WATERFALL
	dw ENGINE_RISINGBADGE
	db ROCK_SMASH
	dw -1 ; (none)
	db 0 ; end

DemoGrassThatWay:
; a: a direction. Return carry if the cell that way from the player is grass
; it can stand on.
	ld [wDemoGoalArg], a
	ld a, [wXCoord]
	ld d, a
	ld a, [wYCoord]
	ld e, a
	ld a, [wDemoGoalArg]
	and a ; DOWN
	jr z, .down
	dec a ; UP
	jr z, .up
	dec a ; LEFT
	jr z, .left
	inc d
	jr .got
.left
	dec d
	jr .got
.up
	dec e
	jr .got
.down
	inc e
.got
	call DemoFlowAt
	cp DFLOW_GOAL
	jr nz, .no
	ld a, [wDemoGoalArg]
	scf
	ret

.no
	and a
	ret


DemoDirToGoal:
; Return the direction from the player toward (wDemoGoalX, wDemoGoalY).
	ld a, [wDemoGoalX]
	ld b, a
	ld a, [wXCoord]
	cp b
	jr z, .same_x
	ld a, RIGHT
	ret c
	ld a, LEFT
	ret

.same_x
	ld a, [wDemoGoalY]
	ld b, a
	ld a, [wYCoord]
	cp b
	ld a, DOWN
	ret c
	ld a, UP
	ret

DemoCarpetDir:
; a: a collision. Return carry and its direction if it's a warp carpet.
	ld b, DOWN
	cp COLL_WARP_CARPET_DOWN
	jr z, .yes
	ld b, UP
	cp COLL_WARP_CARPET_UP
	jr z, .yes
	ld b, LEFT
	cp COLL_WARP_CARPET_LEFT
	jr z, .yes
	ld b, RIGHT
	cp COLL_WARP_CARPET_RIGHT
	jr z, .yes
	and a
	ret

.yes
	ld a, b
	scf
	ret

DemoOffGoalDir:
; On its goal (the warp it came in by, the only grass there): return in a a way
; off it to a cell the way leads back from.
	ld c, DOWN
.off
	ld a, [wXCoord]
	ld d, a
	ld a, [wYCoord]
	ld e, a
	ld a, c
	and a ; DOWN
	jr nz, .not_down
	inc e
	jr .check
.not_down
	dec a ; UP
	jr nz, .not_up
	dec e
	jr .check
.not_up
	dec a ; LEFT
	jr nz, .right
	dec d
	jr .check
.right
	inc d
.check
	push bc
	call DemoFlowAt
	pop bc
	cp NUM_DIRECTIONS
	ld a, c
	ret c
	inc c
	ld a, c
	cp NUM_DIRECTIONS
	jr c, .off
	xor a ; DOWN (no way back: it tries anyway)
	ret

DemoDirPad:
; a: a direction. Return its D-pad button in a.
	ld e, a
	ld d, 0
	ld hl, .Pads
	add hl, de
	ld a, [hl]
	ret

.Pads:
	db PAD_DOWN, PAD_UP, PAD_LEFT, PAD_RIGHT

DemoCheckStuck:
; Return nc. If the player hasn't moved for a while, it works out the way again
; (people move).
	ld a, [wXCoord]
	ld hl, wDemoLastX
	cp [hl]
	jr nz, .moved
	ld a, [wYCoord]
	ld hl, wDemoLastY
	cp [hl]
	jr nz, .moved
	ld hl, wDemoStuck
	inc [hl]
	ld a, [hl]
	cp DEMO_STUCK_FRAMES
	jr c, .done
	ld [hl], 0
	xor a
	ld [wDemoFlowKey], a ; (no map group 0: it works it out again)
.done
	and a
	ret

.moved
	ld a, [wXCoord]
	ld [wDemoLastX], a
	ld a, [wYCoord]
	ld [wDemoLastY], a
	xor a
	ld [wDemoStuck], a
	ret

DemoCheckFlow:
; Work out the flow field again if the map or the goal changed.
	ld hl, wDemoFlowKey
	ld a, [wMapGroup]
	cp [hl]
	jr nz, .new
	inc hl
	ld a, [wMapNumber]
	cp [hl]
	jr nz, .new
	inc hl
	ld a, [wDemoGoal]
	cp [hl]
	jr nz, .new
	inc hl
	ld a, [wDemoGoalX]
	cp [hl]
	jr nz, .new
	inc hl
	ld a, [wDemoGoalY]
	cp [hl]
	ret z
.new
	ld hl, wDemoFlowKey
	ld a, [wMapGroup]
	ld [hli], a
	ld a, [wMapNumber]
	ld [hli], a
	ld a, [wDemoGoal]
	ld [hli], a
	ld a, [wDemoGoalX]
	ld [hli], a
	ld a, [wDemoGoalY]
	ld [hl], a
	jp DemoBuildFlow

DemoCellIndex:
; (d, e): a cell. Return its index in hl.
	ld a, [wDemoGridW]
	ld c, a
	ld b, 0
	ld hl, 0
	ld a, e
	and a
	jr z, .got_row
.row
	add hl, bc
	dec a
	jr nz, .row
.got_row
	ld c, d
	add hl, bc
	ret

DemoFlowAt:
; (d, e): a cell. Return its way to the goal in a (bank 1 stays).
	ld a, [wDemoGridW]
	dec a
	cp d
	jr c, .off
	ld a, [wDemoGridH]
	dec a
	cp e
	jr c, .off
	call DemoCellIndex
	ld a, h
	add HIGH(w4_d000)
	ld h, a
	ld a, BANK(w4_d000)
	ldh [rWBK], a
	ld b, [hl]
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld a, b
	ret

.off
	ld a, DFLOW_UNREACHED
	ret

DemoBuildFlow:
; Work out every cell's way to the goal.
	call DemoFieldMoves
	ld a, [wMapWidth]
	add a
	ld [wDemoGridW], a
	ld a, [wMapHeight]
	add a
	ld [wDemoGridH], a
	call DemoMapCollisions
	call DemoMarkPeople
; nowhere is reached yet
	ld a, BANK(w4_d000)
	ldh [rWBK], a
	ld hl, w4_d000
	ld bc, $1000
	ld a, DFLOW_UNREACHED
	call ByteFill
; the goals, then back from them
	ld a, BANK(wDemoQueue)
	ldh [rWBK], a
	ld hl, wDemoQueue
	ld a, l
	ld [wDemoQueueHead], a
	ld [wDemoQueueTail], a
	ld a, h
	ld [wDemoQueueHead + 1], a
	ld [wDemoQueueTail + 1], a
	call DemoSeedGoals
	call DemoSearch
	ld a, BANK(wXCoord)
	ldh [rWBK], a
; no way from where the player is: not along this link, then
	ld a, [wXCoord]
	ld d, a
	ld a, [wYCoord]
	ld e, a
	call DemoFlowAt
	cp DFLOW_UNREACHED
	ret nz
	call DemoBlockLink
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ret

DemoMapCollisions:
; w3_d000: each cell's collision (COLL_WALL where it can't stand).
	ld hl, 0 ; (the index)
	ld e, 0
.row
	ld d, 0
.cell
	push hl
	push de
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld a, d
	add 4
	ld d, a
	ld a, e
	add 4
	ld e, a
	call GetCoordTileCollision
	pop de
	push de
	call DemoWarpTileHere
	call DemoStandable
	pop de
	pop hl
	push hl
	ld b, a
	ld a, h
	add HIGH(w3_d000)
	ld h, a
	ld a, BANK(w3_d000)
	ldh [rWBK], a
	ld [hl], b
	pop hl
	inc hl
	inc d
	ld a, [wDemoGridW]
	cp d
	jr nz, .cell
	inc e
	ld a, [wDemoGridH]
	cp e
	jr nz, .row
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ret

DemoWarpTileHere:
; a: the collision at cell d, e. A warp's tile only warps where the map has a warp
; (GetDestinationWarpNumber): anywhere else it's floor. Return the collision.
	ld b, a
	and $f0
	cp HI_NYBBLE_WARPS
	ld a, b
	ret nz
	ld a, [wCurMapWarpEventCount]
	and a
	jr z, .floor
	ld c, a
	ld hl, wCurMapWarpEventsPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop
	ld a, [wMapScriptsBank]
	call GetFarByte
	cp e
	jr nz, .next
	inc hl
	ld a, [wMapScriptsBank]
	call GetFarByte
	dec hl
	cp d
	jr nz, .next
	ld a, b
	ret

.next
	ld a, WARP_EVENT_SIZE
	add l
	ld l, a
	jr nc, .no_carry
	inc h
.no_carry
	dec c
	jr nz, .loop
.floor
	ld a, COLL_FLOOR
	ret

DemoStandable:
; a: a collision. Return it, or COLL_WALL if no one can stand there, or the team
; can't get there: CUT trees, water, whirlpools and waterfalls need their field
; moves (wDemoFieldMoves). (WRAM bank 1.)
	cp -1 ; (off the map)
	jr z, .wall
	ld b, a
	ld c, DEMOFIELD_CUT_F
	cp COLL_CUT_TREE
	jr z, .field_move
	cp COLL_CUT_TREE_1A
	jr z, .field_move
	ld c, DEMOFIELD_WHIRLPOOL_F
	cp COLL_WHIRLPOOL
	jr z, .field_move
	cp COLL_WHIRLPOOL_2C
	jr z, .field_move
	ld c, DEMOFIELD_WATERFALL_F
	cp COLL_WATERFALL
	jr z, .field_move
	and $f0
	cp COLL_PIT & $f0
	jr z, .wall
	cp HI_NYBBLE_CURRENT ; (not yet)
	jr z, .wall
	ld a, b
	push bc
	call GetTilePermission
	pop bc
	and $f
	jr z, .land
	cp WATER_TILE
	jr nz, .wall
	ld c, DEMOFIELD_SURF_F
.field_move
	ld a, BANK(wDemoFieldMoves)
	ldh [rWBK], a
	ld a, [wDemoFieldMoves]
	ld h, a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld a, h
	inc c
.bit
	dec c
	jr z, .got_bit
	rrca
	jr .bit
.got_bit
	and 1
	jr z, .wall
.land
	ld a, b
	ret

.wall
	ld a, COLL_WALL
	ret

DemoMarkPeople:
; People (but followers) stand in the way: COLL_WALL in w3_d000.
	ld hl, wObjectStructs + OBJECT_LENGTH ; (not the player)
	ld c, NUM_OBJECT_STRUCTS - 1
.loop
	push hl
	push bc
	ld a, BANK(wObjectStructs)
	ldh [rWBK], a
	ld a, [hl] ; OBJECT_SPRITE
	and a
	jr z, .next
	push hl
	ld bc, OBJECT_MOVEMENT_TYPE
	add hl, bc
	ld a, [hl]
	pop hl
	cp SPRITEMOVEDATA_FOLLOWER
	jr z, .next
	ld a, [hl] ; OBJECT_SPRITE
	cp SPRITE_ROCK
	jr nz, .in_the_way
	ld a, BANK(wDemoFieldMoves)
	ldh [rWBK], a
	ld a, [wDemoFieldMoves]
	bit DEMOFIELD_ROCK_SMASH_F, a
	jr nz, .next ; (it smashes it)
	ld a, BANK(wObjectStructs)
	ldh [rWBK], a
.in_the_way
	ld bc, OBJECT_MAP_X
	add hl, bc
	ld a, [hli]
	sub 4
	ld d, a
	ld a, [hl]
	sub 4
	ld e, a
	ld a, [wDemoGridW]
	dec a
	cp d
	jr c, .next
	ld a, [wDemoGridH]
	dec a
	cp e
	jr c, .next
	call DemoCellIndex
	ld a, h
	add HIGH(w3_d000)
	ld h, a
	ld a, BANK(w3_d000)
	ldh [rWBK], a
	ld [hl], COLL_WALL
.next
	pop bc
	pop hl
	ld de, OBJECT_LENGTH
	add hl, de
	dec c
	jr nz, .loop
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ret

DemoCollAtIndex:
; hl: a cell index. Return its collision in a (WRAM bank 2 after).
	push hl
	ld a, h
	add HIGH(w3_d000)
	ld h, a
	ld a, BANK(w3_d000)
	ldh [rWBK], a
	ld l, [hl]
	ld a, BANK(wDemoQueue)
	ldh [rWBK], a
	ld a, l
	pop hl
	ret

DemoFlowAtIndex:
; hl: a cell index. Return its way in a (WRAM bank 2 after).
	push hl
	ld a, h
	add HIGH(w4_d000)
	ld h, a
	ld a, BANK(w4_d000)
	ldh [rWBK], a
	ld l, [hl]
	ld a, BANK(wDemoQueue)
	ldh [rWBK], a
	ld a, l
	pop hl
	ret

DemoMark:
; Cell (d, e), index hl: its way is a; look on from it later (WRAM bank 2).
	push hl
	ld b, a
	ld a, h
	add HIGH(w4_d000)
	ld h, a
	ld a, BANK(w4_d000)
	ldh [rWBK], a
	ld [hl], b
	ld a, BANK(wDemoQueue)
	ldh [rWBK], a
	pop bc ; (the index)
	ld hl, wDemoQueueTail
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ld [hl], c
	inc hl
	ld [hl], b
	inc hl
	ld a, l
	cp LOW(wDemoQueueEnd)
	jr nz, .no_wrap
	ld a, h
	cp HIGH(wDemoQueueEnd)
	jr nz, .no_wrap
	ld hl, wDemoQueue
.no_wrap
	ld a, l
	ld [wDemoQueueTail], a
	ld a, h
	ld [wDemoQueueTail + 1], a
	ret

DemoSeedGoal:
; Cell (d, e) is a goal, if it's on the map and free (WRAM bank 2).
	ld a, [wDemoGridW]
	dec a
	cp d
	ret c
	ld a, [wDemoGridH]
	dec a
	cp e
	ret c
	push de
	call DemoCellIndex
	pop de
	call DemoCollAtIndex
	cp COLL_WALL
	ret z
	call DemoFlowAtIndex
	cp DFLOW_GOAL
	ret z
	ld a, DFLOW_GOAL
	jp DemoMark

DemoSeedGoals:
; (WRAM bank 2)
	ld a, [wDemoGoal]
	cp DGOAL_CELL
	jr z, .cell
	cp DGOAL_WARP
	jr z, .warps
	cp DGOAL_EDGE
	jp z, .edge
	cp DGOAL_FACE
	jp z, .face
	cp DGOAL_SWEEP
	jp z, .sweep
	cp DGOAL_GRASS
	ret nz
; every grass cell (where wild POKéMON are)
	ld hl, 0
	ld e, 0
.grass_row
	ld d, 0
.grass_cell
	call DemoCollAtIndex
	and $f0
	cp COLL_TALL_GRASS & $f0
	jr nz, .not_grass
	push hl
	push de
	call DemoSeedGoal
	pop de
	pop hl
.not_grass
	inc hl
	inc d
	ld a, [wDemoGridW]
	cp d
	jr nz, .grass_cell
	inc e
	ld a, [wDemoGridH]
	cp e
	jr nz, .grass_row
	ret

.cell
	ld a, [wDemoGoalX]
	ld d, a
	ld a, [wDemoGoalY]
	ld e, a
	jp DemoSeedGoal

.warps
; the warp at (wDemoGoalX, wDemoGoalY)
	ld a, [wDemoGoalX]
	ld d, a
	ld a, [wDemoGoalY]
	ld e, a
	jp DemoSeedGoal

.edge
; the cells along that edge with a way off it
	ld a, [wDemoGoalX]
	cp DOWN
	jr z, .south
	cp UP
	jr z, .north
	cp LEFT
	jr z, .west
; east
	ld a, [wDemoGridW]
	dec a
	ld d, a
	ld e, 0
	ld bc, 1 << 8 | 0 ; (outside: x + 1)
	jr .down_the_edge

.west
	ld d, 0
	ld e, 0
	ld bc, -1 << 8 | 0
.down_the_edge
	ld a, [wDemoGridH]
	ld l, a
.down_loop
	push hl
	push bc
	push de
	call .EdgeCell
	pop de
	pop bc
	pop hl
	inc e
	dec l
	jr nz, .down_loop
	ret

.north
	ld d, 0
	ld e, 0
	ld bc, 0 << 8 | LOW(-1) ; (outside: y - 1)
	jr .along_the_edge

.south
	ld d, 0
	ld a, [wDemoGridH]
	dec a
	ld e, a
	ld bc, 0 << 8 | 1
.along_the_edge
	ld a, [wDemoGridW]
	ld l, a
.along_loop
	push hl
	push bc
	push de
	call .EdgeCell
	pop de
	pop bc
	pop hl
	inc d
	dec l
	jr nz, .along_loop
	ret

.EdgeCell:
; (d, e) on the edge, (d + b, e + c) off it: a goal if one can walk off there.
	push de
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld a, d
	add 4
	add b
	ld d, a
	ld a, e
	add 4
	add c
	ld e, a
	call GetCoordTileCollision
	call DemoStandable
	pop de
	ld b, a
	ld a, BANK(wDemoQueue)
	ldh [rWBK], a
	ld a, b
	cp COLL_WALL
	ret z
	jp DemoSeedGoal

.sweep
; next to each of the map's targets still to do (see DemoTargetOpen)
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	call DemoCurMapTargets
	jr c, .swept
.sweep_loop
	push bc
	push de
	call DemoTargetOpen
	jr nc, .sweep_next
	ld a, b
	ld [wDemoGoalX], a
	ld a, c
	ld [wDemoGoalY], a
	ld a, BANK(wDemoQueue)
	ldh [rWBK], a
	call .face
	ld a, BANK(wXCoord)
	ldh [rWBK], a
.sweep_next
	pop de
	pop bc
	inc de
	dec c
	jr nz, .sweep_loop
.swept
	xor a
	ld [wDemoGoalX], a
	ld [wDemoGoalY], a
	ld a, BANK(wDemoQueue)
	ldh [rWBK], a
	ret

.face
; next to it (or across a counter from it)
	xor a
.face_loop
	push af
	call .FaceCell
	pop af
	inc a
	cp NUM_DIRECTIONS
	jr c, .face_loop
	ret

.FaceCell:
	ld [wDemoCellDir], a
	ld a, [wDemoGoalX]
	ld d, a
	ld a, [wDemoGoalY]
	ld e, a
	call DemoStepToward
	ret c
	push de
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld a, d
	add 4
	ld d, a
	ld a, e
	add 4
	ld e, a
	call GetCoordTileCollision
	pop de
	ld b, a
	ld a, BANK(wDemoQueue)
	ldh [rWBK], a
	ld a, b
	cp COLL_COUNTER
	jp nz, DemoSeedGoal
	call DemoStepToward
	ret c
	jp DemoSeedGoal

DemoStepToward:
; (d, e) one step in direction [wDemoCellDir]; carry if it leaves the map.
	ld a, [wDemoCellDir]
	and a ; DOWN
	jr z, .down
	dec a ; UP
	jr z, .up
	dec a ; LEFT
	jr z, .left
; right
	inc d
	ld a, [wDemoGridW]
	cp d
	jr z, .off
	and a
	ret

.left
	ld a, d
	and a
	jr z, .off
	dec d
	ret

.up
	ld a, e
	and a
	jr z, .off
	dec e
	ret

.down
	inc e
	ld a, [wDemoGridH]
	cp e
	jr z, .off
	and a
	ret

.off
	scf
	ret

DemoStepBack:
; Cell (d, e), index hl, one step back from direction [wDemoCellDir] (where it
; would have come from); carry if that's off the map.
	ld a, [wDemoCellDir]
	and a ; DOWN: from above
	jr z, .from_above
	dec a ; UP: from below
	jr z, .from_below
	dec a ; LEFT: from the right
	jr z, .from_right
; RIGHT: from the left
	ld a, d
	and a
	jr z, .off
	dec d
	dec hl
	and a
	ret

.from_right
	inc d
	ld a, [wDemoGridW]
	cp d
	jr z, .off
	inc hl
	and a
	ret

.from_above
	ld a, e
	and a
	jr z, .off
	dec e
	ld a, [wDemoGridW]
	cpl
	ld c, a
	ld b, -1
	inc bc
	add hl, bc ; (hl - width)
	and a
	ret

.from_below
	inc e
	ld a, [wDemoGridH]
	cp e
	jr z, .off
	ld a, [wDemoGridW]
	ld c, a
	ld b, 0
	add hl, bc
	and a
	ret

.off
	scf
	ret

DemoSearch:
; From the goals back: each cell reached learns the way it came (WRAM bank 2).
.loop
	ld hl, wDemoQueueHead
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wDemoQueueTail]
	cp l
	jr nz, .pop
	ld a, [wDemoQueueTail + 1]
	cp h
	ret z
.pop
	ld a, [hli]
	ld [wDemoCellX], a
	ld a, [hli]
	ld [wDemoCellY], a
	ld a, [hli]
	ld [wDemoCellIndex], a
	ld a, [hli]
	ld [wDemoCellIndex + 1], a
	ld a, l
	cp LOW(wDemoQueueEnd)
	jr nz, .no_wrap
	ld a, h
	cp HIGH(wDemoQueueEnd)
	jr nz, .no_wrap
	ld hl, wDemoQueue
.no_wrap
	ld a, l
	ld [wDemoQueueHead], a
	ld a, h
	ld [wDemoQueueHead + 1], a
; (not on from a warp it isn't going to)
	call .Cell
	call DemoCollAtIndex
	and $f0
	cp HI_NYBBLE_WARPS
	jr nz, .dirs
	call DemoFlowAtIndex
	cp DFLOW_GOAL
	jr nz, .loop
.dirs
	xor a ; DOWN
.dir_loop
	ld [wDemoCellDir], a
	call DemoTryFrom
	ld a, [wDemoCellDir]
	inc a
	cp NUM_DIRECTIONS
	jr c, .dir_loop
	jr .loop

.Cell:
; (d, e), hl: the cell being looked at
	ld a, [wDemoCellX]
	ld d, a
	ld a, [wDemoCellY]
	ld e, a
	ld a, [wDemoCellIndex]
	ld l, a
	ld a, [wDemoCellIndex + 1]
	ld h, a
	ret

DemoTryFrom:
; Could the player reach the cell being looked at by moving [wDemoCellDir]?
; A step from the cell before it, a jump from a ledge two cells back, or a slide
; over ice from further back (on ice the player slides on till off it, or till
; something's in the way).
	call DemoSearch.Cell
	call DemoCollAtIndex
	call DemoIsIce
	jr nz, .stops
; (no one sliding this way stops on this ice if they can go on)
	call DemoStepToward
	ret c ; (off the map: nowhere to go on)
	push de
	call DemoCellIndex
	pop de
	call DemoCollAtIndex
	cp COLL_WALL
	ret nz
.stops
	call DemoSearch.Cell
	call DemoStepBack
	ret c
	push de
	push hl
	call DemoFlowAtIndex
	cp DFLOW_UNREACHED
	jr nz, .no_step
	call DemoCanStep
	jr nc, .no_step
	pop hl
	pop de
	push de
	push hl
	ld a, [wDemoCellDir]
	call DemoMark
.no_step
	pop hl
	pop de
	call DemoCollAtIndex
	call DemoIsIce
	jr z, .slid
; a jump: over a cell no one can stand on, from a ledge that way
	cp COLL_WALL
	ret nz
	call DemoStepBack
	ret c
	call DemoFlowAtIndex
	cp DFLOW_UNREACHED
	ret nz
	call DemoCollAtIndex
	ld b, a
	and $f0
	cp HI_NYBBLE_LEDGES
	ret nz
	ld a, b
	and 7
	push hl
	ld hl, DemoLedgeDirs
	call DemoDirInMask
	pop hl
	ret z
	ld a, [wDemoCellDir]
	jp DemoMark

.slid
; the cell before was ice: the slide may have begun further back
	call DemoStepBack
	ret c
	call DemoCollAtIndex
	cp COLL_WALL
	ret z
	push af
	call DemoFlowAtIndex
	cp DFLOW_UNREACHED
	jr nz, .slid_on
	push de
	push hl
	ld a, [wDemoCellDir]
	call DemoMark
	pop hl
	pop de
.slid_on
	pop af
	call DemoIsIce
	jr z, .slid
	ret

DemoIsIce:
; a: a collision. Return z if it's ice.
	cp COLL_ICE
	ret z
	cp COLL_ICE_2B
	ret

DemoCanStep:
; hl: a cell. Return carry if the player can step from it [wDemoCellDir] into
; the cell being looked at (its side walls and the other's allowing; and only
; up or down a waterfall).
	call DemoCollAtIndex
	cp COLL_WALL
	jr z, .no
	call .Waterfall
	jr nz, .no
	ld hl, DemoSideWallExits
	call .Walls
	jr nz, .no
	push de
	call DemoSearch.Cell
	pop de
	call DemoCollAtIndex
	call .Waterfall
	jr nz, .no
	ld hl, DemoSideWallEntries
	call .Walls
	jr nz, .no
	scf
	ret

.Waterfall:
; a: a collision (kept, for .Walls). Return nz if it's a waterfall, and the way
; isn't up or down.
	ld b, a
	cp COLL_WATERFALL
	jr nz, .not_waterfall
	ld a, [wDemoCellDir]
	cp LEFT
	jr nc, .across
.not_waterfall
	ld a, b
	cp a ; (z)
	ret

.across
	ld a, b
	and a ; (nz)
	ret

.no
	and a
	ret

.Walls:
; a: a collision; hl: which way its side walls block. Return nz if blocked.
	ld b, a
	and $f0
	cp HI_NYBBLE_SIDE_WALLS
	jr z, .side
	cp HI_NYBBLE_SIDE_BUOYS
	jr z, .side
	xor a
	ret

.side
	ld a, b
	and 7
	; fallthrough

DemoDirInMask:
; a: an index into the masks at hl. Return nz if its mask has [wDemoCellDir].
	add l
	ld l, a
	adc h
	sub l
	ld h, a
	ld a, [wDemoCellDir]
	ld b, a
	ld a, [hl]
	inc b
.shift
	dec b
	jr z, .got
	rrca
	jr .shift
.got
	and 1
	ret

; directions as bits: DOWN 1, UP 2, LEFT 4, RIGHT 8
DemoSideWallExits:
; which ways a side wall tile can't be left (as GetMovementPermissions)
	db 8, 4, 2, 1, 9, 5, 10, 6
DemoSideWallEntries:
; which ways it can't be walked into
	db 4, 8, 1, 2, 6, 10, 5, 9
DemoLedgeDirs:
; which ways a ledge can be jumped from (as DoPlayerMovement's .ledge_table)
	db 8, 4, 2, 1, 9, 5, 10, 6

DemoTravel:
; Travel toward map b (group), c (number). Return carry once there.
	ld a, [wMapGroup]
	cp b
	jr nz, .go
	ld a, [wMapNumber]
	cp c
	jr nz, .go
	scf
	ret

.go
	farcall DemoMapKey
	jr c, .lost
	ld d, h
	ld e, l
	farcall DemoRouteTo
	jr c, .lost
	; fallthrough

DemoTravelStep:
; Walk the first step of the way (DemoRouteTo: b, c, de). Return nc.
	ld a, b
	cp DEDGE_EDGE
	jr z, .edge
	cp DEDGE_WALK
	jr z, .walk_on
; through a warp: its cell
	ld a, c
	call DemoWarpCell
	ld a, DGOAL_WARP
	jr .goal

.edge
; off the edge (the direction in wDemoGoalX)
	ld d, c
	ld e, 0
	ld a, DGOAL_EDGE
	jr .goal

.walk_on
; to another region of the map (the next node's cell)
	farcall DemoNodeCell
	ld a, DGOAL_CELL
.goal
	ld [wDemoGoal], a
	ld a, d
	ld [wDemoGoalX], a
	ld a, e
	ld [wDemoGoalY], a
	ld a, BANK(wDemoTravelling)
	ldh [rWBK], a
	ld a, TRUE
	ld [wDemoTravelling], a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	call DemoWalk
	push af
	ld a, BANK(wDemoTravelling)
	ldh [rWBK], a
	xor a
	ld [wDemoTravelling], a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	pop af
	ret nc
; (only a walk to another region of the map ends here: on from there)
	farcall DemoForgetRoutes
	and a
	ret

DemoTravel.lost:
; (no way at all: try every link again in a while)
	xor a
	ld [wDemoPad], a
	ld hl, wDemoStuck
	inc [hl]
	ld a, [hl]
	cp DEMO_STUCK_FRAMES
	jr c, .wait
	ld [hl], 0
	call DemoForgetBlocked
.wait
	and a
	ret

DemoStartHop:
; There's no way to the goal from where it stands (the flow field): if there's a
; way round to a region of the map that has one (off the map and back, or
; through its warps), it goes there first (wDemoHopNodes: see DemoHop). Return
; carry if there isn't.
	ld a, BANK(wDemoHopCount)
	ldh [rWBK], a
	xor a
	ld [wDemoHopCount], a
	ld [wDemoNoWay], a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	farcall DemoCurMapKey
	ret c
	ld d, h
	ld e, l
	farcall DemoMapNodes
	ld a, c
	and a
	jr z, .none
.node
; is there a way from it?
	push bc
	push de
	farcall DemoNodeCell
	call DemoFlowAt
	pop de
	pop bc
	cp DFLOW_UNREACHED
	call nz, .Add
	inc de
	dec c
	jr nz, .node
	ld a, BANK(wDemoHopCount)
	ldh [rWBK], a
	ld a, [wDemoHopCount]
	ld b, a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld a, b
	and a
	jr z, .none
	farcall DemoForgetRoutes
	farcall DemoHopRoute
	jr c, .none ; (no way round, or it's there already)
	xor a
	ld [wDemoFlowKey], a ; (the search had WRAM bank 3)
	and a
	ret

.none
	ld a, BANK(wDemoHopCount)
	ldh [rWBK], a
	xor a
	ld [wDemoHopCount], a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld [wDemoFlowKey], a
	scf
	ret

.Add:
; de: a node (bc, de kept)
	ld a, BANK(wDemoHopCount)
	ldh [rWBK], a
	ld a, [wDemoHopCount]
	cp DEMO_MAX_HOP_NODES
	jr nc, .full
	inc a
	ld [wDemoHopCount], a
	dec a
	add a
	add LOW(wDemoHopNodes)
	ld l, a
	ld a, HIGH(wDemoHopNodes)
	adc 0
	ld h, a
	ld [hl], e
	inc hl
	ld [hl], d
.full
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ret

DemoHop:
; Going round to another region of the map (DemoStartHop): on its way there.
; Once it's there (or if there's no way after all), it's done.
	farcall DemoHopRoute
	jp nc, DemoTravelStep
	ld a, BANK(wDemoHopCount)
	ldh [rWBK], a
	xor a
	ld [wDemoHopCount], a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld [wDemoFlowKey], a
	ld [wDemoPad], a
	farcall DemoForgetRoutes
	ret

DemoWarpCell:
; a: a warp of this map (from 1). Return its cell in d, e.
	dec a
	ld c, a
	ld b, 0
	ld hl, wCurMapWarpEventsPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, WARP_EVENT_SIZE
	call AddNTimes
	ld a, [wMapScriptsBank]
	ld b, a
	call GetFarByte
	ld e, a ; y
	inc hl
	ld a, b
	call GetFarByte
	ld d, a ; x
	ret

DemoBlockLink:
; There's no way along the step of the way around it's taking (wDemoRouteStart to
; wDemoRouteNode, see DemoTravel): remember it.
	ld a, BANK(wDemoTravelling)
	ldh [rWBK], a
	ld a, [wDemoTravelling]
	and a
	ret z
	ld a, [wDemoBlockedCount]
	cp DEMO_MAX_BLOCKED
	jr nc, .full
	inc a
	ld [wDemoBlockedCount], a
.full
	ld a, [wDemoBlockedNext]
	cp DEMO_MAX_BLOCKED
	jr c, .ok
	xor a
.ok
	ld e, a
	inc a
	ld [wDemoBlockedNext], a
	ld d, 0
	ld hl, wDemoBlocked
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	ld a, [wDemoRouteStart]
	ld [hli], a
	ld a, [wDemoRouteStart + 1]
	ld [hli], a
	ld a, [wDemoRouteNode]
	ld [hli], a
	ld a, [wDemoRouteNode + 1]
	ld [hl], a
	farcall DemoForgetRoutes
	xor a
	ld [wDemoFlowKey], a ; (and so the way again)
	ret

DemoFlood::
; w4_d000: DFLOW_GOAL on each cell the player can get to from where it stands
; with nothing but walking (down ledges, sliding on ice, and on the water if it's
; on it already), DFLOW_UNREACHED elsewhere: which of the map's nodes it can get
; to (see DemoStartNodes). The same ways as tools/demo_regions.py's free moves.
; (The flow field is gone: it's worked out again.)
	xor a
	ld [wDemoFlowKey], a
	call DemoFieldMoves
	ld a, [wMapWidth]
	add a
	ld [wDemoGridW], a
	ld a, [wMapHeight]
	add a
	ld [wDemoGridH], a
	call DemoMapCollisions
	call DemoMarkRocks
	ld a, BANK(w4_d000)
	ldh [rWBK], a
	ld hl, w4_d000
	ld bc, $1000
	ld a, DFLOW_UNREACHED
	call ByteFill
	ld a, BANK(wDemoQueue)
	ldh [rWBK], a
	ld hl, wDemoQueue
	ld a, l
	ld [wDemoQueueHead], a
	ld [wDemoQueueTail], a
	ld a, h
	ld [wDemoQueueHead + 1], a
	ld [wDemoQueueTail + 1], a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld a, [wXCoord]
	ld d, a
	ld a, [wYCoord]
	ld e, a
	ld a, [wDemoGridW]
	dec a
	cp d
	jr c, .done
	ld a, [wDemoGridH]
	dec a
	cp e
	jr c, .done
	push de
	call DemoCellIndex
	pop de
	ld a, BANK(wDemoQueue)
	ldh [rWBK], a
	ld a, DFLOW_GOAL
	call DemoMark
.loop
	ld hl, wDemoQueueHead
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wDemoQueueTail]
	cp l
	jr nz, .pop
	ld a, [wDemoQueueTail + 1]
	cp h
	jr z, .done
.pop
	ld a, [hli]
	ld [wDemoCellX], a
	ld a, [hli]
	ld [wDemoCellY], a
	ld a, [hli]
	ld [wDemoCellIndex], a
	ld a, [hli]
	ld [wDemoCellIndex + 1], a
	ld a, l
	cp LOW(wDemoQueueEnd)
	jr nz, .no_wrap
	ld a, h
	cp HIGH(wDemoQueueEnd)
	jr nz, .no_wrap
	ld hl, wDemoQueue
.no_wrap
	ld a, l
	ld [wDemoQueueHead], a
	ld a, h
	ld [wDemoQueueHead + 1], a
	xor a ; DOWN
.dir
	ld [wDemoCellDir], a
	call DemoSearch.Cell
	call DemoFreeStep
	jr c, .next_dir
	call DemoFlowAtIndex
	cp DFLOW_UNREACHED
	jr nz, .next_dir
	ld a, DFLOW_GOAL
	call DemoMark
.next_dir
	ld a, [wDemoCellDir]
	inc a
	cp NUM_DIRECTIONS
	jr c, .dir
	jr .loop

.done
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ret

DemoFloodReached::
; (d, e): a cell. Return carry if DemoFlood got there.
	call DemoFlowAt
	cp DFLOW_GOAL
	scf
	ret z
	and a
	ret

DemoFreeStep:
; Cell (d, e), index hl: can the player go [wDemoCellDir] from it with nothing but
; walking? Return nc and where it ends up in d, e and hl (a step, a jump down a
; ledge, or a slide on ice), else carry. (WRAM bank 2.)
	call DemoCollAtIndex
	ld [wDemoFloodFrom], a
	cp COLL_WALL
	jp z, .no
	cp COLL_WATERFALL
	jr nz, .not_waterfall
	ld a, [wDemoCellDir]
	cp LEFT
	jp nc, .no ; (only up or down a waterfall)
.not_waterfall
	ld a, [wDemoFloodFrom]
	push hl
	ld hl, DemoSideWallExits
	call DemoCanStep.Walls
	pop hl
	jp nz, .no
	push de
	push hl
	call DemoStepToward
	jp c, .blocked
	push de
	call DemoCellIndex
	pop de
	call DemoCollAtIndex
	ld [wDemoFloodTo], a
	cp COLL_WALL
	jr z, .ledge
	and $f0
	cp HI_NYBBLE_WARPS
	jp z, .blocked ; (on it is through it)
	ld a, [wDemoFloodTo]
	push hl
	ld hl, DemoSideWallEntries
	call DemoCanStep.Walls
	pop hl
	jp nz, .blocked
	ld a, [wDemoFloodTo]
	cp COLL_CUT_TREE
	jp z, .blocked
	cp COLL_CUT_TREE_1A
	jp z, .blocked
	cp COLL_WHIRLPOOL
	jr z, .blocked
	cp COLL_WHIRLPOOL_2C
	jr z, .blocked
	cp COLL_WATERFALL
	jr nz, .not_down_waterfall
	ld a, [wDemoCellDir]
	and a ; DOWN
	jr nz, .blocked
	jr .afloat_only
.not_down_waterfall
	push hl
	push de
	call GetTilePermission
	pop de
	pop hl
	and $f
	cp WATER_TILE
	jr nz, .stepped
.afloat_only
; the water, from the water only (getting on it takes SURF)
	push hl
	push de
	ld a, [wDemoFloodFrom]
	call GetTilePermission
	pop de
	pop hl
	and $f
	cp WATER_TILE
	jr nz, .blocked
.stepped
	add sp, 4 ; (where it was)
.slide
; on ice: on till off it, or till the way's blocked
	call DemoCollAtIndex
	call DemoIsIce
	jr nz, .there
	push de
	push hl
	call DemoStepToward
	jr c, .stop
	push de
	call DemoCellIndex
	pop de
	call DemoCollAtIndex
	cp COLL_WALL
	jr z, .stop
	add sp, 4
	jr .slide

.stop
	pop hl
	pop de
.there
	and a
	ret

.ledge
; a jump down a ledge that way, over the cell no one can stand on
	ld a, [wDemoFloodFrom]
	ld b, a
	and $f0
	cp HI_NYBBLE_LEDGES
	jr nz, .blocked
	ld a, b
	and 7
	push hl
	ld hl, DemoLedgeDirs
	call DemoDirInMask
	pop hl
	jr z, .blocked
	call DemoStepToward
	jr c, .blocked
	push de
	call DemoCellIndex
	pop de
	call DemoCollAtIndex
	cp COLL_WALL
	jr z, .blocked
	jr .stepped

.blocked
	pop hl
	pop de
.no
	scf
	ret

DemoMarkRocks:
; Rocks and boulders stand in the way: COLL_WALL in w3_d000 (as DemoMarkPeople).
	ld hl, wObjectStructs + OBJECT_LENGTH ; (not the player)
	ld c, NUM_OBJECT_STRUCTS - 1
.loop
	push hl
	push bc
	ld a, BANK(wObjectStructs)
	ldh [rWBK], a
	ld a, [hl] ; OBJECT_SPRITE
	cp SPRITE_ROCK
	jr z, .mark
	cp SPRITE_BOULDER
	jr nz, .next
.mark
	ld bc, OBJECT_MAP_X
	add hl, bc
	ld a, [hli]
	sub 4
	ld d, a
	ld a, [hl]
	sub 4
	ld e, a
	ld a, [wDemoGridW]
	dec a
	cp d
	jr c, .next
	ld a, [wDemoGridH]
	dec a
	cp e
	jr c, .next
	call DemoCellIndex
	ld a, h
	add HIGH(w3_d000)
	ld h, a
	ld a, BANK(w3_d000)
	ldh [rWBK], a
	ld [hl], COLL_WALL
.next
	pop bc
	pop hl
	ld de, OBJECT_LENGTH
	add hl, de
	dec c
	jr nz, .loop
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ret
