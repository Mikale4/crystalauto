# Pokémon Crystal: Auto Battle

Pokémon Crystal with an **auto battle** button. Turn it on in any battle and the
game picks your Pokémon's moves for you, turn after turn, until you turn it off.
Pokémon also **evolve as soon as they reach their evolution level** in battle,
instead of waiting for the battle to end.

Outside of battle, **your lead Pokémon follows you around**, and every POKéMON
CENTER has a **CHANSEY you can rent**: it walks along with you and heals your team
whenever you ask.

It is built from the [pret/pokecrystal][pokecrystal] disassembly. The rest of the
game is unchanged, and so is the save format, so saves from the original game
carry over.


## How to use it

1. In a battle, the menu shows **SELECT →AUTO** next to FIGHT / PKMN / PACK / RUN.
2. Press **SELECT**. Your Pokémon attacks right away, and every following turn
   is automatic. The text box shows **AUTO BATTLE / SELECT to stop** for half a
   second at the start of each turn.
3. Press **SELECT** at any time to stop. The normal menu comes back at the start
   of the next turn.

Auto battle only picks moves. Choices that matter still go to you: switching
after a Pokémon faints, catching, evolving (B still stops an evolution), and
learning new moves. When a Pokémon with four moves wants to learn another, the game
waits for you to choose which move to forget, or not to learn it, even with auto
battle on.

It works in wild and trainer battles and in the Bug-Catching Contest (whose menu
has no room for the hint, but SELECT works the same). It is also enabled in link
battles and the Battle Tower.

### Normal or continuous

**OPTION** (in the START menu or on the title screen) has an **AUTO BATTLE** setting on
its second page (choose **NEXT** at the bottom of the first page):

- **NORMAL** (the default): auto battle turns off when the battle ends, so every
  battle starts with the menu, and a wild Pokémon you want to catch is never
  knocked out by surprise.
- **CONTINUOUS**: every battle starts in auto battle, from the first turn. Press
  SELECT to stop it for the rest of that battle, even during "Wild … appeared!"
  if you want to make the first move yourself. The next battle starts in auto again.

  The battle text moves along by itself too, so a whole battle plays out without
  pressing anything: "Wild … appeared!", "… wants to battle!", fainting, EXP and
  level-up stats, evolutions, the trainer's defeat line and the prize money. Each
  text box stays up for two-thirds of a second, and A or B still skips ahead.
  Choices still wait for you: whether to learn a move (and which one to forget),
  "Use next POKéMON?", and which Pokémon to send out. After pressing SELECT, text
  waits for A or B again. Text outside of battle, like what a trainer says before
  and after, is unchanged.

The catching demonstration on Route 29 is never automatic. The setting is saved
with your game.


## How it picks a move

Each turn it rates every move that can be selected (it skips moves with no PP left
and Disabled moves) and uses the best one:

- **Damaging moves** are rated by the damage they should deal this turn. This uses
  the game's own damage formula: your stats and stat changes, the foe's
  Defense, STAB, type matchups, held items, weather, badges, Reflect and Light Screen.
  - It counts on the lowest of the game's random damage rolls, and damage beyond
    the foe's remaining HP counts for nothing. The result is then scaled by
    accuracy, so a sure knockout beats a stronger move that might miss.
  - If more than one move would knock the foe out, it prefers a priority move
    such as Quick Attack, so the foe doesn't get to attack first.
  - Multi-hit moves count every hit. Two-turn moves (Solar Beam outside of
    sunlight, Fly, Dig, Sky Attack, Skull Bash, Razor Wind) and Hyper Beam count half.
  - Fixed-damage moves (Seismic Toss, Night Shade, Dragon Rage, Sonic Boom,
    Super Fang, Psywave), Hidden Power, Return, Frustration, Flail and Reversal
    use their real damage. Magnitude and Present use typical values.
  - One-hit KO moves count the foe's whole HP times their accuracy, and are skipped
    against a higher-level foe.
