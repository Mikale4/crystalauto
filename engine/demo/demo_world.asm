; The Demo's map of the world (data/demo/world.asm, made by tools/demo_world.py):
; every map has a key (DemoMapKey), its place in constants/map_constants.asm, and
; its targets and nodes (the way around is in engine/demo/demo_nodes.asm). The
; Demo calls these by farcall, so they take keys in de and give what they find in
; bc, de, hl and carry.

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

DemoMapNodes::
; de: a map key. Return its first node (DemoWorldNodes) in de and how many it has
; in c.
	ld h, d
	ld l, e
	call DemoKeyEntry
	ld de, 5
	add hl, de
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

INCLUDE "data/demo/world.asm"
