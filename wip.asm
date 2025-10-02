; \1 Label
; \2 Label address
MACRO dr
	IF !DEF(cur_bank)
		FAIL "Error: use set_bank_offset to set Bank # and offset"
	ENDC
	ASSERT rom_offset >= 0 && rom_offset < 1048576, "Invalid ROM offset: {#x:rom_offset}"

	IF cur_bank == 0
		ASSERT FATAL, (\2) < $4000 && (\2) >= 0, "Wrong address format: \1"
		DEF label_offset = \2
	ELSE
		ASSERT FATAL, (\2) < $8000 && (\2) > $3FFF, "Wrong address format: \1"
		DEF label_offset = ((cur_bank) - 1) * $4000 + (\2)
	ENDC

	ASSERT FATAL, label_offset - rom_offset >= 0, "Negative binary INCLUDE: \1"
	IF DEF(_GOLD)
		INCBIN "baserom_g.bin", rom_offset, label_offset - rom_offset
	ELIF DEF(_SILVER)
		INCBIN "baserom_s.bin", rom_offset, label_offset - rom_offset
	ENDC
	DEF rom_offset = label_offset
	\1::
ENDM

; G/S label offset, in places where the ROMs diverge
DEF gs_diff = 0

MACRO drd
	dr \1, (\2) + gs_diff
ENDM

; Predefs
MACRO drp
	dr \1Predef, (\2) * 3 + $4b5b
ENDM

MACRO dr_end
	IF !DEF(cur_bank)
		FAIL "Error: use set_bank_offset to set Bank # and offset"
	ENDC
	ASSERT rom_offset >= 0 && rom_offset < 1048576, "Invalid ROM offset: {#x:rom_offset}"

	ASSERT FATAL, ((cur_bank) + 1) * 16384 - rom_offset >= 0, "Negative binary INCLUDE"
	IF DEF(_GOLD)
		INCBIN "baserom_g.bin", rom_offset, ((cur_bank) + 1) * 16384 - rom_offset
	ELIF DEF(_SILVER)
		INCBIN "baserom_s.bin", rom_offset, ((cur_bank) + 1) * 16384 - rom_offset
	ENDC
	PURGE cur_bank, rom_offset
ENDM

; \1 Bank #
; \2 offset into Bank (optional)
MACRO set_bank_offset
	DEF cur_bank = \1
	ASSERT FATAL, cur_bank >= 0 && cur_bank < 64, "Invalid Bank number: \1"

	IF _NARG == 1
		IF cur_bank == 0
			DEF rom_offset = 0
		ELSE
			DEF rom_offset = cur_bank * 16384
		ENDC
	ELSE
		IF cur_bank == 0
			ASSERT FATAL, (\2) < $4000 && (\2) >= 0, "Wrong address format"
			DEF rom_offset = \2
		ELSE
			ASSERT FATAL, (\2) < $8000 && (\2) > $3FFF, "Wrong address format"
			DEF rom_offset = (cur_bank - 1) * $4000 + (\2)
		ENDC
	ENDC
ENDM


;INCLUDE "constants_wip.asm"
;INCLUDE "main.asm"

SECTION "rom1", ROMX, BANK[1]
; ROM $01 : $4000 - $7FFF
	set_bank_offset 1

	dr PlaceWaitingText, $4000
	dr WriteOAMDMACodeToHRAM, $4032
	dr SpriteMovementData, $4274
	dr DeleteMapObject, $4358
	dr UpdateAllObjectsFrozen, $557f
	dr RefreshPlayerSprite, $5730
	dr StopFollow, $5795
	dr _UpdateSprites, $5896
	dr ApplyBGMapAnchorToObjects, $58c5
IF DEF(_GOLD)
	DEF gs_diff = $3b
ENDC
	drd GameInit, $670c
	drd ReanchorBGMap_NoOAMUpdate, $6718
	drd LoadFonts_NoOAMUpdate, $6792
	drd CorrectNickErrors, $6a36
	drd _Multiply, $6a75
	drd _Divide, $6ad5
	drd ItemNames, $7258

	dr_end

