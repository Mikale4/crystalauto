MACRO fishmon
; chance, species (its 16-bit index), level
	db \1
	dw \2
	db \3
ENDM

MACRO time_group
; chance, n: use the nth TimeFishGroups entry
	db \1
	dw 0
	db \2
ENDM

MACRO time_fish
; day species, level, nite species, level
	dw \1
	db \2
	dw \3
	db \4
ENDM

MACRO fishgroup
; chance, old rod, good rod, super rod
	db \1
	dw \2, \3, \4
ENDM

FishGroups:
; entries correspond to FISHGROUP_* constants
	table_width FISHGROUP_DATA_LENGTH
	fishgroup 50 percent + 1, .Shore_Old,            .Shore_Good,            .Shore_Super
	fishgroup 50 percent + 1, .Ocean_Old,            .Ocean_Good,            .Ocean_Super
	fishgroup 50 percent + 1, .Lake_Old,             .Lake_Good,             .Lake_Super
	fishgroup 50 percent + 1, .Pond_Old,             .Pond_Good,             .Pond_Super
	fishgroup 50 percent + 1, .Dratini_Old,          .Dratini_Good,          .Dratini_Super
	fishgroup 50 percent + 1, .Qwilfish_Swarm_Old,   .Qwilfish_Swarm_Good,   .Qwilfish_Swarm_Super
	fishgroup 50 percent + 1, .Remoraid_Swarm_Old,   .Remoraid_Swarm_Good,   .Remoraid_Swarm_Super
	fishgroup 50 percent + 1, .Gyarados_Old,         .Gyarados_Good,         .Gyarados_Super
	fishgroup 50 percent + 1, .Dratini_2_Old,        .Dratini_2_Good,        .Dratini_2_Super
	fishgroup 50 percent + 1, .WhirlIslands_Old,     .WhirlIslands_Good,     .WhirlIslands_Super
	fishgroup 50 percent + 1, .Qwilfish_Old,         .Qwilfish_Good,         .Qwilfish_Super
	fishgroup 50 percent + 1, .Remoraid_Old,         .Remoraid_Good,         .Remoraid_Super
	fishgroup 50 percent + 1, .Qwilfish_NoSwarm_Old, .Qwilfish_NoSwarm_Good, .Qwilfish_NoSwarm_Super
	assert_table_length NUM_FISHGROUPS

.Shore_Old:
	fishmon  70 percent + 1, MAGIKARP,   10
	fishmon  85 percent + 1, MAGIKARP,   10
	fishmon 100 percent,     KRABBY,     10
.Shore_Good:
	fishmon  35 percent,     MAGIKARP,   20
	fishmon  70 percent,     KRABBY,     20
	fishmon  90 percent + 1, KRABBY,     20
	time_group 100 percent,     0
.Shore_Super:
	fishmon  40 percent,     KRABBY,     40
	time_group  70 percent,     1
	fishmon  90 percent + 1, KRABBY,     40
	fishmon 100 percent,     KINGLER,    40
.Ocean_Old:
	fishmon  70 percent + 1, MAGIKARP,   10
	fishmon  85 percent + 1, MAGIKARP,   10
	fishmon 100 percent,     TENTACOOL,  10
.Ocean_Good:
	fishmon  35 percent,     MAGIKARP,   20
	fishmon  70 percent,     TENTACOOL,  20
	fishmon  90 percent + 1, CHINCHOU,   20
	time_group 100 percent,     2
.Ocean_Super:
	fishmon  40 percent,     CHINCHOU,   40
	time_group  70 percent,     3
	fishmon  90 percent + 1, TENTACRUEL, 40
	fishmon 100 percent,     LANTURN,    40
.Lake_Old:
	fishmon  70 percent + 1, MAGIKARP,   10
	fishmon  85 percent + 1, MAGIKARP,   10
	fishmon 100 percent,     GOLDEEN,    10
.Lake_Good:
	fishmon  35 percent,     MAGIKARP,   20
	fishmon  70 percent,     GOLDEEN,    20
	fishmon  90 percent + 1, GOLDEEN,    20
	time_group 100 percent,     4
