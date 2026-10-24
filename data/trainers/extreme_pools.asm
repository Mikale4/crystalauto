ExtremeTeamPools:
; The Pokémon that join each trainer class's teams on EXTREME (as their first
; forms: they join as evolved as their level allows), with a few that cover the
; theme's weaknesses.
; entries correspond to trainer classes (see constants/trainer_constants.asm)
	table_width 2
	dw .Birds       ; FALKNER
	dw .Whitney     ; WHITNEY
	dw .Bugs        ; BUGSY
	dw .Ghosts      ; MORTY
	dw .Ice         ; PRYCE
	dw .Steel       ; JASMINE
	dw .Fighting    ; CHUCK
	dw .Dragons     ; CLAIR
	dw .Rival       ; RIVAL1
	dw .Starters    ; POKEMON_PROF
	dw .Psychic     ; WILL
	dw .Starters    ; CAL
	dw .Bruno       ; BRUNO
	dw .Dark        ; KAREN
	dw .Poison      ; KOGA
	dw .Lance       ; CHAMPION
	dw .Rock        ; BROCK
	dw .Water       ; MISTY
	dw .Electric    ; LT_SURGE
	dw .Science     ; SCIENTIST
	dw .Grass       ; ERIKA
	dw .Youngster   ; YOUNGSTER
	dw .Schoolboy   ; SCHOOLBOY
	dw .Birds       ; BIRD_KEEPER
	dw .Lass        ; LASS
	dw .Poison      ; JANINE
	dw .CoolM       ; COOLTRAINERM
	dw .CoolF       ; COOLTRAINERF
	dw .Beauty      ; BEAUTY
	dw .Maniac      ; POKEMANIAC
	dw .Rocket      ; GRUNTM
	dw .Gentleman   ; GENTLEMAN
	dw .Ice         ; SKIER
	dw .Teacher     ; TEACHER
	dw .Psychic     ; SABRINA
	dw .Bugs        ; BUG_CATCHER
	dw .Fisher      ; FISHER
	dw .SwimmerM    ; SWIMMERM
	dw .SwimmerF    ; SWIMMERF
	dw .Sailor      ; SAILOR
	dw .Science     ; SUPER_NERD
	dw .Rival       ; RIVAL2
	dw .Guitarist   ; GUITARIST
	dw .Hiker       ; HIKER
	dw .Biker       ; BIKER
	dw .Fire        ; BLAINE
	dw .Burglar     ; BURGLAR
	dw .Fire        ; FIREBREATHER
	dw .Juggler     ; JUGGLER
	dw .Fighting    ; BLACKBELT_T
	dw .Executive   ; EXECUTIVEM
	dw .Psychic     ; PSYCHIC_T
	dw .Picnicker   ; PICNICKER
	dw .Camper      ; CAMPER
	dw .Executive   ; EXECUTIVEF
	dw .Sage        ; SAGE
	dw .Medium      ; MEDIUM
	dw .Ice         ; BOARDER
	dw .Pokefan     ; POKEFANM
	dw .Kimono      ; KIMONO_GIRL
	dw .Twins       ; TWINS
	dw .Pokefan     ; POKEFANF
	dw .Red         ; RED
	dw .Blue        ; BLUE
	dw .Officer     ; OFFICER
	dw .Rocket      ; GRUNTF
	dw .Mystic      ; MYSTICALMAN
	assert_table_length NUM_TRAINER_CLASSES

.Birds:
	db PIDGEY, SPEAROW, HOOTHOOT, NATU, DODUO, FARFETCH_D, MURKROW, DELIBIRD, ZUBAT
	db SKARMORY ; (steel, for the rock and electric types birds fear)
	db -1

.Whitney:
	db CLEFFA, IGGLYBUFF, SNUBBULL, TEDDIURSA, AIPOM, SENTRET, MILTANK, DUNSPARCE
	db STANTLER, TOGEPI
	db GIRAFARIG ; (psychic, for fighting types)
	db -1

