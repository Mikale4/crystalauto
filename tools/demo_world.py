#!/usr/bin/env python3
"""Make data/demo/world.asm: every map the Demo can travel to, how the maps link
up (map connections and warps), and what there is to do on each (its targets:
item balls, hidden items and trainers, each with the event flag that says it's
done), from constants/map_constants.asm, data/maps/attributes.asm and the maps'
own events.

Every map has a key: its place in map_constants.asm, counting from 0 (see
DemoMapKey). Maps that can't be reached from the player's room (or that the Demo
leaves alone: link and mobile rooms, the BATTLE TOWER) have no links or targets.

The way around is a search over nodes: a map's regions (tools/demo_regions.py)
that hold a warp or a way across to another map. Each node's edges are its
warps, its ways across, and the ways to the map's other nodes (some needing
field moves).

Usage: python3 tools/demo_world.py
(writes data/demo/world.asm and data/demo/world_nodes.asm)
"""
import re
import sys
from collections import deque
from itertools import combinations
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import demo_regions as R  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent

# maps the Demo stays out of
SKIP = re.compile(
    r"POKECENTER_2F|TRADE_CENTER|COLOSSEUM|TIME_CAPSULE|MOBILE|BATTLE_TOWER|"
    r"BATTLE_TOWER_OUTSIDE|HALL_OF_FAME$"
)
START = "PLAYERS_HOUSE_2F"

# target kinds (DTARGET_* in constants/demo_constants.asm)
ITEMBALL, HIDDEN, TRAINER = 0, 1, 2


def map_constants():
    """[(key, group, number, const)] in map_constants.asm's order."""
    out, group, number = [], 0, 0
    for line in open(ROOT / "constants/map_constants.asm"):
        if re.match(r"\s*newgroup\b", line):
            group += 1
            number = 0
            continue
        m = re.match(r"\s*map_const (\w+),", line)
        if m:
            number += 1
            out.append((len(out), group, number, m.group(1)))
    return out


def attributes():
    """const -> (file label, [connected consts], [(direction, const, offset)])"""
    out, cur = {}, None
    for line in open(ROOT / "data/maps/attributes.asm"):
        m = re.match(r"\s*map_attributes (\w+), (\w+),", line)
        if m:
            cur = m.group(2)
            out[cur] = (m.group(1), [], [])
            continue
        m = re.match(r"\s*connection (\w+), (\w+), (\w+), (-?\d+)", line)
        if m and cur:
            out[cur][1].append(m.group(3))
            out[cur][2].append((m.group(1), m.group(3), int(m.group(4))))
    return out


# edge kinds (DEDGE_* in constants/demo_constants.asm)
DEDGE_WARP, DEDGE_EDGE, DEDGE_WALK = 0, 1, 2
DIRS = {"north": R.UP, "south": R.DOWN, "west": R.LEFT, "east": R.RIGHT}


def crossings(m, side, offset, other):
    """[(cell here, cell there)] for a connection: the cells on this map's edge, and
    where walking off it lands on the other map (see the connection macro)."""
    out = []
    if side in ("north", "south"):
        y = 0 if side == "north" else m.h - 1
        ty = other.h - 1 if side == "north" else 0
        for x in range(m.w):
            out.append(((x, y), (x - 2 * offset, ty)))
    else:
        x = 0 if side == "west" else m.w - 1
        tx = other.w - 1 if side == "west" else 0
        for y in range(m.h):
            out.append(((x, y), (tx, y - 2 * offset)))
    return out


def map_nodes(label, const, attrs, seen):
    """The regions of a map that are nodes ({region: port cell}), with its regions
    and the masks between them."""
    m, comp, between = R.regions(label)
    ports = {}
    for i, (x, y, dest, _) in enumerate(R.warp_events(label)):
        if (x, y) in comp and dest in seen:
            ports.setdefault(comp[(x, y)], (x, y))
    for side, other_const, offset in attrs[const][2]:
        if other_const not in seen:
            continue
        other = R.Map(attrs[other_const][0])
        for here, there in crossings(m, side, offset, other):
            if here in comp and other.kind(there) is not None:
                ports.setdefault(comp[here], here)
    return m, comp, between, ports


def walk_masks(between, start, nodes):
    """{node region: [masks]}: the least field moves to get from region start to
    each other node region of the map."""
    moves = 0
    for masks in between.values():
        for mask in masks:
            moves |= mask
    bits = [b for b in range(5) if moves >> b & 1]
    succ = {}
    for (a, b), masks in between.items():
        succ.setdefault(a, []).append((b, masks))
    found = {}
    for n in range(len(bits) + 1):
        for chosen in combinations(bits, n):
            mask = sum(1 << b for b in chosen)
            reach, todo = {start}, [start]
            while todo:
                a = todo.pop()
                for b, masks in succ.get(a, []):
                    if b not in reach and any(m & mask == m for m in masks):
                        reach.add(b)
                        todo.append(b)
            for r in reach:
                if r != start and r in nodes and not any(m & mask == m for m in found.get(r, [])):
                    found.setdefault(r, []).append(mask)
    return found


