#!/usr/bin/env python3
"""The walkable regions of each map, for the Demo's way around the world (see
tools/demo_world.py): cells the player can go between both ways with nothing but
walking (and jumping down ledges, and sliding on ice), and the ways from region to
region, some of them needing a field move.

This follows the Demo's own walking (engine/demo/demo_walk.asm: DemoStandable,
DemoCanStep, DemoTryFrom), from the maps' block and collision data.
"""
import re
from functools import lru_cache
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

DOWN, UP, LEFT, RIGHT = range(4)
STEP = {DOWN: (0, 1), UP: (0, -1), LEFT: (-1, 0), RIGHT: (1, 0)}

# field moves (DEMOFIELD_* in constants/demo_constants.asm)
CUT, SURF, WHIRLPOOL, WATERFALL, ROCK_SMASH = (1 << i for i in range(5))

# directions as bits: DOWN 1, UP 2, LEFT 4, RIGHT 8 (as DemoSideWallExits and co.)
SIDE_WALL_EXITS = [8, 4, 2, 1, 9, 5, 10, 6]
SIDE_WALL_ENTRIES = [4, 8, 1, 2, 6, 10, 5, 9]
LEDGE_DIRS = [8, 4, 2, 1, 9, 5, 10, 6]


@lru_cache(None)
def collision_consts():
    """name -> value, value -> name"""
    by_name = {}
    for line in open(ROOT / "constants/collision_constants.asm"):
        m = re.match(r"DEF (COLL_\w+|HI_NYBBLE_\w+)\s+EQU \$(\w+)", line)
        if m:
            by_name[m.group(1)] = int(m.group(2), 16)
    return by_name


@lru_cache(None)
def permissions():
    """collision value -> (LAND_TILE | WATER_TILE | WALL_TILE, talk)"""
    out = []
    for line in open(ROOT / "data/collision/collision_permissions.asm"):
        s = line.strip()
        if s.startswith("db"):
            body = s[2:].split(";")[0]
            kind = "WALL_TILE" if "WALL_TILE" in body else "WATER_TILE" if "WATER_TILE" in body else "LAND_TILE"
            out.append((kind, "TALK" in body))
    return out


@lru_cache(None)
def map_consts():
    """file label -> map const"""
    out = {}
    for line in open(ROOT / "data/maps/attributes.asm"):
        m = re.match(r"\s*map_attributes (\w+), (\w+),", line)
        if m:
            out[m.group(1)] = m.group(2)
    return out


@lru_cache(None)
def map_sizes():
    """map const -> (width, height) in blocks"""
    out = {}
    for line in open(ROOT / "constants/map_constants.asm"):
        m = re.match(r"\s*map_const (\w+),\s*(\d+),\s*(\d+)", line)
        if m:
            out[m.group(1)] = (int(m.group(2)), int(m.group(3)))
    return out


def labelled_file(path, label, directive):
    found = False
    for line in open(ROOT / path):
        if line.startswith(label + ":"):
            found = True
        elif found and directive in line:
            return re.search(r'"(.+?)"', line).group(1)
    raise KeyError(label)


@lru_cache(None)
def tileset_collisions(tileset):
    tilesets = [m.group(1) for m in re.finditer(r"^\s*const (TILESET_\w+)", (ROOT / "constants/tileset_constants.asm").read_text(), re.M)]
    names = re.findall(r"^\s*tileset (\w+)", (ROOT / "data/tilesets.asm").read_text(), re.M)
    name = names[tilesets.index(tileset) + 1]  # (Tileset0 comes first)
    consts = collision_consts()
    coll = []
    for line in open(ROOT / labelled_file("gfx/tilesets.asm", name + "Coll", "INCLUDE")):
        m = re.match(r"\s*tilecoll (\w+), (\w+), (\w+), (\w+)", line)
        if m:
            coll.append(tuple(consts["COLL_" + g] for g in m.groups()))
    return coll


@lru_cache(None)
def map_tilesets():
    out = {}
    for line in open(ROOT / "data/maps/maps.asm"):
        m = re.match(r"\s*map (\w+), (\w+),", line)
        if m:
            out[m.group(1)] = m.group(2)
    return out


