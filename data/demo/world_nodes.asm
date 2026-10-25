; The Demo's nodes: the regions of each map with a way out, and the ways from
; them (see engine/demo/demo_nodes.asm). Made by tools/demo_world.py.

DemoWorldNodes:
; for each node: its map key, its cell (the Demo checks it can get there), its
; edges (DemoNodeEdges)
	table_width 6
	dw 0
	db 3, 6
	dw .Node0 ; OLIVINE_POKECENTER_1F
	dw 1
	db 4, 14
	dw .Node1 ; OLIVINE_GYM
	dw 2
	db 2, 6
	dw .Node2 ; OLIVINE_TIMS_HOUSE
	dw 3
	db 2, 6
	dw .Node3 ; OLIVINE_HOUSE_BETA
	dw 4
	db 2, 6
	dw .Node4 ; OLIVINE_PUNISHMENT_SPEECH_HOUSE
	dw 5
	db 2, 6
	dw .Node5 ; OLIVINE_GOOD_ROD_HOUSE
	dw 6
	db 2, 6
	dw .Node6 ; OLIVINE_CAFE
	dw 7
	db 2, 6
	dw .Node7 ; OLIVINE_MART
	dw 8
	db 0, 3
	dw .Node8 ; ROUTE_38_ECRUTEAK_GATE
	dw 9
	db 3, 6
	dw .Node9 ; ROUTE_39_BARN
	dw 10
	db 2, 6
	dw .Node10 ; ROUTE_39_FARMHOUSE
	dw 11
	db 0, 6
	dw .Node11 ; ROUTE_38
	dw 11
	db 35, 7
	dw .Node12 ; ROUTE_38
	dw 11
	db 0, 13
	dw .Node13 ; ROUTE_38
	dw 12
	db 1, 4
	dw .Node14 ; ROUTE_39
	dw 12
	db 19, 6
	dw .Node15 ; ROUTE_39
	dw 12
	db 19, 13
	dw .Node16 ; ROUTE_39
	dw 12
	db 6, 35
	dw .Node17 ; ROUTE_39
	dw 12
	db 13, 35
	dw .Node18 ; ROUTE_39
	dw 13
	db 16, 0
	dw .Node19 ; OLIVINE_CITY
	dw 13
	db 13, 22
	dw .Node20 ; OLIVINE_CITY
	dw 13
	db 23, 0
	dw .Node21 ; OLIVINE_CITY
	dw 13
	db 0, 20
	dw .Node22 ; OLIVINE_CITY
	dw 13
	db 0, 26
	dw .Node23 ; OLIVINE_CITY
	dw 14
	db 2, 6
	dw .Node24 ; MAHOGANY_RED_GYARADOS_SPEECH_HOUSE
	dw 15
	db 4, 16
	dw .Node25 ; MAHOGANY_GYM
	dw 16
	db 3, 6
	dw .Node26 ; MAHOGANY_POKECENTER_1F
	dw 17
	db 0, 3
	dw .Node27 ; ROUTE_42_ECRUTEAK_GATE
	dw 18
	db 10, 4
	dw .Node28 ; ROUTE_42
	dw 18
	db 1, 8
	dw .Node29 ; ROUTE_42
	dw 18
	db 28, 10
	dw .Node30 ; ROUTE_42
	dw 18
	db 46, 8
	dw .Node31 ; ROUTE_42
	dw 18
	db 59, 8
	dw .Node32 ; ROUTE_42
	dw 19
	db 56, 6
	dw .Node33 ; ROUTE_44
	dw 19
	db 56, 8
	dw .Node34 ; ROUTE_44
	dw 20
	db 0, 0
	dw .Node35 ; MAHOGANY_TOWN
	dw 20
	db 11, 8
	dw .Node36 ; MAHOGANY_TOWN
	dw 20
	db 17, 0
	dw .Node37 ; MAHOGANY_TOWN
	dw 20
	db 0, 8
	dw .Node38 ; MAHOGANY_TOWN
	dw 21
	db 2, 5
	dw .Node39 ; SPROUT_TOWER_1F
	dw 21
	db 9, 14
	dw .Node40 ; SPROUT_TOWER_1F
	dw 22
	db 2, 5
	dw .Node41 ; SPROUT_TOWER_2F
	dw 22
	db 6, 3
	dw .Node42 ; SPROUT_TOWER_2F
	dw 23
	db 10, 13
	dw .Node43 ; SPROUT_TOWER_3F
	dw 24
	db 9, 14
	dw .Node44 ; TIN_TOWER_1F
	dw 25
	db 10, 13
	dw .Node45 ; TIN_TOWER_2F
	dw 26
	db 10, 13
	dw .Node46 ; TIN_TOWER_3F
	dw 27
	db 2, 3
	dw .Node47 ; TIN_TOWER_4F
	dw 28
	db 2, 15
	dw .Node48 ; TIN_TOWER_5F
	dw 28
	db 11, 14
	dw .Node49 ; TIN_TOWER_5F
	dw 28
	db 17, 14
	dw .Node50 ; TIN_TOWER_5F
	dw 28
	db 2, 3
	dw .Node51 ; TIN_TOWER_5F
	dw 29
	db 3, 8
	dw .Node52 ; TIN_TOWER_6F
	dw 30
	db 3, 8
	dw .Node53 ; TIN_TOWER_7F
	dw 30
	db 12, 6
	dw .Node54 ; TIN_TOWER_7F
	dw 31
	db 16, 6
	dw .Node55 ; TIN_TOWER_8F
	dw 31
	db 2, 4
	dw .Node56 ; TIN_TOWER_8F
	dw 31
	db 6, 8
	dw .Node57 ; TIN_TOWER_8F
	dw 31
	db 14, 14
	dw .Node58 ; TIN_TOWER_8F
	dw 32
	db 12, 2
	dw .Node59 ; TIN_TOWER_9F
	dw 32
	db 12, 6
	dw .Node60 ; TIN_TOWER_9F
	dw 32
	db 16, 6
	dw .Node61 ; TIN_TOWER_9F
	dw 33
	db 9, 14
	dw .Node62 ; BURNED_TOWER_1F
	dw 33
	db 15, 4
	dw .Node63 ; BURNED_TOWER_1F
	dw 34
	db 17, 14
	dw .Node64 ; BURNED_TOWER_B1F
	dw 34
	db 10, 9
	dw .Node65 ; BURNED_TOWER_B1F
	dw 34
	db 17, 7
	dw .Node66 ; BURNED_TOWER_B1F
	dw 35
	db 33, 17
	dw .Node67 ; NATIONAL_PARK
	dw 37
	db 2, 6
	dw .Node68 ; RADIO_TOWER_1F
	dw 38
	db 0, 1
	dw .Node69 ; RADIO_TOWER_2F
	dw 39
	db 0, 1
	dw .Node70 ; RADIO_TOWER_3F
	dw 39
	db 17, 1
	dw .Node71 ; RADIO_TOWER_3F
	dw 40
	db 0, 1
	dw .Node72 ; RADIO_TOWER_4F
	dw 40
	db 12, 1
	dw .Node73 ; RADIO_TOWER_4F
	dw 41
	db 0, 1
	dw .Node74 ; RADIO_TOWER_5F
	dw 41
	db 12, 1
	dw .Node75 ; RADIO_TOWER_5F
	dw 42
	db 14, 8
	dw .Node76 ; RUINS_OF_ALPH_OUTSIDE
	dw 42
	db 14, 6
	dw .Node77 ; RUINS_OF_ALPH_OUTSIDE
	dw 42
	db 2, 16
	dw .Node78 ; RUINS_OF_ALPH_OUTSIDE
	dw 42
	db 2, 18
	dw .Node79 ; RUINS_OF_ALPH_OUTSIDE
	dw 42
	db 2, 28
	dw .Node80 ; RUINS_OF_ALPH_OUTSIDE
	dw 42
	db 16, 34
	dw .Node81 ; RUINS_OF_ALPH_OUTSIDE
	dw 42
	db 2, 30
	dw .Node82 ; RUINS_OF_ALPH_OUTSIDE
	dw 42
	db 6, 28
	dw .Node83 ; RUINS_OF_ALPH_OUTSIDE
	dw 42
	db 16, 32
	dw .Node84 ; RUINS_OF_ALPH_OUTSIDE
	dw 43
	db 3, 8
	dw .Node85 ; RUINS_OF_ALPH_HO_OH_CHAMBER
	dw 44
	db 3, 8
	dw .Node86 ; RUINS_OF_ALPH_KABUTO_CHAMBER
	dw 45
	db 3, 8
	dw .Node87 ; RUINS_OF_ALPH_OMANYTE_CHAMBER
	dw 46
	db 3, 8
	dw .Node88 ; RUINS_OF_ALPH_AERODACTYL_CHAMBER
	dw 47
	db 10, 12
	dw .Node89 ; RUINS_OF_ALPH_INNER_CHAMBER
	dw 48
	db 2, 6
	dw .Node90 ; RUINS_OF_ALPH_RESEARCH_CENTER
	dw 49
	db 3, 8
	dw .Node91 ; RUINS_OF_ALPH_HO_OH_ITEM_ROOM
	dw 50
	db 3, 8
	dw .Node92 ; RUINS_OF_ALPH_KABUTO_ITEM_ROOM
	dw 51
	db 3, 8
	dw .Node93 ; RUINS_OF_ALPH_OMANYTE_ITEM_ROOM
	dw 52
	db 3, 8
	dw .Node94 ; RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM
	dw 53
	db 9, 9
	dw .Node95 ; RUINS_OF_ALPH_HO_OH_WORD_ROOM
	dw 54
	db 9, 5
	dw .Node96 ; RUINS_OF_ALPH_KABUTO_WORD_ROOM
	dw 55
	db 9, 7
	dw .Node97 ; RUINS_OF_ALPH_OMANYTE_WORD_ROOM
	dw 56
	db 9, 5
	dw .Node98 ; RUINS_OF_ALPH_AERODACTYL_WORD_ROOM
	dw 57
	db 5, 18
	dw .Node99 ; UNION_CAVE_1F
	dw 57
	db 3, 32
	dw .Node100 ; UNION_CAVE_1F
	dw 58
	db 3, 2
	dw .Node101 ; UNION_CAVE_B1F
	dw 58
	db 3, 10
	dw .Node102 ; UNION_CAVE_B1F
	dw 58
	db 7, 18
	dw .Node103 ; UNION_CAVE_B1F
	dw 58
	db 3, 32
	dw .Node104 ; UNION_CAVE_B1F
	dw 58
	db 17, 30
	dw .Node105 ; UNION_CAVE_B1F
	dw 59
	db 5, 2
	dw .Node106 ; UNION_CAVE_B2F
	dw 60
	db 17, 14
	dw .Node107 ; SLOWPOKE_WELL_B1F
	dw 60
	db 7, 10
	dw .Node108 ; SLOWPOKE_WELL_B1F
	dw 61
	db 9, 10
	dw .Node109 ; SLOWPOKE_WELL_B2F
	dw 62
	db 10, 16
	dw .Node110 ; OLIVINE_LIGHTHOUSE_1F
	dw 63
	db 3, 10
	dw .Node111 ; OLIVINE_LIGHTHOUSE_2F
	dw 64
	db 13, 2
	dw .Node112 ; OLIVINE_LIGHTHOUSE_3F
	dw 64
	db 9, 4
	dw .Node113 ; OLIVINE_LIGHTHOUSE_3F
	dw 65
	db 13, 2
	dw .Node114 ; OLIVINE_LIGHTHOUSE_4F
	dw 65
	db 9, 6
	dw .Node115 ; OLIVINE_LIGHTHOUSE_4F
	dw 66
	db 3, 4
	dw .Node116 ; OLIVINE_LIGHTHOUSE_5F
	dw 66
	db 9, 14
	dw .Node117 ; OLIVINE_LIGHTHOUSE_5F
	dw 67
	db 9, 14
	dw .Node118 ; OLIVINE_LIGHTHOUSE_6F
	dw 68
	db 3, 6
	dw .Node119 ; MAHOGANY_MART_1F
	dw 69
	db 27, 1
	dw .Node120 ; TEAM_ROCKET_BASE_B1F
	dw 70
	db 3, 1
	dw .Node121 ; TEAM_ROCKET_BASE_B2F
	dw 70
	db 3, 5
	dw .Node122 ; TEAM_ROCKET_BASE_B2F
	dw 70
	db 3, 13
	dw .Node123 ; TEAM_ROCKET_BASE_B2F
	dw 71
	db 3, 1
	dw .Node124 ; TEAM_ROCKET_BASE_B3F
	dw 71
	db 27, 1
	dw .Node125 ; TEAM_ROCKET_BASE_B3F
	dw 72
	db 1, 6
	dw .Node126 ; ILEX_FOREST
	dw 72
	db 3, 41
	dw .Node127 ; ILEX_FOREST
	dw 73
	db 3, 1
	dw .Node128 ; GOLDENROD_UNDERGROUND
	dw 73
	db 21, 30
	dw .Node129 ; GOLDENROD_UNDERGROUND
	dw 74
	db 23, 2
	dw .Node130 ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES
	dw 74
	db 22, 11
	dw .Node131 ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES
	dw 74
	db 5, 24
	dw .Node132 ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES
	dw 74
	db 21, 24
	dw .Node133 ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES
	dw 75
	db 17, 1
	dw .Node134 ; GOLDENROD_DEPT_STORE_B1F
	dw 75
	db 9, 5
	dw .Node135 ; GOLDENROD_DEPT_STORE_B1F
	dw 76
	db 2, 11
	dw .Node136 ; GOLDENROD_UNDERGROUND_WAREHOUSE
	dw 77
	db 17, 6
	dw .Node137 ; MOUNT_MORTAR_1F_OUTSIDE
	dw 77
	db 17, 32
	dw .Node138 ; MOUNT_MORTAR_1F_OUTSIDE
	dw 77
	db 33, 12
	dw .Node139 ; MOUNT_MORTAR_1F_OUTSIDE
	dw 77
	db 7, 12
	dw .Node140 ; MOUNT_MORTAR_1F_OUTSIDE
	dw 77
	db 3, 32
	dw .Node141 ; MOUNT_MORTAR_1F_OUTSIDE
	dw 77
	db 37, 32
	dw .Node142 ; MOUNT_MORTAR_1F_OUTSIDE
	dw 78
	db 11, 46
	dw .Node143 ; MOUNT_MORTAR_1F_INSIDE
	dw 78
	db 3, 18
	dw .Node144 ; MOUNT_MORTAR_1F_INSIDE
	dw 79
	db 3, 4
	dw .Node145 ; MOUNT_MORTAR_2F_INSIDE
	dw 79
	db 17, 32
	dw .Node146 ; MOUNT_MORTAR_2F_INSIDE
	dw 80
	db 3, 2
	dw .Node147 ; MOUNT_MORTAR_B1F
	dw 80
	db 19, 28
	dw .Node148 ; MOUNT_MORTAR_B1F
	dw 81
	db 4, 18
	dw .Node149 ; ICE_PATH_1F
	dw 81
	db 37, 4
	dw .Node150 ; ICE_PATH_1F
	dw 81
	db 36, 26
	dw .Node151 ; ICE_PATH_1F
	dw 82
	db 3, 14
	dw .Node152 ; ICE_PATH_B1F
	dw 82
	db 5, 24
	dw .Node153 ; ICE_PATH_B1F
	dw 83
	db 17, 0
	dw .Node154 ; ICE_PATH_B2F_MAHOGANY_SIDE
	dw 83
	db 4, 6
	dw .Node155 ; ICE_PATH_B2F_MAHOGANY_SIDE
	dw 83
	db 9, 17
	dw .Node156 ; ICE_PATH_B2F_MAHOGANY_SIDE
	dw 83
	db 19, 11
	dw .Node157 ; ICE_PATH_B2F_MAHOGANY_SIDE
	dw 83
	db 10, 11
	dw .Node158 ; ICE_PATH_B2F_MAHOGANY_SIDE
	dw 83
	db 9, 12
	dw .Node159 ; ICE_PATH_B2F_MAHOGANY_SIDE
	dw 84
	db 3, 14
	dw .Node160 ; ICE_PATH_B2F_BLACKTHORN_SIDE
	dw 84
	db 3, 17
	dw .Node161 ; ICE_PATH_B2F_BLACKTHORN_SIDE
	dw 84
	db 7, 15
	dw .Node162 ; ICE_PATH_B2F_BLACKTHORN_SIDE
	dw 84
	db 4, 15
	dw .Node163 ; ICE_PATH_B2F_BLACKTHORN_SIDE
	dw 84
	db 3, 16
	dw .Node164 ; ICE_PATH_B2F_BLACKTHORN_SIDE
	dw 85
	db 3, 4
	dw .Node165 ; ICE_PATH_B3F
	dw 86
	db 5, 6
	dw .Node166 ; WHIRL_ISLAND_NW
	dw 86
	db 3, 14
	dw .Node167 ; WHIRL_ISLAND_NW
	dw 87
	db 17, 2
	dw .Node168 ; WHIRL_ISLAND_NE
	dw 87
	db 13, 10
	dw .Node169 ; WHIRL_ISLAND_NE
	dw 87
	db 3, 12
	dw .Node170 ; WHIRL_ISLAND_NE
	dw 88
	db 5, 6
	dw .Node171 ; WHIRL_ISLAND_SW
	dw 88
	db 17, 2
	dw .Node172 ; WHIRL_ISLAND_SW
	dw 88
	db 3, 14
	dw .Node173 ; WHIRL_ISLAND_SW
	dw 88
	db 17, 14
	dw .Node174 ; WHIRL_ISLAND_SW
	dw 89
	db 7, 4
	dw .Node175 ; WHIRL_ISLAND_CAVE
	dw 90
	db 5, 12
	dw .Node176 ; WHIRL_ISLAND_SE
	dw 91
	db 9, 30
	dw .Node177 ; WHIRL_ISLAND_B1F
	dw 91
	db 5, 4
	dw .Node178 ; WHIRL_ISLAND_B1F
	dw 91
	db 35, 2
	dw .Node179 ; WHIRL_ISLAND_B1F
	dw 91
	db 17, 20
	dw .Node180 ; WHIRL_ISLAND_B1F
	dw 91
	db 23, 30
	dw .Node181 ; WHIRL_ISLAND_B1F
	dw 91
	db 17, 22
	dw .Node182 ; WHIRL_ISLAND_B1F
	dw 92
	db 11, 4
	dw .Node183 ; WHIRL_ISLAND_B2F
	dw 92
	db 13, 30
	dw .Node184 ; WHIRL_ISLAND_B2F
	dw 92
	db 7, 26
	dw .Node185 ; WHIRL_ISLAND_B2F
	dw 92
	db 11, 6
	dw .Node186 ; WHIRL_ISLAND_B2F
	dw 92
	db 7, 10
	dw .Node187 ; WHIRL_ISLAND_B2F
	dw 93
	db 9, 12
	dw .Node188 ; WHIRL_ISLAND_LUGIA_CHAMBER
	dw 94
	db 15, 0
	dw .Node189 ; SILVER_CAVE_ROOM_1
	dw 94
	db 9, 32
	dw .Node190 ; SILVER_CAVE_ROOM_1
	dw 95
	db 23, 4
	dw .Node191 ; SILVER_CAVE_ROOM_2
	dw 95
	db 17, 30
	dw .Node192 ; SILVER_CAVE_ROOM_2
	dw 95
	db 13, 22
	dw .Node193 ; SILVER_CAVE_ROOM_2
	dw 96
	db 9, 32
	dw .Node194 ; SILVER_CAVE_ROOM_3
	dw 97
	db 13, 2
	dw .Node195 ; SILVER_CAVE_ITEM_ROOMS
	dw 97
	db 7, 14
	dw .Node196 ; SILVER_CAVE_ITEM_ROOMS
	dw 98
	db 17, 0
	dw .Node197 ; DARK_CAVE_VIOLET_ENTRANCE
	dw 98
	db 17, 2
	dw .Node198 ; DARK_CAVE_VIOLET_ENTRANCE
	dw 98
	db 3, 14
	dw .Node199 ; DARK_CAVE_VIOLET_ENTRANCE
	dw 98
	db 35, 32
	dw .Node200 ; DARK_CAVE_VIOLET_ENTRANCE
	dw 99
	db 3, 24
	dw .Node201 ; DARK_CAVE_BLACKTHORN_ENTRANCE
	dw 99
	db 23, 2
	dw .Node202 ; DARK_CAVE_BLACKTHORN_ENTRANCE
	dw 100
	db 3, 4
	dw .Node203 ; DRAGONS_DEN_1F
	dw 100
	db 5, 14
	dw .Node204 ; DRAGONS_DEN_1F
	dw 101
	db 20, 2
	dw .Node205 ; DRAGONS_DEN_B1F
	dw 101
	db 20, 4
	dw .Node206 ; DRAGONS_DEN_B1F
	dw 101
	db 19, 30
	dw .Node207 ; DRAGONS_DEN_B1F
	dw 102
	db 4, 8
	dw .Node208 ; DRAGON_SHRINE
	dw 103
	db 13, 14
	dw .Node209 ; TOHJO_FALLS
	dw 103
	db 25, 14
	dw .Node210 ; TOHJO_FALLS
	dw 104
	db 17, 32
	dw .Node211 ; DIGLETTS_CAVE
	dw 104
	db 15, 4
	dw .Node212 ; DIGLETTS_CAVE
	dw 104
	db 3, 32
	dw .Node213 ; DIGLETTS_CAVE
	dw 105
	db 3, 2
	dw .Node214 ; MOUNT_MOON
	dw 105
	db 25, 4
	dw .Node215 ; MOUNT_MOON
	dw 105
	db 15, 10
	dw .Node216 ; MOUNT_MOON
	dw 105
	db 25, 14
	dw .Node217 ; MOUNT_MOON
	dw 106
	db 3, 1
	dw .Node218 ; UNDERGROUND_PATH
	dw 107
	db 5, 2
	dw .Node219 ; ROCK_TUNNEL_1F
	dw 107
	db 15, 2
	dw .Node220 ; ROCK_TUNNEL_1F
	dw 107
	db 11, 24
	dw .Node221 ; ROCK_TUNNEL_1F
	dw 108
	db 3, 2
	dw .Node222 ; ROCK_TUNNEL_B1F
	dw 108
	db 23, 2
	dw .Node223 ; ROCK_TUNNEL_B1F
	dw 109
	db 4, 1
	dw .Node224 ; SAFARI_ZONE_FUCHSIA_GATE_BETA
	dw 110
	db 9, 23
	dw .Node225 ; SAFARI_ZONE_BETA
	dw 111
	db 13, 4
	dw .Node226 ; VICTORY_ROAD
	dw 111
	db 17, 18
	dw .Node227 ; VICTORY_ROAD
	dw 111
	db 13, 16
	dw .Node228 ; VICTORY_ROAD
	dw 111
	db 1, 34
	dw .Node229 ; VICTORY_ROAD
	dw 111
	db 0, 27
	dw .Node230 ; VICTORY_ROAD
	dw 111
	db 17, 32
	dw .Node231 ; VICTORY_ROAD
	dw 111
	db 9, 66
	dw .Node232 ; VICTORY_ROAD
	dw 112
	db 4, 16
	dw .Node233 ; ECRUTEAK_TIN_TOWER_ENTRANCE
	dw 112
	db 17, 14
	dw .Node234 ; ECRUTEAK_TIN_TOWER_ENTRANCE
	dw 113
	db 7, 3
	dw .Node235 ; WISE_TRIOS_ROOM
	dw 114
	db 3, 6
	dw .Node236 ; ECRUTEAK_POKECENTER_1F
	dw 115
	db 3, 6
	dw .Node237 ; ECRUTEAK_LUGIA_SPEECH_HOUSE
	dw 116
	db 5, 12
	dw .Node238 ; DANCE_THEATER
	dw 117
	db 2, 6
	dw .Node239 ; ECRUTEAK_MART
	dw 118
	db 4, 16
	dw .Node240 ; ECRUTEAK_GYM
	dw 119
	db 3, 6
	dw .Node241 ; ECRUTEAK_ITEMFINDER_HOUSE
	dw 120
	db 21, 2
	dw .Node242 ; ECRUTEAK_CITY
	dw 120
	db 34, 26
	dw .Node243 ; ECRUTEAK_CITY
	dw 121
	db 4, 16
	dw .Node244 ; BLACKTHORN_GYM_1F
	dw 121
	db 7, 8
	dw .Node245 ; BLACKTHORN_GYM_1F
	dw 122
	db 1, 6
	dw .Node246 ; BLACKTHORN_GYM_2F
	dw 123
	db 2, 6
	dw .Node247 ; BLACKTHORN_DRAGON_SPEECH_HOUSE
	dw 124
	db 2, 6
	dw .Node248 ; BLACKTHORN_EMYS_HOUSE
	dw 125
	db 2, 6
	dw .Node249 ; BLACKTHORN_MART
	dw 126
	db 3, 6
	dw .Node250 ; BLACKTHORN_POKECENTER_1F
	dw 127
	db 2, 6
	dw .Node251 ; MOVE_DELETERS_HOUSE
	dw 128
	db 2, 4
	dw .Node252 ; ROUTE_45
	dw 128
	db 0, 76
	dw .Node253 ; ROUTE_45
	dw 128
	db 2, 6
	dw .Node254 ; ROUTE_45
	dw 128
	db 15, 0
	dw .Node255 ; ROUTE_45
	dw 129
	db 14, 4
	dw .Node256 ; ROUTE_46
	dw 129
	db 7, 32
	dw .Node257 ; ROUTE_46
	dw 129
	db 14, 6
	dw .Node258 ; ROUTE_46
	dw 129
	db 19, 10
	dw .Node259 ; ROUTE_46
	dw 130
	db 36, 8
	dw .Node260 ; BLACKTHORN_CITY
	dw 130
	db 20, 2
	dw .Node261 ; BLACKTHORN_CITY
	dw 130
	db 18, 12
	dw .Node262 ; BLACKTHORN_CITY
	dw 131
	db 3, 6
	dw .Node263 ; CINNABAR_POKECENTER_1F
	dw 133
	db 4, 1
	dw .Node264 ; ROUTE_19_FUCHSIA_GATE
	dw 134
	db 5, 4
	dw .Node265 ; SEAFOAM_GYM
	dw 135
	db 1, 0
	dw .Node266 ; ROUTE_19
	dw 135
	db 10, 0
	dw .Node267 ; ROUTE_19
	dw 135
	db 15, 0
	dw .Node268 ; ROUTE_19
	dw 135
	db 7, 4
	dw .Node269 ; ROUTE_19
	dw 135
	db 0, 20
	dw .Node270 ; ROUTE_19
	dw 136
	db 0, 16
	dw .Node271 ; ROUTE_20
	dw 136
	db 38, 6
	dw .Node272 ; ROUTE_20
	dw 137
	db 4, 0
	dw .Node273 ; ROUTE_21
	dw 137
	db 16, 35
	dw .Node274 ; ROUTE_21
	dw 138
	db 11, 12
	dw .Node275 ; CINNABAR_ISLAND
	dw 138
	db 1, 0
	dw .Node276 ; CINNABAR_ISLAND
	dw 138
	db 11, 0
	dw .Node277 ; CINNABAR_ISLAND
	dw 139
	db 2, 6
	dw .Node278 ; CERULEAN_GYM_BADGE_SPEECH_HOUSE
	dw 140
	db 2, 6
	dw .Node279 ; CERULEAN_POLICE_STATION
	dw 141
	db 2, 6
	dw .Node280 ; CERULEAN_TRADE_SPEECH_HOUSE
	dw 142
	db 3, 6
	dw .Node281 ; CERULEAN_POKECENTER_1F
	dw 144
	db 4, 14
	dw .Node282 ; CERULEAN_GYM
	dw 145
	db 2, 6
	dw .Node283 ; CERULEAN_MART
	dw 146
	db 3, 6
	dw .Node284 ; ROUTE_10_POKECENTER_1F
	dw 148
	db 2, 16
	dw .Node285 ; POWER_PLANT
	dw 149
	db 2, 6
	dw .Node286 ; BILLS_HOUSE
	dw 150
	db 2, 4
	dw .Node287 ; ROUTE_4
	dw 150
	db 39, 10
	dw .Node288 ; ROUTE_4
	dw 150
	db 2, 6
	dw .Node289 ; ROUTE_4
	dw 150
	db 39, 4
	dw .Node290 ; ROUTE_4
	dw 150
	db 39, 13
	dw .Node291 ; ROUTE_4
	dw 151
	db 0, 0
	dw .Node292 ; ROUTE_9
	dw 151
	db 59, 17
	dw .Node293 ; ROUTE_9
	dw 151
	db 54, 17
	dw .Node294 ; ROUTE_9
	dw 151
	db 56, 17
	dw .Node295 ; ROUTE_9
	dw 151
	db 0, 4
	dw .Node296 ; ROUTE_9
	dw 151
	db 0, 6
	dw .Node297 ; ROUTE_9
	dw 151
	db 48, 14
	dw .Node298 ; ROUTE_9
	dw 151
	db 48, 16
	dw .Node299 ; ROUTE_9
	dw 152
	db 0, 0
	dw .Node300 ; ROUTE_10_NORTH
	dw 152
	db 11, 2
	dw .Node301 ; ROUTE_10_NORTH
	dw 152
	db 3, 10
	dw .Node302 ; ROUTE_10_NORTH
	dw 152
	db 16, 0
	dw .Node303 ; ROUTE_10_NORTH
	dw 153
	db 0, 0
	dw .Node304 ; ROUTE_24
	dw 153
	db 2, 0
	dw .Node305 ; ROUTE_24
	dw 153
	db 4, 0
	dw .Node306 ; ROUTE_24
	dw 153
	db 8, 0
	dw .Node307 ; ROUTE_24
	dw 153
	db 9, 0
	dw .Node308 ; ROUTE_24
	dw 153
	db 11, 0
	dw .Node309 ; ROUTE_24
	dw 153
	db 15, 0
	dw .Node310 ; ROUTE_24
	dw 153
	db 15, 17
	dw .Node311 ; ROUTE_24
	dw 153
	db 8, 17
	dw .Node312 ; ROUTE_24
	dw 153
	db 9, 17
	dw .Node313 ; ROUTE_24
	dw 154
	db 0, 17
	dw .Node314 ; ROUTE_25
	dw 154
	db 47, 6
	dw .Node315 ; ROUTE_25
	dw 154
	db 15, 17
	dw .Node316 ; ROUTE_25
	dw 154
	db 4, 17
	dw .Node317 ; ROUTE_25
	dw 154
	db 8, 17
	dw .Node318 ; ROUTE_25
	dw 154
	db 9, 17
	dw .Node319 ; ROUTE_25
	dw 155
	db 12, 0
	dw .Node320 ; CERULEAN_CITY
	dw 155
	db 16, 0
	dw .Node321 ; CERULEAN_CITY
	dw 155
	db 20, 0
	dw .Node322 ; CERULEAN_CITY
	dw 155
	db 21, 0
	dw .Node323 ; CERULEAN_CITY
	dw 155
	db 7, 16
	dw .Node324 ; CERULEAN_CITY
	dw 155
	db 23, 0
	dw .Node325 ; CERULEAN_CITY
	dw 155
	db 39, 18
	dw .Node326 ; CERULEAN_CITY
	dw 155
	db 27, 0
	dw .Node327 ; CERULEAN_CITY
	dw 155
	db 0, 23
	dw .Node328 ; CERULEAN_CITY
	dw 155
	db 39, 24
	dw .Node329 ; CERULEAN_CITY
	dw 156
	db 3, 6
	dw .Node330 ; AZALEA_POKECENTER_1F
	dw 157
	db 2, 6
	dw .Node331 ; CHARCOAL_KILN
	dw 158
	db 2, 6
	dw .Node332 ; AZALEA_MART
	dw 159
	db 3, 6
	dw .Node333 ; KURTS_HOUSE
	dw 160
	db 4, 14
	dw .Node334 ; AZALEA_GYM
	dw 161
	db 11, 8
	dw .Node335 ; ROUTE_33
	dw 161
	db 11, 10
	dw .Node336 ; ROUTE_33
	dw 162
	db 15, 10
	dw .Node337 ; AZALEA_TOWN
	dw 162
	db 39, 0
	dw .Node338 ; AZALEA_TOWN
	dw 163
	db 2, 6
	dw .Node339 ; LAKE_OF_RAGE_HIDDEN_POWER_HOUSE
	dw 164
	db 2, 6
	dw .Node340 ; LAKE_OF_RAGE_MAGIKARP_HOUSE
	dw 165
	db 4, 1
	dw .Node341 ; ROUTE_43_MAHOGANY_GATE
	dw 166
	db 4, 1
	dw .Node342 ; ROUTE_43_GATE
	dw 167
	db 9, 50
	dw .Node343 ; ROUTE_43
	dw 167
	db 0, 53
	dw .Node344 ; ROUTE_43
	dw 167
	db 17, 53
	dw .Node345 ; ROUTE_43
	dw 168
	db 7, 4
	dw .Node346 ; LAKE_OF_RAGE
	dw 168
	db 27, 32
	dw .Node347 ; LAKE_OF_RAGE
	dw 168
	db 10, 35
	dw .Node348 ; LAKE_OF_RAGE
	dw 169
	db 11, 74
	dw .Node349 ; ROUTE_32
	dw 169
	db 6, 78
	dw .Node350 ; ROUTE_32
	dw 170
	db 17, 0
	dw .Node351 ; ROUTE_35
	dw 170
	db 9, 32
	dw .Node352 ; ROUTE_35
	dw 170
	db 4, 35
	dw .Node353 ; ROUTE_35
	dw 170
	db 13, 35
	dw .Node354 ; ROUTE_35
	dw 171
	db 19, 8
	dw .Node355 ; ROUTE_36
	dw 172
	db 7, 0
	dw .Node356 ; ROUTE_37
	dw 173
	db 9, 18
	dw .Node357 ; VIOLET_CITY
	dw 174
	db 2, 6
	dw .Node358 ; VIOLET_MART
	dw 175
	db 4, 14
	dw .Node359 ; VIOLET_GYM
	dw 176
	db 3, 14
	dw .Node360 ; EARLS_POKEMON_ACADEMY
	dw 177
	db 3, 6
	dw .Node361 ; VIOLET_NICKNAME_SPEECH_HOUSE
	dw 178
	db 3, 6
	dw .Node362 ; VIOLET_POKECENTER_1F
	dw 179
	db 3, 6
	dw .Node363 ; VIOLET_KYLES_HOUSE
	dw 180
	db 0, 3
	dw .Node364 ; ROUTE_32_RUINS_OF_ALPH_GATE
	dw 181
	db 3, 6
	dw .Node365 ; ROUTE_32_POKECENTER_1F
	dw 182
	db 4, 1
	dw .Node366 ; ROUTE_35_GOLDENROD_GATE
	dw 183
	db 3, 1
	dw .Node367 ; ROUTE_35_NATIONAL_PARK_GATE
	dw 184
	db 4, 1
	dw .Node368 ; ROUTE_36_RUINS_OF_ALPH_GATE
	dw 185
	db 0, 3
	dw .Node369 ; ROUTE_36_NATIONAL_PARK_GATE
	dw 185
	db 1, 4
	dw .Node370 ; ROUTE_36_NATIONAL_PARK_GATE
	dw 186
	db 4, 0
	dw .Node371 ; ROUTE_34
	dw 186
	db 2, 0
	dw .Node372 ; ROUTE_34
	dw 186
	db 13, 36
	dw .Node373 ; ROUTE_34
	dw 186
	db 13, 0
	dw .Node374 ; ROUTE_34
	dw 186
	db 13, 16
	dw .Node375 ; ROUTE_34
	dw 187
	db 14, 0
	dw .Node376 ; GOLDENROD_CITY
	dw 187
	db 24, 8
	dw .Node377 ; GOLDENROD_CITY
	dw 187
	db 23, 0
	dw .Node378 ; GOLDENROD_CITY
	dw 187
	db 12, 35
	dw .Node379 ; GOLDENROD_CITY
	dw 187
	db 23, 35
	dw .Node380 ; GOLDENROD_CITY
	dw 188
	db 2, 16
	dw .Node381 ; GOLDENROD_GYM
	dw 189
	db 2, 6
	dw .Node382 ; GOLDENROD_BIKE_SHOP
	dw 189
	db 1, 7
	dw .Node383 ; GOLDENROD_BIKE_SHOP
	dw 190
	db 2, 6
	dw .Node384 ; GOLDENROD_HAPPINESS_RATER
	dw 191
	db 2, 6
	dw .Node385 ; BILLS_FAMILYS_HOUSE
	dw 192
	db 8, 16
	dw .Node386 ; GOLDENROD_MAGNET_TRAIN_STATION
	dw 193
	db 2, 6
	dw .Node387 ; GOLDENROD_FLOWER_SHOP
	dw 194
	db 2, 6
	dw .Node388 ; GOLDENROD_PP_SPEECH_HOUSE
	dw 195
	db 2, 6
	dw .Node389 ; GOLDENROD_NAME_RATER
	dw 196
	db 7, 6
	dw .Node390 ; GOLDENROD_DEPT_STORE_1F
	dw 197
	db 12, 1
	dw .Node391 ; GOLDENROD_DEPT_STORE_2F
	dw 198
	db 12, 1
	dw .Node392 ; GOLDENROD_DEPT_STORE_3F
	dw 199
	db 12, 1
	dw .Node393 ; GOLDENROD_DEPT_STORE_4F
	dw 200
	db 12, 1
	dw .Node394 ; GOLDENROD_DEPT_STORE_5F
	dw 201
	db 15, 1
	dw .Node395 ; GOLDENROD_DEPT_STORE_6F
	dw 202
	db 1, 2
	dw .Node396 ; GOLDENROD_DEPT_STORE_ELEVATOR
	dw 203
	db 13, 0
	dw .Node397 ; GOLDENROD_DEPT_STORE_ROOF
	dw 204
	db 2, 12
	dw .Node398 ; GOLDENROD_GAME_CORNER
	dw 205
	db 3, 6
	dw .Node399 ; GOLDENROD_POKECENTER_1F
	dw 207
	db 0, 3
	dw .Node400 ; ILEX_FOREST_AZALEA_GATE
	dw 208
	db 4, 1
	dw .Node401 ; ROUTE_34_ILEX_FOREST_GATE
	dw 209
	db 0, 4
	dw .Node402 ; DAY_CARE
	dw 210
	db 17, 4
	dw .Node403 ; ROUTE_6
	dw 210
	db 0, 17
	dw .Node404 ; ROUTE_6
	dw 210
	db 9, 17
	dw .Node405 ; ROUTE_6
	dw 211
	db 0, 8
	dw .Node406 ; ROUTE_11
	dw 212
	db 10, 0
	dw .Node407 ; VERMILION_CITY
	dw 212
	db 5, 6
	dw .Node408 ; VERMILION_CITY
	dw 212
	db 19, 0
	dw .Node409 ; VERMILION_CITY
	dw 212
	db 10, 20
	dw .Node410 ; VERMILION_CITY
	dw 212
	db 34, 6
	dw .Node411 ; VERMILION_CITY
	dw 213
	db 2, 6
	dw .Node412 ; VERMILION_FISHING_SPEECH_HOUSE
	dw 214
	db 3, 6
	dw .Node413 ; VERMILION_POKECENTER_1F
	dw 216
	db 2, 6
	dw .Node414 ; POKEMON_FAN_CLUB
	dw 217
	db 2, 6
	dw .Node415 ; VERMILION_MAGNET_TRAIN_SPEECH_HOUSE
	dw 218
	db 2, 6
	dw .Node416 ; VERMILION_MART
	dw 219
	db 2, 6
	dw .Node417 ; VERMILION_DIGLETTS_CAVE_SPEECH_HOUSE
	dw 220
	db 4, 16
	dw .Node418 ; VERMILION_GYM
	dw 221
	db 4, 1
	dw .Node419 ; ROUTE_6_SAFFRON_GATE
	dw 222
	db 3, 6
	dw .Node420 ; ROUTE_6_UNDERGROUND_PATH_ENTRANCE
	dw 223
	db 0, 0
	dw .Node421 ; ROUTE_1
	dw 223
	db 2, 0
	dw .Node422 ; ROUTE_1
	dw 223
	db 8, 0
	dw .Node423 ; ROUTE_1
	dw 223
	db 11, 0
	dw .Node424 ; ROUTE_1
	dw 223
	db 17, 0
	dw .Node425 ; ROUTE_1
	dw 223
	db 2, 35
	dw .Node426 ; ROUTE_1
	dw 223
	db 11, 35
	dw .Node427 ; ROUTE_1
	dw 224
	db 0, 0
	dw .Node428 ; PALLET_TOWN
	dw 224
	db 4, 0
	dw .Node429 ; PALLET_TOWN
	dw 224
	db 5, 6
	dw .Node430 ; PALLET_TOWN
	dw 224
	db 11, 0
	dw .Node431 ; PALLET_TOWN
	dw 224
	db 19, 0
	dw .Node432 ; PALLET_TOWN
	dw 224
	db 4, 17
	dw .Node433 ; PALLET_TOWN
	dw 225
	db 2, 6
	dw .Node434 ; REDS_HOUSE_1F
	dw 226
	db 7, 1
	dw .Node435 ; REDS_HOUSE_2F
	dw 227
	db 2, 6
	dw .Node436 ; BLUES_HOUSE
	dw 228
	db 4, 10
	dw .Node437 ; OAKS_LAB
	dw 229
	db 52, 0
	dw .Node438 ; ROUTE_3
	dw 229
	db 52, 2
	dw .Node439 ; ROUTE_3
	dw 229
	db 0, 10
	dw .Node440 ; ROUTE_3
	dw 230
	db 29, 14
	dw .Node441 ; PEWTER_CITY
	dw 230
	db 39, 10
	dw .Node442 ; PEWTER_CITY
	dw 230
	db 39, 20
	dw .Node443 ; PEWTER_CITY
	dw 230
	db 39, 26
	dw .Node444 ; PEWTER_CITY
	dw 231
	db 2, 6
	dw .Node445 ; PEWTER_NIDORAN_SPEECH_HOUSE
	dw 232
	db 4, 12
	dw .Node446 ; PEWTER_GYM
	dw 233
	db 2, 6
	dw .Node447 ; PEWTER_MART
	dw 234
	db 3, 6
	dw .Node448 ; PEWTER_POKECENTER_1F
	dw 236
	db 2, 6
	dw .Node449 ; PEWTER_SNOOZE_SPEECH_HOUSE
	dw 237
	db 11, 8
	dw .Node450 ; OLIVINE_PORT
	dw 237
	db 7, 22
	dw .Node451 ; OLIVINE_PORT
	dw 237
	db 7, 24
	dw .Node452 ; OLIVINE_PORT
	dw 238
	db 9, 6
	dw .Node453 ; VERMILION_PORT
	dw 238
	db 7, 18
	dw .Node454 ; VERMILION_PORT
	dw 238
	db 7, 16
	dw .Node455 ; VERMILION_PORT
	dw 239
	db 25, 2
	dw .Node456 ; FAST_SHIP_1F
	dw 239
	db 3, 14
	dw .Node457 ; FAST_SHIP_1F
	dw 240
	db 2, 1
	dw .Node458 ; FAST_SHIP_CABINS_NNW_NNE_NE
	dw 240
	db 2, 13
	dw .Node459 ; FAST_SHIP_CABINS_NNW_NNE_NE
	dw 240
	db 2, 25
	dw .Node460 ; FAST_SHIP_CABINS_NNW_NNE_NE
	dw 241
	db 2, 1
	dw .Node461 ; FAST_SHIP_CABINS_SW_SSW_NW
	dw 241
	db 2, 18
	dw .Node462 ; FAST_SHIP_CABINS_SW_SSW_NW
	dw 241
	db 2, 30
	dw .Node463 ; FAST_SHIP_CABINS_SW_SSW_NW
	dw 242
	db 2, 6
	dw .Node464 ; FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN
	dw 242
	db 2, 18
	dw .Node465 ; FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN
	dw 242
	db 2, 32
	dw .Node466 ; FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN
	dw 243
	db 5, 10
	dw .Node467 ; FAST_SHIP_B1F
	dw 244
	db 3, 1
	dw .Node468 ; OLIVINE_PORT_PASSAGE
	dw 244
	db 15, 1
	dw .Node469 ; OLIVINE_PORT_PASSAGE
	dw 245
	db 3, 1
	dw .Node470 ; VERMILION_PORT_PASSAGE
	dw 245
	db 15, 1
	dw .Node471 ; VERMILION_PORT_PASSAGE
	dw 246
	db 20, 4
	dw .Node472 ; MOUNT_MOON_SQUARE
	dw 246
	db 20, 6
	dw .Node473 ; MOUNT_MOON_SQUARE
	dw 247
	db 3, 6
	dw .Node474 ; MOUNT_MOON_GIFT_SHOP
	dw 248
	db 9, 12
	dw .Node475 ; TIN_TOWER_ROOF
	dw 249
	db 9, 6
	dw .Node476 ; ROUTE_23
	dw 250
	db 5, 12
	dw .Node477 ; INDIGO_PLATEAU_POKECENTER_1F
	dw 251
	db 5, 16
	dw .Node478 ; WILLS_ROOM
	dw 252
	db 4, 16
	dw .Node479 ; KOGAS_ROOM
	dw 253
	db 4, 16
	dw .Node480 ; BRUNOS_ROOM
	dw 254
	db 4, 16
	dw .Node481 ; KARENS_ROOM
	dw 255
	db 4, 23
	dw .Node482 ; LANCES_ROOM
	dw 257
	db 0, 17
	dw .Node483 ; ROUTE_13
	dw 257
	db 40, 0
	dw .Node484 ; ROUTE_13
	dw 257
	db 54, 0
	dw .Node485 ; ROUTE_13
	dw 257
	db 55, 0
	dw .Node486 ; ROUTE_13
	dw 257
	db 11, 17
	dw .Node487 ; ROUTE_13
	dw 257
	db 56, 0
	dw .Node488 ; ROUTE_13
	dw 258
	db 0, 0
	dw .Node489 ; ROUTE_14
	dw 258
	db 11, 0
	dw .Node490 ; ROUTE_14
	dw 258
	db 0, 33
	dw .Node491 ; ROUTE_14
	dw 258
	db 0, 22
	dw .Node492 ; ROUTE_14
	dw 259
	db 3, 4
	dw .Node493 ; ROUTE_15
	dw 259
	db 39, 4
	dw .Node494 ; ROUTE_15
	dw 259
	db 39, 15
	dw .Node495 ; ROUTE_15
	dw 260
	db 0, 2
	dw .Node496 ; ROUTE_18
	dw 260
	db 3, 6
	dw .Node497 ; ROUTE_18
	dw 260
	db 0, 10
	dw .Node498 ; ROUTE_18
	dw 261
	db 5, 14
	dw .Node499 ; FUCHSIA_CITY
	dw 261
	db 22, 14
	dw .Node500 ; FUCHSIA_CITY
	dw 261
	db 15, 35
	dw .Node501 ; FUCHSIA_CITY
	dw 261
	db 1, 35
	dw .Node502 ; FUCHSIA_CITY
	dw 262
	db 2, 6
	dw .Node503 ; FUCHSIA_MART
	dw 263
	db 2, 6
	dw .Node504 ; SAFARI_ZONE_MAIN_OFFICE
	dw 264
	db 4, 16
	dw .Node505 ; FUCHSIA_GYM
	dw 265
	db 2, 6
	dw .Node506 ; BILLS_OLDER_SISTERS_HOUSE
	dw 266
	db 3, 6
	dw .Node507 ; FUCHSIA_POKECENTER_1F
	dw 268
	db 2, 6
	dw .Node508 ; SAFARI_ZONE_WARDENS_HOME
	dw 269
	db 0, 3
	dw .Node509 ; ROUTE_15_FUCHSIA_GATE
	dw 270
	db 39, 0
	dw .Node510 ; ROUTE_8
	dw 270
	db 5, 4
	dw .Node511 ; ROUTE_8
	dw 270
	db 39, 16
	dw .Node512 ; ROUTE_8
	dw 271
	db 0, 0
	dw .Node513 ; ROUTE_12
	dw 271
	db 8, 0
	dw .Node514 ; ROUTE_12
	dw 271
	db 11, 0
	dw .Node515 ; ROUTE_12
	dw 271
	db 11, 34
	dw .Node516 ; ROUTE_12
	dw 271
	db 0, 26
	dw .Node517 ; ROUTE_12
	dw 271
	db 16, 53
	dw .Node518 ; ROUTE_12
	dw 271
	db 0, 53
	dw .Node519 ; ROUTE_12
	dw 271
	db 14, 53
	dw .Node520 ; ROUTE_12
	dw 271
	db 15, 53
	dw .Node521 ; ROUTE_12
	dw 272
	db 6, 0
	dw .Node522 ; ROUTE_10_SOUTH
	dw 272
	db 6, 2
	dw .Node523 ; ROUTE_10_SOUTH
	dw 273
	db 0, 0
	dw .Node524 ; LAVENDER_TOWN
	dw 273
	db 5, 6
	dw .Node525 ; LAVENDER_TOWN
	dw 273
	db 18, 0
	dw .Node526 ; LAVENDER_TOWN
	dw 273
	db 0, 17
	dw .Node527 ; LAVENDER_TOWN
	dw 274
	db 3, 6
	dw .Node528 ; LAVENDER_POKECENTER_1F
	dw 276
	db 2, 6
	dw .Node529 ; MR_FUJIS_HOUSE
	dw 277
	db 2, 6
	dw .Node530 ; LAVENDER_SPEECH_HOUSE
	dw 278
	db 2, 6
	dw .Node531 ; LAVENDER_NAME_RATER
	dw 279
	db 2, 6
	dw .Node532 ; LAVENDER_MART
	dw 280
	db 4, 6
	dw .Node533 ; SOUL_HOUSE
	dw 280
	db 3, 7
	dw .Node534 ; SOUL_HOUSE
	dw 280
	db 6, 7
	dw .Node535 ; SOUL_HOUSE
	dw 281
	db 2, 6
	dw .Node536 ; LAV_RADIO_TOWER_1F
	dw 282
	db 0, 3
	dw .Node537 ; ROUTE_8_SAFFRON_GATE
	dw 283
	db 2, 6
	dw .Node538 ; ROUTE_12_SUPER_ROD_HOUSE
	dw 284
	db 0, 0
	dw .Node539 ; ROUTE_28
	dw 284
	db 33, 6
	dw .Node540 ; ROUTE_28
	dw 284
	db 7, 4
	dw .Node541 ; ROUTE_28
	dw 285
	db 18, 10
	dw .Node542 ; SILVER_CAVE_OUTSIDE
	dw 285
	db 23, 20
	dw .Node543 ; SILVER_CAVE_OUTSIDE
	dw 285
	db 39, 21
	dw .Node544 ; SILVER_CAVE_OUTSIDE
	dw 286
	db 3, 6
	dw .Node545 ; SILVER_CAVE_POKECENTER_1F
	dw 287
	db 2, 6
	dw .Node546 ; ROUTE_28_STEEL_WING_HOUSE
	dw 294
	db 15, 5
	dw .Node547 ; ROUTE_7
	dw 294
	db 19, 16
	dw .Node548 ; ROUTE_7
	dw 295
	db 3, 2
	dw .Node549 ; ROUTE_16
	dw 295
	db 15, 6
	dw .Node550 ; ROUTE_16
	dw 295
	db 8, 6
	dw .Node551 ; ROUTE_16
	dw 296
	db 16, 82
	dw .Node552 ; ROUTE_17
	dw 296
	db 19, 86
	dw .Node553 ; ROUTE_17
	dw 296
	db 19, 78
	dw .Node554 ; ROUTE_17
	dw 297
	db 4, 10
	dw .Node555 ; CELADON_CITY
	dw 297
	db 10, 30
	dw .Node556 ; CELADON_CITY
	dw 298
	db 7, 6
	dw .Node557 ; CELADON_DEPT_STORE_1F
	dw 299
	db 12, 1
	dw .Node558 ; CELADON_DEPT_STORE_2F
	dw 300
	db 12, 1
	dw .Node559 ; CELADON_DEPT_STORE_3F
	dw 301
	db 12, 1
	dw .Node560 ; CELADON_DEPT_STORE_4F
	dw 302
	db 12, 1
	dw .Node561 ; CELADON_DEPT_STORE_5F
	dw 303
	db 15, 1
	dw .Node562 ; CELADON_DEPT_STORE_6F
	dw 304
	db 1, 2
	dw .Node563 ; CELADON_DEPT_STORE_ELEVATOR
	dw 305
	db 3, 1
	dw .Node564 ; CELADON_MANSION_1F
	dw 305
	db 6, 8
	dw .Node565 ; CELADON_MANSION_1F
	dw 305
	db 5, 9
	dw .Node566 ; CELADON_MANSION_1F
	dw 306
	db 0, 1
	dw .Node567 ; CELADON_MANSION_2F
	dw 306
	db 6, 1
	dw .Node568 ; CELADON_MANSION_2F
	dw 307
	db 0, 1
	dw .Node569 ; CELADON_MANSION_3F
	dw 307
	db 6, 1
	dw .Node570 ; CELADON_MANSION_3F
	dw 308
	db 1, 2
	dw .Node571 ; CELADON_MANSION_ROOF
	dw 308
	db 6, 2
	dw .Node572 ; CELADON_MANSION_ROOF
	dw 309
	db 2, 6
	dw .Node573 ; CELADON_MANSION_ROOF_HOUSE
	dw 310
	db 3, 6
	dw .Node574 ; CELADON_POKECENTER_1F
	dw 312
	db 14, 12
	dw .Node575 ; CELADON_GAME_CORNER
	dw 313
	db 2, 4
	dw .Node576 ; CELADON_GAME_CORNER_PRIZE_ROOM
	dw 314
	db 4, 16
	dw .Node577 ; CELADON_GYM
	dw 315
	db 6, 6
	dw .Node578 ; CELADON_CAFE
	dw 316
	db 2, 6
	dw .Node579 ; ROUTE_16_FUCHSIA_SPEECH_HOUSE
	dw 317
	db 0, 3
	dw .Node580 ; ROUTE_16_GATE
	dw 318
	db 0, 3
	dw .Node581 ; ROUTE_7_SAFFRON_GATE
	dw 319
	db 0, 3
	dw .Node582 ; ROUTE_17_ROUTE_18_GATE
	dw 320
	db 19, 2
	dw .Node583 ; ROUTE_40
	dw 320
	db 19, 4
	dw .Node584 ; ROUTE_40
	dw 320
	db 2, 35
	dw .Node585 ; ROUTE_40
	dw 321
	db 32, 0
	dw .Node586 ; ROUTE_41
	dw 321
	db 36, 20
	dw .Node587 ; ROUTE_41
	dw 321
	db 12, 16
	dw .Node588 ; ROUTE_41
	dw 321
	db 12, 18
	dw .Node589 ; ROUTE_41
	dw 321
	db 36, 18
	dw .Node590 ; ROUTE_41
	dw 321
	db 12, 38
	dw .Node591 ; ROUTE_41
	dw 321
	db 36, 46
	dw .Node592 ; ROUTE_41
	dw 321
	db 12, 36
	dw .Node593 ; ROUTE_41
	dw 321
	db 36, 44
	dw .Node594 ; ROUTE_41
	dw 322
	db 17, 42
	dw .Node595 ; CIANWOOD_CITY
	dw 322
	db 29, 1
	dw .Node596 ; CIANWOOD_CITY
	dw 323
	db 2, 6
	dw .Node597 ; MANIAS_HOUSE
	dw 324
	db 4, 16
	dw .Node598 ; CIANWOOD_GYM
	dw 325
	db 3, 6
	dw .Node599 ; CIANWOOD_POKECENTER_1F
	dw 326
	db 2, 6
	dw .Node600 ; CIANWOOD_PHARMACY
	dw 327
	db 2, 6
	dw .Node601 ; CIANWOOD_PHOTO_STUDIO
	dw 328
	db 2, 6
	dw .Node602 ; CIANWOOD_LUGIA_SPEECH_HOUSE
	dw 329
	db 2, 6
	dw .Node603 ; POKE_SEERS_HOUSE
	dw 336
	db 8, 0
	dw .Node604 ; ROUTE_2
	dw 336
	db 15, 16
	dw .Node605 ; ROUTE_2
	dw 336
	db 12, 6
	dw .Node606 ; ROUTE_2
	dw 336
	db 16, 26
	dw .Node607 ; ROUTE_2
	dw 336
	db 15, 32
	dw .Node608 ; ROUTE_2
	dw 337
	db 39, 0
	dw .Node609 ; ROUTE_22
	dw 337
	db 13, 6
	dw .Node610 ; ROUTE_22
	dw 338
	db 0, 8
	dw .Node611 ; VIRIDIAN_CITY
	dw 338
	db 32, 8
	dw .Node612 ; VIRIDIAN_CITY
	dw 338
	db 0, 18
	dw .Node613 ; VIRIDIAN_CITY
	dw 338
	db 20, 35
	dw .Node614 ; VIRIDIAN_CITY
	dw 338
	db 22, 35
	dw .Node615 ; VIRIDIAN_CITY
	dw 338
	db 31, 35
	dw .Node616 ; VIRIDIAN_CITY
	dw 338
	db 37, 35
	dw .Node617 ; VIRIDIAN_CITY
	dw 339
	db 4, 16
	dw .Node618 ; VIRIDIAN_GYM
	dw 340
	db 2, 6
	dw .Node619 ; VIRIDIAN_NICKNAME_SPEECH_HOUSE
	dw 341
	db 2, 12
	dw .Node620 ; TRAINER_HOUSE_1F
	dw 342
	db 9, 3
	dw .Node621 ; TRAINER_HOUSE_B1F
	dw 343
	db 2, 6
	dw .Node622 ; VIRIDIAN_MART
	dw 344
	db 3, 6
	dw .Node623 ; VIRIDIAN_POKECENTER_1F
	dw 346
	db 2, 6
	dw .Node624 ; ROUTE_2_NUGGET_HOUSE
	dw 347
	db 4, 1
	dw .Node625 ; ROUTE_2_GATE
	dw 348
	db 17, 6
	dw .Node626 ; VICTORY_ROAD_GATE
	dw 349
	db 0, 94
	dw .Node627 ; ROUTE_26
	dw 349
	db 7, 6
	dw .Node628 ; ROUTE_26
	dw 349
	db 0, 98
	dw .Node629 ; ROUTE_26
	dw 349
	db 0, 102
	dw .Node630 ; ROUTE_26
	dw 349
	db 0, 105
	dw .Node631 ; ROUTE_26
	dw 349
	db 0, 100
	dw .Node632 ; ROUTE_26
	dw 349
	db 0, 101
	dw .Node633 ; ROUTE_26
	dw 350
	db 26, 4
	dw .Node634 ; ROUTE_27
	dw 350
	db 26, 6
	dw .Node635 ; ROUTE_27
	dw 350
	db 0, 6
	dw .Node636 ; ROUTE_27
	dw 350
	db 33, 8
	dw .Node637 ; ROUTE_27
	dw 350
	db 79, 4
	dw .Node638 ; ROUTE_27
	dw 350
	db 79, 12
	dw .Node639 ; ROUTE_27
	dw 350
	db 79, 8
	dw .Node640 ; ROUTE_27
	dw 350
	db 79, 10
	dw .Node641 ; ROUTE_27
	dw 350
	db 79, 11
	dw .Node642 ; ROUTE_27
	dw 350
	db 79, 15
	dw .Node643 ; ROUTE_27
	dw 351
	db 27, 2
	dw .Node644 ; ROUTE_29
	dw 352
	db 6, 4
	dw .Node645 ; NEW_BARK_TOWN
	dw 352
	db 19, 6
	dw .Node646 ; NEW_BARK_TOWN
	dw 353
	db 4, 10
	dw .Node647 ; ELMS_LAB
	dw 354
	db 6, 6
	dw .Node648 ; PLAYERS_HOUSE_1F
	dw 355
	db 7, 1
	dw .Node649 ; PLAYERS_HOUSE_2F
	dw 356
	db 2, 6
	dw .Node650 ; PLAYERS_NEIGHBORS_HOUSE
	dw 357
	db 2, 6
	dw .Node651 ; ELMS_HOUSE
	dw 358
	db 2, 6
	dw .Node652 ; ROUTE_26_HEAL_HOUSE
	dw 359
	db 2, 6
	dw .Node653 ; DAY_OF_WEEK_SIBLINGS_HOUSE
	dw 360
	db 2, 6
	dw .Node654 ; ROUTE_27_SANDSTORM_HOUSE
	dw 361
	db 4, 1
	dw .Node655 ; ROUTE_29_ROUTE_46_GATE
	dw 362
	db 17, 16
	dw .Node656 ; ROUTE_5
	dw 362
	db 10, 12
	dw .Node657 ; ROUTE_5
	dw 362
	db 6, 0
	dw .Node658 ; ROUTE_5
	dw 363
	db 26, 4
	dw .Node659 ; SAFFRON_CITY
	dw 363
	db 0, 34
	dw .Node660 ; SAFFRON_CITY
	dw 364
	db 4, 10
	dw .Node661 ; FIGHTING_DOJO
	dw 365
	db 5, 2
	dw .Node662 ; SAFFRON_GYM
	dw 365
	db 11, 4
	dw .Node663 ; SAFFRON_GYM
	dw 365
	db 19, 2
	dw .Node664 ; SAFFRON_GYM
	dw 365
	db 1, 10
	dw .Node665 ; SAFFRON_GYM
	dw 365
	db 11, 8
	dw .Node666 ; SAFFRON_GYM
	dw 365
	db 19, 10
	dw .Node667 ; SAFFRON_GYM
	dw 365
	db 1, 14
	dw .Node668 ; SAFFRON_GYM
	dw 365
	db 8, 16
	dw .Node669 ; SAFFRON_GYM
	dw 365
	db 19, 14
	dw .Node670 ; SAFFRON_GYM
	dw 366
	db 2, 6
	dw .Node671 ; SAFFRON_MART
	dw 367
	db 3, 6
	dw .Node672 ; SAFFRON_POKECENTER_1F
	dw 369
	db 2, 6
	dw .Node673 ; MR_PSYCHICS_HOUSE
	dw 370
	db 8, 16
	dw .Node674 ; SAFFRON_MAGNET_TRAIN_STATION
	dw 371
	db 2, 6
	dw .Node675 ; SILPH_CO_1F
	dw 372
	db 2, 6
	dw .Node676 ; COPYCATS_HOUSE_1F
	dw 373
	db 3, 1
	dw .Node677 ; COPYCATS_HOUSE_2F
	dw 374
	db 3, 6
	dw .Node678 ; ROUTE_5_UNDERGROUND_PATH_ENTRANCE
	dw 375
	db 4, 1
	dw .Node679 ; ROUTE_5_SAFFRON_GATE
	dw 376
	db 2, 6
	dw .Node680 ; ROUTE_5_CLEANSE_TAG_HOUSE
	dw 377
	db 7, 40
	dw .Node681 ; ROUTE_30
	dw 378
	db 34, 4
	dw .Node682 ; ROUTE_31
	dw 378
	db 5, 6
	dw .Node683 ; ROUTE_31
	dw 379
	db 23, 4
	dw .Node684 ; CHERRYGROVE_CITY
	dw 380
	db 2, 6
	dw .Node685 ; CHERRYGROVE_MART
	dw 381
	db 3, 6
	dw .Node686 ; CHERRYGROVE_POKECENTER_1F
	dw 382
	db 2, 6
	dw .Node687 ; CHERRYGROVE_GYM_SPEECH_HOUSE
	dw 383
	db 2, 6
	dw .Node688 ; GUIDE_GENTS_HOUSE
	dw 384
	db 2, 6
	dw .Node689 ; CHERRYGROVE_EVOLUTION_SPEECH_HOUSE
	dw 385
	db 2, 6
	dw .Node690 ; ROUTE_30_BERRY_HOUSE
	dw 386
	db 2, 6
	dw .Node691 ; MR_POKEMONS_HOUSE
	dw 387
	db 0, 3
	dw .Node692 ; ROUTE_31_VIOLET_GATE
	assert_table_length NUM_DEMO_NODES

