SECTION "Evolutions and Attacks", ROMX

; Evos+attacks data structure:
; - Evolution methods:
;    * dbbw EVOLVE_LEVEL, level, species
;    * dbbw EVOLVE_ITEM, used item, species
;    * dbbw EVOLVE_TRADE, held item (or -1 for none), species
;    * dbbw EVOLVE_HAPPINESS, TR_* constant (ANYTIME, MORNDAY, NITE), species
; (Here, as in PalletToPewter, none evolve by trading or friendship any more:
; the LINKING CORD and the old trade items evolve them like stones do, ESPEON
; and UMBREON come from the SUN STONE and the MOON STONE, and the rest by level.)
;    * dbbbw EVOLVE_STAT, level, ATK_*_DEF constant (LT, GT, EQ), species
; (species: 16-bit indexes)
; - db 0 ; no more evolutions
; - Learnset (in increasing level order):
;    * dbw level, move (its 16-bit index)
; - db 0 ; no more level-up moves

INCLUDE "data/pokemon/evos_attacks_pointers.asm"

BulbasaurEvosAttacks:
	dbbw EVOLVE_LEVEL, 16, IVYSAUR
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 4, GROWL
	dbw 7, LEECH_SEED
	dbw 10, VINE_WHIP
	dbw 15, POISONPOWDER
	dbw 15, SLEEP_POWDER
	dbw 20, RAZOR_LEAF
	dbw 20, GRASSY_TERRAIN
	dbw 25, SWEET_SCENT
	dbw 32, GROWTH
	dbw 39, SYNTHESIS
	dbw 46, SOLARBEAM
	db 0 ; no more level-up moves

IvysaurEvosAttacks:
	dbbw EVOLVE_LEVEL, 32, VENUSAUR
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 1, LEECH_SEED
	dbw 4, GROWL
	dbw 7, LEECH_SEED
	dbw 10, VINE_WHIP
	dbw 15, POISONPOWDER
	dbw 15, SLEEP_POWDER
	dbw 20, GRASSY_TERRAIN
	dbw 22, RAZOR_LEAF
	dbw 29, SWEET_SCENT
	dbw 38, GROWTH
	dbw 47, SYNTHESIS
	dbw 56, SOLARBEAM
	db 0 ; no more level-up moves

VenusaurEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 1, LEECH_SEED
	dbw 1, VINE_WHIP
	dbw 4, GROWL
	dbw 7, LEECH_SEED
	dbw 10, VINE_WHIP
	dbw 15, POISONPOWDER
	dbw 15, SLEEP_POWDER
	dbw 20, GRASSY_TERRAIN
	dbw 22, RAZOR_LEAF
	dbw 29, SWEET_SCENT
	dbw 41, GROWTH
	dbw 53, SYNTHESIS
	dbw 65, SOLARBEAM
	db 0 ; no more level-up moves

CharmanderEvosAttacks:
	dbbw EVOLVE_LEVEL, 16, CHARMELEON
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, GROWL
	dbw 7, EMBER
	dbw 13, SMOKESCREEN
	dbw 15, LEER
	dbw 19, RAGE
	dbw 25, SCARY_FACE
	dbw 31, FLAMETHROWER
	dbw 37, SLASH
	dbw 43, DRAGON_RAGE
	dbw 49, FIRE_SPIN
	db 0 ; no more level-up moves

CharmeleonEvosAttacks:
	dbbw EVOLVE_LEVEL, 36, CHARIZARD
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, GROWL
	dbw 1, EMBER
	dbw 7, EMBER
	dbw 13, SMOKESCREEN
	dbw 15, LEER
	dbw 20, RAGE
	dbw 27, SCARY_FACE
	dbw 34, FLAMETHROWER
	dbw 41, SLASH
	dbw 48, DRAGON_RAGE
	dbw 55, FIRE_SPIN
	db 0 ; no more level-up moves

CharizardEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, GROWL
	dbw 1, EMBER
	dbw 1, SMOKESCREEN
	dbw 1, LEER
	dbw 7, EMBER
	dbw 13, SMOKESCREEN
	dbw 20, RAGE
	dbw 27, SCARY_FACE
	dbw 34, FLAMETHROWER
	dbw 36, WING_ATTACK
	dbw 44, SLASH
	dbw 54, DRAGON_RAGE
	dbw 64, FIRE_SPIN
	db 0 ; no more level-up moves

SquirtleEvosAttacks:
	dbbw EVOLVE_LEVEL, 16, WARTORTLE
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 4, TAIL_WHIP
	dbw 7, BUBBLE
	dbw 10, WITHDRAW
	dbw 13, WATER_GUN
	dbw 18, BITE
	dbw 23, RAPID_SPIN
	dbw 28, PROTECT
	dbw 33, RAIN_DANCE
	dbw 40, SKULL_BASH
	dbw 47, HYDRO_PUMP
	db 0 ; no more level-up moves

WartortleEvosAttacks:
	dbbw EVOLVE_LEVEL, 36, BLASTOISE
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, TAIL_WHIP
	dbw 1, BUBBLE
	dbw 4, TAIL_WHIP
	dbw 7, BUBBLE
	dbw 10, WITHDRAW
	dbw 13, WATER_GUN
	dbw 19, BITE
	dbw 25, RAPID_SPIN
	dbw 31, PROTECT
	dbw 37, RAIN_DANCE
	dbw 45, SKULL_BASH
	dbw 53, HYDRO_PUMP
	db 0 ; no more level-up moves

BlastoiseEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, TAIL_WHIP
	dbw 1, BUBBLE
	dbw 1, WITHDRAW
	dbw 4, TAIL_WHIP
	dbw 7, BUBBLE
	dbw 10, WITHDRAW
	dbw 13, WATER_GUN
	dbw 19, BITE
	dbw 25, RAPID_SPIN
	dbw 31, PROTECT
	dbw 42, RAIN_DANCE
	dbw 55, SKULL_BASH
	dbw 68, HYDRO_PUMP
	db 0 ; no more level-up moves

CaterpieEvosAttacks:
	dbbw EVOLVE_LEVEL, 7, METAPOD
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, STRING_SHOT
	db 0 ; no more level-up moves

MetapodEvosAttacks:
	dbbw EVOLVE_LEVEL, 10, BUTTERFREE
	db 0 ; no more evolutions
	dbw 1, HARDEN
	dbw 7, HARDEN
	db 0 ; no more level-up moves

ButterfreeEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, CONFUSION
	dbw 10, CONFUSION
	dbw 13, POISONPOWDER
	dbw 14, STUN_SPORE
	dbw 15, SLEEP_POWDER
	dbw 18, SUPERSONIC
	dbw 23, WHIRLWIND
	dbw 28, GUST
	dbw 34, PSYBEAM
	dbw 40, SAFEGUARD
	db 0 ; no more level-up moves

WeedleEvosAttacks:
	dbbw EVOLVE_LEVEL, 7, KAKUNA
	db 0 ; no more evolutions
	dbw 1, POISON_STING
	dbw 1, STRING_SHOT
	db 0 ; no more level-up moves

KakunaEvosAttacks:
	dbbw EVOLVE_LEVEL, 10, BEEDRILL
	db 0 ; no more evolutions
	dbw 1, HARDEN
	dbw 7, HARDEN
	db 0 ; no more level-up moves

BeedrillEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, FURY_ATTACK
	dbw 10, FURY_ATTACK
	dbw 15, FOCUS_ENERGY
	dbw 20, TWINEEDLE
	dbw 25, RAGE
	dbw 30, PURSUIT
	dbw 35, PIN_MISSILE
	dbw 40, AGILITY
	db 0 ; no more level-up moves

PidgeyEvosAttacks:
	dbbw EVOLVE_LEVEL, 18, PIDGEOTTO
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 5, SAND_ATTACK
	dbw 9, GUST
	dbw 15, QUICK_ATTACK
	dbw 21, WHIRLWIND
	dbw 29, WING_ATTACK
	dbw 37, AGILITY
	dbw 47, MIRROR_MOVE
	db 0 ; no more level-up moves

PidgeottoEvosAttacks:
	dbbw EVOLVE_LEVEL, 36, PIDGEOT
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, SAND_ATTACK
	dbw 1, GUST
	dbw 5, SAND_ATTACK
	dbw 9, GUST
	dbw 15, QUICK_ATTACK
	dbw 23, WHIRLWIND
	dbw 33, WING_ATTACK
	dbw 43, AGILITY
	dbw 55, MIRROR_MOVE
	db 0 ; no more level-up moves

PidgeotEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, SAND_ATTACK
	dbw 1, GUST
	dbw 1, QUICK_ATTACK
	dbw 5, SAND_ATTACK
	dbw 9, GUST
	dbw 15, QUICK_ATTACK
	dbw 23, WHIRLWIND
	dbw 33, WING_ATTACK
	dbw 46, AGILITY
	dbw 61, MIRROR_MOVE
	db 0 ; no more level-up moves

RattataEvosAttacks:
	dbbw EVOLVE_LEVEL, 20, RATICATE
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, TAIL_WHIP
	dbw 7, QUICK_ATTACK
	dbw 13, HYPER_FANG
	dbw 20, FOCUS_ENERGY
	dbw 27, PURSUIT
	dbw 34, SUPER_FANG
	db 0 ; no more level-up moves

RaticateEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, TAIL_WHIP
	dbw 1, QUICK_ATTACK
	dbw 7, QUICK_ATTACK
	dbw 13, HYPER_FANG
	dbw 20, SCARY_FACE
	dbw 27, FOCUS_ENERGY
	dbw 30, PURSUIT
	dbw 40, SUPER_FANG
	db 0 ; no more level-up moves

SpearowEvosAttacks:
	dbbw EVOLVE_LEVEL, 20, FEAROW
	db 0 ; no more evolutions
	dbw 1, PECK
	dbw 1, GROWL
	dbw 7, LEER
	dbw 13, FURY_ATTACK
	dbw 25, PURSUIT
	dbw 31, MIRROR_MOVE
	dbw 37, DRILL_PECK
	dbw 43, AGILITY
	db 0 ; no more level-up moves

FearowEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, PECK
	dbw 1, GROWL
	dbw 1, LEER
	dbw 1, FURY_ATTACK
	dbw 7, LEER
	dbw 13, FURY_ATTACK
	dbw 26, PURSUIT
	dbw 32, MIRROR_MOVE
	dbw 40, DRILL_PECK
	dbw 47, AGILITY
	db 0 ; no more level-up moves

EkansEvosAttacks:
	dbbw EVOLVE_LEVEL, 22, ARBOK
	db 0 ; no more evolutions
	dbw 1, WRAP
	dbw 1, LEER
	dbw 9, POISON_STING
	dbw 15, BITE
	dbw 23, GLARE
	dbw 29, SCREECH
	dbw 37, ACID
	dbw 43, HAZE
	db 0 ; no more level-up moves

ArbokEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, WRAP
	dbw 1, LEER
	dbw 1, POISON_STING
	dbw 1, BITE
	dbw 9, POISON_STING
	dbw 15, BITE
	dbw 25, GLARE
	dbw 33, SCREECH
	dbw 43, ACID
	dbw 51, HAZE
	db 0 ; no more level-up moves

PikachuEvosAttacks:
	dbbw EVOLVE_ITEM, THUNDERSTONE, RAICHU
	dbbw EVOLVE_ITEM, TWISTEDSPOON, RAICHU_A
	db 0 ; no more evolutions
	dbw 1, THUNDERSHOCK
	dbw 1, GROWL
	dbw 6, TAIL_WHIP
	dbw 8, THUNDER_WAVE
	dbw 11, QUICK_ATTACK
	dbw 15, DOUBLE_TEAM
	dbw 20, SLAM
	dbw 20, ELECTRIC_TERRAIN
	dbw 26, THUNDERBOLT
	dbw 26, SWIFT
	dbw 33, AGILITY
	dbw 41, THUNDER
	dbw 50, LIGHT_SCREEN
	db 0 ; no more level-up moves

RaichuEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, THUNDERSHOCK
	dbw 1, TAIL_WHIP
	dbw 1, QUICK_ATTACK
	dbw 1, THUNDERBOLT
	dbw 1, GROWL
	dbw 1, THUNDER_WAVE
	dbw 20, ELECTRIC_TERRAIN
	db 0 ; no more level-up moves

SandshrewEvosAttacks:
	dbbw EVOLVE_LEVEL, 22, SANDSLASH
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 6, DEFENSE_CURL
	dbw 11, SAND_ATTACK
	dbw 17, POISON_STING
	dbw 23, SLASH
	dbw 30, SWIFT
	dbw 37, FURY_SWIPES
	dbw 45, SANDSTORM
	db 0 ; no more level-up moves

SandslashEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, DEFENSE_CURL
	dbw 1, SAND_ATTACK
	dbw 6, DEFENSE_CURL
	dbw 11, SAND_ATTACK
	dbw 17, POISON_STING
	dbw 24, SLASH
	dbw 33, SWIFT
	dbw 42, FURY_SWIPES
	dbw 52, SANDSTORM
	db 0 ; no more level-up moves

NidoranFEvosAttacks:
	dbbw EVOLVE_LEVEL, 16, NIDORINA
	db 0 ; no more evolutions
	dbw 1, GROWL
	dbw 1, TACKLE
	dbw 8, SCRATCH
	dbw 12, DOUBLE_KICK
	dbw 17, POISON_STING
	dbw 23, TAIL_WHIP
	dbw 30, BITE
	dbw 38, FURY_SWIPES
	db 0 ; no more level-up moves

NidorinaEvosAttacks:
	dbbw EVOLVE_ITEM, MOON_STONE, NIDOQUEEN
	db 0 ; no more evolutions
	dbw 1, GROWL
	dbw 1, TACKLE
	dbw 8, SCRATCH
	dbw 12, DOUBLE_KICK
	dbw 19, POISON_STING
	dbw 27, TAIL_WHIP
	dbw 36, BITE
	dbw 46, FURY_SWIPES
	db 0 ; no more level-up moves

NidoqueenEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, SCRATCH
	dbw 1, DOUBLE_KICK
	dbw 1, TAIL_WHIP
	dbw 14, POISON_STING
	dbw 23, BODY_SLAM
	db 0 ; no more level-up moves

NidoranMEvosAttacks:
	dbbw EVOLVE_LEVEL, 16, NIDORINO
	db 0 ; no more evolutions
	dbw 1, LEER
	dbw 1, TACKLE
	dbw 8, HORN_ATTACK
	dbw 12, DOUBLE_KICK
	dbw 17, POISON_STING
	dbw 23, FOCUS_ENERGY
	dbw 30, FURY_ATTACK
	dbw 38, HORN_DRILL
	db 0 ; no more level-up moves

NidorinoEvosAttacks:
	dbbw EVOLVE_ITEM, MOON_STONE, NIDOKING
	db 0 ; no more evolutions
	dbw 1, LEER
	dbw 1, TACKLE
	dbw 8, HORN_ATTACK
	dbw 12, DOUBLE_KICK
	dbw 19, POISON_STING
	dbw 27, FOCUS_ENERGY
	dbw 36, FURY_ATTACK
	dbw 46, HORN_DRILL
	db 0 ; no more level-up moves

NidokingEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, HORN_ATTACK
	dbw 1, DOUBLE_KICK
	dbw 1, POISON_STING
	dbw 23, THRASH
	db 0 ; no more level-up moves

ClefairyEvosAttacks:
	dbbw EVOLVE_ITEM, MOON_STONE, CLEFABLE
	db 0 ; no more evolutions
	dbw 1, POUND
	dbw 1, GROWL
	dbw 4, ENCORE
	dbw 8, SING
	dbw 13, DOUBLESLAP
	dbw 16, DRAINING_KISS
	dbw 19, MINIMIZE
	dbw 20, MISTY_TERRAIN
	dbw 26, DEFENSE_CURL
	dbw 34, METRONOME
	dbw 38, MOONBLAST
	dbw 43, MOONLIGHT
	dbw 53, LIGHT_SCREEN
	db 0 ; no more level-up moves

ClefableEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SING
	dbw 1, DOUBLESLAP
	dbw 1, METRONOME
	dbw 1, MOONLIGHT
	dbw 1, MINIMIZE
	dbw 20, MISTY_TERRAIN
	dbw 30, MOONBLAST
	db 0 ; no more level-up moves

VulpixEvosAttacks:
	dbbw EVOLVE_ITEM, FIRE_STONE, NINETALES
	db 0 ; no more evolutions
	dbw 1, EMBER
	dbw 1, TAIL_WHIP
	dbw 7, QUICK_ATTACK
	dbw 13, ROAR
	dbw 19, CONFUSE_RAY
	dbw 25, SAFEGUARD
	dbw 31, FLAMETHROWER
	dbw 37, FIRE_SPIN
	db 0 ; no more level-up moves

NinetalesEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, EMBER
	dbw 1, QUICK_ATTACK
	dbw 1, CONFUSE_RAY
	dbw 1, SAFEGUARD
	dbw 1, TAIL_WHIP
	dbw 1, ROAR
	dbw 43, FIRE_SPIN
	db 0 ; no more level-up moves

JigglypuffEvosAttacks:
	dbbw EVOLVE_ITEM, MOON_STONE, WIGGLYTUFF
	db 0 ; no more evolutions
	dbw 1, SING
	dbw 4, DEFENSE_CURL
	dbw 9, POUND
	dbw 14, DISABLE
	dbw 17, DRAINING_KISS
	dbw 19, ROLLOUT
	dbw 20, MISTY_TERRAIN
	dbw 24, DOUBLESLAP
	dbw 29, REST
	dbw 34, BODY_SLAM
	dbw 39, DOUBLE_EDGE
	dbw 44, PLAY_ROUGH
	db 0 ; no more level-up moves

WigglytuffEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SING
	dbw 1, DISABLE
	dbw 1, DEFENSE_CURL
	dbw 1, DOUBLESLAP
	dbw 20, MISTY_TERRAIN
	dbw 30, PLAY_ROUGH
	db 0 ; no more level-up moves

ZubatEvosAttacks:
	dbbw EVOLVE_LEVEL, 22, GOLBAT
	db 0 ; no more evolutions
	dbw 1, LEECH_LIFE
	dbw 6, SUPERSONIC
	dbw 12, BITE
	dbw 19, CONFUSE_RAY
	dbw 27, WING_ATTACK
	dbw 36, MEAN_LOOK
	dbw 46, HAZE
	db 0 ; no more level-up moves