SECTION "rom2", ROMX, BANK[2]
; ROM $02 : $8000 - $BFFF
	set_bank_offset 2

	dr _LoadOverworldAttrmapPals, $4000
	dr _ScrollBGMapPalettes, $404f
	dr CopyObjectStruct, $46d7
	dr _Sine, $4ac9
	dr GetPredefPointer, $4b3b
	dr PredefPointers, $4b5b
	drp SmallFarFlagAction, 3
	drp PlaceGraphic, $13
	drp InitSGBBorder, $30
	drp LoadSGBLayout, $31
	drp GetMonFrontpic, $3c
	dr InitCGBPals, $5c93

	dr_end

SECTION "rom3", ROMX, BANK[3]
; ROM $03 : $C000 - $FFFF
	set_bank_offset 3

	dr EngineFlagAction, $401b
	dr _ReceiveItem, $54ac
	dr _TossItem, $54e4
	dr _CheckItem, $551b
	dr GetTMHMNumber, $56de
	dr _CheckTossableItem, $56fe
	dr _DoItemEffect, $6aa9

	dr_end

SECTION "rom4", ROMX, BANK[4]
; ROM $04 : $10000 - $13FFF
	set_bank_offset 4

	dr_end

SECTION "rom5", ROMX, BANK[5]
; ROM $05 : $14000 - $17FFF
	set_bank_offset 5

	dr GetTimeOfDay, $4032
	dr StartClock, $4089
	dr _InitTime, $40d1
	dr _UpdatePlayerSprite, $410e
	dr LoadStandingSpritesGFX, $411d
	dr LoadWalkingSpritesGFX, $412e
	dr RefreshSprites, $413f
	dr _DoesSpriteHaveFacings, $42e9
	dr _GetSpritePalette, $4306
	dr CheckWarpCollision, $49ea
	dr CheckDirectionalWarp, $49ff
	dr _LoadOverworldTilemap, $52fa
	dr RunMapSetupScript, $53f1
	dr CheckUpdatePlayerSprite, $557f
	dr Tilesets, $562b

	dr_end

SECTION "rom6", ROMX, BANK[6]
; ROM $06 : $18000 - $1BFFF
	set_bank_offset 6

	dr_end

SECTION "rom7", ROMX, BANK[7]
; ROM $07 : $1C000 - $1FFFF
	set_bank_offset 7

	dr LoadMapGroupRoof, $4000

	dr_end

SECTION "rom8", ROMX, BANK[8]
; ROM $08 : $20000 - $23FFF
	set_bank_offset 8

	dr_end

SECTION "rom9", ROMX, BANK[9]
; ROM $09 : $24000 - $27FFF
	set_bank_offset 9

	dr StringBufferPointers, $4000
	dr _2DMenu_, $400e
	dr _StaticMenuJoypad, $4136
	dr _ScrollingMenuJoypad, $4139
	dr _PushWindow, $42a0
	dr _ExitMenu, $4307
	dr _InitVerticalMenuCursor, $43a6
	dr _InitScrollingMenu, $44e8
	dr _ScrollingMenu, $4504

	dr_end

SECTION "rom10", ROMX, BANK[10]
; ROM $0a : $28000 - $2BFFF
	set_bank_offset 10

	dr_end

SECTION "rom11", ROMX, BANK[11]
; ROM $0b : $2C000 - $2FFFF
	set_bank_offset 11

	dr TrainerClassNames, $52d6

	dr_end

SECTION "rom12", ROMX, BANK[12]
; ROM $0c : $30000 - $33FFF
	set_bank_offset 12

	dr_end

SECTION "rom13", ROMX, BANK[13]
; ROM $0d : $34000 - $37FFF
	set_bank_offset 13

	dr_end

SECTION "rom14", ROMX, BANK[14]
; ROM $0e : $38000 - $3BFFF
	set_bank_offset 14
BattleText::

	dr Battle_GetTrainerName, $5910

	dr_end

SECTION "rom15", ROMX, BANK[15]
; ROM $0f : $3C000 - $3FFFF
	set_bank_offset 15

	dr UpdatePlayerHUD, $5da5
	dr UpdateEnemyHUD, $5e98
	dr _BattleRandom, $6c31

	dr_end