; each edge: its kind (DEDGE_*), the warp (from 1) or direction, the node it
; leads to, the field moves it needs (DEMOFIELD_* bits); -1 ends
.Node0:
	db DEDGE_WARP, 1
	dw 20
	db %00000
	db -1
.Node1:
	db DEDGE_WARP, 1
	dw 20
	db %00000
	db -1
.Node2:
	db DEDGE_WARP, 1
	dw 20
	db %00000
	db -1
.Node3:
	db -1
.Node4:
	db DEDGE_WARP, 1
	dw 20
	db %00000
	db -1
.Node5:
	db DEDGE_WARP, 1
	dw 20
	db %00000
	db -1
.Node6:
	db DEDGE_WARP, 1
	dw 20
	db %00000
	db -1
.Node7:
	db DEDGE_WARP, 1
	dw 20
	db %00000
	db -1
.Node8:
	db DEDGE_WARP, 1
	dw 12
	db %00000
	db DEDGE_WARP, 3
	dw 243
	db %00000
	db -1
.Node9:
	db DEDGE_WARP, 1
	dw 14
	db %00000
	db -1
.Node10:
	db DEDGE_WARP, 1
	dw 14
	db %00000
	db -1
.Node11:
	db DEDGE_EDGE, 2
	dw 15
	db %00000
	db -1
