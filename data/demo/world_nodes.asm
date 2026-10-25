; The Demo's nodes: the regions of each map with a way out, and the ways from
; them (see engine/demo/demo_nodes.asm). Made by tools/demo_world.py.

DemoWorldNodes:
; for each node: its map key, its cell (the Demo checks it can get there), its
; edges (DemoNodeEdges)
	table_width 6
	dw 0
	db 3, 7
	dw .Node0 ; OLIVINE_POKECENTER_1F
	dw 1
	db 4, 15
	dw .Node1 ; OLIVINE_GYM
	dw 2
	db 2, 7
	dw .Node2 ; OLIVINE_TIMS_HOUSE
	dw 3
	db 2, 7
	dw .Node3 ; OLIVINE_HOUSE_BETA
	dw 4
	db 2, 7
	dw .Node4 ; OLIVINE_PUNISHMENT_SPEECH_HOUSE
	dw 5
	db 2, 7
	dw .Node5 ; OLIVINE_GOOD_ROD_HOUSE
	dw 6
	db 2, 7
	dw .Node6 ; OLIVINE_CAFE
	dw 7
	db 2, 7
	dw .Node7 ; OLIVINE_MART
	dw 8
	db 0, 4
	dw .Node8 ; ROUTE_38_ECRUTEAK_GATE
	dw 9
	db 3, 7
	dw .Node9 ; ROUTE_39_BARN
	dw 10
	db 2, 7
	dw .Node10 ; ROUTE_39_FARMHOUSE
	dw 11
	db 0, 6
	dw .Node11 ; ROUTE_38
	dw 11
	db 35, 8
	dw .Node12 ; ROUTE_38
	dw 11
	db 0, 13
	dw .Node13 ; ROUTE_38
	dw 12
	db 1, 3
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
	db 13, 21
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
	db 2, 7
	dw .Node24 ; MAHOGANY_RED_GYARADOS_SPEECH_HOUSE
	dw 15
	db 4, 17
	dw .Node25 ; MAHOGANY_GYM
	dw 16
	db 3, 7
	dw .Node26 ; MAHOGANY_POKECENTER_1F
	dw 17
	db 0, 4
	dw .Node27 ; ROUTE_42_ECRUTEAK_GATE
	dw 18
	db 0, 8
	dw .Node28 ; ROUTE_42
	dw 18
	db 59, 8
	dw .Node29 ; ROUTE_42
	dw 19
	db 56, 7
	dw .Node30 ; ROUTE_44
	dw 20
	db 0, 0
	dw .Node31 ; MAHOGANY_TOWN
	dw 20
	db 11, 7
	dw .Node32 ; MAHOGANY_TOWN
	dw 20
	db 17, 0
	dw .Node33 ; MAHOGANY_TOWN
	dw 20
	db 0, 8
	dw .Node34 ; MAHOGANY_TOWN
	dw 21
	db 2, 6
	dw .Node35 ; SPROUT_TOWER_1F
	dw 21
	db 9, 15
	dw .Node36 ; SPROUT_TOWER_1F
	dw 22
	db 2, 6
	dw .Node37 ; SPROUT_TOWER_2F
	dw 22
	db 6, 4
	dw .Node38 ; SPROUT_TOWER_2F
	dw 23
	db 10, 14
	dw .Node39 ; SPROUT_TOWER_3F
	dw 24
	db 9, 15
	dw .Node40 ; TIN_TOWER_1F
	dw 25
	db 10, 14
	dw .Node41 ; TIN_TOWER_2F
	dw 26
	db 10, 14
	dw .Node42 ; TIN_TOWER_3F
	dw 27
	db 2, 4
	dw .Node43 ; TIN_TOWER_4F
	dw 28
	db 2, 14
	dw .Node44 ; TIN_TOWER_5F
	dw 28
	db 11, 15
	dw .Node45 ; TIN_TOWER_5F
	dw 28
	db 17, 15
	dw .Node46 ; TIN_TOWER_5F
	dw 28
	db 2, 4
	dw .Node47 ; TIN_TOWER_5F
	dw 29
	db 3, 9
	dw .Node48 ; TIN_TOWER_6F
	dw 30
	db 3, 9
	dw .Node49 ; TIN_TOWER_7F
	dw 30
	db 12, 7
	dw .Node50 ; TIN_TOWER_7F
	dw 31
	db 16, 7
	dw .Node51 ; TIN_TOWER_8F
	dw 31
	db 2, 5
	dw .Node52 ; TIN_TOWER_8F
	dw 31
	db 6, 9
	dw .Node53 ; TIN_TOWER_8F
	dw 31
	db 14, 15
	dw .Node54 ; TIN_TOWER_8F
	dw 32
	db 12, 3
	dw .Node55 ; TIN_TOWER_9F
	dw 32
	db 12, 7
	dw .Node56 ; TIN_TOWER_9F
	dw 32
	db 16, 7
	dw .Node57 ; TIN_TOWER_9F
	dw 33
	db 9, 15
	dw .Node58 ; BURNED_TOWER_1F
	dw 33
	db 15, 4
	dw .Node59 ; BURNED_TOWER_1F
	dw 34
	db 17, 14
	dw .Node60 ; BURNED_TOWER_B1F
	dw 34
	db 10, 9
	dw .Node61 ; BURNED_TOWER_B1F
	dw 34
	db 17, 7
	dw .Node62 ; BURNED_TOWER_B1F
	dw 35
	db 33, 18
	dw .Node63 ; NATIONAL_PARK
	dw 37
	db 2, 7
	dw .Node64 ; RADIO_TOWER_1F
	dw 38
	db 0, 0
	dw .Node65 ; RADIO_TOWER_2F
	dw 39
	db 0, 0
	dw .Node66 ; RADIO_TOWER_3F
	dw 39
	db 17, 0
	dw .Node67 ; RADIO_TOWER_3F
	dw 40
	db 0, 0
	dw .Node68 ; RADIO_TOWER_4F
	dw 40
	db 12, 0
	dw .Node69 ; RADIO_TOWER_4F
	dw 41
	db 0, 0
	dw .Node70 ; RADIO_TOWER_5F
	dw 41
	db 12, 0
	dw .Node71 ; RADIO_TOWER_5F
	dw 42
	db 2, 17
	dw .Node72 ; RUINS_OF_ALPH_OUTSIDE
	dw 42
	db 16, 33
	dw .Node73 ; RUINS_OF_ALPH_OUTSIDE
	dw 42
	db 2, 29
	dw .Node74 ; RUINS_OF_ALPH_OUTSIDE
	dw 43
	db 3, 9
	dw .Node75 ; RUINS_OF_ALPH_HO_OH_CHAMBER
	dw 44
	db 3, 9
	dw .Node76 ; RUINS_OF_ALPH_KABUTO_CHAMBER
	dw 45
	db 3, 9
	dw .Node77 ; RUINS_OF_ALPH_OMANYTE_CHAMBER
	dw 46
	db 3, 9
	dw .Node78 ; RUINS_OF_ALPH_AERODACTYL_CHAMBER
	dw 47
	db 10, 13
	dw .Node79 ; RUINS_OF_ALPH_INNER_CHAMBER
	dw 48
	db 2, 7
	dw .Node80 ; RUINS_OF_ALPH_RESEARCH_CENTER
	dw 49
	db 3, 9
	dw .Node81 ; RUINS_OF_ALPH_HO_OH_ITEM_ROOM
	dw 50
	db 3, 9
	dw .Node82 ; RUINS_OF_ALPH_KABUTO_ITEM_ROOM
	dw 51
	db 3, 9
	dw .Node83 ; RUINS_OF_ALPH_OMANYTE_ITEM_ROOM
	dw 52
	db 3, 9
	dw .Node84 ; RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM
	dw 53
	db 9, 9
	dw .Node85 ; RUINS_OF_ALPH_HO_OH_WORD_ROOM
	dw 54
	db 9, 5
	dw .Node86 ; RUINS_OF_ALPH_KABUTO_WORD_ROOM
	dw 55
	db 9, 7
	dw .Node87 ; RUINS_OF_ALPH_OMANYTE_WORD_ROOM
	dw 56
	db 9, 5
	dw .Node88 ; RUINS_OF_ALPH_AERODACTYL_WORD_ROOM
	dw 57
	db 5, 19
	dw .Node89 ; UNION_CAVE_1F
	dw 57
	db 3, 33
	dw .Node90 ; UNION_CAVE_1F
	dw 58
	db 3, 3
	dw .Node91 ; UNION_CAVE_B1F
	dw 58
	db 3, 11
	dw .Node92 ; UNION_CAVE_B1F
	dw 58
	db 7, 19
	dw .Node93 ; UNION_CAVE_B1F
	dw 58
	db 3, 33
	dw .Node94 ; UNION_CAVE_B1F
	dw 58
	db 17, 31
	dw .Node95 ; UNION_CAVE_B1F
	dw 59
	db 5, 3
	dw .Node96 ; UNION_CAVE_B2F
	dw 60
	db 17, 15
	dw .Node97 ; SLOWPOKE_WELL_B1F
	dw 60
	db 7, 11
	dw .Node98 ; SLOWPOKE_WELL_B1F
	dw 61
	db 9, 11
	dw .Node99 ; SLOWPOKE_WELL_B2F
	dw 62
	db 10, 17
	dw .Node100 ; OLIVINE_LIGHTHOUSE_1F
	dw 63
	db 3, 11
	dw .Node101 ; OLIVINE_LIGHTHOUSE_2F
	dw 64
	db 13, 3
	dw .Node102 ; OLIVINE_LIGHTHOUSE_3F
	dw 64
	db 9, 5
	dw .Node103 ; OLIVINE_LIGHTHOUSE_3F
	dw 65
	db 13, 3
	dw .Node104 ; OLIVINE_LIGHTHOUSE_4F
	dw 65
	db 9, 7
	dw .Node105 ; OLIVINE_LIGHTHOUSE_4F
	dw 66
	db 3, 5
	dw .Node106 ; OLIVINE_LIGHTHOUSE_5F
	dw 66
	db 9, 15
	dw .Node107 ; OLIVINE_LIGHTHOUSE_5F
	dw 67
	db 9, 15
	dw .Node108 ; OLIVINE_LIGHTHOUSE_6F
	dw 68
	db 3, 7
	dw .Node109 ; MAHOGANY_MART_1F
	dw 69
	db 27, 2
	dw .Node110 ; TEAM_ROCKET_BASE_B1F
	dw 70
	db 3, 2
	dw .Node111 ; TEAM_ROCKET_BASE_B2F
	dw 70
	db 3, 6
	dw .Node112 ; TEAM_ROCKET_BASE_B2F
	dw 70
	db 3, 14
	dw .Node113 ; TEAM_ROCKET_BASE_B2F
	dw 71
	db 3, 2
	dw .Node114 ; TEAM_ROCKET_BASE_B3F
	dw 71
	db 27, 2
	dw .Node115 ; TEAM_ROCKET_BASE_B3F
	dw 72
	db 1, 5
	dw .Node116 ; ILEX_FOREST
	dw 72
	db 3, 42
	dw .Node117 ; ILEX_FOREST
	dw 73
	db 3, 2
	dw .Node118 ; GOLDENROD_UNDERGROUND
	dw 73
	db 21, 31
	dw .Node119 ; GOLDENROD_UNDERGROUND
	dw 74
	db 23, 3
	dw .Node120 ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES
	dw 74
	db 22, 10
	dw .Node121 ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES
	dw 74
	db 5, 25
	dw .Node122 ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES
	dw 74
	db 21, 25
	dw .Node123 ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES
	dw 75
	db 17, 2
	dw .Node124 ; GOLDENROD_DEPT_STORE_B1F
	dw 75
	db 9, 4
	dw .Node125 ; GOLDENROD_DEPT_STORE_B1F
	dw 76
	db 2, 12
	dw .Node126 ; GOLDENROD_UNDERGROUND_WAREHOUSE
	dw 77
	db 17, 5
	dw .Node127 ; MOUNT_MORTAR_1F_OUTSIDE
	dw 77
	db 17, 33
	dw .Node128 ; MOUNT_MORTAR_1F_OUTSIDE
	dw 77
	db 33, 13
	dw .Node129 ; MOUNT_MORTAR_1F_OUTSIDE
	dw 77
	db 7, 13
	dw .Node130 ; MOUNT_MORTAR_1F_OUTSIDE
	dw 77
	db 3, 33
	dw .Node131 ; MOUNT_MORTAR_1F_OUTSIDE
	dw 77
	db 37, 33
	dw .Node132 ; MOUNT_MORTAR_1F_OUTSIDE
	dw 78
	db 11, 47
	dw .Node133 ; MOUNT_MORTAR_1F_INSIDE
	dw 78
	db 3, 19
	dw .Node134 ; MOUNT_MORTAR_1F_INSIDE
	dw 79
	db 3, 5
	dw .Node135 ; MOUNT_MORTAR_2F_INSIDE
	dw 79
	db 17, 33
	dw .Node136 ; MOUNT_MORTAR_2F_INSIDE
	dw 80
	db 3, 3
	dw .Node137 ; MOUNT_MORTAR_B1F
	dw 80
	db 19, 29
	dw .Node138 ; MOUNT_MORTAR_B1F
	dw 81
	db 4, 19
	dw .Node139 ; ICE_PATH_1F
	dw 81
	db 37, 5
	dw .Node140 ; ICE_PATH_1F
	dw 81
	db 36, 27
	dw .Node141 ; ICE_PATH_1F
	dw 82
	db 3, 15
	dw .Node142 ; ICE_PATH_B1F
	dw 82
	db 5, 25
	dw .Node143 ; ICE_PATH_B1F
	dw 83
	db 17, 1
	dw .Node144 ; ICE_PATH_B2F_MAHOGANY_SIDE
	dw 83
	db 4, 6
	dw .Node145 ; ICE_PATH_B2F_MAHOGANY_SIDE
	dw 84
	db 3, 15
	dw .Node146 ; ICE_PATH_B2F_BLACKTHORN_SIDE
	dw 85
	db 3, 5
	dw .Node147 ; ICE_PATH_B3F
	dw 86
	db 5, 7
	dw .Node148 ; WHIRL_ISLAND_NW
	dw 86
	db 3, 15
	dw .Node149 ; WHIRL_ISLAND_NW
	dw 87
	db 17, 3
	dw .Node150 ; WHIRL_ISLAND_NE
	dw 87
	db 13, 11
	dw .Node151 ; WHIRL_ISLAND_NE
	dw 87
	db 3, 13
	dw .Node152 ; WHIRL_ISLAND_NE
	dw 88
	db 5, 7
	dw .Node153 ; WHIRL_ISLAND_SW
	dw 88
	db 17, 3
	dw .Node154 ; WHIRL_ISLAND_SW
	dw 88
	db 3, 15
	dw .Node155 ; WHIRL_ISLAND_SW
	dw 88
	db 17, 15
	dw .Node156 ; WHIRL_ISLAND_SW
	dw 89
	db 7, 5
	dw .Node157 ; WHIRL_ISLAND_CAVE
	dw 90
	db 5, 13
	dw .Node158 ; WHIRL_ISLAND_SE
	dw 91
	db 9, 31
	dw .Node159 ; WHIRL_ISLAND_B1F
	dw 91
	db 5, 5
	dw .Node160 ; WHIRL_ISLAND_B1F
	dw 91
	db 35, 3
	dw .Node161 ; WHIRL_ISLAND_B1F
	dw 91
	db 17, 21
	dw .Node162 ; WHIRL_ISLAND_B1F
	dw 91
	db 23, 31
	dw .Node163 ; WHIRL_ISLAND_B1F
	dw 92
	db 11, 5
	dw .Node164 ; WHIRL_ISLAND_B2F
	dw 92
	db 13, 31
	dw .Node165 ; WHIRL_ISLAND_B2F
	dw 92
	db 7, 25
	dw .Node166 ; WHIRL_ISLAND_B2F
	dw 92
	db 7, 11
	dw .Node167 ; WHIRL_ISLAND_B2F
	dw 93
	db 9, 13
	dw .Node168 ; WHIRL_ISLAND_LUGIA_CHAMBER
	dw 94
	db 9, 33
	dw .Node169 ; SILVER_CAVE_ROOM_1
	dw 95
	db 23, 3
	dw .Node170 ; SILVER_CAVE_ROOM_2
	dw 95
	db 17, 31
	dw .Node171 ; SILVER_CAVE_ROOM_2
	dw 95
	db 13, 21
	dw .Node172 ; SILVER_CAVE_ROOM_2
	dw 96
	db 9, 33
	dw .Node173 ; SILVER_CAVE_ROOM_3
	dw 97
	db 13, 3
	dw .Node174 ; SILVER_CAVE_ITEM_ROOMS
	dw 97
	db 7, 15
	dw .Node175 ; SILVER_CAVE_ITEM_ROOMS
	dw 98
	db 17, 1
	dw .Node176 ; DARK_CAVE_VIOLET_ENTRANCE
	dw 98
	db 3, 15
	dw .Node177 ; DARK_CAVE_VIOLET_ENTRANCE
	dw 98
	db 35, 33
	dw .Node178 ; DARK_CAVE_VIOLET_ENTRANCE
	dw 99
	db 3, 25
	dw .Node179 ; DARK_CAVE_BLACKTHORN_ENTRANCE
	dw 99
	db 23, 3
	dw .Node180 ; DARK_CAVE_BLACKTHORN_ENTRANCE
	dw 100
	db 3, 5
	dw .Node181 ; DRAGONS_DEN_1F
	dw 100
	db 5, 15
	dw .Node182 ; DRAGONS_DEN_1F
	dw 101
	db 20, 3
	dw .Node183 ; DRAGONS_DEN_B1F
	dw 101
	db 19, 29
	dw .Node184 ; DRAGONS_DEN_B1F
	dw 102
	db 4, 9
	dw .Node185 ; DRAGON_SHRINE
	dw 103
	db 13, 15
	dw .Node186 ; TOHJO_FALLS
	dw 103
	db 25, 15
	dw .Node187 ; TOHJO_FALLS
	dw 104
	db 17, 33
	dw .Node188 ; DIGLETTS_CAVE
	dw 104
	db 15, 5
	dw .Node189 ; DIGLETTS_CAVE
	dw 104
	db 3, 33
	dw .Node190 ; DIGLETTS_CAVE
	dw 105
	db 3, 3
	dw .Node191 ; MOUNT_MOON
	dw 105
	db 25, 5
	dw .Node192 ; MOUNT_MOON
	dw 105
	db 15, 11
	dw .Node193 ; MOUNT_MOON
	dw 105
	db 25, 15
	dw .Node194 ; MOUNT_MOON
	dw 106
	db 3, 2
	dw .Node195 ; UNDERGROUND_PATH
	dw 107
	db 5, 3
	dw .Node196 ; ROCK_TUNNEL_1F
	dw 107
	db 15, 3
	dw .Node197 ; ROCK_TUNNEL_1F
	dw 107
	db 11, 25
	dw .Node198 ; ROCK_TUNNEL_1F
	dw 108
	db 3, 3
	dw .Node199 ; ROCK_TUNNEL_B1F
	dw 108
	db 23, 3
	dw .Node200 ; ROCK_TUNNEL_B1F
	dw 109
	db 4, 0
	dw .Node201 ; SAFARI_ZONE_FUCHSIA_GATE_BETA
	dw 110
	db 9, 23
	dw .Node202 ; SAFARI_ZONE_BETA
	dw 111
	db 17, 19
	dw .Node203 ; VICTORY_ROAD
	dw 111
	db 13, 17
	dw .Node204 ; VICTORY_ROAD
	dw 111
	db 1, 35
	dw .Node205 ; VICTORY_ROAD
	dw 111
	db 0, 27
	dw .Node206 ; VICTORY_ROAD
	dw 111
	db 17, 33
	dw .Node207 ; VICTORY_ROAD
	dw 111
	db 9, 67
	dw .Node208 ; VICTORY_ROAD
	dw 112
	db 4, 17
	dw .Node209 ; ECRUTEAK_TIN_TOWER_ENTRANCE
	dw 112
	db 17, 15
	dw .Node210 ; ECRUTEAK_TIN_TOWER_ENTRANCE
	dw 113
	db 7, 4
	dw .Node211 ; WISE_TRIOS_ROOM
	dw 114
	db 3, 7
	dw .Node212 ; ECRUTEAK_POKECENTER_1F
	dw 115
	db 3, 7
	dw .Node213 ; ECRUTEAK_LUGIA_SPEECH_HOUSE
	dw 116
	db 5, 13
	dw .Node214 ; DANCE_THEATER
	dw 117
	db 2, 7
	dw .Node215 ; ECRUTEAK_MART
	dw 118
	db 4, 17
	dw .Node216 ; ECRUTEAK_GYM
	dw 119
	db 3, 7
	dw .Node217 ; ECRUTEAK_ITEMFINDER_HOUSE
	dw 120
	db 20, 2
	dw .Node218 ; ECRUTEAK_CITY
	dw 120
	db 35, 26
	dw .Node219 ; ECRUTEAK_CITY
	dw 121
	db 4, 17
	dw .Node220 ; BLACKTHORN_GYM_1F
	dw 121
	db 7, 9
	dw .Node221 ; BLACKTHORN_GYM_1F
	dw 122
	db 1, 7
	dw .Node222 ; BLACKTHORN_GYM_2F
	dw 123
	db 2, 7
	dw .Node223 ; BLACKTHORN_DRAGON_SPEECH_HOUSE
	dw 124
	db 2, 7
	dw .Node224 ; BLACKTHORN_EMYS_HOUSE
	dw 125
	db 2, 7
	dw .Node225 ; BLACKTHORN_MART
	dw 126
	db 3, 7
	dw .Node226 ; BLACKTHORN_POKECENTER_1F
	dw 127
	db 2, 7
	dw .Node227 ; MOVE_DELETERS_HOUSE
	dw 128
	db 0, 76
	dw .Node228 ; ROUTE_45
	dw 128
	db 2, 5
	dw .Node229 ; ROUTE_45
	dw 128
	db 15, 0
	dw .Node230 ; ROUTE_45
	dw 129
	db 7, 33
	dw .Node231 ; ROUTE_46
	dw 129
	db 14, 5
	dw .Node232 ; ROUTE_46
	dw 129
	db 19, 10
	dw .Node233 ; ROUTE_46
	dw 130
	db 18, 11
	dw .Node234 ; BLACKTHORN_CITY
	dw 131
	db 3, 7
	dw .Node235 ; CINNABAR_POKECENTER_1F
	dw 133
	db 4, 0
	dw .Node236 ; ROUTE_19_FUCHSIA_GATE
	dw 134
	db 5, 5
	dw .Node237 ; SEAFOAM_GYM
	dw 135
	db 1, 0
	dw .Node238 ; ROUTE_19
	dw 135
	db 10, 0
	dw .Node239 ; ROUTE_19
	dw 135
	db 15, 0
	dw .Node240 ; ROUTE_19
	dw 135
	db 7, 3
	dw .Node241 ; ROUTE_19
	dw 135
	db 0, 20
	dw .Node242 ; ROUTE_19
	dw 136
	db 38, 7
	dw .Node243 ; ROUTE_20
	dw 136
	db 0, 16
	dw .Node244 ; ROUTE_20
	dw 137
	db 4, 0
	dw .Node245 ; ROUTE_21
	dw 137
	db 16, 35
	dw .Node246 ; ROUTE_21
	dw 138
	db 11, 11
	dw .Node247 ; CINNABAR_ISLAND
	dw 138
	db 1, 0
	dw .Node248 ; CINNABAR_ISLAND
	dw 138
	db 11, 0
	dw .Node249 ; CINNABAR_ISLAND
	dw 139
	db 2, 7
	dw .Node250 ; CERULEAN_GYM_BADGE_SPEECH_HOUSE
	dw 140
	db 2, 7
	dw .Node251 ; CERULEAN_POLICE_STATION
	dw 141
	db 2, 7
	dw .Node252 ; CERULEAN_TRADE_SPEECH_HOUSE
	dw 142
	db 3, 7
	dw .Node253 ; CERULEAN_POKECENTER_1F
	dw 144
	db 4, 15
	dw .Node254 ; CERULEAN_GYM
	dw 145
	db 2, 7
	dw .Node255 ; CERULEAN_MART
	dw 146
	db 3, 7
	dw .Node256 ; ROUTE_10_POKECENTER_1F
	dw 148
	db 2, 17
	dw .Node257 ; POWER_PLANT
	dw 149
	db 2, 7
	dw .Node258 ; BILLS_HOUSE
	dw 150
	db 39, 10
	dw .Node259 ; ROUTE_4
	dw 150
	db 2, 5
	dw .Node260 ; ROUTE_4
	dw 150
	db 39, 4
	dw .Node261 ; ROUTE_4
	dw 150
	db 39, 13
	dw .Node262 ; ROUTE_4
	dw 151
	db 0, 0
	dw .Node263 ; ROUTE_9
	dw 151
	db 59, 17
	dw .Node264 ; ROUTE_9
	dw 151
	db 54, 17
	dw .Node265 ; ROUTE_9
	dw 151
	db 56, 17
	dw .Node266 ; ROUTE_9
	dw 151
	db 0, 4
	dw .Node267 ; ROUTE_9
	dw 151
	db 0, 6
	dw .Node268 ; ROUTE_9
	dw 151
	db 48, 15
	dw .Node269 ; ROUTE_9
	dw 152
	db 0, 0
	dw .Node270 ; ROUTE_10_NORTH
	dw 152
	db 11, 1
	dw .Node271 ; ROUTE_10_NORTH
	dw 152
	db 3, 9
	dw .Node272 ; ROUTE_10_NORTH
	dw 152
	db 16, 0
	dw .Node273 ; ROUTE_10_NORTH
	dw 153
	db 0, 0
	dw .Node274 ; ROUTE_24
	dw 153
	db 2, 0
	dw .Node275 ; ROUTE_24
	dw 153
	db 4, 0
	dw .Node276 ; ROUTE_24
	dw 153
	db 8, 0
	dw .Node277 ; ROUTE_24
	dw 153
	db 11, 0
	dw .Node278 ; ROUTE_24
	dw 153
	db 15, 0
	dw .Node279 ; ROUTE_24
	dw 153
	db 15, 17
	dw .Node280 ; ROUTE_24
	dw 154
	db 0, 17
	dw .Node281 ; ROUTE_25
	dw 154
	db 47, 5
	dw .Node282 ; ROUTE_25
	dw 154
	db 15, 17
	dw .Node283 ; ROUTE_25
	dw 154
	db 4, 17
	dw .Node284 ; ROUTE_25
	dw 155
	db 12, 0
	dw .Node285 ; CERULEAN_CITY
	dw 155
	db 16, 0
	dw .Node286 ; CERULEAN_CITY
	dw 155
	db 7, 15
	dw .Node287 ; CERULEAN_CITY
	dw 155
	db 23, 0
	dw .Node288 ; CERULEAN_CITY
	dw 155
	db 39, 18
	dw .Node289 ; CERULEAN_CITY
	dw 155
	db 27, 0
	dw .Node290 ; CERULEAN_CITY
	dw 155
	db 0, 23
	dw .Node291 ; CERULEAN_CITY
	dw 155
	db 39, 24
	dw .Node292 ; CERULEAN_CITY
	dw 156
	db 3, 7
	dw .Node293 ; AZALEA_POKECENTER_1F
	dw 157
	db 2, 7
	dw .Node294 ; CHARCOAL_KILN
	dw 158
	db 2, 7
	dw .Node295 ; AZALEA_MART
	dw 159
	db 3, 7
	dw .Node296 ; KURTS_HOUSE
	dw 160
	db 4, 15
	dw .Node297 ; AZALEA_GYM
	dw 161
	db 11, 9
	dw .Node298 ; ROUTE_33
	dw 162
	db 15, 9
	dw .Node299 ; AZALEA_TOWN
	dw 162
	db 39, 0
	dw .Node300 ; AZALEA_TOWN
	dw 163
	db 2, 7
	dw .Node301 ; LAKE_OF_RAGE_HIDDEN_POWER_HOUSE
	dw 164
	db 2, 7
	dw .Node302 ; LAKE_OF_RAGE_MAGIKARP_HOUSE
	dw 165
	db 4, 0
	dw .Node303 ; ROUTE_43_MAHOGANY_GATE
	dw 166
	db 4, 0
	dw .Node304 ; ROUTE_43_GATE
	dw 167
	db 9, 51
	dw .Node305 ; ROUTE_43
	dw 167
	db 0, 53
	dw .Node306 ; ROUTE_43
	dw 167
	db 17, 53
	dw .Node307 ; ROUTE_43
	dw 168
	db 7, 3
	dw .Node308 ; LAKE_OF_RAGE
	dw 168
	db 27, 31
	dw .Node309 ; LAKE_OF_RAGE
	dw 168
	db 10, 35
	dw .Node310 ; LAKE_OF_RAGE
	dw 169
	db 11, 73
	dw .Node311 ; ROUTE_32
	dw 170
	db 17, 0
	dw .Node312 ; ROUTE_35
	dw 170
	db 9, 33
	dw .Node313 ; ROUTE_35
	dw 170
	db 4, 35
	dw .Node314 ; ROUTE_35
	dw 170
	db 13, 35
	dw .Node315 ; ROUTE_35
	dw 171
	db 18, 8
	dw .Node316 ; ROUTE_36
	dw 172
	db 7, 0
	dw .Node317 ; ROUTE_37
	dw 173
	db 9, 17
	dw .Node318 ; VIOLET_CITY
	dw 174
	db 2, 7
	dw .Node319 ; VIOLET_MART
	dw 175
	db 4, 15
	dw .Node320 ; VIOLET_GYM
	dw 176
	db 3, 15
	dw .Node321 ; EARLS_POKEMON_ACADEMY
	dw 177
	db 3, 7
	dw .Node322 ; VIOLET_NICKNAME_SPEECH_HOUSE
	dw 178
	db 3, 7
	dw .Node323 ; VIOLET_POKECENTER_1F
	dw 179
	db 3, 7
	dw .Node324 ; VIOLET_KYLES_HOUSE
	dw 180
	db 0, 4
	dw .Node325 ; ROUTE_32_RUINS_OF_ALPH_GATE
	dw 181
	db 3, 7
	dw .Node326 ; ROUTE_32_POKECENTER_1F
	dw 182
	db 4, 0
	dw .Node327 ; ROUTE_35_GOLDENROD_GATE
	dw 183
	db 3, 0
	dw .Node328 ; ROUTE_35_NATIONAL_PARK_GATE
	dw 184
	db 4, 0
	dw .Node329 ; ROUTE_36_RUINS_OF_ALPH_GATE
	dw 185
	db 0, 4
	dw .Node330 ; ROUTE_36_NATIONAL_PARK_GATE
	dw 186
	db 4, 0
	dw .Node331 ; ROUTE_34
	dw 186
	db 2, 0
	dw .Node332 ; ROUTE_34
	dw 186
	db 13, 37
	dw .Node333 ; ROUTE_34
	dw 186
	db 13, 0
	dw .Node334 ; ROUTE_34
	dw 186
	db 13, 15
	dw .Node335 ; ROUTE_34
	dw 187
	db 14, 0
	dw .Node336 ; GOLDENROD_CITY
	dw 187
	db 24, 7
	dw .Node337 ; GOLDENROD_CITY
	dw 187
	db 23, 0
	dw .Node338 ; GOLDENROD_CITY
	dw 187
	db 12, 35
	dw .Node339 ; GOLDENROD_CITY
	dw 187
	db 23, 35
	dw .Node340 ; GOLDENROD_CITY
	dw 188
	db 2, 17
	dw .Node341 ; GOLDENROD_GYM
	dw 189
	db 2, 7
	dw .Node342 ; GOLDENROD_BIKE_SHOP
	dw 190
	db 2, 7
	dw .Node343 ; GOLDENROD_HAPPINESS_RATER
	dw 191
	db 2, 7
	dw .Node344 ; BILLS_FAMILYS_HOUSE
	dw 192
	db 8, 17
	dw .Node345 ; GOLDENROD_MAGNET_TRAIN_STATION
	dw 193
	db 2, 7
	dw .Node346 ; GOLDENROD_FLOWER_SHOP
	dw 194
	db 2, 7
	dw .Node347 ; GOLDENROD_PP_SPEECH_HOUSE
	dw 195
	db 2, 7
	dw .Node348 ; GOLDENROD_NAME_RATER
	dw 196
	db 7, 7
	dw .Node349 ; GOLDENROD_DEPT_STORE_1F
	dw 197
	db 12, 0
	dw .Node350 ; GOLDENROD_DEPT_STORE_2F
	dw 198
	db 12, 0
	dw .Node351 ; GOLDENROD_DEPT_STORE_3F
	dw 199
	db 12, 0
	dw .Node352 ; GOLDENROD_DEPT_STORE_4F
	dw 200
	db 12, 0
	dw .Node353 ; GOLDENROD_DEPT_STORE_5F
	dw 201
	db 15, 0
	dw .Node354 ; GOLDENROD_DEPT_STORE_6F
	dw 202
	db 1, 3
	dw .Node355 ; GOLDENROD_DEPT_STORE_ELEVATOR
	dw 203
	db 13, 1
	dw .Node356 ; GOLDENROD_DEPT_STORE_ROOF
	dw 204
	db 2, 13
	dw .Node357 ; GOLDENROD_GAME_CORNER
	dw 205
	db 3, 7
	dw .Node358 ; GOLDENROD_POKECENTER_1F
	dw 207
	db 0, 4
	dw .Node359 ; ILEX_FOREST_AZALEA_GATE
	dw 208
	db 4, 0
	dw .Node360 ; ROUTE_34_ILEX_FOREST_GATE
	dw 209
	db 0, 5
	dw .Node361 ; DAY_CARE
	dw 210
	db 17, 3
	dw .Node362 ; ROUTE_6
	dw 210
	db 0, 17
	dw .Node363 ; ROUTE_6
	dw 210
	db 9, 17
	dw .Node364 ; ROUTE_6
	dw 211
	db 0, 8
	dw .Node365 ; ROUTE_11
	dw 212
	db 10, 0
	dw .Node366 ; VERMILION_CITY
	dw 212
	db 5, 5
	dw .Node367 ; VERMILION_CITY
	dw 212
	db 19, 0
	dw .Node368 ; VERMILION_CITY
	dw 212
	db 10, 19
	dw .Node369 ; VERMILION_CITY
	dw 213
	db 2, 7
	dw .Node370 ; VERMILION_FISHING_SPEECH_HOUSE
	dw 214
	db 3, 7
	dw .Node371 ; VERMILION_POKECENTER_1F
	dw 216
	db 2, 7
	dw .Node372 ; POKEMON_FAN_CLUB
	dw 217
	db 2, 7
	dw .Node373 ; VERMILION_MAGNET_TRAIN_SPEECH_HOUSE
	dw 218
	db 2, 7
	dw .Node374 ; VERMILION_MART
	dw 219
	db 2, 7
	dw .Node375 ; VERMILION_DIGLETTS_CAVE_SPEECH_HOUSE
	dw 220
	db 4, 17
	dw .Node376 ; VERMILION_GYM
	dw 221
	db 4, 0
	dw .Node377 ; ROUTE_6_SAFFRON_GATE
	dw 222
	db 3, 7
	dw .Node378 ; ROUTE_6_UNDERGROUND_PATH_ENTRANCE
	dw 223
	db 0, 0
	dw .Node379 ; ROUTE_1
	dw 223
	db 2, 0
	dw .Node380 ; ROUTE_1
	dw 223
	db 8, 0
	dw .Node381 ; ROUTE_1
	dw 223
	db 11, 0
	dw .Node382 ; ROUTE_1
	dw 223
	db 17, 0
	dw .Node383 ; ROUTE_1
	dw 223
	db 2, 35
	dw .Node384 ; ROUTE_1
	dw 223
	db 11, 35
	dw .Node385 ; ROUTE_1
	dw 224
	db 0, 0
	dw .Node386 ; PALLET_TOWN
	dw 224
	db 4, 0
	dw .Node387 ; PALLET_TOWN
	dw 224
	db 5, 5
	dw .Node388 ; PALLET_TOWN
	dw 224
	db 11, 0
	dw .Node389 ; PALLET_TOWN
	dw 224
	db 19, 0
	dw .Node390 ; PALLET_TOWN
	dw 224
	db 4, 17
	dw .Node391 ; PALLET_TOWN
	dw 225
	db 2, 7
	dw .Node392 ; REDS_HOUSE_1F
	dw 226
	db 7, 0
	dw .Node393 ; REDS_HOUSE_2F
	dw 227
	db 2, 7
	dw .Node394 ; BLUES_HOUSE
	dw 228
	db 4, 11
	dw .Node395 ; OAKS_LAB
	dw 229
	db 52, 1
	dw .Node396 ; ROUTE_3
	dw 229
	db 0, 10
	dw .Node397 ; ROUTE_3
	dw 230
	db 29, 13
	dw .Node398 ; PEWTER_CITY
	dw 230
	db 39, 10
	dw .Node399 ; PEWTER_CITY
	dw 230
	db 39, 20
	dw .Node400 ; PEWTER_CITY
	dw 230
	db 39, 26
	dw .Node401 ; PEWTER_CITY
	dw 231
	db 2, 7
	dw .Node402 ; PEWTER_NIDORAN_SPEECH_HOUSE
	dw 232
	db 4, 13
	dw .Node403 ; PEWTER_GYM
	dw 233
	db 2, 7
	dw .Node404 ; PEWTER_MART
	dw 234
	db 3, 7
	dw .Node405 ; PEWTER_POKECENTER_1F
	dw 236
	db 2, 7
	dw .Node406 ; PEWTER_SNOOZE_SPEECH_HOUSE
	dw 237
	db 11, 7
	dw .Node407 ; OLIVINE_PORT
	dw 238
	db 9, 5
	dw .Node408 ; VERMILION_PORT
	dw 239
	db 25, 1
	dw .Node409 ; FAST_SHIP_1F
	dw 239
	db 3, 13
	dw .Node410 ; FAST_SHIP_1F
	dw 240
	db 2, 0
	dw .Node411 ; FAST_SHIP_CABINS_NNW_NNE_NE
	dw 240
	db 2, 12
	dw .Node412 ; FAST_SHIP_CABINS_NNW_NNE_NE
	dw 240
	db 2, 24
	dw .Node413 ; FAST_SHIP_CABINS_NNW_NNE_NE
	dw 241
	db 2, 0
	dw .Node414 ; FAST_SHIP_CABINS_SW_SSW_NW
	dw 241
	db 2, 19
	dw .Node415 ; FAST_SHIP_CABINS_SW_SSW_NW
	dw 241
	db 2, 31
	dw .Node416 ; FAST_SHIP_CABINS_SW_SSW_NW
	dw 242
	db 2, 7
	dw .Node417 ; FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN
	dw 242
	db 2, 19
	dw .Node418 ; FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN
	dw 242
	db 2, 33
	dw .Node419 ; FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN
	dw 243
	db 5, 11
	dw .Node420 ; FAST_SHIP_B1F
	dw 244
	db 3, 2
	dw .Node421 ; OLIVINE_PORT_PASSAGE
	dw 244
	db 15, 0
	dw .Node422 ; OLIVINE_PORT_PASSAGE
	dw 245
	db 3, 2
	dw .Node423 ; VERMILION_PORT_PASSAGE
	dw 245
	db 15, 0
	dw .Node424 ; VERMILION_PORT_PASSAGE
	dw 246
	db 20, 5
	dw .Node425 ; MOUNT_MOON_SQUARE
	dw 247
	db 3, 7
	dw .Node426 ; MOUNT_MOON_GIFT_SHOP
	dw 248
	db 9, 13
	dw .Node427 ; TIN_TOWER_ROOF
	dw 249
	db 9, 5
	dw .Node428 ; ROUTE_23
	dw 250
	db 5, 13
	dw .Node429 ; INDIGO_PLATEAU_POKECENTER_1F
	dw 251
	db 5, 17
	dw .Node430 ; WILLS_ROOM
	dw 252
	db 4, 17
	dw .Node431 ; KOGAS_ROOM
	dw 253
	db 4, 17
	dw .Node432 ; BRUNOS_ROOM
	dw 254
	db 4, 17
	dw .Node433 ; KARENS_ROOM
	dw 255
	db 4, 23
	dw .Node434 ; LANCES_ROOM
	dw 257
	db 0, 17
	dw .Node435 ; ROUTE_13
	dw 257
	db 40, 0
	dw .Node436 ; ROUTE_13
	dw 257
	db 54, 0
	dw .Node437 ; ROUTE_13
	dw 257
	db 56, 0
	dw .Node438 ; ROUTE_13
	dw 258
	db 0, 0
	dw .Node439 ; ROUTE_14
	dw 258
	db 11, 0
	dw .Node440 ; ROUTE_14
	dw 258
	db 0, 33
	dw .Node441 ; ROUTE_14
	dw 258
	db 0, 22
	dw .Node442 ; ROUTE_14
	dw 259
	db 2, 4
	dw .Node443 ; ROUTE_15
	dw 259
	db 39, 4
	dw .Node444 ; ROUTE_15
	dw 259
	db 39, 15
	dw .Node445 ; ROUTE_15
	dw 260
	db 0, 2
	dw .Node446 ; ROUTE_18
	dw 260
	db 2, 6
	dw .Node447 ; ROUTE_18
	dw 260
	db 0, 10
	dw .Node448 ; ROUTE_18
	dw 261
	db 5, 13
	dw .Node449 ; FUCHSIA_CITY
	dw 261
	db 22, 13
	dw .Node450 ; FUCHSIA_CITY
	dw 261
	db 15, 35
	dw .Node451 ; FUCHSIA_CITY
	dw 261
	db 1, 35
	dw .Node452 ; FUCHSIA_CITY
	dw 262
	db 2, 7
	dw .Node453 ; FUCHSIA_MART
	dw 263
	db 2, 7
	dw .Node454 ; SAFARI_ZONE_MAIN_OFFICE
	dw 264
	db 4, 17
	dw .Node455 ; FUCHSIA_GYM
	dw 265
	db 2, 7
	dw .Node456 ; BILLS_OLDER_SISTERS_HOUSE
	dw 266
	db 3, 7
	dw .Node457 ; FUCHSIA_POKECENTER_1F
	dw 268
	db 2, 7
	dw .Node458 ; SAFARI_ZONE_WARDENS_HOME
	dw 269
	db 0, 4
	dw .Node459 ; ROUTE_15_FUCHSIA_GATE
	dw 270
	db 39, 0
	dw .Node460 ; ROUTE_8
	dw 270
	db 4, 4
	dw .Node461 ; ROUTE_8
	dw 270
	db 39, 16
	dw .Node462 ; ROUTE_8
	dw 271
	db 0, 0
	dw .Node463 ; ROUTE_12
	dw 271
	db 11, 33
	dw .Node464 ; ROUTE_12
	dw 271
	db 11, 0
	dw .Node465 ; ROUTE_12
	dw 271
	db 16, 53
	dw .Node466 ; ROUTE_12
	dw 271
	db 0, 53
	dw .Node467 ; ROUTE_12
	dw 272
	db 6, 1
	dw .Node468 ; ROUTE_10_SOUTH
	dw 273
	db 0, 0
	dw .Node469 ; LAVENDER_TOWN
	dw 273
	db 5, 5
	dw .Node470 ; LAVENDER_TOWN
	dw 273
	db 18, 0
	dw .Node471 ; LAVENDER_TOWN
	dw 273
	db 0, 17
	dw .Node472 ; LAVENDER_TOWN
	dw 274
	db 3, 7
	dw .Node473 ; LAVENDER_POKECENTER_1F
	dw 276
	db 2, 7
	dw .Node474 ; MR_FUJIS_HOUSE
	dw 277
	db 2, 7
	dw .Node475 ; LAVENDER_SPEECH_HOUSE
	dw 278
	db 2, 7
	dw .Node476 ; LAVENDER_NAME_RATER
	dw 279
	db 2, 7
	dw .Node477 ; LAVENDER_MART
	dw 280
	db 4, 7
	dw .Node478 ; SOUL_HOUSE
	dw 281
	db 2, 7
	dw .Node479 ; LAV_RADIO_TOWER_1F
	dw 282
	db 0, 4
	dw .Node480 ; ROUTE_8_SAFFRON_GATE
	dw 283
	db 2, 7
	dw .Node481 ; ROUTE_12_SUPER_ROD_HOUSE
	dw 284
	db 0, 0
	dw .Node482 ; ROUTE_28
	dw 284
	db 33, 5
	dw .Node483 ; ROUTE_28
	dw 284
	db 7, 3
	dw .Node484 ; ROUTE_28
	dw 285
	db 23, 19
	dw .Node485 ; SILVER_CAVE_OUTSIDE
	dw 285
	db 39, 21
	dw .Node486 ; SILVER_CAVE_OUTSIDE
	dw 286
	db 3, 7
	dw .Node487 ; SILVER_CAVE_POKECENTER_1F
	dw 287
	db 2, 7
	dw .Node488 ; ROUTE_28_STEEL_WING_HOUSE
	dw 294
	db 15, 6
	dw .Node489 ; ROUTE_7
	dw 294
	db 19, 16
	dw .Node490 ; ROUTE_7
	dw 295
	db 3, 1
	dw .Node491 ; ROUTE_16
	dw 295
	db 14, 6
	dw .Node492 ; ROUTE_16
	dw 295
	db 9, 6
	dw .Node493 ; ROUTE_16
	dw 296
	db 17, 82
	dw .Node494 ; ROUTE_17
	dw 296
	db 19, 86
	dw .Node495 ; ROUTE_17
	dw 296
	db 19, 78
	dw .Node496 ; ROUTE_17
	dw 297
	db 4, 9
	dw .Node497 ; CELADON_CITY
	dw 297
	db 10, 29
	dw .Node498 ; CELADON_CITY
	dw 298
	db 7, 7
	dw .Node499 ; CELADON_DEPT_STORE_1F
	dw 299
	db 12, 0
	dw .Node500 ; CELADON_DEPT_STORE_2F
	dw 300
	db 12, 0
	dw .Node501 ; CELADON_DEPT_STORE_3F
	dw 301
	db 12, 0
	dw .Node502 ; CELADON_DEPT_STORE_4F
	dw 302
	db 12, 0
	dw .Node503 ; CELADON_DEPT_STORE_5F
	dw 303
	db 15, 0
	dw .Node504 ; CELADON_DEPT_STORE_6F
	dw 304
	db 1, 3
	dw .Node505 ; CELADON_DEPT_STORE_ELEVATOR
	dw 305
	db 3, 0
	dw .Node506 ; CELADON_MANSION_1F
	dw 305
	db 6, 9
	dw .Node507 ; CELADON_MANSION_1F
	dw 306
	db 0, 0
	dw .Node508 ; CELADON_MANSION_2F
	dw 306
	db 6, 0
	dw .Node509 ; CELADON_MANSION_2F
	dw 307
	db 0, 0
	dw .Node510 ; CELADON_MANSION_3F
	dw 307
	db 6, 0
	dw .Node511 ; CELADON_MANSION_3F
	dw 308
	db 1, 1
	dw .Node512 ; CELADON_MANSION_ROOF
	dw 308
	db 6, 1
	dw .Node513 ; CELADON_MANSION_ROOF
	dw 309
	db 2, 7
	dw .Node514 ; CELADON_MANSION_ROOF_HOUSE
	dw 310
	db 3, 7
	dw .Node515 ; CELADON_POKECENTER_1F
	dw 312
	db 14, 13
	dw .Node516 ; CELADON_GAME_CORNER
	dw 313
	db 2, 5
	dw .Node517 ; CELADON_GAME_CORNER_PRIZE_ROOM
	dw 314
	db 4, 17
	dw .Node518 ; CELADON_GYM
	dw 315
	db 6, 7
	dw .Node519 ; CELADON_CAFE
	dw 316
	db 2, 7
	dw .Node520 ; ROUTE_16_FUCHSIA_SPEECH_HOUSE
	dw 317
	db 0, 4
	dw .Node521 ; ROUTE_16_GATE
	dw 318
	db 0, 4
	dw .Node522 ; ROUTE_7_SAFFRON_GATE
	dw 319
	db 0, 4
	dw .Node523 ; ROUTE_17_ROUTE_18_GATE
	dw 320
	db 19, 2
	dw .Node524 ; ROUTE_40
	dw 320
	db 19, 4
	dw .Node525 ; ROUTE_40
	dw 320
	db 2, 35
	dw .Node526 ; ROUTE_40
	dw 321
	db 32, 0
	dw .Node527 ; ROUTE_41
	dw 321
	db 36, 19
	dw .Node528 ; ROUTE_41
	dw 321
	db 12, 17
	dw .Node529 ; ROUTE_41
	dw 321
	db 12, 37
	dw .Node530 ; ROUTE_41
	dw 321
	db 36, 45
	dw .Node531 ; ROUTE_41
	dw 322
	db 17, 41
	dw .Node532 ; CIANWOOD_CITY
	dw 322
	db 29, 1
	dw .Node533 ; CIANWOOD_CITY
	dw 323
	db 2, 7
	dw .Node534 ; MANIAS_HOUSE
	dw 324
	db 4, 17
	dw .Node535 ; CIANWOOD_GYM
	dw 325
	db 3, 7
	dw .Node536 ; CIANWOOD_POKECENTER_1F
	dw 326
	db 2, 7
	dw .Node537 ; CIANWOOD_PHARMACY
	dw 327
	db 2, 7
	dw .Node538 ; CIANWOOD_PHOTO_STUDIO
	dw 328
	db 2, 7
	dw .Node539 ; CIANWOOD_LUGIA_SPEECH_HOUSE
	dw 329
	db 2, 7
	dw .Node540 ; POKE_SEERS_HOUSE
	dw 336
	db 8, 0
	dw .Node541 ; ROUTE_2
	dw 336
	db 15, 15
	dw .Node542 ; ROUTE_2
	dw 336
	db 16, 27
	dw .Node543 ; ROUTE_2
	dw 336
	db 15, 31
	dw .Node544 ; ROUTE_2
	dw 337
	db 39, 0
	dw .Node545 ; ROUTE_22
	dw 337
	db 13, 5
	dw .Node546 ; ROUTE_22
	dw 338
	db 0, 8
	dw .Node547 ; VIRIDIAN_CITY
	dw 338
	db 32, 7
	dw .Node548 ; VIRIDIAN_CITY
	dw 338
	db 0, 18
	dw .Node549 ; VIRIDIAN_CITY
	dw 338
	db 20, 35
	dw .Node550 ; VIRIDIAN_CITY
	dw 338
	db 22, 35
	dw .Node551 ; VIRIDIAN_CITY
	dw 338
	db 31, 35
	dw .Node552 ; VIRIDIAN_CITY
	dw 338
	db 37, 35
	dw .Node553 ; VIRIDIAN_CITY
	dw 339
	db 4, 17
	dw .Node554 ; VIRIDIAN_GYM
	dw 340
	db 2, 7
	dw .Node555 ; VIRIDIAN_NICKNAME_SPEECH_HOUSE
	dw 341
	db 2, 13
	dw .Node556 ; TRAINER_HOUSE_1F
	dw 342
	db 9, 4
	dw .Node557 ; TRAINER_HOUSE_B1F
	dw 343
	db 2, 7
	dw .Node558 ; VIRIDIAN_MART
	dw 344
	db 3, 7
	dw .Node559 ; VIRIDIAN_POKECENTER_1F
	dw 346
	db 2, 7
	dw .Node560 ; ROUTE_2_NUGGET_HOUSE
	dw 347
	db 4, 0
	dw .Node561 ; ROUTE_2_GATE
	dw 348
	db 17, 7
	dw .Node562 ; VICTORY_ROAD_GATE
	dw 349
	db 0, 94
	dw .Node563 ; ROUTE_26
	dw 349
	db 7, 5
	dw .Node564 ; ROUTE_26
	dw 349
	db 0, 98
	dw .Node565 ; ROUTE_26
	dw 349
	db 0, 102
	dw .Node566 ; ROUTE_26
	dw 349
	db 0, 105
	dw .Node567 ; ROUTE_26
	dw 350
	db 33, 7
	dw .Node568 ; ROUTE_27
	dw 350
	db 0, 6
	dw .Node569 ; ROUTE_27
	dw 350
	db 79, 10
	dw .Node570 ; ROUTE_27
	dw 350
	db 79, 4
	dw .Node571 ; ROUTE_27
	dw 350
	db 79, 12
	dw .Node572 ; ROUTE_27
	dw 350
	db 79, 8
	dw .Node573 ; ROUTE_27
	dw 350
	db 79, 15
	dw .Node574 ; ROUTE_27
	dw 351
	db 27, 1
	dw .Node575 ; ROUTE_29
	dw 352
	db 6, 3
	dw .Node576 ; NEW_BARK_TOWN
	dw 352
	db 19, 6
	dw .Node577 ; NEW_BARK_TOWN
	dw 353
	db 4, 11
	dw .Node578 ; ELMS_LAB
	dw 354
	db 6, 7
	dw .Node579 ; PLAYERS_HOUSE_1F
	dw 355
	db 7, 0
	dw .Node580 ; PLAYERS_HOUSE_2F
	dw 356
	db 2, 7
	dw .Node581 ; PLAYERS_NEIGHBORS_HOUSE
	dw 357
	db 2, 7
	dw .Node582 ; ELMS_HOUSE
	dw 358
	db 2, 7
	dw .Node583 ; ROUTE_26_HEAL_HOUSE
	dw 359
	db 2, 7
	dw .Node584 ; DAY_OF_WEEK_SIBLINGS_HOUSE
	dw 360
	db 2, 7
	dw .Node585 ; ROUTE_27_SANDSTORM_HOUSE
	dw 361
	db 4, 0
	dw .Node586 ; ROUTE_29_ROUTE_46_GATE
	dw 362
	db 17, 15
	dw .Node587 ; ROUTE_5
	dw 362
	db 10, 11
	dw .Node588 ; ROUTE_5
	dw 362
	db 6, 0
	dw .Node589 ; ROUTE_5
	dw 363
	db 26, 3
	dw .Node590 ; SAFFRON_CITY
	dw 363
	db 0, 34
	dw .Node591 ; SAFFRON_CITY
	dw 364
	db 4, 11
	dw .Node592 ; FIGHTING_DOJO
	dw 365
	db 5, 3
	dw .Node593 ; SAFFRON_GYM
	dw 365
	db 11, 5
	dw .Node594 ; SAFFRON_GYM
	dw 365
	db 19, 3
	dw .Node595 ; SAFFRON_GYM
	dw 365
	db 1, 11
	dw .Node596 ; SAFFRON_GYM
	dw 365
	db 11, 9
	dw .Node597 ; SAFFRON_GYM
	dw 365
	db 19, 11
	dw .Node598 ; SAFFRON_GYM
	dw 365
	db 1, 15
	dw .Node599 ; SAFFRON_GYM
	dw 365
	db 8, 17
	dw .Node600 ; SAFFRON_GYM
	dw 365
	db 19, 15
	dw .Node601 ; SAFFRON_GYM
	dw 366
	db 2, 7
	dw .Node602 ; SAFFRON_MART
	dw 367
	db 3, 7
	dw .Node603 ; SAFFRON_POKECENTER_1F
	dw 369
	db 2, 7
	dw .Node604 ; MR_PSYCHICS_HOUSE
	dw 370
	db 8, 17
	dw .Node605 ; SAFFRON_MAGNET_TRAIN_STATION
	dw 371
	db 2, 7
	dw .Node606 ; SILPH_CO_1F
	dw 372
	db 2, 7
	dw .Node607 ; COPYCATS_HOUSE_1F
	dw 373
	db 3, 0
	dw .Node608 ; COPYCATS_HOUSE_2F
	dw 374
	db 3, 7
	dw .Node609 ; ROUTE_5_UNDERGROUND_PATH_ENTRANCE
	dw 375
	db 4, 0
	dw .Node610 ; ROUTE_5_SAFFRON_GATE
	dw 376
	db 2, 7
	dw .Node611 ; ROUTE_5_CLEANSE_TAG_HOUSE
	dw 377
	db 7, 39
	dw .Node612 ; ROUTE_30
	dw 378
	db 4, 6
	dw .Node613 ; ROUTE_31
	dw 379
	db 23, 3
	dw .Node614 ; CHERRYGROVE_CITY
	dw 380
	db 2, 7
	dw .Node615 ; CHERRYGROVE_MART
	dw 381
	db 3, 7
	dw .Node616 ; CHERRYGROVE_POKECENTER_1F
	dw 382
	db 2, 7
	dw .Node617 ; CHERRYGROVE_GYM_SPEECH_HOUSE
	dw 383
	db 2, 7
	dw .Node618 ; GUIDE_GENTS_HOUSE
	dw 384
	db 2, 7
	dw .Node619 ; CHERRYGROVE_EVOLUTION_SPEECH_HOUSE
	dw 385
	db 2, 7
	dw .Node620 ; ROUTE_30_BERRY_HOUSE
	dw 386
	db 2, 7
	dw .Node621 ; MR_POKEMONS_HOUSE
	dw 387
	db 0, 4
	dw .Node622 ; ROUTE_31_VIOLET_GATE
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
	dw 219
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
	dw 100
	db %00000
	db DEDGE_WARP, 10
	dw 422
	db %00000
	db DEDGE_EDGE, 1
	dw 14
	db %00000
	db DEDGE_EDGE, 2
	dw 525
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
	dw 524
	db %00000
	db -1
