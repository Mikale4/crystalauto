#!/usr/bin/env python3
"""Make data/randomizer/pools.asm: the Pokémon that wild and trainer Pokémon can
become in RANDOMIZER mode, weakest first by base stat total, and each species'
place among them (see engine/events/randomizer.asm).

Legendaries (LegendaryPool) and UNOWN aren't in the pool: a legendary only
swaps with another legendary, and a wild UNOWN needs letters unlocked. They get
the place they'd have among the others, so that a trainer's legendary becomes
something about as strong.

Usage: python3 tools/randomizer_pools.py
(writes data/randomizer/pools.asm)
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

LEGENDARIES = [
    "ARTICUNO", "ZAPDOS", "MOLTRES", "MEWTWO", "MEW",
    "RAIKOU", "ENTEI", "SUICUNE", "LUGIA", "HO_OH", "CELEBI",
    "ARTICUNO_G", "ZAPDOS_G", "MOLTRES_G",
]
LEFT_OUT = set(LEGENDARIES) | {"UNOWN"}


def species():
    """the species constants, by index (from 1)"""
    names = []
    for line in open(ROOT / "constants/pokemon_constants.asm"):
        if line.startswith("DEF NUM_POKEMON"):
            break
        m = re.match(r"\s*const (\w+)", line)
        if m:
            names.append(m.group(1))
    return names


def base_stat_totals(names):
    files = []
    for line in open(ROOT / "data/pokemon/base_stats.asm"):
        m = re.match(r'\s*INCLUDE "(data/pokemon/base_stats/\w+\.asm)"', line)
        if m:
            files.append(m.group(1))
    assert len(files) == len(names), (len(files), len(names))
    totals = {}
    for name, f in zip(names, files):
        m = re.search(r"db\s+(\d+),\s*(\d+),\s*(\d+),\s*(\d+),\s*(\d+),\s*(\d+)\s*\n\s*;\s*hp",
                      open(ROOT / f).read())
        totals[name] = sum(int(x) for x in m.groups())
    return totals


def main():
    names = species()
    bst = base_stat_totals(names)
    order = sorted(names, key=lambda n: (bst[n], names.index(n)))
    pool = [n for n in order if n not in LEFT_OUT]
    out = open(ROOT / "data/randomizer/pools.asm", "w")
    out.write("; Made by tools/randomizer_pools.py: the Pokémon that wild and trainer\n")
    out.write("; Pokémon can become in RANDOMIZER mode (no legendaries, no UNOWN), weakest\n")
    out.write("; first by base stat total, and each species' place among them.\n\n")
    out.write("RandomizerPool:\n")
    for n in pool:
        out.write(f"\tdw {n:<12} ; {bst[n]}\n")
    out.write(".End:\n")
    out.write(f"DEF NUM_RANDOMIZER_POOL EQU {len(pool)}\n")
    out.write("\tassert (RandomizerPool.End - RandomizerPool) / 2 == NUM_RANDOMIZER_POOL\n\n")
    out.write("RandomizerRanks:\n")
    out.write("; each species' place in RandomizerPool (by index, from 1)\n")
    out.write("\ttable_width 2\n")
    for n in names:
        # where it is, or where it would go
        place = sum(1 for p in pool if (bst[p], names.index(p)) < (bst[n], names.index(n)))
        place = min(place, len(pool) - 1)
        out.write(f"\tdw {place:3} ; {n}\n")
    out.write("\tassert_table_length NUM_POKEMON\n")


if __name__ == "__main__":
    main()