.Node12:
	db DEDGE_WARP, 1
	dw 8
	db %00000
	db DEDGE_EDGE, 2
	dw 14
	db %00000
	db -1
.Node13:
	db DEDGE_EDGE, 2
	dw 16
	db %00000
	db -1
.Node14:
	db DEDGE_WARP, 1
	dw 9
	db %00000
	db DEDGE_WARP, 2
	dw 10
	db %00000
	db DEDGE_EDGE, 0
	dw 20
	db %00000
	db DEDGE_EDGE, 3
	dw 12
	db %00000
	db -1
.Node15:
	db DEDGE_EDGE, 3
	dw 11
	db %00000
	db -1
.Node16:
	db DEDGE_EDGE, 3
	dw 13
	db %00000
	db -1
.Node17:
	db DEDGE_EDGE, 0
	dw 19
	db %00000
	db -1
.Node18:
	db DEDGE_EDGE, 0
	dw 21
	db %00000
	db -1
.Node19:
	db DEDGE_EDGE, 1
	dw 17
	db %00000
	db -1
.Node20:
	db DEDGE_WARP, 1
	dw 0
	db %00000
	db DEDGE_WARP, 2
	dw 1
	db %00000
	db DEDGE_WARP, 3
	dw 2
	db %00000
	db DEDGE_WARP, 5
	dw 4
	db %00000
	db DEDGE_WARP, 6
	dw 5
	db %00000
	db DEDGE_WARP, 7
	dw 6
	db %00000
	db DEDGE_WARP, 8
	dw 7
	db %00000
	db DEDGE_WARP, 9
	dw 110
	db %00000
	db DEDGE_WARP, 10
	dw 469
	db %00000
	db DEDGE_EDGE, 1
	dw 14
	db %00000
	db DEDGE_EDGE, 2
	dw 584
	db %00000
	db DEDGE_WALK, 0
	dw 23
	db %00010
	db -1
