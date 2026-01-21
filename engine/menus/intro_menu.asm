NewGame:
	xor a
	ld [wDebugFlags], a
	call ResetWRAM
	call ClearTilemapEtc
	call OakSpeech
	call InitializeWorld

	ld a, SPAWN_HOME
	ld [wDefaultSpawnpoint], a

	ld a, MAPSETUP_WARP
	ldh [hMapEntryMethod], a
	jp FinishContinueFunction

ResetWRAM:
	xor a
	ldh [hBGMapMode], a
	call _ResetWRAM
	ret

_ResetWRAM:
	ld hl, wShadowOAM
	ld bc, wNewGameResetWIP - wShadowOAM
	xor a
	call ByteFill

	ld hl, wGameData
	ld bc, wGameDataEnd - wGameData
	xor a
	call ByteFill

	ldh a, [rLY]
	ldh [hUnusedBackup], a
	call DelayFrame
	ldh a, [hRandomSub]
	ld [wPlayerID], a

	ldh a, [rLY]
	ldh [hUnusedBackup], a
	call DelayFrame
	ldh a, [hRandomAdd]
	ld [wPlayerID + 1], a

	ld hl, wPartyCount
	call .InitList

	xor a
	ld [wCurBox], a
	ld [wSavedAtLeastOnce], a

	call SetDefaultBoxNames

	ld a, BANK(sBoxCount)
	call OpenSRAM
	ld hl, sBoxCount
	call .InitList
	call CloseSRAM

	ld hl, wNumItems
	call .InitList

	ld hl, wNumKeyItems
	call .InitList

	ld hl, wNumBalls
	call .InitList

	ld hl, wNumPCItems
	call .InitList

	xor a
	ld [wRoamMon1Species], a
	ld [wRoamMon2Species], a
	ld [wRoamMon3Species], a
	ld a, -1
	ld [wRoamMon1MapGroup], a
	ld [wRoamMon2MapGroup], a
	ld [wRoamMon3MapGroup], a
	ld [wRoamMon1MapNumber], a
	ld [wRoamMon2MapNumber], a
	ld [wRoamMon3MapNumber], a

	ld a, BANK(sMysteryGiftItem) ; aka BANK(sMysteryGiftUnlocked)
	call OpenSRAM
	ld hl, sMysteryGiftItem
	xor a
	ld [hli], a
	assert sMysteryGiftItem + 1 == sMysteryGiftUnlocked
	dec a ; -1
	ld [hl], a
	call CloseSRAM

	call LoadOrRegenerateLuckyIDNumber
	call InitializeMagikarpHouse

	xor a
	ld [wMonType], a

	ld [wJohtoBadges], a
	ld [wKantoBadges], a

	ld [wCoins], a
	ld [wCoins + 1], a

if START_MONEY >= $10000
	ld a, HIGH(START_MONEY >> 8)
endc
	ld [wMoney], a
	ld a, HIGH(START_MONEY) ; mid
	ld [wMoney + 1], a
	ld a, LOW(START_MONEY)
	ld [wMoney + 2], a

	xor a
	ld [wWhichMomItem], a

	ld hl, wMomItemTriggerBalance
	ld [hl], HIGH(MOM_MONEY >> 8)
	inc hl
	ld [hl], HIGH(MOM_MONEY) ; mid
	inc hl
	ld [hl], LOW(MOM_MONEY)

	call InitializeNPCNames

	farcall InitDecorations

	farcall DeletePartyMonMail

	call ResetGameTime
	ret

.InitList:
; Loads 0 in the count and -1 in the first item or mon slot.
	xor a
	ld [hli], a
	dec a
	ld [hl], a
	ret

SetDefaultBoxNames:
	ld hl, wBoxNames
	ld c, 0
.loop
	push hl
	ld de, .Box
	call CopyName2
	ld a, '１'
	add c
	dec hl
	ld [hli], a
	ld [hl], '@'
	pop hl
	ld de, BOX_NAME_LENGTH
	add hl, de
	inc c
	ld a, c
	cp NUM_BOXES
	jr c, .loop
	ret

.Box:
	db "ボックス@"