SECTION "rom16", ROMX, BANK[16]
; ROM $10 : $40000 - $43FFF
	set_bank_offset 16

	dr MoveNames, $563e

	dr_end

SECTION "rom17", ROMX, BANK[17]
; ROM $11 : $44000 - $47FFF
	set_bank_offset 17

	dr_end

SECTION "rom18", ROMX, BANK[18]
; ROM $12 : $48000 - $4BFFF
	set_bank_offset 18

	dr_end

SECTION "rom19", ROMX, BANK[19]
; ROM $13 : $4C000 - $4FFFF
	set_bank_offset 19

	dr_end

SECTION "rom20", ROMX, BANK[20]
; ROM $14 : $50000 - $53FFF
	set_bank_offset 20

	dr BaseData, $5aa9
	dr PokemonNames, $7a09

	dr_end

SECTION "rom21", ROMX, BANK[21]
; ROM $15 : $54000 - $57FFF
	set_bank_offset 21

	dr_end

SECTION "rom22", ROMX, BANK[22]
; ROM $16 : $58000 - $5BFFF
	set_bank_offset 22

	dr_end

SECTION "rom23", ROMX, BANK[23]
; ROM $17 : $5C000 - $5FFFF
	set_bank_offset 23

	dr_end

SECTION "rom24", ROMX, BANK[24]
; ROM $18 : $60000 - $63FFF
	set_bank_offset 24

	dr_end

SECTION "rom25", ROMX, BANK[25]
; ROM $19 : $64000 - $67FFF
	set_bank_offset 25

	dr_end

SECTION "rom26", ROMX, BANK[26]
; ROM $1a : $68000 - $6BFFF
	set_bank_offset 26

	dr_end

SECTION "rom27", ROMX, BANK[27]
; ROM $1b : $6C000 - $6FFFF
	set_bank_offset 27

	dr_end

SECTION "rom28", ROMX, BANK[28]
; ROM $1c : $70000 - $73FFF
	set_bank_offset 28

	dr_end

SECTION "rom29", ROMX, BANK[29]
; ROM $1d : $74000 - $77FFF
	set_bank_offset 29

	dr_end

SECTION "rom30", ROMX, BANK[30]
; ROM $1e : $78000 - $7BFFF
	set_bank_offset 30

	dr_end

SECTION "rom31", ROMX, BANK[31]
; ROM $1f : $7C000 - $7FFFF
	set_bank_offset 31

	dr_end

SECTION "rom32", ROMX, BANK[32]
; ROM $20 : $80000 - $83FFF
	set_bank_offset 32

	dr_end

SECTION "rom33", ROMX, BANK[33]
; ROM $21 : $84000 - $87FFF
	set_bank_offset 33

	dr _PrinterReceive, $42d5

	dr_end

SECTION "rom34", ROMX, BANK[34]
; ROM $22 : $88000 - $8BFFF
	set_bank_offset 34

	dr_end

SECTION "rom35", ROMX, BANK[35]
; ROM $23 : $8C000 - $8FFFF
	set_bank_offset 35

	dr UpdateTimeOfDayPal, $417b
	dr _TimeOfDayPals, $418b
	dr _UpdateTimePals, $41bc
	dr FadeInFromWhite, $41c5
	dr FadeOutToWhite, $41d0
	dr ReplaceTimeOfDayPals, $420e
	dr _InitSpriteAnimStruct, $501c
	dr _ReinitSpriteAnimFrame, $5152

	dr_end

SECTION "rom36", ROMX, BANK[36]
; ROM $24 : $90000 - $93FFF
	set_bank_offset 36

	dr_end

SECTION "rom37", ROMX, BANK[37]
; ROM $25 : $94000 - $97FFF
	set_bank_offset 37

	dr MapScenes, $4000
	dr MapGroupPointers, $40ed
	dr EnableScriptMode, $6b89
	dr ScriptEvents, $6b91
	dr CallCallback, $7389
	dr ClearCmdQueue, $7c4e

	dr_end

SECTION "rom38", ROMX, BANK[38]
; ROM $26 : $98000 - $9BFFF
	set_bank_offset 38

	dr_end

SECTION "rom39", ROMX, BANK[39]
; ROM $27 : $9C000 - $9FFFF
	set_bank_offset 39

	dr_end

