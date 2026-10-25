#!/usr/bin/env python3
"""Make data/demo/world.asm: the maps the Demo travels through and how they
link up (map connections and warps), from data/maps/attributes.asm and the
maps' own warp_event lines.

Usage: python3 tools/demo_world.py > data/demo/world.asm
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

# The maps the Demo goes through (only links between these count), in plan order.
MAPS = """
PLAYERS_HOUSE_2F PLAYERS_HOUSE_1F NEW_BARK_TOWN ELMS_LAB
ROUTE_29 CHERRYGROVE_CITY CHERRYGROVE_POKECENTER_1F CHERRYGROVE_MART
ROUTE_30 MR_POKEMONS_HOUSE ROUTE_31 ROUTE_31_VIOLET_GATE
VIOLET_CITY VIOLET_POKECENTER_1F VIOLET_MART VIOLET_GYM
ROUTE_29_ROUTE_46_GATE ROUTE_46
""".split()


def map_files():
    """Map constant -> map file name, from the map_attributes lines."""
    out = {}
    for line in open(ROOT / "data/maps/attributes.asm"):
        m = re.match(r"\s*map_attributes (\w+), (\w+),", line)
        if m:
            out[m.group(2)] = m.group(1)
    return out


def connections():
    """Map constant -> the maps it connects to."""
    out, cur = {}, None
    for line in open(ROOT / "data/maps/attributes.asm"):
        m = re.match(r"\s*map_attributes (\w+), (\w+),", line)
        if m:
            cur = m.group(2)
            out[cur] = []
            continue
        m = re.match(r"\s*connection (\w+), (\w+), (\w+),", line)
        if m and cur:
            out[cur].append(m.group(3))
    return out


def warps(name):
    out = []
    for line in open(ROOT / f"maps/{name}.asm"):
        m = re.match(r"\s*warp_event\s+\d+,\s*\d+,\s*(\w+),", line)
        if m:
            out.append(m.group(1))
    return out


def main():
    files = map_files()
    conns = connections()
    index = {m: i for i, m in enumerate(MAPS)}
    print("; The maps the Demo travels through, and the maps each one leads to")
    print("; (by a connection or a warp). Made by tools/demo_world.py.")
    print()
    print(f"DEF NUM_DEMO_WORLD_MAPS EQU {len(MAPS)}")
    print()
    print("DemoWorldMaps:")
    print("; group, number, the maps it leads to (DemoWorldMaps indexes), -1")
    print("\ttable_width 2")
    for m in MAPS:
        print(f"\tdw .{files[m]}")
    print("\tassert_table_length NUM_DEMO_WORLD_MAPS")
    for m in MAPS:
        links = []
        for dest in conns.get(m, []) + warps(files[m]):
            if dest in index and index[dest] not in links and dest != m:
                links.append(index[dest])
        print(f".{files[m]}:")
        print(f"\tmap_id {m}")
        print("\tdb " + ", ".join(str(i) for i in links + [-1]))
    print()
    print("DemoWorldCenters:")
    print("; the POKéMON CENTERs among them")
    centers = [str(index[m]) for m in MAPS if m.endswith("POKECENTER_1F")]
    print("\tdb " + ", ".join(centers + ["-1"]))


if __name__ == "__main__":
    main()