InitializeMagikarpHouse:
	ld hl, wBestMagikarpLength
	ld a, HIGH(START_MAGIKARP_SIZE)
	ld [hli], a
	ld a, LOW(START_MAGIKARP_SIZE)
	ld [hli], a
	ld_hli_a_string "ヤスアキ@"
	ret

InitializeNPCNames:
	ld hl, .Rival
	ld de, wRivalName
	call .Copy

	ld hl, .Mom
	ld de, wMomsName
	call .Copy

	ld hl, .Red
	ld de, wRedsName
	call .Copy

	ld hl, .Green
	ld de, wGreensName

.Copy:
	ld bc, NAME_LENGTH
	call CopyBytes
	ret

.Rival:  db "？？？@"
.Red:    db "レッド@"
.Green:  db "グリーン@"
.Mom:    db "おかあさん@"

InitializeWorld:
	call ShrinkPlayer
	farcall SpawnPlayer
	farcall _InitializeStartDay
	ret

LoadOrRegenerateLuckyIDNumber:
	ld a, BANK(sLuckyIDNumber)
	call OpenSRAM
	ld a, [wCurDay]
	inc a
	ld b, a
	ld a, [sLuckyNumberDay]
	cp b
	ld a, [sLuckyIDNumber + 1]
	ld c, a
	ld a, [sLuckyIDNumber]
	jr z, .skip
	ld a, b
	ld [sLuckyNumberDay], a
	call Random
	ld c, a
	call Random

.skip
	ld [wLuckyIDNumber], a
	ld [sLuckyIDNumber], a
	ld a, c
	ld [wLuckyIDNumber + 1], a
	ld [sLuckyIDNumber + 1], a
	jp CloseSRAM

Continue:
	farcall TryLoadSaveFile
	jr c, .FailToLoad
	call LoadStandardMenuHeader
	call DisplaySaveInfoOnContinue
	ld a, $1
	ldh [hBGMapMode], a
	ld c, 20
	call DelayFrames
	call ConfirmContinue
	jr nc, .Check1Pass
	call CloseWindow
	jr .FailToLoad

.Check1Pass:
	call Continue_CheckRTC_RestartClock
	jr nc, .Check2Pass
	call CloseWindow
	jr .FailToLoad

.Check2Pass:
	ld a, $8
	ld [wMusicFade], a
	ld a, LOW(MUSIC_NONE)
	ld [wMusicFadeID], a
	ld a, HIGH(MUSIC_NONE)
	ld [wMusicFadeID + 1], a
	call ClearBGPalettes
	call CloseWindow
	call ClearTilemap
	ld c, 20
	call DelayFrames
	farcall JumpRoamMons
	farcall CopyMysteryGiftReceivedDecorationsToPC
	farcall ClockContinue
	ld a, [wSpawnAfterChampion]
	cp SPAWN_LANCE
	jr z, .SpawnAfterE4
	ld a, MAPSETUP_CONTINUE
	ldh [hMapEntryMethod], a
	jp FinishContinueFunction

.FailToLoad:
	ret

.SpawnAfterE4:
	ld a, SPAWN_NEW_BARK
	ld [wDefaultSpawnpoint], a
	call PostCreditsSpawn
	jp FinishContinueFunction

SpawnAfterRed:
	ld a, SPAWN_MT_SILVER
	ld [wDefaultSpawnpoint], a

PostCreditsSpawn:
	xor a
	ld [wSpawnAfterChampion], a
	ld a, MAPSETUP_WARP
	ldh [hMapEntryMethod], a
	ret

ConfirmContinue:
.loop
	call DelayFrame
	call GetJoypad
	ld hl, hJoyPressed
	bit B_PAD_A, [hl]
	jr nz, .PressA
	bit B_PAD_B, [hl]
	jr z, .loop
	scf
	ret

.PressA:
	ret

Continue_CheckRTC_RestartClock:
	call CheckRTCStatus
	and RTC_RESET
	jr z, .pass
	farcall RestartClock
	ld a, c
	and a
	jr z, .pass
	scf
	ret

.pass
	xor a
	ret

FinishContinueFunction:
.loop
	xor a
	ld [wDontPlayMapMusicOnReload], a
	ld hl, wGameTimerPaused
	set GAME_TIMER_COUNTING_F, [hl]
	farcall OverworldLoop
	ld a, [wSpawnAfterChampion]
	cp SPAWN_RED
	jr z, .AfterRed
	jp Reset

