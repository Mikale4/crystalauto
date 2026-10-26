#!/usr/bin/env python3
"""Check that no code uses a move's constant as an 8-bit move ID.

Moves' constants are 16-bit indexes; memory and saves keep 8-bit IDs that
stand for them (see engine/16/move_table.asm). So a move's constant may only
appear where a 16-bit index is meant: `dw`, a 16-bit `ld`, the `cpmove` macro,
`HIGH()`/`LOW()`, assembly-time expressions... This lists every other use.

Usage: tools/check_move_ids.py [repository root]
"""
import re
import sys
from pathlib import Path

root = Path(sys.argv[1] if len(sys.argv) > 1 else ".")

moves = set()
for line in open(root / "constants/move_constants.asm"):
    m = re.match(r"\s*const\s+(\w+)", line)
    if m and not m.group(1).startswith("ANIM_"):
        moves.add(m.group(1))
    if line.startswith("DEF NUM_ATTACKS"):
        break
moves.discard("NO_MOVE")  # (0 either way)
moves.add("NUM_ATTACKS")

SKIP_DIRS = ("constants/", "data/tilesets/", "data/text/", "audio/", "gfx/", "tools/", "vc/", "lib/")
# lines where a move's constant is fine
OK = re.compile(
    r"^\s*(?:"
    r"dw\b|dwb\b|bigdw\b|"
    r"ld\s+(?:hl|bc|de|sp)\s*,|"
    r"cpmove\b|ldmove\b|ldbmove\b|ld_anim\b|"
    r"assert\w*\b|if\b|elif\b|DEF\b|def\b|for\b|"
    r"tmhm\b|move\b|"  # base stats' TM/HM lists; the moves' own data
    r"move_tutor_entry\b|mon_menu_move\b|level_move\b"
    r")"
)
STRING = re.compile(r'"(?:[^"\\]|\\.)*"')
WORD = re.compile(r"\b[A-Z][A-Z0-9_]*\b")
TMHM_MOVE = re.compile(r"(?:TM|HM|MT)\d\d_MOVE$")  # (see constants/item_constants.asm)
SAFE_FUNC = re.compile(r"\b(?:HIGH|LOW)\s*\([^()]*\)")
SKIP_FILES = ("constants.asm",)

errors = []
for path in sorted(root.rglob("*.asm")):
    rel = path.relative_to(root).as_posix()
    if rel.startswith(SKIP_DIRS):
        continue
    for n, line in enumerate(path.read_text(errors="replace").split("\n"), 1):
        code = STRING.sub("", line.split(";")[0])
        if not code.strip() or OK.match(code):
            continue
        code = SAFE_FUNC.sub("", code)
        m = re.match(r"\s*dbw\s+([^,]*),", code)
        if m:
            code = m.group(1)  # (the word is fine)
        used = [w for w in WORD.findall(code) if w in moves or TMHM_MOVE.match(w)]
        if used:
            errors.append(f"{rel}:{n}: {line.strip()}")

for e in errors:
    print(e)
if errors:
    print(f"{len(errors)} uses of a move's constant as an 8-bit ID", file=sys.stderr)
    sys.exit(1)
