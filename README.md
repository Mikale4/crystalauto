# Pokémon Crystal: Auto Battle

Pokémon Crystal with an **auto battle** button. Turn it on in any battle and the
game battles for you, turn after turn, until you turn it off: it picks the moves,
switches to a better matchup, sends in the right Pokémon after one faints, and
decides which moves to learn. Pokémon also **evolve as soon as they reach their
evolution level** in battle, instead of waiting for the battle to end.

Battles work the way they do in the latest games: the **physical/special split**,
the **FAIRY type** and today's **type chart**, and **moves** with their modern power,
accuracy, PP and effects. Pokémon have **natures**, shown with their DVs on a new
page of the stats screen. **Evolutions are simpler** (no trading or friendship
needed), and, as in PalletToPewter, **no items are used in battle**: the X items
are held instead, and give their boost when the Pokémon comes in. Several **held
items** work in new ways (QUICK CLAW, KING'S ROCK, FOCUS BAND, …), a team holds only
one of some of them, **critical hits** work as they do today, and **every Pokémon
obeys you**, traded ones too.

Outside of battle, **your lead Pokémon follows you around**, and every POKéMON
CENTER has a **CHANSEY you can rent**: it walks along with you and heals your team
whenever you ask. As in PalletToPewter, **TMs never run out**, **HMs work without
the move** (and HM moves can be forgotten), and every POKéMON CENTER has a **MOVE
REMINDER** and a **MOVE TUTOR**. When a trainer calls for a rematch, you can **go
there right away**.

Catching follows **PalletToPewter's rule**: beat a wild Pokémon first, then throw
your BALLS at it before it gets away. The DUDE on ROUTE 29 shows you how, and gives
you the RATTATA he catches. PalletToPewter's **level caps**, **difficulties**
(NORMAL, HARD and EXTREME) and **boss Pokémon** are here too.

It is built from the [pret/pokecrystal][pokecrystal] disassembly. The rest of the
game is unchanged, and so is the save format, so saves from the original game
carry over.


## How to use it

1. In a battle, the menu shows **SELECT →AUTO** (and **START →INFO**, see [The battle
   info screen](#the-battle-info-screen)) next to FIGHT / PKMN / PACK / RUN.
2. Press **SELECT**. Your Pokémon attacks right away, and every following turn
   is automatic. The text box shows **AUTO BATTLE / SELECT to stop** for half a
   second at the start of each turn.
3. Press **SELECT** at any time to stop. The normal menu comes back at the start
   of the next turn.

While it's on, auto battle makes every choice in the battle: the moves, switching
Pokémon, which one to send in after one faints, and which move to forget when a
Pokémon learns a fifth (see [How it battles](#how-it-battles)). Catching is still
up to you, and B still stops an evolution. With auto battle off, the battle is
yours as usual.

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
  Learning moves, "Use next POKéMON?" and sending in the next Pokémon are decided
  for you too. After pressing SELECT, text waits for A or B again, and the choices
  are yours. Text outside of battle, like what a trainer says before and after, is
  unchanged.

The catching demonstration on Route 29 is never automatic. When auto battle beats a
wild Pokémon you've already caught, the battle just ends; one you haven't caught yet
still stops and asks whether to throw a BALL (see [Catching](#catching)). The setting
is saved with your game.


## How it battles

Every turn it weighs up the **matchup**: how many turns your Pokémon needs to knock
the foe out with its best attack, how many the foe needs with its own, and which of
the two moves first. Damage comes from the game's own formula (see
[Moves](#moves) below), with the foe's real moves, and counts each side's
chance to hit: a Pokémon whose accuracy SAND-ATTACK has ruined, or that faces a
foe that used DOUBLE TEAM, knows it's losing.

### Switching

When the Pokémon out is losing its matchup, auto battle looks for a party Pokémon
that would do better, and only switches to a **sound** one:

- it isn't weak to any of the foe's attacks. A single super-effective move rules it
  out: HITMONCHAN's THUNDERPUNCH doesn't make it an answer to a STARMIE that knows
  PSYCHIC, and a STARMIE with ICE BEAM and THUNDERBOLT leaves few answers at all.
- it can take the hit it switches in on, and two more of the foe's best attack.
- it wins the matchup, or does clearly better than the Pokémon out (by two turns or
  more). Speed isn't everything: a bulky SLOWKING that resists STARMIE's attacks is
  worth switching in even though STARMIE moves first.

If the Pokémon out can't hurt the foe at all, any sound Pokémon that can is worth
switching to. It never switches twice in a row, or when the Pokémon can't get away
(MEAN LOOK, SPIDER WEB, a trapping move). Switching uses up the turn, as usual.

### After a faint

"Use next POKéMON?" is a yes, and it sends in the party Pokémon with the best
matchup against the foe. If the trainer's Pokémon fainted too, so its next one isn't
known yet, it picks the one whose worst matchup against the trainer's remaining
Pokémon is best. The party screen shows for half a second, so you can see who's
coming.

### Learning moves

When a Pokémon with four moves learns another, auto battle keeps the best four of
the five, picked the way EXTREME's trainers get their movesets (power, the attack
stat the move uses, its own type, accuracy, and attacks of different types), and
never forgets an HM move. If the new move doesn't make the cut, it isn't learned.

### Moves

Each turn it rates every move that can be selected (it skips moves with no PP left
and Disabled moves) and uses the best one:

- **Damaging moves** are rated by the damage they should deal this turn. This uses
  the game's own damage formula: your stats and stat changes, the foe's
  Defense, STAB, type matchups, held items, weather, badges, Reflect and Light Screen.
  - It counts on the lowest of the game's random damage rolls, and damage beyond
    the foe's remaining HP counts for nothing. The result is then scaled by the
    chance to hit (the move's accuracy, your Pokémon's accuracy and the foe's
    evasion), so a sure knockout beats a stronger move that might miss.
  - If more than one move would knock the foe out, it prefers a priority move
    such as Quick Attack, so the foe doesn't get to attack first.
  - Multi-hit moves count every hit. Two-turn moves (Solar Beam outside of
    sunlight, Fly, Dig, Sky Attack, Skull Bash, Razor Wind) and Hyper Beam count half.
  - Fixed-damage moves (Seismic Toss, Night Shade, Dragon Rage, Sonic Boom, and
    Super Fang and the one-hit KO moves, which halve the foe's HP), Hidden Power,
    Rage, Flail, Reversal and Low Kick use their real damage. Magnitude, Psywave and
    Present use typical values. False Swipe counts as sure to hit (a miss swipes
    again).
- **Healing moves** (RECOVER, SOFTBOILED, MILK DRINK, REST, MORNING SUN, SYNTHESIS,
  MOONLIGHT) come first when the Pokémon is under half its HP (a third for REST) and
  the foe can't take that back in a turn, unless an attack knocks the foe out now.
- **Status and stat-raising moves**, against trainers only (wild battles are quicker
  without them), when the matchup calls for one: sleep when the fight will take three
  turns or more, paralysis against a faster foe, TOXIC in a long fight (not on POISON
  or STEEL Pokémon), and a stat boost that suits its best attack when the foe can
  barely hurt it. A status move is never used on a foe that already has a status, a
  SUBSTITUTE or SAFEGUARD, or a type it can't affect.
- **Moves that lower the foe's stats or raise its own guard**, against trainers only,
  when they're worth the turn they take: lowering the foe's accuracy (SAND-ATTACK,
  SMOKESCREEN) or ATTACK (GROWL, against physical attacks), or raising its own
  DEFENSE (DEFENSE CURL, HARDEN, against physical attacks), SP.DEF (AMNESIA, against
  special ones) or evasion (DOUBLE TEAM), when the Pokémon is losing the race to a
  knockout and that would turn it around; lowering the foe's DEFENSE (LEER, TAIL
  WHIP) when that saves a turn and still wins it. Never more than two stages.
- **Other status moves** (and Bide and Future Sight, whose damage can't be
  predicted) are only used when no damaging move can hurt the foe.
- **Self-Destruct and Explosion** are a last resort.
- **Moves that would fail** come last: moves the foe is immune to, Snore and Sleep
  Talk while awake, and Roar and Whirlwind in a wild battle (they'd end it).
- **Counter and Mirror Coat** are never chosen: they work by themselves (see
  [Reworked moves](#reworked-moves)).
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
- This covers every evolution that happens on level-up: by level (including the ones
  that used to need friendship: see [Simpler evolutions](#simpler-evolutions)) and
  Tyrogue's. Pokémon that level up from an Exp. Share evolve too.
- Moves learned on evolving (like Gyarados's Bite) can be used right away.


## Modern battles

### Physical, special and status

Whether an attack is physical or special depends on the move, as it does since
DIAMOND and PEARL, not on its type: FIRE PUNCH, CRUNCH and WATERFALL are physical,
SHADOW BALL, GUST and HIDDEN POWER special. The battle's move menu and the MOVES
screen of the party menu show each move's category: **PHYSICAL**, **SPECIAL** or
**STATUS**.

### The FAIRY type

The FAIRY type joins, with its matchups from the latest games: strong against
FIGHTING, DRAGON and DARK; weak to POISON and STEEL; DRAGON moves don't affect it.
The FAIRY Pokémon are the latest games' ones:

- FAIRY: CLEFFA, CLEFAIRY, CLEFABLE, TOGEPI, SNUBBULL, GRANBULL
- NORMAL/FAIRY: IGGLYBUFF, JIGGLYPUFF, WIGGLYTUFF
- FAIRY/FLYING: TOGETIC; WATER/FAIRY: MARILL, AZUMARILL; PSYCHIC/FAIRY: MR. MIME

CHARM, SWEET KISS and MOONLIGHT are FAIRY moves now, and there are three new ones:
DRAINING KISS (heals 3/4 of the damage it does), PLAY ROUGH and MOONBLAST, which
the FAIRY Pokémon learn by leveling up. The POLKADOT BOW (MARY gives it in the RADIO
TOWER) boosts FAIRY moves.

The rest of the type chart is today's too: GHOST and DARK moves hit STEEL Pokémon
normally. CURSE is a GHOST move, and STRUGGLE has no type.

### Moves

Every move has its power, accuracy and PP from the latest games (TACKLE is 40 power,
THUNDER 110, HYPNOSIS 60% accurate, …), and these work as they do now:

- **Priority**: PROTECT, DETECT and ENDURE (+4), EXTREMESPEED (+2), QUICK ATTACK,
  MACH PUNCH and BIDE (+1); VITAL THROW (−1), WHIRLWIND, ROAR and TELEPORT (−6).
- **Recoil**: DOUBLE-EDGE costs 1/3 of the damage it does, other recoil moves 1/4,
  STRUGGLE 1/4 of the user's max HP. A missed JUMP KICK or HI JUMP KICK costs half
  of the user's max HP.
- **Draining moves** heal half the damage they do; MORNING SUN, SYNTHESIS and
  MOONLIGHT heal 1/2 of the max HP, 2/3 in sunshine and 1/4 in rain or a sandstorm.
- SELF-DESTRUCT and EXPLOSION no longer halve the foe's Defense. FURY CUTTER stops
  growing at 160 power. SKY ATTACK is likely to land a critical hit. RAPID SPIN
  raises the user's Speed. (LOW KICK: see [Reworked moves](#reworked-moves).)
- New added effects: ACID lowers Special Defense, CRUNCH lowers Defense, and
  WATERFALL can make the foe flinch.
- **Status**: a burn takes 1/16 of the max HP a turn, paralysis halves Speed, a
  frozen Pokémon thaws out 20% of the time, sleep lasts one to three turns, and a
  confused Pokémon hurts itself a third of the time.
- WRAP, BIND, FIRE SPIN, CLAMP and WHIRLPOOL last four or five turns and take 1/8 of
  the max HP a turn. DISABLE lasts four turns, ENCORE three, SPITE takes 4 PP, and
  PROTECT, DETECT and ENDURE are a third as likely to work each time in a row.
- HIDDEN POWER is a special move with 60 power.
- **Weather** favors some types, besides the rain's WATER and the sun's FIRE moves
  (1.5×): in a sandstorm, GROUND, ROCK and STEEL moves do 1.5× damage too, and
  GROUND, ROCK and STEEL Pokémon (which the sandstorm doesn't hurt) have their Speed
  and their Special Defense one stage up (1.5× each; the Special Defense against
  special attacks, critical hits too); WATER Pokémon in the rain and GRASS Pokémon
  in the sun have their Speed one stage up (1.5×). These aren't stat changes: they last as long as the weather. The
  battle info screen's field page says whose stat is up.
- **TRANSFORM** works like the latest games' IMPOSTER: a Pokémon that knows it turns
  into the foe as soon as it comes in, before anything else happens (it takes no
  turn and no PP). A wild DITTO turns into your Pokémon right away. It doesn't when
  the foe has transformed too, or is out of sight (FLY, DIG).

### Reworked moves

Some moves work in new ways of their own:

| Move | What it does |
|---|---|
| DOUBLESLAP, COMET PUNCH, FURY ATTACK, PIN MISSILE, SPIKE CANNON, BARRAGE, FURY SWIPES, BONE RUSH | 25 power, 2 to 5 hits |
| BEAT UP | one of them now: 25 power, 2 to 5 hits |
| DREAM EATER | works on a foe that's awake too |
| SUNNY DAY, RAIN DANCE, SANDSTORM, FORESIGHT, FUTURE SIGHT, SPIKES, SAFEGUARD, PSYCH UP, MEAN LOOK, SPIDER WEB, LOCK-ON | used as the Pokémon comes in, like TRANSFORM (see below) |
| PURSUIT | 15 power; hits a foe switching out by itself (see below) |
| FALSE SWIPE | 60 power, 90% accurate; a miss swipes again, for double the damage (not when the foe is protected, out of reach or immune). It no longer leaves the foe 1 HP |
| RAGE | as RAGE FIST: 50 power, and 50 more for every time the user was hit this battle (up to 250) |
| CONSTRICT | always lowers SPEED |
| GUILLOTINE, HORN DRILL, FISSURE | as RUINATION: they halve the foe's HP, 90% accurate |
| PSYWAVE | its power varies as MAGNITUDE's does ("Psywave 8!") |
| RETURN, FRUSTRATION | 102 power, whatever the Pokémon's friendship |
| COUNTER, MIRROR COAT | work by themselves, once each time the Pokémon is out (see below) |
| WHIRLWIND, ROAR | 60-power special attacks, then the foe is driven off (in the wild, the battle ends) |
| PAY DAY | while a Pokémon in your party (not an EGG) knows it, a battle's money is doubled: a trainer's prize and PAY DAY's coins (with an AMULET COIN as well, 4×) |
| RAZOR WIND | no turn to charge: it hits right away (still with a high critical-hit ratio) |
| SKULL BASH | no turn to charge: the user's DEFENSE goes up a stage, then it attacks |
| SOLARBEAM | no turn to charge; 1.5× damage in the sun, 0.5× in rain and sandstorms |
| SKY ATTACK | no turn to charge; instead, as HYPER BEAM, a turn to recharge after (still with a high critical-hit ratio and a 30% chance to flinch) |
| HYPER BEAM, SKY ATTACK | as in the first games: no turn to recharge after knocking the foe out or breaking its SUBSTITUTE (nor after a miss) |
| MIRROR MOVE | works by itself, like COUNTER: right after the foe uses a move, the Pokémon uses that move too (see below) |
| SPIKES | used as the Pokémon comes in too; as in the latest games, up to three layers: a Pokémon coming in on that side (not a FLYING type) loses 1/8, 1/6 or 1/4 of its max HP |
| FLAIL, REVERSAL | 60 power; twice that when the user moves after the foe that turn (or the foe switched out) |
| BIND, WRAP, FIRE SPIN, CLAMP, WHIRLPOOL | as MAGMA STORM: 100 power, 75% accurate (and they still trap the foe) |
| DOUBLE KICK, BONEMERANG, TWINEEDLE | 50 power, for each of the two hits |
| LOW KICK | as in the first games (50 power, 90% accurate, 30% to flinch), and twice the power when the target's DEFENSE is higher than the user's ATTACK |
| ATTRACT | works whatever the genders |
| SNORE | works by itself: at the end of each of its turns while it's asleep, the Pokémon SNOREs (1 PP); it can't be chosen |
| SONICBOOM, SEISMIC TOSS, DRAGON RAGE, NIGHT SHADE | fixed damage, whatever the levels and stats, rolled as MAGNITUDE's power is: 20 (5%), 35 (10%), 50 (20%), 60 (30%), 70 (20%), 85 (10%) or 100 (5%). SONICBOOM is an ELECTRIC move now |
| TRIPLE KICK | as TRIPLE AXEL: up to three kicks, of 20, 40 and 60 power, each one 90% accurate on its own; the first that misses ends it |
| SPITE | works by itself: right after the foe uses a move, it loses 4 PP; once for each of the foe's moves (see below) |
| NIGHTMARE | works by itself: a sleeping foe gets one (see below) |
| SPLASH | a 20-power special WATER attack that works by itself, at the end of each of the Pokémon's turns (see below) |
| CONVERSION, CONVERSION 2 | work by themselves, as in PokeSquad Battler: just before an attack's damage, the Pokémon becomes a type that resists it (CONVERSION 2: one it doesn't affect) (see below) |
| SKETCH | copies the foe's move you choose, from a menu of its moves (see below) |
| MEAN LOOK, SPIDER WEB | they can't be chosen: used only as the Pokémon comes in |
| AMNESIA | as in the first games: SPCL.ATK and SPCL.DEF, 2 stages each; once while it's out (see below) |
| GROWTH | ATTACK and SPCL.ATK, 2 stages each; once while it's out |
| SWORDS DANCE | once while it's out |
| TELEPORT | as in the latest games: moves last, and in a trainer battle, the Pokémon switches out (in the wild, it still flees) (see below) |

**Entry moves.** A Pokémon that knows SUNNY DAY, RAIN DANCE, SANDSTORM, FORESIGHT,
FUTURE SIGHT, SPIKES, SAFEGUARD, PSYCH UP, MEAN LOOK, SPIDER WEB or LOCK-ON uses each
of them as it comes in,
at the start of its first turn out, before anything else happens. Each takes 1 PP
(none is used without PP left), and it doesn't count as the Pokémon's move (QUICK
CLAW and KING'S ROCK still wait for that). LOCK-ON goes last, so its aim is for the
next attack. None is used when it would do nothing: FUTURE SIGHT while one is on its
way, SPIKES with three layers down, SAFEGUARD while it's up, PSYCH UP when none of the
foe's stats have gone up, MEAN LOOK and SPIDER WEB when the foe's trapped already. They
can still be chosen as usual too, but FUTURE SIGHT, SAFEGUARD, MEAN LOOK and SPIDER
WEB: like COUNTER and MIRROR COAT, they work only by themselves ("FUTURE SIGHT works by
itself!"), and auto battle and the other side never choose them.

**PURSUIT.** When a foe switches out, a Pokémon that knows PURSUIT hits it by itself
on its way out, for double damage (1 PP), unless it's asleep or frozen. Then it still
does what it chose (if it chose PURSUIT, that was it).

**COUNTER and MIRROR COAT.** Right after a physical attack hits a Pokémon that knows
COUNTER (a special one, MIRROR COAT), it hits back by itself for twice the damage
(1 PP), unless it fainted, is asleep or frozen, or the attacker is immune. Each one
hits back once while the Pokémon is out, and again only after it has gone back and
come out again (or another one has come in by BATON PASS). They can't be chosen
("COUNTER works by itself!"); a Pokémon with nothing else left to choose STRUGGLEs.
A Pokémon can know both, and attacks too.

**MIRROR MOVE.** Right after the foe uses a move (not when it slept, flinched or
couldn't move), a Pokémon that knows MIRROR MOVE uses that same move back by itself
(1 PP of MIRROR MOVE's), once each time it's out, unless it's asleep, frozen or busy
with a move of its own. It doesn't take up moves that go on for turns (FLY, DIG,
ROLLOUT, THRASH, BIDE), call another (METRONOME, SLEEP TALK) or work by themselves.
Like COUNTER, it can't be chosen.

**SPITE.** Right after the foe uses a move, a Pokémon that knows SPITE takes 4 PP from
that move by itself (1 PP of SPITE's), unless it's asleep or frozen or the move has no
PP left: once for each of the foe's moves, while both are out. So when the foe uses
TACKLE, TACKLE loses 4 PP; the next TACKLE loses none, but the foe's first GROWL loses
4 too. When either side switches, it starts over.

**NIGHTMARE.** At the end of each turn, while the foe is asleep, a Pokémon that knows
NIGHTMARE gives it one by itself (1 PP), unless it's asleep or frozen itself, or the
foe has one already, is behind a SUBSTITUTE or out of sight (FLY, DIG).

**SNORE and SPLASH.** At the end of each of its turns, a Pokémon that knows SNORE
SNOREs by itself while it's asleep, and one that knows SPLASH SPLASHes while it's awake
(not frozen, nor out of sight): SPLASH is a 20-power special WATER attack now. Each
takes 1 PP. (A Pokémon with nothing left to choose, as a young MAGIKARP that only knows
SPLASH, STRUGGLEs, then SPLASHes.)

**CONVERSION and CONVERSION 2** work as in PokeSquad Battler. Just before an attack's
damage (not STRUGGLE's), a Pokémon that knows CONVERSION becomes a type that resists
the attack, picked at random, if it doesn't resist it already; with CONVERSION 2, it
becomes a type the attack doesn't affect, if there is one (else, one that resists it).
With both, CONVERSION 2 goes when there's a type the attack doesn't affect, else
CONVERSION first. Each takes 1 PP, not when the Pokémon is out of sight or protected;
the type lasts until it's switched out.

**SKETCH.** Your Pokémon's SKETCH asks which of the foe's moves to copy, from a menu of
them (not one it knows already, nor SKETCH or STRUGGLE); a foe's SKETCH takes your
Pokémon's move with the most power. As before, the move takes SKETCH's place for good.

**Once while out.** SWORDS DANCE, GROWTH and AMNESIA can each be used once while the
Pokémon is out; then it can't choose it ("GROWTH works once while out!") until it has
gone back and come out again. AMNESIA raises SPCL.ATK and SPCL.DEF by 2 stages each, as
the first games' SPECIAL; GROWTH, ATTACK and SPCL.ATK by 2 each.

**TELEPORT.** As in the latest games, it moves after everything else, and in a trainer
battle the Pokémon switches out (yours: you choose who comes in, or auto battle does),
even when it's trapped; the one coming in starts afresh, with nothing passed on, as
with any switch. In the wild, it flees the battle as before.

### The battle info screen

In a battle, press **START** to see how things stand, and **START** again (or B) to
go back. The first page shows both Pokémon's stat changes: each stat (ATTACK,
DEFENSE, SPEED, SPCL.ATK, SPCL.DEF, ACCURACY, EVASION), yours and the foe's, as how
many stages up (+2) or down (-1), or 0 as it was. **LEFT** or **RIGHT** turns to the
field: the weather, and on each side REFLECT, LIGHT SCREEN, SAFEGUARD, MIST, SPIKES
(how many layers), a FUTURE SIGHT on its way and PERISH SONG, with the turns each has
left. (The Game Boy Color has no L or R buttons, so START it is.)

It opens whenever the battle waits: at the battle menu or the move menu, at any text
waiting for A or B, and between auto battle's turns and texts (START pressed during
an attack opens it as soon as that's done). The battle waits while it's up. Not
while the Demo plays, where START stops the Demo.

### Critical hits

Critical hits work as they do in the latest games. They do 1.5× damage (not 2×), and
ignore the attacker's lowered Attack or Special Attack, the defender's raised
Defense or Special Defense, and REFLECT and LIGHT SCREEN. How likely one is goes by
stages:

| Stage | Chance |
|---|---|
| 0 | 1 in 24 |
| +1 | 1 in 8 |
| +2 | 1 in 2 |
| +3 and up | every hit |

- FOCUS ENERGY (and DIRE HIT): +2
- moves that are likely to land one (KARATE CHOP, RAZOR WIND, RAZOR LEAF,
  CRABHAMMER, SLASH, AEROBLAST, CROSS CHOP, SKY ATTACK): +1
- SCOPE LENS: +2
- STICK and LUCKY PUNCH: +1, and every hit for FARFETCH'D holding a STICK, and for
  CHANSEY or BLISSEY holding a LUCKY PUNCH

### No items in battle

As in PalletToPewter, nobody uses items in battle, on any difficulty: the PACK says
"No items can be used in battle!", and trainers don't use theirs either. (BALLS
still have their own menu once a wild Pokémon is beaten, see
[Catching](#catching), and the BUG-CATCHING CONTEST's PARK BALLS work as usual.)

Instead, the **X items are held**, like BOOSTER ENERGY in the latest games. Give one
to a Pokémon, and it's used up when that Pokémon comes into battle (for that battle:
see below):

| Item | When the holder comes in |
|---|---|
| X ATTACK | Attack +1 |
| X DEFEND | Defense +1 |
| X SPEED | Speed +1 |
| X SPECIAL | Special Attack +1 |
| X ACCURACY | accuracy +1 |
| DIRE HIT | it's getting pumped (FOCUS ENERGY) |
| GUARD SPEC. | it's shrouded in MIST |

They're sold on the 3rd floor of the GOLDENROD DEPT. STORE (VIOLET CITY's mart has
X ATTACK, X DEFEND and X SPEED), and trainers' Pokémon hold them too (see
[Difficulty](#difficulty)). A team holds only one of each (see below).

### Held items

These held items work in new ways:

| Item | What it does |
|---|---|
| QUICK CLAW | the first move its holder uses after it comes in (an attack or not) has +1 priority |
| KING'S ROCK | the first attack its holder uses after it comes in makes the foe flinch, if it hits before the foe has moved |
| FOCUS BAND | once a battle, the first time its holder would faint from an attack, it hangs on with 1 HP |
| SCOPE LENS | +2 critical hit stages (see [Critical hits](#critical-hits)) |
| STICK, LUCKY PUNCH | +1 critical hit stage; every hit for FARFETCH'D (STICK), CHANSEY and BLISSEY (LUCKY PUNCH) |
| CHARCOAL, MYSTIC WATER and the other type boosters | moves of their type do 1.5× damage (instead of 1.1×) |

**One to a team.** A team, yours or a trainer's, holds only one of each of these:
the X items (X ATTACK, X DEFEND, X SPEED, X SPECIAL, X ACCURACY, DIRE HIT and
GUARD SPEC.), BERSERK GENE, FOCUS BAND, KING'S ROCK and QUICK CLAW. You can't GIVE
one to a Pokémon while another on your team holds one ("QUICK CLAW: only one per
team!"), and if two hold one anyway (a Pokémon you caught or traded for, say), only
the first in your party counts in battle. Different ones are fine: an X ATTACK, an
X DEFEND and a QUICK CLAW on the same team all work.

### Held items come back

A held item used up in battle is back once the battle is over: a berry, an X item,
DIRE HIT, GUARD SPEC. So is one a foe's THIEF took. An item your own Pokémon took
with THIEF, it keeps.

### No SHIFT

The SHIFT battle style is gone: when a trainer is about to send out its next
Pokémon, you're never asked whether to switch. BATTLE STYLE in the OPTION menu is
always SET.

### Every Pokémon obeys

Pokémon never disobey: a traded Pokémon does what you (or auto battle) tell it,
whatever its level and whatever badges you have. In the original game, one above
the level your badges allow could loaf around, nap, hurt itself or use another of
its moves instead.


## Natures

Every Pokémon has a **nature**, as in the latest games: it raises one stat by 10%
and lowers another by 10% (HARDY, DOCILE, SERIOUS, BASHFUL and QUIRKY change
nothing). The nature comes from the Pokémon's DVs, so every Pokémon already has
one, those in your old saves too, and keeps it for good. Perfect DVs make a HARDY
Pokémon, so EXTREME's trainers and the bosses aren't held back by theirs.

The stats screen has a fourth page, in orange: the Pokémon's nature, the stats it
raises and lowers, and its DVs (HP, ATTACK, DEFENSE, SPEED and SPECIAL, 0 to 15;
the HP DV comes from the other four).

A game saved before there were natures gets its party's stats updated the first
time you CONTINUE. Pokémon in the PC or the DAY-CARE get theirs when you take them
out, as they always have.


## Simpler evolutions

As in PalletToPewter, no Pokémon needs trading or friendship to evolve:

- **Trade evolutions** use an item instead, from the PACK like an evolution stone:
  the **LINKING CORD** evolves KADABRA, MACHOKE, GRAVELER and HAUNTER; the items they
  used to hold while traded do the rest (KING'S ROCK for POLIWHIRL and SLOWPOKE,
  METAL COAT for ONIX and SCYTHER, DRAGON SCALE for SEADRA, UP-GRADE for PORYGON).
- **Friendship evolutions** go by level: PICHU, CLEFFA and IGGLYBUFF at Lv 12,
  TOGEPI at Lv 20, GOLBAT at Lv 35 and CHANSEY at Lv 40.
- **EEVEE** evolves into ESPEON with a SUN STONE, and into UMBREON with a MOON STONE.

The GOLDENROD DEPT. STORE sells them all: KING'S ROCK, METAL COAT, DRAGON SCALE and
UP-GRADE on the 3rd floor, and the LINKING CORD and six evolution stones (FIRE,
WATER, THUNDER, LEAF, MOON and SUN) on the 4th. So does the CELADON DEPT. STORE, on
its 5th floor: the stones and the LINKING CORD from the clerk with the vitamins, the
other four from the one with the X items.


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
  stands at its strongest Pokémon's level (so do the ELITE FOUR's, LANCE's and RED's),
  and its strongest Pokémon holds an item.
- **HARD**: every trainer's Pokémon are at least at the level cap, and the leaders'
  whole teams at least two levels above it. They're as evolved as their level allows:
  level evolutions at their level, stone evolutions from Lv 20, and the ones that were
  trade evolutions from Lv 34, each trainer going its own way where a line branches.
  Every leader's Pokémon holds an item, and every other trainer's strongest one does.
- **EXTREME**: as HARD, and you get the **ENDLESSCANDY**, a RARE CANDY that never
  runs out, right up to the level cap (use it and you stay on the party screen,
  for another, until you press B). But every trainer brings **six Pokémon**
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
  - **a held item** (see below).
  - **smarter battling**: the AI uses every one of its tricks.

  Boss Pokémon and their allies get their best movesets, perfect DVs and held items
  too (the red GYARADOS stays red).

A trainer's Pokémon that holds an item gets the one that suits it best, and no two
on a team are the same: the X ATTACK or X SPECIAL for its best attack (so it comes
in with +1), else the item that boosts that attack's type (CHARCOAL, MYSTIC WATER,
…), else LEFTOVERS, X SPEED, X DEFEND, DIRE HIT, QUICK CLAW, KING'S ROCK, SCOPE LENS,
BRIGHTPOWDER, a berry, FOCUS BAND, X ACCURACY or GUARD SPEC.


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


## TMs and HMs

As in PalletToPewter:

- **TMs never run out.** Teach a TM's move to as many Pokémon as you like.
- **HMs work without the move.** With an HM in your PACK (and the badge it needs),
  your team can use its field move though no Pokémon knows it: walk up to a tree to
  CUT it, to the water to SURF, to a boulder for STRENGTH, and so on. FLY and FLASH
  show in your Pokémon's menu. ROCK SMASH and HEADBUTT work the same way with their
  TMs.
- **HM moves can be forgotten** like any other move, to make room for a new one.


## The MOVE REMINDER and the MOVE TUTOR

Every POKéMON CENTER has two more people, by the left wall of the lobby (at the
INDIGO PLATEAU, by the right wall). Both are free:

- The **MOVE REMINDER** (the old woman) teaches a Pokémon any move it learns by
  leveling up, up to its level, that it doesn't know.
- The **MOVE TUTOR** (the old man) teaches a Pokémon its EGG moves (those of its first
  form), and whichever of the moves GOLDENROD's tutor teaches it can learn
  (FLAMETHROWER, THUNDERBOLT and ICE BEAM).

Pick a Pokémon, then the move from the list (each with its type; the box below it
shows the move's category, PP, power and accuracy). A Pokémon that already knows
four moves forgets one to learn it.


## Going to a rematch

When a trainer on your POKéGEAR calls to ask for a rematch, the game asks, once the
call is over, whether to go there now. Say **YES** and the screen fades to black as
you set off, then fades back in with a chime as you arrive, on the spot in front of
the trainer, facing them. You arrive on foot, even if you were surfing or on the
BICYCLE, and going ends the Bug-Catching Contest, as flying away would.


## Playing it

You need your own Pokémon Crystal (USA/Europe) **Rev 1** ROM
(`sha1: f2f52230b536214ef7c9924f483392993e226cfb`). Apply one of these patches to it
with a patcher such as [Rom Patcher JS][rompatcher] or Floating IPS:

- [`patches/pokecrystal11_auto_battle.bps`](patches/pokecrystal11_auto_battle.bps)
  (checks that the ROM is the right one)
- [`patches/pokecrystal11_auto_battle.ips`](patches/pokecrystal11_auto_battle.ips)

The patched ROM has `sha1: 8c580a9c8b00f27fbcb0bd2b352df9c000772a09`.

A save from an earlier version keeps working: copy it to the new ROM's name (the
`.sav` beside it). On CONTINUE, its moves are taken over as they were (see
[More than 255 moves](#more-than-255-moves)).


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
- Auto battle's matchups are `AutoBattle_ScoreMatchup` (both sides' turns to a
  knockout, from `AutoBattle_BestDamage`'s damage estimate). Each turn
  `AutoBattle_ShouldSwitch` may pick a switch (`AutoBattle_BestSwitch`,
  `AutoBattle_SoundSwitchIn`), which `BattleMenuPKMN_Loop` carries out through the
  game's own `TryPlayerSwitch`; `PickPartyMonInBattle` and `AskUseNextPokemon` ask
  `AutoBattle_ChooseSendOut` after a faint; and `ForgetMove` in
  [`engine/pokemon/learn.asm`](engine/pokemon/learn.asm) asks
  `AutoLearn_ForgetChoice` (in `extreme_trainers.asm`, with EXTREME's move picking).
  Its working bytes (`wAB*`) are in battle RAM.
- A move's category is kept in the top two bits of its type byte (`PHYSICAL`,
  `SPECIAL`, `STATUS`; `TYPE_MASK` keeps the type), so
  [`data/moves/moves.asm`](data/moves/moves.asm) keeps its layout; the `move` macro
  takes the category after the type. The damage code chooses the stats by it, and
  [`engine/pokemon/categories.asm`](engine/pokemon/categories.asm) names it for the
  menus. `FAIRY` is a new type after `DARK`.
- The moves' data and [`data/types/type_matchups.asm`](data/types/type_matchups.asm)
  follow the latest games; DRAINING KISS, PLAY ROUGH and MOONBLAST take the three
  move IDs after BEAT UP. [`data/moves/priorities.asm`](data/moves/priorities.asm)
  lists each move's priority. The new effects are in
  [`engine/battle/effect_commands.asm`](engine/battle/effect_commands.asm), the
  [`engine/battle/move_effects`](engine/battle/move_effects) files and, where they
  needed more room, [`engine/battle/modern_moves.asm`](engine/battle/modern_moves.asm)
  (recoil, LOW KICK, draining and weather healing).
- Held X items have the new held effect `HELD_ENTRY_BOOST` (with an `ENTRY_*`
  parameter) in [`data/items/attributes.asm`](data/items/attributes.asm);
  `HandleHeldEntryItems` (in `modern_moves.asm`) uses them up at the start of the
  turn, after `HandleBerserkGene`. `GiveTrainerHeldItem` gives trainers' Pokémon
  theirs, and `CheckWhetherToAskSwitch` no longer offers SHIFT.
  `SaveBattleHeldItems` remembers what the party holds as a battle starts
  (`wBattleHeldItems`, in battle RAM), and `RestoreBattleHeldItems`, at the start
  of `ExitBattle`, gives back what's gone.
- `GetUserItem` and `GetOpponentItem` ask `CheckHeldItemLimit` (in
  `modern_moves.asm`; `LimitedHeldItems` lists the one-to-a-team items) whether a
  teammate earlier in the party held the same one going in, and if so return no
  effect. `CheckTeamHoldsLimitedItem` stops a GIVE (`TryGiveItemToPartymon`).
  QUICK CLAW is in `CompareMovePriority` (while `wPlayerTurnsTaken` or
  `wEnemyTurnsTaken`, which count the moves used since coming in, is 0); KING'S
  ROCK is `MarkFirstAttack` (from `BattleCommand_DoTurn`) and `HeldKingsRock`
  (from `BattleCommand_ApplyDamage`, where FOCUS BAND is too), with
  `wPlayerHeldFlags` and `wEnemyHeldFlags` in battle RAM. `HandleEntryTransform`
  runs at the start of the turn, before `HandleBerserkGene`.
- Critical hits: `BattleCommand_Critical` counts the stages
  ([`data/battle/critical_hit_chances.asm`](data/battle/critical_hit_chances.asm)),
  `ModernCriticalStats` picks the stats a critical hit uses, and
  `.CriticalMultiplier` makes it 1.5×.
- `BattleCommand_CheckObedience` does nothing, so every Pokémon obeys (and
  `wAlreadyDisobeyed` stays 0).
- Reworked moves: `AutoMove_Setup` and `AutoMove_Run` (in
  [`engine/battle/effect_commands.asm`](engine/battle/effect_commands.asm)) use a move by
  itself, outside its user's turn: its effect script (`DoMoveScript` runs another),
  its PP (`BattleCommand_DoTurn` with `wAutoMove`), but not as its turn. They serve
  `HandleEntryMoves` (from `HandleEntryTransform`, once per Pokémon out:
  `FIELD_ENTRY_DONE_F` in `wPlayerFieldFlags`, `wEnemyFieldFlags`), `AutoPursuit`
  (from `PursuitSwitch`) and
  `HandleAutoCounter` (after each move, from `DoPlayerTurnAndCounter` and
  `DoEnemyTurnAndCounter`, with the damage `CountHitTaken` keeps in `wHitDamage` from
  `BattleCommand_ApplyDamage`; once each per Pokémon out: `FIELD_COUNTER_F` and
  `FIELD_MIRROR_COAT_F`).
  `CountHitTaken` also counts each Pokémon's hits (`wPlayerTimesHit`,
  `wEnemyTimesHit`) for RAGE (`GetRagePower`, the `ragepower` command). FALSE SWIPE's
  miss is the `swipeagain` command (`FalseSwipeAgain`). PAY DAY's doubling is
  `PartyKnowsPayDay` (asked by `WinTrainerBattle` and `CheckPayDay`). All of these
  are in [`engine/battle/modern_moves.asm`](engine/battle/modern_moves.asm).
  RAZOR WIND is a plain hit (`EFFECT_NORMAL_HIT`); the `SkullBash`, `Solarbeam` and
  `SkyAttack` scripts no longer `charge` (SKULL BASH's DEFENSE is the
  `defenseupfirst` command; SOLARBEAM's weather is in `WeatherMoveModifiers`). The
  weather's stats are `WeatherBoosts`: its Speed is `WeatherSpeed`, for the turn
  order (`CompareSpeeds`, from `DetermineMoveOrder`), the AI (`AICompareSpeed`) and
  auto battle; its SPCL.DEF is `WeatherSpclDef`, in `PlayerAttackDamage` and
  `EnemyAttackDamage`.
  `BattleCommand_RechargeNextTurn` skips the recharge after a KO or a broken
  SUBSTITUTE. MIRROR MOVE is `HandleAutoMirrorMove`: the turn's side gets a
  `NOT_ACTED` last move first (`AfterTurn`), so it's only taken up when one was used.
  SPIKES' layers are `wPlayerSpikes` and `wEnemySpikes` (`SpikesFraction` for the
  damage). FLAIL and REVERSAL's power is the `movedlast` command (`MovedLastPower`,
  with `wTurnActed`). TRIPLE KICK aims each kick after the first with
  `BattleCommand_CheckHit` (in `BattleCommand_EndLoop`), and LOW KICK's power is
  `GetLowKickPower`. The fixed damage of SONICBOOM and the like is
  rolled from `FixedDamageRolls` (auto battle counts on `TYPICAL_FIXED_DAMAGE`). After
  each side's turn (`AfterTurn`): SPITE is `HandleAutoSpite` (the foe's moves it has
  had: `wPlayerSpited`, `wEnemySpited`), NIGHTMARE `HandleAutoNightmare`, and SNORE and
  SPLASH `HandleAutoEndOfTurn` (none of them once either has fainted or the battle is
  over: `CantGoOn`). CONVERSION and CONVERSION 2 are `HandleAutoConversion`, from the
  `stab` and `resettypematchup` commands (`BattleCommand_StabAndConvert`,
  `BattleCommand_ResetTypeMatchupAndConvert`: not the AI's and auto battle's damage
  guesses, which call `BattleCommand_Stab` themselves); its PP is `SpendPP`. SKETCH's
  move is `ChooseSketchMove` (the player's menu is `MoveSelectionScreen` with
  `wMoveSelectionMenuType` 1, the foe's moves). GROWTH's and AMNESIA's second stat is
  the `secondstatup` command; SWORDS DANCE, GROWTH and AMNESIA set their field flag as
  they're used (`OnceOutMoves`, in `MarkFirstAttack`). TELEPORT goes on to
  `BattleCommand_BatonPass` in a trainer battle (`TeleportSwitch` resets what comes in).
  The battle info screen is
  [`engine/battle/battle_info.asm`](engine/battle/battle_info.asm) (`BattleInfoScreen`,
  with a `+` added to the font: `$e4` in [`gfx/font/font.png`](gfx/font/font.png));
  `BattleInfoButton` opens it on START (`hJoypadSum`, reset as the battle starts in
  `InitAutoBattle`), from the text waits (`PromptButton`, `WaitPressAorB_BlinkCursor`),
  auto battle's waits, and the 2D menus' (`Menu_WasButtonPressed`) while
  `wBattleInfoOK` says it's the battle menu or the move menu.
  `CheckPlayerHasUsableMoves`, the move menu, `ParseEnemyAction`, `AIChooseMove` and
  auto battle don't choose the moves that work by themselves (`AutoMoves`), nor those
  used once while out (`CantChooseMove`).
- `ConsumeTM` in [`engine/items/tmhm.asm`](engine/items/tmhm.asm) no longer uses up
  a TM. `CheckPartyMove` in [`engine/events/overworld.asm`](engine/events/overworld.asm),
  which every field move asks, falls back on `FieldMoveItems` (each field move's HM
  or TM) when no Pokémon knows the move, and
  [`engine/pokemon/mon_submenu.asm`](engine/pokemon/mon_submenu.asm) adds FLY and
  FLASH to the menu (`GetMonSubmenuItems.OwnedFieldMove`). `ForgetMove` in
  [`engine/pokemon/learn.asm`](engine/pokemon/learn.asm) no longer keeps HM moves.
- [`engine/events/move_relearner.asm`](engine/events/move_relearner.asm) has the
  MOVE REMINDER and MOVE TUTOR (`MoveReminderScript` and `MoveTutorScript`, standard
  scripts every POKéMON CENTER's map uses; the specials `MoveReminder` and
  `PokecenterMoveTutor`). They list the moves in `wMoveRelearnerMoves` (in the
  POKéDEX's RAM, which nothing else uses then), show them in a scrolling menu, and
  teach them with the game's own `LearnMove`.
- [`engine/phone/phone_trip.asm`](engine/phone/phone_trip.asm) has the trip.
  `PhoneScript_WantsToBattle_Male` and `_Female` mark the call (`MarkPhoneTrip`, a
  spare bit of `wCurCaller`), and `Script_ReceivePhoneCall` ends with
  `PhoneScript_OfferTrip`, which asks, fades out, and warps with a new map setup,
  `MAPSETUP_PHONE_TRIP`. That loads the map with the LCD on
  ([`engine/overworld/load_map_lcd_on.asm`](engine/overworld/load_map_lcd_on.asm):
  the screen turns white while the LCD is off, so it copies to VRAM by HBlank DMA
  while every palette is black) and fades in (`PhoneTripArrives`). The destinations
  are in [`data/phone/trip_destinations.asm`](data/phone/trip_destinations.asm),
  made by [`tools/phone_trips.py`](tools/phone_trips.py) from each contact's phone
  script and map: the cell in front of the trainer, or beside them where that one
  can't be stood on.
- [`engine/pokemon/natures.asm`](engine/pokemon/natures.asm) has `GetNature` (the
  DVs as a 16-bit number, + 15, mod 25), `ApplyNature`, which `CalcMonStatC` calls
  for every stat it works out, and `ApplyNaturesToOldSave`, run once on CONTINUE
  (`EVENT_NATURES_IN_STATS`, a formerly unused event flag). The stats screen's new
  page is `LoadOrangePage` in
  [`engine/pokemon/stats_screen.asm`](engine/pokemon/stats_screen.asm)
  (`ORANGE_PAGE`; the page number now takes three bits of `wStatsScreenFlags`).
- The new evolutions are in
  [`data/pokemon/evos_attacks.asm`](data/pokemon/evos_attacks.asm) (`EVOLVE_ITEM`
  and `EVOLVE_LEVEL`), and the LINKING CORD is item `$19`, formerly unused.


### More than 255 moves

Moves have 16-bit indexes, as in [pokecrystal16][pokecrystal16] (by ax6; the
version kept up at [vulcandth/pokecrystal16][pokecrystal16-vulcandth]), whose
table code this uses. The constants in
[`constants/move_constants.asm`](constants/move_constants.asm) are the indexes, and
the moves' data, names, descriptions and animations, learnsets, egg moves, trainer
parties and move lists are tables of them (`dw`). Memory and saves still keep one
byte per move: an ID that stands for an index in `wMoveIndexTable`
([`engine/16/move_table.asm`](engine/16/move_table.asm)).

- A move gets an ID the first time the game needs one (`GetMoveIDFromIndex`). When
  all 254 are taken, the ones nothing holds any more are taken back: `MoveIDPlaces`
  lists every place a move is kept (the party, the battle, the game's save, the box
  out...).
- The table is saved in SRAM (`sMoveIndexTable`, in bank 0) and written
  there as IDs are given, so the save and the box out always match it.
- The other boxes keep the moves' indexes instead, the low byte where the move is
  and the high bits in its PP, which comes back full when the box is loaded
  (`BillsPC_ConvertBoxData`, called by `SaveBox` and `LoadBox`).
- Code never compares a move with its constant: `cpmove`, `ldmove`, `ld_anim`
  ([`macros/code.asm`](macros/code.asm)), `IsMove`, `CheckMoveInList` and
  `GetMoveAttribute` ([`home/moves.asm`](home/moves.asm)) work with the indexes.
  [`tools/check_move_ids.py`](tools/check_move_ids.py) lists any use of a move's
  constant as an 8-bit ID.
- Battle animations go by the move's index (`wFXAnimID`); the ones that aren't a
  move's (`ANIM_HIT_CONFUSION`...) are negative, their table before
  `BattleAnimations`.
- A save from before (no table in SRAM) starts with each ID standing for the index
  it was, and its boxes are given the new format (`InitMoveTable`).
- A link battle or trade sends a move's index if it is below 256 (a Gold, Silver or
  Crystal game knows only those), and none for the others.


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
[pokecrystal16]: https://github.com/aaaaaa123456789/pokecrystal16
[pokecrystal16-vulcandth]: https://github.com/vulcandth/pokecrystal16
[pret]: https://pret.github.io/
[rompatcher]: https://www.marcrobledo.com/RomPatcher.js/
[docs]: https://pret.github.io/pokecrystal/
[wiki]: https://github.com/pret/pokecrystal/wiki
[tutorials]: https://github.com/pret/pokecrystal/wiki/Tutorials
[symbols]: https://github.com/pret/pokecrystal/tree/symbols
[tools]: https://github.com/pret/gb-asm-tools