.Lake_Super:
	fishmon  40 percent,     GOLDEEN,    40
	time_group  70 percent,     5
	fishmon  90 percent + 1, MAGIKARP,   40
	fishmon 100 percent,     SEAKING,    40
.Pond_Old:
	fishmon  70 percent + 1, MAGIKARP,   10
	fishmon  85 percent + 1, MAGIKARP,   10
	fishmon 100 percent,     POLIWAG,    10
.Pond_Good:
	fishmon  35 percent,     MAGIKARP,   20
	fishmon  70 percent,     POLIWAG,    20
	fishmon  90 percent + 1, POLIWAG,    20
	time_group 100 percent,     6
.Pond_Super:
	fishmon  40 percent,     POLIWAG,    40
	time_group  70 percent,     7
	fishmon  90 percent + 1, MAGIKARP,   40
	fishmon 100 percent,     POLIWAG,    40
.Dratini_Old:
	fishmon  70 percent + 1, MAGIKARP,   10
	fishmon  85 percent + 1, MAGIKARP,   10
	fishmon 100 percent,     MAGIKARP,   10
.Dratini_Good:
	fishmon  35 percent,     MAGIKARP,   20
	fishmon  70 percent,     MAGIKARP,   20
	fishmon  90 percent + 1, MAGIKARP,   20
	time_group 100 percent,     8
.Dratini_Super:
	fishmon  40 percent,     MAGIKARP,   40
	time_group  70 percent,     9
	fishmon  90 percent + 1, MAGIKARP,   40
	fishmon 100 percent,     DRAGONAIR,  40
.Qwilfish_Swarm_Old:
	fishmon  70 percent + 1, MAGIKARP,   5
	fishmon  85 percent + 1, MAGIKARP,   5
	fishmon 100 percent,     QWILFISH,   5
.Qwilfish_Swarm_Good:
	fishmon  35 percent,     MAGIKARP,   20
	fishmon  70 percent,     QWILFISH,   20
	fishmon  90 percent + 1, QWILFISH,   20
	time_group 100 percent,     10
.Qwilfish_Swarm_Super:
	fishmon  40 percent,     QWILFISH,   40
	time_group  70 percent,     11
	fishmon  90 percent + 1, QWILFISH,   40
	fishmon 100 percent,     QWILFISH,   40
.Remoraid_Swarm_Old:
	fishmon  70 percent + 1, MAGIKARP,   10
	fishmon  85 percent + 1, MAGIKARP,   10
	fishmon 100 percent,     REMORAID,   10
.Remoraid_Swarm_Good:
	fishmon  35 percent,     MAGIKARP,   20
	fishmon  70 percent,     REMORAID,   20
	fishmon  90 percent + 1, REMORAID,   20
	time_group 100 percent,     12
.Remoraid_Swarm_Super:
	fishmon  40 percent,     REMORAID,   40
	time_group  70 percent,     13
	fishmon  90 percent + 1, REMORAID,   40
	fishmon 100 percent,     REMORAID,   40
.Gyarados_Old:
	fishmon  70 percent + 1, MAGIKARP,   10
	fishmon  85 percent + 1, MAGIKARP,   10
	fishmon 100 percent,     MAGIKARP,   10
.Gyarados_Good:
	fishmon  35 percent,     MAGIKARP,   20
	fishmon  70 percent,     MAGIKARP,   20
	fishmon  90 percent + 1, MAGIKARP,   20
	time_group 100 percent,     14
.Gyarados_Super:
	fishmon  40 percent,     MAGIKARP,   40
	time_group  70 percent,     15
	fishmon  90 percent + 1, MAGIKARP,   40
	fishmon 100 percent,     MAGIKARP,   40
.Dratini_2_Old:
	fishmon  70 percent + 1, MAGIKARP,   10
	fishmon  85 percent + 1, MAGIKARP,   10
	fishmon 100 percent,     MAGIKARP,   10
.Dratini_2_Good:
	fishmon  35 percent,     MAGIKARP,   10
	fishmon  70 percent,     MAGIKARP,   10
	fishmon  90 percent + 1, MAGIKARP,   10
	time_group 100 percent,     16