.Node23:
	db DEDGE_EDGE, 2
	dw 526
	db %00000
	db DEDGE_WALK, 0
	dw 20
	db %00000
	db -1
.Node24:
	db DEDGE_WARP, 1
	dw 32
	db %00000
	db -1
.Node25:
	db DEDGE_WARP, 1
	dw 32
	db %00000
	db -1
.Node26:
	db DEDGE_WARP, 1
	dw 32
	db %00000
	db -1
.Node27:
	db DEDGE_WARP, 1
	dw 219
	db %00000
	db DEDGE_WARP, 3
	dw 28
	db %00000
	db -1
.Node28:
	db DEDGE_WARP, 1
	dw 27
	db %00000
	db DEDGE_WARP, 3
	dw 131
	db %00000
	db DEDGE_WARP, 4
	dw 128
	db %00000
	db DEDGE_WARP, 5
	dw 132
	db %00000
	db DEDGE_EDGE, 3
	dw 31
	db %00000
	db DEDGE_EDGE, 3
	dw 32
	db %00000
	db -1
.Node29:
	db DEDGE_EDGE, 3
	dw 34
	db %00000
	db -1
.Node30:
	db DEDGE_WARP, 1
	dw 139
	db %00000
	db DEDGE_EDGE, 2
	dw 33
	db %00000
	db DEDGE_EDGE, 2
	dw 32
	db %00000
	db DEDGE_EDGE, 2
	dw 34
	db %00000
	db DEDGE_EDGE, 3
	dw 234
	db %00000
	db -1
