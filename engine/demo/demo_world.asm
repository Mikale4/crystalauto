; The Demo's map of the world (data/demo/world.asm, made by tools/demo_world.py)
; and its way around it. Every map has a key (DemoMapKey): its place in
; constants/map_constants.asm. The way from map to map is a search over the maps'
; links (DemoWorldSearch), in WRAM bank 2, where it shares room with the search
; over a map's cells (they never run at once). The Demo calls these by farcall, so
; they take keys in de and give what they find in bc, de, hl and carry.

DemoMapKey::
; Return in hl the key of map b (group), c (number); carry if it has none.
	ld a, b
	and a
	jr z, .none
	ld a, c
	and a
	jr z, .none
	ld a, b
	dec a
	ld l, a
	ld h, 0
	add hl, hl
	ld de, DemoGroupKeys
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, c
	dec a
	ld e, a
	ld d, 0
	add hl, de
	ld a, l
	sub LOW(NUM_DEMO_WORLD_MAPS)
	ld a, h
	sbc HIGH(NUM_DEMO_WORLD_MAPS)
	ccf
	ret

.none
	scf
	ret

DemoCurMapKey::
; Return in hl the key of the map the player is on (carry if it has none).
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapNumber]
	ld c, a
	jr DemoMapKey

DemoKeyEntry:
; hl: a map key. Return its DemoWorldMaps entry in hl.
	add hl, hl
	ld de, DemoWorldMaps
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

DemoKeyMap::
; de: a map key. Return its map's group and number in b, c.
	ld h, d
	ld l, e
	call DemoKeyEntry
	ld b, [hl]
	inc hl
	ld c, [hl]
	ret

DemoMapTargets::
; de: a map key. Return its first target (a DemoTargets index) in de and how many
; it has in c.
	ld h, d
	ld l, e
	call DemoKeyEntry
	inc hl
	inc hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld c, [hl]
	ld b, 0
	ret

DemoGetTarget::
; de: a DemoTargets index. Return its kind (DTARGET_*) in h, its object (from 1)
; or x in b, its y in c, and its event flag in de.
	ld h, d
	ld l, e
	add hl, hl
	add hl, hl
	add hl, de ; (x5)
	ld de, DemoTargets
	add hl, de
	ld a, [hli]
	push af
	ld b, [hl]
	inc hl
	ld c, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop af
	ld h, a
	ret

DemoNextMapTo::
; de: the key of the map it's going to. Return in hl the key of the map to go to
; next on the shortest way there (from the map the player's on), or carry if
; there's no way. (It remembers the answer until either map changes, or a link is
; blocked.)
	push de
	call DemoCurMapKey
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
	jr nz, .search
	ld a, [wDemoRouteNext]
	ld l, a
	ld a, [wDemoRouteNext + 1]
	ld h, a
	jr .done

.search
	ld a, l
	ld [wDemoRouteFrom], a
	ld a, h
	ld [wDemoRouteFrom + 1], a
	ld a, e
	ld [wDemoRouteTo], a
	ld a, d
	ld [wDemoRouteTo + 1], a
	push de
	call DemoWorldSearch
	pop hl
