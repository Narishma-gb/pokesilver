; \1 Label
; \2 Label address
MACRO dr
	IF BANK(@) == 0
		DEF inc_start = @
	ELSE
		DEF inc_start = @ - $4000
	ENDC

	DEF bank_start = BANK(@) * $4000
	IF (_NARG)
		DEF inc_size = (\2) - @
		ASSERT FATAL, inc_size + inc_start <= $4000, "Bank overflow: \1"
		ASSERT FATAL, inc_size >= 0, "Negative binary INCLUDE: \1"
	ELSE
		DEF inc_size = $4000 - inc_start
	ENDC

	IF DEF(_GOLD)
		INCBIN "baserom_g.bin", bank_start + inc_start, inc_size
	ELIF DEF(_SILVER)
		INCBIN "baserom_s.bin", bank_start + inc_start, inc_size
	ENDC

	IF (_NARG)
\1::
	ENDC
ENDM

; G/S label offset, in places where the ROMs diverge
MACRO set_gs_diff
	IF DEF(_GOLD)
		DEF gs_diff = \1
	ELIF DEF(_SILVER)
		DEF gs_diff = 0
	ENDC
ENDM

MACRO drd
	dr \1, (\2) + gs_diff
ENDM

; StdScripts
MACRO drs
	dr \1StdScript, (\2) * 3 + $4000
ENDM


EXPORT DEF EggPic EQU $7F21

;INCLUDE "constants_wip.asm"
INCLUDE "main.asm"
	set_gs_diff 0


SECTION "rom19", ROMX[$4000], BANK[19]
; ROM $13 : $4C000 - $4FFFF

	dr

SECTION "rom20", ROMX[$4000], BANK[20]
; ROM $14 : $50000 - $53FFF

	dr SelectMonFromParty, $4000
	dr SelectTradeOrDayCareMon, $401d
	dr LoadPartyMenuGFX, $404f
	dr WritePartyMenuTilemap, $405f
	dr InitPartyMenuGFX, $4349
	dr InitPartyMenuWithCancel, $436e
	dr InitPartyMenuNoCancel, $4396
	dr PartyMenuSelect, $43c0
	dr PlacePartyMenuText, $4403
	dr PrintPartyMenuActionText, $44c8
	dr LoadFishingGFX, $45d1
	dr SweetScentFromMenu, $47a4
	dr _Squirtbottle, $4832
	dr _CardKey, $488d
	dr _BasementKey, $48c8
	dr _SacredAsh, $48fa
	dr CopyMonToTempMon, $496d
	dr PrintMonTypes, $4a30
	dr PrintMoveType, $4a5d
	dr PrintType, $4a76
	dr GetTypeName, $4a87
	dr DrawPlayerHP, $4c05
	dr DrawEnemyHP, $4c09
	dr StatsScreenInit, $4c76
	dr PrintTempMonStats, $52b5
	dr GetGender, $5305
	dr ListMovePP, $5378
	dr Unused_PlaceEnemyHPLevel, $53f8
	dr PlaceNonFaintStatus, $543c
	dr ListMoves, $5477
	dr InitList, $54c1
	dr CalcLevel, $5523
	dr CalcExpAtLevel, $554f
	dr _SwitchPartyMons, $561a
	dr GetUnownLetter, $5748
	dr GetMonFrontpic, $577f
	dr GetMonBackpic, $57ed
	dr GetTrainerPic, $588a
	dr DecompressGet2bpp, $58e4
	dr BaseData, $5aa9
	dr PokemonNames, $7a09

	dr

SECTION "rom33", ROMX[$4000], BANK[33]
; ROM $21 : $84000 - $87FFF

	dr _PrinterReceive, $42d5
	dr PrintDexEntry, $4426
	dr PrintUnownStamp, $4528
	dr PrintPartymon, $45c4
	dr _PrintDiploma, $45fc
	dr _HallOfFamePC, $67f3

	dr

SECTION "rom34", ROMX[$4000], BANK[34]
; ROM $22 : $88000 - $8BFFF

	dr

SECTION "rom35", ROMX[$4000], BANK[35]
; ROM $23 : $8C000 - $8FFFF

	dr SaveMenu_CopyTilemapAtOnce, $4000
	dr DummyPredef35, $417a
DummyPredef36::
	dr UpdateTimeOfDayPal, $417b
	dr _TimeOfDayPals, $418b
	dr _UpdateTimePals, $41bc
	dr FadeInFromWhite, $41c5
	dr FadeOutToWhite, $41d0
	dr FadeInFromBlack, $41de
	dr FadeOutToBlack, $41e9
	dr ReplaceTimeOfDayPals, $420e
	dr DoBattleTransition, $4338
	dr PlayWhirlpoolSound, $4883
	dr BlindingFlash, $4890
	dr ShakeHeadbuttTree, $48b3
	dr OWCutAnimation, $49dd
	dr FlyFromAnim, $4b8a
	dr FlyToAnim, $4bd0
	dr MagnetTrain, $4ca1
	dr ClearSpriteAnims, $4f99
	dr PlaySpriteAnimationsAndDelayFrame, $4fa8
	dr PlaySpriteAnimations, $4faf
	dr _InitSpriteAnimStruct, $501c
	dr _ReinitSpriteAnimFrame, $5152
	set_gs_diff $1a
	drd AnimateEndOfExpBar, $6503
	drd ClearSpriteAnims2, $657a
	drd LoadOverworldMonIcon, $6591
	drd LoadMenuMonIcon, $65a5
	drd FreezeMonIcons, $6701
	drd UnfreezeMonIcons, $6728
	drd HoldSwitchmonIcon, $6743

	dr