.AfterRed:
	call SpawnAfterRed
	jr .loop

DisplaySaveInfoOnContinue:
	call CheckRTCStatus
	and RTC_RESET
	jr z, .clock_ok
	lb de, 5, 8
	call DisplayContinueDataWithRTCError
	ret

.clock_ok
	lb de, 5, 8
	call DisplayNormalContinueData
	ret

DisplayNormalContinueData:
	call Continue_LoadMenuHeader
	call Continue_DisplayBadgesDex
	call Continue_PrintGameTime
	call LoadFontsExtra
	call UpdateSprites
	ret

DisplayContinueDataWithRTCError:
	call Continue_LoadMenuHeader
	call Continue_DisplayBadgesDex
	call Continue_UnknownGameTime
	call LoadFontsExtra
	call UpdateSprites
	ret

Continue_LoadMenuHeader:
	xor a
	ldh [hBGMapMode], a
	ld hl, .MenuHeader_Dex
	ld a, [wStatusFlags]
	bit STATUSFLAGS_POKEDEX_F, a
	jr nz, .show_menu
	ld hl, .MenuHeader_NoDex

.show_menu
	call _OffsetMenuHeader
	call MenuBox
	call PlaceVerticalMenuItems
	ret

.MenuHeader_Dex:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 14, 9
	dw .MenuData_Dex
	db 1 ; default option

.MenuData_Dex:
	db 0 ; flags
	db 4 ; items
	db "しゅじんこう　<PLAYER>@"
	db "もっているバッジ　　　　こ@"
	db "#ずかん　　　　ひき@"
	db "プレイじかん@"

.MenuHeader_NoDex:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 14, 9
	dw .MenuData_NoDex
	db 1 ; default option

.MenuData_NoDex:
	db 0 ; flags
	db 4 ; items
	db "しゅじんこう　<PLAYER>@"
	db "もっているバッジ　　　　こ@"
	db "　@"
	db "プレイじかん@"

Continue_DisplayBadgesDex:
	call MenuBoxCoord2Tile
	push hl
	decoord 10, 4, 0
	add hl, de
	call Continue_DisplayBadgeCount
	pop hl
	push hl
	decoord 9, 6, 0
	add hl, de
	call Continue_DisplayPokedexNumCaught
	pop hl
	ret

Continue_PrintGameTime:
	decoord 8, 8, 0
	add hl, de
	call Continue_DisplayGameTime
	ret

Continue_UnknownGameTime:
	decoord 8, 8, 0
	add hl, de
	ld de, .three_question_marks
	call PlaceString
	ret

.three_question_marks
	db "　ふめい@"

Continue_DisplayBadgeCount:
	push hl
	ld hl, wJohtoBadges
	ld b, 2
	call CountSetBits
	pop hl
	ld de, wNumSetBits
	lb bc, 1, 2
	jp PrintNum

Continue_DisplayPokedexNumCaught:
	ld a, [wStatusFlags]
	bit STATUSFLAGS_POKEDEX_F, a
	ret z
	push hl
	ld hl, wPokedexCaught
	ld b, (NUM_POKEMON + 7) / 8
	call CountSetBits
	pop hl
	ld de, wNumSetBits
	lb bc, 1, 3
	jp PrintNum

Continue_DisplayGameTime:
	ld de, wGameTimeHours
	lb bc, 2, 3
	call PrintNum
	ld [hl], ':'
	inc hl
	ld de, wGameTimeMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	jp PrintNum