.Node31:
	db DEDGE_EDGE, 1
	dw 306
	db %00000
	db DEDGE_EDGE, 2
	dw 28
	db %00000
	db -1
.Node32:
	db DEDGE_WARP, 1
	dw 109
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
	dw 303
	db %00000
	db DEDGE_EDGE, 2
	dw 28
	db %00000
	db DEDGE_EDGE, 3
	dw 30
	db %00000
	db -1
.Node33:
	db DEDGE_EDGE, 1
	dw 307
	db %00000
	db DEDGE_EDGE, 3
	dw 30
	db %00000
	db -1
.Node34:
	db DEDGE_EDGE, 2
	dw 29
	db %00000
	db DEDGE_EDGE, 3
	dw 30
	db %00000
	db -1
.Node35:
	db DEDGE_WARP, 4
	dw 37
	db %00000
	db DEDGE_WARP, 5
	dw 38
	db %00000
	db -1
.Node36:
	db DEDGE_WARP, 1
	dw 318
	db %00000
	db DEDGE_WARP, 3
	dw 38
	db %00000
	db -1
.Node37:
	db DEDGE_WARP, 2
	dw 35
	db %00000
	db DEDGE_WARP, 4
	dw 39
	db %00000
	db -1
.Node38:
	db DEDGE_WARP, 1
	dw 36
	db %00000
	db DEDGE_WARP, 3
	dw 35
	db %00000
	db -1