GolbatEvosAttacks:
	dbbw EVOLVE_LEVEL, 35, CROBAT
	db 0 ; no more evolutions
	dbw 1, SCREECH
	dbw 1, LEECH_LIFE
	dbw 1, SUPERSONIC
	dbw 6, SUPERSONIC
	dbw 12, BITE
	dbw 19, CONFUSE_RAY
	dbw 30, WING_ATTACK
	dbw 42, MEAN_LOOK
	dbw 55, HAZE
	db 0 ; no more level-up moves

OddishEvosAttacks:
	dbbw EVOLVE_LEVEL, 21, GLOOM
	db 0 ; no more evolutions
	dbw 1, ABSORB
	dbw 7, SWEET_SCENT
	dbw 14, POISONPOWDER
	dbw 16, STUN_SPORE
	dbw 18, SLEEP_POWDER
	dbw 20, GRASSY_TERRAIN
	dbw 23, ACID
	dbw 32, MOONLIGHT
	dbw 39, PETAL_DANCE
	dbw 46, SOLARBEAM
	db 0 ; no more level-up moves

GloomEvosAttacks:
	dbbw EVOLVE_ITEM, LEAF_STONE, VILEPLUME
	dbbw EVOLVE_ITEM, SUN_STONE, BELLOSSOM
	db 0 ; no more evolutions
	dbw 1, ABSORB
	dbw 1, SWEET_SCENT
	dbw 1, POISONPOWDER
	dbw 7, SWEET_SCENT
	dbw 14, POISONPOWDER
	dbw 16, STUN_SPORE
	dbw 18, SLEEP_POWDER
	dbw 20, GRASSY_TERRAIN
	dbw 24, ACID
	dbw 35, MOONLIGHT
	dbw 44, PETAL_DANCE
	dbw 52, SOLARBEAM
	db 0 ; no more level-up moves

VileplumeEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, ABSORB
	dbw 1, SWEET_SCENT
	dbw 1, STUN_SPORE
	dbw 1, PETAL_DANCE
	dbw 1, SLEEP_POWDER
	dbw 1, ACID
	dbw 15, POISONPOWDER
	dbw 20, GRASSY_TERRAIN
	db 0 ; no more level-up moves

ParasEvosAttacks:
	dbbw EVOLVE_LEVEL, 24, PARASECT
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 7, STUN_SPORE
	dbw 13, POISONPOWDER
	dbw 19, LEECH_LIFE
	dbw 20, GRASSY_TERRAIN
	dbw 25, SPORE
	dbw 31, SLASH
	dbw 37, GROWTH
	dbw 43, GIGA_DRAIN
	db 0 ; no more level-up moves

ParasectEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, STUN_SPORE
	dbw 1, POISONPOWDER
	dbw 7, STUN_SPORE
	dbw 13, POISONPOWDER
	dbw 19, LEECH_LIFE
	dbw 20, GRASSY_TERRAIN
	dbw 28, SPORE
	dbw 37, SLASH
	dbw 46, GROWTH
	dbw 55, GIGA_DRAIN
	db 0 ; no more level-up moves

VenonatEvosAttacks:
	dbbw EVOLVE_LEVEL, 31, VENOMOTH
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DISABLE
	dbw 1, FORESIGHT
	dbw 9, SUPERSONIC
	dbw 17, CONFUSION
	dbw 20, POISONPOWDER
	dbw 25, LEECH_LIFE
	dbw 28, STUN_SPORE
	dbw 33, PSYBEAM
	dbw 36, SLEEP_POWDER
	dbw 41, PSYCHIC_M
	db 0 ; no more level-up moves

VenomothEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DISABLE
	dbw 1, FORESIGHT
	dbw 1, SUPERSONIC
	dbw 9, SUPERSONIC
	dbw 17, CONFUSION
	dbw 20, POISONPOWDER
	dbw 25, LEECH_LIFE
	dbw 28, STUN_SPORE
	dbw 31, GUST
	dbw 36, PSYBEAM
	dbw 42, SLEEP_POWDER
	dbw 52, PSYCHIC_M
	db 0 ; no more level-up moves

DiglettEvosAttacks:
	dbbw EVOLVE_LEVEL, 26, DUGTRIO
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 5, GROWL
	dbw 9, MAGNITUDE
	dbw 17, DIG
	dbw 25, SAND_ATTACK
	dbw 33, SLASH
	dbw 41, EARTHQUAKE
	dbw 49, FISSURE
	db 0 ; no more level-up moves

DugtrioEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TRI_ATTACK
	dbw 1, SCRATCH
	dbw 1, GROWL
	dbw 1, MAGNITUDE
	dbw 5, GROWL
	dbw 9, MAGNITUDE
	dbw 17, DIG
	dbw 25, SAND_ATTACK
	dbw 37, SLASH
	dbw 49, EARTHQUAKE
	dbw 61, FISSURE
	db 0 ; no more level-up moves

MeowthEvosAttacks:
	dbbw EVOLVE_LEVEL, 28, PERSIAN
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, GROWL
	dbw 11, BITE
	dbw 20, PAY_DAY
	dbw 28, FAINT_ATTACK
	dbw 35, SCREECH
	dbw 41, FURY_SWIPES
	dbw 46, SLASH
	db 0 ; no more level-up moves

PersianEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, GROWL
	dbw 1, BITE
	dbw 11, BITE
	dbw 20, PAY_DAY
	dbw 29, FAINT_ATTACK
	dbw 38, SCREECH
	dbw 46, FURY_SWIPES
	dbw 53, SLASH
	db 0 ; no more level-up moves

PsyduckEvosAttacks:
	dbbw EVOLVE_LEVEL, 33, GOLDUCK
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 5, TAIL_WHIP
	dbw 10, DISABLE
	dbw 16, CONFUSION
	dbw 23, SCREECH
	dbw 31, PSYCH_UP
	dbw 40, FURY_SWIPES
	dbw 50, HYDRO_PUMP
	db 0 ; no more level-up moves

GolduckEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, TAIL_WHIP
	dbw 1, DISABLE
	dbw 1, CONFUSION
	dbw 5, TAIL_WHIP
	dbw 10, DISABLE
	dbw 16, CONFUSION
	dbw 23, SCREECH
	dbw 31, PSYCH_UP
	dbw 44, FURY_SWIPES
	dbw 58, HYDRO_PUMP
	db 0 ; no more level-up moves

MankeyEvosAttacks:
	dbbw EVOLVE_LEVEL, 28, PRIMEAPE
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 9, LOW_KICK
	dbw 15, KARATE_CHOP
	dbw 21, FURY_SWIPES
	dbw 27, FOCUS_ENERGY
	dbw 33, SEISMIC_TOSS
	dbw 39, CROSS_CHOP
	dbw 45, SCREECH
	dbw 51, THRASH
	db 0 ; no more level-up moves

PrimeapeEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 1, LOW_KICK
	dbw 1, RAGE
	dbw 9, LOW_KICK
	dbw 15, KARATE_CHOP
	dbw 21, FURY_SWIPES
	dbw 27, FOCUS_ENERGY
	dbw 28, RAGE
	dbw 36, SEISMIC_TOSS
	dbw 45, CROSS_CHOP
	dbw 54, SCREECH
	dbw 63, THRASH
	db 0 ; no more level-up moves

GrowlitheEvosAttacks:
	dbbw EVOLVE_ITEM, FIRE_STONE, ARCANINE
	db 0 ; no more evolutions
	dbw 1, BITE
	dbw 1, ROAR
	dbw 9, EMBER
	dbw 18, LEER
	dbw 26, TAKE_DOWN
	dbw 34, FLAME_WHEEL
	dbw 42, AGILITY
	dbw 50, FLAMETHROWER
	db 0 ; no more level-up moves

ArcanineEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, ROAR
	dbw 1, LEER
	dbw 1, TAKE_DOWN
	dbw 1, FLAME_WHEEL
	dbw 1, EMBER
	dbw 50, EXTREMESPEED
	db 0 ; no more level-up moves

PoliwagEvosAttacks:
	dbbw EVOLVE_LEVEL, 25, POLIWHIRL
	db 0 ; no more evolutions
	dbw 1, BUBBLE
	dbw 7, HYPNOSIS
	dbw 13, WATER_GUN
	dbw 19, DOUBLESLAP
	dbw 25, RAIN_DANCE
	dbw 31, BODY_SLAM
	dbw 37, BELLY_DRUM
	dbw 38, AMNESIA
	dbw 43, HYDRO_PUMP
	db 0 ; no more level-up moves

PoliwhirlEvosAttacks:
	dbbw EVOLVE_ITEM, WATER_STONE, POLIWRATH
	dbbw EVOLVE_ITEM, KINGS_ROCK, POLITOED
	db 0 ; no more evolutions
	dbw 1, BUBBLE
	dbw 1, HYPNOSIS
	dbw 1, WATER_GUN
	dbw 7, HYPNOSIS
	dbw 13, WATER_GUN
	dbw 19, DOUBLESLAP
	dbw 27, RAIN_DANCE
	dbw 35, BODY_SLAM
	dbw 41, AMNESIA
	dbw 43, BELLY_DRUM
	dbw 51, HYDRO_PUMP
	db 0 ; no more level-up moves

PoliwrathEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, WATER_GUN
	dbw 1, HYPNOSIS
	dbw 1, DOUBLESLAP
	dbw 1, SUBMISSION
	dbw 1, BODY_SLAM
	dbw 35, SUBMISSION
	dbw 51, MIND_READER
	db 0 ; no more level-up moves

AbraEvosAttacks:
	dbbw EVOLVE_LEVEL, 16, KADABRA
	db 0 ; no more evolutions
	dbw 1, TELEPORT
	dbw 20, PSYCHIC_TERRAIN
	db 0 ; no more level-up moves

KadabraEvosAttacks:
	dbbw EVOLVE_ITEM, LINKING_CORD, ALAKAZAM
	db 0 ; no more evolutions
	dbw 1, TELEPORT
	dbw 1, KINESIS
	dbw 1, CONFUSION
	dbw 16, CONFUSION
	dbw 18, DISABLE
	dbw 20, PSYCHIC_TERRAIN
	dbw 21, PSYBEAM
	dbw 26, RECOVER
	dbw 31, FUTURE_SIGHT
	dbw 38, PSYCHIC_M
	dbw 45, REFLECT
	db 0 ; no more level-up moves

AlakazamEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TELEPORT
	dbw 1, KINESIS
	dbw 1, CONFUSION
	dbw 16, CONFUSION
	dbw 18, DISABLE
	dbw 20, PSYCHIC_TERRAIN
	dbw 21, PSYBEAM
	dbw 26, RECOVER
	dbw 31, FUTURE_SIGHT
	dbw 38, PSYCHIC_M
	dbw 45, REFLECT
	db 0 ; no more level-up moves

MachopEvosAttacks:
	dbbw EVOLVE_LEVEL, 28, MACHOKE
	db 0 ; no more evolutions
	dbw 1, LOW_KICK
	dbw 1, LEER
	dbw 7, FOCUS_ENERGY
	dbw 13, KARATE_CHOP
	dbw 19, SEISMIC_TOSS
	dbw 25, FORESIGHT
	dbw 31, VITAL_THROW
	dbw 37, CROSS_CHOP
	dbw 43, SCARY_FACE
	dbw 49, SUBMISSION
	db 0 ; no more level-up moves

MachokeEvosAttacks:
	dbbw EVOLVE_ITEM, LINKING_CORD, MACHAMP
	db 0 ; no more evolutions
	dbw 1, LOW_KICK
	dbw 1, LEER
	dbw 1, FOCUS_ENERGY
	dbw 8, FOCUS_ENERGY
	dbw 15, KARATE_CHOP
	dbw 19, SEISMIC_TOSS
	dbw 25, FORESIGHT
	dbw 34, VITAL_THROW
	dbw 43, CROSS_CHOP
	dbw 52, SCARY_FACE
	dbw 61, SUBMISSION
	db 0 ; no more level-up moves

MachampEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, LOW_KICK
	dbw 1, LEER
	dbw 1, FOCUS_ENERGY
	dbw 8, FOCUS_ENERGY
	dbw 15, KARATE_CHOP
	dbw 19, SEISMIC_TOSS
	dbw 25, FORESIGHT
	dbw 34, VITAL_THROW
	dbw 43, CROSS_CHOP
	dbw 52, SCARY_FACE
	dbw 61, SUBMISSION
	db 0 ; no more level-up moves

BellsproutEvosAttacks:
	dbbw EVOLVE_LEVEL, 21, WEEPINBELL
	db 0 ; no more evolutions
	dbw 1, VINE_WHIP
	dbw 6, GROWTH
	dbw 11, WRAP
	dbw 15, SLEEP_POWDER
	dbw 17, POISONPOWDER
	dbw 19, STUN_SPORE
	dbw 20, GRASSY_TERRAIN
	dbw 23, ACID
	dbw 30, SWEET_SCENT
	dbw 37, RAZOR_LEAF
	dbw 45, SLAM
	db 0 ; no more level-up moves

WeepinbellEvosAttacks:
	dbbw EVOLVE_ITEM, LEAF_STONE, VICTREEBEL
	db 0 ; no more evolutions
	dbw 1, VINE_WHIP
	dbw 1, GROWTH
	dbw 1, WRAP
	dbw 6, GROWTH
	dbw 11, WRAP
	dbw 15, SLEEP_POWDER
	dbw 17, POISONPOWDER
	dbw 19, STUN_SPORE
	dbw 20, GRASSY_TERRAIN
	dbw 24, ACID
	dbw 33, SWEET_SCENT
	dbw 42, RAZOR_LEAF
	dbw 54, SLAM
	db 0 ; no more level-up moves

VictreebelEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, VINE_WHIP
	dbw 1, SLEEP_POWDER
	dbw 1, SWEET_SCENT
	dbw 1, RAZOR_LEAF
	dbw 1, STUN_SPORE
	dbw 1, ACID
	dbw 13, WRAP
	dbw 15, POISONPOWDER
	dbw 20, GRASSY_TERRAIN
	db 0 ; no more level-up moves

TentacoolEvosAttacks:
	dbbw EVOLVE_LEVEL, 30, TENTACRUEL
	db 0 ; no more evolutions
	dbw 1, POISON_STING
	dbw 6, SUPERSONIC
	dbw 12, CONSTRICT
	dbw 19, ACID
	dbw 22, WATER_GUN
	dbw 25, BUBBLEBEAM
	dbw 30, WRAP
	dbw 36, BARRIER
	dbw 43, SCREECH
	dbw 49, HYDRO_PUMP
	db 0 ; no more level-up moves

TentacruelEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, POISON_STING
	dbw 1, SUPERSONIC
	dbw 1, CONSTRICT
	dbw 6, SUPERSONIC
	dbw 12, CONSTRICT
	dbw 19, ACID
	dbw 22, WATER_GUN
	dbw 25, BUBBLEBEAM
	dbw 30, WRAP
	dbw 38, BARRIER
	dbw 47, SCREECH
	dbw 55, HYDRO_PUMP
	db 0 ; no more level-up moves

GeodudeEvosAttacks:
	dbbw EVOLVE_LEVEL, 25, GRAVELER
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 6, DEFENSE_CURL
	dbw 11, ROCK_THROW
	dbw 16, MAGNITUDE
	dbw 21, SELFDESTRUCT
	dbw 26, HARDEN
	dbw 31, ROLLOUT
	dbw 36, EARTHQUAKE
	dbw 41, EXPLOSION
	db 0 ; no more level-up moves

GravelerEvosAttacks:
	dbbw EVOLVE_ITEM, LINKING_CORD, GOLEM
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL
	dbw 1, ROCK_THROW
	dbw 6, DEFENSE_CURL
	dbw 11, ROCK_THROW
	dbw 16, MAGNITUDE
	dbw 21, SELFDESTRUCT
	dbw 27, HARDEN
	dbw 34, ROLLOUT
	dbw 41, EARTHQUAKE
	dbw 48, EXPLOSION
	db 0 ; no more level-up moves

GolemEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL
	dbw 1, ROCK_THROW
	dbw 1, MAGNITUDE
	dbw 6, DEFENSE_CURL
	dbw 11, ROCK_THROW
	dbw 16, MAGNITUDE
	dbw 21, SELFDESTRUCT
	dbw 27, HARDEN
	dbw 34, ROLLOUT
	dbw 41, EARTHQUAKE
	dbw 48, EXPLOSION
	db 0 ; no more level-up moves

PonytaEvosAttacks:
	dbbw EVOLVE_LEVEL, 40, RAPIDASH
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 4, GROWL
	dbw 8, TAIL_WHIP
	dbw 13, EMBER
	dbw 19, STOMP
	dbw 26, FIRE_SPIN
	dbw 34, TAKE_DOWN
	dbw 43, AGILITY
	dbw 53, FIRE_BLAST
	db 0 ; no more level-up moves

RapidashEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 1, TAIL_WHIP
	dbw 1, EMBER
	dbw 4, GROWL
	dbw 8, TAIL_WHIP
	dbw 13, EMBER
	dbw 19, STOMP
	dbw 26, FIRE_SPIN
	dbw 34, TAKE_DOWN
	dbw 40, FURY_ATTACK
	dbw 47, AGILITY
	dbw 61, FIRE_BLAST
	db 0 ; no more level-up moves

SlowpokeEvosAttacks:
	dbbw EVOLVE_LEVEL, 37, SLOWBRO
	dbbw EVOLVE_ITEM, KINGS_ROCK, SLOWKING
	db 0 ; no more evolutions
	dbw 1, CURSE
	dbw 1, TACKLE
	dbw 6, GROWL
	dbw 15, WATER_GUN
	dbw 20, CONFUSION
	dbw 20, PSYCHIC_TERRAIN
	dbw 29, DISABLE
	dbw 34, HEADBUTT
	dbw 43, AMNESIA
	dbw 48, PSYCHIC_M
	db 0 ; no more level-up moves

SlowbroEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, CURSE
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 1, WATER_GUN
	dbw 6, GROWL
	dbw 15, WATER_GUN
	dbw 20, CONFUSION
	dbw 20, PSYCHIC_TERRAIN
	dbw 29, DISABLE
	dbw 34, HEADBUTT
	dbw 37, WITHDRAW
	dbw 46, AMNESIA
	dbw 54, PSYCHIC_M
	db 0 ; no more level-up moves

