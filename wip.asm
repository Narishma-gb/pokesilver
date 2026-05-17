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


INCLUDE "main.asm"
	set_gs_diff 0


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
	drd FontInversed, $4d96
	drd SplashScreen, $5196
	drd GameFreakPresents_UpdateLogoPal, $530e
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
	dr PlayStereoSFX, $4ca6
	dr ClearChannels, $4fe9
	dr PlayTrainerEncounterMusic, $500a

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
	dr StatsScreen_LoadFont, $40a6
	dr LoadStatsScreenPageTilesGFX, $40d9
	dr FontExtra, $40f2
	dr StatsScreenPageTilesGFX, $4aa2
	dr EnemyHPBarBorderGFX, $4bb2
	dr HPExpBarBorderGFX, $4bd2
	dr ExpBarGFX, $4c02
	dr TownMapGFX, $4c92
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
	dr NPCTrade, $49ae
	dr MomTriesToBuySomething, $4f17
	dr StagePartyDataForMysteryGift, $5192
	dr InitMysteryGiftLayout, $51da

	dr
