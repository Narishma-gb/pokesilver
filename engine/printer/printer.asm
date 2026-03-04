DEF PRINTPARTY_HP EQU '◀' ; $71

SendScreenToPrinter:
.loop
	call JoyTextDelay
	call CheckCancelPrint
	jr c, .cancel
	ld a, [wJumptableIndex]
	bit JUMPTABLE_EXIT_F, a
	jr nz, .finished
	call PrinterJumptableIteration
	call CheckPrinterStatus
	call PlacePrinterStatusString
	call DelayFrame
	jr .loop

.finished
	and a
	ret

.cancel
	scf
	ret

Printer_CleanUpAfterSend:
	xor a
	ld [wPrinterConnectionOpen], a
	ld [wPrinterOpcode], a
	ret

Printer_PrepareTilemapForPrint:
	push af
	call Printer_StartTransmission
	pop af
	ld [wPrinterMargins], a
	call Printer_CopyTilemapToBuffer
	ret

Printer_ExitPrinter:
	call ReturnToMapFromSubmenu
	call Printer_RestartMapMusic
	ret

PrintDexEntry:
	ld hl, vTiles1
	ld de, FontInversed
	lb bc, BANK(FontInversed), $80
	call Request1bpp

	xor a
	ldh [hPrinter], a
	call Printer_PlayMusic

	ldh a, [rIE]
	push af
	xor a
	ldh [rIF], a
	ld a, IE_SERIAL | IE_VBLANK
	ldh [rIE], a

	call Printer_StartTransmission
	ln a, 1, 3
	ld [wPrinterMargins], a
	hlcoord 0, 0
	decoord 0, 0, wPrinterTilemapBuffer
	ld bc, 17 * SCREEN_WIDTH
	call CopyBytes
	hlcoord 0, 17, wPrinterTilemapBuffer
	ld bc, SCREEN_WIDTH
	ld a, $32
	call ByteFill
	call ClearTilemap
	ld a, %11100100
	call DmgToCgbBGPals
	call DelayFrame

	ld hl, hVBlank
	ld a, [hl]
	push af
	ld [hl], VBLANK_SERIAL

	call SendScreenToPrinter
	pop af
	ldh [hVBlank], a
	call Printer_CleanUpAfterSend

	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a

	call Printer_ExitPrinter
	ld c, 8
.low_volume_delay_frames
	call LowVolume
	call DelayFrame
	dec c
	jr nz, .low_volume_delay_frames
	ret

PrintPCBox:
	ld a, e
	ld [wAddrOfBoxToPrint], a
	ld a, d
	ld [wAddrOfBoxToPrint + 1], a
	ld a, b
	ld [wBankOfBoxToPrint], a
	ld a, c
	ld [wWhichBoxToPrint], a

	xor a
	ldh [hPrinter], a
	ld [wFinishedPrintingBox], a
	call Printer_PlayMusic

	ldh a, [rIE]
	push af
	xor a
	ldh [rIF], a
	ld a, IE_SERIAL | IE_VBLANK
	ldh [rIE], a

	ld hl, hVBlank
	ld a, [hl]
	push af
	ld [hl], VBLANK_SERIAL

	xor a
	ldh [hBGMapMode], a
	call PrintPCBox_Page1
	ln a, 1, 0 ; to be loaded to wPrinterMargins
	call Printer_PrepareTilemapForPrint
	call Printer_ResetRegistersAndStartDataSend
	jr c, .cancel

	call Printer_CleanUpAfterSend
	ld c, 12
	call DelayFrames
	xor a
	ldh [hBGMapMode], a
	call PrintPCBox_Page2
	ln a, 0, 0 ; to be loaded to wPrinterMargins
	call Printer_PrepareTilemapForPrint
	call Printer_ResetRegistersAndStartDataSend
	jr c, .cancel

	call Printer_CleanUpAfterSend
	ld c, 12
	call DelayFrames

	xor a
	ldh [hBGMapMode], a
	call PrintPCBox_Page3
	ln a, 0, 0 ; to be loaded to wPrinterMargins
	call Printer_PrepareTilemapForPrint
	call Printer_ResetRegistersAndStartDataSend
	jr c, .cancel

	call Printer_CleanUpAfterSend
	ld c, 12
	call DelayFrames

	xor a
	ldh [hBGMapMode], a
	call PrintPCBox_Page4
	ln a, 0, 3 ; to be loaded to wPrinterMargins
	call Printer_PrepareTilemapForPrint
	call Printer_ResetRegistersAndStartDataSend