def args(line, macro):
    body = line.split(macro, 1)[1].split(";")[0]
    return [a.strip() for a in body.split(",")]


def map_events(label):
    """(warp destinations, targets) of the map in maps/<label>.asm"""
    text = open(ROOT / f"maps/{label}.asm").read()
    lines = text.splitlines()

    def label_line(name, macro):
        for i, line in enumerate(lines):
            if re.match(rf"{re.escape(name)}:", line):
                for later in lines[i + 1:i + 6]:
                    if macro in later:
                        return args(later, macro)
        return None

    warps, targets = [], []
    obj = 0
    for line in lines:
        s = line.strip()
        if s.startswith("warp_event"):
            warps.append(args(s, "warp_event")[2])
        elif s.startswith("bg_event"):
            a = args(s, "bg_event")
            if a[2] == "BGEVENT_ITEM":
                hidden = label_line(a[3], "hiddenitem")
                if hidden and hidden[1].startswith("EVENT_"):
                    targets.append((HIDDEN, int(a[0]), int(a[1]), hidden[1], hidden[0]))
        elif s.startswith("object_event"):
            obj += 1
            a = args(s, "object_event")
            kind, script, flag = a[9], a[11], a[12]
            if kind == "OBJECTTYPE_ITEMBALL" and flag.startswith("EVENT_"):
                item = label_line(script, "itemball")
                targets.append((ITEMBALL, obj, 0, flag, item[0] if item else "?"))
            elif kind == "OBJECTTYPE_TRAINER":
                tr = label_line(script, "trainer")
                if tr and tr[2].startswith("EVENT_"):
                    targets.append((TRAINER, obj, 0, tr[2], f"{tr[0]} {tr[1]}"))
    return warps, targets, obj