OakSpeech:
	farcall InitClock
	call RotateFourPalettesLeft
	call ClearTilemap

	ld de, MUSIC_ROUTE_30
	call PlayMusic

	call RotateFourPalettesRight
	call RotateThreePalettesRight
	xor a
	ld [wCurPartySpecies], a
	ld a, POKEMON_PROF
	ld [wTrainerClass], a
	call Intro_PrepTrainerPic

	ld b, SCGB_TRAINER_OR_MON_FRONTPIC_PALS
	call GetSGBLayout
	call Intro_RotatePalettesLeftFrontpic

	ld hl, OakText1
	call PrintText
	call RotateThreePalettesRight
	call ClearTilemap

	ld a, MARILL
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	call GetBaseData

	hlcoord 6, 4
	hlcoord 6, 4 ; redundant
	call PrepMonFrontpic

	xor a
	ld [wTempMonDVs], a
	ld [wTempMonDVs + 1], a

	ld b, SCGB_TRAINER_OR_MON_FRONTPIC_PALS
	call GetSGBLayout
	call Intro_WipeInFrontpic

	ld hl, OakText2
	call PrintText
	ld hl, OakText4
	call PrintText
	call RotateThreePalettesRight
	call ClearTilemap

	xor a
	ld [wCurPartySpecies], a
	ld a, POKEMON_PROF
	ld [wTrainerClass], a
	call Intro_PrepTrainerPic

	ld b, SCGB_TRAINER_OR_MON_FRONTPIC_PALS
	call GetSGBLayout
	call Intro_RotatePalettesLeftFrontpic

	ld hl, OakText5
	call PrintText
	call RotateThreePalettesRight
	call ClearTilemap

	xor a
	ld [wCurPartySpecies], a
	ld a, CAL
	ld [wTrainerClass], a
	call Intro_PrepTrainerPic

	ld b, SCGB_TRAINER_OR_MON_FRONTPIC_PALS
	call GetSGBLayout
	call Intro_RotatePalettesLeftFrontpic

	ld hl, OakText6
	call PrintText
	call NamePlayer
	ld hl, OakText7
	call PrintText
	ret

OakText1:
	text "いやあ　またせた！"

	para "ポケットモンスターの　せかいへ"
	line "ようこそ！"

	para "わしの　なまえは　オーキド"

	para "みんなからは　#　はかせと"
	line "したわれて　おるよ"
	prompt

OakText2:
	text "ポケットモンスター⋯⋯⋯#"

	para "この　せかいには"
	line "ポケットモンスターと　よばれる"
	cont "いきもの　たちが"
	cont "いたるところに　すんでいる！@"
	text_asm
	ld a, MARILL
	call PlayMonCry
	call WaitSFX
	ld hl, OakText3
	ret

OakText3:
	text_promptbutton
	text_end

OakText4:
	text "ひとは　#たちと"
	line "なかよく　あそんだり"
	cont "いっしょに　たたかったり⋯⋯⋯⋯"
	cont "たすけあい　ながら"
	cont "くらして　いるのじゃ"
	prompt

OakText5:
	text "しかし　わしらは　#のすべてを"
	line "しっている　わけでは　ない"

	para "#の　ひみつは"
	line "まだまだ　いっぱい　ある！"

	para "わしは　それを　ときあかすために"
	line "まいにち　#の　けんきゅうを"
	cont "つづけている　という　わけじゃ！"
	prompt

OakText6:
	text "さて<⋯>"
	line "そろそろ　きみの　なまえを"
	cont "おしえて　もらおう！"
	prompt

OakText7:
	text "<PLAYER>！"
	line "じゅんびは　いいかな？"

	para "いよいよ　これから"
	line "きみの　ものがたりが　はじまる！"

	para "たのしいことも　くるしいことも"
	line "いっぱい　きみを　まってるだろう！"

	para "ゆめと　ぼうけんと！"
	line "ポケット　モンスターの　せかいへ！"
	cont "レッツ　ゴー！"

	para "あとで　また　あおう！"
	done

NamePlayer:
	call MovePlayerPicRight
	ld hl, NameMenuHeader
	call ShowPlayerNamingChoices
	ld a, [wMenuCursorY]
	dec a
	jr z, .NewName
	ld de, wPlayerName
	call StorePlayerName
	farcall ApplyMonOrTrainerPals
	call MovePlayerPicLeft
	ret

.NewName:
	ld b, NAME_PLAYER
	ld de, wPlayerName
	farcall NamingScreen

	call RotateThreePalettesRight
	call ClearTilemap

	call LoadFontsExtra
	call WaitBGMap

	xor a
	ld [wCurPartySpecies], a
	ld a, CAL
	ld [wTrainerClass], a
	call Intro_PrepTrainerPic

	ld b, SCGB_TRAINER_OR_MON_FRONTPIC_PALS
	call GetSGBLayout
	call RotateThreePalettesLeft

	ld hl, wPlayerName
	ld de, PlayerNameArray
	call InitName
	ret