.cancel
	pop af
	ldh [hVBlank], a
	call Printer_CleanUpAfterSend

	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a
	call Printer_ExitPrinter
	ret

Printer_ResetRegistersAndStartDataSend:
	call Printer_ResetJoypadRegisters
	call SendScreenToPrinter
	ret

PrintUnownStamp:
	xor a
	ldh [hPrinter], a
	call Printer_PlayMusic

	ldh a, [rIE]
	push af
	xor a
	ldh [rIF], a
	ld a, IE_SERIAL | IE_VBLANK
	ldh [rIE], a

	ld hl, hVBlank
	ld a, [hl]
	push af
	ld [hl], VBLANK_SERIAL

	xor a
	ldh [hBGMapMode], a
	call LoadTilemapToTempTilemap
	farcall PlaceUnownPrinterFrontpic
	ln a, 0, 0 ; to be loaded to wPrinterMargins
	call Printer_PrepareTilemapForPrint
	call SafeLoadTempTilemapToTilemap
	call Printer_ResetJoypadRegisters

.loop
	call JoyTextDelay
	call CheckCancelPrint
	jr c, .done
	ld a, [wJumptableIndex]
	bit JUMPTABLE_EXIT_F, a
	jr nz, .done
	call PrinterJumptableIteration
	ld a, [wJumptableIndex]
	cp $2
	jr nc, .check_status
	ld a, 6 / 2
	ld [wPrinterRowIndex], a

.check_status
	call CheckPrinterStatus
	call PlacePrinterStatusString
	call DelayFrame
	jr .loop

.done
	pop af
	ldh [hVBlank], a
	call Printer_CleanUpAfterSend
	call SafeLoadTempTilemapToTilemap

	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a
	ret

PrintMailAndExit:
	xor a
	ldh [hPrinter], a
	call Printer_PlayMusic

	ldh a, [rIE]
	push af
	xor a
	ldh [rIF], a
	ld a, IE_SERIAL | IE_VBLANK
	ldh [rIE], a

	xor a
	ldh [hBGMapMode], a

	ln a, 1, 3 ; to be loaded to wPrinterMargins
	call Printer_PrepareTilemapForPrint
	ld hl, hVBlank
	ld a, [hl]
	push af
	ld [hl], VBLANK_SERIAL

	call SendScreenToPrinter

	pop af
	ldh [hVBlank], a
	call Printer_CleanUpAfterSend
	call Printer_CopyBufferToTilemap

	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a

	call Printer_ExitPrinter
	ret

PrintPartymon:
	xor a
	ldh [hPrinter], a
	call Printer_PlayMusic

	ldh a, [rIE]
	push af
	xor a
	ldh [rIF], a
	ld a, IE_SERIAL | IE_VBLANK
	ldh [rIE], a

	xor a
	ldh [hBGMapMode], a
	call PrintPartyMon
	ln a, 1, 3 ; to be loaded to wPrinterMargins
	call Printer_PrepareTilemapForPrint

	ld hl, hVBlank
	ld a, [hl]
	push af
	ld [hl], VBLANK_SERIAL

	call SendScreenToPrinter

	pop af
	ldh [hVBlank], a
	call Printer_CleanUpAfterSend

	call Printer_CopyBufferToTilemap
	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a
	call Printer_ExitPrinter
	ret

_PrintDiploma:
	farcall PlaceDiplomaOnScreen

	xor a
	ldh [hPrinter], a
	call Printer_PlayMusic

	ldh a, [rIE]
	push af
	xor a
	ldh [rIF], a
	ld a, IE_SERIAL | IE_VBLANK
	ldh [rIE], a

	ld hl, hVBlank
	ld a, [hl]
	push af
	ld [hl], VBLANK_SERIAL

	ln a, 1, 0 ; to be loaded to wPrinterMargins
	call Printer_PrepareTilemapForPrint
	call Printer_ResetJoypadRegisters

	call SendScreenToPrinter
	jr c, .cancel
	call Printer_CleanUpAfterSend
	ld c, 12
	call DelayFrames

	call LoadTilemapToTempTilemap
	xor a
	ldh [hBGMapMode], a

	farcall PrintDiplomaPage2

	ln a, 0, 3 ; to be loaded to wPrinterMargins
	call Printer_PrepareTilemapForPrint
	call SafeLoadTempTilemapToTilemap
	call Printer_ResetJoypadRegisters

	call SendScreenToPrinter