def main():
    consts = map_constants()
    attrs = attributes()
    key = {c: k for k, _, _, c in consts}
    links, targets, nurses, reminders = {}, {}, {}, {}
    for _, _, _, c in consts:
        if c not in attrs or SKIP.search(c):
            continue
        label, conns, _ = attrs[c]
        warps, t, _ = map_events(label)
        dests = []
        for d in conns + warps:
            if d in key and d != c and not SKIP.search(d) and d not in dests:
                dests.append(d)
        links[c] = dests
        targets[c] = t
        if c.endswith("POKECENTER_1F"):
            text = open(ROOT / f"maps/{label}.asm").read()
            objs = [l for l in text.splitlines() if l.strip().startswith("object_event")]
            for i, l in enumerate(objs):
                if "SPRITE_NURSE" in l and c not in nurses:
                    nurses[c] = i + 1
                if "MoveReminderScript" in l:
                    reminders[c] = i + 1
            # (the MOVE TUTOR is the object after the MOVE REMINDER)
            assert "MoveTutorScript" in objs[reminders[c]], c
    # what can be reached from the player's room
    seen, todo = {START}, deque([START])
    while todo:
        c = todo.popleft()
        for d in links.get(c, []):
            if d not in seen:
                seen.add(d)
                todo.append(d)

    print("; Every map the Demo can travel to: how the maps link up, and what there is")
    print("; to do on each (see engine/demo/demo_walk.asm). Made by tools/demo_world.py.")
    print()
    print(f"\tassert NUM_DEMO_WORLD_MAPS == {len(consts)}, \"NUM_DEMO_WORLD_MAPS (constants/demo_constants.asm) should be {len(consts)}\"")
    print()
    groups = {}
    for k, g, _, _ in consts:
        groups.setdefault(g, k)
    print("DemoGroupKeys:")
    print("; the key of each group's first map (MAPGROUP_* - 1)")
    for g in sorted(groups):
        print(f"\tdw {groups[g]}")
    print()
    # the nodes: each map's regions with a way out
    info, node_ids = {}, {}
    for _, _, _, c in consts:
        if c not in seen:
            continue
        info[c] = map_nodes(attrs[c][0], c, attrs, seen)
        for r in sorted(info[c][3]):
            node_ids[(c, r)] = len(node_ids)
    node_edges = {}
    for c, (m, comp, between, ports) in info.items():
        label = attrs[c][0]
        for r in sorted(ports):
            edges = []
            for i, (x, y, dest, num) in enumerate(R.warp_events(label)):
                if comp.get((x, y)) != r or dest not in info:
                    continue
                dwarps = R.warp_events(attrs[dest][0])
                if num - 1 >= len(dwarps):
                    continue
                cell = dwarps[num - 1][:2]
                dr = info[dest][1].get(cell)
                if (dest, dr) in node_ids:
                    edges.append((DEDGE_WARP, i + 1, node_ids[(dest, dr)], 0))
            for side, other_const, offset in attrs[c][2]:
                if other_const not in info:
                    continue
                other = info[other_const]
                for here, there in crossings(m, side, offset, other[0]):
                    if comp.get(here) == r and (other_const, other[1].get(there)) in node_ids:
                        edges.append((DEDGE_EDGE, DIRS[side], node_ids[(other_const, other[1][there])], 0))
            for dr, masks in sorted(walk_masks(between, r, ports).items()):
                for mask in masks:
                    edges.append((DEDGE_WALK, 0, node_ids[(c, dr)], mask))
            unique = []
            for e in edges:
                if not any(u[0] == e[0] and u[2] == e[2] and u[3] == e[3] for u in unique):
                    unique.append(e)
            node_edges[node_ids[(c, r)]] = unique
    print(f"\tassert NUM_DEMO_NODES == {len(node_ids)}, \"NUM_DEMO_NODES (constants/demo_constants.asm) should be {len(node_ids)}\"")
    print()
    print("DemoWorldMaps:")
    print("; for each map key: its map, its first target (DemoTargets) and how many, its")
    print("; first node (DemoWorldNodes) and how many")
    print("\ttable_width 2")
    for _, _, _, c in consts:
        print(f"\tdw .{c.title().replace('_', '')}")
    print("\tassert_table_length NUM_DEMO_WORLD_MAPS")
    first = 0
    all_targets = []
    for k, _, _, c in consts:
        t = targets.get(c, []) if c in seen else []
        nodes = [node_ids[(c, r)] for r in sorted(info[c][3])] if c in info else []
        print(f".{c.title().replace('_', '')}:")
        print(f"\tmap_id {c}")
        print(f"\tdw {first}")
        print(f"\tdb {len(t)}")
        print(f"\tdw {nodes[0] if nodes else 0}")
        print(f"\tdb {len(nodes)}")
        first += len(t)
        all_targets += [(c,) + x for x in t]
    nodes_out = open(ROOT / "data/demo/world_nodes.asm", "w")
    stdout = sys.stdout
    sys.stdout = nodes_out
    print("; The Demo's nodes: the regions of each map with a way out, and the ways from")
    print("; them (see engine/demo/demo_nodes.asm). Made by tools/demo_world.py.")
    print()
    print("DemoWorldNodes:")
    print("; for each node: its map key, its cell (the Demo checks it can get there), its")
    print("; edges (DemoNodeEdges)")
    print("\ttable_width 6")
    for (c, r), n in node_ids.items():
        x, y = info[c][3][r]
        print(f"\tdw {key[c]}\n\tdb {x}, {y}\n\tdw .Node{n} ; {c}")
    print("\tassert_table_length NUM_DEMO_NODES")
    print()
    print("; each edge: its kind (DEDGE_*), the warp (from 1) or direction, the node it")
    print("; leads to, the field moves it needs (DEMOFIELD_* bits); -1 ends")
    names = ["DEDGE_WARP", "DEDGE_EDGE", "DEDGE_WALK"]
    for n, edges in node_edges.items():
        print(f".Node{n}:")
        for kind, arg, dest, mask in edges:
            print(f"\tdb {names[kind]}, {arg}\n\tdw {dest}\n\tdb %{mask:05b}")
        print("\tdb -1")
    print()
    print("DemoWorldCenters:")
    print("; the POKéMON CENTERs: map key, its nurse and its MOVE REMINDER (objects, from 1;")
    print("; the MOVE TUTOR is the one after); -1 ends")
    for c in sorted(nurses, key=lambda c: key[c]):
        if c in seen:
            print(f"\tdw {key[c]}\n\tdb {nurses[c]}, {reminders[c]}")
    print("\tdw -1")
    sys.stdout = stdout
    nodes_out.close()
    print()
    print(f"\tassert NUM_DEMO_TARGETS == {len(all_targets)}, \"NUM_DEMO_TARGETS (constants/demo_constants.asm) should be {len(all_targets)}\"")
    print()
    print("DemoTargets:")
    print("; kind (DTARGET_*), object (from 1) or x, y, the event flag that marks it done")
    print("\ttable_width 5")
    names = {ITEMBALL: "DTARGET_ITEMBALL", HIDDEN: "DTARGET_HIDDEN", TRAINER: "DTARGET_TRAINER"}
    for c, kind, a, b, flag, what in all_targets:
        print(f"\tdb {names[kind]}, {a}, {b}\n\tdw {flag} ; {c}: {what}")
    print("\tassert_table_length NUM_DEMO_TARGETS")


if __name__ == "__main__":
    sys.stdout = open(ROOT / "data/demo/world.asm", "w")
    main()