INCLUDE "data/player_names.asm"

ShowPlayerNamingChoices:
	call LoadMenuHeader
	call VerticalMenu
	ld a, [wMenuCursorY]
	dec a
	call CopyNameFromMenu
	call CloseWindow
	ret

StorePlayerName:
	ld hl, wStringBuffer2
	ld bc, NAME_LENGTH
	call CopyBytes
	ret

ShrinkPlayer:
	ldh a, [hROMBank]
	push af

	ld a, 32 ; fade time
	ld [wMusicFade], a
	ld de, MUSIC_NONE
	ld a, e
	ld [wMusicFadeID], a
	ld a, d
	ld [wMusicFadeID + 1], a

	ld de, SFX_ESCAPE_ROPE
	call PlaySFX
	pop af
	rst Bankswitch

	ld c, 8
	call DelayFrames

	ld hl, Shrink1Pic
	ld b, BANK(Shrink1Pic)
	call ShrinkFrame

	ld c, 8
	call DelayFrames

	ld hl, Shrink2Pic
	ld b, BANK(Shrink2Pic)
	call ShrinkFrame

	ld c, 8
	call DelayFrames

	hlcoord 6, 5
	ld b, 7
	ld c, 7
	call ClearBox

	ld c, 3
	call DelayFrames

	call Intro_PlaceChrisSprite
	call LoadFontsExtra

	ld c, 50
	call DelayFrames

	call RotateThreePalettesRight
	call ClearTilemap
	ret

MovePlayerPicRight:
	hlcoord 6, 4
	ld de, 1
	jr MovePlayerPic

MovePlayerPicLeft:
	hlcoord 13, 4
	ld de, -1
MovePlayerPic:
	ld c, 7 + 1
.loop
	push bc
	push hl
	push de
	xor a
	ldh [hBGMapMode], a
	lb bc, 7, 7
	predef PlaceGraphic
	xor a
	ldh [hBGMapThird], a
	call WaitBGMap
	call DelayFrame
	pop de
	pop hl
	add hl, de
	pop bc
	dec c
	jr nz, .loop
	ret

Intro_RotatePalettesLeftFrontpic:
	ld hl, IntroFadePalettes
	ld b, IntroFadePalettes.End - IntroFadePalettes
.loop
	ld a, [hli]
	call DmgToCgbBGPals
	ld c, 10
	call DelayFrames
	dec b
	jr nz, .loop
	ret

IntroFadePalettes:
	dc 1, 1, 1, 0
	dc 2, 2, 2, 0
	dc 3, 3, 3, 0
	dc 3, 3, 2, 0
	dc 3, 3, 1, 0
	dc 3, 2, 1, 0
.End

Intro_WipeInFrontpic:
	ld a, $77
	ldh [hWX], a
	call DelayFrame
	ld a, %11100100
	call DmgToCgbBGPals
.loop
	call DelayFrame
	ldh a, [hWX]
	sub $8
	cp -1
	ret z
	ldh [hWX], a
	jr .loop

Intro_PrepTrainerPic:
	ld de, vTiles2
	farcall GetTrainerPic
	xor a
	ldh [hGraphicStartTile], a
	hlcoord 6, 4
	lb bc, 7, 7
	predef PlaceGraphic
	ret

ShrinkFrame:
	ld de, vTiles2
	ld c, 7 * 7
	predef DecompressGet2bpp
	xor a
	ldh [hGraphicStartTile], a
	hlcoord 6, 4
	lb bc, 7, 7
	predef PlaceGraphic
	ret

Intro_PlaceChrisSprite:
	ld de, ChrisSpriteGFX
	lb bc, BANK(ChrisSpriteGFX), 12
	ld hl, vTiles0
	call Request2bpp

	ld hl, wShadowOAMSprite00
	ld de, .sprites
	ld a, [de]
	inc de

	ld c, a