.Node39:
	db DEDGE_WARP, 1
	dw 37
	db %00000
	db -1
.Node40:
	db DEDGE_WARP, 1
	dw 218
	db %00000
	db DEDGE_WARP, 3
	dw 41
	db %00000
	db -1
.Node41:
	db DEDGE_WARP, 1
	dw 42
	db %00000
	db DEDGE_WARP, 2
	dw 40
	db %00000
	db -1
.Node42:
	db DEDGE_WARP, 1
	dw 41
	db %00000
	db DEDGE_WARP, 2
	dw 43
	db %00000
	db -1
.Node43:
	db DEDGE_WARP, 1
	dw 47
	db %00000
	db DEDGE_WARP, 2
	dw 42
	db %00000
	db DEDGE_WARP, 3
	dw 44
	db %00000
	db DEDGE_WARP, 4
	dw 46
	db %00000
	db -1
.Node44:
	db DEDGE_WARP, 3
	dw 43
	db %00000
	db -1
.Node45:
	db DEDGE_WARP, 1
	dw 48
	db %00000
	db DEDGE_WALK, 0
	dw 44
	db %00000
	db -1
.Node46:
	db DEDGE_WARP, 4
	dw 43
	db %00000
	db -1
.Node47:
	db DEDGE_WARP, 2
	dw 43
	db %00000
	db DEDGE_WALK, 0
	dw 44
	db %00000
	db DEDGE_WALK, 0
	dw 45
	db %00000
	db DEDGE_WALK, 0
	dw 46
	db %00000
	db -1
.Node48:
	db DEDGE_WARP, 1
	dw 49
	db %00000
	db DEDGE_WARP, 2
	dw 45
	db %00000
	db -1
.Node49:
	db DEDGE_WARP, 1
	dw 48
	db %00000
	db DEDGE_WARP, 2
	dw 52
	db %00000
	db DEDGE_WARP, 4
	dw 50
	db %00000
	db -1
.Node50:
	db DEDGE_WARP, 3
	dw 49
	db %00000
	db DEDGE_WARP, 5
	dw 57
	db %00000
	db -1
.Node51:
	db DEDGE_WARP, 3
	dw 55
	db %00000
	db DEDGE_WARP, 4
	dw 56
	db %00000
	db -1
.Node52:
	db DEDGE_WARP, 1
	dw 49
	db %00000
	db DEDGE_WARP, 2
	dw 55
	db %00000
	db -1
.Node53:
	db DEDGE_WARP, 6
	dw 57
	db %00000
	db -1
.Node54:
	db DEDGE_WARP, 5
	dw 57
	db %00000
	db -1
.Node55:
	db DEDGE_WARP, 1
	dw 52
	db %00000
	db DEDGE_WARP, 2
	dw 51
	db %00000
	db -1
.Node56:
	db DEDGE_WARP, 3
	dw 51
	db %00000
	db DEDGE_WARP, 4
	dw 427
	db %00000
	db -1
.Node57:
	db DEDGE_WARP, 5
	dw 50
	db %00000
	db DEDGE_WARP, 6
	dw 54
	db %00000
	db DEDGE_WARP, 7
	dw 53
	db %00000
	db -1
.Node58:
	db DEDGE_WARP, 1
	dw 219
	db %00000
	db DEDGE_WARP, 4
	dw 61
	db %00000
	db DEDGE_WARP, 8
	dw 62
	db %00000
	db DEDGE_WARP, 12
	dw 60
	db %00000
	db DEDGE_WALK, 0
	dw 59
	db %10000
	db -1
.Node59:
	db DEDGE_WARP, 7
	dw 62
	db %00000
	db DEDGE_WALK, 0
	dw 58
	db %00000
	db -1
.Node60:
	db DEDGE_WARP, 5
	dw 58
	db %00000
	db -1
.Node61:
	db DEDGE_WARP, 6
	dw 58
	db %00000
	db -1
.Node62:
	db DEDGE_WARP, 2
	dw 59
	db %00000
	db -1
.Node63:
	db DEDGE_WARP, 1
	dw 330
	db %00000
	db DEDGE_WARP, 3
	dw 328
	db %00000
	db -1
.Node64:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db DEDGE_WARP, 3
	dw 65
	db %00000
	db -1
.Node65:
	db DEDGE_WARP, 1
	dw 66
	db %00000
	db DEDGE_WARP, 2
	dw 64
	db %00000
	db -1
.Node66:
	db DEDGE_WARP, 1
	dw 65
	db %00000
	db DEDGE_WARP, 2
	dw 68
	db %00000
	db -1
.Node67:
	db DEDGE_WARP, 3
	dw 69
	db %00000
	db -1
.Node68:
	db DEDGE_WARP, 1
	dw 70
	db %00000
	db DEDGE_WARP, 2
	dw 66
	db %00000
	db -1
.Node69:
	db DEDGE_WARP, 3
	dw 71
	db %00000
	db DEDGE_WARP, 4
	dw 67
	db %00000
	db -1
.Node70:
	db DEDGE_WARP, 1
	dw 68
	db %00000
	db -1
.Node71:
	db DEDGE_WARP, 2
	dw 69
	db %00000
	db -1
.Node72:
	db DEDGE_WARP, 1
	dw 75
	db %00000
	db DEDGE_WARP, 2
	dw 76
	db %00000
	db DEDGE_WARP, 5
	dw 79
	db %00000
	db DEDGE_WARP, 6
	dw 80
	db %00000
	db DEDGE_WARP, 7
	dw 91
	db %00000
	db DEDGE_WARP, 9
	dw 329
	db %00000
	db DEDGE_WARP, 10
	dw 325
	db %00000
	db DEDGE_WALK, 0
	dw 73
	db %00010
	db -1
.Node73:
	db DEDGE_WARP, 4
	dw 78
	db %00000
	db DEDGE_WALK, 0
	dw 72
	db %00010
	db -1
.Node74:
	db DEDGE_WARP, 3
	dw 77
	db %00000
	db DEDGE_WARP, 8
	dw 92
	db %00000
	db DEDGE_WALK, 0
	dw 72
	db %00010
	db DEDGE_WALK, 0
	dw 73
	db %00000
	db -1
.Node75:
	db DEDGE_WARP, 1
	dw 72
	db %00000
	db DEDGE_WARP, 5
	dw 81
	db %00000
	db -1
.Node76:
	db DEDGE_WARP, 1
	dw 72
	db %00000
	db DEDGE_WARP, 5
	dw 82
	db %00000
	db -1
.Node77:
	db DEDGE_WARP, 1
	dw 74
	db %00000
	db DEDGE_WARP, 5
	dw 83
	db %00000
	db -1
.Node78:
	db DEDGE_WARP, 1
	dw 73
	db %00000
	db DEDGE_WARP, 5
	dw 84
	db %00000
	db -1
.Node79:
	db DEDGE_WARP, 1
	dw 72
	db %00000
	db -1
.Node80:
	db DEDGE_WARP, 1
	dw 72
	db %00000
	db -1
.Node81:
	db DEDGE_WARP, 1
	dw 75
	db %00000
	db -1
.Node82:
	db DEDGE_WARP, 1
	dw 76
	db %00000
	db -1
.Node83:
	db DEDGE_WARP, 1
	dw 77
	db %00000
	db -1
.Node84:
	db DEDGE_WARP, 1
	dw 78
	db %00000
	db -1
.Node85:
	db -1
.Node86:
	db -1
.Node87:
	db -1
.Node88:
	db -1
.Node89:
	db DEDGE_WARP, 1
	dw 93
	db %00000
	db DEDGE_WARP, 3
	dw 298
	db %00000
	db DEDGE_WARP, 4
	dw 311
	db %00000
	db DEDGE_WALK, 0
	dw 90
	db %00010
	db -1
.Node90:
	db DEDGE_WARP, 2
	dw 94
	db %00000
	db DEDGE_WALK, 0
	dw 89
	db %00010
	db -1
.Node91:
	db DEDGE_WARP, 1
	dw 72
	db %00000
	db DEDGE_WALK, 0
	dw 93
	db %00010
	db -1
.Node92:
	db DEDGE_WARP, 2
	dw 74
	db %00000
	db -1
.Node93:
	db DEDGE_WARP, 3
	dw 89
	db %00000
	db DEDGE_WALK, 0
	dw 91
	db %00010
	db -1
.Node94:
	db DEDGE_WARP, 4
	dw 90
	db %00000
	db DEDGE_WALK, 0
	dw 95
	db %00010
	db -1
.Node95:
	db DEDGE_WARP, 5
	dw 96
	db %00000
	db DEDGE_WALK, 0
	dw 94
	db %00010
	db -1
.Node96:
	db DEDGE_WARP, 1
	dw 95
	db %00000
	db -1
.Node97:
	db DEDGE_WARP, 1
	dw 299
	db %00000
	db -1
.Node98:
	db DEDGE_WARP, 2
	dw 99
	db %00000
	db -1
.Node99:
	db DEDGE_WARP, 1
	dw 98
	db %00000
	db -1
.Node100:
	db DEDGE_WARP, 1
	dw 20
	db %00000
	db DEDGE_WARP, 3
	dw 101
	db %00000
	db -1
.Node101:
	db DEDGE_WARP, 1
	dw 100
	db %00000
	db DEDGE_WARP, 2
	dw 102
	db %00000
	db -1
.Node102:
	db DEDGE_WARP, 1
	dw 104
	db %00000
	db DEDGE_WARP, 2
	dw 101
	db %00000
	db -1
.Node103:
	db DEDGE_WARP, 3
	dw 105
	db %00000
	db -1
.Node104:
	db DEDGE_WARP, 1
	dw 102
	db %00000
	db DEDGE_WARP, 2
	dw 106
	db %00000
	db -1
.Node105:
	db DEDGE_WARP, 3
	dw 107
	db %00000
	db DEDGE_WARP, 4
	dw 103
	db %00000
	db -1
.Node106:
	db DEDGE_WARP, 2
	dw 104
	db %00000
	db -1
.Node107:
	db DEDGE_WARP, 1
	dw 108
	db %00000
	db DEDGE_WARP, 3
	dw 105
	db %00000
	db -1
.Node108:
	db DEDGE_WARP, 1
	dw 107
	db %00000
	db -1
.Node109:
	db DEDGE_WARP, 1
	dw 32
	db %00000
	db DEDGE_WARP, 3
	dw 110
	db %00000
	db -1
.Node110:
	db DEDGE_WARP, 1
	dw 109
	db %00000
	db DEDGE_WARP, 2
	dw 113
	db %00000
	db DEDGE_WARP, 3
	dw 110
	db %00000
	db -1
.Node111:
	db DEDGE_WARP, 2
	dw 114
	db %00000
	db DEDGE_WARP, 3
	dw 115
	db %00000
	db -1
.Node112:
	db DEDGE_WARP, 4
	dw 114
	db %00000
	db -1
.Node113:
	db DEDGE_WARP, 1
	dw 110
	db %00000
	db DEDGE_WARP, 5
	dw 115
	db %00000
	db -1
.Node114:
	db DEDGE_WARP, 1
	dw 111
	db %00000
	db DEDGE_WARP, 3
	dw 112
	db %00000
	db -1
.Node115:
	db DEDGE_WARP, 2
	dw 111
	db %00000
	db DEDGE_WARP, 4
	dw 113
	db %00000
	db -1
.Node116:
	db DEDGE_WARP, 1
	dw 360
	db %00000
	db DEDGE_WALK, 0
	dw 117
	db %00001
	db -1
.Node117:
	db DEDGE_WARP, 2
	dw 359
	db %00000
	db DEDGE_WALK, 0
	dw 116
	db %00001
	db -1
.Node118:
	db DEDGE_WARP, 1
	dw 123
	db %00000
	db DEDGE_WARP, 2
	dw 122
	db %00000
	db DEDGE_WARP, 3
	dw 119
	db %00000
	db -1
.Node119:
	db DEDGE_WARP, 4
	dw 118
	db %00000
	db DEDGE_WARP, 6
	dw 120
	db %00000
	db -1
.Node120:
	db DEDGE_WARP, 1
	dw 119
	db %00000
	db -1
.Node121:
	db DEDGE_WARP, 2
	dw 126
	db %00000
	db -1
.Node122:
	db DEDGE_WARP, 4
	dw 118
	db %00000
	db DEDGE_WARP, 5
	dw 337
	db %00000
	db -1
.Node123:
	db DEDGE_WARP, 7
	dw 118
	db %00000
	db DEDGE_WARP, 8
	dw 337
	db %00000
	db -1
.Node124:
	db DEDGE_WARP, 1
	dw 126
	db %00000
	db -1
.Node125:
	db DEDGE_WARP, 2
	dw 355
	db %00000
	db -1
.Node126:
	db DEDGE_WARP, 1
	dw 121
	db %00000
	db DEDGE_WARP, 3
	dw 124
	db %00000
	db -1
.Node127:
	db DEDGE_WARP, 4
	dw 136
	db %00000
	db DEDGE_WALK, 0
	dw 128
	db %00010
	db -1
.Node128:
	db DEDGE_WARP, 2
	dw 28
	db %00000
	db DEDGE_WARP, 7
	dw 138
	db %00000
	db DEDGE_WALK, 0
	dw 127
	db %01010
	db -1
.Node129:
	db DEDGE_WARP, 9
	dw 133
	db %00000
	db -1
.Node130:
	db DEDGE_WARP, 8
	dw 133
	db %00000
	db -1
.Node131:
	db DEDGE_WARP, 1
	dw 28
	db %00000
	db DEDGE_WARP, 5
	dw 133
	db %00000
	db -1
.Node132:
	db DEDGE_WARP, 3
	dw 28
	db %00000
	db DEDGE_WARP, 6
	dw 133
	db %00000
	db -1
.Node133:
	db DEDGE_WARP, 1
	dw 131
	db %00000
	db DEDGE_WARP, 2
	dw 132
	db %00000
	db DEDGE_WARP, 3
	dw 130
	db %00000
	db DEDGE_WARP, 4
	dw 129
	db %00000
	db -1
.Node134:
	db DEDGE_WARP, 5
	dw 137
	db %00000
	db DEDGE_WARP, 6
	dw 135
	db %00000
	db DEDGE_WALK, 0
	dw 133
	db %00000
	db -1
.Node135:
	db DEDGE_WARP, 2
	dw 134
	db %00000
	db DEDGE_WALK, 0
	dw 136
	db %00010
	db -1
.Node136:
	db DEDGE_WARP, 1
	dw 127
	db %00000
	db DEDGE_WALK, 0
	dw 135
	db %00010
	db -1
.Node137:
	db DEDGE_WARP, 1
	dw 134
	db %00000
	db -1
.Node138:
	db DEDGE_WARP, 2
	dw 128
	db %00000
	db -1
.Node139:
	db DEDGE_WARP, 1
	dw 30
	db %00000
	db -1
.Node140:
	db DEDGE_WARP, 3
	dw 142
	db %00000
	db DEDGE_WALK, 0
	dw 139
	db %00000
	db -1
.Node141:
	db DEDGE_WARP, 2
	dw 234
	db %00000
	db DEDGE_WARP, 4
	dw 143
	db %00000
	db -1
.Node142:
	db DEDGE_WARP, 1
	dw 140
	db %00000
	db DEDGE_WARP, 2
	dw 144
	db %00000
	db -1
.Node143:
	db DEDGE_WARP, 7
	dw 141
	db %00000
	db DEDGE_WARP, 8
	dw 146
	db %00000
	db -1
.Node144:
	db DEDGE_WARP, 1
	dw 142
	db %00000
	db DEDGE_WARP, 2
	dw 147
	db %00000
	db -1
.Node145:
	db DEDGE_WALK, 0
	dw 144
	db %00000
	db -1
.Node146:
	db DEDGE_WARP, 1
	dw 143
	db %00000
	db DEDGE_WARP, 2
	dw 147
	db %00000
	db -1
.Node147:
	db DEDGE_WARP, 1
	dw 144
	db %00000
	db DEDGE_WARP, 2
	dw 146
	db %00000
	db -1
.Node148:
	db DEDGE_WARP, 1
	dw 529
	db %00000
	db DEDGE_WARP, 2
	dw 160
	db %00000
	db -1
.Node149:
	db DEDGE_WARP, 3
	dw 155
	db %00000
	db DEDGE_WARP, 4
	dw 157
	db %00000
	db -1
.Node150:
	db DEDGE_WARP, 2
	dw 161
	db %00000
	db -1
.Node151:
	db DEDGE_WARP, 3
	dw 160
	db %00000
	db -1
.Node152:
	db DEDGE_WARP, 1
	dw 528
	db %00000
	db DEDGE_WALK, 0
	dw 150
	db %00000
	db DEDGE_WALK, 0
	dw 151
	db %00000
	db -1
.Node153:
	db DEDGE_WARP, 1
	dw 530
	db %00000
	db DEDGE_WARP, 3
	dw 159
	db %00000
	db DEDGE_WALK, 0
	dw 154
	db %00010
	db -1
.Node154:
	db DEDGE_WARP, 2
	dw 163
	db %00000
	db DEDGE_WALK, 0
	dw 153
	db %00010
	db -1
.Node155:
	db DEDGE_WARP, 4
	dw 149
	db %00000
	db DEDGE_WALK, 0
	dw 156
	db %00010
	db -1
.Node156:
	db DEDGE_WARP, 5
	dw 165
	db %00000
	db DEDGE_WALK, 0
	dw 155
	db %00010
	db -1
.Node157:
	db DEDGE_WARP, 1
	dw 162
	db %00000
	db DEDGE_WARP, 2
	dw 149
	db %00000
	db -1
.Node158:
	db DEDGE_WARP, 1
	dw 531
	db %00000
	db DEDGE_WARP, 2
	dw 163
	db %00000
	db -1
.Node159:
	db DEDGE_WARP, 4
	dw 153
	db %00000
	db -1