.Bugs:
	db CATERPIE, WEEDLE, LEDYBA, SPINARAK, PARAS, VENONAT, PINECO, YANMA, SCYTHER
	db PINSIR
	db SHUCKLE, HERACROSS ; (rock and fighting, for the rock and fire types)
	db -1

.Ghosts:
	db GASTLY, MISDREAVUS, MURKROW, HOOTHOOT, ZUBAT, DROWZEE, GIRAFARIG
	db HOUNDOUR, SNEASEL ; (dark, for the ghost and psychic types)
	db CUBONE
	db -1

.Ice:
	db SEEL, SHELLDER, SWINUB, SMOOCHUM, SNEASEL, DELIBIRD, LAPRAS, STARYU
	db HORSEA, SLOWPOKE ; (water, for the fire and rock types)
	db -1

.Steel:
	db MAGNEMITE, ONIX, SKARMORY, PINECO, SCYTHER, MAREEP, SHUCKLE
	db GEODUDE ; (ground, for the fire and electric types)
	db CORSOLA ; (water, for the fire and ground types)
	db -1

.Fighting:
	db MANKEY, MACHOP, TYROGUE, POLIWAG, HERACROSS, TEDDIURSA, GEODUDE, ONIX
	db SNEASEL ; (dark, for the psychic types)
	db -1

.Dragons:
	db DRATINI, HORSEA, MAGIKARP, CHARMANDER, AERODACTYL, EKANS, ONIX
	db SKARMORY ; (steel, for the ice and dragon types)
	db -1

.Lance:
	db DRATINI, MAGIKARP, CHARMANDER, AERODACTYL, HORSEA, LAPRAS
	db LARVITAR, SKARMORY ; (for the ice and dragon types)
	db -1

.Rival:
	db GASTLY, ZUBAT, MAGNEMITE, SNEASEL, MURKROW, HOUNDOUR, LARVITAR, KOFFING
	db -1

.Starters:
	db BULBASAUR, CHARMANDER, SQUIRTLE, CHIKORITA, CYNDAQUIL, TOTODILE, PIKACHU
	db EEVEE
	db -1

.Psychic:
	db ABRA, DROWZEE, NATU, EXEGGCUTE, SLOWPOKE, GIRAFARIG, MR__MIME, SMOOCHUM
	db STARYU, PORYGON
	db MAGNEMITE ; (steel, for the bug, ghost and dark types)
	db -1

.Bruno:
	db MACHOP, MANKEY, TYROGUE, ONIX, GEODUDE, RHYHORN, HERACROSS
	db POLIWAG ; (water, for the grass and ground types)
	db SNEASEL ; (dark, for the psychic types)
	db -1

.Dark:
	db HOUNDOUR, MURKROW, SNEASEL, LARVITAR, MISDREAVUS, ODDISH, ZUBAT
	db GASTLY ; (ghost, for the fighting types)
	db SLOWPOKE
	db -1

.Poison:
	db ZUBAT, KOFFING, GRIMER, TENTACOOL, VENONAT, EKANS, NIDORAN_M, NIDORAN_F
	db QWILFISH, SPINARAK
	db SNEASEL ; (dark, for the psychic types)
	db -1

.Rock:
	db GEODUDE, ONIX, RHYHORN, SUDOWOODO, SHUCKLE, LARVITAR, AERODACTYL, CUBONE
	db OMANYTE, KABUTO, CORSOLA ; (water, for the water and grass types)
	db -1

.Water:
	db STARYU, HORSEA, PSYDUCK, GOLDEEN, SEEL, SHELLDER, MARILL, LAPRAS
	db CHINCHOU, WOOPER ; (electric and ground, for the electric types)
	db -1

.Electric:
	db VOLTORB, MAGNEMITE, PIKACHU, ELEKID, MAREEP, PORYGON
	db CHINCHOU ; (water, for the ground types)
	db DODUO ; (flying, out of reach of ground moves)
	db -1