.loop
	ld a, [de]
	inc de
	ld [hli], a ; y
	ld a, [de]
	inc de
	ld [hli], a ; x
	ld a, [de]
	inc de
	ld [hli], a ; tile id
	xor a ; PAL_OW_RED
	ld [hli], a ; attributes
	dec c
	jr nz, .loop
	ret

.sprites
	db 4
	; y pxl, x pxl, tile offset
	db  9 * TILE_WIDTH + 4,  9 * TILE_WIDTH, 0
	db  9 * TILE_WIDTH + 4, 10 * TILE_WIDTH, 1
	db 10 * TILE_WIDTH + 4,  9 * TILE_WIDTH, 2
	db 10 * TILE_WIDTH + 4, 10 * TILE_WIDTH, 3


	const_def
	const TITLESCREENOPTION_MAIN_MENU
	const TITLESCREENOPTION_DELETE_SAVE_DATA
	const TITLESCREENOPTION_RESTART
DEF NUM_TITLESCREENOPTIONS EQU const_value

IntroSequence:
	callfar SplashScreen
	jr c, StartTitleScreen
	callfar GoldSilverIntro

	; fallthrough

StartTitleScreen:
	call TitleScreen
	call DelayFrame
.loop
	call RunTitleScreen
	jr nc, .loop

	call ClearSprites
	call ClearBGPalettes

	ld hl, rLCDC
	res B_LCDC_OBJ_SIZE, [hl] ; 8x8
	call ClearTilemap
	xor a
	ldh [hLCDCPointer], a
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	call UpdateTimePals
	ld a, [wTitleScreenSelectedOption]
	and $3
	ld e, a
	ld d, 0
	ld hl, .dw
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.dw
	dw MainMenu
	dw DeleteSaveData
	dw IntroSequence
	dw IntroSequence

INCLUDE "engine/movie/title.asm"

RunTitleScreen:
	call ScrollTitleScreenClouds
	ld a, [wJumptableIndex]
	bit JUMPTABLE_EXIT_F, a
	jr nz, .done_title
	call TitleScreenScene
	ld a, $1
	ldh [hOAMUpdate], a
	farcall PlaySpriteAnimations
	xor a
	ldh [hOAMUpdate], a
	call UpdateTitleTrailSprite
	call DelayFrame
	and a
	ret

.done_title
	scf
	ret

ScrollTitleScreenClouds:
IF DEF(_GOLD)
	ldh a, [hVBlankCounter]
	and $7
	ret nz
ENDC
	ld hl, wLYOverrides + $5f
	ld a, [hl]
	dec a
	ld bc, $28
	call ByteFill
	ret

TitleScreenScene:
	ld e, a
	ld d, 0
	ld hl, .scenes
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.scenes
	dw TitleScreenTimer
	dw TitleScreenMain
	dw TitleScreenEnd

TitleScreenNextScene: ; unreferenced
	ld hl, wJumptableIndex
	inc [hl]
	ret

TitleScreenTimer:
; Next scene
	ld hl, wJumptableIndex
	inc [hl]

; Start a timer
	ld hl, wTitleScreenTimer
IF DEF(_GOLD)
	ld de, 84 * 60 + 16
ELIF DEF(_SILVER)
	ld de, 73 * 60 + 36
ENDC
	ld [hl], e
	inc hl
	ld [hl], d
	ret

TitleScreenMain:
; Run the timer down.
	ld hl, wTitleScreenTimer
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, e
	or d
	jr z, .end

	dec de
	ld [hl], d
	dec hl
	ld [hl], e

; Save data can be deleted by pressing Up + B + Select.
	call GetJoypad
	ld hl, hJoyDown
	ld a, [hl]
	and PAD_UP + PAD_B + PAD_SELECT
	cp  PAD_UP + PAD_B + PAD_SELECT
	jr z, .delete_save_data

; Press Start or A to start the game.
	ld a, [hl]
	and PAD_START | PAD_A
	jr nz, .incave
	ret

.incave
	ld a, TITLESCREENOPTION_MAIN_MENU
	jr .done

.delete_save_data
	ld a, TITLESCREENOPTION_DELETE_SAVE_DATA

.done
	ld [wTitleScreenSelectedOption], a

; Return to the intro sequence.
	ld hl, wJumptableIndex
	set JUMPTABLE_EXIT_F, [hl]
	ret

