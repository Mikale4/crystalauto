; The Demo's way around the world: a search over nodes (data/demo/world_nodes.asm,
; made by tools/demo_world.py), each a region of a map with a way out: a warp, or
; a way across to the next map. Its edges are those ways out, and the ways to the
; map's other regions (some needing field moves). The search starts from the
; nodes the player can get to from where it stands (DemoStartNodes), and keeps to
; edges whose field moves the team has (wDemoFieldMoves) and that aren't blocked
; (wDemoBlocked). It works in WRAM bank 3 (each node's way back, then the queue),
; which the walking's flow field uses too (it's worked out again after). The Demo
; calls these by farcall, so they take keys in de and give what they find in bc,
; de, hl and carry.

DEF DEMO_NODE_PREV  EQUS "w3_d000" ; 2 bytes a node: the node it was reached from (-1: not yet)
DEF DEMO_NODE_QUEUE EQUS "(w3_d000 + 2 * NUM_DEMO_NODES)" ; the nodes in order of how far they are

	assert 4 * NUM_DEMO_NODES <= $1000, "the Demo's nodes don't fit in a WRAM bank"

DemoRouteTo::
; de: the key of the map it's going to. Return the first step of the shortest way
; there: the edge's kind (DEDGE_*) in b, its warp or direction in c, and the node
; it leads to in de; carry if there's no way. (It remembers the answer until the
; map changes, or a link is blocked, or a walk to another region of the map ends:
; see DemoForgetRoutes.)
	push de
	farcall DemoCurMapKey
	pop de
	ret c
	ld a, BANK(wDemoRouteFrom)
	ldh [rWBK], a
	ld a, [wDemoRouteFrom]
	cp l
	jr nz, .search
	ld a, [wDemoRouteFrom + 1]
	cp h
	jr nz, .search
	ld a, [wDemoRouteTo]
	cp e
	jr nz, .search
	ld a, [wDemoRouteTo + 1]
	cp d
	jr z, .got

.search
	ld a, l
	ld [wDemoRouteFrom], a
	ld a, h
	ld [wDemoRouteFrom + 1], a
	ld a, e
	ld [wDemoRouteTo], a
	ld a, d
	ld [wDemoRouteTo + 1], a
	ld a, DEMOSEARCH_MAP
	ld [wDemoSearchFor], a
	call DemoNodeSearch
	jr c, .no_way
	call DemoFirstStep
	jr nc, .got
.no_way
	ld a, -1
	ld [wDemoRouteKind], a
.got
	ld a, [wDemoRouteKind]
	cp -1
	jr z, .none
	ld b, a
	ld a, [wDemoRouteArg]
	ld c, a
	ld a, [wDemoRouteNode]
	ld e, a
	ld a, [wDemoRouteNode + 1]
	ld d, a
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	and a
	ret

.none
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	scf
	ret

DemoForgetRoutes::
; The way around has to be worked out again (WRAM bank kept).
	ldh a, [rWBK]
	push af
	ld a, BANK(wDemoRouteFrom)
	ldh [rWBK], a
	ld a, -1
	ld [wDemoRouteFrom], a
	ld [wDemoRouteFrom + 1], a
	ld [wDemoCenterFrom], a
	ld [wDemoCenterFrom + 1], a
	pop af
	ldh [rWBK], a
	ret

DemoNearestCenter::
; Return the nearest POKéMON CENTER: its map key in hl and its nurse (object,
; from 1) in c; carry if there's none it can get to.
	farcall DemoCurMapKey
	ret c
	ld a, BANK(wDemoCenterFrom)
	ldh [rWBK], a
	ld a, [wDemoCenterFrom]
	cp l
	jr nz, .search
	ld a, [wDemoCenterFrom + 1]
	cp h
	jr z, .got