; back from where it's going to the map after the start
.back
	push hl
	call DemoWorldPrevAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop de ; (the map before it is hl now; de is the map)
	ld a, h
	and l
	inc a
	jr z, .no_way ; ($ffff: it can't get there)
	ld a, [wDemoWorldStart]
	cp l
	jr nz, .back
	ld a, [wDemoWorldStart + 1]
	cp h
	jr nz, .back
	ld h, d
	ld l, e
	ld a, l
	ld [wDemoRouteNext], a
	ld a, h
	ld [wDemoRouteNext + 1], a
.done
	ld a, h
	and l
	inc a
	jr z, .none
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	and a
	ret

.no_way
	ld a, -1
	ld [wDemoRouteNext], a
	ld [wDemoRouteNext + 1], a
.none
	ld a, BANK(wXCoord)
	ldh [rWBK], a
	scf
	ret

DemoForgetRoutes::
; The way from map to map has to be worked out again (WRAM bank kept).
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
	call DemoCurMapKey
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
	call DemoWorldSearch
	ld hl, wDemoWorldQueue
	ld a, [wDemoWorldTail]
	ld c, a
	ld a, [wDemoWorldTail + 1]
	ld b, a
.next_map
	ld a, b
	or c
	jr z, .no_center
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld hl, DemoWorldCenters
.center
	ld a, [hli]
	cp e
	jr nz, .not_it
	ld a, [hl]
	cp d
	jr z, .found
.not_it
	dec hl
	ld a, [hli]
	and [hl]
	inc a
	jr z, .not_a_center ; (the end of the list)
	inc hl
	inc hl
	jr .center

.not_a_center
	pop hl
	dec bc
	jr .next_map

.found
	inc hl
	ld a, [hl]
	pop hl
	ld [wDemoCenterNurse], a
	ld a, e
	ld [wDemoCenterKey], a
	ld a, d
	ld [wDemoCenterKey + 1], a
	jr .got

.no_center
	ld a, -1
	ld [wDemoCenterKey], a
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
	ret z
	and a
	ret

DemoWorldPrevAddr:
; hl: a map key. Return its wDemoWorldPrev entry's address in hl (de kept).
	push de
	add hl, hl
	ld de, wDemoWorldPrev
	add hl, de
	pop de
	ret

DemoWorldSearch:
; Search the maps from map hl (a key): wDemoWorldPrev, how it got to each map
; ($ffff: it can't); wDemoWorldQueue, the maps in order of how far they are
; (wDemoWorldTail of them). WRAM bank 2 after.
	ld a, BANK(wDemoWorldPrev)
	ldh [rWBK], a
	ld a, l
	ld [wDemoWorldStart], a
	ld a, h
	ld [wDemoWorldStart + 1], a
	ld hl, wDemoWorldPrev
	ld bc, 2 * NUM_DEMO_WORLD_MAPS
	ld a, -1
	call ByteFill
; the start: from itself, first in the queue
	ld a, [wDemoWorldStart]
	ld l, a
	ld a, [wDemoWorldStart + 1]
	ld h, a
	ld b, h
	ld c, l
	call DemoWorldPrevAddr
	ld a, c
	ld [hli], a
	ld [hl], b
	ld a, c
	ld [wDemoWorldQueue], a
	ld a, b
	ld [wDemoWorldQueue + 1], a
	xor a
	ld [wDemoWorldHead], a
	ld [wDemoWorldHead + 1], a
	ld [wDemoWorldTail + 1], a
	inc a
	ld [wDemoWorldTail], a
.search
	ld hl, wDemoWorldHead
	ld a, [hli]
	ld c, a
	ld b, [hl]
	ld a, [wDemoWorldTail]
	cp c
	jr nz, .pop
	ld a, [wDemoWorldTail + 1]
	cp b
	ret z
.pop
; the map it looks on from
	ld hl, wDemoWorldQueue
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld [wDemoWorldCur], a
	ld a, [hl]
	ld [wDemoWorldCur + 1], a
	inc bc
	ld a, c
	ld [wDemoWorldHead], a
	ld a, b
	ld [wDemoWorldHead + 1], a
	ld a, [wDemoWorldCur]
	ld l, a
	ld a, [wDemoWorldCur + 1]
	ld h, a
	call DemoKeyEntry
	ld de, 5 ; (the links)
	add hl, de
.links
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	and e
	inc a
	jr z, .search
	push hl
	call DemoLinkBlocked
	jr c, .next_link
	ld h, d
	ld l, e
	call DemoWorldPrevAddr
	ld a, [hli]
	and [hl]
	inc a
	jr nz, .next_link ; (reached already)
	ld a, [wDemoWorldCur + 1]
	ld [hld], a
	ld a, [wDemoWorldCur]
	ld [hl], a
	ld hl, wDemoWorldTail
	ld a, [hli]
	ld c, a
	ld b, [hl]
	ld hl, wDemoWorldQueue
	add hl, bc
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	inc bc
	ld a, c
	ld [wDemoWorldTail], a
	ld a, b
	ld [wDemoWorldTail + 1], a
.next_link
	pop hl
	jr .links

DemoLinkBlocked:
; Return carry if the link from map wDemoWorldCur to map de is blocked (de and
; hl kept; WRAM bank 2).
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

INCLUDE "data/demo/world.asm"