.cancel
	pop af
	ldh [hVBlank], a
	call Printer_CleanUpAfterSend

	xor a
	ldh [rIF], a
	pop af
	ldh [rIE], a
	call Printer_ExitPrinter
	ret

CheckCancelPrint:
	ldh a, [hJoyDown]
	and PAD_B
	jr nz, .pressed_b
	and a
	ret

.pressed_b
	ld a, [wUnusedGameboyPrinterSafeCancelFlag]
	cp $0c
	jr nz, .cancel

; wait for printer activity to finish before canceling?
.loop
	ld a, [wPrinterOpcode]
	and a
	jr nz, .loop
	ld a, $16 ; cancel
	ld [wPrinterOpcode], a
	ld a, $88
	ldh [rSB], a
	ld a, SC_INTERNAL
	ldh [rSC], a
	ld a, SC_START | SC_INTERNAL
	ldh [rSC], a
.loop2
	ld a, [wPrinterOpcode]
	and a
	jr nz, .loop2

.cancel
	ld a, $1
	ldh [hPrinter], a
	scf
	ret

Printer_CopyTilemapToBuffer:
	hlcoord 0, 0
	ld de, wPrinterTilemapBuffer
	ld bc, SCREEN_AREA
	call CopyBytes
	ret

Printer_CopyBufferToTilemap:
	ld hl, wPrinterTilemapBuffer
	decoord 0, 0
	ld bc, SCREEN_AREA
	call CopyBytes
	ret

Printer_ResetJoypadRegisters:
	xor a
	ldh [hJoyReleased], a
	ldh [hJoyPressed], a
	ldh [hJoyDown], a
	ldh [hJoyLast], a
	ret

Printer_PlayMusic:
	ld de, MUSIC_PRINTER
	call PlayMusic2
	ret

Printer_RestartMapMusic:
	call RestartMapMusic
	ret

CheckPrinterStatus:
; Check for printer errors
; If [wPrinterHandshake] == -1, we're disconnected
	ld a, [wPrinterHandshake]
	cp -1
	jr nz, .printer_connected
	ld a, [wPrinterStatusFlags]
	cp -1
	jr z, .error_2
.printer_connected
	ld a, [wPrinterStatusFlags]
	and PRINTER_STATUS_ERROR_3 | PRINTER_STATUS_ERROR_4 | PRINTER_STATUS_ERROR_1
	ret z ; no error

	bit PRINTER_STATUS_ERROR_1_F, a
	jr nz, .error_1
	bit PRINTER_STATUS_ERROR_4_F, a
	jr nz, .error_4
	; paper error
	ld a, PRINTER_ERROR_3
	jr .load_text_index

.error_4
	; temperature error
	ld a, PRINTER_ERROR_4
	jr .load_text_index

.error_1
	; printer battery low
	ld a, PRINTER_ERROR_1
	jr .load_text_index

.error_2
	; connection error
	ld a, PRINTER_ERROR_2
.load_text_index
	ld [wPrinterStatus], a
	ret

PlacePrinterStatusString:
; Print nonzero printer status
	ld a, [wPrinterStatus]
	and a
	ret z
	push af
	xor a
	ldh [hBGMapMode], a
	hlcoord 2, 5
	lb bc, 10, 14
	call Textbox
	pop af
	ld e, a
	ld d, 0
	ld hl, PrinterStatusStringPointers
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 4, 7
	call PlaceString
	hlcoord 4, 15
	ld de, String_PressBToCancel
	call PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	xor a
	ld [wPrinterStatus], a
	ret

PlacePrinterStatusStringBorderless: ; unreferenced
; Similar to PlacePrinterStatusString, but with different hlcoords
; and ClearBox instead of TextBox.
	ld a, [wPrinterStatus]
	and a
	ret z
	push af
	xor a
	ldh [hBGMapMode], a
	hlcoord 2, 4
	lb bc, 13, 16
	call ClearBox
	pop af
	ld e, a
	ld d, 0
	ld hl, PrinterStatusStringPointers
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 4, 7
	call PlaceString
	hlcoord 4, 15
	ld de, String_PressBToCancel
	call PlaceString
	ld a, $1
	ldh [hBGMapMode], a
	xor a
	ld [wPrinterStatus], a
	ret

