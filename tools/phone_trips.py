#!/usr/bin/env python3
"""Make data/phone/trip_destinations.asm: for each phone contact who calls to ask
for a rematch, the map they wait on and the cell in front of them, where a
phone trip (see PhoneScript_OfferTrip) puts the player, facing them.

Usage: python3 tools/phone_trips.py > data/phone/trip_destinations.asm
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

# (x, y) step for the way a trainer stands, and the way the player then faces
FACING = {
    "SPRITEMOVEDATA_STANDING_DOWN": ((0, 1), "UP"),
    "SPRITEMOVEDATA_STANDING_UP": ((0, -1), "DOWN"),
    "SPRITEMOVEDATA_STANDING_LEFT": ((-1, 0), "RIGHT"),
    "SPRITEMOVEDATA_STANDING_RIGHT": ((1, 0), "LEFT"),
}
# cells to leave be even where they're land: they slide, spin or drop the player
NOT_TO_STAND_ON = ("ICE", "WALK_", "BRAKE", "PIT", "HOP_")
STEPS = {"UP": (0, -1), "DOWN": (0, 1), "LEFT": (-1, 0), "RIGHT": (1, 0)}
# the way to face a trainer from a cell next to them
TOWARD = {(0, 1): "UP", (0, -1): "DOWN", (1, 0): "LEFT", (-1, 0): "RIGHT"}


def phone_contacts():
    out = []
    for line in open(ROOT / "constants/phone_constants.asm"):
        m = re.match(r"\s*const (PHONE_\w+)", line)
        if m:
            out.append(m.group(1))
        elif re.match(r"\s*const_skip", line) and out:
            out.append(None)
        if "NUM_PHONE_CONTACTS" in line:
            break
    return out


def map_consts():
    """file label -> map const"""
    out = {}
    for line in open(ROOT / "data/maps/attributes.asm"):
        m = re.match(r"\s*map_attributes (\w+), (\w+),", line)
        if m:
            out[m.group(1)] = m.group(2)
    return out


def labelled_file(path, label, directive):
    """The file the INCLUDE/INCBIN after a label (or a run of labels) names."""
    found = False
    for line in open(ROOT / path):
        if line.startswith(label + ":"):
            found = True
        elif found and directive in line:
            return re.search(r'"(.+?)"', line).group(1)
    raise KeyError(label)


def collision(label):
    """(x, y) -> the collision of each cell of a map (by its file label)."""
    tileset = width = None
    for line in open(ROOT / "data/maps/maps.asm"):
        m = re.match(rf"\s*map {label}, (\w+),", line)
        if m:
            tileset = m.group(1)
    const = map_consts()[label]
    for line in open(ROOT / "constants/map_constants.asm"):
        m = re.match(rf"\s*map_const {const},\s*(\d+),", line)
        if m:
            width = int(m.group(1))
    tilesets = [m.group(1) for m in re.finditer(r"^\s*const (TILESET_\w+)", (ROOT / "constants/tileset_constants.asm").read_text(), re.M)]
    names = re.findall(r"^\s*tileset (\w+)", (ROOT / "data/tilesets.asm").read_text(), re.M)
    name = names[tilesets.index(tileset) + 1]  # (Tileset0 comes first)
    coll = []
    for line in open(ROOT / labelled_file("gfx/tilesets.asm", name + "Coll", "INCLUDE")):
        m = re.match(r"\s*tilecoll (\w+), (\w+), (\w+), (\w+)", line)
        if m:
            coll.append(m.groups())
    blocks = (ROOT / labelled_file("data/maps/blocks.asm", label + "_Blocks", "INCBIN")).read_bytes()
    grid = {}
    for i, b in enumerate(blocks):
        bx, by = i % width * 2, i // width * 2
        for q, c in enumerate(coll[b]):
            grid[(bx + q % 2, by + q // 2)] = c
    return grid


def walkable():
    """The collision constants the player can stand on (land, not slippery)."""
    consts = {}
    for line in open(ROOT / "constants/collision_constants.asm"):
        m = re.match(r"DEF COLL_(\w+)\s+EQU \$(\w+)", line)
        if m:
            consts[int(m.group(2), 16)] = m.group(1)
    perms = [line.split(";")[0].split()[1:] for line in open(ROOT / "data/collision/collision_permissions.asm")
             if line.strip().startswith("db")]
    return {name for i, name in consts.items() if i < len(perms) and perms[i] == ["LAND_TILE"]
            and not name.startswith(NOT_TO_STAND_ON)}


def taken(label):
    """The cells of a map's objects and warps."""
    out = set()
    for line in open(ROOT / f"maps/{label}.asm"):
        s = line.strip()
        for macro in ("object_event", "warp_event"):
            if s.startswith(macro):
                a = s.split(macro, 1)[1].split(",")
                out.add((int(a[0]), int(a[1])))
    return out


def stand(label, x, y, move):
    """The cell next to a trainer at (x, y) to put the player on (the one in
    front if it can be stood on), and the way to face them."""
    (dx, dy), _ = FACING.get(move, ((0, 1), "UP"))
    grid, busy, ok = collision(label), taken(label), walkable()
    for step in [(dx, dy)] + [d for d in TOWARD if d != (dx, dy)]:
        cell = (x + step[0], y + step[1])
        if grid.get(cell) in ok and cell not in busy:
            return cell[0], cell[1], TOWARD[step]
    raise ValueError(f"{label} {x}, {y}: nowhere to stand")


def contact_trainer(contact):
    """The trainer (class, id) a contact's phone script names, if it asks for
    rematches."""
    for f in (ROOT / "engine/phone/scripts").glob("*.asm"):
        text = f.read_text()
        if "PhoneScript_WantsToBattle" not in text:
            continue
        callee = re.search(r"gettrainername STRING_BUFFER_3, (\w+), (\w+)", text)
        if callee and f.stem.upper() in contact:
            return callee.group(1), callee.group(2)
    return None


def find_trainer(cls, tid, labels):
    for f in sorted((ROOT / "maps").glob("*.asm")):
        text = f.read_text()
        base = tid.rstrip("0123456789")
        m = re.search(rf"^(\w+):\n\ttrainer {cls}, {base}\d*,", text, re.M)
        if not m:
            continue
        label = m.group(1)
        for line in text.splitlines():
            s = line.strip()
            if s.startswith("object_event") and re.search(rf",\s*{label},", s):
                a = [x.strip() for x in s.split("object_event", 1)[1].split(";")[0].split(",")]
                return f.stem, int(a[0]), int(a[1]), a[3]
    return None


def main():
    labels = map_consts()
    print("; For each phone contact who calls to ask for a rematch: the map they wait")
    print("; on, and the cell in front of them that a phone trip takes the player to,")
    print("; facing them (see PhoneScript_OfferTrip). Made by tools/phone_trips.py.")
    print()
    print("PhoneTripDestinations:")
    print("; map group, number, x, y, facing (0, 0: no trip)")
    print("\ttable_width PHONE_TRIP_DESTINATION_SIZE")
    for c in phone_contacts():
        t = contact_trainer(c) if c else None
        where = find_trainer(*t, labels) if t else None
        if not where:
            print(f"\tdb 0, 0, 0, 0, 0 ; {c or '(unused)'}")
            continue
        label, x, y, move = where
        x, y, face = stand(label, x, y, move)
        print(f"\tmap_id {labels[label]}\n\tdb {x}, {y}, {face} ; {c}: {t[0]} {t[1]}")
    print("\tassert_table_length NUM_PHONE_CONTACTS + 1")


if __name__ == "__main__":
    main()
