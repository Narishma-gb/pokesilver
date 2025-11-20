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


EXPORT DEF MoveDescriptions EQU $5CF7
EXPORT DEF EggPic EQU $7F21

;INCLUDE "constants_wip.asm"
INCLUDE "main.asm"
	set_gs_diff 0


SECTION "rom4", ROMX, BANK[4]
; ROM $04 : $10000 - $13FFF
	set_bank_offset 4

	dr _InitializeStartDay, $578b
	dr CheckUnusedTwoDayTimer, $5892
	dr RestartLuckyNumberCountdown, $58b1
	dr _CheckLuckyNumberShowFlag, $58c8
	dr DoMysteryGiftIfDayHasPassed, $58ce
	dr CanLearnTMHMMove, $59bf
	dr GetTMHMMove, $59f0
	dr _NamingScreen, $5a3d
	dr NamingScreen, $5a47
	dr Script_AbortBugContest, $64e8
	dr HealMachineAnim, $656d
	dr ItemFinder, $67e0
	dr PartyMonItemName, $6d7a
	dr GiveParkBalls, $7a0c
	dr _BugContestJudging, $7b1d
	dr SelectRandomBugContestContestants, $7eb5
	dr ContestDropOffMons, $7f1f
	dr ContestReturnMons, $7f3e

	dr_end

SECTION "rom5", ROMX, BANK[5]
; ROM $05 : $14000 - $17FFF
	set_bank_offset 5

	dr GetTimeOfDay, $4032
	dr StartClock, $4089
	dr ClockContinue, $40ae
	dr _InitTime, $40d1
	dr _UpdatePlayerSprite, $410e
	dr LoadStandingSpritesGFX, $411d
	dr LoadWalkingSpritesGFX, $412e
	dr RefreshSprites, $413f
	dr LoadUsedSpritesGFX, $41f8
	dr _DoesSpriteHaveFacings, $42e9
	dr _GetSpritePalette, $4306
	dr CheckWarpCollision, $49ea
	dr CheckDirectionalWarp, $49ff
	dr CheckWarpFacingDown, $4a16
	dr CheckCutCollision, $4a45
	dr EmptyAllSRAMBanks, $4a6a
	dr StartMoveMonWOMail_SaveGame, $4ba4
	dr TryLoadSaveFile, $4e21
	dr TryLoadSaveData, $4e8c
	dr _LoadOverworldTilemap, $52fa
	dr IsSpawnPoint, $53d2
	dr RunMapSetupScript, $53f1
	dr SkipUpdateMapSprites, $5579
	dr CheckUpdatePlayerSprite, $557f
	dr Tilesets, $562b
	dr PokemonCenterPC, $57de
	dr _PlayersHousePC, $592c
	dr BankOfMom, $6759
	dr DayCareMan, $6cde
	dr DayCareLady, $6d32
	dr DayCareManOutside, $71b1
	dr _UnownPrinter, $7503
	dr PhotoStudio, $76c0
	dr CheckBreedmonCompatibility, $78e9
	dr DayCareMon1, $7ee9
	dr DayCareMon2, $7f08

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

	dr RestartClock, $4021

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
	dr PlaceMoneyTopRight, $4a1a
	dr DisplayCoinCaseBalance, $4a5a
	dr DisplayMoneyAndCoinBalance, $4a83
	dr Kurt_SelectApricorn, $4ba1
	dr ProfOaksPCBoot, $67db
	dr InitDecorations, $6c42
	dr SetSpecificDecorationFlag, $73e8
	dr ToggleMaptileDecorations, $751c
	dr ToggleDecorationsVisibility, $7574
	dr GetTrainerDVs, $75cf
	dr _ReturnToBattle_UseBall, $7665

	dr_end

SECTION "rom10", ROMX, BANK[10]
; ROM $0a : $28000 - $2BFFF
	set_bank_offset 10

	dr LinkTextboxAtHL, $4d8e
	dr TradeAnimation, $4df0
	dr TradeAnimationPlayer2, $4e28
	dr CheckTimeCapsuleCompatibility, $5aae
	dr EnterTimeCapsule, $5b2e
	dr WaitForOtherPlayerToExit, $5b40
	dr SetBitsForLinkTradeRequest, $5b89
	dr SetBitsForBattleRequest, $5b92
	dr SetBitsForTimeCapsuleRequest, $5b9b
	dr WaitForLinkedFriend, $5bb2
	dr CheckLinkTimeout_Receptionist, $5c33
	dr TryQuickSave, $5cd8
	dr CheckBothSelectedSameRoom, $5cf4
	dr TimeCapsule, $5d21
	dr TradeCenter, $5d36
	dr Colosseum, $5d4b
	dr CloseLink, $5d60
	dr FailedLinkToPast, $5d68
	dr CableClubCheckWhichChris, $5db5
	dr DoMysteryGift, $5e66
	dr CopyMysteryGiftReceivedDecorationsToPC, $6575
	dr UnlockMysteryGift, $659d
	dr InitRoamMons, $688a
	dr JumpRoamMons, $6993
	dr RandomUnseenWildMon, $6aaa
	dr RandomPhoneWildMon, $6b51
	dr RandomPhoneMon, $6b99

	dr_end

