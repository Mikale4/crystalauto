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
	dw PIDGEY, SPEAROW, HOOTHOOT, NATU, DODUO, FARFETCH_D, MURKROW, DELIBIRD, ZUBAT
	dw SKARMORY ; (steel, for the rock and electric types birds fear)
	dw -1

.Whitney:
	dw CLEFFA, IGGLYBUFF, SNUBBULL, TEDDIURSA, AIPOM, SENTRET, MILTANK, DUNSPARCE
	dw STANTLER, TOGEPI
	dw GIRAFARIG ; (psychic, for fighting types)
	dw -1

.Bugs:
	dw CATERPIE, WEEDLE, LEDYBA, SPINARAK, PARAS, VENONAT, PINECO, YANMA, SCYTHER
	dw PINSIR
	dw SHUCKLE, HERACROSS ; (rock and fighting, for the rock and fire types)
	dw -1

.Ghosts:
	dw GASTLY, MISDREAVUS, MURKROW, HOOTHOOT, ZUBAT, DROWZEE, GIRAFARIG
	dw HOUNDOUR, SNEASEL ; (dark, for the ghost and psychic types)
	dw CUBONE
	dw -1

.Ice:
	dw SEEL, SHELLDER, SWINUB, SMOOCHUM, SNEASEL, DELIBIRD, LAPRAS, STARYU
	dw HORSEA, SLOWPOKE ; (water, for the fire and rock types)
	dw -1

.Steel:
	dw MAGNEMITE, ONIX, SKARMORY, PINECO, SCYTHER, MAREEP, SHUCKLE
	dw GEODUDE ; (ground, for the fire and electric types)
	dw CORSOLA ; (water, for the fire and ground types)
	dw -1

.Fighting:
	dw MANKEY, MACHOP, TYROGUE, POLIWAG, HERACROSS, TEDDIURSA, GEODUDE, ONIX
	dw SNEASEL ; (dark, for the psychic types)
	dw -1

.Dragons:
	dw DRATINI, HORSEA, MAGIKARP, CHARMANDER, AERODACTYL, EKANS, ONIX
	dw SKARMORY ; (steel, for the ice and dragon types)
	dw -1

.Lance:
	dw DRATINI, MAGIKARP, CHARMANDER, AERODACTYL, HORSEA, LAPRAS
	dw LARVITAR, SKARMORY ; (for the ice and dragon types)
	dw -1

.Rival:
	dw GASTLY, ZUBAT, MAGNEMITE, SNEASEL, MURKROW, HOUNDOUR, LARVITAR, KOFFING
	dw -1

.Starters:
	dw BULBASAUR, CHARMANDER, SQUIRTLE, CHIKORITA, CYNDAQUIL, TOTODILE, PIKACHU
	dw EEVEE
	dw -1

.Psychic:
	dw ABRA, DROWZEE, NATU, EXEGGCUTE, SLOWPOKE, GIRAFARIG, MR__MIME, SMOOCHUM
	dw STARYU, PORYGON
	dw MAGNEMITE ; (steel, for the bug, ghost and dark types)
	dw -1

.Bruno:
	dw MACHOP, MANKEY, TYROGUE, ONIX, GEODUDE, RHYHORN, HERACROSS
	dw POLIWAG ; (water, for the grass and ground types)
	dw SNEASEL ; (dark, for the psychic types)
	dw -1

.Dark:
	dw HOUNDOUR, MURKROW, SNEASEL, LARVITAR, MISDREAVUS, ODDISH, ZUBAT
	dw GASTLY ; (ghost, for the fighting types)
	dw SLOWPOKE
	dw -1

.Poison:
	dw ZUBAT, KOFFING, GRIMER, TENTACOOL, VENONAT, EKANS, NIDORAN_M, NIDORAN_F
	dw QWILFISH, SPINARAK
	dw SNEASEL ; (dark, for the psychic types)
	dw -1

.Rock:
	dw GEODUDE, ONIX, RHYHORN, SUDOWOODO, SHUCKLE, LARVITAR, AERODACTYL, CUBONE
	dw OMANYTE, KABUTO, CORSOLA ; (water, for the water and grass types)
	dw -1

.Water:
	dw STARYU, HORSEA, PSYDUCK, GOLDEEN, SEEL, SHELLDER, MARILL, LAPRAS
	dw CHINCHOU, WOOPER ; (electric and ground, for the electric types)
	dw -1

