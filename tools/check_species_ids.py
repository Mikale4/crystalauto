#!/usr/bin/env python3
"""Check that no code uses a species' constant as an 8-bit species ID.

Species' constants are 16-bit indexes; memory and saves keep 8-bit IDs that
stand for them (see engine/16/mon_table.asm). So a species' constant may only
appear where a 16-bit index is meant: `dw`, a 16-bit `ld`, the `cpmon` and
`ldmon` macros, assembly-time expressions... This lists every other use.
(EGG is its own ID too: $FD, which the table keeps for it.)

Usage: tools/check_species_ids.py [repository root]
"""
import re
import sys
from pathlib import Path

root = Path(sys.argv[1] if len(sys.argv) > 1 else ".")

species = set()
for line in open(root / "constants/pokemon_constants.asm"):
    m = re.match(r"\s*const\s+(\w+)", line)
    if m:
        species.add(m.group(1))
    if line.startswith("DEF NUM_POKEMON"):
        break
species.add("NUM_POKEMON")

# (the debug room and the color picker are only in debug builds; EZ Chat's
# Japanese-order Pokémon list is only for mobile features, unused here)
SKIP_FILES = ("data/pokemon/ezchat_order.asm",)
SKIP_DIRS = ("engine/debug/", "constants/", "data/tilesets/", "data/text/", "audio/", "gfx/", "tools/", "vc/", "lib/")
# lines where a species' constant is fine
OK = re.compile(
    r"^\s*(?:"
    r"ds\b|dw\b|bigdw\b|"
    r"ld\s+(?:hl|bc|de|sp)\s*,|"
    r"cpmon\b|ldmon\b|"
    r"assert\w*\b|if\b|elif\b|DEF\b|def\b|for\b|"
    r"mon_species\b|species_dw\b|fishmon\b|time_group\b|time_fish\b|treemon\b|contest_mon\b|decoration\b|npctrade\b|dcatch\b|cry\b|givepoke\b|giveegg\b|getmonname\b|pokepic\b|loadwildmon\b|checkpoke\b|setmonval\b|checkmonval\b"
    r")"
)
STRING = re.compile(r'"(?:[^"\\]|\\.)*"')
WORD = re.compile(r"\b[A-Z][A-Z0-9_]*\b")
SAFE_FUNC = re.compile(r"\b(?:HIGH|LOW)\s*\([^()]*\)")

errors = []
for path in sorted(root.rglob("*.asm")):
    rel = path.relative_to(root).as_posix()
    if rel.startswith(SKIP_DIRS) or rel in SKIP_FILES:
        continue
    for n, line in enumerate(path.read_text(errors="replace").split("\n"), 1):
        code = STRING.sub("", line.split(";")[0])
        code = re.sub(r"^[\w.]+::?", "", code) # (a label)
        if not code.strip() or OK.match(code):
            continue
        code = SAFE_FUNC.sub("", code)
        # data macros with words and bytes: only their bytes can't be species
        m = re.match(r"\s*(dbw|dwb|dbwb|dbbw|dbbbw)\s+(.*)", code)
        if m:
            args = [a.strip() for a in m.group(2).split(",")]
            kinds = {"dbw": "bw", "dwb": "wb", "dbwb": "bwb", "dbbw": "bbw", "dbbbw": "bbbw"}[m.group(1)]
            code = ",".join(a for a, k in zip(args, kinds) if k == "b")
        used = [w for w in WORD.findall(code) if w in species]
        if used:
            errors.append(f"{rel}:{n}: {line.strip()}")

for e in errors:
    print(e)
if errors:
    print(f"{len(errors)} uses of a species' constant as an 8-bit ID", file=sys.stderr)
    sys.exit(1)
