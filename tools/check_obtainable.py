#!/usr/bin/env python3
"""List the species a game can't get (without trading with another game).

A species can be got if it's met in the wild (grass, water, fishing, trees,
rocks, swarms, the Bug-Catching Contest), given (givepoke, giveegg, the ODD EGG,
SHUCKIE), traded for in the game (npctrade), fought as a static or boss Pokémon
(loadwildmon: a boss joins you), or evolves from or hatches from one that can.
Hatching: a species that can breed (not in EGG_NONE) lays its family's first
stage's EGG (a genderless one needs DITTO).

Usage: tools/check_obtainable.py [repository root]
Prints each species nothing gives, and exits 1 if there's any.
"""
import re
import sys
from pathlib import Path

root = Path(sys.argv[1] if len(sys.argv) > 1 else ".")

species = []
for line in open(root / "constants/pokemon_constants.asm"):
    m = re.match(r"\s*const\s+(\w+)", line)
    if m:
        species.append(m.group(1))
    if line.startswith("DEF NUM_POKEMON"):
        break
names = set(species)
ident = re.compile(r"\b[A-Z][A-Z0-9_]*\b")


def mentioned(path):
    """the species named in a file (comments left out)"""
    out = set()
    for line in open(path):
        out |= {w for w in ident.findall(line.split(";")[0]) if w in names}
    return out


# where they're met or given
sources = {}


def add(mons, why):
    for s in mons:
        sources.setdefault(s, why)


for f in sorted((root / "data/wild").glob("*.asm")):
    if f.name in ("flee_mons.asm", "roammon_maps.asm", "unlocked_unowns.asm", "probabilities.asm",
                  "treemon_maps.asm"):
        continue
    add(mentioned(f), f"wild ({f.name})")
add(mentioned(root / "data/events/odd_eggs.asm"), "the ODD EGG")
for line in open(root / "data/events/npc_trades.asm"):
    m = re.match(r"\s*npctrade\s+\w+,\s*(\w+),\s*(\w+)", line)
    if m:
        add([m.group(2)], "a trade")
script = re.compile(r"^\s*(givepoke|giveegg|loadwildmon)\s+(\w+)")
for f in sorted((root / "maps").glob("*.asm")):
    text = open(f).read()
    for line in text.splitlines():
        m = script.match(line)
        if m and m.group(2) in names:
            add([m.group(2)], f"{m.group(1)} ({f.stem})")
    # givepoke 0 gives the species a setmonval put in wScriptVar (OAK's table, the
    # FOSSILS)
    if re.search(r"^\s*givepoke 0\b", text, re.M):
        add([s for s in re.findall(r"^\s*setmonval\s+(\w+)", text, re.M) if s in names], f"givepoke ({f.stem})")
for line in open(root / "engine/events/shuckle.asm"):
    add([w for w in ident.findall(line.split(";")[0]) if w in names], "SHUCKIE")
# the starters (ELM's LAB gives them by a special: see GetStarterSpecies)
add(["CHIKORITA", "CYNDAQUIL", "TOTODILE"], "the starters")

# evolutions, and each one's first stage
evos = {s: [] for s in species}
pre = {}
labels = [l.split()[1] for l in open(root / "data/pokemon/evos_attacks_pointers.asm")
          if l.strip().startswith("dw ")]
by_label = dict(zip(labels, species))
cur = None
for line in open(root / "data/pokemon/evos_attacks.asm"):
    m = re.match(r"(\w+)EvosAttacks:", line)
    if m:
        cur = by_label.get(m.group(0)[:-1])
        continue
    m = re.match(r"\s*db[bw]*\s+(EVOLVE_\w+),.*?(\w+)\s*(?:;.*)?$", line)
    if cur and m and m.group(2) in names:
        evos[cur].append(m.group(2))
        pre.setdefault(m.group(2), cur)
    if re.match(r"\s*db 0 ; no more evolutions", line):
        cur = None

# breeding
base_files = [l.split('"')[1] for l in open(root / "data/pokemon/base_stats.asm") if "INCLUDE" in l]
breeds, genderless = {}, set()
for s, path in zip(species, base_files):
    text = open(root / path).read()
    eggs = re.search(r"dn\s+(\w+),\s*(\w+)", text).groups()
    breeds[s] = "EGG_NONE" not in eggs
    if "GENDER_UNKNOWN" in text:
        genderless.add(s)


def first_stage(s):
    while s in pre:
        s = pre[s]
    return s


got = set(sources)
changed = True
while changed:
    changed = False
    for s in list(got):
        new = list(evos[s])
        if breeds[s] and (s not in genderless or "DITTO" in got) and s != "DITTO":
            new.append(first_stage(s))
        for n in new:
            if n not in got:
                got.add(n)
                sources[n] = f"from {s}"
                changed = True

missing = [s for s in species if s not in got and s != "EGG"]
for s in missing:
    print(s)
sys.exit(1 if missing else 0)