String_PressBToCancel:
	db "ビーボタンで　ちゅうし@"

PrinterStatusStringPointers:
	dw GBPrinterString_Null ; @
	dw GBPrinterString_CheckingLink ; CHECKING LINK
	dw GBPrinterString_Transmitting ; TRANSMITTING
	dw GBPrinterString_Printing ; PRINTING
	dw GBPrinterString_PrinterError1 ; error 1
	dw GBPrinterString_PrinterError2 ; error 2
	dw GBPrinterString_PrinterError3 ; error 3
	dw GBPrinterString_PrinterError4 ; error 4

GBPrinterString_Null: db "@"
GBPrinterString_CheckingLink: next "せつぞくかくにん　ちゅう@"
GBPrinterString_Transmitting: next "データてんそう　ちゅう@"
GBPrinterString_Printing: next "プリントアウト　ちゅう@"
GBPrinterString_PrinterError1:
	db   "プリントエラー　エラー１"
	next ""
	next "ポケットプリンタ　の"
	next "せつめいしょを　よんでね"
	db   "@"
GBPrinterString_PrinterError2:
	db   "プリントエラー　エラー２"
	next ""
	next "ポケットプリンタ　の"
	next "せつめいしょを　よんでね"
	db   "@"
GBPrinterString_PrinterError3:
	db   "プリントエラー　エラー３"
	next ""
	next "ポケットプリンタ　の"
	next "せつめいしょを　よんでね"
	db   "@"
GBPrinterString_PrinterError4:
	db   "プリントエラー　エラー４"
	next ""
	next "ポケットプリンタ　の"
	next "せつめいしょを　よんでね"
	db   "@"

PrintPCBox_Page1:
	xor a
	ld [wWhichBoxMonToPrint], a
	hlcoord 0, 0
	ld bc, SCREEN_AREA
	ld a, '　'
	call ByteFill
	call Printer_PlaceEmptyBoxSlotString

	hlcoord 0, 0
	ld bc, 11 * SCREEN_WIDTH
	ld a, '　'
	call ByteFill

	call Printer_PlaceSideBorders
	call Printer_PlaceTopBorder

	hlcoord 5, 4
	ld de, .String_PokemonList
	call PlaceString

	ld a, [wWhichBoxToPrint]
	ld bc, BOX_NAME_LENGTH
	ld hl, wBoxNames
	call AddNTimes
	ld d, h
	ld e, l
	hlcoord 8, 6
	call PlaceString
	ld a, 1
	call Printer_GetBoxMonSpecies
	hlcoord 2, 11
	ld c, 4
	call Printer_PrintBoxListSegment
	ret

.String_PokemonList:
	db "#リスト@"

PrintPCBox_Page2:
	hlcoord 0, 0
	ld bc, SCREEN_AREA
	ld a, '　'
	call ByteFill
	call Printer_PlaceEmptyBoxSlotString
	call Printer_PlaceSideBorders
	ld a, [wFinishedPrintingBox]
	and a
	ret nz
	ld a, 5
	call Printer_GetBoxMonSpecies
	hlcoord 2, 1
	ld c, 9
	call Printer_PrintBoxListSegment
	ret

PrintPCBox_Page3:
	hlcoord 0, 0
	ld bc, SCREEN_AREA
	ld a, '　'
	call ByteFill
	call Printer_PlaceEmptyBoxSlotString
	call Printer_PlaceSideBorders
	ld a, [wFinishedPrintingBox]
	and a
	ret nz
	ld a, 14
	call Printer_GetBoxMonSpecies
	hlcoord 2, 1
	ld c, 9
	call Printer_PrintBoxListSegment
	ret

PrintPCBox_Page4:
	hlcoord 0, 0
	ld bc, SCREEN_AREA
	ld a, '　'
	call ByteFill
	call Printer_PlaceEmptyBoxSlotString
	call Printer_PlaceSideBorders
	call Printer_PlaceBottomBorders
	ld a, [wFinishedPrintingBox]
	and a
	ret nz
	ld a, 23
	call Printer_GetBoxMonSpecies
	hlcoord 2, 1
	ld c, 8
	call Printer_PrintBoxListSegment
	ret

Printer_PrintBoxListSegment:
	ld a, [wBankOfBoxToPrint]
	call OpenSRAM