.Node21:
	db DEDGE_EDGE, 1
	dw 18
	db %00000
	db -1
.Node22:
	db DEDGE_EDGE, 2
	dw 583
	db %00000
	db -1
.Node23:
	db DEDGE_EDGE, 2
	dw 585
	db %00000
	db DEDGE_WALK, 0
	dw 20
	db %00000
	db -1
.Node24:
	db DEDGE_WARP, 1
	dw 36
	db %00000
	db -1
.Node25:
	db DEDGE_WARP, 1
	dw 36
	db %00000
	db -1
.Node26:
	db DEDGE_WARP, 1
	dw 36
	db %00000
	db -1
.Node27:
	db DEDGE_WARP, 1
	dw 243
	db %00000
	db DEDGE_WARP, 3
	dw 29
	db %00000
	db -1
.Node28:
	db DEDGE_WARP, 3
	dw 141
	db %00000
	db DEDGE_WARP, 4
	dw 138
	db %00000
	db DEDGE_WARP, 5
	dw 142
	db %00000
	db DEDGE_EDGE, 3
	dw 35
	db %00000
	db -1
.Node29:
	db DEDGE_WARP, 1
	dw 27
	db %00000
	db DEDGE_WARP, 3
	dw 141
	db %00000
	db DEDGE_WALK, 0
	dw 30
	db %00010
	db DEDGE_WALK, 0
	dw 31
	db %00010
	db -1
.Node30:
	db DEDGE_WARP, 4
	dw 138
	db %00000
	db DEDGE_WALK, 0
	dw 29
	db %00010
	db DEDGE_WALK, 0
	dw 31
	db %00010
	db -1
.Node31:
	db DEDGE_WARP, 5
	dw 142
	db %00000
	db DEDGE_EDGE, 3
	dw 36
	db %00000
	db DEDGE_WALK, 0
	dw 29
	db %00010
	db DEDGE_WALK, 0
	dw 30
	db %00010
	db -1
.Node32:
	db DEDGE_EDGE, 3
	dw 38
	db %00000
	db -1
.Node33:
	db DEDGE_WARP, 1
	dw 149
	db %00000
	db DEDGE_EDGE, 2
	dw 37
	db %00000
	db DEDGE_EDGE, 2
	dw 38
	db %00000
	db DEDGE_EDGE, 3
	dw 260
	db %00000
	db -1
.Node34:
	db DEDGE_WARP, 1
	dw 149
	db %00000
	db DEDGE_EDGE, 2
	dw 36
	db %00000
	db -1
.Node35:
	db DEDGE_EDGE, 1
	dw 344
	db %00000
	db DEDGE_EDGE, 2
	dw 28
	db %00000
	db -1
.Node36:
	db DEDGE_WARP, 1
	dw 119
	db %00000
	db DEDGE_WARP, 2
	dw 24
	db %00000
	db DEDGE_WARP, 3
	dw 25
	db %00000
	db DEDGE_WARP, 4
	dw 26
	db %00000
	db DEDGE_WARP, 5
	dw 341
	db %00000
	db DEDGE_EDGE, 2
	dw 31
	db %00000
	db DEDGE_EDGE, 3
	dw 34
	db %00000
	db -1
.Node37:
	db DEDGE_EDGE, 1
	dw 345
	db %00000
	db DEDGE_EDGE, 3
	dw 33
	db %00000
	db -1
.Node38:
	db DEDGE_EDGE, 2
	dw 32
	db %00000
	db DEDGE_EDGE, 3
	dw 33
	db %00000
	db -1
.Node39:
	db DEDGE_WARP, 4
	dw 41
	db %00000
	db DEDGE_WARP, 5
	dw 42
	db %00000
	db -1
.Node40:
	db DEDGE_WARP, 1
	dw 357
	db %00000
	db DEDGE_WARP, 3
	dw 42
	db %00000
	db -1
.Node41:
	db DEDGE_WARP, 2
	dw 39
	db %00000
	db DEDGE_WARP, 4
	dw 43
	db %00000
	db -1
.Node42:
	db DEDGE_WARP, 1
	dw 40
	db %00000
	db DEDGE_WARP, 3
	dw 39
	db %00000
	db -1
.Node43:
	db DEDGE_WARP, 1
	dw 41
	db %00000
	db -1
.Node44:
	db DEDGE_WARP, 1
	dw 242
	db %00000
	db DEDGE_WARP, 3
	dw 45
	db %00000
	db -1
.Node45:
	db DEDGE_WARP, 1
	dw 46
	db %00000
	db DEDGE_WARP, 2
	dw 44
	db %00000
	db -1
.Node46:
	db DEDGE_WARP, 1
	dw 45
	db %00000
	db DEDGE_WARP, 2
	dw 47
	db %00000
	db -1
.Node47:
	db DEDGE_WARP, 1
	dw 51
	db %00000
	db DEDGE_WARP, 2
	dw 46
	db %00000
	db DEDGE_WARP, 3
	dw 48
	db %00000
	db DEDGE_WARP, 4
	dw 50
	db %00000
	db -1
.Node48:
	db DEDGE_WARP, 3
	dw 47
	db %00000
	db -1
.Node49:
	db DEDGE_WARP, 1
	dw 52
	db %00000
	db DEDGE_WALK, 0
	dw 48
	db %00000
	db -1
.Node50:
	db DEDGE_WARP, 4
	dw 47
	db %00000
	db -1
.Node51:
	db DEDGE_WARP, 2
	dw 47
	db %00000
	db DEDGE_WALK, 0
	dw 48
	db %00000
	db DEDGE_WALK, 0
	dw 49
	db %00000
	db DEDGE_WALK, 0
	dw 50
	db %00000
	db -1
.Node52:
	db DEDGE_WARP, 1
	dw 53
	db %00000
	db DEDGE_WARP, 2
	dw 49
	db %00000
	db -1
.Node53:
	db DEDGE_WARP, 1
	dw 52
	db %00000
	db DEDGE_WARP, 2
	dw 56
	db %00000
	db DEDGE_WARP, 4
	dw 54
	db %00000
	db -1
.Node54:
	db DEDGE_WARP, 3
	dw 53
	db %00000
	db DEDGE_WARP, 5
	dw 61
	db %00000
	db -1
.Node55:
	db DEDGE_WARP, 3
	dw 59
	db %00000
	db DEDGE_WARP, 4
	dw 60
	db %00000
	db -1
.Node56:
	db DEDGE_WARP, 1
	dw 53
	db %00000
	db DEDGE_WARP, 2
	dw 59
	db %00000
	db -1
.Node57:
	db DEDGE_WARP, 6
	dw 61
	db %00000
	db -1
.Node58:
	db DEDGE_WARP, 5
	dw 61
	db %00000
	db -1
.Node59:
	db DEDGE_WARP, 1
	dw 56
	db %00000
	db DEDGE_WARP, 2
	dw 55
	db %00000
	db -1
.Node60:
	db DEDGE_WARP, 3
	dw 55
	db %00000
	db DEDGE_WARP, 4
	dw 475
	db %00000
	db -1
.Node61:
	db DEDGE_WARP, 5
	dw 54
	db %00000
	db DEDGE_WARP, 6
	dw 58
	db %00000
	db DEDGE_WARP, 7
	dw 57
	db %00000
	db -1
.Node62:
	db DEDGE_WARP, 1
	dw 243
	db %00000
	db DEDGE_WARP, 14
	dw 65
	db %00000
	db DEDGE_WALK, 0
	dw 63
	db %10000
	db -1
.Node63:
	db DEDGE_WALK, 0
	dw 62
	db %00000
	db -1
.Node64:
	db -1
.Node65:
	db DEDGE_WARP, 6
	dw 62
	db %00000
	db -1
.Node66:
	db -1
.Node67:
	db DEDGE_WARP, 1
	dw 369
	db %00000
	db DEDGE_WARP, 1
	dw 370
	db %00000
	db DEDGE_WARP, 3
	dw 367
	db %00000
	db -1
.Node68:
	db DEDGE_WARP, 1
	dw 377
	db %00000
	db DEDGE_WARP, 3
	dw 69
	db %00000
	db -1
.Node69:
	db DEDGE_WARP, 1
	dw 70
	db %00000
	db DEDGE_WARP, 2
	dw 68
	db %00000
	db -1
.Node70:
	db DEDGE_WARP, 1
	dw 69
	db %00000
	db DEDGE_WARP, 2
	dw 72
	db %00000
	db -1
.Node71:
	db DEDGE_WARP, 3
	dw 73
	db %00000
	db -1
.Node72:
	db DEDGE_WARP, 1
	dw 74
	db %00000
	db DEDGE_WARP, 2
	dw 70
	db %00000
	db -1
.Node73:
	db DEDGE_WARP, 3
	dw 75
	db %00000
	db DEDGE_WARP, 4
	dw 71
	db %00000
	db -1
.Node74:
	db DEDGE_WARP, 1
	dw 72
	db %00000
	db -1
.Node75:
	db DEDGE_WARP, 2
	dw 73
	db %00000
	db -1
.Node76:
	db DEDGE_WARP, 2
	dw 86
	db %00000
	db DEDGE_WARP, 5
	dw 89
	db %00000
	db DEDGE_WARP, 6
	dw 90
	db %00000
	db DEDGE_WARP, 9
	dw 368
	db %00000
	db DEDGE_WARP, 10
	dw 364
	db %00000
	db DEDGE_WALK, 0
	dw 81
	db %00010
	db -1
.Node77:
	db DEDGE_WARP, 2
	dw 86
	db %00000
	db -1
.Node78:
	db DEDGE_WARP, 1
	dw 85
	db %00000
	db DEDGE_WARP, 5
	dw 89
	db %00000
	db DEDGE_WARP, 7
	dw 101
	db %00000
	db -1
.Node79:
	db DEDGE_WARP, 1
	dw 85
	db %00000
	db DEDGE_WARP, 7
	dw 101
	db %00000
	db -1
.Node80:
	db DEDGE_WARP, 3
	dw 87
	db %00000
	db DEDGE_WARP, 8
	dw 102
	db %00000
	db -1
.Node81:
	db DEDGE_WARP, 4
	dw 88
	db %00000
	db DEDGE_WALK, 0
	dw 76
	db %00010
	db -1
.Node82:
	db DEDGE_WARP, 3
	dw 87
	db %00000
	db DEDGE_WALK, 0
	dw 76
	db %00010
	db DEDGE_WALK, 0
	dw 81
	db %00000
	db -1
.Node83:
	db DEDGE_WARP, 8
	dw 102
	db %00000
	db DEDGE_WALK, 0
	dw 76
	db %00010
	db DEDGE_WALK, 0
	dw 81
	db %00000
	db DEDGE_WALK, 0
	dw 82
	db %00000
	db -1
.Node84:
	db DEDGE_WARP, 4
	dw 88
	db %00000
	db -1
.Node85:
	db DEDGE_WARP, 1
	dw 79
	db %00000
	db DEDGE_WARP, 1
	dw 78
	db %00000
	db DEDGE_WARP, 5
	dw 91
	db %00000
	db -1
.Node86:
	db DEDGE_WARP, 1
	dw 76
	db %00000
	db DEDGE_WARP, 1
	dw 77
	db %00000
	db DEDGE_WARP, 5
	dw 92
	db %00000
	db -1
.Node87:
	db DEDGE_WARP, 1
	dw 82
	db %00000
	db DEDGE_WARP, 1
	dw 80
	db %00000
	db DEDGE_WARP, 5
	dw 93
	db %00000
	db -1
.Node88:
	db DEDGE_WARP, 1
	dw 81
	db %00000
	db DEDGE_WARP, 1
	dw 84
	db %00000
	db DEDGE_WARP, 5
	dw 94
	db %00000
	db -1
.Node89:
	db DEDGE_WARP, 1
	dw 76
	db %00000
	db DEDGE_WARP, 1
	dw 78
	db %00000
	db -1
.Node90:
	db DEDGE_WARP, 1
	dw 76
	db %00000
	db -1
.Node91:
	db DEDGE_WARP, 1
	dw 85
	db %00000
	db -1
.Node92:
	db DEDGE_WARP, 1
	dw 86
	db %00000
	db -1
.Node93:
	db DEDGE_WARP, 1
	dw 87
	db %00000
	db -1
.Node94:
	db DEDGE_WARP, 1
	dw 88
	db %00000
	db -1
.Node95:
	db -1
.Node96:
	db -1
.Node97:
	db -1
.Node98:
	db -1
.Node99:
	db DEDGE_WARP, 1
	dw 103
	db %00000
	db DEDGE_WARP, 3
	dw 336
	db %00000
	db DEDGE_WARP, 3
	dw 335
	db %00000
	db DEDGE_WARP, 4
	dw 349
	db %00000
	db DEDGE_WARP, 4
	dw 350
	db %00000
	db DEDGE_WALK, 0
	dw 100
	db %00010
	db -1
.Node100:
	db DEDGE_WARP, 2
	dw 104
	db %00000
	db DEDGE_WALK, 0
	dw 99
	db %00010
	db -1
.Node101:
	db DEDGE_WARP, 1
	dw 79
	db %00000
	db DEDGE_WARP, 1
	dw 78
	db %00000
	db DEDGE_WALK, 0
	dw 103
	db %00010
	db -1
.Node102:
	db DEDGE_WARP, 2
	dw 83
	db %00000
	db DEDGE_WARP, 2
	dw 80
	db %00000
	db -1
.Node103:
	db DEDGE_WARP, 3
	dw 99
	db %00000
	db DEDGE_WALK, 0
	dw 101
	db %00010
	db -1
.Node104:
	db DEDGE_WARP, 4
	dw 100
	db %00000
	db DEDGE_WALK, 0
	dw 105
	db %00010
	db -1
.Node105:
	db DEDGE_WARP, 5
	dw 106
	db %00000
	db DEDGE_WALK, 0
	dw 104
	db %00010
	db -1
.Node106:
	db DEDGE_WARP, 1
	dw 105
	db %00000
	db -1
.Node107:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db -1
.Node108:
	db DEDGE_WARP, 2
	dw 109
	db %00000
	db -1
.Node109:
	db DEDGE_WARP, 1
	dw 108
	db %00000
	db -1
.Node110:
	db DEDGE_WARP, 1
	dw 20
	db %00000
	db DEDGE_WARP, 3
	dw 111
	db %00000
	db -1
.Node111:
	db DEDGE_WARP, 1
	dw 110
	db %00000
	db DEDGE_WARP, 2
	dw 112
	db %00000
	db -1
.Node112:
	db DEDGE_WARP, 1
	dw 114
	db %00000
	db DEDGE_WARP, 2
	dw 111
	db %00000
	db -1
.Node113:
	db DEDGE_WARP, 3
	dw 115
	db %00000
	db -1
.Node114:
	db DEDGE_WARP, 1
	dw 112
	db %00000
	db DEDGE_WARP, 2
	dw 116
	db %00000
	db -1
.Node115:
	db DEDGE_WARP, 3
	dw 117
	db %00000
	db DEDGE_WARP, 4
	dw 113
	db %00000
	db -1
.Node116:
	db DEDGE_WARP, 2
	dw 114
	db %00000
	db -1
.Node117:
	db DEDGE_WARP, 1
	dw 118
	db %00000
	db DEDGE_WARP, 3
	dw 115
	db %00000
	db -1
.Node118:
	db DEDGE_WARP, 1
	dw 117
	db %00000
	db -1
.Node119:
	db DEDGE_WARP, 1
	dw 36
	db %00000
	db -1
.Node120:
	db DEDGE_WARP, 1
	dw 119
	db %00000
	db DEDGE_WARP, 2
	dw 123
	db %00000
	db DEDGE_WARP, 3
	dw 120
	db %00000
	db -1
.Node121:
	db DEDGE_WARP, 2
	dw 124
	db %00000
	db DEDGE_WARP, 3
	dw 125
	db %00000
	db -1
.Node122:
	db DEDGE_WARP, 4
	dw 124
	db %00000
	db -1
.Node123:
	db DEDGE_WARP, 1
	dw 120
	db %00000
	db DEDGE_WARP, 5
	dw 125
	db %00000
	db -1
.Node124:
	db DEDGE_WARP, 1
	dw 121
	db %00000
	db DEDGE_WARP, 3
	dw 122
	db %00000
	db -1
.Node125:
	db DEDGE_WARP, 2
	dw 121
	db %00000
	db DEDGE_WARP, 4
	dw 123
	db %00000
	db -1
.Node126:
	db DEDGE_WARP, 1
	dw 401
	db %00000
	db DEDGE_WALK, 0
	dw 127
	db %00001
	db -1
.Node127:
	db DEDGE_WARP, 2
	dw 400
	db %00000
	db DEDGE_WALK, 0
	dw 126
	db %00001
	db -1
.Node128:
	db DEDGE_WARP, 1
	dw 133
	db %00000
	db DEDGE_WARP, 2
	dw 132
	db %00000
	db DEDGE_WARP, 3
	dw 129
	db %00000
	db -1
.Node129:
	db DEDGE_WARP, 4
	dw 128
	db %00000
	db DEDGE_WARP, 6
	dw 130
	db %00000
	db -1
.Node130:
	db DEDGE_WARP, 1
	dw 129
	db %00000
	db -1
.Node131:
	db DEDGE_WARP, 2
	dw 136
	db %00000
	db -1
.Node132:
	db DEDGE_WARP, 4
	dw 128
	db %00000
	db DEDGE_WARP, 5
	dw 377
	db %00000
	db -1
.Node133:
	db DEDGE_WARP, 7
	dw 128
	db %00000
	db DEDGE_WARP, 8
	dw 377
	db %00000
	db -1
.Node134:
	db DEDGE_WARP, 1
	dw 136
	db %00000
	db -1
.Node135:
	db DEDGE_WARP, 2
	dw 396
	db %00000
	db -1
.Node136:
	db DEDGE_WARP, 1
	dw 131
	db %00000
	db DEDGE_WARP, 3
	dw 134
	db %00000
	db -1
.Node137:
	db DEDGE_WARP, 4
	dw 146
	db %00000
	db DEDGE_WALK, 0
	dw 138
	db %00010
	db -1
.Node138:
	db DEDGE_WARP, 2
	dw 30
	db %00000
	db DEDGE_WARP, 2
	dw 28
	db %00000
	db DEDGE_WARP, 7
	dw 148
	db %00000
	db DEDGE_WALK, 0
	dw 137
	db %01010
	db -1
.Node139:
	db DEDGE_WARP, 9
	dw 143
	db %00000
	db -1
.Node140:
	db DEDGE_WARP, 8
	dw 143
	db %00000
	db -1
.Node141:
	db DEDGE_WARP, 1
	dw 29
	db %00000
	db DEDGE_WARP, 1
	dw 28
	db %00000
	db DEDGE_WARP, 5
	dw 143
	db %00000
	db -1
.Node142:
	db DEDGE_WARP, 3
	dw 31
	db %00000
	db DEDGE_WARP, 3
	dw 28
	db %00000
	db DEDGE_WARP, 6
	dw 143
	db %00000
	db -1
.Node143:
	db DEDGE_WARP, 1
	dw 141
	db %00000
	db DEDGE_WARP, 2
	dw 142
	db %00000
	db DEDGE_WARP, 3
	dw 140
	db %00000
	db DEDGE_WARP, 4
	dw 139
	db %00000
	db -1
.Node144:
	db DEDGE_WARP, 5
	dw 147
	db %00000
	db DEDGE_WARP, 6
	dw 145
	db %00000
	db DEDGE_WALK, 0
	dw 143
	db %00000
	db -1
.Node145:
	db DEDGE_WARP, 2
	dw 144
	db %00000
	db DEDGE_WALK, 0
	dw 146
	db %00010
	db -1
.Node146:
	db DEDGE_WARP, 1
	dw 137
	db %00000
	db DEDGE_WALK, 0
	dw 145
	db %00010
	db -1
.Node147:
	db DEDGE_WARP, 1
	dw 144
	db %00000
	db -1
.Node148:
	db DEDGE_WARP, 2
	dw 138
	db %00000
	db -1
.Node149:
	db DEDGE_WARP, 1
	dw 34
	db %00000
	db DEDGE_WARP, 1
	dw 33
	db %00000
	db -1
.Node150:
	db DEDGE_WARP, 3
	dw 152
	db %00000
	db DEDGE_WALK, 0
	dw 149
	db %00000
	db -1
.Node151:
	db DEDGE_WARP, 2
	dw 262
	db %00000
	db DEDGE_WARP, 2
	dw 260
	db %00000
	db DEDGE_WARP, 4
	dw 153
	db %00000
	db -1
.Node152:
	db DEDGE_WARP, 1
	dw 150
	db %00000
	db DEDGE_WARP, 2
	dw 154
	db %00000
	db -1
.Node153:
	db DEDGE_WARP, 7
	dw 151
	db %00000
	db DEDGE_WARP, 8
	dw 161
	db %00000
	db DEDGE_WARP, 8
	dw 160
	db %00000
	db DEDGE_WARP, 8
	dw 162
	db %00000
	db -1
.Node154:
	db DEDGE_WARP, 1
	dw 152
	db %00000
	db DEDGE_WARP, 2
	dw 165
	db %00000
	db -1
.Node155:
	db DEDGE_WALK, 0
	dw 154
	db %00000
	db -1
.Node156:
	db DEDGE_WALK, 0
	dw 154
	db %00000
	db -1
