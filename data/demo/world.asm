; Every map the Demo can travel to: how the maps link up, and what there is
; to do on each (see engine/demo/demo_walk.asm). Made by tools/demo_world.py.

	assert NUM_DEMO_WORLD_MAPS == 388, "NUM_DEMO_WORLD_MAPS (constants/demo_constants.asm) should be 388"

DemoGroupKeys:
; the key of each group's first map (MAPGROUP_* - 1)
	dw 0
	dw 14
	dw 21
	dw 112
	dw 121
	dw 131
	dw 139
	dw 156
	dw 163
	dw 169
	dw 186
	dw 210
	dw 223
	dw 229
	dw 237
	dw 249
	dw 257
	dw 270
	dw 284
	dw 288
	dw 294
	dw 320
	dw 336
	dw 349
	dw 362
	dw 377

	assert NUM_DEMO_NODES == 676, "NUM_DEMO_NODES (constants/demo_constants.asm) should be 676"

DemoWorldMaps:
; for each map key: its map, its first target (DemoTargets) and how many, its
; first node (DemoWorldNodes) and how many
	table_width 2
	dw .OlivinePokecenter1F
	dw .OlivineGym
	dw .OlivineTimsHouse
	dw .OlivineHouseBeta
	dw .OlivinePunishmentSpeechHouse
	dw .OlivineGoodRodHouse
	dw .OlivineCafe
	dw .OlivineMart
	dw .Route38EcruteakGate
	dw .Route39Barn
	dw .Route39Farmhouse
	dw .Route38
	dw .Route39
	dw .OlivineCity
	dw .MahoganyRedGyaradosSpeechHouse
	dw .MahoganyGym
	dw .MahoganyPokecenter1F
	dw .Route42EcruteakGate
	dw .Route42
	dw .Route44
	dw .MahoganyTown
	dw .SproutTower1F
	dw .SproutTower2F
	dw .SproutTower3F
	dw .TinTower1F
	dw .TinTower2F
	dw .TinTower3F
	dw .TinTower4F
	dw .TinTower5F
	dw .TinTower6F
	dw .TinTower7F
	dw .TinTower8F
	dw .TinTower9F
	dw .BurnedTower1F
	dw .BurnedTowerB1F
	dw .NationalPark
	dw .NationalParkBugContest
	dw .RadioTower1F
	dw .RadioTower2F
	dw .RadioTower3F
	dw .RadioTower4F
	dw .RadioTower5F
	dw .RuinsOfAlphOutside
	dw .RuinsOfAlphHoOhChamber
	dw .RuinsOfAlphKabutoChamber
	dw .RuinsOfAlphOmanyteChamber
	dw .RuinsOfAlphAerodactylChamber
	dw .RuinsOfAlphInnerChamber
	dw .RuinsOfAlphResearchCenter
	dw .RuinsOfAlphHoOhItemRoom
	dw .RuinsOfAlphKabutoItemRoom
	dw .RuinsOfAlphOmanyteItemRoom
	dw .RuinsOfAlphAerodactylItemRoom
	dw .RuinsOfAlphHoOhWordRoom
	dw .RuinsOfAlphKabutoWordRoom
	dw .RuinsOfAlphOmanyteWordRoom
	dw .RuinsOfAlphAerodactylWordRoom
	dw .UnionCave1F
	dw .UnionCaveB1F
	dw .UnionCaveB2F
	dw .SlowpokeWellB1F
	dw .SlowpokeWellB2F
	dw .OlivineLighthouse1F
	dw .OlivineLighthouse2F
	dw .OlivineLighthouse3F
	dw .OlivineLighthouse4F
	dw .OlivineLighthouse5F
	dw .OlivineLighthouse6F
	dw .MahoganyMart1F
	dw .TeamRocketBaseB1F
	dw .TeamRocketBaseB2F
	dw .TeamRocketBaseB3F
	dw .IlexForest
	dw .GoldenrodUnderground
	dw .GoldenrodUndergroundSwitchRoomEntrances
	dw .GoldenrodDeptStoreB1F
	dw .GoldenrodUndergroundWarehouse
	dw .MountMortar1FOutside
	dw .MountMortar1FInside
	dw .MountMortar2FInside
	dw .MountMortarB1F
	dw .IcePath1F
	dw .IcePathB1F
	dw .IcePathB2FMahoganySide
	dw .IcePathB2FBlackthornSide
	dw .IcePathB3F
	dw .WhirlIslandNw
	dw .WhirlIslandNe
	dw .WhirlIslandSw
	dw .WhirlIslandCave
	dw .WhirlIslandSe
	dw .WhirlIslandB1F
	dw .WhirlIslandB2F
	dw .WhirlIslandLugiaChamber
	dw .SilverCaveRoom1
	dw .SilverCaveRoom2
	dw .SilverCaveRoom3
	dw .SilverCaveItemRooms
	dw .DarkCaveVioletEntrance
	dw .DarkCaveBlackthornEntrance
	dw .DragonsDen1F
	dw .DragonsDenB1F
	dw .DragonShrine
	dw .TohjoFalls
	dw .DiglettsCave
	dw .MountMoon
	dw .UndergroundPath
	dw .RockTunnel1F
	dw .RockTunnelB1F
	dw .SafariZoneFuchsiaGateBeta
	dw .SafariZoneBeta
	dw .VictoryRoad
	dw .EcruteakTinTowerEntrance
	dw .WiseTriosRoom
	dw .EcruteakPokecenter1F
	dw .EcruteakLugiaSpeechHouse
	dw .DanceTheater
	dw .EcruteakMart
	dw .EcruteakGym
	dw .EcruteakItemfinderHouse
	dw .EcruteakCity
	dw .BlackthornGym1F
	dw .BlackthornGym2F
	dw .BlackthornDragonSpeechHouse
	dw .BlackthornEmysHouse
	dw .BlackthornMart
	dw .BlackthornPokecenter1F
	dw .MoveDeletersHouse
	dw .Route45
	dw .Route46
	dw .BlackthornCity
	dw .CinnabarPokecenter1F
	dw .CinnabarPokecenter2FBeta
	dw .Route19FuchsiaGate
	dw .SeafoamGym
	dw .Route19
	dw .Route20
	dw .Route21
	dw .CinnabarIsland
	dw .CeruleanGymBadgeSpeechHouse
	dw .CeruleanPoliceStation
	dw .CeruleanTradeSpeechHouse
	dw .CeruleanPokecenter1F
	dw .CeruleanPokecenter2FBeta
	dw .CeruleanGym
	dw .CeruleanMart
	dw .Route10Pokecenter1F
	dw .Route10Pokecenter2FBeta
	dw .PowerPlant
	dw .BillsHouse
	dw .Route4
	dw .Route9
	dw .Route10North
	dw .Route24
	dw .Route25
	dw .CeruleanCity
	dw .AzaleaPokecenter1F
	dw .CharcoalKiln
	dw .AzaleaMart
	dw .KurtsHouse
	dw .AzaleaGym
	dw .Route33
	dw .AzaleaTown
	dw .LakeOfRageHiddenPowerHouse
	dw .LakeOfRageMagikarpHouse
	dw .Route43MahoganyGate
	dw .Route43Gate
	dw .Route43
	dw .LakeOfRage
	dw .Route32
	dw .Route35
	dw .Route36
	dw .Route37
	dw .VioletCity
	dw .VioletMart
	dw .VioletGym
	dw .EarlsPokemonAcademy
	dw .VioletNicknameSpeechHouse
	dw .VioletPokecenter1F
	dw .VioletKylesHouse
	dw .Route32RuinsOfAlphGate
	dw .Route32Pokecenter1F
	dw .Route35GoldenrodGate
	dw .Route35NationalParkGate
	dw .Route36RuinsOfAlphGate
	dw .Route36NationalParkGate
	dw .Route34
	dw .GoldenrodCity
	dw .GoldenrodGym
	dw .GoldenrodBikeShop
	dw .GoldenrodHappinessRater
	dw .BillsFamilysHouse
	dw .GoldenrodMagnetTrainStation
	dw .GoldenrodFlowerShop
	dw .GoldenrodPpSpeechHouse
	dw .GoldenrodNameRater
	dw .GoldenrodDeptStore1F
	dw .GoldenrodDeptStore2F
	dw .GoldenrodDeptStore3F
	dw .GoldenrodDeptStore4F
	dw .GoldenrodDeptStore5F
	dw .GoldenrodDeptStore6F
	dw .GoldenrodDeptStoreElevator
	dw .GoldenrodDeptStoreRoof
	dw .GoldenrodGameCorner
	dw .GoldenrodPokecenter1F
	dw .PokecomCenterAdminOfficeMobile
	dw .IlexForestAzaleaGate
	dw .Route34IlexForestGate
	dw .DayCare
	dw .Route6
	dw .Route11
	dw .VermilionCity
	dw .VermilionFishingSpeechHouse
	dw .VermilionPokecenter1F
	dw .VermilionPokecenter2FBeta
	dw .PokemonFanClub
	dw .VermilionMagnetTrainSpeechHouse
	dw .VermilionMart
	dw .VermilionDiglettsCaveSpeechHouse
	dw .VermilionGym
	dw .Route6SaffronGate
	dw .Route6UndergroundPathEntrance
	dw .Route1
	dw .PalletTown
	dw .RedsHouse1F
	dw .RedsHouse2F
	dw .BluesHouse
	dw .OaksLab
	dw .Route3
	dw .PewterCity
	dw .PewterNidoranSpeechHouse
	dw .PewterGym
	dw .PewterMart
	dw .PewterPokecenter1F
	dw .PewterPokecenter2FBeta
	dw .PewterSnoozeSpeechHouse
	dw .OlivinePort
	dw .VermilionPort
	dw .FastShip1F
	dw .FastShipCabinsNnwNneNe
	dw .FastShipCabinsSwSswNw
	dw .FastShipCabinsSeSseCaptainsCabin
	dw .FastShipB1F
	dw .OlivinePortPassage
	dw .VermilionPortPassage
	dw .MountMoonSquare
	dw .MountMoonGiftShop
	dw .TinTowerRoof
	dw .Route23
	dw .IndigoPlateauPokecenter1F
	dw .WillsRoom
	dw .KogasRoom
	dw .BrunosRoom
	dw .KarensRoom
	dw .LancesRoom
	dw .HallOfFame
	dw .Route13
	dw .Route14
	dw .Route15
	dw .Route18
	dw .FuchsiaCity
	dw .FuchsiaMart
	dw .SafariZoneMainOffice
	dw .FuchsiaGym
	dw .BillsOlderSistersHouse
	dw .FuchsiaPokecenter1F
	dw .FuchsiaPokecenter2FBeta
	dw .SafariZoneWardensHome
	dw .Route15FuchsiaGate
	dw .Route8
	dw .Route12
	dw .Route10South
	dw .LavenderTown
	dw .LavenderPokecenter1F
	dw .LavenderPokecenter2FBeta
	dw .MrFujisHouse
	dw .LavenderSpeechHouse
	dw .LavenderNameRater
	dw .LavenderMart
	dw .SoulHouse
	dw .LavRadioTower1F
	dw .Route8SaffronGate
	dw .Route12SuperRodHouse
	dw .Route28
	dw .SilverCaveOutside
	dw .SilverCavePokecenter1F
	dw .Route28SteelWingHouse
	dw .Pokecenter2F
	dw .TradeCenter
	dw .Colosseum
	dw .TimeCapsule
	dw .MobileTradeRoom
	dw .MobileBattleRoom
	dw .Route7
	dw .Route16
	dw .Route17
	dw .CeladonCity
	dw .CeladonDeptStore1F
	dw .CeladonDeptStore2F
	dw .CeladonDeptStore3F
	dw .CeladonDeptStore4F
	dw .CeladonDeptStore5F
	dw .CeladonDeptStore6F
	dw .CeladonDeptStoreElevator
	dw .CeladonMansion1F
	dw .CeladonMansion2F
	dw .CeladonMansion3F
	dw .CeladonMansionRoof
	dw .CeladonMansionRoofHouse
	dw .CeladonPokecenter1F
	dw .CeladonPokecenter2FBeta
	dw .CeladonGameCorner
	dw .CeladonGameCornerPrizeRoom
	dw .CeladonGym
	dw .CeladonCafe
	dw .Route16FuchsiaSpeechHouse
	dw .Route16Gate
	dw .Route7SaffronGate
	dw .Route17Route18Gate
	dw .Route40
	dw .Route41
	dw .CianwoodCity
	dw .ManiasHouse
	dw .CianwoodGym
	dw .CianwoodPokecenter1F
	dw .CianwoodPharmacy
	dw .CianwoodPhotoStudio
	dw .CianwoodLugiaSpeechHouse
	dw .PokeSeersHouse
	dw .BattleTower1F
	dw .BattleTowerBattleRoom
	dw .BattleTowerElevator
	dw .BattleTowerHallway
	dw .Route40BattleTowerGate
	dw .BattleTowerOutside
	dw .Route2
	dw .Route22
	dw .ViridianCity
	dw .ViridianGym
	dw .ViridianNicknameSpeechHouse
	dw .TrainerHouse1F
	dw .TrainerHouseB1F
	dw .ViridianMart
	dw .ViridianPokecenter1F
	dw .ViridianPokecenter2FBeta
	dw .Route2NuggetHouse
	dw .Route2Gate
	dw .VictoryRoadGate
	dw .Route26
	dw .Route27
	dw .Route29
	dw .NewBarkTown
	dw .ElmsLab
	dw .PlayersHouse1F
	dw .PlayersHouse2F
	dw .PlayersNeighborsHouse
	dw .ElmsHouse
	dw .Route26HealHouse
	dw .DayOfWeekSiblingsHouse
	dw .Route27SandstormHouse
	dw .Route29Route46Gate
	dw .Route5
	dw .SaffronCity
	dw .FightingDojo
	dw .SaffronGym
	dw .SaffronMart
	dw .SaffronPokecenter1F
	dw .SaffronPokecenter2FBeta
	dw .MrPsychicsHouse
	dw .SaffronMagnetTrainStation
	dw .SilphCo1F
	dw .CopycatsHouse1F
	dw .CopycatsHouse2F
	dw .Route5UndergroundPathEntrance
	dw .Route5SaffronGate
	dw .Route5CleanseTagHouse
	dw .Route30
	dw .Route31
	dw .CherrygroveCity
	dw .CherrygroveMart
	dw .CherrygrovePokecenter1F
	dw .CherrygroveGymSpeechHouse
	dw .GuideGentsHouse
	dw .CherrygroveEvolutionSpeechHouse
	dw .Route30BerryHouse
	dw .MrPokemonsHouse
	dw .Route31VioletGate
	assert_table_length NUM_DEMO_WORLD_MAPS
.OlivinePokecenter1F:
	map_id OLIVINE_POKECENTER_1F
	dw 0
	db 0
	dw 0
	db 1
.OlivineGym:
	map_id OLIVINE_GYM
	dw 0
	db 0
	dw 1
	db 1
.OlivineTimsHouse:
	map_id OLIVINE_TIMS_HOUSE
	dw 0
	db 0
	dw 2
	db 1
.OlivineHouseBeta:
	map_id OLIVINE_HOUSE_BETA
	dw 0
	db 0
	dw 3
	db 1
.OlivinePunishmentSpeechHouse:
	map_id OLIVINE_PUNISHMENT_SPEECH_HOUSE
	dw 0
	db 0
	dw 4
	db 1
.OlivineGoodRodHouse:
	map_id OLIVINE_GOOD_ROD_HOUSE
	dw 0
	db 0
	dw 5
	db 1
.OlivineCafe:
	map_id OLIVINE_CAFE
	dw 0
	db 0
	dw 6
	db 1
.OlivineMart:
	map_id OLIVINE_MART
	dw 0
	db 0
	dw 7
	db 1
.Route38EcruteakGate:
	map_id ROUTE_38_ECRUTEAK_GATE
	dw 0
	db 0
	dw 8
	db 1
.Route39Barn:
	map_id ROUTE_39_BARN
	dw 0
	db 0
	dw 9
	db 1
.Route39Farmhouse:
	map_id ROUTE_39_FARMHOUSE
	dw 0
	db 0
	dw 10
	db 1
.Route38:
	map_id ROUTE_38
	dw 0
	db 6
	dw 11
	db 3
.Route39:
	map_id ROUTE_39
	dw 6
	db 5
	dw 14
	db 5
.OlivineCity:
	map_id OLIVINE_CITY
	dw 11
	db 0
	dw 19
	db 5
.MahoganyRedGyaradosSpeechHouse:
	map_id MAHOGANY_RED_GYARADOS_SPEECH_HOUSE
	dw 11
	db 0
	dw 24
	db 1
.MahoganyGym:
	map_id MAHOGANY_GYM
	dw 11
	db 5
	dw 25
	db 1
.MahoganyPokecenter1F:
	map_id MAHOGANY_POKECENTER_1F
	dw 16
	db 0
	dw 26
	db 1
.Route42EcruteakGate:
	map_id ROUTE_42_ECRUTEAK_GATE
	dw 16
	db 0
	dw 27
	db 1
.Route42:
	map_id ROUTE_42
	dw 16
	db 6
	dw 28
	db 5
.Route44:
	map_id ROUTE_44
	dw 22
	db 11
	dw 33
	db 2
.MahoganyTown:
	map_id MAHOGANY_TOWN
	dw 33
	db 0
	dw 35
	db 4
.SproutTower1F:
	map_id SPROUT_TOWER_1F
	dw 33
	db 2
	dw 39
	db 2
.SproutTower2F:
	map_id SPROUT_TOWER_2F
	dw 35
	db 3
	dw 41
	db 2
.SproutTower3F:
	map_id SPROUT_TOWER_3F
	dw 38
	db 5
	dw 43
	db 1
.TinTower1F:
	map_id TIN_TOWER_1F
	dw 43
	db 0
	dw 44
	db 1
.TinTower2F:
	map_id TIN_TOWER_2F
	dw 43
	db 0
	dw 45
	db 1