.Science:
	db MAGNEMITE, VOLTORB, KOFFING, GRIMER, PORYGON, DITTO, OMANYTE, KABUTO
	db ABRA, NATU
	db -1

.Grass:
	db ODDISH, BELLSPROUT, EXEGGCUTE, TANGELA, HOPPIP, SUNKERN, BULBASAUR
	db CHIKORITA, PARAS
	db MARILL ; (water, for the fire and ice types)
	db -1

.Youngster:
	db RATTATA, SPEAROW, EKANS, SANDSHREW, ZUBAT, PIDGEY, NIDORAN_M, WOOPER
	db SENTRET, GEODUDE, CATERPIE, MANKEY
	db -1

.Schoolboy:
	db ABRA, PSYDUCK, NATU, ODDISH, BELLSPROUT, GEODUDE, VULPIX, MAREEP
	db SLOWPOKE, KRABBY
	db -1

.Lass:
	db CLEFFA, IGGLYBUFF, ODDISH, MAREEP, MARILL, SNUBBULL, TOGEPI, PICHU
	db NIDORAN_F, HOPPIP, SENTRET
	db -1

.CoolM:
	db CHARMANDER, SQUIRTLE, BULBASAUR, DRATINI, LARVITAR, MAGIKARP, GROWLITHE
	db EXEGGCUTE, RHYHORN, NIDORAN_M, HERACROSS, SCYTHER
	db -1

.CoolF:
	db CHIKORITA, CYNDAQUIL, TOTODILE, CLEFFA, STARYU, DRATINI, EEVEE, PONYTA
	db CHANSEY, LAPRAS, MAREEP
	db -1

.Beauty:
	db CLEFFA, IGGLYBUFF, VULPIX, PONYTA, STARYU, GOLDEEN, SMOOCHUM, SEEL
	db MEOWTH, SNUBBULL
	db -1

.Maniac:
	db SLOWPOKE, NIDORAN_M, RHYHORN, CUBONE, LICKITUNG, KANGASKHAN, LARVITAR
	db AERODACTYL, PORYGON, ONIX
	db -1