.Node157:
	db DEDGE_WALK, 0
	dw 154
	db %00000
	db -1
.Node158:
	db DEDGE_WARP, 2
	dw 165
	db %00000
	db DEDGE_WALK, 0
	dw 154
	db %00000
	db DEDGE_WALK, 0
	dw 157
	db %00000
	db -1
.Node159:
	db DEDGE_WARP, 2
	dw 165
	db %00000
	db DEDGE_WALK, 0
	dw 154
	db %00000
	db DEDGE_WALK, 0
	dw 156
	db %00000
	db -1
.Node160:
	db DEDGE_WARP, 1
	dw 153
	db %00000
	db DEDGE_WARP, 2
	dw 165
	db %00000
	db -1
.Node161:
	db DEDGE_WALK, 0
	dw 160
	db %00000
	db -1
.Node162:
	db DEDGE_WALK, 0
	dw 160
	db %00000
	db -1
.Node163:
	db DEDGE_WARP, 1
	dw 153
	db %00000
	db DEDGE_WALK, 0
	dw 160
	db %00000
	db DEDGE_WALK, 0
	dw 162
	db %00000
	db -1
.Node164:
	db DEDGE_WARP, 1
	dw 153
	db %00000
	db DEDGE_WALK, 0
	dw 160
	db %00000
	db DEDGE_WALK, 0
	dw 161
	db %00000
	db -1
.Node165:
	db DEDGE_WARP, 1
	dw 156
	db %00000
	db DEDGE_WARP, 1
	dw 154
	db %00000
	db DEDGE_WARP, 1
	dw 157
	db %00000
	db DEDGE_WARP, 2
	dw 160
	db %00000
	db -1
.Node166:
	db DEDGE_WARP, 1
	dw 589
	db %00000
	db DEDGE_WARP, 1
	dw 588
	db %00000
	db DEDGE_WARP, 2
	dw 178
	db %00000
	db -1
.Node167:
	db DEDGE_WARP, 3
	dw 173
	db %00000
	db DEDGE_WARP, 4
	dw 175
	db %00000
	db -1
.Node168:
	db DEDGE_WARP, 2
	dw 179
	db %00000
	db -1
.Node169:
	db DEDGE_WARP, 3
	dw 178
	db %00000
	db -1
.Node170:
	db DEDGE_WARP, 1
	dw 587
	db %00000
	db DEDGE_WARP, 1
	dw 590
	db %00000
	db DEDGE_WALK, 0
	dw 168
	db %00000
	db DEDGE_WALK, 0
	dw 169
	db %00000
	db -1
.Node171:
	db DEDGE_WARP, 1
	dw 591
	db %00000
	db DEDGE_WARP, 1
	dw 593
	db %00000
	db DEDGE_WARP, 3
	dw 177
	db %00000
	db DEDGE_WALK, 0
	dw 172
	db %00010
	db -1
.Node172:
	db DEDGE_WARP, 2
	dw 181
	db %00000
	db DEDGE_WALK, 0
	dw 171
	db %00010
	db -1
.Node173:
	db DEDGE_WARP, 4
	dw 167
	db %00000
	db DEDGE_WALK, 0
	dw 174
	db %00010
	db -1
.Node174:
	db DEDGE_WARP, 5
	dw 184
	db %00000
	db DEDGE_WALK, 0
	dw 173
	db %00010
	db -1
.Node175:
	db DEDGE_WARP, 1
	dw 182
	db %00000
	db DEDGE_WARP, 1
	dw 180
	db %00000
	db DEDGE_WARP, 2
	dw 167
	db %00000
	db -1
.Node176:
	db DEDGE_WARP, 1
	dw 592
	db %00000
	db DEDGE_WARP, 1
	dw 594
	db %00000
	db DEDGE_WARP, 2
	dw 181
	db %00000
	db -1
.Node177:
	db DEDGE_WARP, 4
	dw 171
	db %00000
	db -1
.Node178:
	db DEDGE_WARP, 1
	dw 166
	db %00000
	db DEDGE_WARP, 3
	dw 169
	db %00000
	db DEDGE_WARP, 8
	dw 187
	db %00000
	db DEDGE_WALK, 0
	dw 177
	db %00000
	db -1
.Node179:
	db DEDGE_WARP, 2
	dw 168
	db %00000
	db DEDGE_WARP, 7
	dw 186
	db %00010
	db DEDGE_WARP, 7
	dw 183
	db %00000
	db -1
.Node180:
	db DEDGE_WARP, 9
	dw 175
	db %00000
	db -1
.Node181:
	db DEDGE_WARP, 5
	dw 172
	db %00000
	db DEDGE_WARP, 6
	dw 176
	db %00000
	db -1
.Node182:
	db DEDGE_WARP, 9
	dw 175
	db %00000
	db DEDGE_WALK, 0
	dw 177
	db %00000
	db -1
.Node183:
	db DEDGE_WARP, 1
	dw 179
	db %00000
	db DEDGE_WALK, 0
	dw 184
	db %00010
	db DEDGE_WALK, 0
	dw 185
	db %00010
	db DEDGE_WALK, 0
	dw 186
	db %00010
	db -1
.Node184:
	db DEDGE_WARP, 4
	dw 174
	db %00000
	db DEDGE_WALK, 0
	dw 183
	db %01010
	db DEDGE_WALK, 0
	dw 185
	db %00010
	db DEDGE_WALK, 0
	dw 186
	db %01010
	db -1
.Node185:
	db DEDGE_WARP, 3
	dw 188
	db %00000
	db DEDGE_WALK, 0
	dw 183
	db %01010
	db DEDGE_WALK, 0
	dw 184
	db %00010
	db DEDGE_WALK, 0
	dw 186
	db %01010
	db -1
.Node186:
	db DEDGE_WARP, 1
	dw 179
	db %00000
	db DEDGE_WALK, 0
	dw 183
	db %00000
	db DEDGE_WALK, 0
	dw 184
	db %00000
	db DEDGE_WALK, 0
	dw 185
	db %00000
	db -1
.Node187:
	db DEDGE_WARP, 2
	dw 178
	db %00000
	db -1
.Node188:
	db DEDGE_WARP, 1
	dw 185
	db %00000
	db -1
.Node189:
	db DEDGE_WARP, 2
	dw 192
	db %00000
	db -1
.Node190:
	db DEDGE_WARP, 1
	dw 543
	db %00000
	db DEDGE_WARP, 1
	dw 542
	db %00000
	db DEDGE_WARP, 2
	dw 192
	db %00000
	db -1
.Node191:
	db DEDGE_WARP, 4
	dw 196
	db %00000
	db DEDGE_WALK, 0
	dw 192
	db %00010
	db DEDGE_WALK, 0
	dw 193
	db %01010
	db -1
.Node192:
	db DEDGE_WARP, 1
	dw 190
	db %00000
	db DEDGE_WARP, 1
	dw 189
	db %00000
	db DEDGE_WARP, 2
	dw 194
	db %00000
	db DEDGE_WALK, 0
	dw 191
	db %01010
	db DEDGE_WALK, 0
	dw 193
	db %01010
	db -1
.Node193:
	db DEDGE_WARP, 3
	dw 195
	db %00000
	db DEDGE_WALK, 0
	dw 191
	db %01010
	db DEDGE_WALK, 0
	dw 192
	db %00010
	db -1
.Node194:
	db DEDGE_WARP, 1
	dw 192
	db %00000
	db -1
.Node195:
	db DEDGE_WARP, 1
	dw 193
	db %00000
	db -1
.Node196:
	db DEDGE_WARP, 2
	dw 191
	db %00000
	db -1
.Node197:
	db DEDGE_WARP, 2
	dw 201
	db %00000
	db -1
.Node198:
	db DEDGE_WARP, 2
	dw 201
	db %00000
	db DEDGE_WALK, 0
	dw 199
	db %00010
	db DEDGE_WALK, 0
	dw 200
	db %10010
	db -1
.Node199:
	db DEDGE_WARP, 1
	dw 683
	db %00000
	db DEDGE_WARP, 1
	dw 682
	db %00000
	db DEDGE_WALK, 0
	dw 198
	db %00010
	db DEDGE_WALK, 0
	dw 200
	db %10000
	db -1
.Node200:
	db DEDGE_WARP, 3
	dw 258
	db %00000
	db DEDGE_WARP, 3
	dw 256
	db %00000
	db -1
.Node201:
	db DEDGE_WARP, 2
	dw 198
	db %00000
	db DEDGE_WARP, 2
	dw 197
	db %00000
	db -1
.Node202:
	db DEDGE_WARP, 1
	dw 254
	db %00000
	db DEDGE_WARP, 1
	dw 252
	db %00000
	db DEDGE_WALK, 0
	dw 201
	db %00010
	db -1
.Node203:
	db DEDGE_WARP, 1
	dw 261
	db %00000
	db DEDGE_WARP, 1
	dw 260
	db %00000
	db DEDGE_WARP, 2
	dw 204
	db %00000
	db -1
.Node204:
	db DEDGE_WARP, 3
	dw 206
	db %00000
	db DEDGE_WARP, 3
	dw 205
	db %00000
	db DEDGE_WARP, 4
	dw 203
	db %00000
	db -1
.Node205:
	db DEDGE_WARP, 1
	dw 204
	db %00000
	db -1
.Node206:
	db DEDGE_WARP, 1
	dw 204
	db %00000
	db DEDGE_WALK, 0
	dw 207
	db %00110
	db -1
.Node207:
	db DEDGE_WARP, 2
	dw 208
	db %00000
	db DEDGE_WALK, 0
	dw 206
	db %00110
	db -1
.Node208:
	db DEDGE_WARP, 1
	dw 207
	db %00000
	db -1
.Node209:
	db DEDGE_WARP, 1
	dw 635
	db %00000
	db DEDGE_WARP, 1
	dw 634
	db %00000
	db DEDGE_WALK, 0
	dw 210
	db %01010
	db -1
.Node210:
	db DEDGE_WARP, 2
	dw 637
	db %00000
	db DEDGE_WARP, 2
	dw 634
	db %00000
	db DEDGE_WALK, 0
	dw 209
	db %01010
	db -1
.Node211:
	db DEDGE_WARP, 5
	dw 213
	db %00000
	db DEDGE_WARP, 6
	dw 212
	db %00000
	db -1
.Node212:
	db DEDGE_WARP, 3
	dw 605
	db %00000
	db DEDGE_WARP, 3
	dw 606
	db %00000
	db DEDGE_WARP, 4
	dw 211
	db %00000
	db -1
.Node213:
	db DEDGE_WARP, 1
	dw 408
	db %00000
	db DEDGE_WARP, 1
	dw 411
	db %00000
	db DEDGE_WARP, 2
	dw 211
	db %00000
	db -1
.Node214:
	db DEDGE_WARP, 1
	dw 439
	db %00000
	db DEDGE_WARP, 1
	dw 438
	db %00000
	db DEDGE_WARP, 2
	dw 289
	db %00000
	db DEDGE_WARP, 2
	dw 287
	db %00000
	db DEDGE_WARP, 3
	dw 215
	db %00000
	db -1
.Node215:
	db DEDGE_WARP, 5
	dw 473
	db %00000
	db DEDGE_WARP, 5
	dw 472
	db %00000
	db DEDGE_WARP, 7
	dw 214
	db %00000
	db -1
.Node216:
	db DEDGE_WARP, 4
	dw 217
	db %00000
	db DEDGE_WALK, 0
	dw 214
	db %00000
	db -1
.Node217:
	db DEDGE_WARP, 6
	dw 473
	db %00000
	db DEDGE_WARP, 6
	dw 472
	db %00000
	db DEDGE_WARP, 8
	dw 216
	db %00000
	db -1
.Node218:
	db DEDGE_WARP, 1
	dw 678
	db %00000
	db DEDGE_WARP, 2
	dw 420
	db %00000
	db -1
.Node219:
	db DEDGE_WARP, 3
	dw 223
	db %00000
	db DEDGE_WARP, 4
	dw 222
	db %00000
	db -1
.Node220:
	db DEDGE_WARP, 1
	dw 299
	db %00000
	db DEDGE_WARP, 1
	dw 298
	db %00000
	db DEDGE_WARP, 5
	dw 223
	db %00000
	db -1
.Node221:
	db DEDGE_WARP, 2
	dw 523
	db %00000
	db DEDGE_WARP, 2
	dw 522
	db %00000
	db DEDGE_WARP, 6
	dw 222
	db %00000
	db -1
.Node222:
	db DEDGE_WARP, 1
	dw 221
	db %00000
	db DEDGE_WARP, 2
	dw 219
	db %00000
	db -1
.Node223:
	db DEDGE_WARP, 3
	dw 219
	db %00000
	db DEDGE_WARP, 4
	dw 220
	db %00000
	db -1
.Node224:
	db DEDGE_WARP, 1
	dw 225
	db %00000
	db -1
.Node225:
	db -1
.Node226:
	db DEDGE_WARP, 10
	dw 476
	db %00000
	db -1
.Node227:
	db DEDGE_WARP, 7
	dw 231
	db %00000
	db -1
.Node228:
	db DEDGE_WARP, 5
	dw 229
	db %00000
	db DEDGE_WARP, 10
	dw 476
	db %00000
	db DEDGE_WALK, 0
	dw 227
	db %00000
	db -1
.Node229:
	db DEDGE_WARP, 3
	dw 232
	db %00000
	db DEDGE_WARP, 4
	dw 228
	db %00000
	db -1
.Node230:
	db DEDGE_WALK, 0
	dw 229
	db %00000
	db -1
.Node231:
	db DEDGE_WARP, 6
	dw 227
	db %00000
	db DEDGE_WALK, 0
	dw 229
	db %00000
	db -1
.Node232:
	db DEDGE_WARP, 1
	dw 626
	db %00000
	db DEDGE_WARP, 2
	dw 229
	db %00000
	db -1
.Node233:
	db DEDGE_WARP, 1
	dw 243
	db %00000
	db DEDGE_WARP, 3
	dw 234
	db %00000
	db -1
.Node234:
	db DEDGE_WARP, 4
	dw 233
	db %00000
	db DEDGE_WARP, 5
	dw 235
	db %00000
	db -1
.Node235:
	db DEDGE_WARP, 1
	dw 242
	db %00000
	db DEDGE_WARP, 3
	dw 234
	db %00000
	db -1
.Node236:
	db DEDGE_WARP, 1
	dw 243
	db %00000
	db -1
.Node237:
	db DEDGE_WARP, 1
	dw 243
	db %00000
	db -1
.Node238:
	db DEDGE_WARP, 1
	dw 243
	db %00000
	db -1
.Node239:
	db DEDGE_WARP, 1
	dw 243
	db %00000
	db -1
.Node240:
	db DEDGE_WARP, 1
	dw 243
	db %00000
	db -1
.Node241:
	db DEDGE_WARP, 1
	dw 243
	db %00000
	db -1
.Node242:
	db DEDGE_WARP, 4
	dw 235
	db %00000
	db DEDGE_WARP, 12
	dw 44
	db %00000
	db -1
.Node243:
	db DEDGE_WARP, 1
	dw 27
	db %00000
	db DEDGE_WARP, 3
	dw 233
	db %00000
	db DEDGE_WARP, 6
	dw 236
	db %00000
	db DEDGE_WARP, 7
	dw 237
	db %00000
	db DEDGE_WARP, 8
	dw 238
	db %00000
	db DEDGE_WARP, 9
	dw 239
	db %00000
	db DEDGE_WARP, 10
	dw 240
	db %00000
	db DEDGE_WARP, 11
	dw 241
	db %00000
	db DEDGE_WARP, 13
	dw 62
	db %00000
	db DEDGE_WARP, 14
	dw 8
	db %00000
	db DEDGE_EDGE, 0
	dw 356
	db %00000
	db -1
.Node244:
	db DEDGE_WARP, 1
	dw 262
	db %00000
	db DEDGE_WARP, 3
	dw 246
	db %00000
	db -1
.Node245:
	db DEDGE_WARP, 4
	dw 246
	db %00000
	db -1
.Node246:
	db DEDGE_WARP, 1
	dw 244
	db %00000
	db DEDGE_WARP, 2
	dw 245
	db %00000
	db -1
.Node247:
	db DEDGE_WARP, 1
	dw 262
	db %00000
	db -1
.Node248:
	db DEDGE_WARP, 1
	dw 262
	db %00000
	db -1
.Node249:
	db DEDGE_WARP, 1
	dw 262
	db %00000
	db -1
.Node250:
	db DEDGE_WARP, 1
	dw 262
	db %00000
	db -1
.Node251:
	db DEDGE_WARP, 1
	dw 262
	db %00000
	db -1
.Node252:
	db DEDGE_WARP, 1
	dw 202
	db %00000
	db DEDGE_EDGE, 1
	dw 260
	db %00000
	db DEDGE_EDGE, 2
	dw 256
	db %00000
	db -1
.Node253:
	db DEDGE_EDGE, 2
	dw 258
	db %00000
	db -1
.Node254:
	db DEDGE_WARP, 1
	dw 202
	db %00000
	db DEDGE_EDGE, 1
	dw 262
	db %00000
	db DEDGE_WALK, 0
	dw 253
	db %00000
	db -1
.Node255:
	db DEDGE_EDGE, 1
	dw 260
	db %00000
	db DEDGE_EDGE, 2
	dw 259
	db %00000
	db -1
.Node256:
	db DEDGE_WARP, 3
	dw 200
	db %00000
	db DEDGE_EDGE, 3
	dw 252
	db %00000
	db -1
.Node257:
	db DEDGE_WARP, 1
	dw 655
	db %00000
	db -1
.Node258:
	db DEDGE_WARP, 3
	dw 200
	db %00000
	db DEDGE_EDGE, 3
	dw 253
	db %00000
	db DEDGE_WALK, 0
	dw 257
	db %00000
	db -1
.Node259:
	db DEDGE_EDGE, 3
	dw 255
	db %00000
	db -1
.Node260:
	db DEDGE_WARP, 7
	dw 151
	db %00000
	db DEDGE_WARP, 8
	dw 203
	db %00000
	db DEDGE_EDGE, 0
	dw 252
	db %00000
	db DEDGE_EDGE, 0
	dw 255
	db %00000
	db DEDGE_EDGE, 2
	dw 33
	db %00000
	db -1
.Node261:
	db DEDGE_WARP, 8
	dw 203
	db %00000
	db DEDGE_WALK, 0
	dw 262
	db %00010
	db -1
.Node262:
	db DEDGE_WARP, 1
	dw 244
	db %00000
	db DEDGE_WARP, 2
	dw 247
	db %00000
	db DEDGE_WARP, 3
	dw 248
	db %00000
	db DEDGE_WARP, 4
	dw 249
	db %00000
	db DEDGE_WARP, 5
	dw 250
	db %00000
	db DEDGE_WARP, 6
	dw 251
	db %00000
	db DEDGE_WARP, 7
	dw 151
	db %00000
	db DEDGE_EDGE, 0
	dw 254
	db %00000
	db DEDGE_WALK, 0
	dw 261
	db %00010
	db -1
.Node263:
	db DEDGE_WARP, 1
	dw 275
	db %00000
	db -1
.Node264:
	db DEDGE_WARP, 1
	dw 500
	db %00000
	db DEDGE_WARP, 3
	dw 269
	db %00000
	db -1
.Node265:
	db DEDGE_WARP, 1
	dw 272
	db %00000
	db -1
.Node266:
	db DEDGE_EDGE, 1
	dw 502
	db %00000
	db -1
.Node267:
	db DEDGE_EDGE, 1
	dw 500
	db %00000
	db -1
.Node268:
	db DEDGE_EDGE, 1
	dw 501
	db %00000
	db -1
.Node269:
	db DEDGE_WARP, 1
	dw 264
	db %00000
	db DEDGE_WALK, 0
	dw 270
	db %00010
	db -1
.Node270:
	db DEDGE_EDGE, 2
	dw 271
	db %00000
	db DEDGE_WALK, 0
	dw 269
	db %00000
	db -1
.Node271:
	db DEDGE_EDGE, 2
	dw 276
	db %00000
	db DEDGE_EDGE, 3
	dw 270
	db %00000
	db -1
.Node272:
	db DEDGE_WARP, 1
	dw 265
	db %00000
	db -1
.Node273:
	db DEDGE_EDGE, 1
	dw 433
	db %00000
	db DEDGE_EDGE, 0
	dw 276
	db %00000
	db DEDGE_EDGE, 0
	dw 277
	db %00000
	db -1
.Node274:
	db DEDGE_EDGE, 0
	dw 277
	db %00000
	db -1
.Node275:
	db DEDGE_WARP, 1
	dw 263
	db %00000
	db DEDGE_WALK, 0
	dw 276
	db %00010
	db -1
.Node276:
	db DEDGE_EDGE, 1
	dw 273
	db %00000
	db DEDGE_EDGE, 3
	dw 271
	db %00000
	db DEDGE_WALK, 0
	dw 275
	db %00000
	db -1
.Node277:
	db DEDGE_EDGE, 1
	dw 273
	db %00000
	db DEDGE_EDGE, 1
	dw 274
	db %00000
	db -1
.Node278:
	db DEDGE_WARP, 1
	dw 324
	db %00000
	db -1
.Node279:
	db DEDGE_WARP, 1
	dw 324
	db %00000
	db -1
.Node280:
	db DEDGE_WARP, 1
	dw 324
	db %00000
	db -1
.Node281:
	db DEDGE_WARP, 1
	dw 324
	db %00000
	db -1
.Node282:
	db DEDGE_WARP, 1
	dw 324
	db %00000
	db -1
.Node283:
	db DEDGE_WARP, 1
	dw 324
	db %00000
	db -1
.Node284:
	db DEDGE_WARP, 1
	dw 301
	db %00000
	db -1
.Node285:
	db DEDGE_WARP, 1
	dw 302
	db %00000
	db -1
.Node286:
	db DEDGE_WARP, 1
	dw 315
	db %00000
	db -1
.Node287:
	db DEDGE_WARP, 1
	dw 214
	db %00000
	db DEDGE_EDGE, 2
	dw 438
	db %00000
	db DEDGE_EDGE, 3
	dw 320
	db %00000
	db DEDGE_EDGE, 3
	dw 328
	db %00000
	db -1