MagnemiteEvosAttacks:
	dbbw EVOLVE_LEVEL, 30, MAGNETON
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 6, THUNDERSHOCK
	dbw 11, SUPERSONIC
	dbw 16, SONICBOOM
	dbw 20, ELECTRIC_TERRAIN
	dbw 21, THUNDER_WAVE
	dbw 27, LOCK_ON
	dbw 33, SWIFT
	dbw 39, SCREECH
	dbw 45, ZAP_CANNON
	db 0 ; no more level-up moves

MagnetonEvosAttacks:
	dbbw EVOLVE_ITEM, THUNDERSTONE, MAGNEZONE
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, THUNDERSHOCK
	dbw 1, SUPERSONIC
	dbw 1, SONICBOOM
	dbw 6, THUNDERSHOCK
	dbw 11, SUPERSONIC
	dbw 16, SONICBOOM
	dbw 20, ELECTRIC_TERRAIN
	dbw 21, THUNDER_WAVE
	dbw 27, LOCK_ON
	dbw 35, TRI_ATTACK
	dbw 35, SWIFT
	dbw 43, SCREECH
	dbw 53, ZAP_CANNON
	db 0 ; no more level-up moves

FarfetchDEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, PECK
	dbw 7, SAND_ATTACK
	dbw 13, LEER
	dbw 19, FURY_ATTACK
	dbw 25, SWORDS_DANCE
	dbw 31, AGILITY
	dbw 37, SLASH
	dbw 44, FALSE_SWIPE
	db 0 ; no more level-up moves

DoduoEvosAttacks:
	dbbw EVOLVE_LEVEL, 31, DODRIO
	db 0 ; no more evolutions
	dbw 1, PECK
	dbw 1, GROWL
	dbw 9, PURSUIT
	dbw 13, FURY_ATTACK
	dbw 21, TRI_ATTACK
	dbw 25, RAGE
	dbw 33, DRILL_PECK
	dbw 37, AGILITY
	db 0 ; no more level-up moves

DodrioEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, PECK
	dbw 1, GROWL
	dbw 1, PURSUIT
	dbw 1, FURY_ATTACK
	dbw 9, PURSUIT
	dbw 13, FURY_ATTACK
	dbw 21, TRI_ATTACK
	dbw 25, RAGE
	dbw 38, DRILL_PECK
	dbw 47, AGILITY
	db 0 ; no more level-up moves

SeelEvosAttacks:
	dbbw EVOLVE_LEVEL, 34, DEWGONG
	db 0 ; no more evolutions
	dbw 1, HEADBUTT
	dbw 5, GROWL
	dbw 16, AURORA_BEAM
	dbw 21, REST
	dbw 32, TAKE_DOWN
	dbw 37, ICE_BEAM
	dbw 48, SAFEGUARD
	db 0 ; no more level-up moves

DewgongEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, HEADBUTT
	dbw 1, GROWL
	dbw 1, AURORA_BEAM
	dbw 5, GROWL
	dbw 16, AURORA_BEAM
	dbw 20, HAIL
	dbw 21, REST
	dbw 32, TAKE_DOWN
	dbw 43, ICE_BEAM
	dbw 60, SAFEGUARD
	db 0 ; no more level-up moves

GrimerEvosAttacks:
	dbbw EVOLVE_LEVEL, 38, MUK
	db 0 ; no more evolutions
	dbw 1, POISON_GAS
	dbw 1, POUND
	dbw 5, HARDEN
	dbw 10, DISABLE
	dbw 16, SLUDGE
	dbw 23, MINIMIZE
	dbw 31, SCREECH
	dbw 40, ACID_ARMOR
	dbw 50, SLUDGE_BOMB
	db 0 ; no more level-up moves

MukEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, POISON_GAS
	dbw 1, POUND
	dbw 1, HARDEN
	dbw 23, MINIMIZE
	dbw 31, SCREECH
	dbw 33, HARDEN
	dbw 37, DISABLE
	dbw 45, SLUDGE
	dbw 45, ACID_ARMOR
	dbw 60, SLUDGE_BOMB
	; moves are not sorted by level
	db 0 ; no more level-up moves

ShellderEvosAttacks:
	dbbw EVOLVE_ITEM, WATER_STONE, CLOYSTER
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, WITHDRAW
	dbw 9, SUPERSONIC
	dbw 17, AURORA_BEAM
	dbw 25, PROTECT
	dbw 33, LEER
	dbw 41, CLAMP
	dbw 49, ICE_BEAM
	db 0 ; no more level-up moves

CloysterEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, WITHDRAW
	dbw 1, SUPERSONIC
	dbw 1, AURORA_BEAM
	dbw 1, PROTECT
	dbw 1, CLAMP
	dbw 20, HAIL
	dbw 33, SPIKES
	dbw 41, SPIKE_CANNON
	db 0 ; no more level-up moves

GastlyEvosAttacks:
	dbbw EVOLVE_LEVEL, 25, HAUNTER
	db 0 ; no more evolutions
	dbw 1, HYPNOSIS
	dbw 1, LICK
	dbw 8, SPITE
	dbw 13, MEAN_LOOK
	dbw 16, CURSE
	dbw 21, NIGHT_SHADE
	dbw 28, CONFUSE_RAY
	dbw 33, DREAM_EATER
	dbw 36, DESTINY_BOND
	db 0 ; no more level-up moves

HaunterEvosAttacks:
	dbbw EVOLVE_ITEM, LINKING_CORD, GENGAR
	db 0 ; no more evolutions
	dbw 1, HYPNOSIS
	dbw 1, LICK
	dbw 1, SPITE
	dbw 8, SPITE
	dbw 13, MEAN_LOOK
	dbw 16, CURSE
	dbw 21, NIGHT_SHADE
	dbw 31, CONFUSE_RAY
	dbw 39, DREAM_EATER
	dbw 48, DESTINY_BOND
	db 0 ; no more level-up moves

GengarEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, HYPNOSIS
	dbw 1, LICK
	dbw 1, SPITE
	dbw 8, SPITE
	dbw 13, MEAN_LOOK
	dbw 16, CURSE
	dbw 21, NIGHT_SHADE
	dbw 31, CONFUSE_RAY
	dbw 39, DREAM_EATER
	dbw 48, DESTINY_BOND
	db 0 ; no more level-up moves

OnixEvosAttacks:
	dbbw EVOLVE_ITEM, METAL_COAT, STEELIX
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, SCREECH
	dbw 10, BIND
	dbw 14, ROCK_THROW
	dbw 23, HARDEN
	dbw 27, RAGE
	dbw 36, SANDSTORM
	dbw 40, SLAM
	db 0 ; no more level-up moves

DrowzeeEvosAttacks:
	dbbw EVOLVE_LEVEL, 26, HYPNO
	db 0 ; no more evolutions
	dbw 1, POUND
	dbw 1, HYPNOSIS
	dbw 10, DISABLE
	dbw 18, CONFUSION
	dbw 20, PSYCHIC_TERRAIN
	dbw 25, HEADBUTT
	dbw 31, POISON_GAS
	dbw 36, MEDITATE
	dbw 40, PSYCHIC_M
	dbw 43, PSYCH_UP
	dbw 45, FUTURE_SIGHT
	db 0 ; no more level-up moves

HypnoEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, POUND
	dbw 1, HYPNOSIS
	dbw 1, DISABLE
	dbw 1, CONFUSION
	dbw 10, DISABLE
	dbw 18, CONFUSION
	dbw 20, PSYCHIC_TERRAIN
	dbw 25, HEADBUTT
	dbw 33, POISON_GAS
	dbw 40, MEDITATE
	dbw 49, PSYCHIC_M
	dbw 55, PSYCH_UP
	dbw 60, FUTURE_SIGHT
	db 0 ; no more level-up moves

KrabbyEvosAttacks:
	dbbw EVOLVE_LEVEL, 28, KINGLER
	db 0 ; no more evolutions
	dbw 1, BUBBLE
	dbw 5, LEER
	dbw 12, VICEGRIP
	dbw 16, HARDEN
	dbw 23, STOMP
	dbw 27, GUILLOTINE
	dbw 34, PROTECT
	dbw 41, CRABHAMMER
	db 0 ; no more level-up moves

KinglerEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, BUBBLE
	dbw 1, LEER
	dbw 1, VICEGRIP
	dbw 5, LEER
	dbw 12, VICEGRIP
	dbw 16, HARDEN
	dbw 23, STOMP
	dbw 27, GUILLOTINE
	dbw 38, PROTECT
	dbw 49, CRABHAMMER
	db 0 ; no more level-up moves

VoltorbEvosAttacks:
	dbbw EVOLVE_LEVEL, 30, ELECTRODE
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 9, SCREECH
	dbw 17, SONICBOOM
	dbw 20, ELECTRIC_TERRAIN
	dbw 23, SELFDESTRUCT
	dbw 29, ROLLOUT
	dbw 33, LIGHT_SCREEN
	dbw 37, SWIFT
	dbw 39, EXPLOSION
	dbw 41, MIRROR_COAT
	db 0 ; no more level-up moves

ElectrodeEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, SCREECH
	dbw 1, SONICBOOM
	dbw 1, SELFDESTRUCT
	dbw 9, SCREECH
	dbw 17, SONICBOOM
	dbw 20, ELECTRIC_TERRAIN
	dbw 23, SELFDESTRUCT
	dbw 29, ROLLOUT
	dbw 34, LIGHT_SCREEN
	dbw 40, SWIFT
	dbw 44, EXPLOSION
	dbw 48, MIRROR_COAT
	db 0 ; no more level-up moves

ExeggcuteEvosAttacks:
	dbbw EVOLVE_ITEM, LEAF_STONE, EXEGGUTOR
	dbbw EVOLVE_ITEM, DRAGON_FANG, EXEGGUTOR_A
	db 0 ; no more evolutions
	dbw 1, BARRAGE
	dbw 1, HYPNOSIS
	dbw 7, REFLECT
	dbw 13, LEECH_SEED
	dbw 19, CONFUSION
	dbw 20, GRASSY_TERRAIN
	dbw 20, PSYCHIC_TERRAIN
	dbw 25, STUN_SPORE
	dbw 31, POISONPOWDER
	dbw 37, SLEEP_POWDER
	dbw 43, SOLARBEAM
	db 0 ; no more level-up moves

ExeggutorEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, BARRAGE
	dbw 1, HYPNOSIS
	dbw 1, CONFUSION
	dbw 19, STOMP
	dbw 20, GRASSY_TERRAIN
	dbw 20, PSYCHIC_TERRAIN
	dbw 31, EGG_BOMB
	db 0 ; no more level-up moves

CuboneEvosAttacks:
	dbbw EVOLVE_LEVEL, 28, MAROWAK
	dbbw EVOLVE_ITEM, SPELL_TAG, MAROWAK_A
	db 0 ; no more evolutions
	dbw 1, GROWL
	dbw 5, TAIL_WHIP
	dbw 9, BONE_CLUB
	dbw 13, HEADBUTT
	dbw 17, LEER
	dbw 21, FOCUS_ENERGY
	dbw 25, BONEMERANG
	dbw 29, RAGE
	dbw 33, FALSE_SWIPE
	dbw 37, THRASH
	dbw 41, BONE_RUSH
	db 0 ; no more level-up moves

MarowakEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, GROWL
	dbw 1, TAIL_WHIP
	dbw 1, BONE_CLUB
	dbw 1, HEADBUTT
	dbw 5, TAIL_WHIP
	dbw 9, BONE_CLUB
	dbw 13, HEADBUTT
	dbw 17, LEER
	dbw 21, FOCUS_ENERGY
	dbw 25, BONEMERANG
	dbw 32, RAGE
	dbw 39, FALSE_SWIPE
	dbw 46, THRASH
	dbw 53, BONE_RUSH
	db 0 ; no more level-up moves

HitmonleeEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, DOUBLE_KICK
	dbw 6, MEDITATE
	dbw 11, ROLLING_KICK
	dbw 16, JUMP_KICK
	dbw 21, FOCUS_ENERGY
	dbw 26, HI_JUMP_KICK
	dbw 31, MIND_READER
	dbw 36, FORESIGHT
	dbw 41, ENDURE
	dbw 46, MEGA_KICK
	dbw 51, REVERSAL
	db 0 ; no more level-up moves

HitmonchanEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, COMET_PUNCH
	dbw 7, AGILITY
	dbw 13, PURSUIT
	dbw 26, THUNDERPUNCH
	dbw 26, ICE_PUNCH
	dbw 26, FIRE_PUNCH
	dbw 32, MACH_PUNCH
	dbw 38, MEGA_PUNCH
	dbw 44, DETECT
	dbw 50, COUNTER
	db 0 ; no more level-up moves

LickitungEvosAttacks:
	dbbw EVOLVE_LEVEL, 33, LICKILICKY
	db 0 ; no more evolutions
	dbw 1, LICK
	dbw 7, SUPERSONIC
	dbw 13, DEFENSE_CURL
	dbw 19, STOMP
	dbw 25, WRAP
	dbw 31, DISABLE
	dbw 37, SLAM
	dbw 43, SCREECH
	db 0 ; no more level-up moves

KoffingEvosAttacks:
	dbbw EVOLVE_LEVEL, 35, WEEZING
	dbbw EVOLVE_ITEM, POLKADOT_BOW, WEEZING_G
	db 0 ; no more evolutions
	dbw 1, POISON_GAS
	dbw 1, TACKLE
	dbw 9, SMOG
	dbw 17, SELFDESTRUCT
	dbw 21, SLUDGE
	dbw 25, SMOKESCREEN
	dbw 33, HAZE
	dbw 41, EXPLOSION
	dbw 45, DESTINY_BOND
	db 0 ; no more level-up moves

WeezingEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, POISON_GAS
	dbw 1, TACKLE
	dbw 1, SMOG
	dbw 1, SELFDESTRUCT
	dbw 9, SMOG
	dbw 17, SELFDESTRUCT
	dbw 21, SLUDGE
	dbw 25, SMOKESCREEN
	dbw 33, HAZE
	dbw 44, EXPLOSION
	dbw 51, DESTINY_BOND
	db 0 ; no more level-up moves

RhyhornEvosAttacks:
	dbbw EVOLVE_LEVEL, 42, RHYDON
	db 0 ; no more evolutions
	dbw 1, HORN_ATTACK
	dbw 1, TAIL_WHIP
	dbw 13, STOMP
	dbw 19, FURY_ATTACK
	dbw 31, SCARY_FACE
	dbw 37, HORN_DRILL
	dbw 49, TAKE_DOWN
	dbw 50, LEER
	dbw 55, EARTHQUAKE
	db 0 ; no more level-up moves

RhydonEvosAttacks:
	dbbw EVOLVE_ITEM, LINKING_CORD, RHYPERIOR
	db 0 ; no more evolutions
	dbw 1, HORN_ATTACK
	dbw 1, TAIL_WHIP
	dbw 1, STOMP
	dbw 1, FURY_ATTACK
	dbw 13, STOMP
	dbw 19, FURY_ATTACK
	dbw 31, SCARY_FACE
	dbw 37, HORN_DRILL
	dbw 54, TAKE_DOWN
	dbw 55, LEER
	dbw 65, EARTHQUAKE
	db 0 ; no more level-up moves

ChanseyEvosAttacks:
	dbbw EVOLVE_LEVEL, 40, BLISSEY
	db 0 ; no more evolutions
	dbw 1, POUND
	dbw 5, GROWL
	dbw 9, TAIL_WHIP
	dbw 13, SOFTBOILED
	dbw 17, DOUBLESLAP
	dbw 23, MINIMIZE
	dbw 29, SING
	dbw 35, EGG_BOMB
	dbw 41, DEFENSE_CURL
	dbw 49, LIGHT_SCREEN
	dbw 57, DOUBLE_EDGE
	db 0 ; no more level-up moves

TangelaEvosAttacks:
	dbbw EVOLVE_LEVEL, 33, TANGROWTH
	db 0 ; no more evolutions
	dbw 1, CONSTRICT
	dbw 4, SLEEP_POWDER
	dbw 10, ABSORB
	dbw 13, POISONPOWDER
	dbw 19, VINE_WHIP
	dbw 20, GRASSY_TERRAIN
	dbw 25, BIND
	dbw 31, MEGA_DRAIN
	dbw 34, STUN_SPORE
	dbw 40, SLAM
	dbw 46, GROWTH
	db 0 ; no more level-up moves

KangaskhanEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, COMET_PUNCH
	dbw 7, LEER
	dbw 13, BITE
	dbw 19, TAIL_WHIP
	dbw 25, MEGA_PUNCH
	dbw 31, RAGE
	dbw 37, ENDURE
	dbw 43, DIZZY_PUNCH
	dbw 49, REVERSAL
	db 0 ; no more level-up moves

HorseaEvosAttacks:
	dbbw EVOLVE_LEVEL, 32, SEADRA
	db 0 ; no more evolutions
	dbw 1, BUBBLE
	dbw 8, SMOKESCREEN
	dbw 15, LEER
	dbw 22, WATER_GUN
	dbw 29, TWISTER
	dbw 36, AGILITY
	dbw 43, HYDRO_PUMP
	db 0 ; no more level-up moves

SeadraEvosAttacks:
	dbbw EVOLVE_ITEM, DRAGON_SCALE, KINGDRA
	db 0 ; no more evolutions
	dbw 1, BUBBLE
	dbw 1, SMOKESCREEN
	dbw 1, LEER
	dbw 1, WATER_GUN
	dbw 8, SMOKESCREEN
	dbw 15, LEER
	dbw 22, WATER_GUN
	dbw 29, TWISTER
	dbw 40, AGILITY
	dbw 51, HYDRO_PUMP
	db 0 ; no more level-up moves

GoldeenEvosAttacks:
	dbbw EVOLVE_LEVEL, 33, SEAKING
	db 0 ; no more evolutions
	dbw 1, PECK
	dbw 1, TAIL_WHIP
	dbw 10, SUPERSONIC
	dbw 15, HORN_ATTACK
	dbw 24, FLAIL
	dbw 29, FURY_ATTACK
	dbw 38, WATERFALL
	dbw 43, HORN_DRILL
	dbw 52, AGILITY
	db 0 ; no more level-up moves

SeakingEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, PECK
	dbw 1, TAIL_WHIP
	dbw 1, TAIL_WHIP
	dbw 10, SUPERSONIC
	dbw 15, HORN_ATTACK
	dbw 24, FLAIL
	dbw 29, FURY_ATTACK
	dbw 41, WATERFALL
	dbw 49, HORN_DRILL
	dbw 61, AGILITY
	db 0 ; no more level-up moves