.search
	ld a, l
	ld [wDemoCenterFrom], a
	ld a, h
	ld [wDemoCenterFrom + 1], a
	ld a, -1
	ld [wDemoCenterKey], a
	ld [wDemoCenterKey + 1], a
	ld a, DEMOSEARCH_CENTER
	ld [wDemoSearchFor], a
	call DemoNodeSearch
	jr c, .got
	call DemoNodeKey
	call DemoCenterNurse
	ld [wDemoCenterNurse], a
	ld a, e
	ld [wDemoCenterKey], a
	ld a, d
	ld [wDemoCenterKey + 1], a
.got
	ld a, [wDemoCenterKey]
	ld l, a
	ld a, [wDemoCenterKey + 1]
	ld h, a
	ld a, [wDemoCenterNurse]
	ld c, a
	ld b, 0
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	ld a, h
	and l
	inc a
	scf
	ret z ; (none)
	and a
	ret

DemoCenterNurse:
; de: a map key. Return in a the nurse of its POKéMON CENTER, if it's one (nz),
; else z.
	ld hl, DemoWorldCenters
.loop
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld b, a
	and c
	inc a
	ret z ; (the end)
	ld a, c
	cp e
	jr nz, .next
	ld a, b
	cp d
	jr nz, .next
	ld a, [hl]
	and a
	ret nz
.next
	inc hl
	jr .loop

DemoNodeCell::
; de: a node. Return its cell in d, e.
	ld h, d
	ld l, e
	call DemoNodeEntry
	inc hl
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
	ret

DemoNodeEntry:
; hl: a node. Return its DemoWorldNodes entry in hl (de, bc kept).
	push de
	ld d, h
	ld e, l
	add hl, hl
	add hl, de
	add hl, hl ; (x6)
	ld de, DemoWorldNodes
	add hl, de
	pop de
	ret

DemoNodeKey:
; hl: a node. Return its map key in de (hl kept).
	push hl
	call DemoNodeEntry
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	ret

DemoNodeEdges:
; hl: a node. Return its first edge in hl.
	call DemoNodeEntry
	ld bc, 4
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

DemoPrevAddr:
; hl: a node. Return its DEMO_NODE_PREV entry in hl (de, bc kept).
	add hl, hl
	push de
	ld de, DEMO_NODE_PREV
	add hl, de
	pop de
	ret

