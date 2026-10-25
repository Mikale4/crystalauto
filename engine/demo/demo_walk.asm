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
; (people in the way, maybe: it looks again in a while)
	xor a
	ld [wDemoPad], a
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
	ld a, DOWN
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
	xor a ; (nowhere: wait)
	ld [wDemoPad], a
	and a
	ret

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
; every warp of this map to map (wDemoGoalX, wDemoGoalY)
	ld a, BANK(wCurMapWarpEventCount)
	ldh [rWBK], a
	ld a, [wCurMapWarpEventCount]
	and a
	ret z
	ld c, a
	ld hl, wCurMapWarpEventsPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
.warp_loop
	push bc
	push hl
	ld a, BANK(wMapScriptsBank)
	ldh [rWBK], a
	ld a, [wMapScriptsBank]
	ld b, a
	inc hl
	inc hl
	inc hl ; (the warp number)
	ld a, b
	call GetFarByte ; its map group
	ld c, a
	ld a, [wDemoGoalX]
	cp c
	jr nz, .next_warp
	inc hl
	ld a, b
	call GetFarByte ; its map number
	ld c, a
	ld a, [wDemoGoalY]
	cp c
	jr nz, .next_warp
	pop hl
	push hl
	ld a, b
	call GetFarByte ; y
	ld e, a
	inc hl
	ld a, b
	call GetFarByte ; x
	ld d, a
	ld a, BANK(wDemoQueue)
	ldh [rWBK], a
	call DemoSeedGoal
.next_warp
	pop hl
	ld bc, WARP_EVENT_SIZE
	add hl, bc
	pop bc
	dec c
	jr nz, .warp_loop
	ld a, BANK(wDemoQueue)
	ldh [rWBK], a
	ret

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
; a: a collision. Return nz if it's a waterfall, and the way isn't up or down.
	cp COLL_WATERFALL
	jr nz, .not_waterfall
	ld a, [wDemoCellDir]
	cp LEFT
	jr nc, .across
.not_waterfall
	xor a
	ret

.across
	or 1
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
	farcall DemoNextMapTo
	jr c, .lost
; (the link it takes, should there be no way through)
	push hl
	farcall DemoCurMapKey
	ld a, BANK(wDemoTravelFrom)
	ldh [rWBK], a
	ld a, l
	ld [wDemoTravelFrom], a
	ld a, h
	ld [wDemoTravelFrom + 1], a
	pop de
	ld a, e
	ld [wDemoTravelTo], a
	ld a, d
	ld [wDemoTravelTo + 1], a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	farcall DemoKeyMap
; a map it connects to: off that edge; else through its warps
	call DemoConnectionDir
	jr c, .edge
	ld a, b
	ld [wDemoGoalX], a
	ld a, c
	ld [wDemoGoalY], a
	ld a, DGOAL_WARP
	jr .walk

.edge
	ld [wDemoGoalX], a
	xor a
	ld [wDemoGoalY], a
	ld a, DGOAL_EDGE
.walk
	ld [wDemoGoal], a
	call DemoWalk
	and a
	ret

.lost
; (no way at all: try every link again in a while)
	xor a
	ld [wDemoPad], a
	ld hl, wDemoStuck
	inc [hl]
	ld a, [hl]
	cp DEMO_STUCK_FRAMES
	ret c
	ld [hl], 0
	call DemoForgetBlocked
	and a
	ret

DemoBlockLink:
; There's no way along the link travel is taking (wDemoTravelFrom, To): remember it.
	ld a, [wDemoGoal]
	cp DGOAL_WARP
	jr z, .travel
	cp DGOAL_EDGE
	ret nz
.travel
	ld a, BANK(wDemoBlocked)
	ldh [rWBK], a
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
	ld a, [wDemoTravelFrom]
	ld [hli], a
	ld a, [wDemoTravelFrom + 1]
	ld [hli], a
	ld a, [wDemoTravelTo]
	ld [hli], a
	ld a, [wDemoTravelTo + 1]
	ld [hl], a
	farcall DemoForgetRoutes
	xor a
	ld [wDemoFlowKey], a ; (and so the way again)
	ret

DemoConnectionDir:
; Return carry and the direction (UP, DOWN, LEFT, RIGHT) if this map connects
; to map b, c.
	ld hl, .Connections
.loop
	ld a, [hli]
	cp -1
	ret z ; (nc)
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [de]
	cp b
	jr nz, .next
	inc de
	ld a, [de]
	cp c
	jr nz, .next
	ld a, [hl]
	scf
	ret

.next
	inc hl
	jr .loop

.Connections:
	dw wNorthConnectedMapGroup
	db UP
	dw wSouthConnectedMapGroup
	db DOWN
	dw wWestConnectedMapGroup
	db LEFT
	dw wEastConnectedMapGroup
	db RIGHT
	db -1