.TinTower3F:
	map_id TIN_TOWER_3F
	dw 43
	db 1
	dw 46
	db 1
.TinTower4F:
	map_id TIN_TOWER_4F
	dw 44
	db 4
	dw 47
	db 1
.TinTower5F:
	map_id TIN_TOWER_5F
	dw 48
	db 3
	dw 48
	db 4
.TinTower6F:
	map_id TIN_TOWER_6F
	dw 51
	db 1
	dw 52
	db 1
.TinTower7F:
	map_id TIN_TOWER_7F
	dw 52
	db 1
	dw 53
	db 2
.TinTower8F:
	map_id TIN_TOWER_8F
	dw 53
	db 3
	dw 55
	db 4
.TinTower9F:
	map_id TIN_TOWER_9F
	dw 56
	db 1
	dw 59
	db 3
.BurnedTower1F:
	map_id BURNED_TOWER_1F
	dw 57
	db 3
	dw 62
	db 2
.BurnedTowerB1F:
	map_id BURNED_TOWER_B1F
	dw 60
	db 1
	dw 64
	db 3
.NationalPark:
	map_id NATIONAL_PARK
	dw 61
	db 7
	dw 67
	db 1
.NationalParkBugContest:
	map_id NATIONAL_PARK_BUG_CONTEST
	dw 68
	db 0
	dw 0
	db 0
.RadioTower1F:
	map_id RADIO_TOWER_1F
	dw 68
	db 1
	dw 68
	db 1
.RadioTower2F:
	map_id RADIO_TOWER_2F
	dw 69
	db 4
	dw 69
	db 1
.RadioTower3F:
	map_id RADIO_TOWER_3F
	dw 73
	db 4
	dw 70
	db 1
.RadioTower4F:
	map_id RADIO_TOWER_4F
	dw 77
	db 4
	dw 71
	db 2
.RadioTower5F:
	map_id RADIO_TOWER_5F
	dw 81
	db 2
	dw 73
	db 2
.RuinsOfAlphOutside:
	map_id RUINS_OF_ALPH_OUTSIDE
	dw 83
	db 1
	dw 75
	db 9
.RuinsOfAlphHoOhChamber:
	map_id RUINS_OF_ALPH_HO_OH_CHAMBER
	dw 84
	db 0
	dw 84
	db 1
.RuinsOfAlphKabutoChamber:
	map_id RUINS_OF_ALPH_KABUTO_CHAMBER
	dw 84
	db 0
	dw 85
	db 1
.RuinsOfAlphOmanyteChamber:
	map_id RUINS_OF_ALPH_OMANYTE_CHAMBER
	dw 84
	db 0
	dw 86
	db 1
.RuinsOfAlphAerodactylChamber:
	map_id RUINS_OF_ALPH_AERODACTYL_CHAMBER
	dw 84
	db 0
	dw 87
	db 1
.RuinsOfAlphInnerChamber:
	map_id RUINS_OF_ALPH_INNER_CHAMBER
	dw 84
	db 0
	dw 88
	db 1
.RuinsOfAlphResearchCenter:
	map_id RUINS_OF_ALPH_RESEARCH_CENTER
	dw 84
	db 0
	dw 89
	db 1
.RuinsOfAlphHoOhItemRoom:
	map_id RUINS_OF_ALPH_HO_OH_ITEM_ROOM
	dw 84
	db 4
	dw 90
	db 1
.RuinsOfAlphKabutoItemRoom:
	map_id RUINS_OF_ALPH_KABUTO_ITEM_ROOM
	dw 88
	db 4
	dw 91
	db 1
.RuinsOfAlphOmanyteItemRoom:
	map_id RUINS_OF_ALPH_OMANYTE_ITEM_ROOM
	dw 92
	db 4
	dw 92
	db 1
.RuinsOfAlphAerodactylItemRoom:
	map_id RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM
	dw 96
	db 4
	dw 93
	db 1
.RuinsOfAlphHoOhWordRoom:
	map_id RUINS_OF_ALPH_HO_OH_WORD_ROOM
	dw 100
	db 0
	dw 94
	db 1
.RuinsOfAlphKabutoWordRoom:
	map_id RUINS_OF_ALPH_KABUTO_WORD_ROOM
	dw 100
	db 0
	dw 95
	db 1
.RuinsOfAlphOmanyteWordRoom:
	map_id RUINS_OF_ALPH_OMANYTE_WORD_ROOM
	dw 100
	db 0
	dw 96
	db 1
.RuinsOfAlphAerodactylWordRoom:
	map_id RUINS_OF_ALPH_AERODACTYL_WORD_ROOM
	dw 100
	db 0
	dw 97
	db 1
.UnionCave1F:
	map_id UNION_CAVE_1F
	dw 100
	db 9
	dw 98
	db 2
.UnionCaveB1F:
	map_id UNION_CAVE_B1F
	dw 109
	db 6
	dw 100
	db 5
.UnionCaveB2F:
	map_id UNION_CAVE_B2F
	dw 115
	db 5
	dw 105
	db 1
.SlowpokeWellB1F:
	map_id SLOWPOKE_WELL_B1F
	dw 120
	db 5
	dw 106
	db 2
.SlowpokeWellB2F:
	map_id SLOWPOKE_WELL_B2F
	dw 125
	db 1
	dw 108
	db 1
.OlivineLighthouse1F:
	map_id OLIVINE_LIGHTHOUSE_1F
	dw 126
	db 0
	dw 109
	db 1
.OlivineLighthouse2F:
	map_id OLIVINE_LIGHTHOUSE_2F
	dw 126
	db 2
	dw 110
	db 1
.OlivineLighthouse3F:
	map_id OLIVINE_LIGHTHOUSE_3F
	dw 128
	db 4
	dw 111
	db 2
.OlivineLighthouse4F:
	map_id OLIVINE_LIGHTHOUSE_4F
	dw 132
	db 2
	dw 113
	db 2
.OlivineLighthouse5F:
	map_id OLIVINE_LIGHTHOUSE_5F
	dw 134
	db 6
	dw 115
	db 2
.OlivineLighthouse6F:
	map_id OLIVINE_LIGHTHOUSE_6F
	dw 140
	db 1
	dw 117
	db 1
.MahoganyMart1F:
	map_id MAHOGANY_MART_1F
	dw 141
	db 0
	dw 118
	db 1
.TeamRocketBaseB1F:
	map_id TEAM_ROCKET_BASE_B1F
	dw 141
	db 6
	dw 119
	db 1
.TeamRocketBaseB2F:
	map_id TEAM_ROCKET_BASE_B2F
	dw 147
	db 5
	dw 120
	db 3
.TeamRocketBaseB3F:
	map_id TEAM_ROCKET_BASE_B3F
	dw 152
	db 9
	dw 123
	db 2
.IlexForest:
	map_id ILEX_FOREST
	dw 161
	db 8
	dw 125
	db 2
.GoldenrodUnderground:
	map_id GOLDENROD_UNDERGROUND
	dw 169
	db 8
	dw 127
	db 2
.GoldenrodUndergroundSwitchRoomEntrances:
	map_id GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES
	dw 177
	db 10
	dw 129
	db 3
.GoldenrodDeptStoreB1F:
	map_id GOLDENROD_DEPT_STORE_B1F
	dw 187
	db 4
	dw 132
	db 1
.GoldenrodUndergroundWarehouse:
	map_id GOLDENROD_UNDERGROUND_WAREHOUSE
	dw 191
	db 6
	dw 133
	db 1
.MountMortar1FOutside:
	map_id MOUNT_MORTAR_1F_OUTSIDE
	dw 197
	db 3
	dw 134
	db 6
.MountMortar1FInside:
	map_id MOUNT_MORTAR_1F_INSIDE
	dw 200
	db 10
	dw 140
	db 2
.MountMortar2FInside:
	map_id MOUNT_MORTAR_2F_INSIDE
	dw 210
	db 8
	dw 142
	db 2
.MountMortarB1F:
	map_id MOUNT_MORTAR_B1F
	dw 218
	db 6
	dw 144
	db 2
.IcePath1F:
	map_id ICE_PATH_1F
	dw 224
	db 3
	dw 146
	db 3
.IcePathB1F:
	map_id ICE_PATH_B1F
	dw 227
	db 2
	dw 149
	db 3
.IcePathB2FMahoganySide:
	map_id ICE_PATH_B2F_MAHOGANY_SIDE
	dw 229
	db 3
	dw 152
	db 6
.IcePathB2FBlackthornSide:
	map_id ICE_PATH_B2F_BLACKTHORN_SIDE
	dw 232
	db 2
	dw 158
	db 5
.IcePathB3F:
	map_id ICE_PATH_B3F
	dw 234
	db 1
	dw 163
	db 1
.WhirlIslandNw:
	map_id WHIRL_ISLAND_NW
	dw 235
	db 0
	dw 164
	db 2
.WhirlIslandNe:
	map_id WHIRL_ISLAND_NE
	dw 235
	db 1
	dw 166
	db 3
.WhirlIslandSw:
	map_id WHIRL_ISLAND_SW
	dw 236
	db 1
	dw 169
	db 4
.WhirlIslandCave:
	map_id WHIRL_ISLAND_CAVE
	dw 237
	db 0
	dw 173
	db 1
.WhirlIslandSe:
	map_id WHIRL_ISLAND_SE
	dw 237
	db 0
	dw 174
	db 1
.WhirlIslandB1F:
	map_id WHIRL_ISLAND_B1F
	dw 237
	db 8
	dw 175
	db 6
.WhirlIslandB2F:
	map_id WHIRL_ISLAND_B2F
	dw 245
	db 3
	dw 181
	db 5
.WhirlIslandLugiaChamber:
	map_id WHIRL_ISLAND_LUGIA_CHAMBER
	dw 248
	db 0
	dw 186
	db 1
.SilverCaveRoom1:
	map_id SILVER_CAVE_ROOM_1
	dw 248
	db 6
	dw 187
	db 2
.SilverCaveRoom2:
	map_id SILVER_CAVE_ROOM_2
	dw 254
	db 4
	dw 189
	db 3
.SilverCaveRoom3:
	map_id SILVER_CAVE_ROOM_3
	dw 258
	db 0
	dw 192
	db 1
.SilverCaveItemRooms:
	map_id SILVER_CAVE_ITEM_ROOMS
	dw 258
	db 2
	dw 193
	db 2
.DarkCaveVioletEntrance:
	map_id DARK_CAVE_VIOLET_ENTRANCE
	dw 260
	db 5
	dw 195
	db 4
.DarkCaveBlackthornEntrance:
	map_id DARK_CAVE_BLACKTHORN_ENTRANCE
	dw 265
	db 2
	dw 199
	db 2
.DragonsDen1F:
	map_id DRAGONS_DEN_1F
	dw 267
	db 0
	dw 201
	db 2
.DragonsDenB1F:
	map_id DRAGONS_DEN_B1F
	dw 267
	db 9
	dw 203
	db 3
.DragonShrine:
	map_id DRAGON_SHRINE
	dw 276
	db 0
	dw 206
	db 1
.TohjoFalls:
	map_id TOHJO_FALLS
	dw 276
	db 1
	dw 207
	db 2
.DiglettsCave:
	map_id DIGLETTS_CAVE
	dw 277
	db 1
	dw 209
	db 3
.MountMoon:
	map_id MOUNT_MOON
	dw 278
	db 0
	dw 212
	db 4
.UndergroundPath:
	map_id UNDERGROUND_PATH
	dw 278
	db 2
	dw 216
	db 1
.RockTunnel1F:
	map_id ROCK_TUNNEL_1F
	dw 280
	db 4
	dw 217
	db 3
.RockTunnelB1F:
	map_id ROCK_TUNNEL_B1F
	dw 284
	db 4
	dw 220
	db 2
.SafariZoneFuchsiaGateBeta:
	map_id SAFARI_ZONE_FUCHSIA_GATE_BETA
	dw 288
	db 0
	dw 222
	db 1
.SafariZoneBeta:
	map_id SAFARI_ZONE_BETA
	dw 288
	db 0
	dw 223
	db 1
.VictoryRoad:
	map_id VICTORY_ROAD
	dw 288
	db 7
	dw 224
	db 7
.EcruteakTinTowerEntrance:
	map_id ECRUTEAK_TIN_TOWER_ENTRANCE
	dw 295
	db 0
	dw 231
	db 2
.WiseTriosRoom:
	map_id WISE_TRIOS_ROOM
	dw 295
	db 3
	dw 233
	db 1
.EcruteakPokecenter1F:
	map_id ECRUTEAK_POKECENTER_1F
	dw 298
	db 0
	dw 234
	db 1
.EcruteakLugiaSpeechHouse:
	map_id ECRUTEAK_LUGIA_SPEECH_HOUSE
	dw 298
	db 0
	dw 235
	db 1
.DanceTheater:
	map_id DANCE_THEATER
	dw 298
	db 5
	dw 236
	db 1
.EcruteakMart:
	map_id ECRUTEAK_MART
	dw 303
	db 0
	dw 237
	db 1
.EcruteakGym:
	map_id ECRUTEAK_GYM
	dw 303
	db 4
	dw 238
	db 2
.EcruteakItemfinderHouse:
	map_id ECRUTEAK_ITEMFINDER_HOUSE
	dw 307
	db 0
	dw 240
	db 1
.EcruteakCity:
	map_id ECRUTEAK_CITY
	dw 307
	db 1
	dw 241
	db 2
.BlackthornGym1F:
	map_id BLACKTHORN_GYM_1F
	dw 308
	db 3
	dw 243
	db 2
.BlackthornGym2F:
	map_id BLACKTHORN_GYM_2F
	dw 311
	db 2
	dw 245
	db 2
.BlackthornDragonSpeechHouse:
	map_id BLACKTHORN_DRAGON_SPEECH_HOUSE
	dw 313
	db 0
	dw 247
	db 1
.BlackthornEmysHouse:
	map_id BLACKTHORN_EMYS_HOUSE
	dw 313
	db 0
	dw 248
	db 1
.BlackthornMart:
	map_id BLACKTHORN_MART
	dw 313
	db 0
	dw 249
	db 1
.BlackthornPokecenter1F:
	map_id BLACKTHORN_POKECENTER_1F
	dw 313
	db 0
	dw 250
	db 1
.MoveDeletersHouse:
	map_id MOVE_DELETERS_HOUSE
	dw 313
	db 0
	dw 251
	db 1
.Route45:
	map_id ROUTE_45
	dw 313
	db 12
	dw 252
	db 4
.Route46:
	map_id ROUTE_46
	dw 325
	db 4
	dw 256
	db 4
.BlackthornCity:
	map_id BLACKTHORN_CITY
	dw 329
	db 0
	dw 260
	db 3
.CinnabarPokecenter1F:
	map_id CINNABAR_POKECENTER_1F
	dw 329
	db 0
	dw 263
	db 1
.CinnabarPokecenter2FBeta:
	map_id CINNABAR_POKECENTER_2F_BETA
	dw 329
	db 0
	dw 0
	db 0
.Route19FuchsiaGate:
	map_id ROUTE_19_FUCHSIA_GATE
	dw 329
	db 0
	dw 264
	db 1
.SeafoamGym:
	map_id SEAFOAM_GYM
	dw 329
	db 0
	dw 265
	db 1
.Route19:
	map_id ROUTE_19
	dw 329
	db 4
	dw 266
	db 5
.Route20:
	map_id ROUTE_20
	dw 333
	db 3
	dw 271
	db 3
.Route21:
	map_id ROUTE_21
	dw 336
	db 3
	dw 274
	db 2
.CinnabarIsland:
	map_id CINNABAR_ISLAND
	dw 339
	db 1
	dw 276
	db 3
.CeruleanGymBadgeSpeechHouse:
	map_id CERULEAN_GYM_BADGE_SPEECH_HOUSE
	dw 340
	db 0
	dw 279
	db 1
.CeruleanPoliceStation:
	map_id CERULEAN_POLICE_STATION
	dw 340
	db 0
	dw 280
	db 1
.CeruleanTradeSpeechHouse:
	map_id CERULEAN_TRADE_SPEECH_HOUSE
	dw 340
	db 0
	dw 281
	db 1
.CeruleanPokecenter1F:
	map_id CERULEAN_POKECENTER_1F
	dw 340
	db 0
	dw 282
	db 1
.CeruleanPokecenter2FBeta:
	map_id CERULEAN_POKECENTER_2F_BETA
	dw 340
	db 0
	dw 0
	db 0
.CeruleanGym:
	map_id CERULEAN_GYM
	dw 340
	db 4
	dw 283
	db 1
.CeruleanMart:
	map_id CERULEAN_MART
	dw 344
	db 0
	dw 284
	db 1
.Route10Pokecenter1F:
	map_id ROUTE_10_POKECENTER_1F
	dw 344
	db 0
	dw 285
	db 1
.Route10Pokecenter2FBeta:
	map_id ROUTE_10_POKECENTER_2F_BETA
	dw 344
	db 0
	dw 0
	db 0
.PowerPlant:
	map_id POWER_PLANT
	dw 344
	db 0
	dw 286
	db 1
.BillsHouse:
	map_id BILLS_HOUSE
	dw 344
	db 0
	dw 287
	db 1
.Route4:
	map_id ROUTE_4
	dw 344
	db 5
	dw 288
	db 5
.Route9:
	map_id ROUTE_9
	dw 349
	db 7
	dw 293
	db 8
.Route10North:
	map_id ROUTE_10_NORTH
	dw 356
	db 0
	dw 301
	db 4
.Route24:
	map_id ROUTE_24
	dw 356
	db 0
	dw 305
	db 7
.Route25:
	map_id ROUTE_25
	dw 356
	db 9
	dw 312
	db 4
.CeruleanCity:
	map_id CERULEAN_CITY
	dw 365
	db 1
	dw 316
	db 8
.AzaleaPokecenter1F:
	map_id AZALEA_POKECENTER_1F
	dw 366
	db 0
	dw 324
	db 1
.CharcoalKiln:
	map_id CHARCOAL_KILN
	dw 366
	db 0
	dw 325
	db 1