DemoStartNodes:
; wDemoStartNodes: the nodes of this map the player can get to from where it
; stands with nothing but walking (wDemoStartCount of them; all the map's, if it
; can't get to any). (WRAM bank 2 after.)
	ld a, BANK(wDemoStartCount)
	ldh [rWBK], a
	xor a
	ld [wDemoStartCount], a
	ld a, BANK(wMapGroup)
	ldh [rWBK], a
	farcall DemoCurMapKey
	ld d, h
	ld e, l
	farcall DemoMapNodes
	ld a, c
	and a
	ret z
	cp 1
	jr z, .all
	push bc
	push de
	farcall DemoFlood ; (bank 1 after)
	pop de
	pop bc
.check
	push bc
	push de
	call DemoNodeCell
	farcall DemoFloodReached
	pop de
	pop bc
	jr nc, .next
	call .Add
.next
	inc de
	dec c
	jr nz, .check
	ld a, BANK(wDemoStartCount)
	ldh [rWBK], a
	ld a, [wDemoStartCount]
	and a
	ret nz
; (none: then all of them)
	ld a, BANK(wMapGroup)
	ldh [rWBK], a
	farcall DemoCurMapKey
	ld d, h
	ld e, l
	farcall DemoMapNodes
.all
	call .Add
	inc de
	dec c
	jr nz, .all
	ret

.Add:
; de: a node to start from (c kept)
	ld a, BANK(wDemoStartCount)
	ldh [rWBK], a
	ld a, [wDemoStartCount]
	cp DEMO_MAX_START_NODES
	ret nc
	inc a
	ld [wDemoStartCount], a
	dec a
	ld l, a
	ld h, 0
	add hl, hl
	ld a, LOW(wDemoStartNodes)
	add l
	ld l, a
	ld a, HIGH(wDemoStartNodes)
	adc h
	ld h, a
	ld [hl], e
	inc hl
	ld [hl], d
	ret

DemoNodeSearch:
; Search the nodes from the start nodes for the first one that [wDemoSearchFor]
; wants: one on map [wDemoRouteTo] (DEMOSEARCH_MAP), or a POKéMON CENTER's
; (DEMOSEARCH_CENTER). Return it in hl, or carry if there's none it can get to.
; (WRAM bank 2 after.)
	call DemoStartNodes
	xor a
	ld [wDemoFlowKey], a ; (WRAM bank 3 is the search's now: the flow is worked out again)
	ld a, BANK(w3_d000)
	ldh [rWBK], a
	ld hl, DEMO_NODE_PREV
	ld bc, 2 * NUM_DEMO_NODES
	ld a, -1
	call ByteFill
; the start nodes: each from itself, in the queue
	ld a, BANK(wDemoWorldHead)
	ldh [rWBK], a
	xor a
	ld [wDemoWorldHead], a
	ld [wDemoWorldHead + 1], a
	ld [wDemoWorldTail], a
	ld [wDemoWorldTail + 1], a
	ld a, [wDemoStartCount]
	and a
	scf
	ret z
	ld c, a
	ld hl, wDemoStartNodes
.starts
	ld a, BANK(wDemoStartNodes)
	ldh [rWBK], a
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	push bc
	ld b, d
	ld c, e
	call DemoReach
	pop bc
	pop hl
	dec c
	jr nz, .starts
.loop
	ld a, BANK(wDemoWorldHead)
	ldh [rWBK], a
	ld hl, wDemoWorldHead
	ld a, [hli]
	ld c, a
	ld b, [hl]
	ld a, [wDemoWorldTail]
	cp c
	jr nz, .pop
	ld a, [wDemoWorldTail + 1]
	cp b
	scf
	ret z ; (no node it wants)
.pop
	inc bc
	ld a, c
	ld [wDemoWorldHead], a
	ld a, b
	ld [wDemoWorldHead + 1], a
	dec bc
	ld hl, DEMO_NODE_QUEUE
	add hl, bc
	add hl, bc
	ld a, BANK(w3_d000)
	ldh [rWBK], a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, BANK(wDemoWorldCur)
	ldh [rWBK], a
	ld a, l
	ld [wDemoWorldCur], a
	ld a, h
	ld [wDemoWorldCur + 1], a
	call DemoWanted
	ret nc ; (hl: this one)
; on along its edges
	call DemoNodeEdges
.edges
	ld a, [hl]
	cp -1
	jr z, .loop
	push hl
	call DemoEdgeUsable
	jr c, .next_edge
	ld a, BANK(wDemoWorldCur)
	ldh [rWBK], a
	ld a, [wDemoWorldCur]
	ld c, a
	ld a, [wDemoWorldCur + 1]
	ld b, a
	call DemoReach
.next_edge
	pop hl
	ld bc, DEMO_EDGE_LENGTH
	add hl, bc
	jr .edges

DemoReach:
; Node de is reached from node bc (itself, for a start): queue it, unless it's
; reached already.
	ld h, d
	ld l, e
	call DemoPrevAddr
	ld a, BANK(w3_d000)
	ldh [rWBK], a
	ld a, [hli]
	and [hl]
	inc a
	ret nz ; (reached already)
	ld [hl], b
	dec hl
	ld [hl], c
	ld a, BANK(wDemoWorldTail)
	ldh [rWBK], a
	ld hl, wDemoWorldTail
	ld a, [hli]
	ld c, a
	ld b, [hl]
	inc bc
	ld a, b
	ld [hld], a
	ld [hl], c
	dec bc
	ld hl, DEMO_NODE_QUEUE
	add hl, bc
	add hl, bc
	ld a, BANK(w3_d000)
	ldh [rWBK], a
	ld [hl], e
	inc hl
	ld [hl], d
	ret

DemoEdgeUsable:
; hl: an edge of node [wDemoWorldCur]. Return nc and the node it leads to in de if
; the team has its field moves and it isn't blocked; else carry.
	inc hl
	inc hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld b, [hl] ; (the field moves it needs)
	ld a, BANK(wDemoFieldMoves)
	ldh [rWBK], a
	ld a, [wDemoFieldMoves]
	cpl
	and b
	scf
	ret nz
	jp DemoLinkBlocked

DemoWanted:
; hl: a node. Return nc if it's the one [wDemoSearchFor] wants (hl kept).
	call DemoNodeKey
	ld a, [wDemoSearchFor]
	cp DEMOSEARCH_CENTER
	jr z, .center
	ld a, [wDemoRouteTo]
	cp e
	jr nz, .no
	ld a, [wDemoRouteTo + 1]
	cp d
	jr nz, .no
	and a
	ret

.center
	push hl
	call DemoCenterNurse
	pop hl
	jr z, .no
	and a
	ret

.no
	scf
	ret

DemoFirstStep:
; hl: the node the search found. Work out the first step on the way there: the
; edge from a start node (wDemoRouteKind, Arg, Node; wDemoRouteStart). Carry if
; it's a start node itself. (WRAM bank 2 after.)
.back
	ld d, h
	ld e, l
	call DemoPrevAddr
	ld a, BANK(w3_d000)
	ldh [rWBK], a
	ld a, [hli]
	ld h, [hl]
	ld l, a ; (the node before)
	cp e
	jr nz, .not_start
	ld a, h
	cp d
	jr z, .is_start
.not_start
; is the node before a start node?
	push hl
	push de
	call DemoPrevAddr
	ld a, [hli]
	ld b, [hl]
	pop de
	pop hl
	cp l
	jr nz, .back
	ld a, b
	cp h
	jr nz, .back
; hl: the start node; de: the next
	ld a, BANK(wDemoRouteStart)
	ldh [rWBK], a
	ld a, l
	ld [wDemoRouteStart], a
	ld [wDemoWorldCur], a
	ld a, h
	ld [wDemoRouteStart + 1], a
	ld [wDemoWorldCur + 1], a
	ld a, e
	ld [wDemoRouteNode], a
	ld a, d
	ld [wDemoRouteNode + 1], a
	call DemoNodeEdges
.find
	ld a, [hl]
	cp -1
	jr z, .is_start ; (can't be)
	push hl
	call DemoEdgeUsable
	pop hl
	jr c, .next
	ld a, [wDemoRouteNode]
	cp e
	jr nz, .next
	ld a, [wDemoRouteNode + 1]
	cp d
	jr nz, .next
	ld a, [hli]
	ld [wDemoRouteKind], a
	ld a, [hl]
	ld [wDemoRouteArg], a
	and a
	ret

.next
	ld bc, DEMO_EDGE_LENGTH
	add hl, bc
	jr .find

.is_start
	ld a, BANK(wDemoRouteKind)
	ldh [rWBK], a
	scf
	ret

DemoLinkBlocked:
; Return carry if the edge from node [wDemoWorldCur] to node de is blocked (de
; kept; WRAM bank 2).
	ld a, BANK(wDemoBlocked)
	ldh [rWBK], a
	ld a, [wDemoBlockedCount]
	and a
	ret z
	push hl
	ld hl, wDemoBlocked
	ld b, DEMO_MAX_BLOCKED
.loop
	ld a, [wDemoWorldCur]
	cp [hl]
	jr nz, .next
	inc hl
	ld a, [wDemoWorldCur + 1]
	cp [hl]
	jr nz, .next1
	inc hl
	ld a, e
	cp [hl]
	jr nz, .next2
	inc hl
	ld a, d
	cp [hl]
	jr z, .blocked
	jr .next3

.next
	inc hl
.next1
	inc hl
.next2
	inc hl
.next3
	inc hl
	dec b
	jr nz, .loop
	pop hl
	and a
	ret

.blocked
	pop hl
	scf
	ret

INCLUDE "data/demo/world_nodes.asm"