SECTION "rom36", ROMX[$4000], BANK[36]
; ROM $24 : $90000 - $93FFF

	dr GetCallerLocation, $441f
	dr InitClock, $4677
	dr SetDayOfWeek, $494b
	dr PrintHour, $4a86
	dr PokeGear, $4ada
	dr _TownMap, $59e1
	dr PlayRadio, $5ae9
	dr PokegearMap, $5b77
	dr _FlyMap, $5b89
	dr Pokedex_GetArea, $5da5
	dr RegionCheck, $689d
	dr Fish, $68c9
	dr _SlotMachine, $6b85

	dr

SECTION "rom37", ROMX[$4000], BANK[37]
; ROM $25 : $94000 - $97FFF

	dr MapScenes, $4000
	dr MapGroupPointers, $40ed
	dr OverworldLoop, $65f9
	dr EnableScriptMode, $6b89
	dr ScriptEvents, $6b91
	dr CallCallback, $7389
	dr WarpToSpawnPoint, $7a7d
	dr ClearCmdQueue, $7c4e

	dr

SECTION "rom38", ROMX[$4000], BANK[38]
; ROM $26 : $98000 - $9BFFF

	dr

SECTION "rom39", ROMX[$4000], BANK[39]
; ROM $27 : $9C000 - $9FFFF

	dr

SECTION "rom40", ROMX[$4000], BANK[40]
; ROM $28 : $A0000 - $A3FFF

	dr

SECTION "rom41", ROMX[$4000], BANK[41]
; ROM $29 : $A4000 - $A7FFF

	dr

SECTION "rom42", ROMX[$4000], BANK[42]
; ROM $2a : $A8000 - $ABFFF

	dr

SECTION "rom43", ROMX[$4000], BANK[43]
; ROM $2b : $AC000 - $AFFFF

	dr

SECTION "rom44", ROMX[$4000], BANK[44]
; ROM $2c : $B0000 - $B3FFF

	dr

SECTION "rom45", ROMX[$4000], BANK[45]
; ROM $2d : $B4000 - $B7FFF

	dr

SECTION "rom46", ROMX[$6300], BANK[46]
; ROM $2e : $B8000 - $BBFFF

	dr CheckForHiddenItems, $6300
	dr TreeMonEncounter, $6378
	dr RockMonEncounter, $63a1
	dr ReadPartyMonMail, $7258
	dr ReadAnyMail, $7266
	dr ItemIsMail, $7e63

	dr

SECTION "rom47", ROMX[$4000], BANK[47]
; ROM $2f : $BC000 - $BFFFF

	dr

SECTION "rom49", ROMX[$7a40], BANK[49]
; ROM $31 : $C4000 - $C7FFF

	dr _CheckPokerus, $7a40
	dr CheckForLuckyNumberWinners, $7a5a
	dr PrintTodaysLuckyNumber, $7c03
	dr CheckPartyFullAfterContest, $7c15
	dr GiveANickname_YesNo, $7d26

	dr

SECTION "rom50", ROMX[$4000], BANK[50]
; ROM $32 : $C8000 - $CBFFF
BattleAnimations::

	dr DummyPredef2F, $40e4
	dr LoadPoisonBGPals, $7c06

	dr

SECTION "rom51", ROMX[$4000], BANK[51]
; ROM $33 : $CC000 - $CFFFF
ClearBattleAnims::
BattleAnimCommands::

	dr DisplayCaughtContestMonStats, $4000
	dr DisplayAlreadyCaughtText, $40c5
	dr DummyPredef38, $40e4
DummyPredef39::
	dr PlayBattleAnim, $40e5
	dr BattleAnimCmd_RaiseSub, $45e7
	dr BattleAnimCmd_MinimizeOpp, $466c

	dr

SECTION "rom52", ROMX[$4000], BANK[52]
; ROM $34 : $D0000 - $D3FFF

	dr

SECTION "rom53", ROMX[$4000], BANK[53]
; ROM $35 : $D4000 - $D7FFF

	dr

SECTION "rom54", ROMX[$4000], BANK[54]
; ROM $36 : $D8000 - $DBFFF
StdScripts::
	drs MagazineBookshelfScript, $3
	drs IncenseBurnerScript, $5
	drs MerchandiseShelfScript, $6
	drs TownMapScript, $7
	drs WindowScript, $8
	drs TVScript, $9
	drs Radio1Script, $b
	drs BugContestResultsWarpScript, $16
	drs PCScript, $2b

	dr

SECTION "rom55", ROMX[$4000], BANK[55]
; ROM $37 : $DC000 - $DFFFF

	dr rom55_end, $5773