.Rocket:
	db RATTATA, ZUBAT, KOFFING, GRIMER, EKANS, DROWZEE, HOUNDOUR, MURKROW
	db MEOWTH, ODDISH
	db GEODUDE ; (rock and ground, for the psychic types' foes)
	db -1

.Gentleman:
	db GROWLITHE, PONYTA, SNUBBULL, MEOWTH, NATU, STANTLER, NIDORAN_M
	db FARFETCH_D, EEVEE, PICHU
	db -1

.Teacher:
	db CLEFFA, ABRA, NATU, CHANSEY, SMOOCHUM, DROWZEE, ODDISH, MAREEP, PSYDUCK
	db SLOWPOKE
	db -1

.Fisher:
	db MAGIKARP, GOLDEEN, POLIWAG, TENTACOOL, KRABBY, SHELLDER, HORSEA, QWILFISH
	db REMORAID, STARYU
	db CHINCHOU, WOOPER ; (for the electric and grass types)
	db -1

.SwimmerM:
	db TENTACOOL, HORSEA, STARYU, SHELLDER, KRABBY, POLIWAG, PSYDUCK, SEEL
	db MANTINE, REMORAID, MARILL
	db CHINCHOU ; (electric, for the water types)
	db -1

.SwimmerF:
	db GOLDEEN, STARYU, SEEL, HORSEA, MARILL, PSYDUCK, TENTACOOL, CORSOLA
	db MANTINE, SHELLDER, LAPRAS
	db CHINCHOU ; (electric, for the water types)
	db -1

.Sailor:
	db MACHOP, POLIWAG, TENTACOOL, KRABBY, MANKEY, SEEL, PSYDUCK, MAGIKARP
	db SHELLDER
	db WOOPER ; (ground, for the electric types)
	db -1

.Guitarist:
	db VOLTORB, MAGNEMITE, PIKACHU, ELEKID, MAREEP, IGGLYBUFF, KOFFING, SMOOCHUM
	db CHINCHOU ; (water, for the ground types)
	db -1

.Hiker:
	db GEODUDE, ONIX, MACHOP, RHYHORN, SANDSHREW, DIGLETT, CUBONE, PHANPY
	db LARVITAR, SUDOWOODO, TEDDIURSA
	db SWINUB ; (ice, for the grass types)
	db -1

.Biker:
	db KOFFING, GRIMER, VOLTORB, ZUBAT, EKANS, HOUNDOUR, GROWLITHE, PONYTA
	db MACHOP, MAGBY
	db -1

.Fire:
	db VULPIX, GROWLITHE, PONYTA, MAGBY, HOUNDOUR, CHARMANDER, CYNDAQUIL, KOFFING
	db SLUGMA, RHYHORN ; (rock, for the water and ground types' foes)
	db -1

.Burglar:
	db GROWLITHE, VULPIX, MEOWTH, KOFFING, MAGBY, MURKROW, SNEASEL, HOUNDOUR
	db PONYTA
	db -1

.Juggler:
	db VOLTORB, DROWZEE, MR__MIME, KOFFING, ABRA, AIPOM, SMOOCHUM, GIRAFARIG
	db NATU, MAGNEMITE
	db -1

.Executive:
	db KOFFING, ZUBAT, HOUNDOUR, MURKROW, GRIMER, DROWZEE, EKANS, ODDISH, MEOWTH
	db GASTLY, SNEASEL
	db MACHOP ; (fighting, for the dark types)
	db -1

.Picnicker:
	db ODDISH, BELLSPROUT, HOPPIP, SUNKERN, PIKACHU, SENTRET, NIDORAN_F, MAREEP
	db MARILL, PONYTA, CLEFFA, SNUBBULL
	db -1

.Camper:
	db SANDSHREW, DIGLETT, GEODUDE, RATTATA, ZUBAT, CATERPIE, VULPIX, GROWLITHE
	db PHANPY, TEDDIURSA, NIDORAN_M, CUBONE
	db -1

.Sage:
	db BELLSPROUT, HOOTHOOT, GASTLY, NATU, DROWZEE, ODDISH, MISDREAVUS
	db EXEGGCUTE, SUNKERN
	db -1

.Medium:
	db GASTLY, MISDREAVUS, DROWZEE, ABRA, NATU, MURKROW, HOUNDOUR, SMOOCHUM
	db GIRAFARIG
	db -1

.Pokefan:
	db PICHU, CLEFFA, IGGLYBUFF, SNUBBULL, MARILL, TOGEPI, MEOWTH, EEVEE, CHANSEY
	db SENTRET, AIPOM
	db -1

.Kimono:
	db EEVEE, VULPIX, PONYTA, SMOOCHUM, MISDREAVUS, CLEFFA, NATU, CHINCHOU
	db MARILL
	db -1

.Twins:
	db CLEFFA, IGGLYBUFF, PICHU, MARILL, TEDDIURSA, PHANPY, SPINARAK, LEDYBA
	db ODDISH, HOPPIP, NIDORAN_F, NIDORAN_M
	db -1

.Red:
	db PIKACHU, BULBASAUR, CHARMANDER, SQUIRTLE, SNORLAX, LAPRAS, EEVEE
	db AERODACTYL, KANGASKHAN, TAUROS
	db -1

.Blue:
	db PIDGEY, ABRA, RHYHORN, EXEGGCUTE, GROWLITHE, MAGIKARP, SQUIRTLE, MACHOP
	db ELEKID
	db -1

.Officer:
	db GROWLITHE, HOUNDOUR, SNUBBULL, MACHOP, MAGNEMITE, VOLTORB, ELEKID, PONYTA
	db STANTLER
	db -1

.Mystic:
	db DROWZEE, GASTLY, VOLTORB, NATU, MISDREAVUS, ABRA, GIRAFARIG, SMOOCHUM
	db VULPIX
	db -1
