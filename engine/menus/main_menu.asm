	; MainMenuItems indexes
	const_def
	const MAINMENU_NEW_GAME ; 0
	const MAINMENU_CONTINUE ; 1
	const MAINMENU_MYSTERY  ; 2

	; MainMenu.Strings and MainMenu.Jumptable indexes
	const_def
	const MAINMENUITEM_CONTINUE     ; 0
	const MAINMENUITEM_NEW_GAME     ; 1
	const MAINMENUITEM_OPTION       ; 2
	const MAINMENUITEM_MYSTERY_GIFT ; 3

MainMenu:
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld de, MUSIC_MAIN_MENU
	call PlayMusic
.loop
	call ClearTilemapEtc
	ld b, SCGB_DIPLOMA
	call GetSGBLayout
	ld hl, wGameTimerPaused
	res GAME_TIMER_COUNTING_F, [hl]
	call MainMenu_GetWhichMenu
	ld [wWhichIndexSet], a
	nop
	nop
	nop
	ld hl, .MenuHeader
	call LoadMenuHeader
	call MainMenuJoypadLoop
	call CloseWindow
	jr c, .quit
	call ClearTilemap
	ld a, [wMenuSelection]
	ld hl, .Jumptable
	rst JumpTable
	jr .loop

.quit
	jp StartTitleScreen

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 13, 7
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 0 ; items
	dw MainMenuItems
	dw PlaceMenuStrings
	dw .Strings

.Strings:
; entries correspond to MAINMENUITEM_* constants
	db "つづきから　はじめる@"
	db "さいしょから　はじめる@"
	db "せっていを　かえる@"
	db "ふしぎな　おくりもの@"

.Jumptable:
; entries correspond to MAINMENUITEM_* constants
	dw Continue
	dw NewGame
	dw Option
	dw MysteryGift

MainMenuItems:
; entries correspond to MAINMENU_* constants

	; MAINMENU_NEW_GAME
	db 2
	db MAINMENUITEM_NEW_GAME
	db MAINMENUITEM_OPTION
	db -1

	; MAINMENU_CONTINUE
	db 3
	db MAINMENUITEM_CONTINUE
	db MAINMENUITEM_NEW_GAME
	db MAINMENUITEM_OPTION
	db -1

	; MAINMENU_MYSTERY
	db 4
	db MAINMENUITEM_CONTINUE
	db MAINMENUITEM_NEW_GAME
	db MAINMENUITEM_OPTION
	db MAINMENUITEM_MYSTERY_GIFT
	db -1

MainMenu_GetWhichMenu:
	ld a, MAINMENU_NEW_GAME
	ret
	; dummied out
	ld a, [wSaveFileExists]
	and a
	jr nz, .next
	ld a, MAINMENU_NEW_GAME
	ret

.next
	ldh a, [hCGB]
	cp TRUE
	ld a, MAINMENU_CONTINUE
	ret nz
	ld a, BANK(sNumDailyMysteryGiftPartnerIDs)
	call OpenSRAM
	ld a, [sNumDailyMysteryGiftPartnerIDs]
	cp -1 ; locked?
	call CloseSRAM
	ld a, MAINMENU_CONTINUE
	ret z
	ld a, MAINMENU_MYSTERY
	ret

MainMenuJoypadLoop:
	call SetUpMenu
.loop
	nop
	nop
	nop
	call GetScrollingMenuJoypad
	ld a, [wMenuJoypad]
	cp PAD_B
	jr z, .b_button
	cp PAD_A
	jr z, .a_button
	jr .loop

.a_button
	call PlayClickSFX
	and a
	ret

.b_button
	scf
	ret

MainMenu_PrintCurrentTimeAndDay:
	ld a, [wSaveFileExists]
	and a
	ret z
	call .PlaceBox
	xor a
	ldh [hBGMapMode], a
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call .PlaceTime
	ld a, $1
	ldh [hBGMapMode], a
	pop af
	ld [wOptions], a
	ret

.PlaceBox:
	call CheckRTCStatus
	and RTC_RESET
	jr nz, .TimeFail
	hlcoord 0, 12
	ld b, 4
	ld c, 13
	call Textbox
	ret

.TimeFail:
	call SpeechTextbox
	ret

.PlaceTime:
	ld a, [wSaveFileExists]
	and a
	ret z
	call CheckRTCStatus
	and RTC_RESET
	jp nz, .PrintTimeNotSet
	call UpdateTime
	call GetWeekday
	ld b, a
	decoord 1, 14
	call PrintDayOfWeek
	decoord 2, 16
	ldh a, [hHours]
	ld c, a
	farcall PrintHour
	hlcoord 9, 16
	ld de, hMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	hlcoord 11, 16
	ld de, .minString
	call PlaceString
	ret

.minString:
	db "ふん@"

.PrintTimeNotSet:
	hlcoord 1, 14
	ld de, .TimeNotSetString
	call PlaceString
	ret

.TimeNotSetString:
	db "とけいのじこく　　ふめい@"

.MainMenuTimeUnknownText: ; unreferenced
	text "とけいのじこく　　ふめい"
	done

PrintDayOfWeek:
	push de
	ld hl, .Days
	ld a, b
	call GetNthString
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	ld h, b
	ld l, c
	ld de, .Day
	call PlaceString
	ret

.Days:
	db "にち@"
	db "げつ@"
	db "か@"
	db "すい@"
	db "もく@"
	db "きん@"
	db "ど@"
.Day:
	db "ようび@"

ClearTilemapEtc:
	xor a
	ldh [hMapAnims], a
	call ClearTilemap
	call LoadFontsExtra
	call LoadStandardFont
	call ClearWindowData
	ret

MysteryGift:
	call UpdateTime
	farcall DoMysteryGiftIfDayHasPassed
	farcall DoMysteryGift
	ret

Option:
	farcall _Option
	ret