.end
; Next scene
	ld hl, wJumptableIndex
	inc [hl]

; Fade out the title screen music
	xor a ; MUSIC_NONE
	ld [wMusicFadeID], a
	ld [wMusicFadeID + 1], a
	ld hl, wMusicFade
	ld [hl], 8 ; 1 second

	ld hl, wTitleScreenTimer
	inc [hl]
	ret

TitleScreenEnd:
; Wait until the music is done fading.

	ld hl, wTitleScreenTimer
	inc [hl]

	ld a, [wMusicFade]
	and a
	ret nz

	ld a, TITLESCREENOPTION_RESTART
	ld [wTitleScreenSelectedOption], a

; Back to the intro.
	ld hl, wJumptableIndex
	set JUMPTABLE_EXIT_F, [hl]
	ret

DeleteSaveData:
	call ClearTilemap
	call GetMemSGBLayout
	call LoadStandardFont
	call LoadFontsExtra
	ld de, MUSIC_MAIN_MENU
	call PlayMusic
	ld hl, .ClearAllSaveDataText
	call PrintText
	ld hl, .NoYesMenuHeader
	call CopyMenuHeader
	call VerticalMenu
	jp c, Init
	ld a, [wMenuCursorY]
	cp 1
	jp z, Init
	farcall EmptyAllSRAMBanks
	jp Init

.ClearAllSaveDataText:
	text "すべての　セーブデータエリアを"
	line "クリア　しますか？"
	done

.NoYesMenuHeader:
	db 0 ; flags
	menu_coords 14, 7, SCREEN_WIDTH - 1, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING ; flags
	db 2 ; items
	db "いいえ@"
	db "はい@"

UpdateTitleTrailSprite:
	; Only update every 4 seconds, when the low 2 bits of [wTitleScreenTimer] are 0.
	ld a, [wTitleScreenTimer]
	and %00000011
	ret nz
IF DEF(_GOLD)
	ld bc, wSpriteAnim10
	ld hl, SPRITEANIMSTRUCT_FRAME
	add hl, bc
	ld l, [hl]
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, .TitleTrailCoords
	add hl, de
	; Every 8 seconds (i.e. every other update), get the second coords; else, get the first coords
	ld a, [wTitleScreenTimer]
	and %00000100
	srl a
	srl a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	and a
	ret z
	ld e, a
	ld d, [hl]
ELIF DEF(_SILVER)
	depixel 15, 11, 4, 0
ENDC
	ld a, SPRITE_ANIM_OBJ_GS_TITLE_TRAIL
	call InitSpriteAnimStruct
	ret

IF DEF(_GOLD)
.TitleTrailCoords:
MACRO trail_coords
	rept _NARG / 2
		DEF _dx = 4
		if \1 == 0 && \2 == 0
			DEF _dx = 0
		endc
		dbpixel \1, \2, _dx, 0
		shift 2
	endr
ENDM
	; frame 0 y, x; frame 1 y, x
	trail_coords 11, 10,  0,  0
	trail_coords 11, 13, 11, 11
	trail_coords 11, 13, 11, 15
	trail_coords 11, 17, 11, 15
	trail_coords  0,  0, 11, 15
	trail_coords  0,  0, 11, 11
ENDC

Copyright:
	call ClearTilemap
	call LoadFontsExtra
	ld de, CopyrightGFX
	ld hl, vTiles2 tile $60
	lb bc, BANK(CopyrightGFX), 26
	call Request2bpp
	hlcoord 2, 7
	ld de, CopyrightString
	jp PlaceString

CopyrightString:
	; ©1995-1999 Nintendo
	db   $60, $61, $62, $63, $61, $62, $64
	db   $65, $66, $67, $68, $69, $6a

	; ©1995-1999 Creatures inc.
	next $60, $61, $62, $63, $61, $62, $64
	db   $6b, $6c, $6d, $6e, $6f, $70, $71, $72

	; ©1995-1999 GAME FREAK inc.
	next $60, $61, $62, $63, $61, $62, $64
	db   $73, $74, $75, $76, $77, $78, $79, $71, $72

	db "@"

GameInit::
	call ClearWindowData
	farcall TryLoadSaveData
	jp IntroSequence
