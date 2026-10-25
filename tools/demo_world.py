#!/usr/bin/env python3
"""Make data/demo/world.asm: every map the Demo can travel to, how the maps link
up (map connections and warps), and what there is to do on each (its targets:
item balls, hidden items and trainers, each with the event flag that says it's
done), from constants/map_constants.asm, data/maps/attributes.asm and the maps'
own events.

Every map has a key: its place in map_constants.asm, counting from 0 (see
DemoMapKey). Maps that can't be reached from the player's room (or that the Demo
leaves alone: link and mobile rooms, the BATTLE TOWER) have no links or targets.

Usage: python3 tools/demo_world.py > data/demo/world.asm
"""
import re
from collections import deque
from pathlib import Path

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
    """const -> (file label, [connected consts])"""
    out, cur = {}, None
    for line in open(ROOT / "data/maps/attributes.asm"):
        m = re.match(r"\s*map_attributes (\w+), (\w+),", line)
        if m:
            cur = m.group(2)
            out[cur] = (m.group(1), [])
            continue
        m = re.match(r"\s*connection (\w+), (\w+), (\w+),", line)
        if m and cur:
            out[cur][1].append(m.group(3))
    return out


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
    links, targets, nurses = {}, {}, {}
    for _, _, _, c in consts:
        if c not in attrs or SKIP.search(c):
            continue
        label, conns = attrs[c]
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
                if "SPRITE_NURSE" in l:
                    nurses[c] = i + 1
                    break
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
    print("DemoWorldMaps:")
    print("; for each map key: its map, its first target (DemoTargets) and how many, the")
    print("; maps it leads to (keys; -1 ends)")
    print("\ttable_width 2")
    for _, _, _, c in consts:
        print(f"\tdw .{c.title().replace('_', '')}")
    print("\tassert_table_length NUM_DEMO_WORLD_MAPS")
    first = 0
    all_targets = []
    for k, _, _, c in consts:
        t = targets.get(c, []) if c in seen else []
        l = links.get(c, []) if c in seen else []
        print(f".{c.title().replace('_', '')}:")
        print(f"\tmap_id {c}")
        print(f"\tdw {first}")
        print(f"\tdb {len(t)}")
        print("\tdw " + ", ".join([str(key[d]) for d in l if d in seen] + ["-1"]))
        first += len(t)
        all_targets += [(c,) + x for x in t]
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
    print()
    print("DemoWorldCenters:")
    print("; the POKéMON CENTERs: map key, its nurse (object, from 1); -1 ends")
    for c in sorted(nurses, key=lambda c: key[c]):
        if c in seen:
            print(f"\tdw {key[c]}\n\tdb {nurses[c]}")
    print("\tdw -1")


if __name__ == "__main__":
    main()
