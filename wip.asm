; \1 Label
; \2 Label address
MACRO dr
	IF BANK(@) == 0
		DEF inc_start = @
	ELSE
		DEF inc_start = @ - $4000
	ENDC

	DEF bank_start = BANK(@) * $4000
	DEF inc_size = (\2) - @

	ASSERT FATAL, inc_size + inc_start <= $4000, "Bank overflow: \1"
	ASSERT FATAL, inc_size >= 0, "Negative binary INCLUDE: \1"

	IF DEF(_GOLD)
		INCBIN "baserom_sw99_g.bin", bank_start + inc_start, inc_size
	ELIF DEF(_SILVER)
		INCBIN "baserom_sw99_s.bin", bank_start + inc_start, inc_size
	ENDC
	\1::
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

; Predefs
MACRO drp
	dr \1Predef, (\2) * 3 + $4b5b
ENDM


EXPORT DEF EggPic EQU $7e32

INCLUDE "main.asm"

SECTION "rom2", ROMX[$4000], BANK[2]
; ROM $02 : $8000 - $BFFF

	dr _LoadOverworldAttrmapPals, $4000
	dr _ScrollBGMapPalettes, $404f
	dr SpawnPlayer, $461a
	dr CopyDECoordsToMapObject, $4653
	dr CopyObjectStruct, $46d7
	dr CopyTempObjectToObjectStruct, $4876
	dr QueueFollowerFirstStep, $4a7a
	dr _Sine, $4ac9
	dr GetPredefPointer, $4b3b
	dr PredefPointers, $4b5b
	drp SmallFarFlagAction, $3
	drp TryAddMonToParty, $6
	drp LinkTextboxAtHL, $10
	drp PlaceGraphic, $13
	drp ListMoves, $20
	drp InitSGBBorder, $30
	drp LoadSGBLayout, $31
	drp GetMonFrontpic, $3c
	drp DecompressGet2bpp, $3f
	dr ApplyMonOrTrainerPals, $51ad
	dr InitCGBPals, $5c37


SECTION "rom3", ROMX[$4000], BANK[3]
; ROM $03 : $C000 - $FFFF

	dr EngineFlagAction, $401b
	dr _ReceiveItem, $54c5
	dr _TossItem, $54fd
	dr _CheckItem, $5534
	dr GetTMHMNumber, $56ea
	dr _CheckTossableItem, $570a
	dr RemoveMonFromPartyOrBox, $62be
	dr CheckCurPartyMonFainted, $67af
	dr _DoItemEffect, $6af1


SECTION "rom4", ROMX[$4000], BANK[4]
; ROM $04 : $10000 - $13FFF

	dr _InitializeStartDay, $578b
	dr DoMysteryGiftIfDayHasPassed, $58a0
	dr NamingScreen, $5a12


SECTION "rom5", ROMX[$4000], BANK[5]
; ROM $05 : $14000 - $17FFF

	dr GetTimeOfDay, $4032
	dr StartClock, $4089
	dr ClockContinue, $40ae
	dr _InitTime, $40d1
	dr _UpdatePlayerSprite, $410e
	dr LoadStandingSpritesGFX, $411d
	dr LoadWalkingSpritesGFX, $412e
	dr RefreshSprites, $413f
	dr _DoesSpriteHaveFacings, $42e9
	dr _GetSpritePalette, $4306
	dr CheckWarpCollision, $49e4
	dr CheckDirectionalWarp, $49f9
	dr CheckWarpFacingDown, $4a10
	dr EmptyAllSRAMBanks, $4a64
	dr TryLoadSaveFile, $4e1c
	dr TryLoadSaveData, $4e78
	dr _LoadOverworldTilemap, $52e2
	dr RunMapSetupScript, $53d9
	dr CheckUpdatePlayerSprite, $5580
	dr Tilesets, $5621
	dr CheckBreedmonCompatibility, $76f7


;SECTION "rom6", ROMX[$4000], BANK[6]
; ROM $06 : $18000 - $1BFFF


SECTION "rom7", ROMX[$4000], BANK[7]
; ROM $07 : $1C000 - $1FFFF

	dr LoadMapGroupRoof, $4000


SECTION "rom8", ROMX[$4000], BANK[8]
; ROM $08 : $20000 - $23FFF

	dr RestartClock, $4021


SECTION "rom9", ROMX[$4000], BANK[9]
; ROM $09 : $24000 - $27FFF

	dr StringBufferPointers, $4000
	dr _2DMenu_, $400e
	dr _StaticMenuJoypad, $4136
	dr _ScrollingMenuJoypad, $4139
	dr _PushWindow, $42a0
	dr _ExitMenu, $4307
	dr _InitVerticalMenuCursor, $43a6
	dr _InitScrollingMenu, $44e8
	dr _ScrollingMenu, $4504
	dr InitDecorations, $6c47