SECTION "rom40", ROMX, BANK[40]
; ROM $28 : $A0000 - $A3FFF
	set_bank_offset 40

	dr_end

SECTION "rom41", ROMX, BANK[41]
; ROM $29 : $A4000 - $A7FFF
	set_bank_offset 41

	dr_end

SECTION "rom42", ROMX, BANK[42]
; ROM $2a : $A8000 - $ABFFF
	set_bank_offset 42

	dr_end

SECTION "rom43", ROMX, BANK[43]
; ROM $2b : $AC000 - $AFFFF
	set_bank_offset 43

	dr_end

SECTION "rom44", ROMX, BANK[44]
; ROM $2c : $B0000 - $B3FFF
	set_bank_offset 44

	dr_end

SECTION "rom45", ROMX, BANK[45]
; ROM $2d : $B4000 - $B7FFF
	set_bank_offset 45

	dr_end

SECTION "rom46", ROMX, BANK[46]
; ROM $2e : $B8000 - $BBFFF
	set_bank_offset 46

	dr_end

SECTION "rom47", ROMX, BANK[47]
; ROM $2f : $BC000 - $BFFFF
	set_bank_offset 47

	dr_end

SECTION "rom48", ROMX, BANK[48]
; ROM $30 : $C0000 - $C3FFF
	set_bank_offset 48

	dr_end

SECTION "rom49", ROMX, BANK[49]
; ROM $31 : $C4000 - $C7FFF
	set_bank_offset 49

	dr_end

SECTION "rom50", ROMX, BANK[50]
; ROM $32 : $C8000 - $CBFFF
	set_bank_offset 50
BattleAnimations::

	dr_end

SECTION "rom51", ROMX, BANK[51]
; ROM $33 : $CC000 - $CFFFF
	set_bank_offset 51
ClearBattleAnims::
BattleAnimCommands::

	dr_end

SECTION "rom52", ROMX, BANK[52]
; ROM $34 : $D0000 - $D3FFF
	set_bank_offset 52

	dr_end

SECTION "rom53", ROMX, BANK[53]
; ROM $35 : $D4000 - $D7FFF
	set_bank_offset 53

	dr_end

SECTION "rom54", ROMX, BANK[54]
; ROM $36 : $D8000 - $DBFFF
	set_bank_offset 54

	dr_end

SECTION "rom55", ROMX, BANK[55]
; ROM $37 : $DC000 - $DFFFF
	set_bank_offset 55

	dr_end

SECTION "rom56", ROMX, BANK[56]
; ROM $38 : $E0000 - $E3FFF
	set_bank_offset 56

	dr_end

SECTION "rom57", ROMX, BANK[57]
; ROM $39 : $E4000 - $E7FFF
	set_bank_offset 57

	dr_end

SECTION "rom58", ROMX, BANK[58]
; ROM $3a : $E8000 - $EBFFF
	set_bank_offset 58
LoadMusicByte::

	dr _InitSound, $4000
	dr _UpdateSound, $405c
	dr _PlayMusic, $4b30
	dr _PlayCry, $4b79
	dr _PlaySFX, $4c04

	dr_end

SECTION "rom59", ROMX, BANK[59]
; ROM $3b : $EC000 - $EFFFF
	set_bank_offset 59

	dr_end

SECTION "rom60", ROMX, BANK[60]
; ROM $3c : $F0000 - $F3FFF
	set_bank_offset 60

	dr PokemonCries, $6747

	dr_end

SECTION "rom61", ROMX, BANK[61]
; ROM $3d : $F4000 - $F7FFF
	set_bank_offset 61

	dr_end

SECTION "rom62", ROMX, BANK[62]
; ROM $3e : $F8000 - $FBFFF
	set_bank_offset 62

	dr _LoadStandardFont, $4000
	dr _LoadFontsExtra, $400c
	dr _LoadFontsBattleExtra, $4032
	dr CollisionPermissionTable, $734a

	dr_end

SECTION "rom63", ROMX, BANK[63]
; ROM $3f : $FC000 - $FFFFF
	set_bank_offset 63

	dr _AnimateTileset, $4003

	dr_end