.Node160:
	db DEDGE_WARP, 1
	dw 148
	db %00000
	db DEDGE_WARP, 3
	dw 151
	db %00000
	db DEDGE_WARP, 8
	dw 167
	db %00000
	db DEDGE_WALK, 0
	dw 159
	db %00000
	db -1
.Node161:
	db DEDGE_WARP, 2
	dw 150
	db %00000
	db DEDGE_WARP, 7
	dw 164
	db %00000
	db -1
.Node162:
	db DEDGE_WARP, 9
	dw 157
	db %00000
	db DEDGE_WALK, 0
	dw 159
	db %00000
	db -1
.Node163:
	db DEDGE_WARP, 5
	dw 154
	db %00000
	db DEDGE_WARP, 6
	dw 158
	db %00000
	db -1
.Node164:
	db DEDGE_WARP, 1
	dw 161
	db %00000
	db DEDGE_WALK, 0
	dw 165
	db %00010
	db DEDGE_WALK, 0
	dw 166
	db %00010
	db -1
.Node165:
	db DEDGE_WARP, 4
	dw 156
	db %00000
	db DEDGE_WALK, 0
	dw 164
	db %01010
	db DEDGE_WALK, 0
	dw 166
	db %00010
	db -1
.Node166:
	db DEDGE_WARP, 3
	dw 168
	db %00000
	db DEDGE_WALK, 0
	dw 164
	db %01010
	db DEDGE_WALK, 0
	dw 165
	db %00010
	db -1
.Node167:
	db DEDGE_WARP, 2
	dw 160
	db %00000
	db -1
.Node168:
	db DEDGE_WARP, 1
	dw 166
	db %00000
	db -1
.Node169:
	db DEDGE_WARP, 1
	dw 485
	db %00000
	db DEDGE_WARP, 2
	dw 171
	db %00000
	db -1
.Node170:
	db DEDGE_WARP, 4
	dw 175
	db %00000
	db DEDGE_WALK, 0
	dw 171
	db %00010
	db DEDGE_WALK, 0
	dw 172
	db %01010
	db -1
.Node171:
	db DEDGE_WARP, 1
	dw 169
	db %00000
	db DEDGE_WARP, 2
	dw 173
	db %00000
	db DEDGE_WALK, 0
	dw 170
	db %01010
	db DEDGE_WALK, 0
	dw 172
	db %01010
	db -1
.Node172:
	db DEDGE_WARP, 3
	dw 174
	db %00000
	db DEDGE_WALK, 0
	dw 170
	db %01010
	db DEDGE_WALK, 0
	dw 171
	db %00010
	db -1
.Node173:
	db DEDGE_WARP, 1
	dw 171
	db %00000
	db -1
.Node174:
	db DEDGE_WARP, 1
	dw 172
	db %00000
	db -1
.Node175:
	db DEDGE_WARP, 2
	dw 170
	db %00000
	db -1
.Node176:
	db DEDGE_WARP, 2
	dw 179
	db %00000
	db DEDGE_WALK, 0
	dw 177
	db %00010
	db DEDGE_WALK, 0
	dw 178
	db %10010
	db -1
.Node177:
	db DEDGE_WARP, 1
	dw 613
	db %00000
	db DEDGE_WALK, 0
	dw 176
	db %00010
	db DEDGE_WALK, 0
	dw 178
	db %10000
	db -1
.Node178:
	db DEDGE_WARP, 3
	dw 232
	db %00000
	db DEDGE_WALK, 0
	dw 176
	db %10010
	db DEDGE_WALK, 0
	dw 177
	db %10000
	db -1
.Node179:
	db DEDGE_WARP, 2
	dw 176
	db %00000
	db -1
.Node180:
	db DEDGE_WARP, 1
	dw 229
	db %00000
	db DEDGE_WALK, 0
	dw 179
	db %00010
	db -1
.Node181:
	db DEDGE_WARP, 1
	dw 234
	db %00000
	db DEDGE_WARP, 2
	dw 182
	db %00000
	db -1
.Node182:
	db DEDGE_WARP, 3
	dw 183
	db %00000
	db DEDGE_WARP, 4
	dw 181
	db %00000
	db -1
.Node183:
	db DEDGE_WARP, 1
	dw 182
	db %00000
	db DEDGE_WALK, 0
	dw 184
	db %00110
	db -1
.Node184:
	db DEDGE_WARP, 2
	dw 185
	db %00000
	db DEDGE_WALK, 0
	dw 183
	db %00110
	db -1
.Node185:
	db DEDGE_WARP, 1
	dw 184
	db %00000
	db -1
.Node186:
	db DEDGE_WARP, 1
	dw 568
	db %00000
	db DEDGE_WALK, 0
	dw 187
	db %01010
	db -1
.Node187:
	db DEDGE_WARP, 2
	dw 568
	db %00000
	db DEDGE_WALK, 0
	dw 186
	db %01010
	db -1
.Node188:
	db DEDGE_WARP, 5
	dw 190
	db %00000
	db DEDGE_WARP, 6
	dw 189
	db %00000
	db -1
.Node189:
	db DEDGE_WARP, 3
	dw 542
	db %00000
	db DEDGE_WARP, 4
	dw 188
	db %00000
	db -1
.Node190:
	db DEDGE_WARP, 1
	dw 367
	db %00000
	db DEDGE_WARP, 2
	dw 188
	db %00000
	db -1
.Node191:
	db DEDGE_WARP, 1
	dw 396
	db %00000
	db DEDGE_WARP, 2
	dw 260
	db %00000
	db DEDGE_WARP, 3
	dw 192
	db %00000
	db -1
.Node192:
	db DEDGE_WARP, 5
	dw 425
	db %00000
	db DEDGE_WARP, 7
	dw 191
	db %00000
	db -1
.Node193:
	db DEDGE_WARP, 4
	dw 194
	db %00000
	db DEDGE_WALK, 0
	dw 191
	db %00000
	db -1
.Node194:
	db DEDGE_WARP, 6
	dw 425
	db %00000
	db DEDGE_WARP, 8
	dw 193
	db %00000
	db -1
.Node195:
	db DEDGE_WARP, 1
	dw 609
	db %00000
	db DEDGE_WARP, 2
	dw 378
	db %00000
	db -1
.Node196:
	db DEDGE_WARP, 3
	dw 200
	db %00000
	db DEDGE_WARP, 4
	dw 199
	db %00000
	db -1
.Node197:
	db DEDGE_WARP, 1
	dw 269
	db %00000
	db DEDGE_WARP, 5
	dw 200
	db %00000
	db -1
.Node198:
	db DEDGE_WARP, 2
	dw 468
	db %00000
	db DEDGE_WARP, 6
	dw 199
	db %00000
	db -1
.Node199:
	db DEDGE_WARP, 1
	dw 198
	db %00000
	db DEDGE_WARP, 2
	dw 196
	db %00000
	db -1
.Node200:
	db DEDGE_WARP, 3
	dw 196
	db %00000
	db DEDGE_WARP, 4
	dw 197
	db %00000
	db -1
.Node201:
	db DEDGE_WARP, 1
	dw 202
	db %00000
	db -1
.Node202:
	db DEDGE_WARP, 1
	dw 201
	db %00000
	db -1
.Node203:
	db DEDGE_WARP, 7
	dw 207
	db %00000
	db -1
.Node204:
	db DEDGE_WARP, 5
	dw 205
	db %00000
	db DEDGE_WARP, 10
	dw 428
	db %00000
	db DEDGE_WALK, 0
	dw 203
	db %00000
	db -1
.Node205:
	db DEDGE_WARP, 3
	dw 208
	db %00000
	db DEDGE_WARP, 4
	dw 204
	db %00000
	db -1
.Node206:
	db DEDGE_WALK, 0
	dw 205
	db %00000
	db -1
.Node207:
	db DEDGE_WARP, 6
	dw 203
	db %00000
	db DEDGE_WALK, 0
	dw 205
	db %00000
	db -1
.Node208:
	db DEDGE_WARP, 1
	dw 562
	db %00000
	db DEDGE_WARP, 2
	dw 205
	db %00000
	db -1
.Node209:
	db DEDGE_WARP, 1
	dw 219
	db %00000
	db DEDGE_WARP, 3
	dw 210
	db %00000
	db -1
.Node210:
	db DEDGE_WARP, 4
	dw 209
	db %00000
	db DEDGE_WARP, 5
	dw 211
	db %00000
	db -1
.Node211:
	db DEDGE_WARP, 1
	dw 218
	db %00000
	db DEDGE_WARP, 3
	dw 210
	db %00000
	db -1
.Node212:
	db DEDGE_WARP, 1
	dw 219
	db %00000
	db -1
.Node213:
	db DEDGE_WARP, 1
	dw 219
	db %00000
	db -1
.Node214:
	db DEDGE_WARP, 1
	dw 219
	db %00000
	db -1
.Node215:
	db DEDGE_WARP, 1
	dw 219
	db %00000
	db -1
.Node216:
	db DEDGE_WARP, 1
	dw 219
	db %00000
	db DEDGE_WARP, 8
	dw 216
	db %00000
	db -1
.Node217:
	db DEDGE_WARP, 1
	dw 219
	db %00000
	db -1
.Node218:
	db DEDGE_WARP, 4
	dw 211
	db %00000
	db DEDGE_WARP, 12
	dw 40
	db %00000
	db -1
.Node219:
	db DEDGE_WARP, 1
	dw 27
	db %00000
	db DEDGE_WARP, 3
	dw 209
	db %00000
	db DEDGE_WARP, 6
	dw 212
	db %00000
	db DEDGE_WARP, 7
	dw 213
	db %00000
	db DEDGE_WARP, 8
	dw 214
	db %00000
	db DEDGE_WARP, 9
	dw 215
	db %00000
	db DEDGE_WARP, 10
	dw 216
	db %00000
	db DEDGE_WARP, 11
	dw 217
	db %00000
	db DEDGE_WARP, 13
	dw 58
	db %00000
	db DEDGE_WARP, 14
	dw 8
	db %00000
	db DEDGE_EDGE, 0
	dw 317
	db %00000
	db -1
.Node220:
	db DEDGE_WARP, 1
	dw 234
	db %00000
	db DEDGE_WARP, 3
	dw 222
	db %00000
	db -1
.Node221:
	db DEDGE_WARP, 4
	dw 222
	db %00000
	db -1
.Node222:
	db DEDGE_WARP, 1
	dw 220
	db %00000
	db DEDGE_WARP, 2
	dw 221
	db %00000
	db -1
.Node223:
	db DEDGE_WARP, 1
	dw 234
	db %00000
	db -1
.Node224:
	db DEDGE_WARP, 1
	dw 234
	db %00000
	db -1
.Node225:
	db DEDGE_WARP, 1
	dw 234
	db %00000
	db -1
.Node226:
	db DEDGE_WARP, 1
	dw 234
	db %00000
	db -1
.Node227:
	db DEDGE_WARP, 1
	dw 234
	db %00000
	db -1
.Node228:
	db DEDGE_EDGE, 2
	dw 232
	db %00000
	db -1
.Node229:
	db DEDGE_WARP, 1
	dw 180
	db %00000
	db DEDGE_EDGE, 1
	dw 234
	db %00000
	db DEDGE_EDGE, 2
	dw 232
	db %00000
	db DEDGE_WALK, 0
	dw 228
	db %00000
	db -1
.Node230:
	db DEDGE_EDGE, 1
	dw 234
	db %00000
	db DEDGE_EDGE, 2
	dw 233
	db %00000
	db -1
.Node231:
	db DEDGE_WARP, 1
	dw 586
	db %00000
	db -1
.Node232:
	db DEDGE_WARP, 3
	dw 178
	db %00000
	db DEDGE_EDGE, 3
	dw 229
	db %00000
	db DEDGE_EDGE, 3
	dw 228
	db %00000
	db DEDGE_WALK, 0
	dw 231
	db %00000
	db -1
.Node233:
	db DEDGE_EDGE, 3
	dw 230
	db %00000
	db -1
.Node234:
	db DEDGE_WARP, 1
	dw 220
	db %00000
	db DEDGE_WARP, 2
	dw 223
	db %00000
	db DEDGE_WARP, 3
	dw 224
	db %00000
	db DEDGE_WARP, 4
	dw 225
	db %00000
	db DEDGE_WARP, 5
	dw 226
	db %00000
	db DEDGE_WARP, 6
	dw 227
	db %00000
	db DEDGE_WARP, 7
	dw 141
	db %00000
	db DEDGE_WARP, 8
	dw 181
	db %00000
	db DEDGE_EDGE, 0
	dw 229
	db %00000
	db DEDGE_EDGE, 0
	dw 230
	db %00000
	db DEDGE_EDGE, 2
	dw 30
	db %00000
	db -1
.Node235:
	db DEDGE_WARP, 1
	dw 247
	db %00000
	db -1
.Node236:
	db DEDGE_WARP, 1
	dw 450
	db %00000
	db DEDGE_WARP, 3
	dw 241
	db %00000
	db -1
.Node237:
	db DEDGE_WARP, 1
	dw 243
	db %00000
	db -1
.Node238:
	db DEDGE_EDGE, 1
	dw 452
	db %00000
	db -1
.Node239:
	db DEDGE_EDGE, 1
	dw 450
	db %00000
	db -1
.Node240:
	db DEDGE_EDGE, 1
	dw 451
	db %00000
	db -1
.Node241:
	db DEDGE_WARP, 1
	dw 236
	db %00000
	db DEDGE_WALK, 0
	dw 242
	db %00010
	db -1
.Node242:
	db DEDGE_EDGE, 2
	dw 244
	db %00000
	db DEDGE_WALK, 0
	dw 241
	db %00000
	db -1
.Node243:
	db DEDGE_WARP, 1
	dw 237
	db %00000
	db DEDGE_WALK, 0
	dw 244
	db %00010
	db -1
.Node244:
	db DEDGE_EDGE, 2
	dw 248
	db %00000
	db DEDGE_EDGE, 3
	dw 242
	db %00000
	db DEDGE_WALK, 0
	dw 243
	db %00000
	db -1
.Node245:
	db DEDGE_EDGE, 1
	dw 391
	db %00000
	db DEDGE_EDGE, 0
	dw 248
	db %00000
	db DEDGE_EDGE, 0
	dw 249
	db %00000
	db -1
.Node246:
	db DEDGE_EDGE, 0
	dw 249
	db %00000
	db -1
.Node247:
	db DEDGE_WARP, 1
	dw 235
	db %00000
	db DEDGE_WALK, 0
	dw 248
	db %00010
	db -1
.Node248:
	db DEDGE_EDGE, 1
	dw 245
	db %00000
	db DEDGE_EDGE, 3
	dw 244
	db %00000
	db DEDGE_WALK, 0
	dw 247
	db %00000
	db -1
.Node249:
	db DEDGE_EDGE, 1
	dw 245
	db %00000
	db DEDGE_EDGE, 1
	dw 246
	db %00000
	db -1
.Node250:
	db DEDGE_WARP, 1
	dw 287
	db %00000
	db -1
.Node251:
	db DEDGE_WARP, 1
	dw 287
	db %00000
	db -1
.Node252:
	db DEDGE_WARP, 1
	dw 287
	db %00000
	db -1
.Node253:
	db DEDGE_WARP, 1
	dw 287
	db %00000
	db -1
.Node254:
	db DEDGE_WARP, 1
	dw 287
	db %00000
	db -1
.Node255:
	db DEDGE_WARP, 1
	dw 287
	db %00000
	db -1
.Node256:
	db DEDGE_WARP, 1
	dw 271
	db %00000
	db -1
.Node257:
	db DEDGE_WARP, 1
	dw 272
	db %00000
	db -1
.Node258:
	db DEDGE_WARP, 1
	dw 282
	db %00000
	db -1
.Node259:
	db DEDGE_EDGE, 3
	dw 287
	db %00000
	db -1
.Node260:
	db DEDGE_WARP, 1
	dw 191
	db %00000
	db DEDGE_EDGE, 2
	dw 396
	db %00000
	db DEDGE_EDGE, 3
	dw 285
	db %00000
	db DEDGE_EDGE, 3
	dw 291
	db %00000
	db DEDGE_WALK, 0
	dw 259
	db %00000
	db -1
.Node261:
	db DEDGE_EDGE, 3
	dw 286
	db %00000
	db -1
.Node262:
	db DEDGE_EDGE, 3
	dw 291
	db %00000
	db -1
.Node263:
	db DEDGE_EDGE, 2
	dw 289
	db %00000
	db -1
.Node264:
	db DEDGE_EDGE, 0
	dw 270
	db %00000
	db -1
.Node265:
	db DEDGE_EDGE, 0
	dw 271
	db %00000
	db DEDGE_WALK, 0
	dw 266
	db %00010
	db DEDGE_WALK, 0
	dw 267
	db %00001
	db -1
.Node266:
	db DEDGE_EDGE, 0
	dw 273
	db %00000
	db DEDGE_WALK, 0
	dw 265
	db %00000
	db DEDGE_WALK, 0
	dw 267
	db %00001
	db -1
.Node267:
	db DEDGE_EDGE, 2
	dw 287
	db %00000
	db DEDGE_WALK, 0
	dw 265
	db %00001
	db DEDGE_WALK, 0
	dw 266
	db %00011
	db -1
.Node268:
	db DEDGE_EDGE, 2
	dw 292
	db %00000
	db -1
.Node269:
	db DEDGE_WARP, 1
	dw 197
	db %00000
	db DEDGE_EDGE, 0
	dw 270
	db %00000
	db DEDGE_EDGE, 0
	dw 271
	db %00000
	db -1
.Node270:
	db DEDGE_EDGE, 1
	dw 269
	db %00000
	db DEDGE_EDGE, 1
	dw 264
	db %00000
	db DEDGE_EDGE, 0
	dw 468
	db %00000
	db -1
.Node271:
	db DEDGE_WARP, 1
	dw 256
	db %00000
	db DEDGE_EDGE, 1
	dw 269
	db %00000
	db DEDGE_EDGE, 1
	dw 265
	db %00000
	db -1
.Node272:
	db DEDGE_WARP, 2
	dw 257
	db %00000
	db DEDGE_WALK, 0
	dw 273
	db %00010
	db -1
.Node273:
	db DEDGE_EDGE, 1
	dw 266
	db %00000
	db DEDGE_WALK, 0
	dw 272
	db %00000
	db -1
.Node274:
	db DEDGE_EDGE, 1
	dw 281
	db %00000
	db DEDGE_EDGE, 0
	dw 285
	db %00000
	db -1
.Node275:
	db DEDGE_EDGE, 1
	dw 282
	db %00000
	db DEDGE_WALK, 0
	dw 276
	db %00010
	db -1
.Node276:
	db DEDGE_EDGE, 1
	dw 284
	db %00000
	db DEDGE_EDGE, 0
	dw 286
	db %00000
	db DEDGE_WALK, 0
	dw 275
	db %00000
	db -1
.Node277:
	db DEDGE_EDGE, 1
	dw 282
	db %00000
	db DEDGE_EDGE, 0
	dw 287
	db %00000
	db -1
.Node278:
	db DEDGE_EDGE, 1
	dw 282
	db %00000
	db DEDGE_EDGE, 0
	dw 288
	db %00000
	db -1
.Node279:
	db DEDGE_EDGE, 1
	dw 283
	db %00000
	db -1
.Node280:
	db DEDGE_EDGE, 0
	dw 290
	db %00000
	db -1
.Node281:
	db DEDGE_EDGE, 0
	dw 274
	db %00000
	db -1
.Node282:
	db DEDGE_WARP, 1
	dw 258
	db %00000
	db DEDGE_EDGE, 0
	dw 275
	db %00000
	db DEDGE_EDGE, 0
	dw 277
	db %00000
	db DEDGE_EDGE, 0
	dw 278
	db %00000
	db DEDGE_WALK, 0
	dw 284
	db %00010
	db -1