SECTION "rom10", ROMX[$4000], BANK[10]
; ROM $0a : $28000 - $2BFFF

	dr DoMysteryGift, $5e41
	dr CopyMysteryGiftReceivedDecorationsToPC, $6529
	dr JumpRoamMons, $6958


SECTION "rom11", ROMX[$4000], BANK[11]
; ROM $0b : $2C000 - $2FFFF

	dr TrainerClassNames, $55b3
	dr MoveDescriptions, $5e67


;SECTION "rom12", ROMX[$4000], BANK[12]
; ROM $0c : $30000 - $33FFF


;SECTION "rom13", ROMX[$4000], BANK[13]
; ROM $0d : $34000 - $37FFF


SECTION "rom14", ROMX[$4000], BANK[14]
; ROM $0e : $38000 - $3BFFF
BattleText::

	dr Battle_GetTrainerName, $5982


SECTION "rom15", ROMX[$4000], BANK[15]
; ROM $0f : $3C000 - $3FFFF

	dr UpdatePlayerHUD, $5ba1
	dr UpdateEnemyHUD, $5c99
	dr _BattleRandom, $6a54


SECTION "rom16", ROMX[$4000], BANK[16]
; ROM $10 : $40000 - $43FFF

	dr MoveNames, $56a0
	dr Moves, $5ccd


SECTION "rom17", ROMX[$4000], BANK[17]
; ROM $11 : $44000 - $47FFF

	set_gs_diff $53
	drd DeletePartyMonMail, $7c8f


;SECTION "rom18", ROMX[$4000], BANK[18]
; ROM $12 : $48000 - $4BFFF


;SECTION "rom19", ROMX[$4000], BANK[19]
; ROM $13 : $4C000 - $4FFFF


SECTION "rom20", ROMX[$4000], BANK[20]
; ROM $14 : $50000 - $53FFF

	dr SelectMonFromParty, $4000
	dr GetTrainerPic, $57a5
	dr BaseData, $59ba
	dr PokemonNames, $791a


;SECTION "rom21", ROMX[$4000], BANK[21]
; ROM $15 : $54000 - $57FFF


;SECTION "rom22", ROMX[$4000], BANK[22]
; ROM $16 : $58000 - $5BFFF


;SECTION "rom23", ROMX[$4000], BANK[23]
; ROM $17 : $5C000 - $5FFFF


;SECTION "rom24", ROMX[$4000], BANK[24]
; ROM $18 : $60000 - $63FFF


;SECTION "rom25", ROMX[$4000], BANK[25]
; ROM $19 : $64000 - $67FFF


;SECTION "rom26", ROMX[$4000], BANK[26]
; ROM $1a : $68000 - $6BFFF


;SECTION "rom27", ROMX[$4000], BANK[27]
; ROM $1b : $6C000 - $6FFFF


;SECTION "rom28", ROMX[$4000], BANK[28]
; ROM $1c : $70000 - $73FFF


;SECTION "rom29", ROMX[$4000], BANK[29]
; ROM $1d : $74000 - $77FFF


;SECTION "rom30", ROMX[$4000], BANK[30]
; ROM $1e : $78000 - $7BFFF


;SECTION "rom31", ROMX[$4000], BANK[31]
; ROM $1f : $7C000 - $7FFFF


;SECTION "rom32", ROMX[$4000], BANK[32]
; ROM $20 : $80000 - $83FFF


SECTION "rom33", ROMX[$4000], BANK[33]
; ROM $21 : $84000 - $87FFF

	dr _PrinterReceive, $42d5


;SECTION "rom34", ROMX[$4000], BANK[34]
; ROM $22 : $88000 - $8BFFF


SECTION "rom35", ROMX[$4000], BANK[35]
; ROM $23 : $8C000 - $8FFFF

	dr UpdateTimeOfDayPal, $4001
	dr _TimeOfDayPals, $4011
	dr _UpdateTimePals, $4042
	dr FadeInFromWhite, $404b
	dr FadeOutToWhite, $4056
	dr ReplaceTimeOfDayPals, $4094
	dr ClearSpriteAnims, $4dce
	dr PlaySpriteAnimations, $4de4
	dr _InitSpriteAnimStruct, $4e51
	dr _ReinitSpriteAnimFrame, $4f87


SECTION "rom36", ROMX[$4000], BANK[36]
; ROM $24 : $90000 - $93FFF

	dr InitClock, $466f
	dr PrintHour, $4a7e