.AzaleaMart:
	map_id AZALEA_MART
	dw 366
	db 0
	dw 326
	db 1
.KurtsHouse:
	map_id KURTS_HOUSE
	dw 366
	db 0
	dw 327
	db 1
.AzaleaGym:
	map_id AZALEA_GYM
	dw 366
	db 5
	dw 328
	db 1
.Route33:
	map_id ROUTE_33
	dw 371
	db 1
	dw 329
	db 2
.AzaleaTown:
	map_id AZALEA_TOWN
	dw 372
	db 1
	dw 331
	db 2
.LakeOfRageHiddenPowerHouse:
	map_id LAKE_OF_RAGE_HIDDEN_POWER_HOUSE
	dw 373
	db 0
	dw 333
	db 1
.LakeOfRageMagikarpHouse:
	map_id LAKE_OF_RAGE_MAGIKARP_HOUSE
	dw 373
	db 0
	dw 334
	db 1
.Route43MahoganyGate:
	map_id ROUTE_43_MAHOGANY_GATE
	dw 373
	db 0
	dw 335
	db 1
.Route43Gate:
	map_id ROUTE_43_GATE
	dw 373
	db 0
	dw 336
	db 1
.Route43:
	map_id ROUTE_43
	dw 373
	db 7
	dw 337
	db 3
.LakeOfRage:
	map_id LAKE_OF_RAGE
	dw 380
	db 9
	dw 340
	db 3
.Route32:
	map_id ROUTE_32
	dw 389
	db 12
	dw 343
	db 2
.Route35:
	map_id ROUTE_35
	dw 401
	db 9
	dw 345
	db 4
.Route36:
	map_id ROUTE_36
	dw 410
	db 2
	dw 349
	db 1
.Route37:
	map_id ROUTE_37
	dw 412
	db 4
	dw 350
	db 1
.VioletCity:
	map_id VIOLET_CITY
	dw 416
	db 3
	dw 351
	db 1
.VioletMart:
	map_id VIOLET_MART
	dw 419
	db 0
	dw 352
	db 1
.VioletGym:
	map_id VIOLET_GYM
	dw 419
	db 2
	dw 353
	db 1
.EarlsPokemonAcademy:
	map_id EARLS_POKEMON_ACADEMY
	dw 421
	db 0
	dw 354
	db 1
.VioletNicknameSpeechHouse:
	map_id VIOLET_NICKNAME_SPEECH_HOUSE
	dw 421
	db 0
	dw 355
	db 1
.VioletPokecenter1F:
	map_id VIOLET_POKECENTER_1F
	dw 421
	db 0
	dw 356
	db 1
.VioletKylesHouse:
	map_id VIOLET_KYLES_HOUSE
	dw 421
	db 0
	dw 357
	db 1
.Route32RuinsOfAlphGate:
	map_id ROUTE_32_RUINS_OF_ALPH_GATE
	dw 421
	db 0
	dw 358
	db 1
.Route32Pokecenter1F:
	map_id ROUTE_32_POKECENTER_1F
	dw 421
	db 0
	dw 359
	db 1
.Route35GoldenrodGate:
	map_id ROUTE_35_GOLDENROD_GATE
	dw 421
	db 0
	dw 360
	db 1
.Route35NationalParkGate:
	map_id ROUTE_35_NATIONAL_PARK_GATE
	dw 421
	db 0
	dw 361
	db 1
.Route36RuinsOfAlphGate:
	map_id ROUTE_36_RUINS_OF_ALPH_GATE
	dw 421
	db 0
	dw 362
	db 1
.Route36NationalParkGate:
	map_id ROUTE_36_NATIONAL_PARK_GATE
	dw 421
	db 0
	dw 363
	db 2
.Route34:
	map_id ROUTE_34
	dw 421
	db 11
	dw 365
	db 5
.GoldenrodCity:
	map_id GOLDENROD_CITY
	dw 432
	db 0
	dw 370
	db 5
.GoldenrodGym:
	map_id GOLDENROD_GYM
	dw 432
	db 4
	dw 375
	db 1
.GoldenrodBikeShop:
	map_id GOLDENROD_BIKE_SHOP
	dw 436
	db 0
	dw 376
	db 2
.GoldenrodHappinessRater:
	map_id GOLDENROD_HAPPINESS_RATER
	dw 436
	db 0
	dw 378
	db 1
.BillsFamilysHouse:
	map_id BILLS_FAMILYS_HOUSE
	dw 436
	db 0
	dw 379
	db 1
.GoldenrodMagnetTrainStation:
	map_id GOLDENROD_MAGNET_TRAIN_STATION
	dw 436
	db 0
	dw 380
	db 1
.GoldenrodFlowerShop:
	map_id GOLDENROD_FLOWER_SHOP
	dw 436
	db 0
	dw 381
	db 1
.GoldenrodPpSpeechHouse:
	map_id GOLDENROD_PP_SPEECH_HOUSE
	dw 436
	db 0
	dw 382
	db 1
.GoldenrodNameRater:
	map_id GOLDENROD_NAME_RATER
	dw 436
	db 0
	dw 383
	db 1
.GoldenrodDeptStore1F:
	map_id GOLDENROD_DEPT_STORE_1F
	dw 436
	db 0
	dw 384
	db 1
.GoldenrodDeptStore2F:
	map_id GOLDENROD_DEPT_STORE_2F
	dw 436
	db 0
	dw 385
	db 1
.GoldenrodDeptStore3F:
	map_id GOLDENROD_DEPT_STORE_3F
	dw 436
	db 0
	dw 386
	db 1
.GoldenrodDeptStore4F:
	map_id GOLDENROD_DEPT_STORE_4F
	dw 436
	db 0
	dw 387
	db 1
.GoldenrodDeptStore5F:
	map_id GOLDENROD_DEPT_STORE_5F
	dw 436
	db 0
	dw 388
	db 1
.GoldenrodDeptStore6F:
	map_id GOLDENROD_DEPT_STORE_6F
	dw 436
	db 0
	dw 389
	db 1
.GoldenrodDeptStoreElevator:
	map_id GOLDENROD_DEPT_STORE_ELEVATOR
	dw 436
	db 0
	dw 390
	db 1
.GoldenrodDeptStoreRoof:
	map_id GOLDENROD_DEPT_STORE_ROOF
	dw 436
	db 0
	dw 391
	db 1
.GoldenrodGameCorner:
	map_id GOLDENROD_GAME_CORNER
	dw 436
	db 0
	dw 392
	db 1
.GoldenrodPokecenter1F:
	map_id GOLDENROD_POKECENTER_1F
	dw 436
	db 0
	dw 393
	db 1
.PokecomCenterAdminOfficeMobile:
	map_id POKECOM_CENTER_ADMIN_OFFICE_MOBILE
	dw 436
	db 0
	dw 0
	db 0
.IlexForestAzaleaGate:
	map_id ILEX_FOREST_AZALEA_GATE
	dw 436
	db 0
	dw 394
	db 1
.Route34IlexForestGate:
	map_id ROUTE_34_ILEX_FOREST_GATE
	dw 436
	db 0
	dw 395
	db 1
.DayCare:
	map_id DAY_CARE
	dw 436
	db 0
	dw 396
	db 1
.Route6:
	map_id ROUTE_6
	dw 436
	db 2
	dw 397
	db 3
.Route11:
	map_id ROUTE_11
	dw 438
	db 5
	dw 400
	db 1
.VermilionCity:
	map_id VERMILION_CITY
	dw 443
	db 1
	dw 401
	db 5
.VermilionFishingSpeechHouse:
	map_id VERMILION_FISHING_SPEECH_HOUSE
	dw 444
	db 0
	dw 406
	db 1
.VermilionPokecenter1F:
	map_id VERMILION_POKECENTER_1F
	dw 444
	db 0
	dw 407
	db 1
.VermilionPokecenter2FBeta:
	map_id VERMILION_POKECENTER_2F_BETA
	dw 444
	db 0
	dw 0
	db 0
.PokemonFanClub:
	map_id POKEMON_FAN_CLUB
	dw 444
	db 0
	dw 408
	db 1
.VermilionMagnetTrainSpeechHouse:
	map_id VERMILION_MAGNET_TRAIN_SPEECH_HOUSE
	dw 444
	db 0
	dw 409
	db 1
.VermilionMart:
	map_id VERMILION_MART
	dw 444
	db 0
	dw 410
	db 1
.VermilionDiglettsCaveSpeechHouse:
	map_id VERMILION_DIGLETTS_CAVE_SPEECH_HOUSE
	dw 444
	db 0
	dw 411
	db 1
.VermilionGym:
	map_id VERMILION_GYM
	dw 444
	db 3
	dw 412
	db 1
.Route6SaffronGate:
	map_id ROUTE_6_SAFFRON_GATE
	dw 447
	db 0
	dw 413
	db 1
.Route6UndergroundPathEntrance:
	map_id ROUTE_6_UNDERGROUND_PATH_ENTRANCE
	dw 447
	db 0
	dw 414
	db 1
.Route1:
	map_id ROUTE_1
	dw 447
	db 2
	dw 415
	db 7
.PalletTown:
	map_id PALLET_TOWN
	dw 449
	db 0
	dw 422
	db 6
.RedsHouse1F:
	map_id REDS_HOUSE_1F
	dw 449
	db 0
	dw 428
	db 1
.RedsHouse2F:
	map_id REDS_HOUSE_2F
	dw 449
	db 0
	dw 429
	db 1
.BluesHouse:
	map_id BLUES_HOUSE
	dw 449
	db 0
	dw 430
	db 1
.OaksLab:
	map_id OAKS_LAB
	dw 449
	db 0
	dw 431
	db 1
.Route3:
	map_id ROUTE_3
	dw 449
	db 4
	dw 432
	db 3
.PewterCity:
	map_id PEWTER_CITY
	dw 453
	db 0
	dw 435
	db 4
.PewterNidoranSpeechHouse:
	map_id PEWTER_NIDORAN_SPEECH_HOUSE
	dw 453
	db 0
	dw 439
	db 1
.PewterGym:
	map_id PEWTER_GYM
	dw 453
	db 1
	dw 440
	db 1
.PewterMart:
	map_id PEWTER_MART
	dw 454
	db 0
	dw 441
	db 1
.PewterPokecenter1F:
	map_id PEWTER_POKECENTER_1F
	dw 454
	db 0
	dw 442
	db 1
.PewterPokecenter2FBeta:
	map_id PEWTER_POKECENTER_2F_BETA
	dw 454
	db 0
	dw 0
	db 0
.PewterSnoozeSpeechHouse:
	map_id PEWTER_SNOOZE_SPEECH_HOUSE
	dw 454
	db 0
	dw 443
	db 1
.OlivinePort:
	map_id OLIVINE_PORT
	dw 454
	db 1
	dw 444
	db 2
.VermilionPort:
	map_id VERMILION_PORT
	dw 455
	db 1
	dw 446
	db 2
.FastShip1F:
	map_id FAST_SHIP_1F
	dw 456
	db 0
	dw 448
	db 2
.FastShipCabinsNnwNneNe:
	map_id FAST_SHIP_CABINS_NNW_NNE_NE
	dw 456
	db 6
	dw 450
	db 3
.FastShipCabinsSwSswNw:
	map_id FAST_SHIP_CABINS_SW_SSW_NW
	dw 462
	db 4
	dw 453
	db 3
.FastShipCabinsSeSseCaptainsCabin:
	map_id FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN
	dw 466
	db 7
	dw 456
	db 3
.FastShipB1F:
	map_id FAST_SHIP_B1F
	dw 473
	db 10
	dw 459
	db 1
.OlivinePortPassage:
	map_id OLIVINE_PORT_PASSAGE
	dw 483
	db 0
	dw 460
	db 2
.VermilionPortPassage:
	map_id VERMILION_PORT_PASSAGE
	dw 483
	db 0
	dw 462
	db 2
.MountMoonSquare:
	map_id MOUNT_MOON_SQUARE
	dw 483
	db 1
	dw 464
	db 2
.MountMoonGiftShop:
	map_id MOUNT_MOON_GIFT_SHOP
	dw 484
	db 0
	dw 466
	db 1
.TinTowerRoof:
	map_id TIN_TOWER_ROOF
	dw 484
	db 0
	dw 467
	db 1
.Route23:
	map_id ROUTE_23
	dw 484
	db 0
	dw 468
	db 1
.IndigoPlateauPokecenter1F:
	map_id INDIGO_PLATEAU_POKECENTER_1F
	dw 484
	db 0
	dw 469
	db 1
.WillsRoom:
	map_id WILLS_ROOM
	dw 484
	db 0
	dw 470
	db 1
.KogasRoom:
	map_id KOGAS_ROOM
	dw 484
	db 0
	dw 471
	db 1
.BrunosRoom:
	map_id BRUNOS_ROOM
	dw 484
	db 0
	dw 472
	db 1
.KarensRoom:
	map_id KARENS_ROOM
	dw 484
	db 0
	dw 473
	db 1
.LancesRoom:
	map_id LANCES_ROOM
	dw 484
	db 0
	dw 474
	db 1
.HallOfFame:
	map_id HALL_OF_FAME
	dw 484
	db 0
	dw 0
	db 0
.Route13:
	map_id ROUTE_13
	dw 484
	db 6
	dw 475
	db 4
.Route14:
	map_id ROUTE_14
	dw 490
	db 3
	dw 479
	db 4
.Route15:
	map_id ROUTE_15
	dw 493
	db 7
	dw 483
	db 3
.Route18:
	map_id ROUTE_18
	dw 500
	db 2
	dw 486
	db 3
.FuchsiaCity:
	map_id FUCHSIA_CITY
	dw 502
	db 0
	dw 489
	db 4
.FuchsiaMart:
	map_id FUCHSIA_MART
	dw 502
	db 0
	dw 493
	db 1
.SafariZoneMainOffice:
	map_id SAFARI_ZONE_MAIN_OFFICE
	dw 502
	db 0
	dw 494
	db 1
.FuchsiaGym:
	map_id FUCHSIA_GYM
	dw 502
	db 0
	dw 495
	db 1
.BillsOlderSistersHouse:
	map_id BILLS_OLDER_SISTERS_HOUSE
	dw 502
	db 0
	dw 496
	db 1
.FuchsiaPokecenter1F:
	map_id FUCHSIA_POKECENTER_1F
	dw 502
	db 0
	dw 497
	db 1
.FuchsiaPokecenter2FBeta:
	map_id FUCHSIA_POKECENTER_2F_BETA
	dw 502
	db 0
	dw 0
	db 0
.SafariZoneWardensHome:
	map_id SAFARI_ZONE_WARDENS_HOME
	dw 502
	db 0
	dw 498
	db 1
.Route15FuchsiaGate:
	map_id ROUTE_15_FUCHSIA_GATE
	dw 502
	db 0
	dw 499
	db 1
.Route8:
	map_id ROUTE_8
	dw 502
	db 5
	dw 500
	db 3
.Route12:
	map_id ROUTE_12
	dw 507
	db 7
	dw 503
	db 5
.Route10South:
	map_id ROUTE_10_SOUTH
	dw 514
	db 2
	dw 508
	db 2
.LavenderTown:
	map_id LAVENDER_TOWN
	dw 516
	db 0
	dw 510
	db 4
.LavenderPokecenter1F:
	map_id LAVENDER_POKECENTER_1F
	dw 516
	db 0
	dw 514
	db 1
.LavenderPokecenter2FBeta:
	map_id LAVENDER_POKECENTER_2F_BETA
	dw 516
	db 0
	dw 0
	db 0
.MrFujisHouse:
	map_id MR_FUJIS_HOUSE
	dw 516
	db 0
	dw 515
	db 1
.LavenderSpeechHouse:
	map_id LAVENDER_SPEECH_HOUSE
	dw 516
	db 0
	dw 516
	db 1
.LavenderNameRater:
	map_id LAVENDER_NAME_RATER
	dw 516
	db 0
	dw 517
	db 1
.LavenderMart:
	map_id LAVENDER_MART
	dw 516
	db 0
	dw 518
	db 1
.SoulHouse:
	map_id SOUL_HOUSE
	dw 516
	db 0
	dw 519
	db 3
.LavRadioTower1F:
	map_id LAV_RADIO_TOWER_1F
	dw 516
	db 0
	dw 522
	db 1
.Route8SaffronGate:
	map_id ROUTE_8_SAFFRON_GATE
	dw 516
	db 0
	dw 523
	db 1
.Route12SuperRodHouse:
	map_id ROUTE_12_SUPER_ROD_HOUSE
	dw 516
	db 0
	dw 524
	db 1
.Route28:
	map_id ROUTE_28
	dw 516
	db 1
	dw 525
	db 3
.SilverCaveOutside:
	map_id SILVER_CAVE_OUTSIDE
	dw 517
	db 1
	dw 528
	db 3
.SilverCavePokecenter1F:
	map_id SILVER_CAVE_POKECENTER_1F
	dw 518
	db 0
	dw 531
	db 1
.Route28SteelWingHouse:
	map_id ROUTE_28_STEEL_WING_HOUSE
	dw 518
	db 0
	dw 532
	db 1
.Pokecenter2F:
	map_id POKECENTER_2F
	dw 518
	db 0
	dw 0
	db 0
.TradeCenter:
	map_id TRADE_CENTER
	dw 518
	db 0
	dw 0
	db 0
.Colosseum:
	map_id COLOSSEUM
	dw 518
	db 0
	dw 0
	db 0
.TimeCapsule:
	map_id TIME_CAPSULE
	dw 518
	db 0
	dw 0
	db 0
.MobileTradeRoom:
	map_id MOBILE_TRADE_ROOM
	dw 518
	db 0
	dw 0
	db 0
.MobileBattleRoom:
	map_id MOBILE_BATTLE_ROOM
	dw 518
	db 0
	dw 0
	db 0
.Route7:
	map_id ROUTE_7
	dw 518
	db 0
	dw 533
	db 2
.Route16:
	map_id ROUTE_16
	dw 518
	db 0
	dw 535
	db 3