.Node283:
	db DEDGE_EDGE, 0
	dw 279
	db %00000
	db -1
.Node284:
	db DEDGE_EDGE, 0
	dw 276
	db %00000
	db DEDGE_WALK, 0
	dw 282
	db %00000
	db -1
.Node285:
	db DEDGE_EDGE, 1
	dw 274
	db %00000
	db DEDGE_EDGE, 2
	dw 260
	db %00000
	db -1
.Node286:
	db DEDGE_EDGE, 1
	dw 276
	db %00000
	db DEDGE_EDGE, 2
	dw 261
	db %00000
	db -1
.Node287:
	db DEDGE_WARP, 1
	dw 250
	db %00000
	db DEDGE_WARP, 2
	dw 251
	db %00000
	db DEDGE_WARP, 3
	dw 252
	db %00000
	db DEDGE_WARP, 4
	dw 253
	db %00000
	db DEDGE_WARP, 5
	dw 254
	db %00000
	db DEDGE_WARP, 6
	dw 255
	db %00000
	db DEDGE_EDGE, 1
	dw 277
	db %00000
	db DEDGE_EDGE, 0
	dw 587
	db %00000
	db DEDGE_EDGE, 0
	dw 589
	db %00000
	db DEDGE_EDGE, 2
	dw 259
	db %00000
	db DEDGE_EDGE, 3
	dw 267
	db %00000
	db -1
.Node288:
	db DEDGE_EDGE, 1
	dw 278
	db %00000
	db DEDGE_WALK, 0
	dw 287
	db %00000
	db -1
.Node289:
	db DEDGE_EDGE, 3
	dw 263
	db %00000
	db DEDGE_WALK, 0
	dw 290
	db %00010
	db -1
.Node290:
	db DEDGE_EDGE, 1
	dw 280
	db %00000
	db DEDGE_WALK, 0
	dw 289
	db %00000
	db -1
.Node291:
	db DEDGE_EDGE, 2
	dw 262
	db %00000
	db DEDGE_EDGE, 2
	dw 260
	db %00000
	db -1
.Node292:
	db DEDGE_EDGE, 3
	dw 268
	db %00000
	db -1
.Node293:
	db DEDGE_WARP, 1
	dw 299
	db %00000
	db -1
.Node294:
	db DEDGE_WARP, 1
	dw 299
	db %00000
	db -1
.Node295:
	db DEDGE_WARP, 1
	dw 299
	db %00000
	db -1
.Node296:
	db DEDGE_WARP, 1
	dw 299
	db %00000
	db -1
.Node297:
	db DEDGE_WARP, 1
	dw 299
	db %00000
	db -1
.Node298:
	db DEDGE_WARP, 1
	dw 89
	db %00000
	db DEDGE_EDGE, 1
	dw 311
	db %00000
	db DEDGE_EDGE, 2
	dw 300
	db %00000
	db DEDGE_EDGE, 2
	dw 299
	db %00000
	db -1
.Node299:
	db DEDGE_WARP, 1
	dw 293
	db %00000
	db DEDGE_WARP, 2
	dw 294
	db %00000
	db DEDGE_WARP, 3
	dw 295
	db %00000
	db DEDGE_WARP, 4
	dw 296
	db %00000
	db DEDGE_WARP, 5
	dw 297
	db %00000
	db DEDGE_WARP, 6
	dw 97
	db %00000
	db DEDGE_WARP, 7
	dw 359
	db %00000
	db DEDGE_EDGE, 3
	dw 298
	db %00000
	db -1
.Node300:
	db DEDGE_EDGE, 3
	dw 298
	db %00000
	db -1
.Node301:
	db DEDGE_WARP, 1
	dw 308
	db %00000
	db -1
.Node302:
	db DEDGE_WARP, 1
	dw 309
	db %00000
	db -1
.Node303:
	db DEDGE_WARP, 1
	dw 305
	db %00000
	db DEDGE_WARP, 3
	dw 32
	db %00000
	db -1
.Node304:
	db DEDGE_WARP, 1
	dw 305
	db %00000
	db -1
.Node305:
	db DEDGE_WARP, 1
	dw 303
	db %00000
	db DEDGE_WARP, 3
	dw 304
	db %00000
	db DEDGE_EDGE, 1
	dw 310
	db %00000
	db DEDGE_EDGE, 1
	dw 309
	db %00000
	db -1
.Node306:
	db DEDGE_EDGE, 0
	dw 31
	db %00000
	db -1
.Node307:
	db DEDGE_EDGE, 0
	dw 33
	db %00000
	db -1
.Node308:
	db DEDGE_WARP, 1
	dw 301
	db %00000
	db DEDGE_WALK, 0
	dw 310
	db %00001
	db -1
.Node309:
	db DEDGE_WARP, 2
	dw 302
	db %00000
	db DEDGE_EDGE, 0
	dw 305
	db %00000
	db -1
.Node310:
	db DEDGE_EDGE, 0
	dw 305
	db %00000
	db DEDGE_WALK, 0
	dw 308
	db %00001
	db -1
.Node311:
	db DEDGE_WARP, 1
	dw 326
	db %00000
	db DEDGE_WARP, 2
	dw 325
	db %00000
	db DEDGE_WARP, 4
	dw 89
	db %00000
	db DEDGE_EDGE, 1
	dw 318
	db %00000
	db DEDGE_EDGE, 0
	dw 298
	db %00000
	db -1
.Node312:
	db DEDGE_EDGE, 1
	dw 316
	db %00000
	db DEDGE_WALK, 0
	dw 313
	db %00001
	db -1
.Node313:
	db DEDGE_WARP, 1
	dw 327
	db %00000
	db DEDGE_WARP, 3
	dw 328
	db %00000
	db DEDGE_WALK, 0
	dw 312
	db %00001
	db -1
.Node314:
	db DEDGE_EDGE, 0
	dw 336
	db %00000
	db -1
.Node315:
	db DEDGE_EDGE, 0
	dw 338
	db %00000
	db -1
.Node316:
	db DEDGE_WARP, 1
	dw 330
	db %00000
	db DEDGE_WARP, 3
	dw 329
	db %00000
	db DEDGE_EDGE, 1
	dw 317
	db %00000
	db DEDGE_EDGE, 0
	dw 312
	db %00000
	db DEDGE_EDGE, 3
	dw 318
	db %00000
	db -1
.Node317:
	db DEDGE_EDGE, 1
	dw 219
	db %00000
	db DEDGE_EDGE, 0
	dw 316
	db %00000
	db -1
.Node318:
	db DEDGE_WARP, 1
	dw 319
	db %00000
	db DEDGE_WARP, 2
	dw 320
	db %00000
	db DEDGE_WARP, 3
	dw 321
	db %00000
	db DEDGE_WARP, 4
	dw 322
	db %00000
	db DEDGE_WARP, 5
	dw 323
	db %00000
	db DEDGE_WARP, 6
	dw 324
	db %00000
	db DEDGE_WARP, 7
	dw 36
	db %00000
	db DEDGE_WARP, 8
	dw 622
	db %00000
	db DEDGE_EDGE, 0
	dw 311
	db %00000
	db DEDGE_EDGE, 2
	dw 316
	db %00000
	db -1
.Node319:
	db DEDGE_WARP, 1
	dw 318
	db %00000
	db -1
.Node320:
	db DEDGE_WARP, 1
	dw 318
	db %00000
	db -1
.Node321:
	db DEDGE_WARP, 1
	dw 318
	db %00000
	db -1
.Node322:
	db DEDGE_WARP, 1
	dw 318
	db %00000
	db -1
.Node323:
	db DEDGE_WARP, 1
	dw 318
	db %00000
	db -1
.Node324:
	db DEDGE_WARP, 1
	dw 318
	db %00000
	db -1
.Node325:
	db DEDGE_WARP, 1
	dw 72
	db %00000
	db DEDGE_WARP, 3
	dw 311
	db %00000
	db -1
.Node326:
	db DEDGE_WARP, 1
	dw 311
	db %00000
	db -1
.Node327:
	db DEDGE_WARP, 1
	dw 313
	db %00000
	db DEDGE_WARP, 3
	dw 337
	db %00000
	db -1
.Node328:
	db DEDGE_WARP, 1
	dw 63
	db %00000
	db DEDGE_WARP, 3
	dw 313
	db %00000
	db -1
.Node329:
	db DEDGE_WARP, 1
	dw 316
	db %00000
	db DEDGE_WARP, 3
	dw 72
	db %00000
	db -1
.Node330:
	db DEDGE_WARP, 1
	dw 63
	db %00000
	db DEDGE_WARP, 3
	dw 316
	db %00000
	db -1
.Node331:
	db DEDGE_EDGE, 1
	dw 339
	db %00000
	db DEDGE_WALK, 0
	dw 332
	db %00010
	db -1
.Node332:
	db DEDGE_EDGE, 1
	dw 339
	db %00000
	db DEDGE_WALK, 0
	dw 331
	db %00000
	db -1
.Node333:
	db DEDGE_WARP, 1
	dw 360
	db %00000
	db DEDGE_WARP, 3
	dw 361
	db %00000
	db DEDGE_EDGE, 1
	dw 337
	db %00000
	db -1
.Node334:
	db DEDGE_EDGE, 1
	dw 340
	db %00000
	db -1
.Node335:
	db DEDGE_WARP, 5
	dw 361
	db %00000
	db -1
.Node336:
	db DEDGE_EDGE, 1
	dw 314
	db %00000
	db -1
.Node337:
	db DEDGE_WARP, 1
	dw 341
	db %00000
	db DEDGE_WARP, 2
	dw 342
	db %00000
	db DEDGE_WARP, 3
	dw 343
	db %00000
	db DEDGE_WARP, 4
	dw 344
	db %00000
	db DEDGE_WARP, 5
	dw 345
	db %00000
	db DEDGE_WARP, 6
	dw 346
	db %00000
	db DEDGE_WARP, 7
	dw 347
	db %00000
	db DEDGE_WARP, 8
	dw 348
	db %00000
	db DEDGE_WARP, 9
	dw 349
	db %00000
	db DEDGE_WARP, 10
	dw 357
	db %00000
	db DEDGE_WARP, 11
	dw 64
	db %00000
	db DEDGE_WARP, 12
	dw 327
	db %00000
	db DEDGE_WARP, 13
	dw 123
	db %00000
	db DEDGE_WARP, 14
	dw 122
	db %00000
	db DEDGE_WARP, 15
	dw 358
	db %00000
	db DEDGE_EDGE, 0
	dw 333
	db %00000
	db -1
.Node338:
	db DEDGE_EDGE, 1
	dw 315
	db %00000
	db -1
.Node339:
	db DEDGE_EDGE, 0
	dw 332
	db %00000
	db DEDGE_EDGE, 0
	dw 331
	db %00000
	db -1
.Node340:
	db DEDGE_EDGE, 0
	dw 334
	db %00000
	db -1
.Node341:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db -1
.Node342:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db -1
.Node343:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db -1
.Node344:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db -1
.Node345:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db DEDGE_WARP, 3
	dw 605
	db %00000
	db -1
.Node346:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db -1
.Node347:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db -1
.Node348:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db -1
.Node349:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db DEDGE_WARP, 3
	dw 350
	db %00000
	db DEDGE_WARP, 4
	dw 355
	db %00000
	db -1
.Node350:
	db DEDGE_WARP, 1
	dw 351
	db %00000
	db DEDGE_WARP, 2
	dw 349
	db %00000
	db DEDGE_WARP, 3
	dw 355
	db %00000
	db -1
.Node351:
	db DEDGE_WARP, 1
	dw 350
	db %00000
	db DEDGE_WARP, 2
	dw 352
	db %00000
	db DEDGE_WARP, 3
	dw 355
	db %00000
	db -1
.Node352:
	db DEDGE_WARP, 1
	dw 353
	db %00000
	db DEDGE_WARP, 2
	dw 351
	db %00000
	db DEDGE_WARP, 3
	dw 355
	db %00000
	db -1
.Node353:
	db DEDGE_WARP, 1
	dw 352
	db %00000
	db DEDGE_WARP, 2
	dw 354
	db %00000
	db DEDGE_WARP, 3
	dw 355
	db %00000
	db -1
.Node354:
	db DEDGE_WARP, 1
	dw 353
	db %00000
	db DEDGE_WARP, 2
	dw 355
	db %00000
	db DEDGE_WARP, 3
	dw 356
	db %00000
	db -1
.Node355:
	db DEDGE_WARP, 1
	dw 349
	db %00000
	db -1
.Node356:
	db DEDGE_WARP, 1
	dw 354
	db %00000
	db -1
.Node357:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db -1
.Node358:
	db DEDGE_WARP, 1
	dw 337
	db %00000
	db -1
.Node359:
	db DEDGE_WARP, 1
	dw 117
	db %00000
	db DEDGE_WARP, 3
	dw 299
	db %00000
	db -1
.Node360:
	db DEDGE_WARP, 1
	dw 333
	db %00000
	db DEDGE_WARP, 3
	dw 116
	db %00000
	db -1
.Node361:
	db DEDGE_WARP, 1
	dw 333
	db %00000
	db DEDGE_WARP, 3
	dw 335
	db %00000
	db -1
.Node362:
	db DEDGE_WARP, 1
	dw 378
	db %00000
	db DEDGE_WARP, 2
	dw 377
	db %00000
	db DEDGE_EDGE, 0
	dw 367
	db %00000
	db -1
.Node363:
	db DEDGE_EDGE, 0
	dw 366
	db %00000
	db -1
.Node364:
	db DEDGE_EDGE, 0
	dw 368
	db %00000
	db -1
.Node365:
	db DEDGE_EDGE, 2
	dw 367
	db %00000
	db DEDGE_EDGE, 3
	dw 464
	db %00000
	db -1
.Node366:
	db DEDGE_EDGE, 1
	dw 363
	db %00000
	db -1
.Node367:
	db DEDGE_WARP, 1
	dw 370
	db %00000
	db DEDGE_WARP, 2
	dw 371
	db %00000
	db DEDGE_WARP, 3
	dw 372
	db %00000
	db DEDGE_WARP, 4
	dw 373
	db %00000
	db DEDGE_WARP, 5
	dw 374
	db %00000
	db DEDGE_WARP, 6
	dw 375
	db %00000
	db DEDGE_WARP, 8
	dw 424
	db %00000
	db DEDGE_WARP, 10
	dw 190
	db %00000
	db DEDGE_EDGE, 1
	dw 362
	db %00000
	db DEDGE_EDGE, 3
	dw 365
	db %00000
	db DEDGE_WALK, 0
	dw 369
	db %00001
	db DEDGE_WALK, 0
	dw 369
	db %00010
	db -1
.Node368:
	db DEDGE_EDGE, 1
	dw 364
	db %00000
	db -1
.Node369:
	db DEDGE_WARP, 7
	dw 376
	db %00000
	db DEDGE_WALK, 0
	dw 367
	db %00001
	db DEDGE_WALK, 0
	dw 367
	db %00010
	db -1
.Node370:
	db DEDGE_WARP, 1
	dw 367
	db %00000
	db -1
.Node371:
	db DEDGE_WARP, 1
	dw 367
	db %00000
	db -1
.Node372:
	db DEDGE_WARP, 1
	dw 367
	db %00000
	db -1
.Node373:
	db DEDGE_WARP, 1
	dw 367
	db %00000
	db -1
.Node374:
	db DEDGE_WARP, 1
	dw 367
	db %00000
	db -1
.Node375:
	db DEDGE_WARP, 1
	dw 367
	db %00000
	db -1
.Node376:
	db DEDGE_WARP, 1
	dw 369
	db %00000
	db -1
.Node377:
	db DEDGE_WARP, 1
	dw 590
	db %00000
	db DEDGE_WARP, 3
	dw 362
	db %00000
	db -1
.Node378:
	db DEDGE_WARP, 1
	dw 362
	db %00000
	db DEDGE_WARP, 3
	dw 195
	db %00000
	db -1
.Node379:
	db DEDGE_EDGE, 1
	dw 550
	db %00000
	db DEDGE_EDGE, 0
	dw 386
	db %00000
	db -1
.Node380:
	db DEDGE_EDGE, 1
	dw 551
	db %00000
	db -1
.Node381:
	db DEDGE_EDGE, 1
	dw 548
	db %00000
	db DEDGE_EDGE, 0
	dw 388
	db %00000
	db -1
.Node382:
	db DEDGE_EDGE, 1
	dw 552
	db %00000
	db -1
.Node383:
	db DEDGE_EDGE, 1
	dw 553
	db %00000
	db DEDGE_EDGE, 0
	dw 389
	db %00000
	db DEDGE_EDGE, 0
	dw 390
	db %00000
	db -1
.Node384:
	db DEDGE_EDGE, 0
	dw 386
	db %00000
	db DEDGE_EDGE, 0
	dw 387
	db %00000
	db -1
.Node385:
	db DEDGE_EDGE, 0
	dw 389
	db %00000
	db -1
.Node386:
	db DEDGE_EDGE, 1
	dw 379
	db %00000
	db DEDGE_EDGE, 1
	dw 384
	db %00000
	db -1
.Node387:
	db DEDGE_EDGE, 1
	dw 384
	db %00000
	db -1
.Node388:
	db DEDGE_WARP, 1
	dw 392
	db %00000
	db DEDGE_WARP, 2
	dw 394
	db %00000
	db DEDGE_WARP, 3
	dw 395
	db %00000
	db DEDGE_EDGE, 1
	dw 381
	db %00000
	db DEDGE_WALK, 0
	dw 391
	db %00010
	db -1
.Node389:
	db DEDGE_EDGE, 1
	dw 385
	db %00000
	db DEDGE_EDGE, 1
	dw 383
	db %00000
	db -1
.Node390:
	db DEDGE_EDGE, 1
	dw 383
	db %00000
	db -1
.Node391:
	db DEDGE_EDGE, 0
	dw 245
	db %00000
	db DEDGE_WALK, 0
	dw 388
	db %00000
	db -1
.Node392:
	db DEDGE_WARP, 1
	dw 388
	db %00000
	db DEDGE_WARP, 3
	dw 393
	db %00000
	db -1
.Node393:
	db DEDGE_WARP, 1
	dw 392
	db %00000
	db -1
.Node394:
	db DEDGE_WARP, 1
	dw 388
	db %00000
	db -1
.Node395:
	db DEDGE_WARP, 1
	dw 388
	db %00000
	db -1
.Node396:
	db DEDGE_WARP, 1
	dw 191
	db %00000
	db DEDGE_EDGE, 2
	dw 399
	db %00000
	db DEDGE_EDGE, 2
	dw 398
	db %00000
	db DEDGE_EDGE, 3
	dw 260
	db %00000
	db -1
.Node397:
	db DEDGE_EDGE, 2
	dw 400
	db %00000
	db DEDGE_EDGE, 2
	dw 401
	db %00000
	db -1
.Node398:
	db DEDGE_WARP, 1
	dw 402
	db %00000
	db DEDGE_WARP, 2
	dw 403
	db %00000
	db DEDGE_WARP, 3
	dw 404
	db %00000
	db DEDGE_WARP, 4
	dw 405
	db %00000
	db DEDGE_WARP, 5
	dw 406
	db %00000
	db DEDGE_EDGE, 0
	dw 541
	db %00000
	db DEDGE_EDGE, 3
	dw 396
	db %00000
	db -1
.Node399:
	db DEDGE_EDGE, 3
	dw 396
	db %00000
	db -1
.Node400:
	db DEDGE_EDGE, 3
	dw 397
	db %00000
	db -1
.Node401:
	db DEDGE_EDGE, 3
	dw 397
	db %00000
	db -1