StaryuEvosAttacks:
	dbbw EVOLVE_ITEM, WATER_STONE, STARMIE
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, HARDEN
	dbw 7, WATER_GUN
	dbw 13, RAPID_SPIN
	dbw 19, RECOVER
	dbw 25, SWIFT
	dbw 31, BUBBLEBEAM
	dbw 37, MINIMIZE
	dbw 43, LIGHT_SCREEN
	dbw 50, HYDRO_PUMP
	db 0 ; no more level-up moves

StarmieEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, RAPID_SPIN
	dbw 1, RECOVER
	dbw 1, BUBBLEBEAM
	dbw 1, WATER_GUN
	dbw 1, HARDEN
	dbw 20, PSYCHIC_TERRAIN
	dbw 37, CONFUSE_RAY
	db 0 ; no more level-up moves

MrMimeEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, BARRIER
	dbw 6, CONFUSION
	dbw 11, SUBSTITUTE
	dbw 16, MEDITATE
	dbw 20, MISTY_TERRAIN
	dbw 20, PSYCHIC_TERRAIN
	dbw 21, DOUBLESLAP
	dbw 24, DRAINING_KISS
	dbw 26, LIGHT_SCREEN
	dbw 26, REFLECT
	dbw 31, ENCORE
	dbw 36, PSYBEAM
	dbw 41, BATON_PASS
	dbw 44, MOONBLAST
	dbw 46, SAFEGUARD
	db 0 ; no more level-up moves

ScytherEvosAttacks:
	dbbw EVOLVE_ITEM, METAL_COAT, SCIZOR
	dbbw EVOLVE_ITEM, HARD_STONE, KLEAVOR
	db 0 ; no more evolutions
	dbw 1, QUICK_ATTACK
	dbw 1, LEER
	dbw 6, FOCUS_ENERGY
	dbw 12, PURSUIT
	dbw 18, FALSE_SWIPE
	dbw 24, AGILITY
	dbw 30, WING_ATTACK
	dbw 36, SLASH
	dbw 42, SWORDS_DANCE
	dbw 48, DOUBLE_TEAM
	db 0 ; no more level-up moves

JynxEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, POUND
	dbw 1, LICK
	dbw 1, LOVELY_KISS
	dbw 1, POWDER_SNOW
	dbw 9, LOVELY_KISS
	dbw 13, POWDER_SNOW
	dbw 20, HAIL
	dbw 20, PSYCHIC_TERRAIN
	dbw 21, DOUBLESLAP
	dbw 25, ICE_PUNCH
	dbw 35, MEAN_LOOK
	dbw 41, BODY_SLAM
	dbw 47, THRASH
	dbw 51, PERISH_SONG
	dbw 57, BLIZZARD
	db 0 ; no more level-up moves

ElectabuzzEvosAttacks:
	dbbw EVOLVE_ITEM, LINKING_CORD, ELECTIVIRE
	db 0 ; no more evolutions
	dbw 1, QUICK_ATTACK
	dbw 1, LEER
	dbw 1, THUNDERPUNCH
	dbw 9, THUNDERPUNCH
	dbw 17, LIGHT_SCREEN
	dbw 20, ELECTRIC_TERRAIN
	dbw 25, SWIFT
	dbw 34, THUNDERSHOCK
	dbw 36, SCREECH
	dbw 47, THUNDERBOLT
	dbw 58, THUNDER
	db 0 ; no more level-up moves

MagmarEvosAttacks:
	dbbw EVOLVE_ITEM, LINKING_CORD, MAGMORTAR
	db 0 ; no more evolutions
	dbw 1, EMBER
	dbw 1, LEER
	dbw 1, SMOG
	dbw 1, FIRE_PUNCH
	dbw 7, LEER
	dbw 13, SMOG
	dbw 19, FIRE_PUNCH
	dbw 25, SMOKESCREEN
	dbw 33, SUNNY_DAY
	dbw 41, FLAMETHROWER
	dbw 49, CONFUSE_RAY
	dbw 57, FIRE_BLAST
	db 0 ; no more level-up moves

PinsirEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, VICEGRIP
	dbw 7, FOCUS_ENERGY
	dbw 13, BIND
	dbw 19, SEISMIC_TOSS
	dbw 25, HARDEN
	dbw 31, GUILLOTINE
	dbw 37, SUBMISSION
	dbw 43, SWORDS_DANCE
	dbw 49, SLASH
	db 0 ; no more level-up moves

TaurosEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 4, TAIL_WHIP
	dbw 8, RAGE
	dbw 13, HORN_ATTACK
	dbw 19, SCARY_FACE
	dbw 21, STOMP
	dbw 26, PURSUIT
	dbw 34, REST
	dbw 35, LEER
	dbw 43, THRASH
	dbw 53, TAKE_DOWN
	db 0 ; no more level-up moves

MagikarpEvosAttacks:
	dbbw EVOLVE_LEVEL, 20, GYARADOS
	db 0 ; no more evolutions
	dbw 1, SPLASH
	dbw 15, TACKLE
	dbw 30, FLAIL
	db 0 ; no more level-up moves

GyaradosEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, THRASH
	dbw 1, TACKLE
	dbw 20, BITE
	dbw 25, DRAGON_RAGE
	dbw 30, LEER
	dbw 35, TWISTER
	dbw 40, HYDRO_PUMP
	dbw 45, RAIN_DANCE
	dbw 50, HYPER_BEAM
	db 0 ; no more level-up moves

LaprasEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, WATER_GUN
	dbw 1, GROWL
	dbw 1, SING
	dbw 8, MIST
	dbw 15, BODY_SLAM
	dbw 20, HAIL
	dbw 22, CONFUSE_RAY
	dbw 29, PERISH_SONG
	dbw 36, ICE_BEAM
	dbw 43, RAIN_DANCE
	dbw 50, SAFEGUARD
	dbw 57, HYDRO_PUMP
	db 0 ; no more level-up moves

DittoEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TRANSFORM
	db 0 ; no more level-up moves

EeveeEvosAttacks:
	dbbw EVOLVE_ITEM, THUNDERSTONE, JOLTEON
	dbbw EVOLVE_ITEM, WATER_STONE, VAPOREON
	dbbw EVOLVE_ITEM, FIRE_STONE, FLAREON
	dbbw EVOLVE_ITEM, SUN_STONE, ESPEON
	dbbw EVOLVE_ITEM, MOON_STONE, UMBREON
	dbbw EVOLVE_ITEM, LEAF_STONE, LEAFEON
	dbbw EVOLVE_ITEM, NEVERMELTICE, GLACEON
	dbbw EVOLVE_ITEM, POLKADOT_BOW, SYLVEON
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, TAIL_WHIP
	dbw 8, SAND_ATTACK
	dbw 16, GROWL
	dbw 23, QUICK_ATTACK
	dbw 30, BITE
	dbw 36, BATON_PASS
	dbw 36, FOCUS_ENERGY
	dbw 42, TAKE_DOWN
	db 0 ; no more level-up moves

VaporeonEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, TAIL_WHIP
	dbw 8, SAND_ATTACK
	dbw 16, WATER_GUN
	dbw 23, QUICK_ATTACK
	dbw 30, BITE
	dbw 36, AURORA_BEAM
	dbw 42, HAZE
	dbw 42, MIST
	dbw 47, ACID_ARMOR
	dbw 52, HYDRO_PUMP
	db 0 ; no more level-up moves

JolteonEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, TAIL_WHIP
	dbw 8, SAND_ATTACK
	dbw 16, THUNDERSHOCK
	dbw 20, ELECTRIC_TERRAIN
	dbw 23, QUICK_ATTACK
	dbw 30, DOUBLE_KICK
	dbw 36, PIN_MISSILE
	dbw 42, THUNDER_WAVE
	dbw 47, AGILITY
	dbw 52, THUNDER
	db 0 ; no more level-up moves

FlareonEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, TAIL_WHIP
	dbw 8, SAND_ATTACK
	dbw 16, EMBER
	dbw 23, QUICK_ATTACK
	dbw 30, BITE
	dbw 36, FIRE_SPIN
	dbw 42, SMOG
	dbw 47, LEER
	dbw 48, RAGE
	dbw 52, FLAMETHROWER
	db 0 ; no more level-up moves

PorygonEvosAttacks:
	dbbw EVOLVE_ITEM, UP_GRADE, PORYGON2
	db 0 ; no more evolutions
	dbw 1, CONVERSION2
	dbw 1, TACKLE
	dbw 1, CONVERSION
	dbw 9, AGILITY
	dbw 12, PSYBEAM
	dbw 20, RECOVER
	dbw 24, SHARPEN
	dbw 32, LOCK_ON
	dbw 36, TRI_ATTACK
	dbw 44, ZAP_CANNON
	db 0 ; no more level-up moves

OmanyteEvosAttacks:
	dbbw EVOLVE_LEVEL, 40, OMASTAR
	db 0 ; no more evolutions
	dbw 1, CONSTRICT
	dbw 1, WITHDRAW
	dbw 13, BITE
	dbw 19, WATER_GUN
	dbw 31, LEER
	dbw 34, HORN_ATTACK
	dbw 37, PROTECT
	dbw 46, SPIKE_CANNON
	dbw 49, ANCIENTPOWER
	dbw 55, HYDRO_PUMP
	db 0 ; no more level-up moves

OmastarEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, CONSTRICT
	dbw 1, WITHDRAW
	dbw 1, BITE
	dbw 1, HORN_ATTACK
	dbw 13, BITE
	dbw 19, WATER_GUN
	dbw 31, LEER
	dbw 37, PROTECT
	dbw 40, SPIKE_CANNON
	dbw 54, ANCIENTPOWER
	dbw 65, HYDRO_PUMP
	db 0 ; no more level-up moves

KabutoEvosAttacks:
	dbbw EVOLVE_LEVEL, 40, KABUTOPS
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, HARDEN
	dbw 10, ABSORB
	dbw 19, LEER
	dbw 28, SAND_ATTACK
	dbw 37, ENDURE
	dbw 39, SLASH
	dbw 46, MEGA_DRAIN
	dbw 49, HYDRO_PUMP
	dbw 55, ANCIENTPOWER
	db 0 ; no more level-up moves

KabutopsEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, HARDEN
	dbw 1, ABSORB
	dbw 10, ABSORB
	dbw 19, LEER
	dbw 28, SAND_ATTACK
	dbw 37, ENDURE
	dbw 40, SLASH
	dbw 51, MEGA_DRAIN
	dbw 53, HYDRO_PUMP
	dbw 65, ANCIENTPOWER
	db 0 ; no more level-up moves

AerodactylEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, WING_ATTACK
	dbw 8, AGILITY
	dbw 15, BITE
	dbw 22, SUPERSONIC
	dbw 29, ANCIENTPOWER
	dbw 36, SCARY_FACE
	dbw 43, TAKE_DOWN
	dbw 50, HYPER_BEAM
	db 0 ; no more level-up moves

SnorlaxEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 8, AMNESIA
	dbw 15, DEFENSE_CURL
	dbw 22, BELLY_DRUM
	dbw 29, HEADBUTT
	dbw 36, SNORE
	dbw 36, REST
	dbw 41, HARDEN
	dbw 43, BODY_SLAM
	dbw 48, DOUBLE_EDGE
	dbw 50, ROLLOUT
	dbw 57, HYPER_BEAM
	db 0 ; no more level-up moves

ArticunoEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, GUST
	dbw 1, POWDER_SNOW
	dbw 1, PECK
	dbw 13, MIST
	dbw 20, HAIL
	dbw 25, AGILITY
	dbw 37, MIND_READER
	dbw 49, ICE_BEAM
	dbw 61, REFLECT
	dbw 73, BLIZZARD
	db 0 ; no more level-up moves

ZapdosEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, PECK
	dbw 1, THUNDERSHOCK
	dbw 13, THUNDER_WAVE
	dbw 20, ELECTRIC_TERRAIN
	dbw 25, AGILITY
	dbw 37, DETECT
	dbw 49, DRILL_PECK
	dbw 61, LIGHT_SCREEN
	dbw 73, THUNDER
	db 0 ; no more level-up moves

MoltresEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, WING_ATTACK
	dbw 1, EMBER
	dbw 1, PECK
	dbw 13, FIRE_SPIN
	dbw 25, AGILITY
	dbw 37, ENDURE
	dbw 49, FLAMETHROWER
	dbw 51, LEER
	dbw 61, SAFEGUARD
	dbw 73, SKY_ATTACK
	db 0 ; no more level-up moves

DratiniEvosAttacks:
	dbbw EVOLVE_LEVEL, 30, DRAGONAIR
	db 0 ; no more evolutions
	dbw 1, WRAP
	dbw 1, LEER
	dbw 8, THUNDER_WAVE
	dbw 15, TWISTER
	dbw 22, DRAGON_RAGE
	dbw 29, SLAM
	dbw 36, AGILITY
	dbw 43, SAFEGUARD
	dbw 50, OUTRAGE
	dbw 57, HYPER_BEAM
	db 0 ; no more level-up moves

DragonairEvosAttacks:
	dbbw EVOLVE_LEVEL, 55, DRAGONITE
	db 0 ; no more evolutions
	dbw 1, WRAP
	dbw 1, LEER
	dbw 1, THUNDER_WAVE
	dbw 1, TWISTER
	dbw 8, THUNDER_WAVE
	dbw 15, TWISTER
	dbw 22, DRAGON_RAGE
	dbw 29, SLAM
	dbw 38, AGILITY
	dbw 47, SAFEGUARD
	dbw 56, OUTRAGE
	dbw 65, HYPER_BEAM
	db 0 ; no more level-up moves

DragoniteEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, WRAP
	dbw 1, LEER
	dbw 1, THUNDER_WAVE
	dbw 1, TWISTER
	dbw 8, THUNDER_WAVE
	dbw 15, TWISTER
	dbw 22, DRAGON_RAGE
	dbw 29, SLAM
	dbw 38, AGILITY
	dbw 47, SAFEGUARD
	dbw 55, WING_ATTACK
	dbw 61, OUTRAGE
	dbw 75, HYPER_BEAM
	db 0 ; no more level-up moves

MewtwoEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, CONFUSION
	dbw 1, DISABLE
	dbw 11, BARRIER
	dbw 20, PSYCHIC_TERRAIN
	dbw 22, SWIFT
	dbw 33, PSYCH_UP
	dbw 44, FUTURE_SIGHT
	dbw 55, MIST
	dbw 66, PSYCHIC_M
	dbw 77, AMNESIA
	dbw 88, RECOVER
	dbw 99, SAFEGUARD
	db 0 ; no more level-up moves

MewEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, POUND
	dbw 10, TRANSFORM
	dbw 20, MEGA_PUNCH
	dbw 20, PSYCHIC_TERRAIN
	dbw 30, METRONOME
	dbw 40, PSYCHIC_M
	dbw 50, ANCIENTPOWER
	db 0 ; no more level-up moves

ChikoritaEvosAttacks:
	dbbw EVOLVE_LEVEL, 16, BAYLEEF
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 8, RAZOR_LEAF
	dbw 12, REFLECT
	dbw 15, POISONPOWDER
	dbw 20, GRASSY_TERRAIN
	dbw 22, SYNTHESIS
	dbw 29, BODY_SLAM
	dbw 36, LIGHT_SCREEN
	dbw 43, SAFEGUARD
	dbw 50, SOLARBEAM
	db 0 ; no more level-up moves

BayleefEvosAttacks:
	dbbw EVOLVE_LEVEL, 32, MEGANIUM
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 1, RAZOR_LEAF
	dbw 1, REFLECT
	dbw 8, RAZOR_LEAF
	dbw 12, REFLECT
	dbw 15, POISONPOWDER
	dbw 20, GRASSY_TERRAIN
	dbw 23, SYNTHESIS
	dbw 31, BODY_SLAM
	dbw 39, LIGHT_SCREEN
	dbw 47, SAFEGUARD
	dbw 55, SOLARBEAM
	db 0 ; no more level-up moves

MeganiumEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 1, RAZOR_LEAF
	dbw 1, REFLECT
	dbw 8, RAZOR_LEAF
	dbw 12, REFLECT
	dbw 15, POISONPOWDER
	dbw 20, GRASSY_TERRAIN
	dbw 23, SYNTHESIS
	dbw 31, BODY_SLAM
	dbw 41, LIGHT_SCREEN
	dbw 51, SAFEGUARD
	dbw 61, SOLARBEAM
	db 0 ; no more level-up moves

CyndaquilEvosAttacks:
	dbbw EVOLVE_LEVEL, 14, QUILAVA
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, LEER
	dbw 6, SMOKESCREEN
	dbw 12, EMBER
	dbw 19, QUICK_ATTACK
	dbw 27, FLAME_WHEEL
	dbw 36, SWIFT
	dbw 46, FLAMETHROWER
	db 0 ; no more level-up moves

QuilavaEvosAttacks:
	dbbw EVOLVE_LEVEL, 36, TYPHLOSION
	dbbw EVOLVE_ITEM, SPELL_TAG, TYPHLOSION_H
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, LEER
	dbw 1, SMOKESCREEN
	dbw 6, SMOKESCREEN
	dbw 12, EMBER
	dbw 21, QUICK_ATTACK
	dbw 31, FLAME_WHEEL
	dbw 42, SWIFT
	dbw 54, FLAMETHROWER
	db 0 ; no more level-up moves

TyphlosionEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, LEER
	dbw 1, SMOKESCREEN
	dbw 1, EMBER
	dbw 6, SMOKESCREEN
	dbw 12, EMBER
	dbw 21, QUICK_ATTACK
	dbw 31, FLAME_WHEEL
	dbw 45, SWIFT
	dbw 60, FLAMETHROWER
	db 0 ; no more level-up moves

TotodileEvosAttacks:
	dbbw EVOLVE_LEVEL, 18, CROCONAW
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 7, RAGE
	dbw 13, WATER_GUN
	dbw 20, BITE
	dbw 27, SCARY_FACE
	dbw 35, SLASH
	dbw 43, SCREECH
	dbw 52, HYDRO_PUMP
	db 0 ; no more level-up moves

CroconawEvosAttacks:
	dbbw EVOLVE_LEVEL, 30, FERALIGATR
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 1, RAGE
	dbw 7, RAGE
	dbw 13, WATER_GUN
	dbw 21, BITE
	dbw 28, SCARY_FACE
	dbw 37, SLASH
	dbw 45, SCREECH
	dbw 55, HYDRO_PUMP
	db 0 ; no more level-up moves

FeraligatrEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 1, RAGE
	dbw 1, WATER_GUN
	dbw 7, RAGE
	dbw 13, WATER_GUN
	dbw 21, BITE
	dbw 28, SCARY_FACE
	dbw 38, SLASH
	dbw 47, SCREECH
	dbw 58, HYDRO_PUMP
	db 0 ; no more level-up moves

SentretEvosAttacks:
	dbbw EVOLVE_LEVEL, 15, FURRET
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 5, DEFENSE_CURL
	dbw 11, QUICK_ATTACK
	dbw 17, FURY_SWIPES
	dbw 25, SLAM
	dbw 33, REST
	dbw 41, AMNESIA
	db 0 ; no more level-up moves

FurretEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, DEFENSE_CURL
	dbw 1, QUICK_ATTACK
	dbw 5, DEFENSE_CURL
	dbw 11, QUICK_ATTACK
	dbw 18, FURY_SWIPES
	dbw 28, SLAM
	dbw 38, REST
	dbw 48, AMNESIA
	db 0 ; no more level-up moves

HoothootEvosAttacks:
	dbbw EVOLVE_LEVEL, 20, NOCTOWL
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 6, FORESIGHT
	dbw 11, PECK
	dbw 16, HYPNOSIS
	dbw 22, REFLECT
	dbw 28, TAKE_DOWN
	dbw 34, CONFUSION
	dbw 48, DREAM_EATER
	db 0 ; no more level-up moves

NoctowlEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 1, FORESIGHT
	dbw 1, PECK
	dbw 6, FORESIGHT
	dbw 11, PECK
	dbw 16, HYPNOSIS
	dbw 25, REFLECT
	dbw 33, TAKE_DOWN
	dbw 41, CONFUSION
	dbw 57, DREAM_EATER
	db 0 ; no more level-up moves

LedybaEvosAttacks:
	dbbw EVOLVE_LEVEL, 18, LEDIAN
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 8, SUPERSONIC
	dbw 15, COMET_PUNCH
	dbw 22, LIGHT_SCREEN
	dbw 22, REFLECT
	dbw 22, SAFEGUARD
	dbw 29, BATON_PASS
	dbw 36, SWIFT
	dbw 43, AGILITY
	dbw 50, DOUBLE_EDGE
	db 0 ; no more level-up moves

LedianEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, SUPERSONIC
	dbw 8, SUPERSONIC
	dbw 15, COMET_PUNCH
	dbw 24, LIGHT_SCREEN
	dbw 24, REFLECT
	dbw 24, SAFEGUARD
	dbw 33, BATON_PASS
	dbw 42, SWIFT
	dbw 51, AGILITY
	dbw 60, DOUBLE_EDGE
	db 0 ; no more level-up moves

SpinarakEvosAttacks:
	dbbw EVOLVE_LEVEL, 22, ARIADOS
	db 0 ; no more evolutions
	dbw 1, POISON_STING
	dbw 1, STRING_SHOT
	dbw 6, SCARY_FACE
	dbw 11, CONSTRICT
	dbw 17, NIGHT_SHADE
	dbw 23, LEECH_LIFE
	dbw 30, FURY_SWIPES
	dbw 37, SPIDER_WEB
	dbw 45, AGILITY
	dbw 45, SCREECH
	dbw 53, PSYCHIC_M
	db 0 ; no more level-up moves

AriadosEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, POISON_STING
	dbw 1, STRING_SHOT
	dbw 1, SCARY_FACE
	dbw 1, CONSTRICT
	dbw 6, SCARY_FACE
	dbw 11, CONSTRICT
	dbw 17, NIGHT_SHADE
	dbw 25, LEECH_LIFE
	dbw 34, FURY_SWIPES
	dbw 43, SPIDER_WEB
	dbw 53, AGILITY
	dbw 53, SCREECH
	dbw 63, PSYCHIC_M
	db 0 ; no more level-up moves

CrobatEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SCREECH
	dbw 1, LEECH_LIFE
	dbw 1, SUPERSONIC
	dbw 6, SUPERSONIC
	dbw 12, BITE
	dbw 19, CONFUSE_RAY
	dbw 30, WING_ATTACK
	dbw 42, MEAN_LOOK
	dbw 55, HAZE
	db 0 ; no more level-up moves

ChinchouEvosAttacks:
	dbbw EVOLVE_LEVEL, 27, LANTURN
	db 0 ; no more evolutions
	dbw 1, BUBBLE
	dbw 1, THUNDER_WAVE
	dbw 5, SUPERSONIC
	dbw 13, FLAIL
	dbw 17, WATER_GUN
	dbw 20, ELECTRIC_TERRAIN
	dbw 25, SPARK
	dbw 29, CONFUSE_RAY
	dbw 37, TAKE_DOWN
	dbw 41, HYDRO_PUMP
	db 0 ; no more level-up moves

LanturnEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, BUBBLE
	dbw 1, THUNDER_WAVE
	dbw 1, SUPERSONIC
	dbw 5, SUPERSONIC
	dbw 13, FLAIL
	dbw 17, WATER_GUN
	dbw 20, ELECTRIC_TERRAIN
	dbw 25, SPARK
	dbw 33, CONFUSE_RAY
	dbw 45, TAKE_DOWN
	dbw 53, HYDRO_PUMP
	db 0 ; no more level-up moves

PichuEvosAttacks:
	dbbw EVOLVE_LEVEL, 12, PIKACHU
	db 0 ; no more evolutions
	dbw 1, THUNDERSHOCK
	dbw 1, CHARM
	dbw 6, TAIL_WHIP
	dbw 8, THUNDER_WAVE
	dbw 11, SWEET_KISS
	dbw 20, ELECTRIC_TERRAIN
	db 0 ; no more level-up moves

CleffaEvosAttacks:
	dbbw EVOLVE_LEVEL, 12, CLEFAIRY
	db 0 ; no more evolutions
	dbw 1, POUND
	dbw 1, CHARM
	dbw 4, ENCORE
	dbw 8, SING
	dbw 10, DRAINING_KISS
	dbw 13, SWEET_KISS
	dbw 20, MISTY_TERRAIN
	db 0 ; no more level-up moves

IgglybuffEvosAttacks:
	dbbw EVOLVE_LEVEL, 12, JIGGLYPUFF
	db 0 ; no more evolutions
	dbw 1, SING
	dbw 1, CHARM
	dbw 4, DEFENSE_CURL
	dbw 9, POUND
	dbw 11, DRAINING_KISS
	dbw 14, SWEET_KISS
	dbw 20, MISTY_TERRAIN
	db 0 ; no more level-up moves

TogepiEvosAttacks:
	dbbw EVOLVE_LEVEL, 20, TOGETIC
	db 0 ; no more evolutions
	dbw 1, GROWL
	dbw 1, CHARM
	dbw 7, METRONOME
	dbw 12, DRAINING_KISS
	dbw 18, SWEET_KISS
	dbw 20, MISTY_TERRAIN
	dbw 25, ENCORE
	dbw 31, SAFEGUARD
	dbw 38, DOUBLE_EDGE
	db 0 ; no more level-up moves

TogeticEvosAttacks:
	dbbw EVOLVE_ITEM, SUN_STONE, TOGEKISS
	db 0 ; no more evolutions
	dbw 1, GROWL
	dbw 1, CHARM
	dbw 7, METRONOME
	dbw 12, DRAINING_KISS
	dbw 18, SWEET_KISS
	dbw 20, MISTY_TERRAIN
	dbw 25, ENCORE
	dbw 31, SAFEGUARD
	dbw 34, MOONBLAST
	dbw 38, DOUBLE_EDGE
	db 0 ; no more level-up moves

NatuEvosAttacks:
	dbbw EVOLVE_LEVEL, 25, XATU
	db 0 ; no more evolutions
	dbw 1, PECK
	dbw 1, LEER
	dbw 10, NIGHT_SHADE
	dbw 20, TELEPORT
	dbw 20, PSYCHIC_TERRAIN
	dbw 30, FUTURE_SIGHT
	dbw 40, CONFUSE_RAY
	dbw 50, PSYCHIC_M
	db 0 ; no more level-up moves

XatuEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, PECK
	dbw 1, LEER
	dbw 1, NIGHT_SHADE
	dbw 10, NIGHT_SHADE
	dbw 20, TELEPORT
	dbw 20, PSYCHIC_TERRAIN
	dbw 35, FUTURE_SIGHT
	dbw 50, CONFUSE_RAY
	dbw 65, PSYCHIC_M
	db 0 ; no more level-up moves

MareepEvosAttacks:
	dbbw EVOLVE_LEVEL, 15, FLAAFFY
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 9, THUNDERSHOCK
	dbw 16, THUNDER_WAVE
	dbw 20, ELECTRIC_TERRAIN
	dbw 23, COTTON_SPORE
	dbw 30, LIGHT_SCREEN
	dbw 37, THUNDER
	db 0 ; no more level-up moves

FlaaffyEvosAttacks:
	dbbw EVOLVE_LEVEL, 30, AMPHAROS
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 1, THUNDERSHOCK
	dbw 9, THUNDERSHOCK
	dbw 18, THUNDER_WAVE
	dbw 20, ELECTRIC_TERRAIN
	dbw 27, COTTON_SPORE
	dbw 36, LIGHT_SCREEN
	dbw 45, THUNDER
	db 0 ; no more level-up moves

AmpharosEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 1, THUNDERSHOCK
	dbw 1, THUNDER_WAVE
	dbw 9, THUNDERSHOCK
	dbw 18, THUNDER_WAVE
	dbw 20, ELECTRIC_TERRAIN
	dbw 27, COTTON_SPORE
	dbw 30, THUNDERPUNCH
	dbw 42, LIGHT_SCREEN
	dbw 57, THUNDER
	db 0 ; no more level-up moves

BellossomEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, ABSORB
	dbw 1, SWEET_SCENT
	dbw 1, STUN_SPORE
	dbw 1, PETAL_DANCE
	dbw 20, GRASSY_TERRAIN
	dbw 55, SOLARBEAM
	db 0 ; no more level-up moves

MarillEvosAttacks:
	dbbw EVOLVE_LEVEL, 18, AZUMARILL
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 3, DEFENSE_CURL
	dbw 6, TAIL_WHIP
	dbw 10, WATER_GUN
	dbw 15, ROLLOUT
	dbw 20, MISTY_TERRAIN
	dbw 21, BUBBLEBEAM
	dbw 25, PLAY_ROUGH
	dbw 28, DOUBLE_EDGE
	dbw 36, RAIN_DANCE
	db 0 ; no more level-up moves

AzumarillEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL
	dbw 1, TAIL_WHIP
	dbw 1, WATER_GUN
	dbw 3, DEFENSE_CURL
	dbw 6, TAIL_WHIP
	dbw 10, WATER_GUN
	dbw 15, ROLLOUT
	dbw 20, MISTY_TERRAIN
	dbw 25, BUBBLEBEAM
	dbw 30, PLAY_ROUGH
	dbw 36, DOUBLE_EDGE
	dbw 48, RAIN_DANCE
	db 0 ; no more level-up moves

SudowoodoEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, ROCK_THROW
	dbw 1, MIMIC
	dbw 10, FLAIL
	dbw 19, LOW_KICK
	dbw 28, ROCK_SLIDE
	dbw 37, FAINT_ATTACK
	dbw 46, SLAM
	db 0 ; no more level-up moves

PolitoedEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, WATER_GUN
	dbw 1, HYPNOSIS
	dbw 1, DOUBLESLAP
	dbw 1, PERISH_SONG
	dbw 35, PERISH_SONG
	dbw 51, SWAGGER
	db 0 ; no more level-up moves

HoppipEvosAttacks:
	dbbw EVOLVE_LEVEL, 18, SKIPLOOM
	db 0 ; no more evolutions
	dbw 1, SPLASH
	dbw 5, SYNTHESIS
	dbw 5, TAIL_WHIP
	dbw 10, TACKLE
	dbw 13, POISONPOWDER
	dbw 15, STUN_SPORE
	dbw 17, SLEEP_POWDER
	dbw 20, LEECH_SEED
	dbw 20, GRASSY_TERRAIN
	dbw 25, COTTON_SPORE
	dbw 30, MEGA_DRAIN
	db 0 ; no more level-up moves

SkiploomEvosAttacks:
	dbbw EVOLVE_LEVEL, 27, JUMPLUFF
	db 0 ; no more evolutions
	dbw 1, SPLASH
	dbw 1, SYNTHESIS
	dbw 1, TAIL_WHIP
	dbw 1, TACKLE
	dbw 5, SYNTHESIS
	dbw 5, TAIL_WHIP
	dbw 10, TACKLE
	dbw 13, POISONPOWDER
	dbw 15, STUN_SPORE
	dbw 17, SLEEP_POWDER
	dbw 20, GRASSY_TERRAIN
	dbw 22, LEECH_SEED
	dbw 29, COTTON_SPORE
	dbw 36, MEGA_DRAIN
	db 0 ; no more level-up moves

JumpluffEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SPLASH
	dbw 1, SYNTHESIS
	dbw 1, TAIL_WHIP
	dbw 1, TACKLE
	dbw 5, SYNTHESIS
	dbw 5, TAIL_WHIP
	dbw 10, TACKLE
	dbw 13, POISONPOWDER
	dbw 15, STUN_SPORE
	dbw 17, SLEEP_POWDER
	dbw 20, GRASSY_TERRAIN
	dbw 22, LEECH_SEED
	dbw 33, COTTON_SPORE
	dbw 44, MEGA_DRAIN
	db 0 ; no more level-up moves

AipomEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, TAIL_WHIP
	dbw 6, SAND_ATTACK
	dbw 12, BATON_PASS
	dbw 19, FURY_SWIPES
	dbw 27, SWIFT
	dbw 36, SCREECH
	dbw 46, AGILITY
	db 0 ; no more level-up moves

SunkernEvosAttacks:
	dbbw EVOLVE_ITEM, SUN_STONE, SUNFLORA
	db 0 ; no more evolutions
	dbw 1, ABSORB
	dbw 4, GROWTH
	dbw 10, MEGA_DRAIN
	dbw 19, SUNNY_DAY
	dbw 20, GRASSY_TERRAIN
	dbw 31, SYNTHESIS
	dbw 46, GIGA_DRAIN
	db 0 ; no more level-up moves

SunfloraEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, ABSORB
	dbw 1, POUND
	dbw 4, GROWTH
	dbw 10, RAZOR_LEAF
	dbw 19, SUNNY_DAY
	dbw 20, GRASSY_TERRAIN
	dbw 31, PETAL_DANCE
	dbw 46, SOLARBEAM
	db 0 ; no more level-up moves

YanmaEvosAttacks:
	dbbw EVOLVE_LEVEL, 33, YANMEGA
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, FORESIGHT
	dbw 7, QUICK_ATTACK
	dbw 13, DOUBLE_TEAM
	dbw 19, SONICBOOM
	dbw 25, DETECT
	dbw 31, SUPERSONIC
	dbw 37, WING_ATTACK
	dbw 37, SWIFT
	dbw 43, SCREECH
	db 0 ; no more level-up moves

WooperEvosAttacks:
	dbbw EVOLVE_LEVEL, 20, QUAGSIRE
	db 0 ; no more evolutions
	dbw 1, WATER_GUN
	dbw 1, TAIL_WHIP
	dbw 11, SLAM
	dbw 21, AMNESIA
	dbw 31, EARTHQUAKE
	dbw 41, RAIN_DANCE
	dbw 51, MIST
	dbw 51, HAZE
	db 0 ; no more level-up moves

QuagsireEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, WATER_GUN
	dbw 1, TAIL_WHIP
	dbw 11, SLAM
	dbw 23, AMNESIA
	dbw 35, EARTHQUAKE
	dbw 47, RAIN_DANCE
	dbw 59, MIST
	dbw 59, HAZE
	db 0 ; no more level-up moves

EspeonEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, TAIL_WHIP
	dbw 8, SAND_ATTACK
	dbw 16, CONFUSION
	dbw 20, PSYCHIC_TERRAIN
	dbw 23, QUICK_ATTACK
	dbw 30, SWIFT
	dbw 36, PSYBEAM
	dbw 42, PSYCH_UP
	dbw 47, PSYCHIC_M
	dbw 52, MORNING_SUN
	db 0 ; no more level-up moves

UmbreonEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, TAIL_WHIP
	dbw 8, SAND_ATTACK
	dbw 16, PURSUIT
	dbw 23, QUICK_ATTACK
	dbw 30, CONFUSE_RAY
	dbw 36, FAINT_ATTACK
	dbw 42, MEAN_LOOK
	dbw 47, SCREECH
	dbw 52, MOONLIGHT
	db 0 ; no more level-up moves

MurkrowEvosAttacks:
	dbbw EVOLVE_ITEM, MOON_STONE, HONCHKROW
	db 0 ; no more evolutions
	dbw 1, PECK
	dbw 11, PURSUIT
	dbw 16, HAZE
	dbw 26, NIGHT_SHADE
	dbw 31, FAINT_ATTACK
	dbw 41, MEAN_LOOK
	db 0 ; no more level-up moves

SlowkingEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, CURSE
	dbw 1, TACKLE
	dbw 6, GROWL
	dbw 15, WATER_GUN
	dbw 20, CONFUSION
	dbw 20, PSYCHIC_TERRAIN
	dbw 29, DISABLE
	dbw 34, HEADBUTT
	dbw 43, SWAGGER
	dbw 48, PSYCHIC_M
	db 0 ; no more level-up moves

MisdreavusEvosAttacks:
	dbbw EVOLVE_ITEM, MOON_STONE, MISMAGIUS
	db 0 ; no more evolutions
	dbw 1, GROWL
	dbw 1, PSYWAVE
	dbw 6, SPITE
	dbw 12, CONFUSE_RAY
	dbw 19, MEAN_LOOK
	dbw 27, PSYBEAM
	dbw 36, PAIN_SPLIT
	dbw 46, PERISH_SONG
	db 0 ; no more level-up moves

UnownEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, HIDDEN_POWER
	dbw 20, PSYCHIC_TERRAIN
	db 0 ; no more level-up moves

WobbuffetEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, COUNTER
	dbw 1, MIRROR_COAT
	dbw 1, SAFEGUARD
	dbw 1, DESTINY_BOND
	db 0 ; no more level-up moves