.Route17:
	map_id ROUTE_17
	dw 518
	db 6
	dw 538
	db 3
.CeladonCity:
	map_id CELADON_CITY
	dw 524
	db 1
	dw 541
	db 2
.CeladonDeptStore1F:
	map_id CELADON_DEPT_STORE_1F
	dw 525
	db 0
	dw 543
	db 1
.CeladonDeptStore2F:
	map_id CELADON_DEPT_STORE_2F
	dw 525
	db 0
	dw 544
	db 1
.CeladonDeptStore3F:
	map_id CELADON_DEPT_STORE_3F
	dw 525
	db 0
	dw 545
	db 1
.CeladonDeptStore4F:
	map_id CELADON_DEPT_STORE_4F
	dw 525
	db 0
	dw 546
	db 1
.CeladonDeptStore5F:
	map_id CELADON_DEPT_STORE_5F
	dw 525
	db 0
	dw 547
	db 1
.CeladonDeptStore6F:
	map_id CELADON_DEPT_STORE_6F
	dw 525
	db 0
	dw 548
	db 1
.CeladonDeptStoreElevator:
	map_id CELADON_DEPT_STORE_ELEVATOR
	dw 525
	db 0
	dw 549
	db 1
.CeladonMansion1F:
	map_id CELADON_MANSION_1F
	dw 525
	db 0
	dw 550
	db 3
.CeladonMansion2F:
	map_id CELADON_MANSION_2F
	dw 525
	db 0
	dw 553
	db 2
.CeladonMansion3F:
	map_id CELADON_MANSION_3F
	dw 525
	db 0
	dw 555
	db 2
.CeladonMansionRoof:
	map_id CELADON_MANSION_ROOF
	dw 525
	db 0
	dw 557
	db 2
.CeladonMansionRoofHouse:
	map_id CELADON_MANSION_ROOF_HOUSE
	dw 525
	db 0
	dw 559
	db 1
.CeladonPokecenter1F:
	map_id CELADON_POKECENTER_1F
	dw 525
	db 0
	dw 560
	db 1
.CeladonPokecenter2FBeta:
	map_id CELADON_POKECENTER_2F_BETA
	dw 525
	db 0
	dw 0
	db 0
.CeladonGameCorner:
	map_id CELADON_GAME_CORNER
	dw 525
	db 0
	dw 561
	db 1
.CeladonGameCornerPrizeRoom:
	map_id CELADON_GAME_CORNER_PRIZE_ROOM
	dw 525
	db 0
	dw 562
	db 1
.CeladonGym:
	map_id CELADON_GYM
	dw 525
	db 5
	dw 563
	db 1
.CeladonCafe:
	map_id CELADON_CAFE
	dw 530
	db 0
	dw 564
	db 1
.Route16FuchsiaSpeechHouse:
	map_id ROUTE_16_FUCHSIA_SPEECH_HOUSE
	dw 530
	db 0
	dw 565
	db 1
.Route16Gate:
	map_id ROUTE_16_GATE
	dw 530
	db 0
	dw 566
	db 1
.Route7SaffronGate:
	map_id ROUTE_7_SAFFRON_GATE
	dw 530
	db 0
	dw 567
	db 1
.Route17Route18Gate:
	map_id ROUTE_17_ROUTE_18_GATE
	dw 530
	db 0
	dw 568
	db 1
.Route40:
	map_id ROUTE_40
	dw 530
	db 5
	dw 569
	db 3
.Route41:
	map_id ROUTE_41
	dw 535
	db 11
	dw 572
	db 9
.CianwoodCity:
	map_id CIANWOOD_CITY
	dw 546
	db 2
	dw 581
	db 2
.ManiasHouse:
	map_id MANIAS_HOUSE
	dw 548
	db 0
	dw 583
	db 1
.CianwoodGym:
	map_id CIANWOOD_GYM
	dw 548
	db 4
	dw 584
	db 1
.CianwoodPokecenter1F:
	map_id CIANWOOD_POKECENTER_1F
	dw 552
	db 0
	dw 585
	db 1
.CianwoodPharmacy:
	map_id CIANWOOD_PHARMACY
	dw 552
	db 0
	dw 586
	db 1
.CianwoodPhotoStudio:
	map_id CIANWOOD_PHOTO_STUDIO
	dw 552
	db 0
	dw 587
	db 1
.CianwoodLugiaSpeechHouse:
	map_id CIANWOOD_LUGIA_SPEECH_HOUSE
	dw 552
	db 0
	dw 588
	db 1
.PokeSeersHouse:
	map_id POKE_SEERS_HOUSE
	dw 552
	db 0
	dw 589
	db 1
.BattleTower1F:
	map_id BATTLE_TOWER_1F
	dw 552
	db 0
	dw 0
	db 0
.BattleTowerBattleRoom:
	map_id BATTLE_TOWER_BATTLE_ROOM
	dw 552
	db 0
	dw 0
	db 0
.BattleTowerElevator:
	map_id BATTLE_TOWER_ELEVATOR
	dw 552
	db 0
	dw 0
	db 0
.BattleTowerHallway:
	map_id BATTLE_TOWER_HALLWAY
	dw 552
	db 0
	dw 0
	db 0
.Route40BattleTowerGate:
	map_id ROUTE_40_BATTLE_TOWER_GATE
	dw 552
	db 0
	dw 0
	db 0
.BattleTowerOutside:
	map_id BATTLE_TOWER_OUTSIDE
	dw 552
	db 0
	dw 0
	db 0
.Route2:
	map_id ROUTE_2
	dw 552
	db 11
	dw 590
	db 5
.Route22:
	map_id ROUTE_22
	dw 563
	db 0
	dw 595
	db 2
.ViridianCity:
	map_id VIRIDIAN_CITY
	dw 563
	db 0
	dw 597
	db 7
.ViridianGym:
	map_id VIRIDIAN_GYM
	dw 563
	db 0
	dw 604
	db 1
.ViridianNicknameSpeechHouse:
	map_id VIRIDIAN_NICKNAME_SPEECH_HOUSE
	dw 563
	db 0
	dw 605
	db 1
.TrainerHouse1F:
	map_id TRAINER_HOUSE_1F
	dw 563
	db 0
	dw 606
	db 1
.TrainerHouseB1F:
	map_id TRAINER_HOUSE_B1F
	dw 563
	db 0
	dw 607
	db 1
.ViridianMart:
	map_id VIRIDIAN_MART
	dw 563
	db 0
	dw 608
	db 1
.ViridianPokecenter1F:
	map_id VIRIDIAN_POKECENTER_1F
	dw 563
	db 0
	dw 609
	db 1
.ViridianPokecenter2FBeta:
	map_id VIRIDIAN_POKECENTER_2F_BETA
	dw 563
	db 0
	dw 0
	db 0
.Route2NuggetHouse:
	map_id ROUTE_2_NUGGET_HOUSE
	dw 563
	db 0
	dw 610
	db 1
.Route2Gate:
	map_id ROUTE_2_GATE
	dw 563
	db 0
	dw 611
	db 1
.VictoryRoadGate:
	map_id VICTORY_ROAD_GATE
	dw 563
	db 0
	dw 612
	db 1
.Route26:
	map_id ROUTE_26
	dw 563
	db 7
	dw 613
	db 5
.Route27:
	map_id ROUTE_27
	dw 570
	db 8
	dw 618
	db 9
.Route29:
	map_id ROUTE_29
	dw 578
	db 1
	dw 627
	db 1
.NewBarkTown:
	map_id NEW_BARK_TOWN
	dw 579
	db 0
	dw 628
	db 2
.ElmsLab:
	map_id ELMS_LAB
	dw 579
	db 0
	dw 630
	db 1
.PlayersHouse1F:
	map_id PLAYERS_HOUSE_1F
	dw 579
	db 0
	dw 631
	db 1
.PlayersHouse2F:
	map_id PLAYERS_HOUSE_2F
	dw 579
	db 0
	dw 632
	db 1
.PlayersNeighborsHouse:
	map_id PLAYERS_NEIGHBORS_HOUSE
	dw 579
	db 0
	dw 633
	db 1
.ElmsHouse:
	map_id ELMS_HOUSE
	dw 579
	db 0
	dw 634
	db 1
.Route26HealHouse:
	map_id ROUTE_26_HEAL_HOUSE
	dw 579
	db 0
	dw 635
	db 1
.DayOfWeekSiblingsHouse:
	map_id DAY_OF_WEEK_SIBLINGS_HOUSE
	dw 579
	db 0
	dw 636
	db 1
.Route27SandstormHouse:
	map_id ROUTE_27_SANDSTORM_HOUSE
	dw 579
	db 0
	dw 637
	db 1
.Route29Route46Gate:
	map_id ROUTE_29_ROUTE_46_GATE
	dw 579
	db 0
	dw 638
	db 1
.Route5:
	map_id ROUTE_5
	dw 579
	db 0
	dw 639
	db 3
.SaffronCity:
	map_id SAFFRON_CITY
	dw 579
	db 0
	dw 642
	db 2
.FightingDojo:
	map_id FIGHTING_DOJO
	dw 579
	db 1
	dw 644
	db 1
.SaffronGym:
	map_id SAFFRON_GYM
	dw 580
	db 4
	dw 645
	db 9
.SaffronMart:
	map_id SAFFRON_MART
	dw 584
	db 0
	dw 654
	db 1
.SaffronPokecenter1F:
	map_id SAFFRON_POKECENTER_1F
	dw 584
	db 0
	dw 655
	db 1
.SaffronPokecenter2FBeta:
	map_id SAFFRON_POKECENTER_2F_BETA
	dw 584
	db 0
	dw 0
	db 0
.MrPsychicsHouse:
	map_id MR_PSYCHICS_HOUSE
	dw 584
	db 0
	dw 656
	db 1
.SaffronMagnetTrainStation:
	map_id SAFFRON_MAGNET_TRAIN_STATION
	dw 584
	db 0
	dw 657
	db 1
.SilphCo1F:
	map_id SILPH_CO_1F
	dw 584
	db 0
	dw 658
	db 1
.CopycatsHouse1F:
	map_id COPYCATS_HOUSE_1F
	dw 584
	db 0
	dw 659
	db 1
.CopycatsHouse2F:
	map_id COPYCATS_HOUSE_2F
	dw 584
	db 0
	dw 660
	db 1
.Route5UndergroundPathEntrance:
	map_id ROUTE_5_UNDERGROUND_PATH_ENTRANCE
	dw 584
	db 0
	dw 661
	db 1
.Route5SaffronGate:
	map_id ROUTE_5_SAFFRON_GATE
	dw 584
	db 0
	dw 662
	db 1
.Route5CleanseTagHouse:
	map_id ROUTE_5_CLEANSE_TAG_HOUSE
	dw 584
	db 0
	dw 663
	db 1
.Route30:
	map_id ROUTE_30
	dw 584
	db 5
	dw 664
	db 1
.Route31:
	map_id ROUTE_31
	dw 589
	db 3
	dw 665
	db 2
.CherrygroveCity:
	map_id CHERRYGROVE_CITY
	dw 592
	db 0
	dw 667
	db 1
.CherrygroveMart:
	map_id CHERRYGROVE_MART
	dw 592
	db 0
	dw 668
	db 1
.CherrygrovePokecenter1F:
	map_id CHERRYGROVE_POKECENTER_1F
	dw 592
	db 0
	dw 669
	db 1
.CherrygroveGymSpeechHouse:
	map_id CHERRYGROVE_GYM_SPEECH_HOUSE
	dw 592
	db 0
	dw 670
	db 1
.GuideGentsHouse:
	map_id GUIDE_GENTS_HOUSE
	dw 592
	db 0
	dw 671
	db 1
.CherrygroveEvolutionSpeechHouse:
	map_id CHERRYGROVE_EVOLUTION_SPEECH_HOUSE
	dw 592
	db 0
	dw 672
	db 1
.Route30BerryHouse:
	map_id ROUTE_30_BERRY_HOUSE
	dw 592
	db 0
	dw 673
	db 1
.MrPokemonsHouse:
	map_id MR_POKEMONS_HOUSE
	dw 592
	db 0
	dw 674
	db 1
.Route31VioletGate:
	map_id ROUTE_31_VIOLET_GATE
	dw 592
	db 0
	dw 675
	db 1

	assert NUM_DEMO_TARGETS == 592, "NUM_DEMO_TARGETS (constants/demo_constants.asm) should be 592"