.Node402:
	db DEDGE_WARP, 1
	dw 398
	db %00000
	db -1
.Node403:
	db DEDGE_WARP, 1
	dw 398
	db %00000
	db -1
.Node404:
	db DEDGE_WARP, 1
	dw 398
	db %00000
	db -1
.Node405:
	db DEDGE_WARP, 1
	dw 398
	db %00000
	db -1
.Node406:
	db DEDGE_WARP, 1
	dw 398
	db %00000
	db -1
.Node407:
	db DEDGE_WARP, 1
	dw 421
	db %00000
	db DEDGE_WARP, 2
	dw 409
	db %00000
	db -1
.Node408:
	db DEDGE_WARP, 1
	dw 423
	db %00000
	db DEDGE_WARP, 2
	dw 409
	db %00000
	db -1
.Node409:
	db DEDGE_WARP, 1
	dw 410
	db %00000
	db DEDGE_WARP, 2
	dw 411
	db %00000
	db DEDGE_WARP, 3
	dw 412
	db %00000
	db DEDGE_WARP, 4
	dw 413
	db %00000
	db DEDGE_WARP, 5
	dw 414
	db %00000
	db DEDGE_WARP, 6
	dw 415
	db %00000
	db DEDGE_WARP, 7
	dw 416
	db %00000
	db DEDGE_WARP, 8
	dw 417
	db %00000
	db DEDGE_WARP, 9
	dw 418
	db %00000
	db DEDGE_WARP, 12
	dw 420
	db %00000
	db -1
.Node410:
	db DEDGE_WARP, 10
	dw 419
	db %00000
	db DEDGE_WARP, 11
	dw 420
	db %00000
	db -1
.Node411:
	db DEDGE_WARP, 1
	dw 409
	db %00000
	db -1
.Node412:
	db DEDGE_WARP, 2
	dw 409
	db %00000
	db -1
.Node413:
	db DEDGE_WARP, 3
	dw 409
	db %00000
	db -1
.Node414:
	db DEDGE_WARP, 1
	dw 409
	db %00000
	db -1
.Node415:
	db DEDGE_WARP, 2
	dw 409
	db %00000
	db -1
.Node416:
	db DEDGE_WARP, 4
	dw 409
	db %00000
	db -1
.Node417:
	db DEDGE_WARP, 1
	dw 409
	db %00000
	db -1
.Node418:
	db DEDGE_WARP, 3
	dw 409
	db %00000
	db -1
.Node419:
	db DEDGE_WARP, 5
	dw 410
	db %00000
	db -1
.Node420:
	db DEDGE_WARP, 1
	dw 410
	db %00000
	db DEDGE_WARP, 2
	dw 409
	db %00000
	db -1
.Node421:
	db DEDGE_WARP, 4
	dw 422
	db %00000
	db DEDGE_WARP, 5
	dw 407
	db %00000
	db -1
.Node422:
	db DEDGE_WARP, 1
	dw 20
	db %00000
	db DEDGE_WARP, 3
	dw 421
	db %00000
	db -1
.Node423:
	db DEDGE_WARP, 4
	dw 424
	db %00000
	db DEDGE_WARP, 5
	dw 408
	db %00000
	db -1
.Node424:
	db DEDGE_WARP, 1
	dw 367
	db %00000
	db DEDGE_WARP, 3
	dw 423
	db %00000
	db -1
.Node425:
	db DEDGE_WARP, 1
	dw 192
	db %00000
	db DEDGE_WARP, 2
	dw 194
	db %00000
	db DEDGE_WARP, 3
	dw 426
	db %00000
	db -1
.Node426:
	db DEDGE_WARP, 1
	dw 425
	db %00000
	db -1
.Node427:
	db DEDGE_WARP, 1
	dw 56
	db %00000
	db -1
.Node428:
	db DEDGE_WARP, 1
	dw 429
	db %00000
	db DEDGE_WARP, 3
	dw 204
	db %00000
	db -1
.Node429:
	db DEDGE_WARP, 1
	dw 428
	db %00000
	db DEDGE_WARP, 4
	dw 430
	db %00000
	db -1
.Node430:
	db DEDGE_WARP, 1
	dw 429
	db %00000
	db -1
.Node431:
	db -1
.Node432:
	db -1
.Node433:
	db -1
.Node434:
	db -1
.Node435:
	db DEDGE_EDGE, 0
	dw 439
	db %00000
	db -1
.Node436:
	db DEDGE_EDGE, 1
	dw 467
	db %00000
	db -1
.Node437:
	db DEDGE_EDGE, 1
	dw 464
	db %00000
	db DEDGE_EDGE, 0
	dw 440
	db %00000
	db DEDGE_WALK, 0
	dw 438
	db %00010
	db -1
.Node438:
	db DEDGE_EDGE, 1
	dw 466
	db %00000
	db DEDGE_WALK, 0
	dw 437
	db %00000
	db -1
.Node439:
	db DEDGE_EDGE, 1
	dw 435
	db %00000
	db -1
.Node440:
	db DEDGE_EDGE, 1
	dw 437
	db %00000
	db DEDGE_EDGE, 2
	dw 443
	db %00000
	db DEDGE_WALK, 0
	dw 442
	db %00001
	db -1
.Node441:
	db DEDGE_EDGE, 2
	dw 445
	db %00000
	db -1
.Node442:
	db DEDGE_EDGE, 2
	dw 444
	db %00000
	db DEDGE_WALK, 0
	dw 440
	db %00000
	db -1
.Node443:
	db DEDGE_WARP, 1
	dw 459
	db %00000
	db DEDGE_EDGE, 3
	dw 440
	db %00000
	db -1
.Node444:
	db DEDGE_EDGE, 3
	dw 442
	db %00000
	db DEDGE_WALK, 0
	dw 443
	db %00000
	db -1
.Node445:
	db DEDGE_EDGE, 3
	dw 441
	db %00000
	db -1
.Node446:
	db DEDGE_EDGE, 2
	dw 496
	db %00000
	db -1
.Node447:
	db DEDGE_WARP, 1
	dw 523
	db %00000
	db DEDGE_EDGE, 3
	dw 450
	db %00000
	db -1
.Node448:
	db DEDGE_EDGE, 2
	dw 495
	db %00000
	db -1
.Node449:
	db DEDGE_WARP, 1
	dw 453
	db %00000
	db DEDGE_WALK, 0
	dw 450
	db %00001
	db -1
.Node450:
	db DEDGE_WARP, 2
	dw 454
	db %00000
	db DEDGE_WARP, 3
	dw 455
	db %00000
	db DEDGE_WARP, 4
	dw 456
	db %00000
	db DEDGE_WARP, 5
	dw 457
	db %00000
	db DEDGE_WARP, 6
	dw 458
	db %00000
	db DEDGE_WARP, 8
	dw 459
	db %00000
	db DEDGE_WARP, 10
	dw 236
	db %00000
	db DEDGE_EDGE, 0
	dw 239
	db %00000
	db DEDGE_EDGE, 2
	dw 447
	db %00000
	db DEDGE_WALK, 0
	dw 449
	db %00001
	db -1
.Node451:
	db DEDGE_EDGE, 0
	dw 240
	db %00000
	db -1
.Node452:
	db DEDGE_EDGE, 0
	dw 238
	db %00000
	db -1
.Node453:
	db DEDGE_WARP, 1
	dw 449
	db %00000
	db -1
.Node454:
	db DEDGE_WARP, 1
	dw 450
	db %00000
	db -1
.Node455:
	db DEDGE_WARP, 1
	dw 450
	db %00000
	db -1
.Node456:
	db DEDGE_WARP, 1
	dw 450
	db %00000
	db -1
.Node457:
	db DEDGE_WARP, 1
	dw 450
	db %00000
	db -1
.Node458:
	db DEDGE_WARP, 1
	dw 450
	db %00000
	db -1
.Node459:
	db DEDGE_WARP, 1
	dw 450
	db %00000
	db DEDGE_WARP, 3
	dw 443
	db %00000
	db -1
.Node460:
	db DEDGE_EDGE, 3
	dw 469
	db %00000
	db -1
.Node461:
	db DEDGE_WARP, 1
	dw 480
	db %00000
	db DEDGE_EDGE, 3
	dw 470
	db %00000
	db -1
.Node462:
	db DEDGE_EDGE, 3
	dw 472
	db %00000
	db -1
.Node463:
	db DEDGE_EDGE, 1
	dw 472
	db %00000
	db -1
.Node464:
	db DEDGE_WARP, 1
	dw 481
	db %00000
	db DEDGE_EDGE, 1
	dw 470
	db %00000
	db DEDGE_EDGE, 0
	dw 437
	db %00000
	db DEDGE_EDGE, 2
	dw 365
	db %00000
	db DEDGE_WALK, 0
	dw 466
	db %00010
	db -1
.Node465:
	db DEDGE_EDGE, 1
	dw 471
	db %00000
	db -1
.Node466:
	db DEDGE_EDGE, 0
	dw 438
	db %00000
	db DEDGE_WALK, 0
	dw 464
	db %00000
	db -1
.Node467:
	db DEDGE_EDGE, 0
	dw 436
	db %00000
	db -1
.Node468:
	db DEDGE_WARP, 1
	dw 198
	db %00000
	db DEDGE_EDGE, 1
	dw 270
	db %00000
	db DEDGE_EDGE, 0
	dw 469
	db %00000
	db DEDGE_EDGE, 0
	dw 470
	db %00000
	db DEDGE_EDGE, 0
	dw 471
	db %00000
	db -1
.Node469:
	db DEDGE_EDGE, 1
	dw 468
	db %00000
	db DEDGE_EDGE, 2
	dw 460
	db %00000
	db -1
.Node470:
	db DEDGE_WARP, 1
	dw 473
	db %00000
	db DEDGE_WARP, 2
	dw 474
	db %00000
	db DEDGE_WARP, 3
	dw 475
	db %00000
	db DEDGE_WARP, 4
	dw 476
	db %00000
	db DEDGE_WARP, 5
	dw 477
	db %00000
	db DEDGE_WARP, 6
	dw 478
	db %00000
	db DEDGE_WARP, 7
	dw 479
	db %00000
	db DEDGE_EDGE, 1
	dw 468
	db %00000
	db DEDGE_EDGE, 0
	dw 464
	db %00000
	db DEDGE_EDGE, 2
	dw 461
	db %00000
	db -1
.Node471:
	db DEDGE_EDGE, 1
	dw 468
	db %00000
	db DEDGE_EDGE, 0
	dw 465
	db %00000
	db -1
.Node472:
	db DEDGE_EDGE, 0
	dw 463
	db %00000
	db DEDGE_EDGE, 2
	dw 462
	db %00000
	db -1
.Node473:
	db DEDGE_WARP, 1
	dw 470
	db %00000
	db -1
.Node474:
	db DEDGE_WARP, 1
	dw 470
	db %00000
	db -1
.Node475:
	db DEDGE_WARP, 1
	dw 470
	db %00000
	db -1
.Node476:
	db DEDGE_WARP, 1
	dw 470
	db %00000
	db -1
.Node477:
	db DEDGE_WARP, 1
	dw 470
	db %00000
	db -1
.Node478:
	db DEDGE_WARP, 1
	dw 470
	db %00000
	db -1
.Node479:
	db DEDGE_WARP, 1
	dw 470
	db %00000
	db -1
.Node480:
	db DEDGE_WARP, 1
	dw 590
	db %00000
	db DEDGE_WARP, 3
	dw 461
	db %00000
	db -1
.Node481:
	db DEDGE_WARP, 1
	dw 464
	db %00000
	db -1
.Node482:
	db DEDGE_EDGE, 2
	dw 485
	db %00000
	db -1
.Node483:
	db DEDGE_WARP, 2
	dw 562
	db %00000
	db DEDGE_EDGE, 2
	dw 485
	db %00000
	db -1
.Node484:
	db DEDGE_WARP, 1
	dw 488
	db %00000
	db DEDGE_EDGE, 2
	dw 486
	db %00000
	db DEDGE_WALK, 0
	dw 483
	db %00000
	db -1
.Node485:
	db DEDGE_WARP, 1
	dw 487
	db %00000
	db DEDGE_WARP, 2
	dw 169
	db %00000
	db DEDGE_EDGE, 3
	dw 482
	db %00000
	db DEDGE_EDGE, 3
	dw 483
	db %00000
	db DEDGE_WALK, 0
	dw 486
	db %00001
	db -1
.Node486:
	db DEDGE_EDGE, 3
	dw 484
	db %00000
	db DEDGE_WALK, 0
	dw 485
	db %00001
	db -1
.Node487:
	db DEDGE_WARP, 1
	dw 485
	db %00000
	db -1
.Node488:
	db DEDGE_WARP, 1
	dw 484
	db %00000
	db -1
.Node489:
	db DEDGE_WARP, 1
	dw 522
	db %00000
	db DEDGE_EDGE, 2
	dw 497
	db %00000
	db -1
.Node490:
	db DEDGE_EDGE, 3
	dw 591
	db %00000
	db -1
.Node491:
	db DEDGE_WARP, 1
	dw 520
	db %00000
	db DEDGE_WALK, 0
	dw 492
	db %00001
	db -1
.Node492:
	db DEDGE_WARP, 2
	dw 521
	db %00000
	db DEDGE_EDGE, 3
	dw 497
	db %00000
	db DEDGE_WALK, 0
	dw 491
	db %00001
	db -1
.Node493:
	db DEDGE_WARP, 4
	dw 521
	db %00000
	db DEDGE_EDGE, 0
	dw 494
	db %00000
	db -1
.Node494:
	db DEDGE_WARP, 1
	dw 523
	db %00000
	db DEDGE_EDGE, 1
	dw 493
	db %00000
	db -1
.Node495:
	db DEDGE_EDGE, 3
	dw 448
	db %00000
	db -1
.Node496:
	db DEDGE_EDGE, 3
	dw 446
	db %00000
	db -1
.Node497:
	db DEDGE_WARP, 1
	dw 499
	db %00000
	db DEDGE_WARP, 2
	dw 507
	db %00000
	db DEDGE_WARP, 3
	dw 506
	db %00000
	db DEDGE_WARP, 5
	dw 515
	db %00000
	db DEDGE_WARP, 6
	dw 516
	db %00000
	db DEDGE_WARP, 7
	dw 517
	db %00000
	db DEDGE_WARP, 9
	dw 519
	db %00000
	db DEDGE_EDGE, 2
	dw 492
	db %00000
	db DEDGE_EDGE, 3
	dw 489
	db %00000
	db DEDGE_WALK, 0
	dw 498
	db %00001
	db -1
.Node498:
	db DEDGE_WARP, 8
	dw 518
	db %00000
	db DEDGE_WALK, 0
	dw 497
	db %00001
	db -1
.Node499:
	db DEDGE_WARP, 1
	dw 497
	db %00000
	db DEDGE_WARP, 3
	dw 500
	db %00000
	db DEDGE_WARP, 4
	dw 505
	db %00000
	db -1
.Node500:
	db DEDGE_WARP, 1
	dw 501
	db %00000
	db DEDGE_WARP, 2
	dw 499
	db %00000
	db DEDGE_WARP, 3
	dw 505
	db %00000
	db -1
.Node501:
	db DEDGE_WARP, 1
	dw 500
	db %00000
	db DEDGE_WARP, 2
	dw 502
	db %00000
	db DEDGE_WARP, 3
	dw 505
	db %00000
	db -1
.Node502:
	db DEDGE_WARP, 1
	dw 503
	db %00000
	db DEDGE_WARP, 2
	dw 501
	db %00000
	db DEDGE_WARP, 3
	dw 505
	db %00000
	db -1
.Node503:
	db DEDGE_WARP, 1
	dw 502
	db %00000
	db DEDGE_WARP, 2
	dw 504
	db %00000
	db DEDGE_WARP, 3
	dw 505
	db %00000
	db -1
.Node504:
	db DEDGE_WARP, 1
	dw 503
	db %00000
	db DEDGE_WARP, 2
	dw 505
	db %00000
	db -1
.Node505:
	db DEDGE_WARP, 1
	dw 499
	db %00000
	db -1
.Node506:
	db DEDGE_WARP, 3
	dw 497
	db %00000
	db DEDGE_WARP, 4
	dw 508
	db %00000
	db -1
.Node507:
	db DEDGE_WARP, 1
	dw 497
	db %00000
	db DEDGE_WARP, 5
	dw 509
	db %00000
	db -1
.Node508:
	db DEDGE_WARP, 1
	dw 506
	db %00000
	db DEDGE_WARP, 2
	dw 510
	db %00000
	db -1
.Node509:
	db DEDGE_WARP, 3
	dw 511
	db %00000
	db DEDGE_WARP, 4
	dw 507
	db %00000
	db -1
.Node510:
	db DEDGE_WARP, 1
	dw 512
	db %00000
	db DEDGE_WARP, 2
	dw 508
	db %00000
	db -1
.Node511:
	db DEDGE_WARP, 3
	dw 509
	db %00000
	db DEDGE_WARP, 4
	dw 513
	db %00000
	db -1
.Node512:
	db DEDGE_WARP, 1
	dw 510
	db %00000
	db DEDGE_WARP, 3
	dw 514
	db %00000
	db -1
.Node513:
	db DEDGE_WARP, 2
	dw 511
	db %00000
	db -1
.Node514:
	db DEDGE_WARP, 1
	dw 512
	db %00000
	db -1
.Node515:
	db DEDGE_WARP, 1
	dw 497
	db %00000
	db -1
.Node516:
	db DEDGE_WARP, 1
	dw 497
	db %00000
	db -1
.Node517:
	db DEDGE_WARP, 1
	dw 497
	db %00000
	db -1
.Node518:
	db DEDGE_WARP, 1
	dw 498
	db %00000
	db -1
.Node519:
	db DEDGE_WARP, 1
	dw 497
	db %00000
	db -1
.Node520:
	db DEDGE_WARP, 1
	dw 491
	db %00000
	db -1
.Node521:
	db DEDGE_WARP, 1
	dw 493
	db %00000
	db DEDGE_WARP, 3
	dw 492
	db %00000
	db -1
.Node522:
	db DEDGE_WARP, 1
	dw 489
	db %00000
	db DEDGE_WARP, 3
	dw 590
	db %00000
	db -1
.Node523:
	db DEDGE_WARP, 1
	dw 494
	db %00000
	db DEDGE_WARP, 3
	dw 447
	db %00000
	db -1
.Node524:
	db DEDGE_EDGE, 3
	dw 22
	db %00000
	db -1
.Node525:
	db DEDGE_EDGE, 3
	dw 20
	db %00000
	db DEDGE_WALK, 0
	dw 526
	db %00010
	db -1
.Node526:
	db DEDGE_EDGE, 0
	dw 527
	db %00000
	db DEDGE_EDGE, 3
	dw 23
	db %00000
	db DEDGE_WALK, 0
	dw 525
	db %00000
	db -1
.Node527:
	db DEDGE_EDGE, 1
	dw 526
	db %00000
	db DEDGE_EDGE, 2
	dw 533
	db %00000
	db DEDGE_WALK, 0
	dw 528
	db %00110
	db DEDGE_WALK, 0
	dw 529
	db %00110
	db DEDGE_WALK, 0
	dw 530
	db %00110
	db DEDGE_WALK, 0
	dw 531
	db %00110
	db -1
.Node528:
	db DEDGE_WARP, 2
	dw 152
	db %00000
	db DEDGE_WALK, 0
	dw 527
	db %00110
	db DEDGE_WALK, 0
	dw 529
	db %00110
	db DEDGE_WALK, 0
	dw 530
	db %00110
	db DEDGE_WALK, 0
	dw 531
	db %00110
	db -1