.Node288:
	db DEDGE_EDGE, 3
	dw 324
	db %00000
	db -1
.Node289:
	db DEDGE_WARP, 1
	dw 214
	db %00000
	db DEDGE_WALK, 0
	dw 288
	db %00000
	db -1
.Node290:
	db DEDGE_EDGE, 3
	dw 321
	db %00000
	db -1
.Node291:
	db DEDGE_EDGE, 3
	dw 328
	db %00000
	db -1
.Node292:
	db DEDGE_EDGE, 2
	dw 326
	db %00000
	db -1
.Node293:
	db DEDGE_EDGE, 0
	dw 300
	db %00000
	db -1
.Node294:
	db DEDGE_EDGE, 0
	dw 301
	db %00000
	db DEDGE_WALK, 0
	dw 295
	db %00010
	db DEDGE_WALK, 0
	dw 296
	db %00001
	db -1
.Node295:
	db DEDGE_EDGE, 0
	dw 303
	db %00000
	db DEDGE_WALK, 0
	dw 294
	db %00000
	db DEDGE_WALK, 0
	dw 296
	db %00001
	db -1
.Node296:
	db DEDGE_EDGE, 2
	dw 324
	db %00000
	db DEDGE_WALK, 0
	dw 294
	db %00001
	db DEDGE_WALK, 0
	dw 295
	db %00011
	db -1
.Node297:
	db DEDGE_EDGE, 2
	dw 329
	db %00000
	db -1
.Node298:
	db DEDGE_WARP, 1
	dw 220
	db %00000
	db DEDGE_EDGE, 0
	dw 300
	db %00000
	db -1
.Node299:
	db DEDGE_WARP, 1
	dw 220
	db %00000
	db DEDGE_EDGE, 0
	dw 301
	db %00000
	db -1
.Node300:
	db DEDGE_EDGE, 1
	dw 298
	db %00000
	db DEDGE_EDGE, 1
	dw 293
	db %00000
	db DEDGE_EDGE, 0
	dw 522
	db %00000
	db -1
.Node301:
	db DEDGE_WARP, 1
	dw 284
	db %00000
	db DEDGE_EDGE, 1
	dw 299
	db %00000
	db DEDGE_EDGE, 1
	dw 294
	db %00000
	db -1
.Node302:
	db DEDGE_WARP, 2
	dw 285
	db %00000
	db DEDGE_WALK, 0
	dw 303
	db %00010
	db -1
.Node303:
	db DEDGE_EDGE, 1
	dw 295
	db %00000
	db DEDGE_WALK, 0
	dw 302
	db %00000
	db -1
.Node304:
	db DEDGE_EDGE, 1
	dw 314
	db %00000
	db DEDGE_EDGE, 0
	dw 320
	db %00000
	db -1
.Node305:
	db DEDGE_EDGE, 1
	dw 315
	db %00000
	db DEDGE_WALK, 0
	dw 306
	db %00010
	db -1
.Node306:
	db DEDGE_EDGE, 1
	dw 317
	db %00000
	db DEDGE_EDGE, 0
	dw 321
	db %00000
	db DEDGE_WALK, 0
	dw 305
	db %00000
	db -1
.Node307:
	db DEDGE_EDGE, 1
	dw 318
	db %00000
	db -1
.Node308:
	db DEDGE_EDGE, 1
	dw 319
	db %00000
	db -1
.Node309:
	db DEDGE_EDGE, 1
	dw 315
	db %00000
	db DEDGE_EDGE, 0
	dw 325
	db %00000
	db -1
.Node310:
	db DEDGE_EDGE, 1
	dw 316
	db %00000
	db -1
.Node311:
	db DEDGE_EDGE, 0
	dw 327
	db %00000
	db -1
.Node312:
	db DEDGE_EDGE, 0
	dw 322
	db %00000
	db -1
.Node313:
	db DEDGE_EDGE, 0
	dw 323
	db %00000
	db -1
.Node314:
	db DEDGE_EDGE, 0
	dw 304
	db %00000
	db -1
.Node315:
	db DEDGE_WARP, 1
	dw 286
	db %00000
	db DEDGE_EDGE, 0
	dw 305
	db %00000
	db DEDGE_EDGE, 0
	dw 309
	db %00000
	db DEDGE_WALK, 0
	dw 317
	db %00010
	db -1
.Node316:
	db DEDGE_EDGE, 0
	dw 310
	db %00000
	db -1
.Node317:
	db DEDGE_EDGE, 0
	dw 306
	db %00000
	db DEDGE_WALK, 0
	dw 315
	db %00000
	db -1
.Node318:
	db DEDGE_EDGE, 0
	dw 307
	db %00000
	db -1
.Node319:
	db DEDGE_EDGE, 0
	dw 308
	db %00000
	db -1
.Node320:
	db DEDGE_EDGE, 1
	dw 304
	db %00000
	db DEDGE_EDGE, 2
	dw 287
	db %00000
	db -1
.Node321:
	db DEDGE_EDGE, 1
	dw 306
	db %00000
	db DEDGE_EDGE, 2
	dw 290
	db %00000
	db -1
.Node322:
	db DEDGE_EDGE, 1
	dw 312
	db %00000
	db -1
.Node323:
	db DEDGE_EDGE, 1
	dw 313
	db %00000
	db -1
.Node324:
	db DEDGE_WARP, 1
	dw 278
	db %00000
	db DEDGE_WARP, 2
	dw 279
	db %00000
	db DEDGE_WARP, 3
	dw 280
	db %00000
	db DEDGE_WARP, 4
	dw 281
	db %00000
	db DEDGE_WARP, 5
	dw 282
	db %00000
	db DEDGE_WARP, 6
	dw 283
	db %00000
	db DEDGE_EDGE, 0
	dw 656
	db %00000
	db DEDGE_EDGE, 0
	dw 658
	db %00000
	db DEDGE_EDGE, 2
	dw 288
	db %00000
	db DEDGE_EDGE, 3
	dw 296
	db %00000
	db -1
.Node325:
	db DEDGE_EDGE, 1
	dw 309
	db %00000
	db DEDGE_WALK, 0
	dw 324
	db %00000
	db -1
.Node326:
	db DEDGE_EDGE, 3
	dw 292
	db %00000
	db DEDGE_WALK, 0
	dw 327
	db %00010
	db -1
.Node327:
	db DEDGE_EDGE, 1
	dw 311
	db %00000
	db DEDGE_WALK, 0
	dw 326
	db %00000
	db -1
.Node328:
	db DEDGE_EDGE, 2
	dw 291
	db %00000
	db DEDGE_EDGE, 2
	dw 287
	db %00000
	db -1
.Node329:
	db DEDGE_EDGE, 3
	dw 297
	db %00000
	db -1
.Node330:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db -1
.Node331:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db -1
.Node332:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db -1
.Node333:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db -1
.Node334:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db -1
.Node335:
	db DEDGE_WARP, 1
	dw 99
	db %00000
	db DEDGE_EDGE, 1
	dw 350
	db %00000
	db DEDGE_EDGE, 2
	dw 338
	db %00000
	db -1
.Node336:
	db DEDGE_WARP, 1
	dw 99
	db %00000
	db DEDGE_EDGE, 2
	dw 337
	db %00000
	db -1
.Node337:
	db DEDGE_WARP, 1
	dw 330
	db %00000
	db DEDGE_WARP, 2
	dw 331
	db %00000
	db DEDGE_WARP, 3
	dw 332
	db %00000
	db DEDGE_WARP, 4
	dw 333
	db %00000
	db DEDGE_WARP, 5
	dw 334
	db %00000
	db DEDGE_WARP, 6
	dw 107
	db %00000
	db DEDGE_WARP, 7
	dw 400
	db %00000
	db DEDGE_EDGE, 3
	dw 336
	db %00000
	db -1
.Node338:
	db DEDGE_EDGE, 3
	dw 335
	db %00000
	db -1
.Node339:
	db DEDGE_WARP, 1
	dw 346
	db %00000
	db -1
.Node340:
	db DEDGE_WARP, 1
	dw 347
	db %00000
	db -1
.Node341:
	db DEDGE_WARP, 1
	dw 343
	db %00000
	db DEDGE_WARP, 3
	dw 36
	db %00000
	db -1
.Node342:
	db DEDGE_WARP, 1
	dw 343
	db %00000
	db -1
.Node343:
	db DEDGE_WARP, 1
	dw 341
	db %00000
	db DEDGE_WARP, 3
	dw 342
	db %00000
	db DEDGE_EDGE, 1
	dw 348
	db %00000
	db DEDGE_EDGE, 1
	dw 347
	db %00000
	db -1
.Node344:
	db DEDGE_EDGE, 0
	dw 35
	db %00000
	db -1
.Node345:
	db DEDGE_EDGE, 0
	dw 37
	db %00000
	db -1
.Node346:
	db DEDGE_WARP, 1
	dw 339
	db %00000
	db DEDGE_WALK, 0
	dw 348
	db %00001
	db -1
.Node347:
	db DEDGE_WARP, 2
	dw 340
	db %00000
	db DEDGE_EDGE, 0
	dw 343
	db %00000
	db -1
.Node348:
	db DEDGE_EDGE, 0
	dw 343
	db %00000
	db DEDGE_WALK, 0
	dw 346
	db %00001
	db -1
.Node349:
	db DEDGE_WARP, 1
	dw 365
	db %00000
	db DEDGE_WARP, 2
	dw 364
	db %00000
	db DEDGE_WARP, 4
	dw 99
	db %00000
	db DEDGE_EDGE, 1
	dw 357
	db %00000
	db -1
.Node350:
	db DEDGE_WARP, 4
	dw 99
	db %00000
	db DEDGE_EDGE, 0
	dw 335
	db %00000
	db -1
.Node351:
	db DEDGE_EDGE, 1
	dw 355
	db %00000
	db DEDGE_WALK, 0
	dw 352
	db %00001
	db -1
.Node352:
	db DEDGE_WARP, 1
	dw 366
	db %00000
	db DEDGE_WARP, 3
	dw 367
	db %00000
	db DEDGE_WALK, 0
	dw 351
	db %00001
	db -1
.Node353:
	db DEDGE_EDGE, 0
	dw 376
	db %00000
	db -1
.Node354:
	db DEDGE_EDGE, 0
	dw 378
	db %00000
	db -1
.Node355:
	db DEDGE_WARP, 1
	dw 370
	db %00000
	db DEDGE_WARP, 3
	dw 368
	db %00000
	db DEDGE_EDGE, 1
	dw 356
	db %00000
	db DEDGE_EDGE, 0
	dw 351
	db %00000
	db DEDGE_EDGE, 3
	dw 357
	db %00000
	db -1
.Node356:
	db DEDGE_EDGE, 1
	dw 243
	db %00000
	db DEDGE_EDGE, 0
	dw 355
	db %00000
	db -1
.Node357:
	db DEDGE_WARP, 1
	dw 358
	db %00000
	db DEDGE_WARP, 2
	dw 359
	db %00000
	db DEDGE_WARP, 3
	dw 360
	db %00000
	db DEDGE_WARP, 4
	dw 361
	db %00000
	db DEDGE_WARP, 5
	dw 362
	db %00000
	db DEDGE_WARP, 6
	dw 363
	db %00000
	db DEDGE_WARP, 7
	dw 40
	db %00000
	db DEDGE_WARP, 8
	dw 692
	db %00000
	db DEDGE_EDGE, 0
	dw 349
	db %00000
	db DEDGE_EDGE, 2
	dw 355
	db %00000
	db -1
.Node358:
	db DEDGE_WARP, 1
	dw 357
	db %00000
	db -1
.Node359:
	db DEDGE_WARP, 1
	dw 357
	db %00000
	db -1
.Node360:
	db DEDGE_WARP, 1
	dw 357
	db %00000
	db -1
.Node361:
	db DEDGE_WARP, 1
	dw 357
	db %00000
	db -1
.Node362:
	db DEDGE_WARP, 1
	dw 357
	db %00000
	db -1
.Node363:
	db DEDGE_WARP, 1
	dw 357
	db %00000
	db -1
.Node364:
	db DEDGE_WARP, 1
	dw 76
	db %00000
	db DEDGE_WARP, 3
	dw 349
	db %00000
	db -1
.Node365:
	db DEDGE_WARP, 1
	dw 349
	db %00000
	db -1
.Node366:
	db DEDGE_WARP, 1
	dw 352
	db %00000
	db DEDGE_WARP, 3
	dw 377
	db %00000
	db -1
.Node367:
	db DEDGE_WARP, 1
	dw 67
	db %00000
	db DEDGE_WARP, 3
	dw 352
	db %00000
	db -1
.Node368:
	db DEDGE_WARP, 1
	dw 355
	db %00000
	db DEDGE_WARP, 3
	dw 76
	db %00000
	db -1
.Node369:
	db DEDGE_WARP, 1
	dw 67
	db %00000
	db -1
.Node370:
	db DEDGE_WARP, 1
	dw 67
	db %00000
	db DEDGE_WARP, 3
	dw 355
	db %00000
	db -1
.Node371:
	db DEDGE_EDGE, 1
	dw 379
	db %00000
	db DEDGE_WALK, 0
	dw 372
	db %00010
	db -1
.Node372:
	db DEDGE_EDGE, 1
	dw 379
	db %00000
	db DEDGE_WALK, 0
	dw 371
	db %00000
	db -1
.Node373:
	db DEDGE_WARP, 1
	dw 401
	db %00000
	db DEDGE_WARP, 3
	dw 402
	db %00000
	db DEDGE_EDGE, 1
	dw 377
	db %00000
	db -1
.Node374:
	db DEDGE_EDGE, 1
	dw 380
	db %00000
	db -1
.Node375:
	db DEDGE_WARP, 5
	dw 402
	db %00000
	db -1
.Node376:
	db DEDGE_EDGE, 1
	dw 353
	db %00000
	db -1
.Node377:
	db DEDGE_WARP, 1
	dw 381
	db %00000
	db DEDGE_WARP, 2
	dw 382
	db %00000
	db DEDGE_WARP, 2
	dw 383
	db %00000
	db DEDGE_WARP, 3
	dw 384
	db %00000
	db DEDGE_WARP, 4
	dw 385
	db %00000
	db DEDGE_WARP, 5
	dw 386
	db %00000
	db DEDGE_WARP, 6
	dw 387
	db %00000
	db DEDGE_WARP, 7
	dw 388
	db %00000
	db DEDGE_WARP, 8
	dw 389
	db %00000
	db DEDGE_WARP, 9
	dw 390
	db %00000
	db DEDGE_WARP, 10
	dw 398
	db %00000
	db DEDGE_WARP, 11
	dw 68
	db %00000
	db DEDGE_WARP, 12
	dw 366
	db %00000
	db DEDGE_WARP, 13
	dw 133
	db %00000
	db DEDGE_WARP, 14
	dw 132
	db %00000
	db DEDGE_WARP, 15
	dw 399
	db %00000
	db DEDGE_EDGE, 0
	dw 373
	db %00000
	db -1
.Node378:
	db DEDGE_EDGE, 1
	dw 354
	db %00000
	db -1
.Node379:
	db DEDGE_EDGE, 0
	dw 372
	db %00000
	db DEDGE_EDGE, 0
	dw 371
	db %00000
	db -1
.Node380:
	db DEDGE_EDGE, 0
	dw 374
	db %00000
	db -1
.Node381:
	db DEDGE_WARP, 1
	dw 377
	db %00000
	db -1
.Node382:
	db DEDGE_WARP, 1
	dw 377
	db %00000
	db -1
.Node383:
	db DEDGE_WARP, 1
	dw 377
	db %00000
	db -1
.Node384:
	db DEDGE_WARP, 1
	dw 377
	db %00000
	db -1
.Node385:
	db DEDGE_WARP, 1
	dw 377
	db %00000
	db -1
.Node386:
	db DEDGE_WARP, 1
	dw 377
	db %00000
	db DEDGE_WARP, 3
	dw 674
	db %00000
	db -1
.Node387:
	db DEDGE_WARP, 1
	dw 377
	db %00000
	db -1
.Node388:
	db DEDGE_WARP, 1
	dw 377
	db %00000
	db -1
.Node389:
	db DEDGE_WARP, 1
	dw 377
	db %00000
	db -1
.Node390:
	db DEDGE_WARP, 1
	dw 377
	db %00000
	db DEDGE_WARP, 3
	dw 391
	db %00000
	db DEDGE_WARP, 4
	dw 396
	db %00000
	db -1
.Node391:
	db DEDGE_WARP, 1
	dw 392
	db %00000
	db DEDGE_WARP, 2
	dw 390
	db %00000
	db DEDGE_WARP, 3
	dw 396
	db %00000
	db -1
.Node392:
	db DEDGE_WARP, 1
	dw 391
	db %00000
	db DEDGE_WARP, 2
	dw 393
	db %00000
	db DEDGE_WARP, 3
	dw 396
	db %00000
	db -1
.Node393:
	db DEDGE_WARP, 1
	dw 394
	db %00000
	db DEDGE_WARP, 2
	dw 392
	db %00000
	db DEDGE_WARP, 3
	dw 396
	db %00000
	db -1
.Node394:
	db DEDGE_WARP, 1
	dw 393
	db %00000
	db DEDGE_WARP, 2
	dw 395
	db %00000
	db DEDGE_WARP, 3
	dw 396
	db %00000
	db -1
.Node395:
	db DEDGE_WARP, 1
	dw 394
	db %00000
	db DEDGE_WARP, 2
	dw 396
	db %00000
	db DEDGE_WARP, 3
	dw 397
	db %00000
	db -1
.Node396:
	db DEDGE_WARP, 1
	dw 390
	db %00000
	db -1
.Node397:
	db DEDGE_WARP, 1
	dw 395
	db %00000
	db -1
.Node398:
	db DEDGE_WARP, 1
	dw 377
	db %00000
	db -1
.Node399:
	db DEDGE_WARP, 1
	dw 377
	db %00000
	db -1
.Node400:
	db DEDGE_WARP, 1
	dw 127
	db %00000
	db DEDGE_WARP, 3
	dw 337
	db %00000
	db -1
.Node401:
	db DEDGE_WARP, 1
	dw 373
	db %00000
	db DEDGE_WARP, 3
	dw 126
	db %00000
	db -1
.Node402:
	db DEDGE_WARP, 1
	dw 373
	db %00000
	db DEDGE_WARP, 3
	dw 375
	db %00000
	db -1
.Node403:
	db DEDGE_WARP, 1
	dw 420
	db %00000
	db DEDGE_WARP, 2
	dw 419
	db %00000
	db DEDGE_EDGE, 0
	dw 408
	db %00000
	db -1
.Node404:
	db DEDGE_EDGE, 0
	dw 407
	db %00000
	db -1
.Node405:
	db DEDGE_EDGE, 0
	dw 409
	db %00000
	db -1
.Node406:
	db DEDGE_EDGE, 2
	dw 408
	db %00000
	db DEDGE_EDGE, 3
	dw 517
	db %00000
	db -1
.Node407:
	db DEDGE_EDGE, 1
	dw 404
	db %00000
	db -1
.Node408:
	db DEDGE_WARP, 1
	dw 412
	db %00000
	db DEDGE_WARP, 2
	dw 413
	db %00000
	db DEDGE_WARP, 3
	dw 414
	db %00000
	db DEDGE_WARP, 4
	dw 415
	db %00000
	db DEDGE_WARP, 5
	dw 416
	db %00000
	db DEDGE_WARP, 6
	dw 417
	db %00000
	db DEDGE_WARP, 8
	dw 471
	db %00000
	db DEDGE_WARP, 10
	dw 213
	db %00000
	db DEDGE_EDGE, 1
	dw 403
	db %00000
	db DEDGE_EDGE, 3
	dw 406
	db %00000
	db DEDGE_WALK, 0
	dw 410
	db %00001
	db DEDGE_WALK, 0
	dw 410
	db %00010
	db -1
.Node409:
	db DEDGE_EDGE, 1
	dw 405
	db %00000
	db -1
.Node410:
	db DEDGE_WARP, 7
	dw 418
	db %00000
	db DEDGE_WALK, 0
	dw 408
	db %00001
	db DEDGE_WALK, 0
	dw 408
	db %00010
	db -1
.Node411:
	db DEDGE_WARP, 10
	dw 213
	db %00000
	db -1
.Node412:
	db DEDGE_WARP, 1
	dw 408
	db %00000
	db -1
.Node413:
	db DEDGE_WARP, 1
	dw 408
	db %00000
	db -1
.Node414:
	db DEDGE_WARP, 1
	dw 408
	db %00000
	db -1
.Node415:
	db DEDGE_WARP, 1
	dw 408
	db %00000
	db -1
.Node416:
	db DEDGE_WARP, 1
	dw 408
	db %00000
	db -1
.Node417:
	db DEDGE_WARP, 1
	dw 408
	db %00000
	db -1
.Node418:
	db DEDGE_WARP, 1
	dw 410
	db %00000
	db -1
.Node419:
	db DEDGE_WARP, 1
	dw 659
	db %00000
	db DEDGE_WARP, 3
	dw 403
	db %00000
	db -1
.Node420:
	db DEDGE_WARP, 1
	dw 403
	db %00000
	db DEDGE_WARP, 3
	dw 218
	db %00000
	db -1
.Node421:
	db DEDGE_EDGE, 1
	dw 614
	db %00000
	db DEDGE_EDGE, 0
	dw 428
	db %00000
	db -1
.Node422:
	db DEDGE_EDGE, 1
	dw 615
	db %00000
	db -1
.Node423:
	db DEDGE_EDGE, 1
	dw 612
	db %00000
	db DEDGE_EDGE, 0
	dw 430
	db %00000
	db -1
.Node424:
	db DEDGE_EDGE, 1
	dw 616
	db %00000
	db -1
.Node425:
	db DEDGE_EDGE, 1
	dw 617
	db %00000
	db DEDGE_EDGE, 0
	dw 431
	db %00000
	db DEDGE_EDGE, 0
	dw 432
	db %00000
	db -1
.Node426:
	db DEDGE_EDGE, 0
	dw 428
	db %00000
	db DEDGE_EDGE, 0
	dw 429
	db %00000
	db -1
.Node427:
	db DEDGE_EDGE, 0
	dw 431
	db %00000
	db -1