SECTION "rom11", ROMX, BANK[11]
; ROM $0b : $2C000 - $2FFFF
	set_bank_offset 11

	dr TrainerClassNames, $52d6
	dr MoveDeletion, $55e2
	dr PrintMoveDescription, $5ce3

	dr_end

SECTION "rom12", ROMX, BANK[12]
; ROM $0c : $30000 - $33FFF
	set_bank_offset 12

	dr_end

SECTION "rom13", ROMX, BANK[13]
; ROM $0d : $34000 - $37FFF
	set_bank_offset 13

	dr CheckTypeMatchup, $491f
	dr RaiseStat, $630f
	dr BattleCommand_StatUpMessage, $64d3
	dr BattleCommand_StatUpFailText, $657f
	dr CalcPlayerStats, $66ff
	dr GetItemHeldEffect, $7ee8

	dr_end

SECTION "rom14", ROMX, BANK[14]
; ROM $0e : $38000 - $3BFFF
	set_bank_offset 14
BattleText::

	dr AI_Basic, $45a1
AIScoring::
	dr AI_Setup, $45f0
	dr AI_Types, $4645
	dr AI_Offensive, $46b2
	dr AI_Smart, $46ce
	dr AI_Opportunist, $52f9
	dr AI_Aggressive, $534d
	dr AI_Cautious, $53fc
	dr AI_Status, $5437
	dr AI_Risky, $548d
	dr AI_None, $54e6
	dr TrainerClassAttributes, $5580
	dr Battle_GetTrainerName, $5910
	dr ConfusedNoMoreText, $7823

	dr_end

SECTION "rom15", ROMX, BANK[15]
; ROM $0f : $3C000 - $3FFFF
	set_bank_offset 15

	dr FleeMons, $4551
	dr CheckPlayerPartyForFitMon, $5706
	dr GetPartyMonDVs, $58f1
	dr GetEnemyMonDVs, $5903
	dr UpdatePlayerHUD, $5da5
	dr UpdateEnemyHUD, $5e98
	dr MoveSelectionScreen, $6303
	dr CheckEnemyLockedIn, $6708
	dr LoadEnemyMon, $676b
	dr _BattleRandom, $6c31
	dr FillInExpBar, $720e
	dr GetBattleMonBackpic, $72bb
	dr GetEnemyMonFrontpic, $72fa
	dr StartBattle, $733f
	dr _DisplayLinkRecord, $75de

	dr_end

SECTION "Evolutions and Attacks", ROMX, BANK[16]
SECTION "rom16", ROMX, BANK[16]
; ROM $10 : $40000 - $43FFF
	set_bank_offset 16

	dr MoveNames, $563e
	dr Moves, $5c6c
	dr EvolvePokemon, $6349
	dr EvolveAfterBattle, $6357
	dr LearnLevelMoves, $6625
	dr FillMoves, $667f
	dr GetPreEvolution, $692f
	dr EvosAttacksPointers, $695f

	dr_end

SECTION "rom17", ROMX, BANK[17]
; ROM $11 : $44000 - $47FFF
	set_bank_offset 17, $431b
PokedexDataPointerFirstTable::

	set_gs_diff -34
	drd PokedexDataPointerSecondTable, $58c2

	set_gs_diff $3e
	drd PlaceGraphic, $7aa0
	drd DeletePartyMonMail, $7cc8
	drd IsAnyMonHoldingMail, $7ce4

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

	dr SelectMonFromParty, $4000
	dr LoadPartyMenuGFX, $404f
	dr WritePartyMenuTilemap, $405f
	dr InitPartyMenuGFX, $4349
	dr InitPartyMenuWithCancel, $436e
	dr PartyMenuSelect, $43c0
	dr PlacePartyMenuText, $4403
	dr PrintPartyMenuActionText, $44c8
	dr LoadFishingGFX, $45d1
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
	dr CalcLevel, $5523
	dr CalcExpAtLevel, $554f
	dr GetUnownLetter, $5748
	dr GetMonFrontpic, $577f
	dr GetMonBackpic, $57ed
	dr GetTrainerPic, $588a
	dr DecompressGet2bpp, $58e4
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
	dr _PrintDiploma, $45fc

	dr_end