GirafarigEvosAttacks:
	dbbw EVOLVE_LEVEL, 33, FARIGIRAF
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 1, CONFUSION
	dbw 1, STOMP
	dbw 7, CONFUSION
	dbw 13, STOMP
	dbw 20, AGILITY
	dbw 20, PSYCHIC_TERRAIN
	dbw 30, BATON_PASS
	dbw 41, PSYBEAM
	dbw 54, CRUNCH
	db 0 ; no more level-up moves

PinecoEvosAttacks:
	dbbw EVOLVE_LEVEL, 31, FORRETRESS
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, PROTECT
	dbw 8, SELFDESTRUCT
	dbw 15, TAKE_DOWN
	dbw 22, RAPID_SPIN
	dbw 29, BIDE
	dbw 36, EXPLOSION
	dbw 43, SPIKES
	dbw 50, DOUBLE_EDGE
	db 0 ; no more level-up moves

ForretressEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, PROTECT
	dbw 1, SELFDESTRUCT
	dbw 8, SELFDESTRUCT
	dbw 15, TAKE_DOWN
	dbw 22, RAPID_SPIN
	dbw 29, BIDE
	dbw 39, EXPLOSION
	dbw 49, SPIKES
	dbw 59, DOUBLE_EDGE
	db 0 ; no more level-up moves

DunsparceEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, RAGE
	dbw 5, DEFENSE_CURL
	dbw 13, GLARE
	dbw 18, SPITE
	dbw 26, PURSUIT
	dbw 30, SCREECH
	dbw 38, TAKE_DOWN
	db 0 ; no more level-up moves

GligarEvosAttacks:
	dbbw EVOLVE_ITEM, MOON_STONE, GLISCOR
	db 0 ; no more evolutions
	dbw 1, POISON_STING
	dbw 6, SAND_ATTACK
	dbw 13, HARDEN
	dbw 20, QUICK_ATTACK
	dbw 28, FAINT_ATTACK
	dbw 36, SLASH
	dbw 44, SCREECH
	dbw 52, GUILLOTINE
	db 0 ; no more level-up moves

SteelixEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, SCREECH
	dbw 10, BIND
	dbw 14, ROCK_THROW
	dbw 23, HARDEN
	dbw 27, RAGE
	dbw 36, SANDSTORM
	dbw 40, SLAM
	dbw 49, CRUNCH
	db 0 ; no more level-up moves

SnubbullEvosAttacks:
	dbbw EVOLVE_LEVEL, 23, GRANBULL
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, SCARY_FACE
	dbw 4, TAIL_WHIP
	dbw 8, CHARM
	dbw 13, BITE
	dbw 19, LICK
	dbw 20, MISTY_TERRAIN
	dbw 23, PLAY_ROUGH
	dbw 26, ROAR
	dbw 34, RAGE
	dbw 43, TAKE_DOWN
	db 0 ; no more level-up moves

GranbullEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, SCARY_FACE
	dbw 4, TAIL_WHIP
	dbw 8, CHARM
	dbw 13, BITE
	dbw 19, LICK
	dbw 20, MISTY_TERRAIN
	dbw 23, PLAY_ROUGH
	dbw 28, ROAR
	dbw 38, RAGE
	dbw 51, TAKE_DOWN
	db 0 ; no more level-up moves

QwilfishEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SPIKES
	dbw 1, TACKLE
	dbw 1, POISON_STING
	dbw 10, HARDEN
	dbw 10, MINIMIZE
	dbw 19, WATER_GUN
	dbw 28, PIN_MISSILE
	dbw 37, TAKE_DOWN
	dbw 46, HYDRO_PUMP
	db 0 ; no more level-up moves

ScizorEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, QUICK_ATTACK
	dbw 1, LEER
	dbw 6, FOCUS_ENERGY
	dbw 12, PURSUIT
	dbw 18, FALSE_SWIPE
	dbw 24, AGILITY
	dbw 30, METAL_CLAW
	dbw 36, SLASH
	dbw 42, SWORDS_DANCE
	dbw 48, DOUBLE_TEAM
	db 0 ; no more level-up moves

ShuckleEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, CONSTRICT
	dbw 1, WITHDRAW
	dbw 9, WRAP
	dbw 14, ENCORE
	dbw 23, SAFEGUARD
	dbw 28, BIDE
	dbw 37, REST
	db 0 ; no more level-up moves

HeracrossEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, LEER
	dbw 6, HORN_ATTACK
	dbw 12, ENDURE
	dbw 19, FURY_ATTACK
	dbw 27, COUNTER
	dbw 35, TAKE_DOWN
	dbw 44, REVERSAL
	dbw 54, MEGAHORN
	db 0 ; no more level-up moves

SneaselEvosAttacks:
	dbbw EVOLVE_ITEM, MOON_STONE, WEAVILE
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 9, QUICK_ATTACK
	dbw 17, SCREECH
	dbw 20, HAIL
	dbw 25, FAINT_ATTACK
	dbw 33, FURY_SWIPES
	dbw 41, AGILITY
	dbw 49, SLASH
	dbw 57, BEAT_UP
	dbw 65, METAL_CLAW
	db 0 ; no more level-up moves

TeddiursaEvosAttacks:
	dbbw EVOLVE_LEVEL, 30, URSARING
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 8, LICK
	dbw 15, FURY_SWIPES
	dbw 22, FAINT_ATTACK
	dbw 29, REST
	dbw 36, SLASH
	dbw 43, SNORE
	dbw 50, THRASH
	db 0 ; no more level-up moves

UrsaringEvosAttacks:
	dbbw EVOLVE_ITEM, MOON_STONE, URSALUNA
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 1, LICK
	dbw 1, FURY_SWIPES
	dbw 8, LICK
	dbw 15, FURY_SWIPES
	dbw 22, FAINT_ATTACK
	dbw 29, REST
	dbw 39, SLASH
	dbw 49, SNORE
	dbw 59, THRASH
	db 0 ; no more level-up moves

SlugmaEvosAttacks:
	dbbw EVOLVE_LEVEL, 38, MAGCARGO
	db 0 ; no more evolutions
	dbw 1, SMOG
	dbw 8, EMBER
	dbw 15, ROCK_THROW
	dbw 22, HARDEN
	dbw 29, AMNESIA
	dbw 36, FLAMETHROWER
	dbw 43, ROCK_SLIDE
	dbw 50, BODY_SLAM
	db 0 ; no more level-up moves

MagcargoEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SMOG
	dbw 1, EMBER
	dbw 1, ROCK_THROW
	dbw 8, EMBER
	dbw 15, ROCK_THROW
	dbw 22, HARDEN
	dbw 29, AMNESIA
	dbw 36, FLAMETHROWER
	dbw 48, ROCK_SLIDE
	dbw 60, BODY_SLAM
	db 0 ; no more level-up moves

SwinubEvosAttacks:
	dbbw EVOLVE_LEVEL, 33, PILOSWINE
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 10, POWDER_SNOW
	dbw 19, ENDURE
	dbw 20, HAIL
	dbw 28, TAKE_DOWN
	dbw 37, MIST
	dbw 46, BLIZZARD
	dbw 55, AMNESIA
	db 0 ; no more level-up moves

PiloswineEvosAttacks:
	dbbw EVOLVE_LEVEL, 40, MAMOSWINE
	db 0 ; no more evolutions
	dbw 1, HORN_ATTACK
	dbw 1, POWDER_SNOW
	dbw 1, ENDURE
	dbw 10, POWDER_SNOW
	dbw 19, ENDURE
	dbw 20, HAIL
	dbw 28, TAKE_DOWN
	dbw 33, FURY_ATTACK
	dbw 42, MIST
	dbw 56, BLIZZARD
	dbw 70, AMNESIA
	db 0 ; no more level-up moves

CorsolaEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 7, HARDEN
	dbw 13, BUBBLE
	dbw 19, RECOVER
	dbw 25, BUBBLEBEAM
	dbw 31, SPIKE_CANNON
	dbw 37, MIRROR_COAT
	dbw 43, ANCIENTPOWER
	db 0 ; no more level-up moves

RemoraidEvosAttacks:
	dbbw EVOLVE_LEVEL, 25, OCTILLERY
	db 0 ; no more evolutions
	dbw 1, WATER_GUN
	dbw 11, LOCK_ON
	dbw 22, PSYBEAM
	dbw 22, AURORA_BEAM
	dbw 22, BUBBLEBEAM
	dbw 33, FOCUS_ENERGY
	dbw 44, ICE_BEAM
	dbw 55, HYPER_BEAM
	db 0 ; no more level-up moves

OctilleryEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, WATER_GUN
	dbw 11, CONSTRICT
	dbw 22, PSYBEAM
	dbw 22, AURORA_BEAM
	dbw 22, BUBBLEBEAM
	dbw 25, OCTAZOOKA
	dbw 38, FOCUS_ENERGY
	dbw 54, ICE_BEAM
	dbw 70, HYPER_BEAM
	db 0 ; no more level-up moves

DelibirdEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, PRESENT
	dbw 20, HAIL
	db 0 ; no more level-up moves

MantineEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, BUBBLE
	dbw 10, SUPERSONIC
	dbw 18, BUBBLEBEAM
	dbw 25, TAKE_DOWN
	dbw 32, AGILITY
	dbw 40, WING_ATTACK
	dbw 49, CONFUSE_RAY
	db 0 ; no more level-up moves

SkarmoryEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, LEER
	dbw 1, PECK
	dbw 13, SAND_ATTACK
	dbw 19, SWIFT
	dbw 25, AGILITY
	dbw 37, FURY_ATTACK
	dbw 49, STEEL_WING
	db 0 ; no more level-up moves

HoundourEvosAttacks:
	dbbw EVOLVE_LEVEL, 24, HOUNDOOM
	db 0 ; no more evolutions
	dbw 1, LEER
	dbw 1, EMBER
	dbw 7, ROAR
	dbw 13, SMOG
	dbw 20, BITE
	dbw 27, FAINT_ATTACK
	dbw 35, FLAMETHROWER
	dbw 43, CRUNCH
	db 0 ; no more level-up moves

HoundoomEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, LEER
	dbw 1, EMBER
	dbw 7, ROAR
	dbw 13, SMOG
	dbw 20, BITE
	dbw 30, FAINT_ATTACK
	dbw 41, FLAMETHROWER
	dbw 52, CRUNCH
	db 0 ; no more level-up moves

KingdraEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, BUBBLE
	dbw 1, SMOKESCREEN
	dbw 1, LEER
	dbw 1, WATER_GUN
	dbw 8, SMOKESCREEN
	dbw 15, LEER
	dbw 22, WATER_GUN
	dbw 29, TWISTER
	dbw 40, AGILITY
	dbw 51, HYDRO_PUMP
	db 0 ; no more level-up moves

PhanpyEvosAttacks:
	dbbw EVOLVE_LEVEL, 25, DONPHAN
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 9, DEFENSE_CURL
	dbw 17, FLAIL
	dbw 25, TAKE_DOWN
	dbw 33, ROLLOUT
	dbw 41, ENDURE
	dbw 49, DOUBLE_EDGE
	db 0 ; no more level-up moves

DonphanEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, HORN_ATTACK
	dbw 1, GROWL
	dbw 9, DEFENSE_CURL
	dbw 17, FLAIL
	dbw 25, FURY_ATTACK
	dbw 33, ROLLOUT
	dbw 41, RAPID_SPIN
	dbw 49, EARTHQUAKE
	db 0 ; no more level-up moves

Porygon2EvosAttacks:
	dbbw EVOLVE_ITEM, UP_GRADE, PORYGON_Z
	db 0 ; no more evolutions
	dbw 1, CONVERSION2
	dbw 1, TACKLE
	dbw 1, CONVERSION
	dbw 9, AGILITY
	dbw 12, PSYBEAM
	dbw 20, RECOVER
	dbw 24, DEFENSE_CURL
	dbw 32, LOCK_ON
	dbw 36, TRI_ATTACK
	dbw 44, ZAP_CANNON
	db 0 ; no more level-up moves

StantlerEvosAttacks:
	dbbw EVOLVE_LEVEL, 33, WYRDEER
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 8, LEER
	dbw 15, HYPNOSIS
	dbw 23, STOMP
	dbw 31, SAND_ATTACK
	dbw 40, TAKE_DOWN
	dbw 49, CONFUSE_RAY
	db 0 ; no more level-up moves

SmeargleEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SKETCH
	dbw 11, SKETCH
	dbw 21, SKETCH
	dbw 31, SKETCH
	dbw 41, SKETCH
	dbw 51, SKETCH
	dbw 61, SKETCH
	dbw 71, SKETCH
	dbw 81, SKETCH
	dbw 91, SKETCH
	db 0 ; no more level-up moves

TyrogueEvosAttacks:
	dbbbw EVOLVE_STAT, 20, ATK_LT_DEF, HITMONCHAN
	dbbbw EVOLVE_STAT, 20, ATK_GT_DEF, HITMONLEE
	dbbbw EVOLVE_STAT, 20, ATK_EQ_DEF, HITMONTOP
	db 0 ; no more evolutions
	dbw 1, TACKLE
	db 0 ; no more level-up moves

HitmontopEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, ROLLING_KICK
	dbw 7, FOCUS_ENERGY
	dbw 13, PURSUIT
	dbw 19, QUICK_ATTACK
	dbw 25, RAPID_SPIN
	dbw 31, COUNTER
	dbw 37, AGILITY
	dbw 43, DETECT
	dbw 49, TRIPLE_KICK
	db 0 ; no more level-up moves

SmoochumEvosAttacks:
	dbbw EVOLVE_LEVEL, 30, JYNX
	db 0 ; no more evolutions
	dbw 1, POUND
	dbw 1, LICK
	dbw 9, SWEET_KISS
	dbw 13, POWDER_SNOW
	dbw 20, HAIL
	dbw 20, PSYCHIC_TERRAIN
	dbw 21, CONFUSION
	dbw 25, SING
	dbw 33, MEAN_LOOK
	dbw 37, PSYCHIC_M
	dbw 45, PERISH_SONG
	dbw 49, BLIZZARD
	db 0 ; no more level-up moves

ElekidEvosAttacks:
	dbbw EVOLVE_LEVEL, 30, ELECTABUZZ
	db 0 ; no more evolutions
	dbw 1, QUICK_ATTACK
	dbw 1, LEER
	dbw 9, THUNDERPUNCH
	dbw 17, LIGHT_SCREEN
	dbw 20, ELECTRIC_TERRAIN
	dbw 25, SWIFT
	dbw 33, SCREECH
	dbw 41, THUNDERBOLT
	dbw 49, THUNDER
	db 0 ; no more level-up moves

MagbyEvosAttacks:
	dbbw EVOLVE_LEVEL, 30, MAGMAR
	db 0 ; no more evolutions
	dbw 1, EMBER
	dbw 7, LEER
	dbw 13, SMOG
	dbw 19, FIRE_PUNCH
	dbw 25, SMOKESCREEN
	dbw 31, SUNNY_DAY
	dbw 37, FLAMETHROWER
	dbw 43, CONFUSE_RAY
	dbw 49, FIRE_BLAST
	db 0 ; no more level-up moves

MiltankEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 4, GROWL
	dbw 8, DEFENSE_CURL
	dbw 13, STOMP
	dbw 19, MILK_DRINK
	dbw 26, BIDE
	dbw 34, ROLLOUT
	dbw 43, BODY_SLAM
	dbw 53, HEAL_BELL
	db 0 ; no more level-up moves

BlisseyEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, POUND
	dbw 4, GROWL
	dbw 7, TAIL_WHIP
	dbw 10, SOFTBOILED
	dbw 13, DOUBLESLAP
	dbw 18, MINIMIZE
	dbw 23, SING
	dbw 28, EGG_BOMB
	dbw 33, DEFENSE_CURL
	dbw 40, LIGHT_SCREEN
	dbw 47, DOUBLE_EDGE
	db 0 ; no more level-up moves

RaikouEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, BITE
	dbw 1, LEER
	dbw 11, THUNDERSHOCK
	dbw 20, ELECTRIC_TERRAIN
	dbw 21, ROAR
	dbw 31, QUICK_ATTACK
	dbw 41, SPARK
	dbw 51, REFLECT
	dbw 61, CRUNCH
	dbw 71, THUNDER
	db 0 ; no more level-up moves

EnteiEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, BITE
	dbw 1, LEER
	dbw 11, EMBER
	dbw 21, ROAR
	dbw 31, FIRE_SPIN
	dbw 41, STOMP
	dbw 51, FLAMETHROWER
	dbw 61, SWAGGER
	dbw 71, FIRE_BLAST
	db 0 ; no more level-up moves

SuicuneEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, BITE
	dbw 1, LEER
	dbw 11, BUBBLEBEAM
	dbw 11, WATER_GUN
	dbw 21, RAIN_DANCE
	dbw 21, ROAR
	dbw 31, GUST
	dbw 41, AURORA_BEAM
	dbw 51, MIST
	dbw 61, MIRROR_COAT
	dbw 71, HYDRO_PUMP
	db 0 ; no more level-up moves

LarvitarEvosAttacks:
	dbbw EVOLVE_LEVEL, 30, PUPITAR
	db 0 ; no more evolutions
	dbw 1, BITE
	dbw 1, LEER
	dbw 8, SANDSTORM
	dbw 15, SCREECH
	dbw 22, ROCK_SLIDE
	dbw 29, THRASH
	dbw 36, SCARY_FACE
	dbw 43, CRUNCH
	dbw 50, EARTHQUAKE
	dbw 57, HYPER_BEAM
	db 0 ; no more level-up moves

PupitarEvosAttacks:
	dbbw EVOLVE_LEVEL, 55, TYRANITAR
	db 0 ; no more evolutions
	dbw 1, BITE
	dbw 1, LEER
	dbw 1, SANDSTORM
	dbw 1, SCREECH
	dbw 8, SANDSTORM
	dbw 15, SCREECH
	dbw 22, ROCK_SLIDE
	dbw 29, THRASH
	dbw 38, SCARY_FACE
	dbw 47, CRUNCH
	dbw 56, EARTHQUAKE
	dbw 65, HYPER_BEAM
	db 0 ; no more level-up moves

TyranitarEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, BITE
	dbw 1, LEER
	dbw 1, SANDSTORM
	dbw 1, SCREECH
	dbw 8, SANDSTORM
	dbw 15, SCREECH
	dbw 22, ROCK_SLIDE
	dbw 29, THRASH
	dbw 38, SCARY_FACE
	dbw 47, CRUNCH
	dbw 61, EARTHQUAKE
	dbw 75, HYPER_BEAM
	db 0 ; no more level-up moves

LugiaEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, AEROBLAST
	dbw 11, SAFEGUARD
	dbw 20, PSYCHIC_TERRAIN
	dbw 22, GUST
	dbw 33, RECOVER
	dbw 44, HYDRO_PUMP
	dbw 55, RAIN_DANCE
	dbw 66, SWIFT
	dbw 77, WHIRLWIND
	dbw 88, ANCIENTPOWER
	dbw 99, FUTURE_SIGHT
	db 0 ; no more level-up moves

HoOhEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SACRED_FIRE
	dbw 11, SAFEGUARD
	dbw 22, GUST
	dbw 33, RECOVER
	dbw 44, FIRE_BLAST
	dbw 55, SUNNY_DAY
	dbw 66, SWIFT
	dbw 77, WHIRLWIND
	dbw 88, ANCIENTPOWER
	dbw 99, FUTURE_SIGHT
	db 0 ; no more level-up moves

CelebiEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, LEECH_SEED
	dbw 1, CONFUSION
	dbw 1, RECOVER
	dbw 1, HEAL_BELL
	dbw 10, SAFEGUARD
	dbw 20, ANCIENTPOWER
	dbw 20, GRASSY_TERRAIN
	dbw 20, PSYCHIC_TERRAIN
	dbw 30, FUTURE_SIGHT
	dbw 40, BATON_PASS
	dbw 50, PERISH_SONG
	db 0 ; no more level-up moves

; the Pokémon after CELEBI (see FIRST_NEW_POKEMON)

RattataAEvosAttacks:
	dbbw EVOLVE_LEVEL, 20, RATICATE_A
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, TAIL_WHIP
	dbw 4, QUICK_ATTACK
	dbw 7, FOCUS_ENERGY
	dbw 10, BITE
	dbw 13, PURSUIT
	dbw 15, SUPER_FANG
	dbw 16, HYPER_FANG
	dbw 18, CRUNCH
	dbw 27, DOUBLE_EDGE
	db 0 ; no more level-up moves

RaticateAEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SCARY_FACE
	dbw 1, COUNTER
	dbw 1, SWORDS_DANCE
	dbw 1, FURY_SWIPES
	dbw 1, TACKLE
	dbw 1, TAIL_WHIP
	dbw 1, QUICK_ATTACK
	dbw 1, FOCUS_ENERGY
	dbw 10, BITE
	dbw 13, PURSUIT
	dbw 15, SUPER_FANG
	dbw 16, HYPER_FANG
	dbw 18, CRUNCH
	dbw 39, DOUBLE_EDGE
	db 0 ; no more level-up moves

RaichuAEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, PSYCHIC_M
	dbw 1, ENCORE
	dbw 1, SWEET_KISS
	dbw 1, THUNDERSHOCK
	dbw 1, TAIL_WHIP
	dbw 1, GROWL
	dbw 1, QUICK_ATTACK
	dbw 1, CHARM
	dbw 1, IRON_TAIL
	dbw 1, THUNDERBOLT
	dbw 1, DOUBLE_TEAM
	dbw 1, THUNDER_WAVE
	dbw 1, SPARK
	dbw 1, AGILITY
	dbw 1, SLAM
	dbw 1, LIGHT_SCREEN
	dbw 1, THUNDER
	db 0 ; no more level-up moves

SandshrewAEvosAttacks:
	dbbw EVOLVE_ITEM, NEVERMELTICE, SANDSLASH_A
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, DEFENSE_CURL
	dbw 3, BIDE
	dbw 3, MIST
	dbw 5, POWDER_SNOW
	dbw 9, RAPID_SPIN
	dbw 9, ROLLOUT
	dbw 11, FURY_CUTTER
	dbw 12, SWIFT
	dbw 14, METAL_CLAW
	dbw 16, MIRROR_COAT
	dbw 20, FURY_SWIPES
	dbw 24, ICE_PUNCH
	dbw 26, SLASH
	dbw 28, SWORDS_DANCE
	dbw 36, BLIZZARD
	dbw 42, HAIL
	db 0 ; no more level-up moves

SandslashAEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, COUNTER
	dbw 1, SCRATCH
	dbw 1, BIDE
	dbw 1, ROLLOUT
	dbw 1, SLASH
	dbw 1, DEFENSE_CURL
	dbw 1, FURY_CUTTER
	dbw 1, RAPID_SPIN
	dbw 1, METAL_CLAW
	dbw 1, SWIFT
	dbw 1, FURY_SWIPES
	dbw 1, SWORDS_DANCE
	dbw 1, HAIL
	dbw 1, BLIZZARD
	dbw 1, MIST
	dbw 1, POWDER_SNOW
	db 0 ; no more level-up moves

VulpixAEvosAttacks:
	dbbw EVOLVE_ITEM, NEVERMELTICE, NINETALES_A
	db 0 ; no more evolutions
	dbw 1, POWDER_SNOW
	dbw 1, TACKLE
	dbw 1, TAIL_WHIP
	dbw 4, DISABLE
	dbw 7, MIST
	dbw 7, ROAR
	dbw 12, CONFUSE_RAY
	dbw 12, SPITE
	dbw 15, ICY_WIND
	dbw 17, AURORA_BEAM
	dbw 23, FAINT_ATTACK
	dbw 24, ICE_BEAM
	dbw 31, BLIZZARD
	dbw 34, SAFEGUARD
	db 0 ; no more level-up moves

NinetalesAEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, HYPNOSIS
	dbw 1, SPITE
	dbw 1, TACKLE
	dbw 1, ICE_BEAM
	dbw 1, ICY_WIND
	dbw 1, TAIL_WHIP
	dbw 1, MIST
	dbw 1, AURORA_BEAM
	dbw 1, CONFUSE_RAY
	dbw 1, SAFEGUARD
	dbw 1, BLIZZARD
	dbw 1, POWDER_SNOW
	dbw 1, DISABLE
	db 0 ; no more level-up moves

MeowthAEvosAttacks:
	dbbw EVOLVE_LEVEL, 28, PERSIAN_A
	db 0 ; no more evolutions
	dbw 1, SCRATCH
	dbw 1, GROWL
	dbw 1, BITE
	dbw 12, PAY_DAY
	dbw 14, FURY_SWIPES
	dbw 17, SCREECH
	dbw 22, FAINT_ATTACK
	dbw 27, SLASH
	dbw 35, PLAY_ROUGH
	db 0 ; no more level-up moves

MeowthGEvosAttacks:
	dbbw EVOLVE_LEVEL, 28, PERRSERKER
	db 0 ; no more evolutions
	dbw 1, GROWL
	dbw 8, SCRATCH
	dbw 12, PAY_DAY
	dbw 16, METAL_CLAW
	dbw 24, SWAGGER
	dbw 29, FURY_SWIPES
	dbw 32, SCREECH
	dbw 36, SLASH
	dbw 44, THRASH
	db 0 ; no more level-up moves

PersianAEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SWIFT
	dbw 1, AMNESIA
	dbw 1, HYPNOSIS
	dbw 1, PLAY_ROUGH
	dbw 1, SCRATCH
	dbw 1, GROWL
	dbw 1, BITE
	dbw 12, PAY_DAY
	dbw 14, FURY_SWIPES
	dbw 17, SCREECH
	dbw 22, FAINT_ATTACK
	dbw 27, SLASH
	db 0 ; no more level-up moves

GrowlitheHEvosAttacks:
	dbbw EVOLVE_ITEM, FIRE_STONE, ARCANINE_H
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, LEER
	dbw 1, EMBER
	dbw 8, BITE
	dbw 12, FLAME_WHEEL
	dbw 21, ROCK_SLIDE
	dbw 29, CRUNCH
	dbw 36, TAKE_DOWN
	dbw 37, DOUBLE_EDGE
	dbw 40, FLAMETHROWER
	dbw 44, ROAR
	dbw 52, REVERSAL
	db 0 ; no more level-up moves

ArcanineHEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, EXTREMESPEED
	dbw 1, TACKLE
	dbw 1, FLAME_WHEEL
	dbw 1, CRUNCH
	dbw 1, REVERSAL
	dbw 1, TAKE_DOWN
	dbw 1, AGILITY
	dbw 1, ROCK_THROW
	dbw 1, EMBER
	dbw 1, ROAR
	dbw 1, BITE
	dbw 1, LEER
	dbw 1, ROCK_SLIDE
	dbw 5, FLAMETHROWER
	dbw 37, DOUBLE_EDGE
	db 0 ; no more level-up moves

GeodudeAEvosAttacks:
	dbbw EVOLVE_LEVEL, 25, GRAVELER_A
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL
	dbw 3, THUNDERSHOCK
	dbw 6, BIDE
	dbw 9, ROCK_THROW
	dbw 10, ROLLOUT
	dbw 12, SPARK
	dbw 15, TAKE_DOWN
	dbw 19, SELFDESTRUCT
	dbw 22, THUNDERPUNCH
	dbw 23, ROCK_SLIDE
	dbw 31, DOUBLE_EDGE
	dbw 35, EXPLOSION
	db 0 ; no more level-up moves

GravelerAEvosAttacks:
	dbbw EVOLVE_ITEM, LINKING_CORD, GOLEM_A
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL
	dbw 1, THUNDERSHOCK
	dbw 1, BIDE
	dbw 9, ROCK_THROW
	dbw 10, ROLLOUT
	dbw 12, SPARK
	dbw 15, TAKE_DOWN
	dbw 19, SELFDESTRUCT
	dbw 22, THUNDERPUNCH
	dbw 23, ROCK_SLIDE
	dbw 39, DOUBLE_EDGE
	dbw 44, EXPLOSION
	db 0 ; no more level-up moves

GolemAEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, MEGA_PUNCH
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL
	dbw 1, THUNDERSHOCK
	dbw 1, BIDE
	dbw 9, ROCK_THROW
	dbw 12, SPARK
	dbw 15, TAKE_DOWN
	dbw 19, SELFDESTRUCT
	dbw 22, THUNDERPUNCH
	dbw 23, ROCK_SLIDE
	dbw 39, DOUBLE_EDGE
	dbw 44, EXPLOSION
	db 0 ; no more level-up moves

PonytaGEvosAttacks:
	dbbw EVOLVE_LEVEL, 40, RAPIDASH_G
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 5, TAIL_WHIP
	dbw 10, CONFUSION
	dbw 20, AGILITY
	dbw 25, PSYBEAM
	dbw 30, STOMP
	dbw 41, TAKE_DOWN
	dbw 50, PSYCHIC_M
	db 0 ; no more level-up moves

RapidashGEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, MEGAHORN
	dbw 1, TACKLE
	dbw 1, QUICK_ATTACK
	dbw 1, GROWL
	dbw 1, TAIL_WHIP
	dbw 1, CONFUSION
	dbw 20, AGILITY
	dbw 25, PSYBEAM
	dbw 30, STOMP
	dbw 43, TAKE_DOWN
	dbw 56, PSYCHIC_M
	db 0 ; no more level-up moves

SlowpokeGEvosAttacks:
	dbbw EVOLVE_LEVEL, 37, SLOWBRO_G
	dbbw EVOLVE_ITEM, KINGS_ROCK, SLOWKING_G
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, CURSE
	dbw 3, GROWL
	dbw 6, ACID
	dbw 12, CONFUSION
	dbw 15, DISABLE
	dbw 21, HEADBUTT
	dbw 27, AMNESIA
	dbw 30, SURF
	dbw 36, PSYCHIC_M
	dbw 39, PSYCH_UP
	dbw 42, RAIN_DANCE
	db 0 ; no more level-up moves

SlowbroGEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, WITHDRAW
	dbw 1, TACKLE
	dbw 1, CURSE
	dbw 1, GROWL
	dbw 1, ACID
	dbw 12, CONFUSION
	dbw 15, DISABLE
	dbw 21, HEADBUTT
	dbw 27, AMNESIA
	dbw 30, SURF
	dbw 36, PSYCHIC_M
	dbw 39, PSYCH_UP
	dbw 42, RAIN_DANCE
	db 0 ; no more level-up moves

FarfetchDGEvosAttacks:
	dbbw EVOLVE_LEVEL, 30, SIRFETCH_D
	db 0 ; no more evolutions
	dbw 1, PECK
	dbw 1, SAND_ATTACK
	dbw 5, LEER
	dbw 10, FURY_CUTTER
	dbw 15, ROCK_SMASH
	dbw 25, DETECT
	dbw 45, SWORDS_DANCE
	dbw 50, SLAM
	db 0 ; no more level-up moves

ExeggutorAEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, BARRAGE
	dbw 1, EGG_BOMB
	dbw 1, HYPNOSIS
	dbw 1, CONFUSION
	dbw 1, MEGA_DRAIN
	dbw 1, STUN_SPORE
	dbw 1, SYNTHESIS
	dbw 1, GIGA_DRAIN
	dbw 1, SOLARBEAM
	dbw 1, ABSORB
	dbw 1, REFLECT
	dbw 1, LEECH_SEED
	db 0 ; no more level-up moves

MarowakAEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SWORDS_DANCE
	dbw 1, FALSE_SWIPE
	dbw 1, GROWL
	dbw 1, HEADBUTT
	dbw 1, SCREECH
	dbw 1, TAIL_WHIP
	dbw 1, BONE_CLUB
	dbw 1, FLAME_WHEEL
	dbw 1, FOCUS_ENERGY
	dbw 1, DOUBLE_EDGE
	dbw 1, LEER
	dbw 1, MUD_SLAP
	dbw 1, FIRE_SPIN
	dbw 18, RAGE
	dbw 21, BONEMERANG
	dbw 31, BONE_RUSH
	dbw 33, THRASH
	db 0 ; no more level-up moves

WeezingGEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SMOG
	dbw 1, SMOKESCREEN
	dbw 1, HAZE
	dbw 1, POISON_GAS
	dbw 1, TACKLE
	dbw 20, SLUDGE
	dbw 28, SELFDESTRUCT
	dbw 32, SLUDGE_BOMB
	dbw 38, TOXIC
	dbw 50, EXPLOSION
	dbw 62, DESTINY_BOND
	dbw 68, MISTY_TERRAIN
	db 0 ; no more level-up moves

MrMimeGEvosAttacks:
	dbbw EVOLVE_LEVEL, 42, MR__RIME
	db 0 ; no more evolutions
	dbw 1, ENCORE
	dbw 1, PROTECT
	dbw 1, MIMIC
	dbw 1, LIGHT_SCREEN
	dbw 1, REFLECT
	dbw 1, SAFEGUARD
	dbw 1, MISTY_TERRAIN
	dbw 1, POUND
	dbw 1, RAPID_SPIN
	dbw 1, BATON_PASS
	dbw 12, CONFUSION
	dbw 20, ICY_WIND
	dbw 24, DOUBLE_KICK
	dbw 28, PSYBEAM
	dbw 32, HYPNOSIS
	dbw 36, MIRROR_COAT
	dbw 48, PSYCHIC_M
	db 0 ; no more level-up moves

ArticunoGEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, GUST
	dbw 5, CONFUSION
	dbw 10, REFLECT
	dbw 15, HYPNOSIS
	dbw 20, AGILITY
	dbw 25, ANCIENTPOWER
	dbw 40, RECOVER
	dbw 50, DREAM_EATER
	dbw 60, DOUBLE_TEAM
	dbw 60, MIND_READER
	dbw 65, FUTURE_SIGHT
	db 0 ; no more level-up moves

ZapdosGEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, PECK
	dbw 1, FOCUS_ENERGY
	dbw 5, ROCK_SMASH
	dbw 10, LIGHT_SCREEN
	dbw 20, AGILITY
	dbw 25, ANCIENTPOWER
	dbw 35, DRILL_PECK
	dbw 55, COUNTER
	dbw 60, DETECT
	dbw 70, REVERSAL
	db 0 ; no more level-up moves

MoltresGEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, GUST
	dbw 1, LEER
	dbw 10, SAFEGUARD
	dbw 15, WING_ATTACK
	dbw 20, AGILITY
	dbw 25, ANCIENTPOWER
	dbw 60, ENDURE
	dbw 70, SKY_ATTACK
	db 0 ; no more level-up moves

TyphlosionHEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, QUICK_ATTACK
	dbw 1, SMOKESCREEN
	dbw 1, TACKLE
	dbw 1, EMBER
	dbw 1, LEER
	dbw 1, DOUBLE_EDGE
	dbw 11, ROLLOUT
	dbw 18, FLAME_WHEEL
	dbw 24, DEFENSE_CURL
	dbw 25, SWIFT
	dbw 34, FLAMETHROWER
	dbw 43, SHADOW_BALL
	db 0 ; no more level-up moves

WooperPEvosAttacks:
	dbbw EVOLVE_LEVEL, 20, CLODSIRE
	db 0 ; no more evolutions
	dbw 1, TAIL_WHIP
	dbw 4, TACKLE
	dbw 16, SLAM
	dbw 32, AMNESIA
	dbw 36, TOXIC
	dbw 40, EARTHQUAKE
	db 0 ; no more level-up moves

SlowkingGEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, SWAGGER
	dbw 1, TACKLE
	dbw 1, CURSE
	dbw 1, GROWL
	dbw 1, ACID
	dbw 12, CONFUSION
	dbw 15, DISABLE
	dbw 21, HEADBUTT
	dbw 27, AMNESIA
	dbw 30, SURF
	dbw 36, PSYCHIC_M
	dbw 39, PSYCH_UP
	dbw 42, RAIN_DANCE
	db 0 ; no more level-up moves

QwilfishHEvosAttacks:
	dbbw EVOLVE_ITEM, POISON_BARB, OVERQWIL
	db 0 ; no more evolutions
	dbw 1, POISON_STING
	dbw 1, TACKLE
	dbw 4, HARDEN
	dbw 5, SPIKES
	dbw 8, BITE
	dbw 9, PIN_MISSILE
	dbw 16, MINIMIZE
	dbw 44, TOXIC
	dbw 47, DOUBLE_EDGE
	dbw 48, CRUNCH
	dbw 56, DESTINY_BOND
	dbw 57, SELFDESTRUCT
	db 0 ; no more level-up moves

CorsolaGEvosAttacks:
	dbbw EVOLVE_LEVEL, 38, CURSOLA
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, HARDEN
	dbw 10, DISABLE
	dbw 15, SPITE
	dbw 20, ANCIENTPOWER
	dbw 30, CURSE
	dbw 45, NIGHT_SHADE
	dbw 55, MIRROR_COAT
	db 0 ; no more level-up moves