DemoTargets:
; kind (DTARGET_*), object (from 1) or x, y, the event flag that marks it done
	table_width 5
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SCHOOLBOY_CHAD ; ROUTE_38: SCHOOLBOY CHAD1
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_LASS_DANA ; ROUTE_38: LASS DANA1
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_BIRD_KEEPER_TOBY ; ROUTE_38: BIRD_KEEPER TOBY
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_BEAUTY_VALERIE ; ROUTE_38: BEAUTY VALERIE
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_SAILOR_HARRY ; ROUTE_38: SAILOR HARRY
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_BEAUTY_OLIVIA ; ROUTE_38: BEAUTY OLIVIA
	db DTARGET_HIDDEN, 5, 13
	dw EVENT_ROUTE_39_HIDDEN_NUGGET ; ROUTE_39: NUGGET
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SAILOR_EUGENE ; ROUTE_39: SAILOR EUGENE
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_POKEFANM_DEREK ; ROUTE_39: POKEFANM DEREK1
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_POKEFANF_RUTH ; ROUTE_39: POKEFANF RUTH
	db DTARGET_TRAINER, 8, 0
	dw EVENT_BEAT_PSYCHIC_NORMAN ; ROUTE_39: PSYCHIC_T NORMAN
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_SKIER_ROXANNE ; MAHOGANY_GYM: SKIER ROXANNE
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_BOARDER_RONALD ; MAHOGANY_GYM: BOARDER RONALD
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_SKIER_CLARISSA ; MAHOGANY_GYM: SKIER CLARISSA
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_BOARDER_BRAD ; MAHOGANY_GYM: BOARDER BRAD
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_BOARDER_DOUGLAS ; MAHOGANY_GYM: BOARDER DOUGLAS
	db DTARGET_HIDDEN, 16, 11
	dw EVENT_ROUTE_42_HIDDEN_MAX_POTION ; ROUTE_42: MAX_POTION
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_FISHER_TULLY ; ROUTE_42: FISHER TULLY1
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_HIKER_BENJAMIN ; ROUTE_42: HIKER BENJAMIN
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_POKEMANIAC_SHANE ; ROUTE_42: POKEMANIAC SHANE
	db DTARGET_ITEMBALL, 7, 0
	dw EVENT_ROUTE_42_ULTRA_BALL ; ROUTE_42: ULTRA_BALL
	db DTARGET_ITEMBALL, 8, 0
	dw EVENT_ROUTE_42_SUPER_POTION ; ROUTE_42: SUPER_POTION
	db DTARGET_HIDDEN, 32, 9
	dw EVENT_ROUTE_44_HIDDEN_ELIXER ; ROUTE_44: ELIXER
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_FISHER_WILTON ; ROUTE_44: FISHER WILTON1
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_FISHER_EDGAR ; ROUTE_44: FISHER EDGAR
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_PSYCHIC_PHIL ; ROUTE_44: PSYCHIC_T PHIL
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_POKEMANIAC_ZACH ; ROUTE_44: POKEMANIAC ZACH
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_BIRD_KEEPER_VANCE ; ROUTE_44: BIRD_KEEPER VANCE1
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_COOLTRAINERM_ALLEN ; ROUTE_44: COOLTRAINERM ALLEN
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_COOLTRAINERF_CYBIL ; ROUTE_44: COOLTRAINERF CYBIL
	db DTARGET_ITEMBALL, 9, 0
	dw EVENT_ROUTE_44_MAX_REVIVE ; ROUTE_44: MAX_REVIVE
	db DTARGET_ITEMBALL, 10, 0
	dw EVENT_ROUTE_44_ULTRA_BALL ; ROUTE_44: ULTRA_BALL
	db DTARGET_ITEMBALL, 11, 0
	dw EVENT_ROUTE_44_MAX_REPEL ; ROUTE_44: MAX_REPEL
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_SAGE_CHOW ; SPROUT_TOWER_1F: SAGE CHOW
	db DTARGET_ITEMBALL, 6, 0
	dw EVENT_SPROUT_TOWER_1F_PARLYZ_HEAL ; SPROUT_TOWER_1F: PARLYZ_HEAL
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SAGE_NICO ; SPROUT_TOWER_2F: SAGE NICO
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_SAGE_EDMOND ; SPROUT_TOWER_2F: SAGE EDMOND
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_SPROUT_TOWER_2F_X_ACCURACY ; SPROUT_TOWER_2F: X_ACCURACY
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SAGE_JIN ; SPROUT_TOWER_3F: SAGE JIN
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_SAGE_TROY ; SPROUT_TOWER_3F: SAGE TROY
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_SAGE_NEAL ; SPROUT_TOWER_3F: SAGE NEAL
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_SPROUT_TOWER_3F_POTION ; SPROUT_TOWER_3F: POTION
	db DTARGET_ITEMBALL, 6, 0
	dw EVENT_SPROUT_TOWER_3F_ESCAPE_ROPE ; SPROUT_TOWER_3F: ESCAPE_ROPE
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_TIN_TOWER_3F_FULL_HEAL ; TIN_TOWER_3F: FULL_HEAL
	db DTARGET_HIDDEN, 11, 6
	dw EVENT_TIN_TOWER_4F_HIDDEN_MAX_POTION ; TIN_TOWER_4F: MAX_POTION
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_TIN_TOWER_4F_ULTRA_BALL ; TIN_TOWER_4F: ULTRA_BALL
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_TIN_TOWER_4F_PP_UP ; TIN_TOWER_4F: PP_UP
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_TIN_TOWER_4F_ESCAPE_ROPE ; TIN_TOWER_4F: ESCAPE_ROPE
	db DTARGET_HIDDEN, 16, 14
	dw EVENT_TIN_TOWER_5F_HIDDEN_FULL_RESTORE ; TIN_TOWER_5F: FULL_RESTORE
	db DTARGET_HIDDEN, 3, 15
	dw EVENT_TIN_TOWER_5F_HIDDEN_CARBOS ; TIN_TOWER_5F: CARBOS
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_TIN_TOWER_5F_RARE_CANDY ; TIN_TOWER_5F: RARE_CANDY
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_TIN_TOWER_6F_MAX_POTION ; TIN_TOWER_6F: MAX_POTION
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_TIN_TOWER_7F_MAX_REVIVE ; TIN_TOWER_7F: MAX_REVIVE
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_TIN_TOWER_8F_NUGGET ; TIN_TOWER_8F: NUGGET
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_TIN_TOWER_8F_MAX_ELIXER ; TIN_TOWER_8F: MAX_ELIXER
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_TIN_TOWER_8F_FULL_RESTORE ; TIN_TOWER_8F: FULL_RESTORE
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_TIN_TOWER_9F_HP_UP ; TIN_TOWER_9F: HP_UP
	db DTARGET_HIDDEN, 8, 7
	dw EVENT_BURNED_TOWER_1F_HIDDEN_ETHER ; BURNED_TOWER_1F: ETHER
	db DTARGET_HIDDEN, 13, 11
	dw EVENT_BURNED_TOWER_1F_HIDDEN_ULTRA_BALL ; BURNED_TOWER_1F: ULTRA_BALL
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_BURNED_TOWER_1F_HP_UP ; BURNED_TOWER_1F: HP_UP
	db DTARGET_ITEMBALL, 8, 0
	dw EVENT_BURNED_TOWER_B1F_TM_ENDURE ; BURNED_TOWER_B1F: TM_ENDURE
	db DTARGET_HIDDEN, 6, 47
	dw EVENT_NATIONAL_PARK_HIDDEN_FULL_HEAL ; NATIONAL_PARK: FULL_HEAL
	db DTARGET_TRAINER, 8, 0
	dw EVENT_BEAT_SCHOOLBOY_JACK ; NATIONAL_PARK: SCHOOLBOY JACK1
	db DTARGET_TRAINER, 9, 0
	dw EVENT_BEAT_POKEFANF_BEVERLY ; NATIONAL_PARK: POKEFANF BEVERLY1
	db DTARGET_TRAINER, 10, 0
	dw EVENT_BEAT_POKEFANM_WILLIAM ; NATIONAL_PARK: POKEFANM WILLIAM
	db DTARGET_TRAINER, 11, 0
	dw EVENT_BEAT_LASS_KRISE ; NATIONAL_PARK: LASS KRISE
	db DTARGET_ITEMBALL, 12, 0
	dw EVENT_NATIONAL_PARK_PARLYZ_HEAL ; NATIONAL_PARK: PARLYZ_HEAL
	db DTARGET_ITEMBALL, 14, 0
	dw EVENT_NATIONAL_PARK_TM_DIG ; NATIONAL_PARK: TM_DIG
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_3 ; RADIO_TOWER_1F: GRUNTM GRUNTM_3
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_4 ; RADIO_TOWER_2F: GRUNTM GRUNTM_4
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_5 ; RADIO_TOWER_2F: GRUNTM GRUNTM_5
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_6 ; RADIO_TOWER_2F: GRUNTM GRUNTM_6
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_ROCKET_GRUNTF_2 ; RADIO_TOWER_2F: GRUNTF GRUNTF_2
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_7 ; RADIO_TOWER_3F: GRUNTM GRUNTM_7
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_8 ; RADIO_TOWER_3F: GRUNTM GRUNTM_8
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_9 ; RADIO_TOWER_3F: GRUNTM GRUNTM_9
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_SCIENTIST_MARC ; RADIO_TOWER_3F: SCIENTIST MARC
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_10 ; RADIO_TOWER_4F: GRUNTM GRUNTM_10
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_ROCKET_EXECUTIVEM_2 ; RADIO_TOWER_4F: EXECUTIVEM EXECUTIVEM_2
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_ROCKET_GRUNTF_4 ; RADIO_TOWER_4F: GRUNTF GRUNTF_4
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_SCIENTIST_RICH ; RADIO_TOWER_4F: SCIENTIST RICH
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_ROCKET_EXECUTIVEF_1 ; RADIO_TOWER_5F: EXECUTIVEF EXECUTIVEF_1
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_RADIO_TOWER_5F_ULTRA_BALL ; RADIO_TOWER_5F: ULTRA_BALL
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_PSYCHIC_NATHAN ; RUINS_OF_ALPH_OUTSIDE: PSYCHIC_T NATHAN
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_PICKED_UP_GOLD_BERRY_FROM_HO_OH_ITEM_ROOM ; RUINS_OF_ALPH_HO_OH_ITEM_ROOM: GOLD_BERRY
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_PICKED_UP_MYSTERYBERRY_FROM_HO_OH_ITEM_ROOM ; RUINS_OF_ALPH_HO_OH_ITEM_ROOM: MYSTERYBERRY
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_PICKED_UP_REVIVAL_HERB_FROM_HO_OH_ITEM_ROOM ; RUINS_OF_ALPH_HO_OH_ITEM_ROOM: REVIVAL_HERB
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_PICKED_UP_CHARCOAL_FROM_HO_OH_ITEM_ROOM ; RUINS_OF_ALPH_HO_OH_ITEM_ROOM: CHARCOAL
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_PICKED_UP_BERRY_FROM_KABUTO_ITEM_ROOM ; RUINS_OF_ALPH_KABUTO_ITEM_ROOM: BERRY
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_PICKED_UP_PSNCUREBERRY_FROM_KABUTO_ITEM_ROOM ; RUINS_OF_ALPH_KABUTO_ITEM_ROOM: PSNCUREBERRY
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_PICKED_UP_HEAL_POWDER_FROM_KABUTO_ITEM_ROOM ; RUINS_OF_ALPH_KABUTO_ITEM_ROOM: HEAL_POWDER
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_PICKED_UP_ENERGYPOWDER_FROM_KABUTO_ITEM_ROOM ; RUINS_OF_ALPH_KABUTO_ITEM_ROOM: ENERGYPOWDER
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_PICKED_UP_MYSTERYBERRY_FROM_OMANYTE_ITEM_ROOM ; RUINS_OF_ALPH_OMANYTE_ITEM_ROOM: MYSTERYBERRY
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_PICKED_UP_MYSTIC_WATER_FROM_OMANYTE_ITEM_ROOM ; RUINS_OF_ALPH_OMANYTE_ITEM_ROOM: MYSTIC_WATER
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_PICKED_UP_STARDUST_FROM_OMANYTE_ITEM_ROOM ; RUINS_OF_ALPH_OMANYTE_ITEM_ROOM: STARDUST
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_PICKED_UP_STAR_PIECE_FROM_OMANYTE_ITEM_ROOM ; RUINS_OF_ALPH_OMANYTE_ITEM_ROOM: STAR_PIECE
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_PICKED_UP_GOLD_BERRY_FROM_AERODACTYL_ITEM_ROOM ; RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM: GOLD_BERRY
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_PICKED_UP_MOON_STONE_FROM_AERODACTYL_ITEM_ROOM ; RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM: MOON_STONE
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_PICKED_UP_HEAL_POWDER_FROM_AERODACTYL_ITEM_ROOM ; RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM: HEAL_POWDER
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_PICKED_UP_ENERGY_ROOT_FROM_AERODACTYL_ITEM_ROOM ; RUINS_OF_ALPH_AERODACTYL_ITEM_ROOM: ENERGY_ROOT
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_HIKER_DANIEL ; UNION_CAVE_1F: HIKER DANIEL
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_POKEMANIAC_LARRY ; UNION_CAVE_1F: POKEMANIAC LARRY
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_HIKER_RUSSELL ; UNION_CAVE_1F: HIKER RUSSELL
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_FIREBREATHER_RAY ; UNION_CAVE_1F: FIREBREATHER RAY
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_FIREBREATHER_BILL ; UNION_CAVE_1F: FIREBREATHER BILL
	db DTARGET_ITEMBALL, 6, 0
	dw EVENT_UNION_CAVE_1F_GREAT_BALL ; UNION_CAVE_1F: GREAT_BALL
	db DTARGET_ITEMBALL, 7, 0
	dw EVENT_UNION_CAVE_1F_X_ATTACK ; UNION_CAVE_1F: X_ATTACK
	db DTARGET_ITEMBALL, 8, 0
	dw EVENT_UNION_CAVE_1F_POTION ; UNION_CAVE_1F: POTION
	db DTARGET_ITEMBALL, 9, 0
	dw EVENT_UNION_CAVE_1F_AWAKENING ; UNION_CAVE_1F: AWAKENING
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_HIKER_PHILLIP ; UNION_CAVE_B1F: HIKER PHILLIP
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_HIKER_LEONARD ; UNION_CAVE_B1F: HIKER LEONARD
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_POKEMANIAC_ANDREW ; UNION_CAVE_B1F: POKEMANIAC ANDREW
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_POKEMANIAC_CALVIN ; UNION_CAVE_B1F: POKEMANIAC CALVIN
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_UNION_CAVE_B1F_TM_SWIFT ; UNION_CAVE_B1F: TM_SWIFT
	db DTARGET_ITEMBALL, 7, 0
	dw EVENT_UNION_CAVE_B1F_X_DEFEND ; UNION_CAVE_B1F: X_DEFEND
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_COOLTRAINERM_NICK ; UNION_CAVE_B2F: COOLTRAINERM NICK
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_COOLTRAINERF_GWEN ; UNION_CAVE_B2F: COOLTRAINERF GWEN
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_COOLTRAINERF_EMMA ; UNION_CAVE_B2F: COOLTRAINERF EMMA
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_UNION_CAVE_B2F_ELIXER ; UNION_CAVE_B2F: ELIXER
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_UNION_CAVE_B2F_HYPER_POTION ; UNION_CAVE_B2F: HYPER_POTION
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_29 ; SLOWPOKE_WELL_B1F: GRUNTM GRUNTM_29
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_1 ; SLOWPOKE_WELL_B1F: GRUNTM GRUNTM_1
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_2 ; SLOWPOKE_WELL_B1F: GRUNTM GRUNTM_2
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_ROCKET_GRUNTF_1 ; SLOWPOKE_WELL_B1F: GRUNTF GRUNTF_1
	db DTARGET_ITEMBALL, 9, 0
	dw EVENT_SLOWPOKE_WELL_B1F_SUPER_POTION ; SLOWPOKE_WELL_B1F: SUPER_POTION
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_SLOWPOKE_WELL_B2F_TM_RAIN_DANCE ; SLOWPOKE_WELL_B2F: TM_RAIN_DANCE
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SAILOR_HUEY ; OLIVINE_LIGHTHOUSE_2F: SAILOR HUEY1
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_GENTLEMAN_ALFRED ; OLIVINE_LIGHTHOUSE_2F: GENTLEMAN ALFRED
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SAILOR_TERRELL ; OLIVINE_LIGHTHOUSE_3F: SAILOR TERRELL
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_GENTLEMAN_PRESTON ; OLIVINE_LIGHTHOUSE_3F: GENTLEMAN PRESTON
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_BIRD_KEEPER_THEO ; OLIVINE_LIGHTHOUSE_3F: BIRD_KEEPER THEO
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_OLIVINE_LIGHTHOUSE_3F_ETHER ; OLIVINE_LIGHTHOUSE_3F: ETHER
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SAILOR_KENT ; OLIVINE_LIGHTHOUSE_4F: SAILOR KENT
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_LASS_CONNIE ; OLIVINE_LIGHTHOUSE_4F: LASS CONNIE1
	db DTARGET_HIDDEN, 3, 13
	dw EVENT_OLIVINE_LIGHTHOUSE_5F_HIDDEN_HYPER_POTION ; OLIVINE_LIGHTHOUSE_5F: HYPER_POTION
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SAILOR_ERNEST ; OLIVINE_LIGHTHOUSE_5F: SAILOR ERNEST
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_BIRD_KEEPER_DENIS ; OLIVINE_LIGHTHOUSE_5F: BIRD_KEEPER DENIS
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_OLIVINE_LIGHTHOUSE_5F_RARE_CANDY ; OLIVINE_LIGHTHOUSE_5F: RARE_CANDY
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_OLIVINE_LIGHTHOUSE_5F_SUPER_REPEL ; OLIVINE_LIGHTHOUSE_5F: SUPER_REPEL
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_OLIVINE_LIGHTHOUSE_5F_TM_SWAGGER ; OLIVINE_LIGHTHOUSE_5F: TM_SWAGGER
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_OLIVINE_LIGHTHOUSE_6F_SUPER_POTION ; OLIVINE_LIGHTHOUSE_6F: SUPER_POTION
	db DTARGET_HIDDEN, 3, 11
	dw EVENT_TEAM_ROCKET_BASE_B1F_HIDDEN_REVIVE ; TEAM_ROCKET_BASE_B1F: REVIVE
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_16 ; TEAM_ROCKET_BASE_B1F: GRUNTM GRUNTM_16
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_SCIENTIST_JED ; TEAM_ROCKET_BASE_B1F: SCIENTIST JED
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_TEAM_ROCKET_BASE_B1F_HYPER_POTION ; TEAM_ROCKET_BASE_B1F: HYPER_POTION
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_TEAM_ROCKET_BASE_B1F_NUGGET ; TEAM_ROCKET_BASE_B1F: NUGGET
	db DTARGET_ITEMBALL, 6, 0
	dw EVENT_TEAM_ROCKET_BASE_B1F_GUARD_SPEC ; TEAM_ROCKET_BASE_B1F: GUARD_SPEC
	db DTARGET_HIDDEN, 26, 7
	dw EVENT_TEAM_ROCKET_BASE_B2F_HIDDEN_FULL_HEAL ; TEAM_ROCKET_BASE_B2F: FULL_HEAL
	db DTARGET_TRAINER, 11, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_17 ; TEAM_ROCKET_BASE_B2F: GRUNTM GRUNTM_17
	db DTARGET_TRAINER, 12, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_18 ; TEAM_ROCKET_BASE_B2F: GRUNTM GRUNTM_18
	db DTARGET_TRAINER, 13, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_19 ; TEAM_ROCKET_BASE_B2F: GRUNTM GRUNTM_19
	db DTARGET_ITEMBALL, 14, 0
	dw EVENT_TEAM_ROCKET_BASE_B2F_TM_THIEF ; TEAM_ROCKET_BASE_B2F: TM_THIEF
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_ROCKET_GRUNTF_5 ; TEAM_ROCKET_BASE_B3F: GRUNTF GRUNTF_5
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_28 ; TEAM_ROCKET_BASE_B3F: GRUNTM GRUNTM_28
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_SCIENTIST_ROSS ; TEAM_ROCKET_BASE_B3F: SCIENTIST ROSS
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_SCIENTIST_MITCH ; TEAM_ROCKET_BASE_B3F: SCIENTIST MITCH
	db DTARGET_ITEMBALL, 10, 0
	dw EVENT_TEAM_ROCKET_BASE_B3F_PROTEIN ; TEAM_ROCKET_BASE_B3F: PROTEIN
	db DTARGET_ITEMBALL, 11, 0
	dw EVENT_TEAM_ROCKET_BASE_B3F_X_SPECIAL ; TEAM_ROCKET_BASE_B3F: X_SPECIAL
	db DTARGET_ITEMBALL, 12, 0
	dw EVENT_TEAM_ROCKET_BASE_B3F_FULL_HEAL ; TEAM_ROCKET_BASE_B3F: FULL_HEAL
	db DTARGET_ITEMBALL, 13, 0
	dw EVENT_TEAM_ROCKET_BASE_B3F_ICE_HEAL ; TEAM_ROCKET_BASE_B3F: ICE_HEAL
	db DTARGET_ITEMBALL, 14, 0
	dw EVENT_TEAM_ROCKET_BASE_B3F_ULTRA_BALL ; TEAM_ROCKET_BASE_B3F: ULTRA_BALL
	db DTARGET_HIDDEN, 11, 7
	dw EVENT_ILEX_FOREST_HIDDEN_ETHER ; ILEX_FOREST: ETHER
	db DTARGET_HIDDEN, 22, 14
	dw EVENT_ILEX_FOREST_HIDDEN_SUPER_POTION ; ILEX_FOREST: SUPER_POTION
	db DTARGET_HIDDEN, 1, 17
	dw EVENT_ILEX_FOREST_HIDDEN_FULL_HEAL ; ILEX_FOREST: FULL_HEAL
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_ILEX_FOREST_REVIVE ; ILEX_FOREST: REVIVE
	db DTARGET_TRAINER, 8, 0
	dw EVENT_BEAT_BUG_CATCHER_WAYNE ; ILEX_FOREST: BUG_CATCHER WAYNE
	db DTARGET_ITEMBALL, 9, 0
	dw EVENT_ILEX_FOREST_X_ATTACK ; ILEX_FOREST: X_ATTACK
	db DTARGET_ITEMBALL, 10, 0
	dw EVENT_ILEX_FOREST_ANTIDOTE ; ILEX_FOREST: ANTIDOTE
	db DTARGET_ITEMBALL, 11, 0
	dw EVENT_ILEX_FOREST_ETHER ; ILEX_FOREST: ETHER
	db DTARGET_HIDDEN, 6, 13
	dw EVENT_GOLDENROD_UNDERGROUND_HIDDEN_PARLYZ_HEAL ; GOLDENROD_UNDERGROUND: PARLYZ_HEAL
	db DTARGET_HIDDEN, 4, 18
	dw EVENT_GOLDENROD_UNDERGROUND_HIDDEN_SUPER_POTION ; GOLDENROD_UNDERGROUND: SUPER_POTION
	db DTARGET_HIDDEN, 17, 8
	dw EVENT_GOLDENROD_UNDERGROUND_HIDDEN_ANTIDOTE ; GOLDENROD_UNDERGROUND: ANTIDOTE
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SUPER_NERD_ERIC ; GOLDENROD_UNDERGROUND: SUPER_NERD ERIC
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_SUPER_NERD_TERU ; GOLDENROD_UNDERGROUND: SUPER_NERD TERU
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_POKEMANIAC_ISSAC ; GOLDENROD_UNDERGROUND: POKEMANIAC ISSAC
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_POKEMANIAC_DONALD ; GOLDENROD_UNDERGROUND: POKEMANIAC DONALD
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_GOLDENROD_UNDERGROUND_COIN_CASE ; GOLDENROD_UNDERGROUND: COIN_CASE
	db DTARGET_HIDDEN, 8, 9
	dw EVENT_GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES_HIDDEN_MAX_POTION ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES: MAX_POTION
	db DTARGET_HIDDEN, 1, 8
	dw EVENT_GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES_HIDDEN_REVIVE ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES: REVIVE
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_BURGLAR_DUNCAN ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES: BURGLAR DUNCAN
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_BURGLAR_EDDIE ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES: BURGLAR EDDIE
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_13 ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES: GRUNTM GRUNTM_13
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_11 ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES: GRUNTM GRUNTM_11
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_25 ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES: GRUNTM GRUNTM_25
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_ROCKET_GRUNTF_3 ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES: GRUNTF GRUNTF_3
	db DTARGET_ITEMBALL, 9, 0
	dw EVENT_GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES_SMOKE_BALL ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES: SMOKE_BALL
	db DTARGET_ITEMBALL, 10, 0
	dw EVENT_GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES_FULL_HEAL ; GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES: FULL_HEAL
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_GOLDENROD_DEPT_STORE_B1F_ETHER ; GOLDENROD_DEPT_STORE_B1F: ETHER
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_GOLDENROD_DEPT_STORE_B1F_AMULET_COIN ; GOLDENROD_DEPT_STORE_B1F: AMULET_COIN
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_GOLDENROD_DEPT_STORE_B1F_BURN_HEAL ; GOLDENROD_DEPT_STORE_B1F: BURN_HEAL
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_GOLDENROD_DEPT_STORE_B1F_ULTRA_BALL ; GOLDENROD_DEPT_STORE_B1F: ULTRA_BALL
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_24 ; GOLDENROD_UNDERGROUND_WAREHOUSE: GRUNTM GRUNTM_24
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_14 ; GOLDENROD_UNDERGROUND_WAREHOUSE: GRUNTM GRUNTM_14
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_ROCKET_GRUNTM_15 ; GOLDENROD_UNDERGROUND_WAREHOUSE: GRUNTM GRUNTM_15
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_GOLDENROD_UNDERGROUND_WAREHOUSE_MAX_ETHER ; GOLDENROD_UNDERGROUND_WAREHOUSE: MAX_ETHER
	db DTARGET_ITEMBALL, 6, 0
	dw EVENT_GOLDENROD_UNDERGROUND_WAREHOUSE_TM_SLEEP_TALK ; GOLDENROD_UNDERGROUND_WAREHOUSE: TM_SLEEP_TALK
	db DTARGET_ITEMBALL, 7, 0
	dw EVENT_GOLDENROD_UNDERGROUND_WAREHOUSE_ULTRA_BALL ; GOLDENROD_UNDERGROUND_WAREHOUSE: ULTRA_BALL
	db DTARGET_HIDDEN, 25, 22
	dw EVENT_MOUNT_MORTAR_1F_OUTSIDE_HIDDEN_HYPER_POTION ; MOUNT_MORTAR_1F_OUTSIDE: HYPER_POTION
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_MOUNT_MORTAR_1F_OUTSIDE_ETHER ; MOUNT_MORTAR_1F_OUTSIDE: ETHER
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_MOUNT_MORTAR_1F_OUTSIDE_REVIVE ; MOUNT_MORTAR_1F_OUTSIDE: REVIVE
	db DTARGET_HIDDEN, 30, 11
	dw EVENT_MOUNT_MORTAR_1F_INSIDE_HIDDEN_MAX_REPEL ; MOUNT_MORTAR_1F_INSIDE: MAX_REPEL
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_MOUNT_MORTAR_1F_INSIDE_ESCAPE_ROPE ; MOUNT_MORTAR_1F_INSIDE: ESCAPE_ROPE
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_MOUNT_MORTAR_1F_INSIDE_MAX_REVIVE ; MOUNT_MORTAR_1F_INSIDE: MAX_REVIVE
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_MOUNT_MORTAR_1F_INSIDE_HYPER_POTION ; MOUNT_MORTAR_1F_INSIDE: HYPER_POTION
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_MOUNT_MORTAR_1F_INSIDE_MAX_POTION ; MOUNT_MORTAR_1F_INSIDE: MAX_POTION
	db DTARGET_ITEMBALL, 6, 0
	dw EVENT_MOUNT_MORTAR_1F_INSIDE_NUGGET ; MOUNT_MORTAR_1F_INSIDE: NUGGET
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_POKEMANIAC_MILLER ; MOUNT_MORTAR_1F_INSIDE: POKEMANIAC MILLER
	db DTARGET_TRAINER, 8, 0
	dw EVENT_BEAT_SUPER_NERD_MARKUS ; MOUNT_MORTAR_1F_INSIDE: SUPER_NERD MARKUS
	db DTARGET_ITEMBALL, 9, 0
	dw EVENT_MOUNT_MORTAR_1F_INSIDE_IRON ; MOUNT_MORTAR_1F_INSIDE: IRON
	db DTARGET_ITEMBALL, 10, 0
	dw EVENT_MOUNT_MORTAR_1F_INSIDE_ULTRA_BALL ; MOUNT_MORTAR_1F_INSIDE: ULTRA_BALL
	db DTARGET_HIDDEN, 24, 8
	dw EVENT_MOUNT_MORTAR_2F_INSIDE_HIDDEN_FULL_RESTORE ; MOUNT_MORTAR_2F_INSIDE: FULL_RESTORE
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_MOUNT_MORTAR_2F_INSIDE_MAX_POTION ; MOUNT_MORTAR_2F_INSIDE: MAX_POTION
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_MOUNT_MORTAR_2F_INSIDE_RARE_CANDY ; MOUNT_MORTAR_2F_INSIDE: RARE_CANDY
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_MOUNT_MORTAR_2F_INSIDE_TM_DEFENSE_CURL ; MOUNT_MORTAR_2F_INSIDE: TM_DEFENSE_CURL
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_MOUNT_MORTAR_2F_INSIDE_DRAGON_SCALE ; MOUNT_MORTAR_2F_INSIDE: DRAGON_SCALE
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_MOUNT_MORTAR_2F_INSIDE_ELIXER ; MOUNT_MORTAR_2F_INSIDE: ELIXER
	db DTARGET_ITEMBALL, 6, 0
	dw EVENT_MOUNT_MORTAR_2F_INSIDE_ESCAPE_ROPE ; MOUNT_MORTAR_2F_INSIDE: ESCAPE_ROPE
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_SUPER_NERD_HUGH ; MOUNT_MORTAR_2F_INSIDE: SUPER_NERD HUGH
	db DTARGET_HIDDEN, 4, 6
	dw EVENT_MOUNT_MORTAR_B1F_HIDDEN_MAX_REVIVE ; MOUNT_MORTAR_B1F: MAX_REVIVE
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_MOUNT_MORTAR_B1F_HYPER_POTION ; MOUNT_MORTAR_B1F: HYPER_POTION
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_MOUNT_MORTAR_B1F_CARBOS ; MOUNT_MORTAR_B1F: CARBOS
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_MOUNT_MORTAR_B1F_FULL_RESTORE ; MOUNT_MORTAR_B1F: FULL_RESTORE
	db DTARGET_ITEMBALL, 6, 0
	dw EVENT_MOUNT_MORTAR_B1F_MAX_ETHER ; MOUNT_MORTAR_B1F: MAX_ETHER
	db DTARGET_ITEMBALL, 7, 0
	dw EVENT_MOUNT_MORTAR_B1F_PP_UP ; MOUNT_MORTAR_B1F: PP_UP
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_GOT_HM07_WATERFALL ; ICE_PATH_1F: HM_WATERFALL
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_ICE_PATH_1F_PP_UP ; ICE_PATH_1F: PP_UP
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_ICE_PATH_1F_PROTEIN ; ICE_PATH_1F: PROTEIN
	db DTARGET_HIDDEN, 17, 30
	dw EVENT_ICE_PATH_B1F_HIDDEN_MAX_POTION ; ICE_PATH_B1F: MAX_POTION
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_ICE_PATH_B1F_IRON ; ICE_PATH_B1F: IRON
	db DTARGET_HIDDEN, 0, 17
	dw EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_HIDDEN_CARBOS ; ICE_PATH_B2F_MAHOGANY_SIDE: CARBOS
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_FULL_HEAL ; ICE_PATH_B2F_MAHOGANY_SIDE: FULL_HEAL
	db DTARGET_ITEMBALL, 6, 0
	dw EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_MAX_POTION ; ICE_PATH_B2F_MAHOGANY_SIDE: MAX_POTION
	db DTARGET_HIDDEN, 2, 10
	dw EVENT_ICE_PATH_B2F_BLACKTHORN_SIDE_HIDDEN_ICE_HEAL ; ICE_PATH_B2F_BLACKTHORN_SIDE: ICE_HEAL
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_ICE_PATH_B2F_BLACKTHORN_SIDE_TM_REST ; ICE_PATH_B2F_BLACKTHORN_SIDE: TM_REST
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_ICE_PATH_B3F_NEVERMELTICE ; ICE_PATH_B3F: NEVERMELTICE
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_WHIRL_ISLAND_NE_ULTRA_BALL ; WHIRL_ISLAND_NE: ULTRA_BALL
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_WHIRL_ISLAND_SW_ULTRA_BALL ; WHIRL_ISLAND_SW: ULTRA_BALL
	db DTARGET_HIDDEN, 30, 4
	dw EVENT_WHIRL_ISLAND_B1F_HIDDEN_RARE_CANDY ; WHIRL_ISLAND_B1F: RARE_CANDY
	db DTARGET_HIDDEN, 36, 18
	dw EVENT_WHIRL_ISLAND_B1F_HIDDEN_ULTRA_BALL ; WHIRL_ISLAND_B1F: ULTRA_BALL
	db DTARGET_HIDDEN, 2, 23
	dw EVENT_WHIRL_ISLAND_B1F_HIDDEN_FULL_RESTORE ; WHIRL_ISLAND_B1F: FULL_RESTORE
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_WHIRL_ISLAND_B1F_FULL_RESTORE ; WHIRL_ISLAND_B1F: FULL_RESTORE
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_WHIRL_ISLAND_B1F_CARBOS ; WHIRL_ISLAND_B1F: CARBOS
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_WHIRL_ISLAND_B1F_CALCIUM ; WHIRL_ISLAND_B1F: CALCIUM
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_WHIRL_ISLAND_B1F_NUGGET ; WHIRL_ISLAND_B1F: NUGGET
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_WHIRL_ISLAND_B1F_ESCAPE_ROPE ; WHIRL_ISLAND_B1F: ESCAPE_ROPE
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_WHIRL_ISLAND_B2F_FULL_RESTORE ; WHIRL_ISLAND_B2F: FULL_RESTORE
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_WHIRL_ISLAND_B2F_MAX_REVIVE ; WHIRL_ISLAND_B2F: MAX_REVIVE
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_WHIRL_ISLAND_B2F_MAX_ELIXER ; WHIRL_ISLAND_B2F: MAX_ELIXER
	db DTARGET_HIDDEN, 16, 23
	dw EVENT_SILVER_CAVE_ROOM_1_HIDDEN_DIRE_HIT ; SILVER_CAVE_ROOM_1: DIRE_HIT
	db DTARGET_HIDDEN, 17, 12
	dw EVENT_SILVER_CAVE_ROOM_1_HIDDEN_ULTRA_BALL ; SILVER_CAVE_ROOM_1: ULTRA_BALL
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_SILVER_CAVE_ROOM_1_MAX_ELIXER ; SILVER_CAVE_ROOM_1: MAX_ELIXER
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_SILVER_CAVE_ROOM_1_PROTEIN ; SILVER_CAVE_ROOM_1: PROTEIN
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_SILVER_CAVE_ROOM_1_ESCAPE_ROPE ; SILVER_CAVE_ROOM_1: ESCAPE_ROPE
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_SILVER_CAVE_ROOM_1_ULTRA_BALL ; SILVER_CAVE_ROOM_1: ULTRA_BALL
	db DTARGET_HIDDEN, 14, 31
	dw EVENT_SILVER_CAVE_ROOM_2_HIDDEN_MAX_POTION ; SILVER_CAVE_ROOM_2: MAX_POTION
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_SILVER_CAVE_ROOM_2_CALCIUM ; SILVER_CAVE_ROOM_2: CALCIUM
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_SILVER_CAVE_ROOM_2_ULTRA_BALL ; SILVER_CAVE_ROOM_2: ULTRA_BALL
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_SILVER_CAVE_ROOM_2_PP_UP ; SILVER_CAVE_ROOM_2: PP_UP
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_SILVER_CAVE_ITEM_ROOMS_MAX_REVIVE ; SILVER_CAVE_ITEM_ROOMS: MAX_REVIVE
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_SILVER_CAVE_ITEM_ROOMS_FULL_RESTORE ; SILVER_CAVE_ITEM_ROOMS: FULL_RESTORE
	db DTARGET_HIDDEN, 26, 3
	dw EVENT_DARK_CAVE_VIOLET_ENTRANCE_HIDDEN_ELIXER ; DARK_CAVE_VIOLET_ENTRANCE: ELIXER
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_DARK_CAVE_VIOLET_ENTRANCE_POTION ; DARK_CAVE_VIOLET_ENTRANCE: POTION
	db DTARGET_ITEMBALL, 6, 0
	dw EVENT_DARK_CAVE_VIOLET_ENTRANCE_FULL_HEAL ; DARK_CAVE_VIOLET_ENTRANCE: FULL_HEAL
	db DTARGET_ITEMBALL, 7, 0
	dw EVENT_DARK_CAVE_VIOLET_ENTRANCE_HYPER_POTION ; DARK_CAVE_VIOLET_ENTRANCE: HYPER_POTION
	db DTARGET_ITEMBALL, 8, 0
	dw EVENT_DARK_CAVE_VIOLET_ENTRANCE_DIRE_HIT ; DARK_CAVE_VIOLET_ENTRANCE: DIRE_HIT
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_DARK_CAVE_BLACKTHORN_ENTRANCE_REVIVE ; DARK_CAVE_BLACKTHORN_ENTRANCE: REVIVE
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_DARK_CAVE_BLACKTHORN_ENTRANCE_TM_SNORE ; DARK_CAVE_BLACKTHORN_ENTRANCE: TM_SNORE
	db DTARGET_HIDDEN, 33, 29
	dw EVENT_DRAGONS_DEN_B1F_HIDDEN_REVIVE ; DRAGONS_DEN_B1F: REVIVE
	db DTARGET_HIDDEN, 21, 17
	dw EVENT_DRAGONS_DEN_B1F_HIDDEN_MAX_POTION ; DRAGONS_DEN_B1F: MAX_POTION
	db DTARGET_HIDDEN, 31, 15
	dw EVENT_DRAGONS_DEN_B1F_HIDDEN_MAX_ELIXER ; DRAGONS_DEN_B1F: MAX_ELIXER
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_COOLTRAINERM_DARIN ; DRAGONS_DEN_B1F: COOLTRAINERM DARIN
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_COOLTRAINERF_CARA ; DRAGONS_DEN_B1F: COOLTRAINERF CARA
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_TWINS_LEA_AND_PIA ; DRAGONS_DEN_B1F: TWINS LEAANDPIA1
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_TWINS_LEA_AND_PIA ; DRAGONS_DEN_B1F: TWINS LEAANDPIA1
	db DTARGET_ITEMBALL, 8, 0
	dw EVENT_DRAGONS_DEN_B1F_CALCIUM ; DRAGONS_DEN_B1F: CALCIUM
	db DTARGET_ITEMBALL, 9, 0
	dw EVENT_DRAGONS_DEN_B1F_MAX_ELIXER ; DRAGONS_DEN_B1F: MAX_ELIXER
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_TOHJO_FALLS_MOON_STONE ; TOHJO_FALLS: MOON_STONE
	db DTARGET_HIDDEN, 6, 11
	dw EVENT_DIGLETTS_CAVE_HIDDEN_MAX_REVIVE ; DIGLETTS_CAVE: MAX_REVIVE
	db DTARGET_HIDDEN, 3, 9
	dw EVENT_UNDERGROUND_PATH_HIDDEN_FULL_RESTORE ; UNDERGROUND_PATH: FULL_RESTORE
	db DTARGET_HIDDEN, 1, 19
	dw EVENT_UNDERGROUND_PATH_HIDDEN_X_SPECIAL ; UNDERGROUND_PATH: X_SPECIAL
	db DTARGET_HIDDEN, 24, 4
	dw EVENT_ROCK_TUNNEL_1F_HIDDEN_X_ACCURACY ; ROCK_TUNNEL_1F: X_ACCURACY
	db DTARGET_HIDDEN, 21, 15
	dw EVENT_ROCK_TUNNEL_1F_HIDDEN_X_DEFEND ; ROCK_TUNNEL_1F: X_DEFEND
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_ROCK_TUNNEL_1F_ELIXER ; ROCK_TUNNEL_1F: ELIXER
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_ROCK_TUNNEL_1F_TM_STEEL_WING ; ROCK_TUNNEL_1F: TM_STEEL_WING
	db DTARGET_HIDDEN, 4, 14
	dw EVENT_ROCK_TUNNEL_B1F_HIDDEN_MAX_POTION ; ROCK_TUNNEL_B1F: MAX_POTION
	db DTARGET_ITEMBALL, 1, 0
	dw EVENT_ROCK_TUNNEL_B1F_IRON ; ROCK_TUNNEL_B1F: IRON
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_ROCK_TUNNEL_B1F_PP_UP ; ROCK_TUNNEL_B1F: PP_UP
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_ROCK_TUNNEL_B1F_REVIVE ; ROCK_TUNNEL_B1F: REVIVE
	db DTARGET_HIDDEN, 3, 29
	dw EVENT_VICTORY_ROAD_HIDDEN_MAX_POTION ; VICTORY_ROAD: MAX_POTION
	db DTARGET_HIDDEN, 3, 65
	dw EVENT_VICTORY_ROAD_HIDDEN_FULL_HEAL ; VICTORY_ROAD: FULL_HEAL
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_VICTORY_ROAD_TM_EARTHQUAKE ; VICTORY_ROAD: TM_EARTHQUAKE
	db DTARGET_ITEMBALL, 3, 0
	dw EVENT_VICTORY_ROAD_MAX_REVIVE ; VICTORY_ROAD: MAX_REVIVE
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_VICTORY_ROAD_FULL_RESTORE ; VICTORY_ROAD: FULL_RESTORE
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_VICTORY_ROAD_FULL_HEAL ; VICTORY_ROAD: FULL_HEAL
	db DTARGET_ITEMBALL, 6, 0
	dw EVENT_VICTORY_ROAD_HP_UP ; VICTORY_ROAD: HP_UP
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_SAGE_GAKU ; WISE_TRIOS_ROOM: SAGE GAKU
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_SAGE_MASA ; WISE_TRIOS_ROOM: SAGE MASA
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_SAGE_KOJI ; WISE_TRIOS_ROOM: SAGE KOJI
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_KIMONO_GIRL_NAOKO ; DANCE_THEATER: KIMONO_GIRL NAOKO
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_KIMONO_GIRL_SAYO ; DANCE_THEATER: KIMONO_GIRL SAYO
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_KIMONO_GIRL_ZUKI ; DANCE_THEATER: KIMONO_GIRL ZUKI
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_KIMONO_GIRL_KUNI ; DANCE_THEATER: KIMONO_GIRL KUNI
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_KIMONO_GIRL_MIKI ; DANCE_THEATER: KIMONO_GIRL MIKI
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_SAGE_JEFFREY ; ECRUTEAK_GYM: SAGE JEFFREY
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_SAGE_PING ; ECRUTEAK_GYM: SAGE PING
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_MEDIUM_MARTHA ; ECRUTEAK_GYM: MEDIUM MARTHA
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_MEDIUM_GRACE ; ECRUTEAK_GYM: MEDIUM GRACE
	db DTARGET_HIDDEN, 23, 14
	dw EVENT_ECRUTEAK_CITY_HIDDEN_HYPER_POTION ; ECRUTEAK_CITY: HYPER_POTION
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_COOLTRAINERM_MIKE ; BLACKTHORN_GYM_1F: COOLTRAINERM MIKE
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_COOLTRAINERM_PAUL ; BLACKTHORN_GYM_1F: COOLTRAINERM PAUL
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_COOLTRAINERF_LOLA ; BLACKTHORN_GYM_1F: COOLTRAINERF LOLA
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_COOLTRAINERM_CODY ; BLACKTHORN_GYM_2F: COOLTRAINERM CODY
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_COOLTRAINERF_FRAN ; BLACKTHORN_GYM_2F: COOLTRAINERF FRAN
	db DTARGET_HIDDEN, 13, 80
	dw EVENT_ROUTE_45_HIDDEN_PP_UP ; ROUTE_45: PP_UP
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_HIKER_ERIK ; ROUTE_45: HIKER ERIK
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_HIKER_MICHAEL ; ROUTE_45: HIKER MICHAEL
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_HIKER_PARRY ; ROUTE_45: HIKER PARRY3
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_HIKER_TIMOTHY ; ROUTE_45: HIKER TIMOTHY
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_BLACKBELT_KENJI ; ROUTE_45: BLACKBELT_T KENJI3
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_COOLTRAINERM_RYAN ; ROUTE_45: COOLTRAINERM RYAN
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_COOLTRAINERF_KELLY ; ROUTE_45: COOLTRAINERF KELLY
	db DTARGET_ITEMBALL, 9, 0
	dw EVENT_ROUTE_45_NUGGET ; ROUTE_45: NUGGET
	db DTARGET_ITEMBALL, 10, 0
	dw EVENT_ROUTE_45_REVIVE ; ROUTE_45: REVIVE
	db DTARGET_ITEMBALL, 11, 0
	dw EVENT_ROUTE_45_ELIXER ; ROUTE_45: ELIXER
	db DTARGET_ITEMBALL, 12, 0
	dw EVENT_ROUTE_45_MAX_POTION ; ROUTE_45: MAX_POTION
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_HIKER_BAILEY ; ROUTE_46: HIKER BAILEY
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_CAMPER_TED ; ROUTE_46: CAMPER TED
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_PICNICKER_ERIN ; ROUTE_46: PICNICKER ERIN1
	db DTARGET_ITEMBALL, 6, 0
	dw EVENT_ROUTE_46_X_SPEED ; ROUTE_46: X_SPEED
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SWIMMERF_DAWN ; ROUTE_19: SWIMMERF DAWN
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_SWIMMERM_HAROLD ; ROUTE_19: SWIMMERM HAROLD
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_SWIMMERM_JEROME ; ROUTE_19: SWIMMERM JEROME
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_SWIMMERM_TUCKER ; ROUTE_19: SWIMMERM TUCKER
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SWIMMERF_NICOLE ; ROUTE_20: SWIMMERF NICOLE
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_SWIMMERF_LORI ; ROUTE_20: SWIMMERF LORI
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_SWIMMERM_CAMERON ; ROUTE_20: SWIMMERM CAMERON
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SWIMMERF_NIKKI ; ROUTE_21: SWIMMERF NIKKI
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_SWIMMERM_SETH ; ROUTE_21: SWIMMERM SETH
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_FISHER_ARNOLD ; ROUTE_21: FISHER ARNOLD
	db DTARGET_HIDDEN, 9, 1
	dw EVENT_CINNABAR_ISLAND_HIDDEN_RARE_CANDY ; CINNABAR_ISLAND: RARE_CANDY
	db DTARGET_HIDDEN, 3, 8
	dw EVENT_FOUND_MACHINE_PART_IN_CERULEAN_GYM ; CERULEAN_GYM: MACHINE_PART
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_SWIMMERF_DIANA ; CERULEAN_GYM: SWIMMERF DIANA
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_SWIMMERF_BRIANA ; CERULEAN_GYM: SWIMMERF BRIANA
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_SWIMMERM_PARKER ; CERULEAN_GYM: SWIMMERM PARKER
	db DTARGET_HIDDEN, 10, 3
	dw EVENT_ROUTE_4_HIDDEN_ULTRA_BALL ; ROUTE_4: ULTRA_BALL
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_BIRD_KEEPER_HANK ; ROUTE_4: BIRD_KEEPER HANK
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_PICNICKER_HOPE ; ROUTE_4: PICNICKER HOPE
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_PICNICKER_SHARON ; ROUTE_4: PICNICKER SHARON
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_ROUTE_4_HP_UP ; ROUTE_4: HP_UP
	db DTARGET_HIDDEN, 41, 15
	dw EVENT_ROUTE_9_HIDDEN_ETHER ; ROUTE_9: ETHER
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_CAMPER_DEAN ; ROUTE_9: CAMPER DEAN
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_PICNICKER_HEIDI ; ROUTE_9: PICNICKER HEIDI
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_CAMPER_SID ; ROUTE_9: CAMPER SID
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_PICNICKER_EDNA ; ROUTE_9: PICNICKER EDNA
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_HIKER_TIM ; ROUTE_9: HIKER TIM
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_HIKER_SIDNEY ; ROUTE_9: HIKER SIDNEY
	db DTARGET_HIDDEN, 4, 5
	dw EVENT_ROUTE_25_HIDDEN_POTION ; ROUTE_25: POTION
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_SCHOOLBOY_DUDLEY ; ROUTE_25: SCHOOLBOY DUDLEY
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_LASS_ELLEN ; ROUTE_25: LASS ELLEN
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_SCHOOLBOY_JOE ; ROUTE_25: SCHOOLBOY JOE
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_LASS_LAURA ; ROUTE_25: LASS LAURA
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_CAMPER_LLOYD ; ROUTE_25: CAMPER LLOYD
	db DTARGET_TRAINER, 8, 0
	dw EVENT_BEAT_LASS_SHANNON ; ROUTE_25: LASS SHANNON
	db DTARGET_TRAINER, 9, 0
	dw EVENT_BEAT_SUPER_NERD_PAT ; ROUTE_25: SUPER_NERD PAT
	db DTARGET_ITEMBALL, 11, 0
	dw EVENT_ROUTE_25_PROTEIN ; ROUTE_25: PROTEIN
	db DTARGET_HIDDEN, 2, 12
	dw EVENT_FOUND_BERSERK_GENE_IN_CERULEAN_CITY ; CERULEAN_CITY: BERSERK_GENE
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_BUG_CATCHER_BENNY ; AZALEA_GYM: BUG_CATCHER BUG_CATCHER_BENNY
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_BUG_CATCHER_AL ; AZALEA_GYM: BUG_CATCHER AL
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_BUG_CATCHER_JOSH ; AZALEA_GYM: BUG_CATCHER JOSH
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_TWINS_AMY_AND_MAY ; AZALEA_GYM: TWINS AMYANDMAY1
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_TWINS_AMY_AND_MAY ; AZALEA_GYM: TWINS AMYANDMAY2
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_HIKER_ANTHONY ; ROUTE_33: HIKER ANTHONY2
	db DTARGET_HIDDEN, 31, 6
	dw EVENT_AZALEA_TOWN_HIDDEN_FULL_HEAL ; AZALEA_TOWN: FULL_HEAL
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_POKEMANIAC_BEN ; ROUTE_43: POKEMANIAC BEN
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_POKEMANIAC_BRENT ; ROUTE_43: POKEMANIAC BRENT1
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_POKEMANIAC_RON ; ROUTE_43: POKEMANIAC RON
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_FISHER_MARVIN ; ROUTE_43: FISHER MARVIN
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_PICNICKER_TIFFANY ; ROUTE_43: PICNICKER TIFFANY3
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_CAMPER_SPENCER ; ROUTE_43: CAMPER SPENCER
	db DTARGET_ITEMBALL, 8, 0
	dw EVENT_ROUTE_43_MAX_ETHER ; ROUTE_43: MAX_ETHER
	db DTARGET_HIDDEN, 11, 28
	dw EVENT_LAKE_OF_RAGE_HIDDEN_FULL_RESTORE ; LAKE_OF_RAGE: FULL_RESTORE
	db DTARGET_HIDDEN, 4, 4
	dw EVENT_LAKE_OF_RAGE_HIDDEN_RARE_CANDY ; LAKE_OF_RAGE: RARE_CANDY
	db DTARGET_HIDDEN, 35, 5
	dw EVENT_LAKE_OF_RAGE_HIDDEN_MAX_POTION ; LAKE_OF_RAGE: MAX_POTION
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_FISHER_ANDRE ; LAKE_OF_RAGE: FISHER ANDRE
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_FISHER_RAYMOND ; LAKE_OF_RAGE: FISHER RAYMOND
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_COOLTRAINERM_AARON ; LAKE_OF_RAGE: COOLTRAINERM AARON
	db DTARGET_TRAINER, 8, 0
	dw EVENT_BEAT_COOLTRAINERF_LOIS ; LAKE_OF_RAGE: COOLTRAINERF LOIS
	db DTARGET_ITEMBALL, 11, 0
	dw EVENT_LAKE_OF_RAGE_ELIXER ; LAKE_OF_RAGE: ELIXER
	db DTARGET_ITEMBALL, 12, 0
	dw EVENT_LAKE_OF_RAGE_TM_DETECT ; LAKE_OF_RAGE: TM_DETECT
	db DTARGET_HIDDEN, 12, 67
	dw EVENT_ROUTE_32_HIDDEN_GREAT_BALL ; ROUTE_32: GREAT_BALL
	db DTARGET_HIDDEN, 11, 40
	dw EVENT_ROUTE_32_HIDDEN_SUPER_POTION ; ROUTE_32: SUPER_POTION
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_FISHER_JUSTIN ; ROUTE_32: FISHER JUSTIN
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_FISHER_RALPH ; ROUTE_32: FISHER RALPH1
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_FISHER_HENRY ; ROUTE_32: FISHER HENRY
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_YOUNGSTER_ALBERT ; ROUTE_32: YOUNGSTER ALBERT
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_YOUNGSTER_GORDON ; ROUTE_32: YOUNGSTER GORDON
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_CAMPER_ROLAND ; ROUTE_32: CAMPER ROLAND
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_PICNICKER_LIZ ; ROUTE_32: PICNICKER LIZ1
	db DTARGET_TRAINER, 9, 0
	dw EVENT_BEAT_BIRD_KEEPER_PETER ; ROUTE_32: BIRD_KEEPER PETER
	db DTARGET_ITEMBALL, 11, 0
	dw EVENT_ROUTE_32_GREAT_BALL ; ROUTE_32: GREAT_BALL
	db DTARGET_ITEMBALL, 14, 0
	dw EVENT_ROUTE_32_REPEL ; ROUTE_32: REPEL
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_CAMPER_IVAN ; ROUTE_35: CAMPER IVAN
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_CAMPER_ELLIOT ; ROUTE_35: CAMPER ELLIOT
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_PICNICKER_BROOKE ; ROUTE_35: PICNICKER BROOKE
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_PICNICKER_KIM ; ROUTE_35: PICNICKER KIM
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_BIRD_KEEPER_BRYAN ; ROUTE_35: BIRD_KEEPER BRYAN
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_FIREBREATHER_WALT ; ROUTE_35: FIREBREATHER WALT
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_BUG_CATCHER_ARNIE ; ROUTE_35: BUG_CATCHER ARNIE1
	db DTARGET_TRAINER, 8, 0
	dw EVENT_BEAT_JUGGLER_IRWIN ; ROUTE_35: JUGGLER IRWIN1
	db DTARGET_ITEMBALL, 11, 0
	dw EVENT_ROUTE_35_TM_ROLLOUT ; ROUTE_35: TM_ROLLOUT
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_PSYCHIC_MARK ; ROUTE_36: PSYCHIC_T MARK
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_SCHOOLBOY_ALAN ; ROUTE_36: SCHOOLBOY ALAN1
	db DTARGET_HIDDEN, 4, 2
	dw EVENT_ROUTE_37_HIDDEN_ETHER ; ROUTE_37: ETHER
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_TWINS_ANN_AND_ANNE ; ROUTE_37: TWINS ANNANDANNE1
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_TWINS_ANN_AND_ANNE ; ROUTE_37: TWINS ANNANDANNE2
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_PSYCHIC_GREG ; ROUTE_37: PSYCHIC_T GREG
	db DTARGET_HIDDEN, 37, 14
	dw EVENT_VIOLET_CITY_HIDDEN_HYPER_POTION ; VIOLET_CITY: HYPER_POTION
	db DTARGET_ITEMBALL, 7, 0
	dw EVENT_VIOLET_CITY_PP_UP ; VIOLET_CITY: PP_UP
	db DTARGET_ITEMBALL, 8, 0
	dw EVENT_VIOLET_CITY_RARE_CANDY ; VIOLET_CITY: RARE_CANDY
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_BIRD_KEEPER_ROD ; VIOLET_GYM: BIRD_KEEPER ROD
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_BIRD_KEEPER_ABE ; VIOLET_GYM: BIRD_KEEPER ABE
	db DTARGET_HIDDEN, 8, 32
	dw EVENT_ROUTE_34_HIDDEN_RARE_CANDY ; ROUTE_34: RARE_CANDY
	db DTARGET_HIDDEN, 17, 19
	dw EVENT_ROUTE_34_HIDDEN_SUPER_POTION ; ROUTE_34: SUPER_POTION
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_CAMPER_TODD ; ROUTE_34: CAMPER TODD1
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_YOUNGSTER_SAMUEL ; ROUTE_34: YOUNGSTER SAMUEL
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_YOUNGSTER_IAN ; ROUTE_34: YOUNGSTER IAN
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_PICNICKER_GINA ; ROUTE_34: PICNICKER GINA1
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_POKEFANM_BRANDON ; ROUTE_34: POKEFANM BRANDON
	db DTARGET_TRAINER, 10, 0
	dw EVENT_BEAT_COOLTRAINERF_IRENE ; ROUTE_34: COOLTRAINERF IRENE
	db DTARGET_TRAINER, 11, 0
	dw EVENT_BEAT_COOLTRAINERF_JENN ; ROUTE_34: COOLTRAINERF JENN
	db DTARGET_TRAINER, 12, 0
	dw EVENT_BEAT_COOLTRAINERF_KATE ; ROUTE_34: COOLTRAINERF KATE
	db DTARGET_ITEMBALL, 13, 0
	dw EVENT_ROUTE_34_NUGGET ; ROUTE_34: NUGGET
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_LASS_CARRIE ; GOLDENROD_GYM: LASS CARRIE
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_LASS_BRIDGET ; GOLDENROD_GYM: LASS BRIDGET
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_BEAUTY_VICTORIA ; GOLDENROD_GYM: BEAUTY VICTORIA
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_BEAUTY_SAMANTHA ; GOLDENROD_GYM: BEAUTY SAMANTHA
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_POKEFANM_REX ; ROUTE_6: POKEFANM REX
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_POKEFANM_ALLAN ; ROUTE_6: POKEFANM ALLAN
	db DTARGET_HIDDEN, 32, 5
	dw EVENT_ROUTE_11_HIDDEN_REVIVE ; ROUTE_11: REVIVE
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_YOUNGSTER_OWEN ; ROUTE_11: YOUNGSTER OWEN
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_YOUNGSTER_JASON ; ROUTE_11: YOUNGSTER JASON
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_PSYCHIC_HERMAN ; ROUTE_11: PSYCHIC_T HERMAN
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_PSYCHIC_FIDEL ; ROUTE_11: PSYCHIC_T FIDEL
	db DTARGET_HIDDEN, 12, 19
	dw EVENT_VERMILION_CITY_HIDDEN_FULL_HEAL ; VERMILION_CITY: FULL_HEAL
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_GENTLEMAN_GREGORY ; VERMILION_GYM: GENTLEMAN GREGORY
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_GUITARIST_VINCENT ; VERMILION_GYM: GUITARIST VINCENT
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_JUGGLER_HORTON ; VERMILION_GYM: JUGGLER HORTON
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SCHOOLBOY_DANNY ; ROUTE_1: SCHOOLBOY DANNY
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_COOLTRAINERF_QUINN ; ROUTE_1: COOLTRAINERF QUINN
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_FIREBREATHER_OTIS ; ROUTE_3: FIREBREATHER OTIS
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_YOUNGSTER_WARREN ; ROUTE_3: YOUNGSTER WARREN
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_YOUNGSTER_JIMMY ; ROUTE_3: YOUNGSTER JIMMY
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_FIREBREATHER_BURT ; ROUTE_3: FIREBREATHER BURT
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_CAMPER_JERRY ; PEWTER_GYM: CAMPER JERRY
	db DTARGET_HIDDEN, 1, 22
	dw EVENT_OLIVINE_PORT_HIDDEN_PROTEIN ; OLIVINE_PORT: PROTEIN
	db DTARGET_HIDDEN, 16, 13
	dw EVENT_VERMILION_PORT_HIDDEN_IRON ; VERMILION_PORT: IRON
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_COOLTRAINERM_SEAN ; FAST_SHIP_CABINS_NNW_NNE_NE: COOLTRAINERM SEAN
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_COOLTRAINERF_CAROL ; FAST_SHIP_CABINS_NNW_NNE_NE: COOLTRAINERF CAROL
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_POKEMANIAC_ETHAN ; FAST_SHIP_CABINS_NNW_NNE_NE: POKEMANIAC ETHAN
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_HIKER_NOLAND ; FAST_SHIP_CABINS_NNW_NNE_NE: HIKER NOLAND
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_GENTLEMAN_EDWARD ; FAST_SHIP_CABINS_NNW_NNE_NE: GENTLEMAN EDWARD
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_BURGLAR_COREY ; FAST_SHIP_CABINS_NNW_NNE_NE: BURGLAR COREY
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_FIREBREATHER_LYLE ; FAST_SHIP_CABINS_SW_SSW_NW: FIREBREATHER LYLE
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_BUG_CATCHER_KEN ; FAST_SHIP_CABINS_SW_SSW_NW: BUG_CATCHER KEN
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_BEAUTY_CASSIE ; FAST_SHIP_CABINS_SW_SSW_NW: BEAUTY CASSIE
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_GUITARIST_CLYDE ; FAST_SHIP_CABINS_SW_SSW_NW: GUITARIST CLYDE
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_POKEFANM_COLIN ; FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN: POKEFANM COLIN
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_TWINS_MEG_AND_PEG ; FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN: TWINS MEGANDPEG1
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_TWINS_MEG_AND_PEG ; FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN: TWINS MEGANDPEG2
	db DTARGET_TRAINER, 8, 0
	dw EVENT_BEAT_PSYCHIC_RODNEY ; FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN: PSYCHIC_T RODNEY
	db DTARGET_TRAINER, 9, 0
	dw EVENT_BEAT_POKEFANM_JEREMY ; FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN: POKEFANM JEREMY
	db DTARGET_TRAINER, 10, 0
	dw EVENT_BEAT_POKEFANF_GEORGIA ; FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN: POKEFANF GEORGIA
	db DTARGET_TRAINER, 11, 0
	dw EVENT_BEAT_SUPER_NERD_SHAWN ; FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN: SUPER_NERD SHAWN
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_SAILOR_JEFF ; FAST_SHIP_B1F: SAILOR JEFF
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_PICNICKER_DEBRA ; FAST_SHIP_B1F: PICNICKER DEBRA
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_JUGGLER_FRITZ ; FAST_SHIP_B1F: JUGGLER FRITZ
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_SAILOR_GARRETT ; FAST_SHIP_B1F: SAILOR GARRETT
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_FISHER_JONAH ; FAST_SHIP_B1F: FISHER JONAH
	db DTARGET_TRAINER, 8, 0
	dw EVENT_BEAT_BLACKBELT_WAI ; FAST_SHIP_B1F: BLACKBELT_T WAI
	db DTARGET_TRAINER, 9, 0
	dw EVENT_BEAT_SAILOR_KENNETH ; FAST_SHIP_B1F: SAILOR KENNETH
	db DTARGET_TRAINER, 10, 0
	dw EVENT_BEAT_TEACHER_SHIRLEY ; FAST_SHIP_B1F: TEACHER SHIRLEY
	db DTARGET_TRAINER, 11, 0
	dw EVENT_BEAT_SCHOOLBOY_NATE ; FAST_SHIP_B1F: SCHOOLBOY NATE
	db DTARGET_TRAINER, 12, 0
	dw EVENT_BEAT_SCHOOLBOY_RICKY ; FAST_SHIP_B1F: SCHOOLBOY RICKY
	db DTARGET_HIDDEN, 7, 7
	dw EVENT_MOUNT_MOON_SQUARE_HIDDEN_MOON_STONE ; MOUNT_MOON_SQUARE: MOON_STONE
	db DTARGET_HIDDEN, 30, 13
	dw EVENT_ROUTE_13_HIDDEN_CALCIUM ; ROUTE_13: CALCIUM
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_BIRD_KEEPER_PERRY ; ROUTE_13: BIRD_KEEPER PERRY
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_BIRD_KEEPER_BRET ; ROUTE_13: BIRD_KEEPER BRET
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_POKEFANM_JOSHUA ; ROUTE_13: POKEFANM JOSHUA
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_HIKER_KENNY ; ROUTE_13: HIKER KENNY
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_POKEFANM_ALEX ; ROUTE_13: POKEFANM ALEX
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_POKEFANM_CARTER ; ROUTE_14: POKEFANM CARTER
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_BIRD_KEEPER_ROY ; ROUTE_14: BIRD_KEEPER ROY
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_POKEFANM_TREVOR ; ROUTE_14: POKEFANM TREVOR
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SCHOOLBOY_KIP ; ROUTE_15: SCHOOLBOY KIPP
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_SCHOOLBOY_TOMMY ; ROUTE_15: SCHOOLBOY TOMMY
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_SCHOOLBOY_JOHNNY ; ROUTE_15: SCHOOLBOY JOHNNY
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_SCHOOLBOY_BILLY ; ROUTE_15: SCHOOLBOY BILLY
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_TEACHER_COLETTE ; ROUTE_15: TEACHER COLETTE
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_TEACHER_HILLARY ; ROUTE_15: TEACHER HILLARY
	db DTARGET_ITEMBALL, 7, 0
	dw EVENT_ROUTE_15_PP_UP ; ROUTE_15: PP_UP
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_BIRD_KEEPER_BORIS ; ROUTE_18: BIRD_KEEPER BORIS
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_BIRD_KEEPER_BOB ; ROUTE_18: BIRD_KEEPER BOB
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_BIKER_DWAYNE ; ROUTE_8: BIKER DWAYNE
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_BIKER_HARRIS ; ROUTE_8: BIKER HARRIS
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_BIKER_ZEKE ; ROUTE_8: BIKER ZEKE
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_SUPER_NERD_SAM ; ROUTE_8: SUPER_NERD SAM
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_SUPER_NERD_TOM ; ROUTE_8: SUPER_NERD TOM
	db DTARGET_HIDDEN, 14, 13
	dw EVENT_ROUTE_12_HIDDEN_ELIXER ; ROUTE_12: ELIXER
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_FISHER_MARTIN ; ROUTE_12: FISHER MARTIN
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_FISHER_STEPHEN ; ROUTE_12: FISHER STEPHEN
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_FISHER_BARNEY ; ROUTE_12: FISHER BARNEY
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_FISHER_KYLE ; ROUTE_12: FISHER KYLE
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_ROUTE_12_CALCIUM ; ROUTE_12: CALCIUM
	db DTARGET_ITEMBALL, 6, 0
	dw EVENT_ROUTE_12_NUGGET ; ROUTE_12: NUGGET
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_HIKER_JIM ; ROUTE_10_SOUTH: HIKER JIM
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_POKEFANM_ROBERT ; ROUTE_10_SOUTH: POKEFANM ROBERT
	db DTARGET_HIDDEN, 25, 2
	dw EVENT_ROUTE_28_HIDDEN_RARE_CANDY ; ROUTE_28: RARE_CANDY
	db DTARGET_HIDDEN, 9, 25
	dw EVENT_SILVER_CAVE_OUTSIDE_HIDDEN_FULL_RESTORE ; SILVER_CAVE_OUTSIDE: FULL_RESTORE
	db DTARGET_HIDDEN, 9, 54
	dw EVENT_ROUTE_17_HIDDEN_MAX_ETHER ; ROUTE_17: MAX_ETHER
	db DTARGET_HIDDEN, 8, 77
	dw EVENT_ROUTE_17_HIDDEN_MAX_ELIXER ; ROUTE_17: MAX_ELIXER
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_BIKER_RILEY ; ROUTE_17: BIKER RILEY
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_BIKER_JOEL ; ROUTE_17: BIKER JOEL
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_BIKER_GLENN ; ROUTE_17: BIKER GLENN
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_BIKER_CHARLES ; ROUTE_17: BIKER CHARLES
	db DTARGET_HIDDEN, 37, 21
	dw EVENT_CELADON_CITY_HIDDEN_PP_UP ; CELADON_CITY: PP_UP
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_LASS_MICHELLE ; CELADON_GYM: LASS MICHELLE
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_PICNICKER_TANYA ; CELADON_GYM: PICNICKER TANYA
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_BEAUTY_JULIA ; CELADON_GYM: BEAUTY JULIA
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_TWINS_JO_AND_ZOE ; CELADON_GYM: TWINS JOANDZOE1
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_TWINS_JO_AND_ZOE ; CELADON_GYM: TWINS JOANDZOE2
	db DTARGET_HIDDEN, 7, 8
	dw EVENT_ROUTE_40_HIDDEN_HYPER_POTION ; ROUTE_40: HYPER_POTION
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SWIMMERM_SIMON ; ROUTE_40: SWIMMERM SIMON
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_SWIMMERM_RANDALL ; ROUTE_40: SWIMMERM RANDALL
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_SWIMMERF_ELAINE ; ROUTE_40: SWIMMERF ELAINE
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_SWIMMERF_PAULA ; ROUTE_40: SWIMMERF PAULA
	db DTARGET_HIDDEN, 9, 35
	dw EVENT_ROUTE_41_HIDDEN_MAX_ETHER ; ROUTE_41: MAX_ETHER
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_SWIMMERM_CHARLIE ; ROUTE_41: SWIMMERM CHARLIE
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_SWIMMERM_GEORGE ; ROUTE_41: SWIMMERM GEORGE
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_SWIMMERM_BERKE ; ROUTE_41: SWIMMERM BERKE
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_SWIMMERM_KIRK ; ROUTE_41: SWIMMERM KIRK
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_SWIMMERM_MATHEW ; ROUTE_41: SWIMMERM MATHEW
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_SWIMMERF_KAYLEE ; ROUTE_41: SWIMMERF KAYLEE
	db DTARGET_TRAINER, 7, 0
	dw EVENT_BEAT_SWIMMERF_SUSIE ; ROUTE_41: SWIMMERF SUSIE
	db DTARGET_TRAINER, 8, 0
	dw EVENT_BEAT_SWIMMERF_DENISE ; ROUTE_41: SWIMMERF DENISE
	db DTARGET_TRAINER, 9, 0
	dw EVENT_BEAT_SWIMMERF_KARA ; ROUTE_41: SWIMMERF KARA
	db DTARGET_TRAINER, 10, 0
	dw EVENT_BEAT_SWIMMERF_WENDY ; ROUTE_41: SWIMMERF WENDY
	db DTARGET_HIDDEN, 4, 19
	dw EVENT_CIANWOOD_CITY_HIDDEN_REVIVE ; CIANWOOD_CITY: REVIVE
	db DTARGET_HIDDEN, 5, 29
	dw EVENT_CIANWOOD_CITY_HIDDEN_MAX_ETHER ; CIANWOOD_CITY: MAX_ETHER
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_BLACKBELT_YOSHI ; CIANWOOD_GYM: BLACKBELT_T YOSHI
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_BLACKBELT_LAO ; CIANWOOD_GYM: BLACKBELT_T LAO
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_BLACKBELT_NOB ; CIANWOOD_GYM: BLACKBELT_T NOB
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_BLACKBELT_LUNG ; CIANWOOD_GYM: BLACKBELT_T LUNG
	db DTARGET_HIDDEN, 7, 23
	dw EVENT_ROUTE_2_HIDDEN_MAX_ETHER ; ROUTE_2: MAX_ETHER
	db DTARGET_HIDDEN, 4, 14
	dw EVENT_ROUTE_2_HIDDEN_FULL_HEAL ; ROUTE_2: FULL_HEAL
	db DTARGET_HIDDEN, 4, 27
	dw EVENT_ROUTE_2_HIDDEN_FULL_RESTORE ; ROUTE_2: FULL_RESTORE
	db DTARGET_HIDDEN, 11, 30
	dw EVENT_ROUTE_2_HIDDEN_REVIVE ; ROUTE_2: REVIVE
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_BUG_CATCHER_ROB ; ROUTE_2: BUG_CATCHER ROB
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_BUG_CATCHER_ED ; ROUTE_2: BUG_CATCHER ED
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_BUG_CATCHER_DOUG ; ROUTE_2: BUG_CATCHER DOUG
	db DTARGET_ITEMBALL, 4, 0
	dw EVENT_ROUTE_2_DIRE_HIT ; ROUTE_2: DIRE_HIT
	db DTARGET_ITEMBALL, 5, 0
	dw EVENT_ROUTE_2_MAX_POTION ; ROUTE_2: MAX_POTION
	db DTARGET_ITEMBALL, 6, 0
	dw EVENT_ROUTE_2_CARBOS ; ROUTE_2: CARBOS
	db DTARGET_ITEMBALL, 7, 0
	dw EVENT_ROUTE_2_ELIXER ; ROUTE_2: ELIXER
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_COOLTRAINERM_JAKE ; ROUTE_26: COOLTRAINERM JAKE
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_COOLTRAINERM_GAVEN ; ROUTE_26: COOLTRAINERM GAVEN3
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_COOLTRAINERF_JOYCE ; ROUTE_26: COOLTRAINERF JOYCE
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_COOLTRAINERF_BETH ; ROUTE_26: COOLTRAINERF BETH1
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_PSYCHIC_RICHARD ; ROUTE_26: PSYCHIC_T RICHARD
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_FISHER_SCOTT ; ROUTE_26: FISHER SCOTT
	db DTARGET_ITEMBALL, 8, 0
	dw EVENT_ROUTE_26_MAX_ELIXER ; ROUTE_26: MAX_ELIXER
	db DTARGET_TRAINER, 1, 0
	dw EVENT_BEAT_COOLTRAINERM_BLAKE ; ROUTE_27: COOLTRAINERM BLAKE
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_COOLTRAINERM_BRIAN ; ROUTE_27: COOLTRAINERM BRIAN
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_COOLTRAINERF_REENA ; ROUTE_27: COOLTRAINERF REENA1
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_COOLTRAINERF_MEGAN ; ROUTE_27: COOLTRAINERF MEGAN
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_PSYCHIC_GILBERT ; ROUTE_27: PSYCHIC_T GILBERT
	db DTARGET_TRAINER, 6, 0
	dw EVENT_BEAT_BIRD_KEEPER_JOSE2 ; ROUTE_27: BIRD_KEEPER JOSE2
	db DTARGET_ITEMBALL, 7, 0
	dw EVENT_ROUTE_27_TM_SOLARBEAM ; ROUTE_27: TM_SOLARBEAM
	db DTARGET_ITEMBALL, 8, 0
	dw EVENT_ROUTE_27_RARE_CANDY ; ROUTE_27: RARE_CANDY
	db DTARGET_ITEMBALL, 8, 0
	dw EVENT_ROUTE_29_POTION ; ROUTE_29: POTION
	db DTARGET_ITEMBALL, 2, 0
	dw EVENT_PICKED_UP_FOCUS_BAND ; FIGHTING_DOJO: FOCUS_BAND
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_MEDIUM_REBECCA ; SAFFRON_GYM: MEDIUM REBECCA
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_PSYCHIC_FRANKLIN ; SAFFRON_GYM: PSYCHIC_T FRANKLIN
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_MEDIUM_DORIS ; SAFFRON_GYM: MEDIUM DORIS
	db DTARGET_TRAINER, 5, 0
	dw EVENT_BEAT_PSYCHIC_JARED ; SAFFRON_GYM: PSYCHIC_T JARED
	db DTARGET_HIDDEN, 14, 9
	dw EVENT_ROUTE_30_HIDDEN_POTION ; ROUTE_30: POTION
	db DTARGET_TRAINER, 2, 0
	dw EVENT_BEAT_YOUNGSTER_JOEY ; ROUTE_30: YOUNGSTER JOEY1
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_YOUNGSTER_MIKEY ; ROUTE_30: YOUNGSTER MIKEY
	db DTARGET_TRAINER, 4, 0
	dw EVENT_BEAT_BUG_CATCHER_DON ; ROUTE_30: BUG_CATCHER DON
	db DTARGET_ITEMBALL, 11, 0
	dw EVENT_ROUTE_30_ANTIDOTE ; ROUTE_30: ANTIDOTE
	db DTARGET_TRAINER, 3, 0
	dw EVENT_BEAT_BUG_CATCHER_WADE ; ROUTE_31: BUG_CATCHER WADE1
	db DTARGET_ITEMBALL, 6, 0
	dw EVENT_ROUTE_31_POTION ; ROUTE_31: POTION
	db DTARGET_ITEMBALL, 7, 0
	dw EVENT_ROUTE_31_POKE_BALL ; ROUTE_31: POKE_BALL
	assert_table_length NUM_DEMO_TARGETS