.Node529:
	db DEDGE_WARP, 1
	dw 148
	db %00000
	db DEDGE_WALK, 0
	dw 527
	db %00110
	db DEDGE_WALK, 0
	dw 528
	db %00110
	db DEDGE_WALK, 0
	dw 530
	db %00110
	db DEDGE_WALK, 0
	dw 531
	db %00110
	db -1
.Node530:
	db DEDGE_WARP, 3
	dw 153
	db %00000
	db DEDGE_WALK, 0
	dw 527
	db %00110
	db DEDGE_WALK, 0
	dw 528
	db %00110
	db DEDGE_WALK, 0
	dw 529
	db %00110
	db DEDGE_WALK, 0
	dw 531
	db %00110
	db -1
.Node531:
	db DEDGE_WARP, 4
	dw 158
	db %00000
	db DEDGE_WALK, 0
	dw 527
	db %00110
	db DEDGE_WALK, 0
	dw 528
	db %00110
	db DEDGE_WALK, 0
	dw 529
	db %00110
	db DEDGE_WALK, 0
	dw 530
	db %00110
	db -1
.Node532:
	db DEDGE_WARP, 1
	dw 534
	db %00000
	db DEDGE_WARP, 2
	dw 535
	db %00000
	db DEDGE_WARP, 3
	dw 536
	db %00000
	db DEDGE_WARP, 4
	dw 537
	db %00000
	db DEDGE_WARP, 5
	dw 538
	db %00000
	db DEDGE_WARP, 6
	dw 539
	db %00000
	db DEDGE_WARP, 7
	dw 540
	db %00000
	db DEDGE_WALK, 0
	dw 533
	db %00010
	db -1
.Node533:
	db DEDGE_EDGE, 3
	dw 527
	db %00000
	db DEDGE_WALK, 0
	dw 532
	db %00000
	db -1
.Node534:
	db DEDGE_WARP, 1
	dw 532
	db %00000
	db -1
.Node535:
	db DEDGE_WARP, 1
	dw 532
	db %00000
	db -1
.Node536:
	db DEDGE_WARP, 1
	dw 532
	db %00000
	db -1
.Node537:
	db DEDGE_WARP, 1
	dw 532
	db %00000
	db -1
.Node538:
	db DEDGE_WARP, 1
	dw 532
	db %00000
	db -1
.Node539:
	db DEDGE_WARP, 1
	dw 532
	db %00000
	db -1
.Node540:
	db DEDGE_WARP, 1
	dw 532
	db %00000
	db -1
.Node541:
	db DEDGE_EDGE, 1
	dw 398
	db %00000
	db DEDGE_EDGE, 0
	dw 548
	db %00000
	db DEDGE_WALK, 0
	dw 542
	db %00001
	db DEDGE_WALK, 0
	dw 543
	db %00001
	db DEDGE_WALK, 0
	dw 544
	db %00001
	db -1
.Node542:
	db DEDGE_WARP, 1
	dw 560
	db %00000
	db DEDGE_WARP, 5
	dw 189
	db %00000
	db DEDGE_WALK, 0
	dw 541
	db %00001
	db DEDGE_WALK, 0
	dw 543
	db %00001
	db DEDGE_WALK, 0
	dw 544
	db %00001
	db -1
.Node543:
	db DEDGE_WARP, 3
	dw 561
	db %00000
	db DEDGE_WALK, 0
	dw 541
	db %00001
	db DEDGE_WALK, 0
	dw 542
	db %00001
	db DEDGE_WALK, 0
	dw 544
	db %00001
	db -1
.Node544:
	db DEDGE_WARP, 2
	dw 561
	db %00000
	db DEDGE_WALK, 0
	dw 541
	db %00001
	db DEDGE_WALK, 0
	dw 542
	db %00001
	db DEDGE_WALK, 0
	dw 543
	db %00001
	db -1
.Node545:
	db DEDGE_EDGE, 3
	dw 547
	db %00000
	db DEDGE_EDGE, 3
	dw 549
	db %00000
	db -1
.Node546:
	db DEDGE_WARP, 1
	dw 562
	db %00000
	db DEDGE_EDGE, 3
	dw 548
	db %00000
	db -1
.Node547:
	db DEDGE_EDGE, 2
	dw 545
	db %00000
	db -1
.Node548:
	db DEDGE_WARP, 1
	dw 554
	db %00000
	db DEDGE_WARP, 2
	dw 555
	db %00000
	db DEDGE_WARP, 3
	dw 556
	db %00000
	db DEDGE_WARP, 4
	dw 558
	db %00000
	db DEDGE_WARP, 5
	dw 559
	db %00000
	db DEDGE_EDGE, 1
	dw 541
	db %00000
	db DEDGE_EDGE, 0
	dw 381
	db %00000
	db DEDGE_EDGE, 2
	dw 546
	db %00000
	db -1
.Node549:
	db DEDGE_EDGE, 2
	dw 545
	db %00000
	db -1
.Node550:
	db DEDGE_EDGE, 0
	dw 379
	db %00000
	db -1
.Node551:
	db DEDGE_EDGE, 0
	dw 380
	db %00000
	db -1
.Node552:
	db DEDGE_EDGE, 0
	dw 382
	db %00000
	db -1
.Node553:
	db DEDGE_EDGE, 0
	dw 383
	db %00000
	db -1
.Node554:
	db DEDGE_WARP, 1
	dw 548
	db %00000
	db -1
.Node555:
	db DEDGE_WARP, 1
	dw 548
	db %00000
	db -1
.Node556:
	db DEDGE_WARP, 1
	dw 548
	db %00000
	db DEDGE_WARP, 3
	dw 557
	db %00000
	db -1
.Node557:
	db DEDGE_WARP, 1
	dw 556
	db %00000
	db -1
.Node558:
	db DEDGE_WARP, 1
	dw 548
	db %00000
	db -1
.Node559:
	db DEDGE_WARP, 1
	dw 548
	db %00000
	db -1
.Node560:
	db DEDGE_WARP, 1
	dw 542
	db %00000
	db -1
.Node561:
	db DEDGE_WARP, 1
	dw 543
	db %00000
	db DEDGE_WARP, 3
	dw 544
	db %00000
	db -1
.Node562:
	db DEDGE_WARP, 1
	dw 546
	db %00000
	db DEDGE_WARP, 3
	dw 564
	db %00000
	db DEDGE_WARP, 5
	dw 208
	db %00000
	db DEDGE_WARP, 7
	dw 483
	db %00000
	db -1
.Node563:
	db DEDGE_EDGE, 2
	dw 571
	db %00000
	db DEDGE_WALK, 0
	dw 564
	db %00010
	db DEDGE_WALK, 0
	dw 565
	db %00010
	db DEDGE_WALK, 0
	dw 566
	db %00010
	db -1
.Node564:
	db DEDGE_WARP, 1
	dw 562
	db %00000
	db DEDGE_WARP, 2
	dw 583
	db %00000
	db DEDGE_WARP, 3
	dw 584
	db %00000
	db DEDGE_EDGE, 2
	dw 570
	db %00000
	db DEDGE_WALK, 0
	dw 563
	db %00000
	db DEDGE_WALK, 0
	dw 565
	db %00010
	db DEDGE_WALK, 0
	dw 566
	db %00010
	db -1
.Node565:
	db DEDGE_EDGE, 2
	dw 573
	db %00000
	db DEDGE_WALK, 0
	dw 563
	db %00000
	db DEDGE_WALK, 0
	dw 564
	db %00000
	db DEDGE_WALK, 0
	dw 566
	db %00010
	db -1
.Node566:
	db DEDGE_EDGE, 2
	dw 572
	db %00000
	db DEDGE_WALK, 0
	dw 563
	db %00000
	db DEDGE_WALK, 0
	dw 564
	db %00000
	db DEDGE_WALK, 0
	dw 565
	db %00010
	db -1
.Node567:
	db DEDGE_EDGE, 2
	dw 574
	db %00000
	db -1
.Node568:
	db DEDGE_WARP, 1
	dw 585
	db %00000
	db DEDGE_WARP, 2
	dw 186
	db %00000
	db DEDGE_WARP, 3
	dw 187
	db %00000
	db DEDGE_WALK, 0
	dw 569
	db %00010
	db DEDGE_WALK, 0
	dw 570
	db %00010
	db DEDGE_WALK, 0
	dw 572
	db %00010
	db DEDGE_WALK, 0
	dw 573
	db %00010
	db -1
.Node569:
	db DEDGE_EDGE, 2
	dw 577
	db %00000
	db DEDGE_WALK, 0
	dw 568
	db %00000
	db DEDGE_WALK, 0
	dw 570
	db %00010
	db DEDGE_WALK, 0
	dw 572
	db %00010
	db DEDGE_WALK, 0
	dw 573
	db %00010
	db -1
.Node570:
	db DEDGE_EDGE, 3
	dw 564
	db %00000
	db DEDGE_WALK, 0
	dw 568
	db %00010
	db DEDGE_WALK, 0
	dw 569
	db %00010
	db DEDGE_WALK, 0
	dw 572
	db %00010
	db DEDGE_WALK, 0
	dw 573
	db %00010
	db -1
.Node571:
	db DEDGE_EDGE, 3
	dw 563
	db %00000
	db DEDGE_WALK, 0
	dw 568
	db %00010
	db DEDGE_WALK, 0
	dw 569
	db %00010
	db DEDGE_WALK, 0
	dw 570
	db %00000
	db DEDGE_WALK, 0
	dw 572
	db %00010
	db DEDGE_WALK, 0
	dw 573
	db %00010
	db -1
.Node572:
	db DEDGE_EDGE, 3
	dw 566
	db %00000
	db DEDGE_WALK, 0
	dw 568
	db %00010
	db DEDGE_WALK, 0
	dw 569
	db %00010
	db DEDGE_WALK, 0
	dw 570
	db %00000
	db DEDGE_WALK, 0
	dw 573
	db %00010
	db -1
.Node573:
	db DEDGE_EDGE, 3
	dw 565
	db %00000
	db DEDGE_WALK, 0
	dw 568
	db %00010
	db DEDGE_WALK, 0
	dw 569
	db %00010
	db DEDGE_WALK, 0
	dw 570
	db %00000
	db DEDGE_WALK, 0
	dw 572
	db %00010
	db -1
.Node574:
	db DEDGE_EDGE, 3
	dw 567
	db %00000
	db -1
.Node575:
	db DEDGE_WARP, 1
	dw 586
	db %00000
	db DEDGE_EDGE, 2
	dw 614
	db %00000
	db DEDGE_EDGE, 3
	dw 576
	db %00000
	db -1
.Node576:
	db DEDGE_WARP, 1
	dw 578
	db %00000
	db DEDGE_WARP, 2
	dw 579
	db %00000
	db DEDGE_WARP, 3
	dw 581
	db %00000
	db DEDGE_WARP, 4
	dw 582
	db %00000
	db DEDGE_EDGE, 2
	dw 575
	db %00000
	db DEDGE_WALK, 0
	dw 577
	db %00010
	db -1
.Node577:
	db DEDGE_EDGE, 3
	dw 569
	db %00000
	db DEDGE_WALK, 0
	dw 576
	db %00000
	db -1
.Node578:
	db DEDGE_WARP, 1
	dw 576
	db %00000
	db -1
.Node579:
	db DEDGE_WARP, 1
	dw 576
	db %00000
	db DEDGE_WARP, 3
	dw 580
	db %00000
	db -1
.Node580:
	db DEDGE_WARP, 1
	dw 579
	db %00000
	db -1
.Node581:
	db DEDGE_WARP, 1
	dw 576
	db %00000
	db -1
.Node582:
	db DEDGE_WARP, 1
	dw 576
	db %00000
	db -1
.Node583:
	db DEDGE_WARP, 1
	dw 564
	db %00000
	db -1
.Node584:
	db DEDGE_WARP, 1
	dw 564
	db %00000
	db -1
.Node585:
	db DEDGE_WARP, 1
	dw 568
	db %00000
	db -1
.Node586:
	db DEDGE_WARP, 1
	dw 231
	db %00000
	db DEDGE_WARP, 3
	dw 575
	db %00000
	db -1
.Node587:
	db DEDGE_WARP, 1
	dw 609
	db %00000
	db DEDGE_WARP, 2
	dw 610
	db %00000
	db DEDGE_EDGE, 1
	dw 287
	db %00000
	db -1
.Node588:
	db DEDGE_WARP, 4
	dw 611
	db %00000
	db DEDGE_WALK, 0
	dw 587
	db %00000
	db -1
.Node589:
	db DEDGE_EDGE, 1
	dw 287
	db %00000
	db DEDGE_WALK, 0
	dw 587
	db %00000
	db DEDGE_WALK, 0
	dw 588
	db %00000
	db -1
.Node590:
	db DEDGE_WARP, 1
	dw 592
	db %00000
	db DEDGE_WARP, 2
	dw 600
	db %00000
	db DEDGE_WARP, 3
	dw 602
	db %00000
	db DEDGE_WARP, 4
	dw 603
	db %00000
	db DEDGE_WARP, 5
	dw 604
	db %00000
	db DEDGE_WARP, 6
	dw 605
	db %00000
	db DEDGE_WARP, 7
	dw 606
	db %00000
	db DEDGE_WARP, 8
	dw 607
	db %00000
	db DEDGE_WARP, 9
	dw 610
	db %00000
	db DEDGE_WARP, 10
	dw 522
	db %00000
	db DEDGE_WARP, 12
	dw 377
	db %00000
	db DEDGE_WARP, 14
	dw 480
	db %00000
	db -1
.Node591:
	db DEDGE_EDGE, 2
	dw 490
	db %00000
	db -1
.Node592:
	db DEDGE_WARP, 1
	dw 590
	db %00000
	db -1
.Node593:
	db DEDGE_WARP, 7
	dw 594
	db %00000
	db DEDGE_WARP, 17
	dw 597
	db %00000
	db DEDGE_WARP, 21
	dw 596
	db %00000
	db DEDGE_WARP, 31
	dw 595
	db %00000
	db -1
.Node594:
	db DEDGE_WARP, 8
	dw 599
	db %00000
	db DEDGE_WARP, 14
	dw 598
	db %00000
	db DEDGE_WARP, 22
	dw 593
	db %00000
	db DEDGE_WARP, 28
	dw 596
	db %00000
	db -1
.Node595:
	db DEDGE_WARP, 10
	dw 601
	db %00000
	db DEDGE_WARP, 16
	dw 593
	db %00000
	db DEDGE_WARP, 24
	dw 599
	db %00000
	db DEDGE_WARP, 30
	dw 598
	db %00000
	db -1
.Node596:
	db DEDGE_WARP, 6
	dw 593
	db %00000
	db DEDGE_WARP, 13
	dw 594
	db %00000
	db DEDGE_WARP, 20
	dw 598
	db %00000
	db DEDGE_WARP, 27
	dw 599
	db %00000
	db -1
.Node597:
	db DEDGE_WARP, 32
	dw 593
	db %00000
	db -1
.Node598:
	db DEDGE_WARP, 5
	dw 596
	db %00000
	db DEDGE_WARP, 15
	dw 595
	db %00000
	db DEDGE_WARP, 19
	dw 601
	db %00000
	db DEDGE_WARP, 29
	dw 594
	db %00000
	db -1
.Node599:
	db DEDGE_WARP, 9
	dw 595
	db %00000
	db DEDGE_WARP, 12
	dw 596
	db %00000
	db DEDGE_WARP, 23
	dw 594
	db %00000
	db DEDGE_WARP, 26
	dw 601
	db %00000
	db -1
.Node600:
	db DEDGE_WARP, 1
	dw 590
	db %00000
	db DEDGE_WARP, 3
	dw 601
	db %00000
	db -1
.Node601:
	db DEDGE_WARP, 4
	dw 598
	db %00000
	db DEDGE_WARP, 11
	dw 599
	db %00000
	db DEDGE_WARP, 18
	dw 600
	db %00000
	db DEDGE_WARP, 25
	dw 595
	db %00000
	db -1
.Node602:
	db DEDGE_WARP, 1
	dw 590
	db %00000
	db -1
.Node603:
	db DEDGE_WARP, 1
	dw 590
	db %00000
	db -1
.Node604:
	db DEDGE_WARP, 1
	dw 590
	db %00000
	db -1
.Node605:
	db DEDGE_WARP, 1
	dw 590
	db %00000
	db DEDGE_WARP, 3
	dw 345
	db %00000
	db -1
.Node606:
	db DEDGE_WARP, 1
	dw 590
	db %00000
	db -1
.Node607:
	db DEDGE_WARP, 1
	dw 590
	db %00000
	db DEDGE_WARP, 3
	dw 608
	db %00000
	db -1
.Node608:
	db DEDGE_WARP, 1
	dw 607
	db %00000
	db -1
.Node609:
	db DEDGE_WARP, 1
	dw 587
	db %00000
	db DEDGE_WARP, 3
	dw 195
	db %00000
	db -1
.Node610:
	db DEDGE_WARP, 1
	dw 587
	db %00000
	db DEDGE_WARP, 3
	dw 590
	db %00000
	db -1
.Node611:
	db DEDGE_WARP, 1
	dw 588
	db %00000
	db -1
.Node612:
	db DEDGE_WARP, 1
	dw 620
	db %00000
	db DEDGE_WARP, 2
	dw 621
	db %00000
	db DEDGE_EDGE, 1
	dw 613
	db %00000
	db DEDGE_EDGE, 0
	dw 614
	db %00000
	db -1
.Node613:
	db DEDGE_WARP, 1
	dw 622
	db %00000
	db DEDGE_WARP, 3
	dw 177
	db %00000
	db DEDGE_EDGE, 0
	dw 612
	db %00000
	db -1
.Node614:
	db DEDGE_WARP, 1
	dw 615
	db %00000
	db DEDGE_WARP, 2
	dw 616
	db %00000
	db DEDGE_WARP, 3
	dw 617
	db %00000
	db DEDGE_WARP, 4
	dw 618
	db %00000
	db DEDGE_WARP, 5
	dw 619
	db %00000
	db DEDGE_EDGE, 1
	dw 612
	db %00000
	db DEDGE_EDGE, 3
	dw 575
	db %00000
	db -1
.Node615:
	db DEDGE_WARP, 1
	dw 614
	db %00000
	db -1
.Node616:
	db DEDGE_WARP, 1
	dw 614
	db %00000
	db -1
.Node617:
	db DEDGE_WARP, 1
	dw 614
	db %00000
	db -1
.Node618:
	db DEDGE_WARP, 1
	dw 614
	db %00000
	db -1
.Node619:
	db DEDGE_WARP, 1
	dw 614
	db %00000
	db -1
.Node620:
	db DEDGE_WARP, 1
	dw 612
	db %00000
	db -1
.Node621:
	db DEDGE_WARP, 1
	dw 612
	db %00000
	db -1
.Node622:
	db DEDGE_WARP, 1
	dw 318
	db %00000
	db DEDGE_WARP, 3
	dw 613
	db %00000
	db -1

DemoWorldCenters:
; the POKéMON CENTERs: map key, its nurse (object, from 1); -1 ends
	dw 0
	db 1
	dw 16
	db 1
	dw 114
	db 1
	dw 126
	db 1
	dw 131
	db 1
	dw 142
	db 1
	dw 146
	db 1
	dw 156
	db 1
	dw 178
	db 1
	dw 181
	db 1
	dw 205
	db 1
	dw 214
	db 1
	dw 234
	db 1
	dw 250
	db 1
	dw 266
	db 1
	dw 274
	db 1
	dw 286
	db 1
	dw 310
	db 1
	dw 325
	db 1
	dw 344
	db 1
	dw 367
	db 1
	dw 381
	db 1
	dw -1