.Electric:
	dw VOLTORB, MAGNEMITE, PIKACHU, ELEKID, MAREEP, PORYGON
	dw CHINCHOU ; (water, for the ground types)
	dw DODUO ; (flying, out of reach of ground moves)
	dw -1

.Science:
	dw MAGNEMITE, VOLTORB, KOFFING, GRIMER, PORYGON, DITTO, OMANYTE, KABUTO
	dw ABRA, NATU
	dw -1

.Grass:
	dw ODDISH, BELLSPROUT, EXEGGCUTE, TANGELA, HOPPIP, SUNKERN, BULBASAUR
	dw CHIKORITA, PARAS
	dw MARILL ; (water, for the fire and ice types)
	dw -1

.Youngster:
	dw RATTATA, SPEAROW, EKANS, SANDSHREW, ZUBAT, PIDGEY, NIDORAN_M, WOOPER
	dw SENTRET, GEODUDE, CATERPIE, MANKEY
	dw -1

.Schoolboy:
	dw ABRA, PSYDUCK, NATU, ODDISH, BELLSPROUT, GEODUDE, VULPIX, MAREEP
	dw SLOWPOKE, KRABBY
	dw -1

.Lass:
	dw CLEFFA, IGGLYBUFF, ODDISH, MAREEP, MARILL, SNUBBULL, TOGEPI, PICHU
	dw NIDORAN_F, HOPPIP, SENTRET
	dw -1

.CoolM:
	dw CHARMANDER, SQUIRTLE, BULBASAUR, DRATINI, LARVITAR, MAGIKARP, GROWLITHE
	dw EXEGGCUTE, RHYHORN, NIDORAN_M, HERACROSS, SCYTHER
	dw -1

.CoolF:
	dw CHIKORITA, CYNDAQUIL, TOTODILE, CLEFFA, STARYU, DRATINI, EEVEE, PONYTA
	dw CHANSEY, LAPRAS, MAREEP
	dw -1

.Beauty:
	dw CLEFFA, IGGLYBUFF, VULPIX, PONYTA, STARYU, GOLDEEN, SMOOCHUM, SEEL
	dw MEOWTH, SNUBBULL
	dw -1

.Maniac:
	dw SLOWPOKE, NIDORAN_M, RHYHORN, CUBONE, LICKITUNG, KANGASKHAN, LARVITAR
	dw AERODACTYL, PORYGON, ONIX
	dw -1

