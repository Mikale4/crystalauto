# Pokémon Crystal: Auto Battle

Pokémon Crystal with an **auto battle** button. Turn it on in any battle and the
game picks your Pokémon's moves for you, turn after turn, until you turn it off.
Pokémon also **evolve as soon as they reach their evolution level** in battle,
instead of waiting for the battle to end.

Outside of battle, **your lead Pokémon follows you around**, and every POKéMON
CENTER has a **CHANSEY you can rent**: it walks along with you and heals your team
whenever you ask.

Catching follows **PalletToPewter's rule**: beat a wild Pokémon first, then throw
your BALLS at it before it gets away. The DUDE on ROUTE 29 shows you how, and gives
you the RATTATA he catches. PalletToPewter's **level caps**, **difficulties**
(NORMAL, HARD and EXTREME) and **boss Pokémon** are here too.

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
  battle starts with the menu.
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

The catching demonstration on Route 29 is never automatic. When auto battle beats a
wild Pokémon you've already caught, the battle just ends; one you haven't caught yet
still stops and asks whether to throw a BALL (see [Catching](#catching)). The setting
is saved with your game.


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


## Catching

Catching works the way it does in PalletToPewter:

- A wild Pokémon won't go in a BALL while it can still battle. Try, and you're told
  to beat it first; the BALL isn't used up.
- Beat it, and once your team has its EXP. it gets back up with 1 HP, **worn out**:
  it can't battle any more.
- "Throw a BALL?" opens your BALLS, with how many of each you have. Pick one, or
  **LEAVE** it be. You get **3 tries, plus one for each badge**, before it gets away;
  the prompt counts them down. The Pokémon TEAM ROCKET disguises as items in their
  hideout never run off, so you can throw as many as you like at them.
- A Pokémon you catch comes out of its BALL rested: full HP, no status, full PP.
- In the BUG-CATCHING CONTEST it works the same way, with your PARK BALLS.

### The DUDE on ROUTE 29

The DUDE's catching lesson shows the rule: he beats the wild RATTATA with a stone,
then throws his BALL. Afterwards he gives you that RATTATA (the very one he caught,
at level 5), and you can give it a nickname. It goes to the PC if your party is full.


## Boss Pokémon

As in PalletToPewter, the one-of-a-kind Pokémon of the story don't fight alone. Each
brings **five allies** that suit it and cover its weaknesses: "SUDOWOODO and its
allies attack!" They come at you one at a time ("GEODUDE comes first!", "ONIX rushes
in!"), then "SUDOWOODO joins the fight itself!" There's no running, and no BALL will
hold them. Beat the boss and it **decides to join you**: it gets back up, looks at you
for a long moment, and comes along, rested (to the PC if your party is full).

| Boss | Lv | Allies (each as evolved as its level allows) |
|---|---|---|
| SUDOWOODO (ROUTE 36) | 20 | GEODUDE, ONIX, BELLSPROUT, HOPPIP, PINECO |
| LAPRAS (UNION CAVE, Fridays) | 20 | SHELLDER, SEEL, WOOPER, ZUBAT, SLOWPOKE |
| the red GYARADOS (LAKE OF RAGE) | 30 | MAGIKARP, WOOPER, POLIWAG, TENTACOOL, GOLDEEN |
| ELECTRODE ×3 (TEAM ROCKET's hideout) | 23 | VOLTORB, MAGNEMITE, PIKACHU, ZUBAT, KOFFING |
| SNORLAX (VERMILION CITY) | 50 | SLOWBRO, WIGGLYTUFF, LICKITUNG, HYPNO, KANGASKHAN |
| SUICUNE (TIN TOWER) | 40 | STARYU, SEEL, WOOPER, HORSEA, SMOOCHUM |
| RAIKOU (BURNED TOWER) | 40 | ELEKID, JOLTEON, CHINCHOU, MAREEP, HOPPIP |
| ENTEI (BURNED TOWER) | 40 | GROWLITHE, MAGBY, HOUNDOUR, VULPIX, EXEGGCUTE |
| LUGIA (WHIRL ISLANDS) | 60 | HORSEA, CHINCHOU, MANTINE, SLOWPOKE, SKARMORY |
| HO-OH (TIN TOWER's roof) | 60 | FLAREON, VAPOREON, JOLTEON, ESPEON, UMBREON |
| CELEBI (ILEX FOREST) | 30 | PINECO, ODDISH, FARFETCH'D, HERACROSS, HOOTHOOT |

On NORMAL the allies are two levels under the boss. On HARD and EXTREME they're at
the level cap, and the boss at least two above it; on EXTREME they also have their
best movesets and perfect DVs. The random wild GYARADOS of the LAKE OF RAGE are
ordinary wild Pokémon: only the ones met in the story are bosses. Lose to a boss and
it's still there to try again.

**RAIKOU and ENTEI don't roam.** After they bolt from the BURNED TOWER's basement,
they come back to where you first saw them and wait there. They won't battle you
until SUICUNE has joined you; after that, each is a boss. (A game saved while they
roamed stops them roaming; if you already caught one, it doesn't come back.)

## Level caps

As in PalletToPewter, your Pokémon only grow to **two levels below the strongest
Pokémon of your next big battle**. The cap never goes back down, and once RED is
beaten there is none. Your TRAINER CARD shows it.

| Next big battle | Its strongest Pokémon | Level cap |
|---|---|---|
| Your rival in CHERRYGROVE CITY | Lv 5 | 5 |
| FALKNER | PIDGEOTTO, Lv 9 | 7 |
| BUGSY, then your rival in AZALEA TOWN | SCYTHER and his starter, Lv 16 | 14 |
| WHITNEY, then the odd tree on ROUTE 36 | MILTANK and SUDOWOODO, Lv 20 | 18 |
| Your rival in the BURNED TOWER | his starter, Lv 22 | 20 |
| MORTY | GENGAR, Lv 25 | 23 |
| CHUCK, JASMINE and PRYCE (and the red GYARADOS and TEAM ROCKET's hideout on the way) | JASMINE's STEELIX, Lv 35 | 33 |
| TEAM ROCKET in the RADIO TOWER | an EXECUTIVE's GOLBAT, Lv 36 | 34 |
| CLAIR, then your rival on VICTORY ROAD | KINGDRA, Lv 40 | 38 |
| WILL, KOGA, BRUNO, KAREN | Lv 42, 44, 46, 47 | 40, 42, 44, 45 |
| LANCE | DRAGONITE, Lv 50 | 48 |
| KANTO's other GYM LEADERS | BLAINE's RAPIDASH, Lv 50 | 48 |
| BLUE | GYARADOS, Lv 58 | 56 |
| RED | PIKACHU, Lv 81 | 79 |

Where Crystal lets you take the battles in any order (the middle of JOHTO, the RADIO
TOWER, KANTO's GYMS), they count as one, with the strongest Pokémon among them, the
way PalletToPewter groups CELADON's battles.

- A Pokémon at the cap gets no EXP ("… is at the level cap!"), and what it can't take
  is shared evenly among teammates that are still below it.
- RARE CANDY stops at the cap, and says who to beat next. So does the DAY-CARE.
- Saves from before the level caps start at the right cap for your badges.

## Difficulty

PROF. OAK asks how tough a journey you want after you choose your name. A game saved
before there were difficulties is asked once, when you CONTINUE. Your TRAINER CARD
shows it.

- **NORMAL**: the journey as it was meant to be, except that a GYM LEADER's whole team
  stands at its strongest Pokémon's level (so do the ELITE FOUR's, LANCE's and RED's).
- **HARD**: every trainer's Pokémon are at least at the level cap, and the leaders'
  whole teams at least two levels above it. They're as evolved as their level allows:
  level evolutions at their level, stone evolutions from Lv 20, trade evolutions from
  Lv 34 and friendship ones from Lv 30, each trainer going its own way where a line
  branches. Items can't be used in battle (BALLS still can, once a Pokémon is beaten).
- **EXTREME**: as HARD, and you get the **ENDLESSCANDY**, a RARE CANDY that never
  runs out, right up to the level cap. But every trainer brings **six Pokémon**
  (except your rival in CHERRYGROVE CITY, who has just his starter). Their own are
  joined by others that suit them, from a list for each kind of trainer: birds for
  FALKNER and the BIRD KEEPERS, ice for PRYCE and the SKIERS, water for MISTY and the
  SWIMMERS, and so on, with a few that cover the theme's weaknesses (SKARMORY for the
  birds, a water Pokémon for the fire trainers). They join at the trainer's level, as
  evolved as that allows, but no stronger than is fair for it (their base stats add
  up to no more than 300 + 6 × the level; otherwise they join as an earlier form), so
  a SNORLAX or a LAPRAS waits until the late game. Then every one of them gets:
  - **its best moveset**, from the moves it has learned by its level and the TMs, HMs
    and tutor moves a player could have by then (by your badges): its three strongest
    attacks of different types (power, the attack stat that move type uses, its own
    type, accuracy, and moves that hit more than once or need a turn to charge), then
    its best support move (sleep, paralysis, a stat boost, recovery, TOXIC, …).
  - **perfect DVs**.
  - **a held item**: the one that boosts its best attack's type, else LEFTOVERS, QUICK
    CLAW, KING'S ROCK, SCOPE LENS, BRIGHTPOWDER or a berry, no two the same on a team.
  - **smarter battling**: the AI uses every one of its tricks.

  Boss Pokémon and their allies get their best movesets and perfect DVs too (the red
  GYARADOS stays red).


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

The patched ROM has `sha1: 80164713238de322134b648bd8e0a6f8b503f5aa`.


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
- [`engine/battle/capture_rule.asm`](engine/battle/capture_rule.asm) has the capture
  rule. `PokeBallEffect` asks `CaptureRule_CheckBall` before a BALL is thrown;
  `HandleEnemyMonFaint` calls `WildMonWornOut` after the EXP., which brings the
  Pokémon back with 1 HP and runs the BALL menu (the BALLS pocket in a scrolling menu,
  with LEAVE for CANCEL) and the tries, throwing with the game's own `PokeBallEffect`.
  `wCaptureFlags` and `wCaptureTriesLeft` are two unused bytes of battle RAM, cleared
  at the start of every battle.
- The same file has the DUDE's part of the lesson: `DudeBeatsWildMon` runs before his
  BALL in the tutorial battle, the tutorial catch keeps the RATTATA's DVs in
  `wDudeMonDVs`, and [`maps/Route29.asm`](maps/Route29.asm) gives it with `givepoke`,
  then `GiveDudeMonCaughtDVs` gives it those DVs.
- [`engine/pokemon/level_caps.asm`](engine/pokemon/level_caps.asm) has the level cap
  steps (`LevelCapStepAces`, `LevelCapStepFlags`), `GetLevelCap`, and the EXP hooks
  `GiveExperiencePoints` calls: `LevelCap_ClampExp` for each Pokémon, and
  `LevelCap_ShareExcess`, which runs `GiveExperiencePoints` once more to share what
  was left over. `wLevelCapStep` (saved) counts the steps done; new event flags mark
  the rival battles and RED (`EVENT_BEAT_RIVAL_IN_*`, `EVENT_BEAT_RED`).
- [`engine/events/difficulty.asm`](engine/events/difficulty.asm) asks for the
  difficulty (`wDifficulty`, saved), gives the ENDLESSCANDY (item `$89`, formerly
  unused), blocks items in battle and prints the TRAINER CARD's new line.
  [`engine/battle/difficulty_trainers.asm`](engine/battle/difficulty_trainers.asm)
  changes trainers' teams after `ReadTrainerParty` makes them (`FitEvolution` reads the
  game's own evolution data), and
  [`engine/battle/extreme_trainers.asm`](engine/battle/extreme_trainers.asm) makes
  EXTREME's: `FillExtremeTeam` (from
  [`data/trainers/extreme_pools.asm`](data/trainers/extreme_pools.asm)),
  `PickBestMoves` (learnsets, `TMHMMoves` and `TMHMBadgesNeeded`) and
  `GiveExtremeHeldItem`. `GetEnemyMonTrainerDVs` gives a boss's and EXTREME trainers'
  Pokémon their own DVs in battle, where other trainers' use their class's.
- [`engine/battle/bosses.asm`](engine/battle/bosses.asm) makes a scripted wild battle
  with a boss (`BossTeams`) a trainer battle that borrows `BOSS_TRAINER_CLASS`, and
  changes what that class would decide: the party (`LoadBossParty`), name, picture and
  palette (the boss's), the order the allies come in (`BossNextMon`), the AI
  (`GetAIMoveWeights`, `GetAIItemSwitchAttributes`: smart, never switching), the texts
  (`BossBattleText`) and the win (`BossJoins`). `wBossBattle` holds the boss until the
  battle ends. RAIKOU and ENTEI wait in
  [`maps/BurnedTowerB1F.asm`](maps/BurnedTowerB1F.asm); `InitRoamMons` now stops
  roaming instead of starting it.
- The rental's heals and POKéMON CENTER are kept in three spare bytes of the saved
  player data (`wRentalChanseyHeals`), and `EVENT_RENTAL_CHANSEY_FROM_HERE`, a
  formerly unused event flag, hides the counter CHANSEY in the POKéMON CENTER it
  came from.


## Other changes

- The player's sprite (CHRIS) has black pixels instead of red ones beside his face.


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