.Node428:
	db DEDGE_EDGE, 1
	dw 421
	db %00000
	db DEDGE_EDGE, 1
	dw 426
	db %00000
	db -1
.Node429:
	db DEDGE_EDGE, 1
	dw 426
	db %00000
	db -1
.Node430:
	db DEDGE_WARP, 1
	dw 434
	db %00000
	db DEDGE_WARP, 2
	dw 436
	db %00000
	db DEDGE_WARP, 3
	dw 437
	db %00000
	db DEDGE_EDGE, 1
	dw 423
	db %00000
	db DEDGE_WALK, 0
	dw 433
	db %00010
	db -1
.Node431:
	db DEDGE_EDGE, 1
	dw 427
	db %00000
	db DEDGE_EDGE, 1
	dw 425
	db %00000
	db -1
.Node432:
	db DEDGE_EDGE, 1
	dw 425
	db %00000
	db -1
.Node433:
	db DEDGE_EDGE, 0
	dw 273
	db %00000
	db DEDGE_WALK, 0
	dw 430
	db %00000
	db -1
.Node434:
	db DEDGE_WARP, 1
	dw 430
	db %00000
	db DEDGE_WARP, 3
	dw 435
	db %00000
	db -1
.Node435:
	db DEDGE_WARP, 1
	dw 434
	db %00000
	db -1
.Node436:
	db DEDGE_WARP, 1
	dw 430
	db %00000
	db -1
.Node437:
	db DEDGE_WARP, 1
	dw 430
	db %00000
	db -1
.Node438:
	db DEDGE_WARP, 1
	dw 214
	db %00000
	db DEDGE_EDGE, 2
	dw 442
	db %00000
	db DEDGE_EDGE, 3
	dw 287
	db %00000
	db -1
.Node439:
	db DEDGE_WARP, 1
	dw 214
	db %00000
	db DEDGE_EDGE, 2
	dw 441
	db %00000
	db -1
.Node440:
	db DEDGE_EDGE, 2
	dw 443
	db %00000
	db DEDGE_EDGE, 2
	dw 444
	db %00000
	db -1
.Node441:
	db DEDGE_WARP, 1
	dw 445
	db %00000
	db DEDGE_WARP, 2
	dw 446
	db %00000
	db DEDGE_WARP, 3
	dw 447
	db %00000
	db DEDGE_WARP, 4
	dw 448
	db %00000
	db DEDGE_WARP, 5
	dw 449
	db %00000
	db DEDGE_EDGE, 0
	dw 604
	db %00000
	db DEDGE_EDGE, 3
	dw 439
	db %00000
	db -1
.Node442:
	db DEDGE_EDGE, 3
	dw 438
	db %00000
	db -1
.Node443:
	db DEDGE_EDGE, 3
	dw 440
	db %00000
	db -1
.Node444:
	db DEDGE_EDGE, 3
	dw 440
	db %00000
	db -1
.Node445:
	db DEDGE_WARP, 1
	dw 441
	db %00000
	db -1
.Node446:
	db DEDGE_WARP, 1
	dw 441
	db %00000
	db -1
.Node447:
	db DEDGE_WARP, 1
	dw 441
	db %00000
	db -1
.Node448:
	db DEDGE_WARP, 1
	dw 441
	db %00000
	db -1
.Node449:
	db DEDGE_WARP, 1
	dw 441
	db %00000
	db -1
.Node450:
	db DEDGE_WARP, 1
	dw 468
	db %00000
	db -1
.Node451:
	db DEDGE_WARP, 2
	dw 456
	db %00000
	db -1
.Node452:
	db DEDGE_WARP, 2
	dw 456
	db %00000
	db -1
.Node453:
	db DEDGE_WARP, 1
	dw 470
	db %00000
	db -1
.Node454:
	db DEDGE_WARP, 2
	dw 456
	db %00000
	db -1
.Node455:
	db DEDGE_WARP, 2
	dw 456
	db %00000
	db -1
.Node456:
	db DEDGE_WARP, 1
	dw 457
	db %00000
	db DEDGE_WARP, 2
	dw 458
	db %00000
	db DEDGE_WARP, 3
	dw 459
	db %00000
	db DEDGE_WARP, 4
	dw 460
	db %00000
	db DEDGE_WARP, 5
	dw 461
	db %00000
	db DEDGE_WARP, 6
	dw 462
	db %00000
	db DEDGE_WARP, 7
	dw 463
	db %00000
	db DEDGE_WARP, 8
	dw 464
	db %00000
	db DEDGE_WARP, 9
	dw 465
	db %00000
	db DEDGE_WARP, 12
	dw 467
	db %00000
	db -1
.Node457:
	db DEDGE_WARP, 10
	dw 466
	db %00000
	db DEDGE_WARP, 11
	dw 467
	db %00000
	db -1
.Node458:
	db DEDGE_WARP, 1
	dw 456
	db %00000
	db -1
.Node459:
	db DEDGE_WARP, 2
	dw 456
	db %00000
	db -1
.Node460:
	db DEDGE_WARP, 3
	dw 456
	db %00000
	db -1
.Node461:
	db DEDGE_WARP, 1
	dw 456
	db %00000
	db -1
.Node462:
	db DEDGE_WARP, 2
	dw 456
	db %00000
	db -1
.Node463:
	db DEDGE_WARP, 4
	dw 456
	db %00000
	db -1
.Node464:
	db DEDGE_WARP, 1
	dw 456
	db %00000
	db -1
.Node465:
	db DEDGE_WARP, 3
	dw 456
	db %00000
	db -1
.Node466:
	db DEDGE_WARP, 5
	dw 457
	db %00000
	db -1
.Node467:
	db DEDGE_WARP, 1
	dw 457
	db %00000
	db DEDGE_WARP, 2
	dw 456
	db %00000
	db -1
.Node468:
	db DEDGE_WARP, 4
	dw 469
	db %00000
	db DEDGE_WARP, 5
	dw 450
	db %00000
	db -1
.Node469:
	db DEDGE_WARP, 1
	dw 20
	db %00000
	db DEDGE_WARP, 3
	dw 468
	db %00000
	db -1
.Node470:
	db DEDGE_WARP, 4
	dw 471
	db %00000
	db DEDGE_WARP, 5
	dw 453
	db %00000
	db -1
.Node471:
	db DEDGE_WARP, 1
	dw 408
	db %00000
	db DEDGE_WARP, 3
	dw 470
	db %00000
	db -1
.Node472:
	db DEDGE_WARP, 1
	dw 215
	db %00000
	db DEDGE_WARP, 2
	dw 217
	db %00000
	db -1
.Node473:
	db DEDGE_WARP, 1
	dw 215
	db %00000
	db DEDGE_WARP, 2
	dw 217
	db %00000
	db DEDGE_WARP, 3
	dw 474
	db %00000
	db -1
.Node474:
	db DEDGE_WARP, 1
	dw 473
	db %00000
	db -1
.Node475:
	db DEDGE_WARP, 1
	dw 60
	db %00000
	db -1
.Node476:
	db DEDGE_WARP, 1
	dw 477
	db %00000
	db DEDGE_WARP, 3
	dw 228
	db %00000
	db DEDGE_WARP, 3
	dw 226
	db %00000
	db -1
.Node477:
	db DEDGE_WARP, 1
	dw 476
	db %00000
	db DEDGE_WARP, 4
	dw 478
	db %00000
	db -1
.Node478:
	db DEDGE_WARP, 1
	dw 477
	db %00000
	db -1
.Node479:
	db -1
.Node480:
	db -1
.Node481:
	db -1
.Node482:
	db -1
.Node483:
	db DEDGE_EDGE, 0
	dw 489
	db %00000
	db -1
.Node484:
	db DEDGE_EDGE, 1
	dw 519
	db %00000
	db -1
.Node485:
	db DEDGE_EDGE, 1
	dw 520
	db %00000
	db -1
.Node486:
	db DEDGE_EDGE, 1
	dw 521
	db %00000
	db DEDGE_WALK, 0
	dw 487
	db %00010
	db DEDGE_WALK, 0
	dw 488
	db %00010
	db -1
.Node487:
	db DEDGE_EDGE, 0
	dw 490
	db %00000
	db DEDGE_WALK, 0
	dw 488
	db %00010
	db -1
.Node488:
	db DEDGE_EDGE, 1
	dw 518
	db %00000
	db DEDGE_WALK, 0
	dw 487
	db %00000
	db -1
.Node489:
	db DEDGE_EDGE, 1
	dw 483
	db %00000
	db -1
.Node490:
	db DEDGE_EDGE, 1
	dw 487
	db %00000
	db DEDGE_EDGE, 2
	dw 493
	db %00000
	db DEDGE_WALK, 0
	dw 492
	db %00001
	db -1
.Node491:
	db DEDGE_EDGE, 2
	dw 495
	db %00000
	db -1
.Node492:
	db DEDGE_EDGE, 2
	dw 494
	db %00000
	db DEDGE_WALK, 0
	dw 490
	db %00000
	db -1
.Node493:
	db DEDGE_WARP, 1
	dw 509
	db %00000
	db DEDGE_EDGE, 3
	dw 490
	db %00000
	db -1
.Node494:
	db DEDGE_EDGE, 3
	dw 492
	db %00000
	db DEDGE_WALK, 0
	dw 493
	db %00000
	db -1
.Node495:
	db DEDGE_EDGE, 3
	dw 491
	db %00000
	db -1
.Node496:
	db DEDGE_EDGE, 2
	dw 554
	db %00000
	db -1
.Node497:
	db DEDGE_WARP, 1
	dw 582
	db %00000
	db DEDGE_EDGE, 3
	dw 500
	db %00000
	db -1
.Node498:
	db DEDGE_EDGE, 2
	dw 553
	db %00000
	db -1
.Node499:
	db DEDGE_WARP, 1
	dw 503
	db %00000
	db DEDGE_WALK, 0
	dw 500
	db %00001
	db -1
.Node500:
	db DEDGE_WARP, 2
	dw 504
	db %00000
	db DEDGE_WARP, 3
	dw 505
	db %00000
	db DEDGE_WARP, 4
	dw 506
	db %00000
	db DEDGE_WARP, 5
	dw 507
	db %00000
	db DEDGE_WARP, 6
	dw 508
	db %00000
	db DEDGE_WARP, 8
	dw 509
	db %00000
	db DEDGE_WARP, 10
	dw 264
	db %00000
	db DEDGE_EDGE, 0
	dw 267
	db %00000
	db DEDGE_EDGE, 2
	dw 497
	db %00000
	db DEDGE_WALK, 0
	dw 499
	db %00001
	db -1
.Node501:
	db DEDGE_EDGE, 0
	dw 268
	db %00000
	db -1
.Node502:
	db DEDGE_EDGE, 0
	dw 266
	db %00000
	db -1
.Node503:
	db DEDGE_WARP, 1
	dw 499
	db %00000
	db -1
.Node504:
	db DEDGE_WARP, 1
	dw 500
	db %00000
	db -1
.Node505:
	db DEDGE_WARP, 1
	dw 500
	db %00000
	db -1
.Node506:
	db DEDGE_WARP, 1
	dw 500
	db %00000
	db -1
.Node507:
	db DEDGE_WARP, 1
	dw 500
	db %00000
	db -1
.Node508:
	db DEDGE_WARP, 1
	dw 500
	db %00000
	db -1
.Node509:
	db DEDGE_WARP, 1
	dw 500
	db %00000
	db DEDGE_WARP, 3
	dw 493
	db %00000
	db -1
.Node510:
	db DEDGE_EDGE, 3
	dw 524
	db %00000
	db -1
.Node511:
	db DEDGE_WARP, 1
	dw 537
	db %00000
	db DEDGE_EDGE, 3
	dw 525
	db %00000
	db -1
.Node512:
	db DEDGE_EDGE, 3
	dw 527
	db %00000
	db -1
.Node513:
	db DEDGE_EDGE, 1
	dw 527
	db %00000
	db -1
.Node514:
	db DEDGE_EDGE, 1
	dw 525
	db %00000
	db -1
.Node515:
	db DEDGE_EDGE, 1
	dw 526
	db %00000
	db -1
.Node516:
	db DEDGE_WARP, 1
	dw 538
	db %00000
	db DEDGE_WALK, 0
	dw 517
	db %00010
	db DEDGE_WALK, 0
	dw 518
	db %00010
	db -1
.Node517:
	db DEDGE_EDGE, 2
	dw 406
	db %00000
	db DEDGE_WALK, 0
	dw 516
	db %00010
	db DEDGE_WALK, 0
	dw 518
	db %00010
	db -1
.Node518:
	db DEDGE_EDGE, 0
	dw 488
	db %00000
	db DEDGE_WALK, 0
	dw 516
	db %00000
	db DEDGE_WALK, 0
	dw 517
	db %00000
	db -1
.Node519:
	db DEDGE_EDGE, 0
	dw 484
	db %00000
	db -1
.Node520:
	db DEDGE_EDGE, 0
	dw 485
	db %00000
	db -1
.Node521:
	db DEDGE_EDGE, 0
	dw 486
	db %00000
	db DEDGE_WALK, 0
	dw 516
	db %00010
	db DEDGE_WALK, 0
	dw 517
	db %00010
	db DEDGE_WALK, 0
	dw 518
	db %00010
	db -1
.Node522:
	db DEDGE_WARP, 1
	dw 221
	db %00000
	db DEDGE_EDGE, 1
	dw 300
	db %00000
	db DEDGE_EDGE, 0
	dw 524
	db %00000
	db DEDGE_EDGE, 0
	dw 526
	db %00000
	db -1
.Node523:
	db DEDGE_WARP, 1
	dw 221
	db %00000
	db DEDGE_EDGE, 0
	dw 525
	db %00000
	db -1
.Node524:
	db DEDGE_EDGE, 1
	dw 522
	db %00000
	db DEDGE_EDGE, 2
	dw 510
	db %00000
	db -1
.Node525:
	db DEDGE_WARP, 1
	dw 528
	db %00000
	db DEDGE_WARP, 2
	dw 529
	db %00000
	db DEDGE_WARP, 3
	dw 530
	db %00000
	db DEDGE_WARP, 4
	dw 531
	db %00000
	db DEDGE_WARP, 5
	dw 532
	db %00000
	db DEDGE_WARP, 6
	dw 533
	db %00000
	db DEDGE_WARP, 6
	dw 534
	db %00000
	db DEDGE_WARP, 7
	dw 536
	db %00000
	db DEDGE_EDGE, 1
	dw 523
	db %00000
	db DEDGE_EDGE, 0
	dw 514
	db %00000
	db DEDGE_EDGE, 2
	dw 511
	db %00000
	db -1
.Node526:
	db DEDGE_EDGE, 1
	dw 522
	db %00000
	db DEDGE_EDGE, 0
	dw 515
	db %00000
	db -1
.Node527:
	db DEDGE_EDGE, 0
	dw 513
	db %00000
	db DEDGE_EDGE, 2
	dw 512
	db %00000
	db -1
.Node528:
	db DEDGE_WARP, 1
	dw 525
	db %00000
	db -1
.Node529:
	db DEDGE_WARP, 1
	dw 525
	db %00000
	db -1
.Node530:
	db DEDGE_WARP, 1
	dw 525
	db %00000
	db -1
.Node531:
	db DEDGE_WARP, 1
	dw 525
	db %00000
	db -1
.Node532:
	db DEDGE_WARP, 1
	dw 525
	db %00000
	db -1
.Node533:
	db DEDGE_WARP, 1
	dw 525
	db %00000
	db -1
.Node534:
	db DEDGE_WARP, 1
	dw 525
	db %00000
	db -1
.Node535:
	db DEDGE_WARP, 2
	dw 525
	db %00000
	db -1
.Node536:
	db DEDGE_WARP, 1
	dw 525
	db %00000
	db -1
.Node537:
	db DEDGE_WARP, 1
	dw 659
	db %00000
	db DEDGE_WARP, 3
	dw 511
	db %00000
	db -1
.Node538:
	db DEDGE_WARP, 1
	dw 516
	db %00000
	db -1
.Node539:
	db DEDGE_EDGE, 2
	dw 542
	db %00000
	db -1
.Node540:
	db DEDGE_WARP, 2
	dw 626
	db %00000
	db DEDGE_EDGE, 2
	dw 543
	db %00000
	db -1
.Node541:
	db DEDGE_WARP, 1
	dw 546
	db %00000
	db DEDGE_EDGE, 2
	dw 544
	db %00000
	db DEDGE_WALK, 0
	dw 540
	db %00000
	db -1
.Node542:
	db DEDGE_WARP, 2
	dw 190
	db %00000
	db DEDGE_EDGE, 3
	dw 539
	db %00000
	db -1
.Node543:
	db DEDGE_WARP, 1
	dw 545
	db %00000
	db DEDGE_WARP, 2
	dw 190
	db %00000
	db DEDGE_EDGE, 3
	dw 540
	db %00000
	db DEDGE_WALK, 0
	dw 544
	db %00001
	db -1
.Node544:
	db DEDGE_EDGE, 3
	dw 541
	db %00000
	db DEDGE_WALK, 0
	dw 543
	db %00001
	db -1
.Node545:
	db DEDGE_WARP, 1
	dw 543
	db %00000
	db -1
.Node546:
	db DEDGE_WARP, 1
	dw 541
	db %00000
	db -1
.Node547:
	db DEDGE_WARP, 1
	dw 581
	db %00000
	db DEDGE_EDGE, 2
	dw 555
	db %00000
	db -1
.Node548:
	db DEDGE_EDGE, 3
	dw 660
	db %00000
	db -1
.Node549:
	db DEDGE_WARP, 1
	dw 579
	db %00000
	db DEDGE_WALK, 0
	dw 550
	db %00001
	db -1
.Node550:
	db DEDGE_WARP, 2
	dw 580
	db %00000
	db DEDGE_EDGE, 3
	dw 555
	db %00000
	db DEDGE_WALK, 0
	dw 549
	db %00001
	db -1
.Node551:
	db DEDGE_WARP, 4
	dw 580
	db %00000
	db DEDGE_EDGE, 0
	dw 552
	db %00000
	db -1
.Node552:
	db DEDGE_WARP, 1
	dw 582
	db %00000
	db DEDGE_EDGE, 1
	dw 551
	db %00000
	db -1
.Node553:
	db DEDGE_EDGE, 3
	dw 498
	db %00000
	db -1
.Node554:
	db DEDGE_EDGE, 3
	dw 496
	db %00000
	db -1
.Node555:
	db DEDGE_WARP, 1
	dw 557
	db %00000
	db DEDGE_WARP, 2
	dw 565
	db %00000
	db DEDGE_WARP, 2
	dw 566
	db %00000
	db DEDGE_WARP, 3
	dw 564
	db %00000
	db DEDGE_WARP, 5
	dw 574
	db %00000
	db DEDGE_WARP, 6
	dw 575
	db %00000
	db DEDGE_WARP, 7
	dw 576
	db %00000
	db DEDGE_WARP, 9
	dw 578
	db %00000
	db DEDGE_EDGE, 2
	dw 550
	db %00000
	db DEDGE_EDGE, 3
	dw 547
	db %00000
	db DEDGE_WALK, 0
	dw 556
	db %00001
	db -1
.Node556:
	db DEDGE_WARP, 8
	dw 577
	db %00000
	db DEDGE_WALK, 0
	dw 555
	db %00001
	db -1
.Node557:
	db DEDGE_WARP, 1
	dw 555
	db %00000
	db DEDGE_WARP, 3
	dw 558
	db %00000
	db DEDGE_WARP, 4
	dw 563
	db %00000
	db -1
.Node558:
	db DEDGE_WARP, 1
	dw 559
	db %00000
	db DEDGE_WARP, 2
	dw 557
	db %00000
	db DEDGE_WARP, 3
	dw 563
	db %00000
	db -1
.Node559:
	db DEDGE_WARP, 1
	dw 558
	db %00000
	db DEDGE_WARP, 2
	dw 560
	db %00000
	db DEDGE_WARP, 3
	dw 563
	db %00000
	db -1
.Node560:
	db DEDGE_WARP, 1
	dw 561
	db %00000
	db DEDGE_WARP, 2
	dw 559
	db %00000
	db DEDGE_WARP, 3
	dw 563
	db %00000
	db -1
.Node561:
	db DEDGE_WARP, 1
	dw 560
	db %00000
	db DEDGE_WARP, 2
	dw 562
	db %00000
	db DEDGE_WARP, 3
	dw 563
	db %00000
	db -1
.Node562:
	db DEDGE_WARP, 1
	dw 561
	db %00000
	db DEDGE_WARP, 2
	dw 563
	db %00000
	db -1
.Node563:
	db DEDGE_WARP, 1
	dw 557
	db %00000
	db -1
.Node564:
	db DEDGE_WARP, 3
	dw 555
	db %00000
	db DEDGE_WARP, 4
	dw 567
	db %00000
	db -1
.Node565:
	db DEDGE_WARP, 1
	dw 555
	db %00000
	db DEDGE_WARP, 5
	dw 568
	db %00000
	db -1
.Node566:
	db DEDGE_WARP, 1
	dw 555
	db %00000
	db -1
.Node567:
	db DEDGE_WARP, 1
	dw 564
	db %00000
	db DEDGE_WARP, 2
	dw 569
	db %00000
	db -1
.Node568:
	db DEDGE_WARP, 3
	dw 570
	db %00000
	db DEDGE_WARP, 4
	dw 565
	db %00000
	db -1
.Node569:
	db DEDGE_WARP, 1
	dw 571
	db %00000
	db DEDGE_WARP, 2
	dw 567
	db %00000
	db -1
.Node570:
	db DEDGE_WARP, 3
	dw 568
	db %00000
	db DEDGE_WARP, 4
	dw 572
	db %00000
	db -1
.Node571:
	db DEDGE_WARP, 1
	dw 569
	db %00000
	db DEDGE_WARP, 3
	dw 573
	db %00000
	db -1
.Node572:
	db DEDGE_WARP, 2
	dw 570
	db %00000
	db -1
.Node573:
	db DEDGE_WARP, 1
	dw 571
	db %00000
	db -1
.Node574:
	db DEDGE_WARP, 1
	dw 555
	db %00000
	db -1
.Node575:
	db DEDGE_WARP, 1
	dw 555
	db %00000
	db -1
.Node576:
	db DEDGE_WARP, 1
	dw 555
	db %00000
	db -1