.Dratini_2_Super:
	fishmon  40 percent,     MAGIKARP,   10
	time_group  70 percent,     17
	fishmon  90 percent + 1, MAGIKARP,   10
	fishmon 100 percent,     DRAGONAIR,  10
.WhirlIslands_Old:
	fishmon  70 percent + 1, MAGIKARP,   10
	fishmon  85 percent + 1, MAGIKARP,   10
	fishmon 100 percent,     KRABBY,     10
.WhirlIslands_Good:
	fishmon  35 percent,     MAGIKARP,   20
	fishmon  70 percent,     KRABBY,     20
	fishmon  90 percent + 1, CORSOLA_G,  20
	time_group 100 percent,     18
.WhirlIslands_Super:
	fishmon  40 percent,     KRABBY,     40
	time_group  70 percent,     19
	fishmon  90 percent + 1, CORSOLA_G,  40
	fishmon 100 percent,     SEADRA,     40
.Qwilfish_NoSwarm_Old:
.Qwilfish_Old:
	fishmon  70 percent + 1, MAGIKARP,   10
	fishmon  85 percent + 1, MAGIKARP,   10
	fishmon 100 percent,     TENTACOOL,  10
.Qwilfish_NoSwarm_Good:
.Qwilfish_Good:
	fishmon  35 percent,     MAGIKARP,   20
	fishmon  70 percent,     TENTACOOL,  20
	fishmon  90 percent + 1, TENTACOOL,  20
	time_group 100 percent,     20
.Qwilfish_NoSwarm_Super:
.Qwilfish_Super:
	fishmon  40 percent,     TENTACOOL,  40
	time_group  70 percent,     21
	fishmon  90 percent + 1, MAGIKARP,   40
	fishmon 100 percent,     QWILFISH,   40
.Remoraid_Old:
	fishmon  70 percent + 1, MAGIKARP,   10
	fishmon  85 percent + 1, MAGIKARP,   10
	fishmon 100 percent,     POLIWAG,    10
.Remoraid_Good:
	fishmon  35 percent,     MAGIKARP,   20
	fishmon  70 percent,     POLIWAG,    20
	fishmon  90 percent + 1, POLIWAG,    20
	time_group 100 percent,     6
.Remoraid_Super:
	fishmon  40 percent,     POLIWAG,    40
	time_group  70 percent,     7
	fishmon  90 percent + 1, MAGIKARP,   40
	fishmon 100 percent,     REMORAID,   40
TimeFishGroups:
	;  day              nite
	time_fish CORSOLA,    20,  STARYU,     20 ; 0
	time_fish CORSOLA,    40,  STARYU,     40 ; 1
	time_fish SHELLDER,   20,  SHELLDER,   20 ; 2
	time_fish SHELLDER,   40,  SHELLDER,   40 ; 3
	time_fish GOLDEEN,    20,  GOLDEEN,    20 ; 4
	time_fish GOLDEEN,    40,  GOLDEEN,    40 ; 5
	time_fish POLIWAG,    20,  POLIWAG,    20 ; 6
	time_fish POLIWAG,    40,  POLIWAG,    40 ; 7
	time_fish DRATINI,    20,  DRATINI,    20 ; 8
	time_fish DRATINI,    40,  DRATINI,    40 ; 9
	time_fish QWILFISH,   20,  QWILFISH,   20 ; 10
	time_fish QWILFISH,   40,  QWILFISH,   40 ; 11
	time_fish REMORAID,   20,  REMORAID,   20 ; 12
	time_fish REMORAID,   40,  REMORAID,   40 ; 13
	time_fish GYARADOS,   20,  GYARADOS,   20 ; 14
	time_fish GYARADOS,   40,  GYARADOS,   40 ; 15
	time_fish DRATINI,    10,  DRATINI,    10 ; 16
	time_fish DRATINI,    10,  DRATINI,    10 ; 17
	time_fish HORSEA,     20,  HORSEA,     20 ; 18
	time_fish HORSEA,     40,  HORSEA,     40 ; 19
	time_fish TENTACOOL,  20,  QWILFISH_H, 20 ; 20
	time_fish TENTACOOL,  40,  QWILFISH_H, 40 ; 21
