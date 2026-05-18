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