.Node577:
	db DEDGE_WARP, 1
	dw 556
	db %00000
	db -1
.Node578:
	db DEDGE_WARP, 1
	dw 555
	db %00000
	db -1
.Node579:
	db DEDGE_WARP, 1
	dw 549
	db %00000
	db -1
.Node580:
	db DEDGE_WARP, 1
	dw 551
	db %00000
	db DEDGE_WARP, 3
	dw 550
	db %00000
	db -1
.Node581:
	db DEDGE_WARP, 1
	dw 547
	db %00000
	db DEDGE_WARP, 3
	dw 659
	db %00000
	db -1
.Node582:
	db DEDGE_WARP, 1
	dw 552
	db %00000
	db DEDGE_WARP, 3
	dw 497
	db %00000
	db -1
.Node583:
	db DEDGE_EDGE, 3
	dw 22
	db %00000
	db -1
.Node584:
	db DEDGE_EDGE, 3
	dw 20
	db %00000
	db DEDGE_WALK, 0
	dw 585
	db %00010
	db -1
.Node585:
	db DEDGE_EDGE, 0
	dw 586
	db %00000
	db DEDGE_EDGE, 3
	dw 23
	db %00000
	db DEDGE_WALK, 0
	dw 584
	db %00000
	db -1
.Node586:
	db DEDGE_EDGE, 1
	dw 585
	db %00000
	db DEDGE_EDGE, 2
	dw 596
	db %00000
	db DEDGE_WALK, 0
	dw 587
	db %00110
	db DEDGE_WALK, 0
	dw 589
	db %00110
	db DEDGE_WALK, 0
	dw 591
	db %00110
	db DEDGE_WALK, 0
	dw 592
	db %00110
	db -1
.Node587:
	db DEDGE_WARP, 2
	dw 170
	db %00000
	db DEDGE_WALK, 0
	dw 586
	db %00110
	db DEDGE_WALK, 0
	dw 589
	db %00110
	db DEDGE_WALK, 0
	dw 591
	db %00110
	db DEDGE_WALK, 0
	dw 592
	db %00110
	db -1
.Node588:
	db DEDGE_WARP, 1
	dw 166
	db %00000
	db -1
.Node589:
	db DEDGE_WARP, 1
	dw 166
	db %00000
	db DEDGE_WALK, 0
	dw 586
	db %00110
	db DEDGE_WALK, 0
	dw 587
	db %00110
	db DEDGE_WALK, 0
	dw 591
	db %00110
	db DEDGE_WALK, 0
	dw 592
	db %00110
	db -1
.Node590:
	db DEDGE_WARP, 2
	dw 170
	db %00000
	db -1
.Node591:
	db DEDGE_WARP, 3
	dw 171
	db %00000
	db DEDGE_WALK, 0
	dw 586
	db %00110
	db DEDGE_WALK, 0
	dw 587
	db %00110
	db DEDGE_WALK, 0
	dw 589
	db %00110
	db DEDGE_WALK, 0
	dw 592
	db %00110
	db -1
.Node592:
	db DEDGE_WARP, 4
	dw 176
	db %00000
	db DEDGE_WALK, 0
	dw 586
	db %00110
	db DEDGE_WALK, 0
	dw 587
	db %00110
	db DEDGE_WALK, 0
	dw 589
	db %00110
	db DEDGE_WALK, 0
	dw 591
	db %00110
	db -1
.Node593:
	db DEDGE_WARP, 3
	dw 171
	db %00000
	db -1
.Node594:
	db DEDGE_WARP, 4
	dw 176
	db %00000
	db -1
.Node595:
	db DEDGE_WARP, 1
	dw 597
	db %00000
	db DEDGE_WARP, 2
	dw 598
	db %00000
	db DEDGE_WARP, 3
	dw 599
	db %00000
	db DEDGE_WARP, 4
	dw 600
	db %00000
	db DEDGE_WARP, 5
	dw 601
	db %00000
	db DEDGE_WARP, 6
	dw 602
	db %00000
	db DEDGE_WARP, 7
	dw 603
	db %00000
	db DEDGE_WALK, 0
	dw 596
	db %00010
	db -1
.Node596:
	db DEDGE_EDGE, 3
	dw 586
	db %00000
	db DEDGE_WALK, 0
	dw 595
	db %00000
	db -1
.Node597:
	db DEDGE_WARP, 1
	dw 595
	db %00000
	db -1
.Node598:
	db DEDGE_WARP, 1
	dw 595
	db %00000
	db -1
.Node599:
	db DEDGE_WARP, 1
	dw 595
	db %00000
	db -1
.Node600:
	db DEDGE_WARP, 1
	dw 595
	db %00000
	db -1
.Node601:
	db DEDGE_WARP, 1
	dw 595
	db %00000
	db -1
.Node602:
	db DEDGE_WARP, 1
	dw 595
	db %00000
	db -1
.Node603:
	db DEDGE_WARP, 1
	dw 595
	db %00000
	db -1
.Node604:
	db DEDGE_EDGE, 1
	dw 441
	db %00000
	db DEDGE_EDGE, 0
	dw 612
	db %00000
	db DEDGE_WALK, 0
	dw 605
	db %00001
	db DEDGE_WALK, 0
	dw 607
	db %00001
	db DEDGE_WALK, 0
	dw 608
	db %00001
	db -1
.Node605:
	db DEDGE_WARP, 1
	dw 624
	db %00000
	db DEDGE_WARP, 5
	dw 212
	db %00000
	db DEDGE_WALK, 0
	dw 604
	db %00001
	db DEDGE_WALK, 0
	dw 607
	db %00001
	db DEDGE_WALK, 0
	dw 608
	db %00001
	db -1
.Node606:
	db DEDGE_WARP, 5
	dw 212
	db %00000
	db -1
.Node607:
	db DEDGE_WARP, 3
	dw 625
	db %00000
	db DEDGE_WALK, 0
	dw 604
	db %00001
	db DEDGE_WALK, 0
	dw 605
	db %00001
	db DEDGE_WALK, 0
	dw 608
	db %00001
	db -1
.Node608:
	db DEDGE_WARP, 2
	dw 625
	db %00000
	db DEDGE_WALK, 0
	dw 604
	db %00001
	db DEDGE_WALK, 0
	dw 605
	db %00001
	db DEDGE_WALK, 0
	dw 607
	db %00001
	db -1
.Node609:
	db DEDGE_EDGE, 3
	dw 611
	db %00000
	db DEDGE_EDGE, 3
	dw 613
	db %00000
	db -1
.Node610:
	db DEDGE_WARP, 1
	dw 626
	db %00000
	db DEDGE_EDGE, 3
	dw 612
	db %00000
	db -1
.Node611:
	db DEDGE_EDGE, 2
	dw 609
	db %00000
	db -1
.Node612:
	db DEDGE_WARP, 1
	dw 618
	db %00000
	db DEDGE_WARP, 2
	dw 619
	db %00000
	db DEDGE_WARP, 3
	dw 620
	db %00000
	db DEDGE_WARP, 4
	dw 622
	db %00000
	db DEDGE_WARP, 5
	dw 623
	db %00000
	db DEDGE_EDGE, 1
	dw 604
	db %00000
	db DEDGE_EDGE, 0
	dw 423
	db %00000
	db DEDGE_EDGE, 2
	dw 610
	db %00000
	db -1
.Node613:
	db DEDGE_EDGE, 2
	dw 609
	db %00000
	db -1
.Node614:
	db DEDGE_EDGE, 0
	dw 421
	db %00000
	db -1
.Node615:
	db DEDGE_EDGE, 0
	dw 422
	db %00000
	db -1
.Node616:
	db DEDGE_EDGE, 0
	dw 424
	db %00000
	db -1
.Node617:
	db DEDGE_EDGE, 0
	dw 425
	db %00000
	db -1
.Node618:
	db DEDGE_WARP, 1
	dw 612
	db %00000
	db -1
.Node619:
	db DEDGE_WARP, 1
	dw 612
	db %00000
	db -1
.Node620:
	db DEDGE_WARP, 1
	dw 612
	db %00000
	db DEDGE_WARP, 3
	dw 621
	db %00000
	db -1
.Node621:
	db DEDGE_WARP, 1
	dw 620
	db %00000
	db -1
.Node622:
	db DEDGE_WARP, 1
	dw 612
	db %00000
	db -1
.Node623:
	db DEDGE_WARP, 1
	dw 612
	db %00000
	db -1
.Node624:
	db DEDGE_WARP, 1
	dw 605
	db %00000
	db -1
.Node625:
	db DEDGE_WARP, 1
	dw 607
	db %00000
	db DEDGE_WARP, 3
	dw 608
	db %00000
	db -1
.Node626:
	db DEDGE_WARP, 1
	dw 610
	db %00000
	db DEDGE_WARP, 3
	dw 628
	db %00000
	db DEDGE_WARP, 5
	dw 232
	db %00000
	db DEDGE_WARP, 7
	dw 540
	db %00000
	db -1
.Node627:
	db DEDGE_EDGE, 2
	dw 638
	db %00000
	db DEDGE_WALK, 0
	dw 629
	db %00010
	db -1
.Node628:
	db DEDGE_WARP, 1
	dw 626
	db %00000
	db DEDGE_WARP, 2
	dw 652
	db %00000
	db DEDGE_WARP, 3
	dw 653
	db %00000
	db DEDGE_WALK, 0
	dw 627
	db %00000
	db DEDGE_WALK, 0
	dw 629
	db %00010
	db DEDGE_WALK, 0
	dw 630
	db %00010
	db -1
.Node629:
	db DEDGE_EDGE, 2
	dw 640
	db %00000
	db DEDGE_WALK, 0
	dw 627
	db %00000
	db -1
.Node630:
	db DEDGE_EDGE, 2
	dw 639
	db %00000
	db DEDGE_WALK, 0
	dw 627
	db %00000
	db DEDGE_WALK, 0
	dw 628
	db %00000
	db DEDGE_WALK, 0
	dw 629
	db %00010
	db -1
.Node631:
	db DEDGE_EDGE, 2
	dw 643
	db %00000
	db -1
.Node632:
	db DEDGE_EDGE, 2
	dw 641
	db %00000
	db DEDGE_WALK, 0
	dw 627
	db %00010
	db DEDGE_WALK, 0
	dw 629
	db %00010
	db -1
.Node633:
	db DEDGE_EDGE, 2
	dw 642
	db %00000
	db DEDGE_WALK, 0
	dw 627
	db %00010
	db DEDGE_WALK, 0
	dw 628
	db %00010
	db DEDGE_WALK, 0
	dw 629
	db %00010
	db DEDGE_WALK, 0
	dw 630
	db %00010
	db -1
.Node634:
	db DEDGE_WARP, 2
	dw 209
	db %00000
	db DEDGE_WARP, 3
	dw 210
	db %00000
	db -1
.Node635:
	db DEDGE_WARP, 2
	dw 209
	db %00000
	db DEDGE_WALK, 0
	dw 636
	db %00010
	db -1
.Node636:
	db DEDGE_EDGE, 2
	dw 646
	db %00000
	db DEDGE_WALK, 0
	dw 635
	db %00000
	db -1
.Node637:
	db DEDGE_WARP, 1
	dw 654
	db %00000
	db DEDGE_WARP, 3
	dw 210
	db %00000
	db DEDGE_WALK, 0
	dw 635
	db %00000
	db DEDGE_WALK, 0
	dw 636
	db %00010
	db DEDGE_WALK, 0
	dw 639
	db %00010
	db -1
.Node638:
	db DEDGE_EDGE, 3
	dw 627
	db %00000
	db DEDGE_WALK, 0
	dw 640
	db %00010
	db -1
.Node639:
	db DEDGE_EDGE, 3
	dw 630
	db %00000
	db DEDGE_WALK, 0
	dw 635
	db %00010
	db DEDGE_WALK, 0
	dw 636
	db %00010
	db DEDGE_WALK, 0
	dw 637
	db %00010
	db -1
.Node640:
	db DEDGE_EDGE, 3
	dw 629
	db %00000
	db -1
.Node641:
	db DEDGE_EDGE, 3
	dw 632
	db %00000
	db DEDGE_WALK, 0
	dw 640
	db %00010
	db -1
.Node642:
	db DEDGE_EDGE, 3
	dw 633
	db %00000
	db DEDGE_WALK, 0
	dw 635
	db %00010
	db DEDGE_WALK, 0
	dw 636
	db %00010
	db DEDGE_WALK, 0
	dw 637
	db %00010
	db DEDGE_WALK, 0
	dw 639
	db %00010
	db -1
.Node643:
	db DEDGE_EDGE, 3
	dw 631
	db %00000
	db -1
.Node644:
	db DEDGE_WARP, 1
	dw 655
	db %00000
	db DEDGE_EDGE, 2
	dw 684
	db %00000
	db DEDGE_EDGE, 3
	dw 645
	db %00000
	db -1
.Node645:
	db DEDGE_WARP, 1
	dw 647
	db %00000
	db DEDGE_WARP, 2
	dw 648
	db %00000
	db DEDGE_WARP, 3
	dw 650
	db %00000
	db DEDGE_WARP, 4
	dw 651
	db %00000
	db DEDGE_EDGE, 2
	dw 644
	db %00000
	db DEDGE_WALK, 0
	dw 646
	db %00010
	db -1
.Node646:
	db DEDGE_EDGE, 3
	dw 636
	db %00000
	db DEDGE_WALK, 0
	dw 645
	db %00000
	db -1
.Node647:
	db DEDGE_WARP, 1
	dw 645
	db %00000
	db -1
.Node648:
	db DEDGE_WARP, 1
	dw 645
	db %00000
	db DEDGE_WARP, 3
	dw 649
	db %00000
	db -1
.Node649:
	db DEDGE_WARP, 1
	dw 648
	db %00000
	db -1
.Node650:
	db DEDGE_WARP, 1
	dw 645
	db %00000
	db -1
.Node651:
	db DEDGE_WARP, 1
	dw 645
	db %00000
	db -1
.Node652:
	db DEDGE_WARP, 1
	dw 628
	db %00000
	db -1
.Node653:
	db DEDGE_WARP, 1
	dw 628
	db %00000
	db -1
.Node654:
	db DEDGE_WARP, 1
	dw 637
	db %00000
	db -1
.Node655:
	db DEDGE_WARP, 1
	dw 257
	db %00000
	db DEDGE_WARP, 3
	dw 644
	db %00000
	db -1
.Node656:
	db DEDGE_WARP, 1
	dw 678
	db %00000
	db DEDGE_WARP, 2
	dw 679
	db %00000
	db DEDGE_EDGE, 1
	dw 324
	db %00000
	db -1
.Node657:
	db DEDGE_WARP, 4
	dw 680
	db %00000
	db DEDGE_WALK, 0
	dw 656
	db %00000
	db -1
.Node658:
	db DEDGE_EDGE, 1
	dw 324
	db %00000
	db DEDGE_WALK, 0
	dw 656
	db %00000
	db DEDGE_WALK, 0
	dw 657
	db %00000
	db -1
.Node659:
	db DEDGE_WARP, 1
	dw 661
	db %00000
	db DEDGE_WARP, 2
	dw 669
	db %00000
	db DEDGE_WARP, 3
	dw 671
	db %00000
	db DEDGE_WARP, 4
	dw 672
	db %00000
	db DEDGE_WARP, 5
	dw 673
	db %00000
	db DEDGE_WARP, 6
	dw 674
	db %00000
	db DEDGE_WARP, 7
	dw 675
	db %00000
	db DEDGE_WARP, 8
	dw 676
	db %00000
	db DEDGE_WARP, 9
	dw 679
	db %00000
	db DEDGE_WARP, 10
	dw 581
	db %00000
	db DEDGE_WARP, 12
	dw 419
	db %00000
	db DEDGE_WARP, 14
	dw 537
	db %00000
	db -1
.Node660:
	db DEDGE_EDGE, 2
	dw 548
	db %00000
	db -1
.Node661:
	db DEDGE_WARP, 1
	dw 659
	db %00000
	db -1
.Node662:
	db DEDGE_WARP, 7
	dw 663
	db %00000
	db DEDGE_WARP, 17
	dw 666
	db %00000
	db DEDGE_WARP, 21
	dw 665
	db %00000
	db DEDGE_WARP, 31
	dw 664
	db %00000
	db -1
.Node663:
	db DEDGE_WARP, 8
	dw 668
	db %00000
	db DEDGE_WARP, 14
	dw 667
	db %00000
	db DEDGE_WARP, 22
	dw 662
	db %00000
	db DEDGE_WARP, 28
	dw 665
	db %00000
	db -1
.Node664:
	db DEDGE_WARP, 10
	dw 670
	db %00000
	db DEDGE_WARP, 16
	dw 662
	db %00000
	db DEDGE_WARP, 24
	dw 668
	db %00000
	db DEDGE_WARP, 30
	dw 667
	db %00000
	db -1
.Node665:
	db DEDGE_WARP, 6
	dw 662
	db %00000
	db DEDGE_WARP, 13
	dw 663
	db %00000
	db DEDGE_WARP, 20
	dw 667
	db %00000
	db DEDGE_WARP, 27
	dw 668
	db %00000
	db -1
.Node666:
	db DEDGE_WARP, 32
	dw 662
	db %00000
	db -1
.Node667:
	db DEDGE_WARP, 5
	dw 665
	db %00000
	db DEDGE_WARP, 15
	dw 664
	db %00000
	db DEDGE_WARP, 19
	dw 670
	db %00000
	db DEDGE_WARP, 29
	dw 663
	db %00000
	db -1
.Node668:
	db DEDGE_WARP, 9
	dw 664
	db %00000
	db DEDGE_WARP, 12
	dw 665
	db %00000
	db DEDGE_WARP, 23
	dw 663
	db %00000
	db DEDGE_WARP, 26
	dw 670
	db %00000
	db -1
.Node669:
	db DEDGE_WARP, 1
	dw 659
	db %00000
	db DEDGE_WARP, 3
	dw 670
	db %00000
	db -1
.Node670:
	db DEDGE_WARP, 4
	dw 667
	db %00000
	db DEDGE_WARP, 11
	dw 668
	db %00000
	db DEDGE_WARP, 18
	dw 669
	db %00000
	db DEDGE_WARP, 25
	dw 664
	db %00000
	db -1
.Node671:
	db DEDGE_WARP, 1
	dw 659
	db %00000
	db -1
.Node672:
	db DEDGE_WARP, 1
	dw 659
	db %00000
	db -1
.Node673:
	db DEDGE_WARP, 1
	dw 659
	db %00000
	db -1
.Node674:
	db DEDGE_WARP, 1
	dw 659
	db %00000
	db DEDGE_WARP, 3
	dw 386
	db %00000
	db -1
.Node675:
	db DEDGE_WARP, 1
	dw 659
	db %00000
	db -1
.Node676:
	db DEDGE_WARP, 1
	dw 659
	db %00000
	db DEDGE_WARP, 3
	dw 677
	db %00000
	db -1
.Node677:
	db DEDGE_WARP, 1
	dw 676
	db %00000
	db -1
.Node678:
	db DEDGE_WARP, 1
	dw 656
	db %00000
	db DEDGE_WARP, 3
	dw 218
	db %00000
	db -1
.Node679:
	db DEDGE_WARP, 1
	dw 656
	db %00000
	db DEDGE_WARP, 3
	dw 659
	db %00000
	db -1
.Node680:
	db DEDGE_WARP, 1
	dw 657
	db %00000
	db -1
.Node681:
	db DEDGE_WARP, 1
	dw 690
	db %00000
	db DEDGE_WARP, 2
	dw 691
	db %00000
	db DEDGE_EDGE, 1
	dw 683
	db %00000
	db DEDGE_EDGE, 0
	dw 684
	db %00000
	db -1
.Node682:
	db DEDGE_WARP, 3
	dw 199
	db %00000
	db -1
.Node683:
	db DEDGE_WARP, 1
	dw 692
	db %00000
	db DEDGE_WARP, 3
	dw 199
	db %00000
	db DEDGE_EDGE, 0
	dw 681
	db %00000
	db -1
.Node684:
	db DEDGE_WARP, 1
	dw 685
	db %00000
	db DEDGE_WARP, 2
	dw 686
	db %00000
	db DEDGE_WARP, 3
	dw 687
	db %00000
	db DEDGE_WARP, 4
	dw 688
	db %00000
	db DEDGE_WARP, 5
	dw 689
	db %00000
	db DEDGE_EDGE, 1
	dw 681
	db %00000
	db DEDGE_EDGE, 3
	dw 644
	db %00000
	db -1
.Node685:
	db DEDGE_WARP, 1
	dw 684
	db %00000
	db -1
.Node686:
	db DEDGE_WARP, 1
	dw 684
	db %00000
	db -1
.Node687:
	db DEDGE_WARP, 1
	dw 684
	db %00000
	db -1
.Node688:
	db DEDGE_WARP, 1
	dw 684
	db %00000
	db -1
.Node689:
	db DEDGE_WARP, 1
	dw 684
	db %00000
	db -1
.Node690:
	db DEDGE_WARP, 1
	dw 681
	db %00000
	db -1
.Node691:
	db DEDGE_WARP, 1
	dw 681
	db %00000
	db -1
.Node692:
	db DEDGE_WARP, 1
	dw 357
	db %00000
	db DEDGE_WARP, 3
	dw 683
	db %00000
	db -1

DemoWorldCenters:
; the POKéMON CENTERs: map key, its nurse and its MOVE REMINDER (objects, from 1;
; the MOVE TUTOR is the one after); -1 ends
	dw 0
	db 1, 6
	dw 16
	db 1, 6
	dw 114
	db 1, 7
	dw 126
	db 1, 6
	dw 131
	db 1, 5
	dw 142
	db 1, 5
	dw 146
	db 1, 6
	dw 156
	db 1, 6
	dw 178
	db 1, 7
	dw 181
	db 1, 5
	dw 205
	db 1, 7
	dw 214
	db 1, 6
	dw 234
	db 1, 7
	dw 250
	db 1, 8
	dw 266
	db 1, 6
	dw 274
	db 1, 6
	dw 286
	db 1, 4
	dw 310
	db 1, 7
	dw 325
	db 1, 6
	dw 344
	db 1, 6
	dw 367
	db 1, 6
	dw 381
	db 1, 6
	dw -1