- **Status moves** (and Counter, Mirror Coat, Bide and Future Sight, whose damage
  can't be predicted) are only used when no damaging move can hurt the foe.
- **Self-Destruct and Explosion** are a last resort.
- **Moves that would fail** come last: moves the foe is immune to, Dream Eater on
  an awake foe, Snore and Sleep Talk while awake, and False Swipe on a foe with 1 HP.
- **While asleep**, it prefers Sleep Talk, then Snore.

If no move can be selected, your Pokémon uses Struggle, as usual.


## Evolving in battle

In the original game, a Pokémon that reaches its evolution level in battle only
evolves once the battle is won, so not at all if you go on to lose. Here it evolves
right after its level-up, before the next foe is sent out:

- The usual evolution scene plays, then the battle picks up where it left off.
  If the Pokémon in battle evolved, it keeps fighting with its new species, types,
  stats and name, and any stat changes from the battle are kept.
- Pressing B still stops the evolution, and an Everstone still prevents it. Like
  after a battle, a stopped evolution is tried again at the next level-up.
- This covers every evolution that happens on level-up: by level, by friendship
  (Golbat, Chansey, Eevee and the baby Pokémon) and Tyrogue's. Pokémon that level up
  from an Exp. Share evolve too.
- Moves learned on evolving (like Gyarados's Bite) can be used right away.


## Your Pokémon follows you

The first Pokémon in your party that isn't fainted (or an egg) walks behind you,
one step back, at your speed.

- It walks where you walked: around corners, through doors, down ledges (it hops
  them right after you) and across from one route or town to the next.
- You can walk through it: step back into it and you swap places.
- After going through a door, up stairs or any other warp, it waits on your tile
  and comes out behind you on your first step. It also stays out of sight while you
  SURF, and comes back once you're on land.
- Like in HEARTGOLD and SOULSILVER, it goes back in its ball while you ride the
  BICYCLE, and comes back out when you get off.
- Don't want it? Set **FOLLOWER** to **OFF** on the second page of the **OPTION**
  menu.
- Talk to it to see how it's doing: it may be happily trotting along, sniffing the
  breeze or ready for a battle, or it may tell you it needs a rest.
- Change your lead Pokémon (in the party menu, at the PC, or when it faints) and
  the new one takes its place. Its color matches its type.
- If someone walks into its spot, it gets out of the way and comes back out behind
  you on your next step.

It looks like the Pokémon's party icon, like every Pokémon you see walking around in
Crystal (the Day-Care Pokémon, the Pokémon in people's houses).

Followers don't come along in the link rooms or the BATTLE TOWER. A map's own
people and objects always come first: in the rare spot where a map needs every
object slot, the followers make room and come back when there's space again.


## Rent NURSE JOY's CHANSEY

Every POKéMON CENTER has a CHANSEY behind the counter, next to NURSE JOY. Talk to
it to take it with you:

| Heals | Price  |
| ----- | ------ |
| 5     | ¥500   |
| 10    | ¥1,000 |
| 15    | ¥1,500 |

- The CHANSEY walks behind your Pokémon, or right behind you when your Pokémon isn't
  out (on the BICYCLE, or with FOLLOWER set to OFF). It always comes along, on foot or
  on the BICYCLE; only SURF puts it away for a while.
- Talk to it, or press **B** anywhere to call it, and it offers to use SOFTBOILED:
  your whole team is fully healed (HP, status and PP), fainted Pokémon included. It
  tells you how many heals it has left, and doesn't use one if your team is already
  in perfect shape.
- You can only have one CHANSEY at a time. The one from that POKéMON CENTER is away
  while it's with you; the others tell you their friend is already out traveling.
- When its last heal is used, it heads back home to its POKéMON CENTER.

The CHANSEY and its heals are saved with your game.


## Playing it

You need your own Pokémon Crystal (USA/Europe) **Rev 1** ROM
(`sha1: f2f52230b536214ef7c9924f483392993e226cfb`). Apply one of these patches to it
with a patcher such as [Rom Patcher JS][rompatcher] or Floating IPS:

- [`patches/pokecrystal11_auto_battle.bps`](patches/pokecrystal11_auto_battle.bps)
  (checks that the ROM is the right one)
- [`patches/pokecrystal11_auto_battle.ips`](patches/pokecrystal11_auto_battle.ips)

The patched ROM has `sha1: c78aaf0c1d36e5741fa3d741d48d3f1154ec37b0`.


## Building it

Set up the tools as described in [INSTALL.md](INSTALL.md) (rgbds 1.0.4), then:

```sh
make crystal11    # builds pokecrystal11.gbc (Rev 1)
```

`make` builds the original release (`pokecrystal.gbc`), and the other targets in
the Makefile work too. `make compare` no longer matches the original ROMs, since
the game has changed.

To remake the patches from your own Rev 1 ROM:

```sh
python3 tools/make_ips_bps.py baserom11.gbc pokecrystal11.gbc patches/pokecrystal11_auto_battle
```


## The code

- [`engine/battle/auto_battle.asm`](engine/battle/auto_battle.asm) has the auto battle
  turn, the move rating, `InitAutoBattle`, which turns it on at the start of a
  battle with the CONTINUOUS option, and `AutoBattleTextDelay`, which moves battle
  text along. `PromptButton` and `WaitPressAorB_BlinkCursor` in
  [`home/joypad.asm`](home/joypad.asm), where text waits for A or B, call it first,
  the same way they already skip the wait in link battles.
- [`engine/battle/menu.asm`](engine/battle/menu.asm) turns it on when SELECT is pressed
  in the battle menu, and shows the hint.
- [`engine/battle/core.asm`](engine/battle/core.asm) skips the battle menu and the
  move menu while it is on, and evolves Pokémon after the party gains experience.
- `wAutoBattle` in [`ram/wram.asm`](ram/wram.asm) is an unused byte of battle RAM, so it
  is cleared at the start of every battle.
- [`engine/menus/options_menu.asm`](engine/menus/options_menu.asm) now has pages
  (`OptionsPages`). The first is Crystal's own options, as they were; the second has
  AUTO BATTLE and FOLLOWER, stored in spare bits of `wOptions2`
  (`CONTINUOUS_AUTO_BATTLE`, `NO_FOLLOWER`), which is saved with the other options.
  Each page ends with CANCEL and NEXT or BACK. To add an option, add its `OPT_*`
  constant, handler and cursor position, and its name to a page's strings.
- [`engine/battle/evolve_in_battle.asm`](engine/battle/evolve_in_battle.asm) runs the
  game's own `EvolveAfterBattle` during the battle, then restores the battle screen,
  music and the evolved Pokémon's battle data.
- [`engine/overworld/followers.asm`](engine/overworld/followers.asm) runs the
  followers. Each one is an object struct with no map object, so it never takes one
  of a map's object slots (`CopyObjectStruct` sends a follower away if a map object
  needs its struct). `UpdateFollowers` runs every overworld frame from
  `HandleMapObjects`: it brings the followers out or puts them away, hides them, and
  loads the lead Pokémon's icon when it changes. `DoMovementFunction` tells it about
  every step the player takes; each follower keeps a short queue of the tiles its
  leader left and walks into them (`MovementFunction_Follower`, a new
  `SPRITEMOVEDATA_FOLLOWER`). The player walks through followers (`IsNPCAtCoord`
  skips them for the player's own moves), they keep their places across map
  connections, and `ApplyMovement` lets them follow the player's scripted walks.
- [`engine/events/follower_scripts.asm`](engine/events/follower_scripts.asm) has what
  the followers say, the CHANSEY's SOFTBOILED, and the rental at the counter
  (`PokecenterChanseyScript`, a new standard script used by every POKéMON CENTER's map).
- The icons use two new sprite IDs, `SPRITE_FOLLOWER` and `SPRITE_RENTAL_CHANSEY`,
  and a new 8-tile `ICON_SPRITE` type. Every map loads them, so to make room
  `ArrangeUsedSprites` now fills the end of the first VRAM table with later, shorter
  sprites and lets a sprite end exactly at the end of the second.
- The rental's heals and POKéMON CENTER are kept in three spare bytes of the saved
  player data (`wRentalChanseyHeals`), and `EVENT_RENTAL_CHANSEY_FROM_HERE`, a
  formerly unused event flag, hides the counter CHANSEY in the POKéMON CENTER it
  came from.


## Based on pret/pokecrystal

This is a disassembly of Pokémon Crystal by [pret][pret]. For the disassembly itself, see:

- [**FAQ**](FAQ.md)
- [**Documentation**][docs]
- [**Wiki**][wiki] (includes [tutorials][tutorials])
- [**Symbols**][symbols]
- [**Tools**][tools]

[pokecrystal]: https://github.com/pret/pokecrystal
[pret]: https://pret.github.io/
[rompatcher]: https://www.marcrobledo.com/RomPatcher.js/
[docs]: https://pret.github.io/pokecrystal/
[wiki]: https://github.com/pret/pokecrystal/wiki
[tutorials]: https://github.com/pret/pokecrystal/wiki/Tutorials
[symbols]: https://github.com/pret/pokecrystal/tree/symbols
[tools]: https://github.com/pret/gb-asm-tools
