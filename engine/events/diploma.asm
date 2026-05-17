AnimateUnusedPikachu:
	ret

AnimateUnusedPikachu2: ; unreferenced
	ret

_Diploma:
	call PlaceDiplomaOnScreen
	call WaitPressAorB_BlinkCursor
	ret

PlaceDiplomaOnScreen:
	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	call DisableLCD
	ld hl, DiplomaGFX
	ld de, vTiles2
	call Decompress
	ld hl, DiplomaPage1Tilemap
	decoord 0, 0
	ld bc, SCREEN_AREA
	call CopyBytes
	ld de, .Player
	hlcoord 3, 5
	call PlaceString
	ld de, .Sama
	hlcoord 15, 5
	call PlaceString
	ld de, wPlayerName
	hlcoord 9, 5
	call PlaceString
	ld de, .Certification
	hlcoord 3, 8
	call PlaceString
	ld de, .GameFreak
	hlcoord 11, 16
	call PlaceString
	call EnableLCD
	call WaitBGMap
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	call SetDefaultBGPAndOBP
	call DelayFrame
	ret

.Player:
	db "プレイヤー@"

.Sama:
	db "さま@"

.Certification:
	db   "しんがた　#ずかんを"
	next "みごと　かんせい　させた"
	next "いだいな　こうせきを　たたえ"
	next "ここに　しょうめい　します"
	db   "@"

.GameFreak:
	db "ゲームフリーク@"

PrintDiplomaPage2:
	hlcoord 0, 0
	ld bc, SCREEN_AREA
	ld a, '　'
	call ByteFill
	ld hl, DiplomaPage2Tilemap
	decoord 0, 0
	ld bc, SCREEN_AREA
	call CopyBytes
	ld de, .PlayTime
	hlcoord 3, 15
	call PlaceString
	hlcoord 12, 15
	ld de, wGameTimeHours
	lb bc, 2, 4
	call PrintNum
	ld [hl], $67 ; colon
	inc hl
	ld de, wGameTimeMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ret

.PlayTime:
	db "プレイじかん@"

DiplomaGFX:
INCBIN "gfx/diploma/diploma.2bpp.lz"

DiplomaPage1Tilemap:
INCBIN "gfx/diploma/page1.tilemap"

DiplomaPage2Tilemap:
INCBIN "gfx/diploma/page2.tilemap"