AzurillEvosAttacks:
	dbbw EVOLVE_LEVEL, 12, MARILL
	db 0 ; no more evolutions
	dbw 1, SPLASH
	dbw 1, BUBBLE
	dbw 1, WATER_GUN
	dbw 1, TAIL_WHIP
	dbw 2, CHARM
	dbw 6, BUBBLEBEAM
	dbw 12, SLAM
	db 0 ; no more level-up moves

WynautEvosAttacks:
	dbbw EVOLVE_LEVEL, 15, WOBBUFFET
	db 0 ; no more evolutions
	dbw 1, COUNTER
	dbw 1, SPLASH
	dbw 1, CHARM
	dbw 1, MIRROR_COAT
	dbw 1, ENCORE
	dbw 1, SAFEGUARD
	dbw 1, DESTINY_BOND
	dbw 1, AMNESIA
	db 0 ; no more level-up moves

MismagiusEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, CONFUSE_RAY
	dbw 1, CONFUSION
	dbw 1, GROWL
	dbw 1, PSYWAVE
	dbw 1, SPITE
	dbw 1, MEAN_LOOK
	dbw 1, PAIN_SPLIT
	dbw 1, PERISH_SONG
	dbw 1, PSYBEAM
	dbw 1, SHADOW_BALL
	dbw 11, HYPNOSIS
	db 0 ; no more level-up moves

HonchkrowEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, PURSUIT
	dbw 1, HAZE
	dbw 1, GUST
	dbw 1, WING_ATTACK
	dbw 1, MEAN_LOOK
	dbw 1, NIGHT_SHADE
	dbw 1, PECK
	dbw 25, SWAGGER
	db 0 ; no more level-up moves

BonslyEvosAttacks:
	dbbw EVOLVE_LEVEL, 17, SUDOWOODO
	db 0 ; no more evolutions
	dbw 1, ROLLOUT
	dbw 4, FLAIL
	dbw 5, TACKLE
	dbw 8, LOW_KICK
	dbw 8, ROCK_THROW
	dbw 15, MIMIC
	dbw 15, ROCK_SLIDE
	dbw 15, SLAM
	dbw 19, FAINT_ATTACK
	dbw 33, COUNTER
	dbw 37, DOUBLE_EDGE
	db 0 ; no more level-up moves

MimeJrEvosAttacks:
	dbbw EVOLVE_LEVEL, 18, MR__MIME
	dbbw EVOLVE_ITEM, NEVERMELTICE, MR__MIME_G
	db 0 ; no more evolutions
	dbw 1, BARRIER
	dbw 1, CONFUSION
	dbw 1, POUND
	dbw 4, BATON_PASS
	dbw 6, HYPNOSIS
	dbw 8, ENCORE
	dbw 8, MEDITATE
	dbw 11, DOUBLESLAP
	dbw 15, MIMIC
	dbw 20, PROTECT
	dbw 22, LIGHT_SCREEN
	dbw 22, REFLECT
	dbw 25, PSYBEAM
	dbw 29, SUBSTITUTE
	dbw 34, PSYCHIC_M
	dbw 36, SAFEGUARD
	db 0 ; no more level-up moves

HappinyEvosAttacks:
	dbbw EVOLVE_LEVEL, 12, CHANSEY
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, MINIMIZE
	dbw 1, POUND
	dbw 1, CHARM
	dbw 4, DEFENSE_CURL
	dbw 8, SWEET_KISS
	dbw 18, DRAINING_KISS
	dbw 34, SOFTBOILED
	dbw 43, DOUBLE_EDGE
	db 0 ; no more level-up moves

MunchlaxEvosAttacks:
	dbbw EVOLVE_LEVEL, 30, SNORLAX
	db 0 ; no more evolutions
	dbw 1, ROLLOUT
	dbw 1, METRONOME
	dbw 1, LICK
	dbw 1, TACKLE
	dbw 4, DEFENSE_CURL
	dbw 9, AMNESIA
	dbw 9, REST
	dbw 16, BITE
	dbw 20, SCREECH
	dbw 25, BODY_SLAM
	dbw 44, BELLY_DRUM
	dbw 44, FLAIL
	dbw 46, DOUBLE_EDGE
	db 0 ; no more level-up moves

MantykeEvosAttacks:
	dbbw EVOLVE_LEVEL, 20, MANTINE
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, BUBBLE
	dbw 1, WATER_GUN
	dbw 3, SUPERSONIC
	dbw 7, BUBBLEBEAM
	dbw 8, WING_ATTACK
	dbw 11, CONFUSE_RAY
	dbw 13, HEADBUTT
	dbw 19, AGILITY
	dbw 27, TAKE_DOWN
	dbw 37, HYDRO_PUMP
	dbw 47, DOUBLE_EDGE
	db 0 ; no more level-up moves

WeavileEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, BEAT_UP
	dbw 1, SCRATCH
	dbw 1, AGILITY
	dbw 1, LEER
	dbw 1, SLASH
	dbw 1, QUICK_ATTACK
	dbw 10, FAINT_ATTACK
	dbw 10, SCREECH
	dbw 11, SWIFT
	dbw 14, ICY_WIND
	dbw 16, FURY_SWIPES
	dbw 18, METAL_CLAW
	dbw 34, SWORDS_DANCE
	dbw 43, BLIZZARD
	db 0 ; no more level-up moves

MagnezoneEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, MIRROR_COAT
	dbw 1, TRI_ATTACK
	dbw 1, ZAP_CANNON
	dbw 1, BARRIER
	dbw 1, TACKLE
	dbw 1, ELECTRIC_TERRAIN
	dbw 1, THUNDERSHOCK
	dbw 1, SONICBOOM
	dbw 1, SUPERSONIC
	dbw 1, THUNDER_WAVE
	dbw 13, LIGHT_SCREEN
	dbw 18, SPARK
	dbw 24, SCREECH
	dbw 27, LOCK_ON
	dbw 34, THUNDERBOLT
	dbw 43, THUNDER
	db 0 ; no more level-up moves

LickilickyEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, LICK
	dbw 1, TACKLE
	dbw 1, DEFENSE_CURL
	dbw 1, ROLLOUT
	dbw 1, SUPERSONIC
	dbw 6, REST
	dbw 17, WRAP
	dbw 21, STOMP
	dbw 24, DISABLE
	dbw 25, DOUBLE_EDGE
	dbw 29, SLAM
	dbw 42, SCREECH
	dbw 60, BELLY_DRUM
	db 0 ; no more level-up moves

RhyperiorEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, HORN_ATTACK
	dbw 1, MEGAHORN
	dbw 1, TACKLE
	dbw 1, HORN_DRILL
	dbw 1, TAIL_WHIP
	dbw 1, STOMP
	dbw 1, FURY_ATTACK
	dbw 1, SCARY_FACE
	dbw 11, ROCK_SMASH
	dbw 25, ROCK_SLIDE
	dbw 33, TAKE_DOWN
	dbw 43, DOUBLE_EDGE
	dbw 47, EARTHQUAKE
	db 0 ; no more level-up moves

TangrowthEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, ABSORB
	dbw 1, CONSTRICT
	dbw 1, BIND
	dbw 1, STUN_SPORE
	dbw 1, GROWTH
	dbw 4, SLEEP_POWDER
	dbw 7, VINE_WHIP
	dbw 11, POISONPOWDER
	dbw 12, MEGA_DRAIN
	dbw 24, ANCIENTPOWER
	dbw 32, GIGA_DRAIN
	dbw 40, SLAM
	dbw 50, GRASSY_TERRAIN
	dbw 52, SLUDGE_BOMB
	db 0 ; no more level-up moves

ElectivireEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, ELECTRIC_TERRAIN
	dbw 1, FIRE_PUNCH
	dbw 1, QUICK_ATTACK
	dbw 1, LEER
	dbw 1, THUNDERSHOCK
	dbw 1, LOW_KICK
	dbw 11, SPARK
	dbw 12, SWIFT
	dbw 18, THUNDER_WAVE
	dbw 24, SCREECH
	dbw 25, LIGHT_SCREEN
	dbw 25, THUNDERPUNCH
	dbw 34, THUNDERBOLT
	dbw 43, THUNDER
	db 0 ; no more level-up moves

MagmortarEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, THUNDERPUNCH
	dbw 1, SMOG
	dbw 1, LEER
	dbw 1, EMBER
	dbw 1, SMOKESCREEN
	dbw 6, TACKLE
	dbw 11, FLAME_WHEEL
	dbw 12, FAINT_ATTACK
	dbw 15, FIRE_SPIN
	dbw 18, POISON_GAS
	dbw 20, CONFUSE_RAY
	dbw 24, SCARY_FACE
	dbw 25, FIRE_PUNCH
	dbw 34, FLAMETHROWER
	dbw 40, LOW_KICK
	dbw 42, SUNNY_DAY
	dbw 43, FIRE_BLAST
	dbw 62, HYPER_BEAM
	db 0 ; no more level-up moves

TogekissEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, SKY_ATTACK
	dbw 1, EXTREMESPEED
	dbw 1, TRI_ATTACK
	dbw 1, CHARM
	dbw 1, ANCIENTPOWER
	dbw 1, METRONOME
	dbw 1, DOUBLE_EDGE
	dbw 1, SAFEGUARD
	dbw 1, BATON_PASS
	dbw 1, GROWL
	dbw 1, POUND
	dbw 1, SWEET_KISS
	dbw 11, DRAINING_KISS
	dbw 43, MOONBLAST
	db 0 ; no more level-up moves

YanmegaEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, FORESIGHT
	dbw 1, GUST
	dbw 1, QUICK_ATTACK
	dbw 1, DOUBLE_TEAM
	dbw 1, HYPNOSIS
	dbw 1, WING_ATTACK
	dbw 14, SONICBOOM
	dbw 17, DETECT
	dbw 22, SUPERSONIC
	dbw 30, PURSUIT
	dbw 30, STRING_SHOT
	dbw 33, ANCIENTPOWER
	dbw 38, SLASH
	dbw 43, CRUNCH
	dbw 43, SCREECH
	db 0 ; no more level-up moves

LeafeonEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, RAZOR_LEAF
	dbw 1, TACKLE
	dbw 1, TAIL_WHIP
	dbw 1, SWIFT
	dbw 1, BITE
	dbw 1, BATON_PASS
	dbw 1, TAKE_DOWN
	dbw 1, CHARM
	dbw 1, DOUBLE_EDGE
	dbw 1, GROWL
	dbw 5, SAND_ATTACK
	dbw 6, QUICK_ATTACK
	dbw 20, LEECH_SEED
	dbw 25, GIGA_DRAIN
	dbw 25, MIMIC
	dbw 29, SWORDS_DANCE
	dbw 29, SYNTHESIS
	dbw 35, SUNNY_DAY
	db 0 ; no more level-up moves

GlaceonEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, ICY_WIND
	dbw 1, POWDER_SNOW
	dbw 1, TACKLE
	dbw 1, TAIL_WHIP
	dbw 1, SWIFT
	dbw 1, BATON_PASS
	dbw 1, TAKE_DOWN
	dbw 1, CHARM
	dbw 1, DOUBLE_EDGE
	dbw 1, GROWL
	dbw 5, SAND_ATTACK
	dbw 6, QUICK_ATTACK
	dbw 17, BITE
	dbw 25, ICE_BEAM
	dbw 25, MIMIC
	dbw 29, BARRIER
	dbw 33, MIRROR_COAT
	dbw 35, HAIL
	dbw 45, BLIZZARD
	db 0 ; no more level-up moves

GliscorEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, GUILLOTINE
	dbw 1, SAND_ATTACK
	dbw 1, HARDEN
	dbw 1, POISON_STING
	dbw 1, SLASH
	dbw 6, QUICK_ATTACK
	dbw 16, FURY_CUTTER
	dbw 19, FAINT_ATTACK
	dbw 19, MUD_SLAP
	dbw 20, PIN_MISSILE
	dbw 27, SCREECH
	dbw 30, SWORDS_DANCE
	dbw 45, CRABHAMMER
	dbw 45, EARTHQUAKE
	db 0 ; no more level-up moves

MamoswineEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, ANCIENTPOWER
	dbw 1, FURY_ATTACK
	dbw 1, SCARY_FACE
	dbw 1, PECK
	dbw 1, TACKLE
	dbw 1, MUD_SLAP
	dbw 1, POWDER_SNOW
	dbw 1, FLAIL
	dbw 14, ENDURE
	dbw 20, MIST
	dbw 21, HAIL
	dbw 28, TAKE_DOWN
	dbw 30, ICY_WIND
	dbw 37, AMNESIA
	dbw 40, EARTHQUAKE
	dbw 41, THRASH
	dbw 43, BLIZZARD
	dbw 52, DOUBLE_EDGE
	db 0 ; no more level-up moves

PorygonZEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, CONVERSION2
	dbw 1, ZAP_CANNON
	dbw 1, DEFENSE_CURL
	dbw 1, TACKLE
	dbw 1, CONVERSION
	dbw 5, THUNDERSHOCK
	dbw 7, PSYBEAM
	dbw 9, THUNDER_WAVE
	dbw 12, AGILITY
	dbw 15, SPARK
	dbw 18, RECOVER
	dbw 21, TRI_ATTACK
	dbw 29, THUNDERBOLT
	dbw 45, LOCK_ON
	dbw 47, HYPER_BEAM
	dbw 50, DOUBLE_EDGE
	db 0 ; no more level-up moves

SylveonEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TAIL_WHIP
	dbw 1, BITE
	dbw 1, TACKLE
	dbw 1, BATON_PASS
	dbw 1, TAKE_DOWN
	dbw 1, CHARM
	dbw 1, DOUBLE_EDGE
	dbw 1, GROWL
	dbw 5, SAND_ATTACK
	dbw 6, QUICK_ATTACK
	dbw 11, SWIFT
	dbw 20, DRAINING_KISS
	dbw 25, LIGHT_SCREEN
	dbw 25, MIMIC
	dbw 25, PLAY_ROUGH
	dbw 29, MISTY_TERRAIN
	dbw 37, MOONBLAST
	dbw 45, PSYCH_UP
	db 0 ; no more level-up moves

PerrserkerEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, GROWL
	dbw 1, SCRATCH
	dbw 12, PAY_DAY
	dbw 16, METAL_CLAW
	dbw 24, SWAGGER
	dbw 31, FURY_SWIPES
	dbw 36, SCREECH
	dbw 42, SLASH
	dbw 54, THRASH
	db 0 ; no more level-up moves

CursolaEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, PERISH_SONG
	dbw 1, TACKLE
	dbw 1, HARDEN
	dbw 1, DISABLE
	dbw 15, SPITE
	dbw 20, ANCIENTPOWER
	dbw 30, CURSE
	dbw 45, NIGHT_SHADE
	dbw 55, MIRROR_COAT
	db 0 ; no more level-up moves

SirfetchDEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, PECK
	dbw 1, SAND_ATTACK
	dbw 1, LEER
	dbw 1, FURY_CUTTER
	dbw 15, ROCK_SMASH
	dbw 25, DETECT
	dbw 45, SWORDS_DANCE
	dbw 50, SLAM
	db 0 ; no more level-up moves

MrRimeEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, ENCORE
	dbw 1, PROTECT
	dbw 1, MIMIC
	dbw 1, LIGHT_SCREEN
	dbw 1, REFLECT
	dbw 1, SAFEGUARD
	dbw 1, MISTY_TERRAIN
	dbw 1, POUND
	dbw 1, RAPID_SPIN
	dbw 1, BATON_PASS
	dbw 12, CONFUSION
	dbw 20, ICY_WIND
	dbw 24, DOUBLE_KICK
	dbw 28, PSYBEAM
	dbw 32, HYPNOSIS
	dbw 36, MIRROR_COAT
	dbw 48, PSYCHIC_M
	db 0 ; no more level-up moves

WyrdeerEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 3, LEER
	dbw 5, CONFUSION
	dbw 9, HYPNOSIS
	dbw 13, STOMP
	dbw 16, SAND_ATTACK
	dbw 21, TAKE_DOWN
	dbw 23, CONFUSE_RAY
	dbw 47, DOUBLE_EDGE
	dbw 62, MEGAHORN
	db 0 ; no more level-up moves

KleavorEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, QUICK_ATTACK
	dbw 1, LEER
	dbw 4, FURY_CUTTER
	dbw 8, FALSE_SWIPE
	dbw 16, DOUBLE_TEAM
	dbw 24, SLASH
	dbw 25, SWORDS_DANCE
	dbw 28, FOCUS_ENERGY
	dbw 32, AGILITY
	dbw 36, ROCK_SLIDE
	db 0 ; no more level-up moves

UrsalunaEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, SCRATCH
	dbw 1, LEER
	dbw 1, LICK
	dbw 8, FURY_SWIPES
	dbw 17, SWEET_SCENT
	dbw 18, SLASH
	dbw 25, PLAY_ROUGH
	dbw 35, SCARY_FACE
	dbw 41, REST
	dbw 41, SNORE
	dbw 43, DOUBLE_EDGE
	dbw 56, THRASH
	db 0 ; no more level-up moves

OverqwilEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, POISON_STING
	dbw 1, TACKLE
	dbw 4, HARDEN
	dbw 5, SPIKES
	dbw 8, BITE
	dbw 9, PIN_MISSILE
	dbw 16, MINIMIZE
	dbw 44, TOXIC
	dbw 47, DOUBLE_EDGE
	dbw 48, CRUNCH
	dbw 56, DESTINY_BOND
	dbw 57, SELFDESTRUCT
	db 0 ; no more level-up moves

ClodsireEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, AMNESIA
	dbw 1, TAIL_WHIP
	dbw 1, POISON_STING
	dbw 16, SLAM
	dbw 36, MEGAHORN
	dbw 40, TOXIC
	dbw 48, EARTHQUAKE
	db 0 ; no more level-up moves

FarigirafEvosAttacks:
	db 0 ; no more evolutions
	dbw 1, TACKLE
	dbw 1, GROWL
	dbw 5, CONFUSION
	dbw 14, STOMP
	dbw 19, PSYBEAM
	dbw 23, AGILITY
	dbw 37, CRUNCH
	dbw 41, BATON_PASS
	dbw 50, PSYCHIC_M
	db 0 ; no more level-up moves