def collision(label):
    """{(x, y): collision value} of a map (by its file label), and its size in cells."""
    const = map_consts()[label]
    width, height = map_sizes()[const]
    coll = tileset_collisions(map_tilesets()[label])
    blocks = (ROOT / labelled_file("data/maps/blocks.asm", label + "_Blocks", "INCBIN")).read_bytes()
    grid = {}
    for i, b in enumerate(blocks[:width * height]):
        bx, by = i % width * 2, i // width * 2
        for q, c in enumerate(coll[b]):
            grid[(bx + q % 2, by + q // 2)] = c
    return grid, width * 2, height * 2


def object_events(label):
    """[(x, y, sprite, script, event flag)] of a map's object events"""
    out = []
    for line in open(ROOT / f"maps/{label}.asm"):
        s = line.strip()
        if s.startswith("object_event"):
            a = [t.strip() for t in s.split("object_event", 1)[1].split(";")[0].split(",")]
            out.append((int(a[0]), int(a[1]), a[2], a[11], a[12]))
    return out


def warp_events(label):
    """[(x, y, dest map const, dest warp number)]"""
    out = []
    for line in open(ROOT / f"maps/{label}.asm"):
        s = line.strip()
        if s.startswith("warp_event"):
            a = [t.strip() for t in s.split("warp_event", 1)[1].split(";")[0].split(",")]
            out.append((int(a[0]), int(a[1]), a[2], int(a[3])))
    return out


class Map:
    """A map's cells as the Demo walks them."""

    def __init__(self, label):
        self.label = label
        self.grid, self.w, self.h = collision(label)
        c = collision_consts()
        self.c = c
        # a warp's tile only warps where the map has a warp: anywhere else it's floor
        warps = {(x, y) for x, y, _, _ in warp_events(label)}
        for cell, v in self.grid.items():
            if v & 0xf0 == c["HI_NYBBLE_WARPS"] and cell not in warps:
                self.grid[cell] = c["COLL_FLOOR"]
        self.rocks ={(x, y) for x, y, spr, _, _ in object_events(label) if spr == "SPRITE_ROCK"}
        self.boulders = {(x, y) for x, y, spr, _, _ in object_events(label) if spr == "SPRITE_BOULDER"}

    def kind(self, cell):
        """'land', 'ice', 'water', 'waterfall', 'whirlpool', 'cut', 'rock' or None (no one stands there)"""
        if cell in self.boulders:
            return None
        if cell in self.rocks:
            return "rock"
        v = self.grid.get(cell)
        if v is None:
            return None
        c = self.c
        if v in (c["COLL_CUT_TREE"], c["COLL_CUT_TREE_1A"]):
            return "cut"
        if v in (c["COLL_WHIRLPOOL"], c["COLL_WHIRLPOOL_2C"]):
            return "whirlpool"
        if v == c["COLL_WATERFALL"]:
            return "waterfall"
        if v in (c["COLL_ICE"], c["COLL_ICE_2B"]):
            return "ice"
        hi = v & 0xf0
        if hi == c["COLL_PIT"] & 0xf0 or hi == c["HI_NYBBLE_CURRENT"]:
            return None
        perm = permissions()[v] if v < len(permissions()) else ("WALL_TILE", False)
        if perm[0] == "LAND_TILE":
            return "land"
        if perm[0] == "WATER_TILE":
            return "water"
        return None

    def need(self, kind, from_kind, d):
        """The field moves stepping into a cell of this kind needs (None: can't)."""
        if kind is None:
            return None
        if kind == "cut":
            return CUT
        if kind == "rock":
            return ROCK_SMASH
        afloat = from_kind in ("water", "whirlpool", "waterfall")
        surf = 0 if afloat else SURF
        if kind == "whirlpool":
            return WHIRLPOOL | surf
        if kind == "waterfall":
            if d == UP:
                return WATERFALL | surf
            if d == DOWN:
                return surf
            return None
        if kind == "water":
            return surf
        return 0

    def is_warp(self, cell):
        """A warp tile (a door, stairs, a cave...): stepping on it is going through
        it, so no way across a map goes over one (as the Demo walks)."""
        return self.grid.get(cell, 0) & 0xf0 == self.c["HI_NYBBLE_WARPS"]

    def side_blocked(self, cell, d, table):
        v = self.grid.get(cell, 0)
        hi = v & 0xf0
        if hi in (self.c["HI_NYBBLE_SIDE_WALLS"], self.c["HI_NYBBLE_SIDE_BUOYS"]):
            return table[v & 7] >> d & 1
        return 0

    def can_step(self, a, d, onto_warps=False):
        """The field moves a step from cell a that way needs, and where it ends (sliding
        on ice); None if it can't (or it ends on a warp, unless onto_warps)."""
        ka = self.kind(a)
        if ka is None:
            return None
        if ka == "waterfall" and d in (LEFT, RIGHT):
            return None
        dx, dy = STEP[d]
        b = (a[0] + dx, a[1] + dy)
        kb = self.kind(b)
        need = self.need(kb, ka, d)
        if need is None or self.side_blocked(a, d, SIDE_WALL_EXITS) or self.side_blocked(b, d, SIDE_WALL_ENTRIES):
            return None
        # on ice: on till off it, or till the way's blocked
        seen = 0
        while self.kind(b) == "ice" and seen < 100:
            n = (b[0] + dx, b[1] + dy)
            if self.kind(n) is None:
                break
            b = n
            seen += 1
        if self.is_warp(b) and not onto_warps:
            return None
        return need, b

    def ledge_jump(self, a, d):
        """Where a jump from cell a that way lands, or None."""
        v = self.grid.get(a, 0)
        if v & 0xf0 != self.c["HI_NYBBLE_LEDGES"] or not LEDGE_DIRS[v & 7] >> d & 1:
            return None
        dx, dy = STEP[d]
        over = (a[0] + dx, a[1] + dy)
        land = (a[0] + 2 * dx, a[1] + 2 * dy)
        if self.kind(over) is None and self.kind(land) in ("land", "ice") and not self.is_warp(land):
            return land
        return None

    def cells(self):
        return [cell for cell in self.grid if self.kind(cell) is not None]

    def edges(self):
        """{cell: [(next cell, needs)]}"""
        out = {}
        for a in self.cells():
            lst = []
            for d in STEP:
                r = self.can_step(a, d)
                if r:
                    lst.append((r[1], r[0]))
                j = self.ledge_jump(a, d)
                if j:
                    lst.append((j, 0))
            out[a] = lst
        return out


def sccs(nodes, succ):
    """Tarjan's strongly connected components (iterative). Returns {node: component}."""
    index, low, comp = {}, {}, {}
    stack, on = [], set()
    n = 0
    c = 0
    for root in nodes:
        if root in index:
            continue
        work = [(root, iter(succ(root)))]
        index[root] = low[root] = n
        n += 1
        stack.append(root)
        on.add(root)
        while work:
            v, it = work[-1]
            advanced = False
            for w in it:
                if w not in index:
                    index[w] = low[w] = n
                    n += 1
                    stack.append(w)
                    on.add(w)
                    work.append((w, iter(succ(w))))
                    advanced = True
                    break
                elif w in on:
                    low[v] = min(low[v], index[w])
            if advanced:
                continue
            work.pop()
            if work:
                low[work[-1][0]] = min(low[work[-1][0]], low[v])
            if low[v] == index[v]:
                while True:
                    w = stack.pop()
                    on.discard(w)
                    comp[w] = c
                    if w == v:
                        break
                c += 1
    return comp


def regions(label):
    """(Map, {cell: region}, {(region, region): {needs}}) for a map: regions are
    the free-move strongly connected components; each way between two needs the
    field moves of one of its masks. (Nothing steps onto a warp tile but to go
    through it: m.entries holds, for each, the regions a step onto it is from,
    and m.exits the regions a step off it (having come through it) is to:
    {warp cell: {region: (cell, needs)}}.)"""
    m = Map(label)
    edges = m.edges()
    free = {a: [b for b, need in lst if need == 0] for a, lst in edges.items()}
    comp = sccs(list(edges), lambda v: free.get(v, []))
    between = {}
    for a, lst in edges.items():
        for b, need in lst:
            ra, rb = comp[a], comp.get(b)
            if rb is None or ra == rb:
                continue
            # (the least each way needs: no mask that holds another)
            masks = between.setdefault((ra, rb), set())
            if any(m & need == m for m in masks):
                continue
            masks -= {m for m in masks if m & need == need}
            masks.add(need)
    m.entries, m.exits = {}, {}
    for w in edges:
        if not m.is_warp(w):
            continue
        for d, (dx, dy) in STEP.items():
            n = (w[0] - dx, w[1] - dy)
            if n in comp and not m.is_warp(n):
                r = m.can_step(n, d, onto_warps=True)
                if r and r[1] == w:
                    m.entries.setdefault(w, {}).setdefault(comp[n], (n, r[0]))
            r = m.can_step(w, d)
            if r:
                m.exits.setdefault(w, {}).setdefault(comp[r[1]], (r[1], r[0]))
    return m, comp, between


if __name__ == "__main__":
    import sys
    for label in sys.argv[1:]:
        m, comp, between = regions(label)
        n = len(set(comp.values()))
        print(label, "regions", n, "edges", len(between))
        sym = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        for y in range(m.h):
            print("".join(sym[comp[(x, y)] % len(sym)] if (x, y) in comp else "#" for x in range(m.w)))