SECTION "rom34", ROMX, BANK[34]
; ROM $22 : $88000 - $8BFFF
	set_bank_offset 34

	dr_end

SECTION "rom35", ROMX, BANK[35]
; ROM $23 : $8C000 - $8FFFF
	set_bank_offset 35

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
	dr PlaySpriteAnimations, $4faf
	dr _InitSpriteAnimStruct, $501c
	dr _ReinitSpriteAnimFrame, $5152

	dr_end

SECTION "rom36", ROMX, BANK[36]
; ROM $24 : $90000 - $93FFF
	set_bank_offset 36

	dr InitClock, $4677
	dr SetDayOfWeek, $494b
	dr PrintHour, $4a86
	dr _TownMap, $59e1
	dr PlayRadio, $5ae9
	dr PokegearMap, $5b77
	dr _FlyMap, $5b89
	dr Pokedex_GetArea, $5da5
	dr Fish, $68c9
	dr _SlotMachine, $6b85

	dr_end

SECTION "rom37", ROMX, BANK[37]
; ROM $25 : $94000 - $97FFF
	set_bank_offset 37

	dr MapScenes, $4000
	dr MapGroupPointers, $40ed
	dr OverworldLoop, $65f9
	dr EnableScriptMode, $6b89
	dr ScriptEvents, $6b91
	dr CallCallback, $7389
	dr WarpToSpawnPoint, $7a7d
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

	dr TreeMonEncounter, $6378
	dr RockMonEncounter, $63a1

	dr_end

SECTION "rom47", ROMX, BANK[47]
; ROM $2f : $BC000 - $BFFFF
	set_bank_offset 47

	dr_end

SECTION "rom48", ROMX, BANK[48]
; ROM $30 : $C0000 - $C3FFF
	set_bank_offset 48

	dr ChrisSpriteGFX, $4000

	dr_end

SECTION "rom49", ROMX, BANK[49]
; ROM $31 : $C4000 - $C7FFF
	set_bank_offset 49

	dr _CheckPokerus, $7a40
	dr CheckForLuckyNumberWinners, $7a5a
	dr PrintTodaysLuckyNumber, $7c03
	dr CheckPartyFullAfterContest, $7c15
	dr GiveANickname_YesNo, $7d26

	dr_end

SECTION "rom50", ROMX, BANK[50]
; ROM $32 : $C8000 - $CBFFF
	set_bank_offset 50
BattleAnimations::

	dr DummyPredef2F, $40e4
	dr LoadPoisonBGPals, $7c06

	dr_end

SECTION "rom51", ROMX, BANK[51]
; ROM $33 : $CC000 - $CFFFF
	set_bank_offset 51
ClearBattleAnims::
BattleAnimCommands::

	dr DisplayCaughtContestMonStats, $4000
	dr DisplayAlreadyCaughtText, $40c5
	dr DummyPredef38, $40e4
DummyPredef39::
	dr PlayBattleAnim, $40e5

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
StdScripts::

	dr_end

SECTION "rom55", ROMX, BANK[55]
; ROM $37 : $DC000 - $DFFFF
	set_bank_offset 55

	dr_end

SECTION "rom56", ROMX, BANK[56]
; ROM $38 : $E0000 - $E3FFF
	set_bank_offset 56

	dr _Diploma, $4002
	dr _CardFlip, $48bd
	dr _UnownPuzzle, $5995
	dr _MemoryGame, $667a
	dr _DepositPKMN, $6bb6
	dr _WithdrawPKMN, $6d81
	dr _MovePKMNWithoutMail, $6f4e
	dr _ChangeBox, $7ce3

	dr_end

SECTION "rom57", ROMX, BANK[57]
; ROM $39 : $E4000 - $E7FFF
	set_bank_offset 57

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
	dr Shrink1Pic, $744a
	dr Shrink2Pic, $74da
	dr _NameRater, $7683
	dr PlaySlowCry, $7933
	dr NewPokedexEntry, $7969
	dr ConvertMon_1to2, $79d4
	dr UpdateUnownDex, $7ae4
	dr CheckMagikarpLength, $7bfe
	dr MagikarpHouseSign, $7d87

	dr_end

SECTION "rom63", ROMX, BANK[63]
; ROM $3f : $FC000 - $FFFFF
	set_bank_offset 63

	dr DummyPredef3A, $4001
	dr _AnimateTileset, $4003

	dr_end