SECTION "rom37", ROMX[$4000], BANK[37]
; ROM $25 : $94000 - $97FFF

	dr MapScenes, $4000
	dr MapGroupPointers, $40e5
	dr OverworldLoop, $65f1
	dr EnableScriptMode, $6b73
	dr ScriptEvents, $6b7b
	dr CallCallback, $7358
	dr ClearCmdQueue, $7bf6


;SECTION "rom38", ROMX[$4000], BANK[38]
; ROM $26 : $98000 - $9BFFF


;SECTION "rom39", ROMX[$4000], BANK[39]
; ROM $27 : $9C000 - $9FFFF


;SECTION "rom40", ROMX[$4000], BANK[40]
; ROM $28 : $A0000 - $A3FFF


;SECTION "rom41", ROMX[$4000], BANK[41]
; ROM $29 : $A4000 - $A7FFF


;SECTION "rom42", ROMX[$4000], BANK[42]
; ROM $2a : $A8000 - $ABFFF


;SECTION "rom43", ROMX[$4000], BANK[43]
; ROM $2b : $AC000 - $AFFFF


;SECTION "rom44", ROMX[$4000], BANK[44]
; ROM $2c : $B0000 - $B3FFF


;SECTION "rom45", ROMX[$4000], BANK[45]
; ROM $2d : $B4000 - $B7FFF


;SECTION "rom46", ROMX[$4000], BANK[46]
; ROM $2e : $B8000 - $BBFFF


;SECTION "rom47", ROMX[$4000], BANK[47]
; ROM $2f : $BC000 - $BFFFF


SECTION "rom48", ROMX[$4000], BANK[48]
; ROM $30 : $C0000 - $C3FFF

	dr ChrisSpriteGFX, $4000


;SECTION "rom49", ROMX[$4000], BANK[49]
; ROM $31 : $C4000 - $C7FFF


SECTION "rom50", ROMX[$4000], BANK[50]
; ROM $32 : $C8000 - $CBFFF
BattleAnimations::


SECTION "rom51", ROMX[$4000], BANK[51]
; ROM $33 : $CC000 - $CFFFF
ClearBattleAnims::
BattleAnimCommands::


;SECTION "rom52", ROMX[$4000], BANK[52]
; ROM $34 : $D0000 - $D3FFF


;SECTION "rom53", ROMX[$4000], BANK[53]
; ROM $35 : $D4000 - $D7FFF


;SECTION "rom54", ROMX[$4000], BANK[54]
; ROM $36 : $D8000 - $DBFFF


;SECTION "rom55", ROMX[$4000], BANK[55]
; ROM $37 : $DC000 - $DFFFF


;SECTION "rom56", ROMX[$4000], BANK[56]
; ROM $38 : $E0000 - $E3FFF


SECTION "rom57", ROMX[$4000], BANK[57]
; ROM $39 : $E4000 - $E7FFF

	dr CopyrightGFX, $4000
	dr TitleScreenGFX2, $41a0
	set_gs_diff $40
	drd TitleScreenGFX3, $41e0
	set_gs_diff $1b8
	drd TitleScreenGFX1, $4410
	set_gs_diff $180
	drd TitleScreenTilemap, $497c
	set_gs_diff $17a
	drd _Option, $4a35
	drd SplashScreen, $4d8e
	drd GoldSilverIntro, $5097


SECTION "rom58", ROMX[$4000], BANK[58]
; ROM $3a : $E8000 - $EBFFF
LoadMusicByte::

	dr _InitSound, $4000
	dr _UpdateSound, $4080
	dr _PlayMusic, $4b43
	dr _PlayCry, $4b80
	dr _PlaySFX, $4c0b


;SECTION "rom59", ROMX[$4000], BANK[59]
; ROM $3b : $EC000 - $EFFFF


SECTION "rom60", ROMX[$4000], BANK[60]
; ROM $3c : $F0000 - $F3FFF

	dr PokemonCries, $66c5


;SECTION "rom61", ROMX[$4000], BANK[61]
; ROM $3d : $F4000 - $F7FFF


SECTION "rom62", ROMX[$4000], BANK[62]
; ROM $3e : $F8000 - $FBFFF

	dr _LoadStandardFont, $4000
	dr _LoadFontsExtra, $400c
	dr _LoadFontsBattleExtra, $4032
	dr CollisionPermissionTable, $734a
	dr Shrink1Pic, $744a
	dr Shrink2Pic, $74da


SECTION "rom63", ROMX[$4000], BANK[63]
; ROM $3f : $FC000 - $FFFFF

	dr _AnimateTileset, $4003