.Rocket:
	dw RATTATA, ZUBAT, KOFFING, GRIMER, EKANS, DROWZEE, HOUNDOUR, MURKROW
	dw MEOWTH, ODDISH
	dw GEODUDE ; (rock and ground, for the psychic types' foes)
	dw -1

.Gentleman:
	dw GROWLITHE, PONYTA, SNUBBULL, MEOWTH, NATU, STANTLER, NIDORAN_M
	dw FARFETCH_D, EEVEE, PICHU
	dw -1

.Teacher:
	dw CLEFFA, ABRA, NATU, CHANSEY, SMOOCHUM, DROWZEE, ODDISH, MAREEP, PSYDUCK
	dw SLOWPOKE
	dw -1

.Fisher:
	dw MAGIKARP, GOLDEEN, POLIWAG, TENTACOOL, KRABBY, SHELLDER, HORSEA, QWILFISH
	dw REMORAID, STARYU
	dw CHINCHOU, WOOPER ; (for the electric and grass types)
	dw -1

.SwimmerM:
	dw TENTACOOL, HORSEA, STARYU, SHELLDER, KRABBY, POLIWAG, PSYDUCK, SEEL
	dw MANTINE, REMORAID, MARILL
	dw CHINCHOU ; (electric, for the water types)
	dw -1

.SwimmerF:
	dw GOLDEEN, STARYU, SEEL, HORSEA, MARILL, PSYDUCK, TENTACOOL, CORSOLA
	dw MANTINE, SHELLDER, LAPRAS
	dw CHINCHOU ; (electric, for the water types)
	dw -1

.Sailor:
	dw MACHOP, POLIWAG, TENTACOOL, KRABBY, MANKEY, SEEL, PSYDUCK, MAGIKARP
	dw SHELLDER
	dw WOOPER ; (ground, for the electric types)
	dw -1

.Guitarist:
	dw VOLTORB, MAGNEMITE, PIKACHU, ELEKID, MAREEP, IGGLYBUFF, KOFFING, SMOOCHUM
	dw CHINCHOU ; (water, for the ground types)
	dw -1

.Hiker:
	dw GEODUDE, ONIX, MACHOP, RHYHORN, SANDSHREW, DIGLETT, CUBONE, PHANPY
	dw LARVITAR, SUDOWOODO, TEDDIURSA
	dw SWINUB ; (ice, for the grass types)
	dw -1

.Biker:
	dw KOFFING, GRIMER, VOLTORB, ZUBAT, EKANS, HOUNDOUR, GROWLITHE, PONYTA
	dw MACHOP, MAGBY
	dw -1

.Fire:
	dw VULPIX, GROWLITHE, PONYTA, MAGBY, HOUNDOUR, CHARMANDER, CYNDAQUIL, KOFFING
	dw SLUGMA, RHYHORN ; (rock, for the water and ground types' foes)
	dw -1

.Burglar:
	dw GROWLITHE, VULPIX, MEOWTH, KOFFING, MAGBY, MURKROW, SNEASEL, HOUNDOUR
	dw PONYTA
	dw -1

.Juggler:
	dw VOLTORB, DROWZEE, MR__MIME, KOFFING, ABRA, AIPOM, SMOOCHUM, GIRAFARIG
	dw NATU, MAGNEMITE
	dw -1

.Executive:
	dw KOFFING, ZUBAT, HOUNDOUR, MURKROW, GRIMER, DROWZEE, EKANS, ODDISH, MEOWTH
	dw GASTLY, SNEASEL
	dw MACHOP ; (fighting, for the dark types)
	dw -1

.Picnicker:
	dw ODDISH, BELLSPROUT, HOPPIP, SUNKERN, PIKACHU, SENTRET, NIDORAN_F, MAREEP
	dw MARILL, PONYTA, CLEFFA, SNUBBULL
	dw -1

.Camper:
	dw SANDSHREW, DIGLETT, GEODUDE, RATTATA, ZUBAT, CATERPIE, VULPIX, GROWLITHE
	dw PHANPY, TEDDIURSA, NIDORAN_M, CUBONE
	dw -1

.Sage:
	dw BELLSPROUT, HOOTHOOT, GASTLY, NATU, DROWZEE, ODDISH, MISDREAVUS
	dw EXEGGCUTE, SUNKERN
	dw -1

.Medium:
	dw GASTLY, MISDREAVUS, DROWZEE, ABRA, NATU, MURKROW, HOUNDOUR, SMOOCHUM
	dw GIRAFARIG
	dw -1

.Pokefan:
	dw PICHU, CLEFFA, IGGLYBUFF, SNUBBULL, MARILL, TOGEPI, MEOWTH, EEVEE, CHANSEY
	dw SENTRET, AIPOM
	dw -1

.Kimono:
	dw EEVEE, VULPIX, PONYTA, SMOOCHUM, MISDREAVUS, CLEFFA, NATU, CHINCHOU
	dw MARILL
	dw -1

.Twins:
	dw CLEFFA, IGGLYBUFF, PICHU, MARILL, TEDDIURSA, PHANPY, SPINARAK, LEDYBA
	dw ODDISH, HOPPIP, NIDORAN_F, NIDORAN_M
	dw -1

.Red:
	dw PIKACHU, BULBASAUR, CHARMANDER, SQUIRTLE, SNORLAX, LAPRAS, EEVEE
	dw AERODACTYL, KANGASKHAN, TAUROS
	dw -1

.Blue:
	dw PIDGEY, ABRA, RHYHORN, EXEGGCUTE, GROWLITHE, MAGIKARP, SQUIRTLE, MACHOP
	dw ELEKID
	dw -1

.Officer:
	dw GROWLITHE, HOUNDOUR, SNUBBULL, MACHOP, MAGNEMITE, VOLTORB, ELEKID, PONYTA
	dw STANTLER
	dw -1

.Mystic:
	dw DROWZEE, GASTLY, VOLTORB, NATU, MISDREAVUS, ABRA, GIRAFARIG, SMOOCHUM
	dw VULPIX
	dw -1