SECTION "rom56", ROMX[$4000], BANK[56]
; ROM $38 : $E0000 - $E3FFF

	dr _Diploma, $4002
	dr RotateUnownFrontpic, $47cf
	dr _CardFlip, $48bd
	dr _UnownPuzzle, $5995
	dr _MemoryGame, $667a
	dr _DepositPKMN, $6bb6
	dr _WithdrawPKMN, $6d81
	dr _MovePKMNWithoutMail, $6f4e
	dr _ChangeBox, $7ce3

	dr

SECTION "rom57", ROMX[$4000], BANK[57]
; ROM $39 : $E4000 - $E7FFF

	dr CopyrightGFX, $4000
	dr TitleScreenGFX3, $41a0
	set_gs_diff $40
	drd TitleScreenGFX2, $41e0
	set_gs_diff $1b8
	drd TitleScreenGFX1, $4410
	set_gs_diff $180
	drd TitleScreenTilemap, $497c
	set_gs_diff $17a
	drd _Option, $4a35
	drd SplashScreen, $5196
	drd GoldSilverIntro, $549f

	dr

SECTION "rom58", ROMX[$4000], BANK[58]
; ROM $3a : $E8000 - $EBFFF
LoadMusicByte::

	dr _InitSound, $4000
	dr _UpdateSound, $405c
	dr _PlayMusic, $4b30
	dr _PlayCry, $4b79
	dr _PlaySFX, $4c04
	dr ClearChannels, $4fe9

	dr

SECTION "rom59", ROMX[$4000], BANK[59]
; ROM $3b : $EC000 - $EFFFF

	dr

SECTION "rom60", ROMX[$4000], BANK[60]
; ROM $3c : $F0000 - $F3FFF

	dr PokemonCries, $6747

	dr

SECTION "rom61", ROMX[$4000], BANK[61]
; ROM $3d : $F4000 - $F7FFF

	dr

SECTION "rom62", ROMX[$4000], BANK[62]
; ROM $3e : $F8000 - $FBFFF

	dr _LoadStandardFont, $4000
	dr _LoadFontsExtra, $400c
	dr _LoadFontsBattleExtra, $4032
	dr LoadBattleFontsHPBar, $4066
	dr LoadHPBar, $4081
	dr LoadStatsScreenPageTilesGFX, $40d9
	dr EnemyHPBarBorderGFX, $4bb2
	dr HPExpBarBorderGFX, $4bd2
	dr ExpBarGFX, $4c02
	dr Footprints, $519a
	dr UnownFont, $719a
	dr CollisionPermissionTable, $734a
	dr Shrink1Pic, $744a
	dr Shrink2Pic, $74da
	dr ValidateOTTrademon, $751a
	dr CheckAnyOtherAliveMonsForTrade, $7579
	dr PlaceTradePartnerNamesAndParty, $75a9
	dr KantoMonSpecials, $75ec
	dr _NameRater, $7683
	dr PlaySlowCry, $7933
	dr NewPokedexEntry, $7969
	dr ConvertMon_2to1, $79bd
	dr ConvertMon_1to2, $79d4
	dr UpdateUnownDex, $7ae4
	dr PrintUnownWord, $7afa
	dr CheckMagikarpLength, $7bfe
	dr CalcMagikarpLength, $7ccc
	dr MagikarpHouseSign, $7d87
	dr HiddenPowerDamage, $7db6
	dr _DisappearUser, $7e1f
	dr _AppearUserRaiseSub, $7e34
	dr _AppearUserLowerSub, $7e3c
	dr DoWeatherModifiers, $7e6f
	dr DoBadgeTypeBoosts, $7ef0

	dr

SECTION "rom63", ROMX[$4000], BANK[63]
; ROM $3f : $FC000 - $FFFFF

	dr DummyPredef3A, $4001
	dr _AnimateTileset, $4003
	dr Tileset0Anim, $401e
TilesetJohtoModernAnim::
TilesetKantoAnim::
TilesetParkAnim::
TilesetForestAnim::
	dr TilesetJohtoAnim, $404a
	dr TilesetPortAnim, $40d6
	dr TilesetEliteFourRoomAnim, $4106
	dr TilesetCaveAnim, $418e
TilesetDarkCaveAnim::
	dr TilesetIcePathAnim, $41da
	dr TilesetTowerAnim, $4226
	dr TilesetHouseAnim, $428e
TilesetPlayersHouseAnim::
TilesetPokecenterAnim::
TilesetGateAnim::
TilesetLabAnim::
TilesetFacilityAnim::
TilesetMartAnim::
TilesetMansionAnim::
TilesetGameCornerAnim::
TilesetTraditionalHouseAnim::
TilesetTrainStationAnim::
TilesetChampionsRoomAnim::
TilesetLighthouseAnim::
TilesetPlayersRoomAnim::
TilesetRuinsOfAlphAnim::
TilesetRadioTowerAnim::
TilesetUndergroundAnim::
	dr StagePartyDataForMysteryGift, $5192
	dr InitMysteryGiftLayout, $51da

	dr
