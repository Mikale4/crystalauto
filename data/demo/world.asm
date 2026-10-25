; The maps the Demo travels through, and the maps each one leads to
; (by a connection or a warp). Made by tools/demo_world.py.

DEF NUM_DEMO_WORLD_MAPS EQU 18

DemoWorldMaps:
; group, number, the maps it leads to (DemoWorldMaps indexes), -1
	table_width 2
	dw .PlayersHouse2F
	dw .PlayersHouse1F
	dw .NewBarkTown
	dw .ElmsLab
	dw .Route29
	dw .CherrygroveCity
	dw .CherrygrovePokecenter1F
	dw .CherrygroveMart
	dw .Route30
	dw .MrPokemonsHouse
	dw .Route31
	dw .Route31VioletGate
	dw .VioletCity
	dw .VioletPokecenter1F
	dw .VioletMart
	dw .VioletGym
	dw .Route29Route46Gate
	dw .Route46
	assert_table_length NUM_DEMO_WORLD_MAPS
.PlayersHouse2F:
	map_id PLAYERS_HOUSE_2F
	db 1, -1
.PlayersHouse1F:
	map_id PLAYERS_HOUSE_1F
	db 2, 0, -1
.NewBarkTown:
	map_id NEW_BARK_TOWN
	db 4, 3, 1, -1
.ElmsLab:
	map_id ELMS_LAB
	db 2, -1
.Route29:
	map_id ROUTE_29
	db 17, 5, 2, 16, -1
.CherrygroveCity:
	map_id CHERRYGROVE_CITY
	db 8, 4, 7, 6, -1
.CherrygrovePokecenter1F:
	map_id CHERRYGROVE_POKECENTER_1F
	db 5, -1
.CherrygroveMart:
	map_id CHERRYGROVE_MART
	db 5, -1
.Route30:
	map_id ROUTE_30
	db 10, 5, 9, -1
.MrPokemonsHouse:
	map_id MR_POKEMONS_HOUSE
	db 8, -1
.Route31:
	map_id ROUTE_31
	db 8, 12, 11, -1
.Route31VioletGate:
	map_id ROUTE_31_VIOLET_GATE
	db 12, 10, -1
.VioletCity:
	map_id VIOLET_CITY
	db 10, 14, 15, 13, 11, -1
.VioletPokecenter1F:
	map_id VIOLET_POKECENTER_1F
	db 12, -1
.VioletMart:
	map_id VIOLET_MART
	db 12, -1
.VioletGym:
	map_id VIOLET_GYM
	db 12, -1
.Route29Route46Gate:
	map_id ROUTE_29_ROUTE_46_GATE
	db 17, 4, -1
.Route46:
	map_id ROUTE_46
	db 4, 16, -1

DemoWorldCenters:
; the POKéMON CENTERs among them
	db 6, 13, -1