.loop
	ld a, c
	and a
	jp z, .max_length
	dec c
	ld a, [de]
	cp $ff
	jr z, .finish
	ld [wNamedObjectIndex], a
	ld [wCurPartySpecies], a

	push bc
	push hl
	push de

	push hl
	ld bc, 12
	ld a, '　'
	call ByteFill
	pop hl

	push hl
	call GetBasePokemonName
	pop hl

	push hl
	call PlaceString
	ld a, [wCurPartySpecies]
	cp EGG
	pop hl
	jr z, .ok2

	ld bc, NAME_LENGTH - 1
	add hl, bc
	call Printer_GetMonGender
	ld a, '／'
	ld [hli], a

	push hl
	ld a, [wAddrOfBoxToPrint]
	ld l, a
	ld a, [wAddrOfBoxToPrint + 1]
	ld h, a
	ld bc, sBoxMonNicknames - sBox
	add hl, bc
	ld bc, NAME_LENGTH
	ld a, [wWhichBoxMonToPrint]
	call AddNTimes
	ld e, l
	ld d, h
	pop hl

	push hl
	call PlaceString
	pop hl

	ld bc, NAME_LENGTH
	add hl, bc
	push hl
	ld a, [wAddrOfBoxToPrint]
	ld l, a
	ld a, [wAddrOfBoxToPrint + 1]
	ld h, a
	ld bc, 2 + MONS_PER_BOX + MON_LEVEL
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, [wWhichBoxMonToPrint]
	call AddNTimes
	ld a, [hl]
	pop hl
	call PrintLevel_Force3Digits
.ok2
	ld hl, wWhichBoxMonToPrint
	inc [hl]
	pop de
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	inc de
	jp .loop

.finish
	ld a, $1
	ld [wFinishedPrintingBox], a
.max_length
	call CloseSRAM
	ret

Printer_GetMonGender:
	push hl
	ld a, [wAddrOfBoxToPrint]
	ld l, a
	ld a, [wAddrOfBoxToPrint + 1]
	ld h, a
	ld bc, 2 + MONS_PER_BOX + MON_DVS
	add hl, bc
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, [wWhichBoxMonToPrint]
	call AddNTimes
	ld de, wTempMonDVs
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld a, [wWhichBoxMonToPrint]
	ld [wCurPartyMon], a
	ld a, TEMPMON
	ld [wMonType], a
	farcall GetGender
	ld a, '　'
	jr c, .got_gender
	ld a, '♂'
	jr nz, .got_gender
	ld a, '♀'
.got_gender
	pop hl
	ld [hli], a
	ret

Printer_GetBoxMonSpecies:
	push hl
	ld e, a
	ld d, 0
	ld a, [wAddrOfBoxToPrint]
	ld l, a
	ld a, [wAddrOfBoxToPrint + 1]
	ld h, a
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ret

Printer_PlaceTopBorder:
	hlcoord 0, 0
	ld a, '┌'
	ld [hli], a
	ld a, '─'
	ld c, SCREEN_WIDTH - 2
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ld a, '┐'
	ld [hl], a
	ret

Printer_PlaceSideBorders:
	hlcoord 0, 0
	ld de, SCREEN_WIDTH - 1
	ld c, SCREEN_HEIGHT
.loop
	ld a, '│'
	ld [hl], a
	add hl, de
	ld a, '│'
	ld [hli], a
	dec c
	jr nz, .loop
	ret

Printer_PlaceBottomBorders:
	hlcoord 0, 17
	ld a, '└'
	ld [hli], a
	ld a, '─'
	ld c, SCREEN_WIDTH - 2
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ld a, '┘'
	ld [hl], a
	ret

Printer_PlaceEmptyBoxSlotString:
	hlcoord 2, 1
	ld c, 9
.loop
	push bc
	push hl
	ld de, .EmptyBoxSlotString
	call PlaceString
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ret

.EmptyBoxSlotString:
	db "ーーーーー　／ーーーーー@"

PrintPartyMon:
	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	xor a
	ldh [hBGMapMode], a
	call LoadFontsBattleExtra

	ld de, GBPrinterHPIcon
	ld hl, vTiles2 tile PRINTPARTY_HP
	lb bc, BANK(GBPrinterHPIcon), 1
	call Request1bpp

	ld de, GBPrinterLvIcon
	ld hl, vTiles2 tile '<LV>'
	lb bc, BANK(GBPrinterLvIcon), 1
	call Request1bpp

	ld de, StatsScreenPageTilesGFX + 14 tiles ; shiny icon
	ld hl, vTiles2 tile '⁂'
	lb bc, BANK(StatsScreenPageTilesGFX), 1
	call Get2bpp

	xor a
	ld [wMonType], a
	farcall CopyMonToTempMon
	hlcoord 7, 0
	ld b, 16
	ld c, 11
	call Textbox
	hlcoord 0, 8
	ld b, 8
	ld c, 7
	call Textbox
	hlcoord 8, 1
	ld a, [wTempMonLevel]
	call PrintLevel_Force3Digits
	hlcoord 12, 1
	ld [hl], PRINTPARTY_HP
	inc hl
	ld de, wTempMonMaxHP
	lb bc, 2, 3
	call PrintNum
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	ld [wCurSpecies], a
	ld hl, wPartyMonNicknames
	call GetCurPartyMonName
	hlcoord 8, 3
	call PlaceString
	hlcoord 13, 3
	ld [hl], '／'
	call GetPokemonName
	hlcoord 14, 3
	call PlaceString
	hlcoord 1, 0
	ld [hl], '№'
	inc hl
	ld [hl], '．'
	inc hl
	ld de, wNamedObjectIndex
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	hlcoord 10, 5
	ld de, PrintParty_OTString
	call PlaceString
	ld hl, wPartyMonOTs
	call GetCurPartyMonName
	hlcoord 14, 5
	call PlaceString
	hlcoord 11, 6
	ld de, PrintParty_IDNoString
	call PlaceString
	hlcoord 14, 6
	ld de, wTempMonID
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum

	hlcoord 9, 8
	ld de, PrintParty_StatsString
	call PlaceString
	hlcoord 16, 8
	ld de, wTempMonAttack
	call .PrintTempMonStats
	hlcoord 16, 10
	ld de, wTempMonDefense
	call .PrintTempMonStats
	hlcoord 16, 12
	ld de, wTempMonSpclAtk
	call .PrintTempMonStats
	hlcoord 16, 14
	ld de, wTempMonSpclDef
	call .PrintTempMonStats
	hlcoord 16, 16
	ld de, wTempMonSpeed
	call .PrintTempMonStats

	hlcoord 1, 10
	ld a, [wTempMonMoves + 0]
	call PlaceMoveNameString
	hlcoord 1, 12
	ld a, [wTempMonMoves + 1]
	call PlaceMoveNameString
	hlcoord 1, 14
	ld a, [wTempMonMoves + 2]
	call PlaceMoveNameString
	hlcoord 1, 16
	ld a, [wTempMonMoves + 3]
	call PlaceMoveNameString

	call PlaceGenderAndShininess
	ld hl, wTempMonDVs
	predef GetUnownLetter
	hlcoord 0, 1
	call PrepMonFrontpic
	call WaitBGMap
	ld b, SCGB_STATS_SCREEN_HP_PALS
	call GetSGBLayout
	call SetDefaultBGPAndOBP
	ret

.PrintTempMonStats:
	lb bc, 2, 3
	call PrintNum
	ret

GetCurPartyMonName:
	ld bc, NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld e, l
	ld d, h
	ret

PlaceMoveNameString:
	and a
	jr z, .no_move

	ld [wNamedObjectIndex], a
	call GetMoveName
	jr .got_string

.no_move
	ld de, PrintParty_NoMoveString

.got_string
	call PlaceString
	ret

PlaceGenderAndShininess:
	farcall GetGender
	ld a, '　'
	jr c, .got_gender
	ld a, '♂'
	jr nz, .got_gender
	ld a, '♀'

.got_gender
	hlcoord 17, 1
	ld [hl], a
	ld bc, wTempMonDVs
	farcall CheckShininess
	ret nc
	hlcoord 18, 1
	ld [hl], '⁂'
	ret

PrintParty_OTString:
	db "おや　／@"

PrintParty_IDNoString:
	db "<ID>№@"

PrintParty_StatsString:
	db   "こうげき"
	next "ぼうぎょ"
	next "とくこう"
	next "とくぼう"
	next "すばやさ"
	db   "@"

PrintParty_NoMoveString:
	db "ーーーーーーー@"

GBPrinterHPIcon:
INCBIN "gfx/printer/hp.1bpp"

GBPrinterLvIcon:
INCBIN "gfx/printer/lv.1bpp"
