	const_def 1
	const PINK_PAGE  ; 1
	const GREEN_PAGE ; 2
	const BLUE_PAGE  ; 3
DEF NUM_STAT_PAGES EQU const_value - 1

StatsScreenInit:
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a ; disable overworld tile animations

	ld c, PINK_PAGE ; first_page
	call StatsScreenMain

	; restore old values
	pop af
	ldh [hMapAnims], a
	ret

StatsScreenMain:
	push bc
	ld a, [wMonType]
	cp TEMPMON
	jr nz, .not_tempmon
	ld a, [wBufferMonSpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld hl, wBufferMon
	ld de, wTempMon
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	jr .got_stats

.not_tempmon
	call CopyMonToTempMon
	ld a, [wCurPartySpecies]
	cp EGG
	jp z, .got_stats
	ld a, [wMonType]
	cp BOXMON
	jr c, .got_stats
	call CalcTempmonStats

.got_stats
	call ClearBGPalettes
	call ClearTilemap
	call UpdateSprites
	callfar StatsScreen_LoadFont

	pop bc
	ld a, [wCurPartySpecies]
	cp EGG
	jp z, EggStatsInit
	call StatsScreen_InitUpperHalf
	ld b, 0
	jp StatsScreen_JumpToLoadPageFunction

StatsScreen_LoadPage:
	push bc
	ld de, .done_loading
	push de
	jp hl

.done_loading
	pop bc
	ld b, 1

.joypad_loop
	call GetJoypad
	ld a, [wMonType]
	cp TEMPMON
	jr nz, .not_tempmon
	push hl
	push de
	push bc
	farcall StatsScreenDPad
	pop bc
	pop de
	pop hl
	ld a, [wMenuJoypad]
	and PAD_DOWN | PAD_UP
	jr nz, StatsScreenMain
	ld a, [wMenuJoypad]
	jr .joypad_action

.not_tempmon
	ldh a, [hJoyPressed]

.joypad_action
	and PAD_CTRL_PAD | PAD_A | PAD_B
	jr z, .joypad_loop
	bit B_PAD_B, a
	jp nz, StatsScreen_Exit
	bit B_PAD_LEFT, a
	jr nz, .d_left
	bit B_PAD_RIGHT, a
	jr nz, .d_right
	bit B_PAD_A, a
	jr nz, .a_button
	bit B_PAD_UP, a
	jr nz, .d_up

; down
	ld a, [wMonType]
	cp BOXMON
	jr nc, .joypad_loop
	and a
	ld a, [wPartyCount]
	jr z, .next_mon
	ld a, [wOTPartyCount]
.next_mon
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	jr z, .joypad_loop
	ld [wCurPartyMon], a
	ld b, a
	ld a, [wMonType]
	and a
	jr nz, .load_mon
	ld a, b
	inc a
	ld [wPartyMenuCursor], a
	jr .load_mon

.d_up
	ld a, [wCurPartyMon]
	and a
	jr z, .joypad_loop
	dec a
	ld [wCurPartyMon], a
	ld b, a
	ld a, [wMonType]
	and a
	jr nz, .load_mon
	ld a, b
	inc a
	ld [wPartyMenuCursor], a
.load_mon
	jp StatsScreenMain

.a_button
	ld a, c
	cp BLUE_PAGE ; last page
	jr z, StatsScreen_Exit

.d_right
	inc c
	ld a, BLUE_PAGE ; last page
	cp c
	jr nc, StatsScreen_JumpToLoadPageFunction
	ld c, PINK_PAGE ; first page
	jr StatsScreen_JumpToLoadPageFunction

.d_left
	dec c
	jr nz, StatsScreen_JumpToLoadPageFunction
	ld c, BLUE_PAGE ; last page
; fallthrough

StatsScreen_JumpToLoadPageFunction:
	ld hl, StatsScreen_LoadPageJumptable
	push bc
	dec c
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc
	jp StatsScreen_LoadPage

EggStatsInit:
	push bc
	call EggStatsScreen
	pop bc
; fallthrough

EggStats_JoypadLoop:
	call GetJoypad
	ld a, [wMonType]
	cp TEMPMON
	jr nz, .not_tempmon
	push hl
	push de
	push bc
	farcall StatsScreenDPad
	pop bc
	pop de
	pop hl
	ld a, [wMenuJoypad]
	and PAD_DOWN | PAD_UP
	jp nz, StatsScreenMain
	ld a, [wMenuJoypad]
	jr .joypad_action

.not_tempmon
	ldh a, [hJoyPressed]
.joypad_action
	and PAD_DOWN | PAD_UP | PAD_A | PAD_B
	jr z, EggStats_JoypadLoop
	bit B_PAD_A, a
	jr nz, StatsScreen_Exit
	bit B_PAD_B, a
	jr nz, StatsScreen_Exit
	bit B_PAD_UP, a
	jr nz, EggStats_UpAction
	bit B_PAD_DOWN, a
	jp EggStats_DownAction

StatsScreen_Exit:
	call ClearBGPalettes
	call ClearTilemap
	ret

EggStats_DownAction:
	ld a, [wMonType]
	cp BOXMON
	jr nc, EggStats_JoypadLoop
	and a
	ld a, [wPartyCount]
	jr z, .next_mon
	ld a, [wOTPartyCount]
.next_mon
	ld b, a
	ld a, [wCurPartyMon]
	inc a
	cp b
	jr z, EggStats_JoypadLoop
	ld [wCurPartyMon], a
	ld b, a
	ld a, [wMonType]
	and a
	jr nz, EggStats_ScrollToLoadMon
	ld a, b
	inc a
	ld [wPartyMenuCursor], a
	jr EggStats_ScrollToLoadMon

EggStats_UpAction:
	ld a, [wCurPartyMon]
	and a
	jr z, EggStats_JoypadLoop
	dec a
	ld [wCurPartyMon], a
	ld b, a
	ld a, [wMonType]
	and a
	jr nz, EggStats_ScrollToLoadMon
	ld a, b
	inc a
	ld [wPartyMenuCursor], a
; fallthrough

EggStats_ScrollToLoadMon:
	jp StatsScreenMain

StatsScreen_LoadPageJumptable:
; entries correspond to *_PAGE constants
	table_width 2
	dw LoadPinkPage
	dw LoadGreenPage
	dw LoadBluePage
	assert_table_length NUM_STAT_PAGES

StatsScreen_InitUpperHalf:
	push bc
	xor a
	ldh [hBGMapMode], a
	ld a, [wBaseDexNo]
	ld [wTextDecimalByte], a
	ld [wCurSpecies], a
	hlcoord 1, 0
	ld [hl], '№'
	inc hl
	ld [hl], '．'
	inc hl
	ld de, wTextDecimalByte
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	hlcoord 1, 8
	call PrintLevel
	ld hl, .NicknamePointers
	call GetNicknamePointer
; Nickname
	ld a, [wMonType]
	cp BOXMON
	ld a, BANK(sBoxMonNicknames)
	call z, OpenSRAM
	ld d, h
	ld e, l
	hlcoord 1, 10
	call PlaceString
	ld a, [wMonType]
	cp BOXMON
	call z, CloseSRAM
; Gender character
	call GetGender
	jr c, .next
	ld a, '♂'
	jr nz, .got_gender
	ld a, '♀'
.got_gender
	hlcoord 5, 8
	ld [hl], a
.next
	hlcoord 1, 12
	ld a, '／'
	ld [hli], a
	ld a, [wBaseDexNo]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	call PlaceString
	call StatsScreen_PlaceVerticalDivider
	call StatsScreen_PlacePageSwitchArrows
	call StatsScreen_PlaceShinyIcon
; Place HP bar
	ld hl, wTempMonHP
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wTempMonMaxHP
	ld a, [hli]
	ld d, a
	ld e, [hl]
	callfar ComputeHPBarPixels
	ld hl, wCurHPPal
	call SetHPPal
	ld b, SCGB_STATS_SCREEN_HP_PALS
	call GetSGBLayout
	pop bc
	ret

.NicknamePointers:
	dw wPartyMonNicknames
	dw wOTPartyMonNicknames
	dw sBoxMonNicknames
	dw wBufferMonNickname

LoadPinkPage:
	push bc
	push bc
	xor a
	ldh [hBGMapMode], a
	ld a, [wBaseDexNo]
	ld [wTextDecimalByte], a
	ld [wCurSpecies], a
	ld b, PINK_PAGE
	call StatsScreen_LoadPageIndicators

; Load graphics
	hlcoord 8, 0
	lb bc, 18, 12
	call ClearBox
	hlcoord 10, 1
	ld b, $0
	call DrawPlayerHP
	hlcoord 18, 1
	ld [hl], $41 ; right HP/exp bar end cap
	hlcoord 9, 4
	ld de, .Status_Type
	call PlaceString
	ld a, [wTempMonPokerusStatus]
	ld b, a
	and $f
	jr nz, .HasPokerus
	ld a, b
	and $f0
	jr z, .NotImmuneToPkrs
	hlcoord 19, 9
	ld [hl], '．' ; Pokérus immunity dot
.NotImmuneToPkrs:
	ld a, [wMonType]
	cp BOXMON
	jr z, .StatusOK
	hlcoord 15, 4
	push hl
	ld de, wTempMonStatus
	call PlaceStatusString
	pop hl
	jr .StatusOK
.HasPokerus:
	ld de, .PkrsStr
	hlcoord 15, 4
	call PlaceString
	jr .done_status
.StatusOK:
	ld de, .OK_str
	call z, PlaceString
.done_status
	hlcoord 14, 6
	call PrintMonTypes
	hlcoord 8, 10
	ld b, 6
	ld c, 10
	call Textbox
	hlcoord 10, 10
	ld de, .ExpPointStr
	call PlaceString
; print next level
	ld a, [wTempMonLevel]
	push af
	cp MAX_LEVEL
	jr z, .got_level
	inc a
	ld [wTempMonLevel], a
.got_level
	hlcoord 16, 14
	call PrintLevel
	pop af
	ld [wTempMonLevel], a
	ld de, wTempMonExp
	hlcoord 12, 11
	lb bc, 3, 7
	call PrintNum
; level-up graphics and strings
	call .CalcExpToNextLevel
	ld de, wExpToNextLevel
	hlcoord 10, 13
	lb bc, 3, 7
	call PrintNum
	hlcoord 9, 13
	ld de, .LevelUpStr
	call PlaceString
	hlcoord 17, 13
	ld de, .ToStr
	call PlaceString
	ld a, [wTempMonLevel]
	ld b, a
	ld de, wTempMonExp + 2
	hlcoord 10, 16
	predef FillInExpBar
	hlcoord 9, 16
	ld [hl], $40 ; left exp bar end cap
	hlcoord 18, 16
	ld [hl], $41 ; right exp bar end cap

; Load palettes / place frontpic
	pop bc
	farcall LoadStatsScreenPals
	call WaitBGMap
	ld a, 1
	ldh [hBGMapMode], a
	pop bc
	ld a, b
	and a
	jp z, StatsScreen_PlaceFrontpic
	ret

.CalcExpToNextLevel:
	ld a, [wTempMonLevel]
	cp MAX_LEVEL
	jr z, .AlreadyAtMaxLevel
	inc a
	ld d, a
	call CalcExpAtLevel
	ld hl, wTempMonExp + 2
	ld hl, wTempMonExp + 2
	ldh a, [hQuotient + 3]
	sub [hl]
	dec hl
	ld [wExpToNextLevel + 2], a
	ldh a, [hQuotient + 2]
	sbc [hl]
	dec hl
	ld [wExpToNextLevel + 1], a
	ldh a, [hQuotient + 1]
	sbc [hl]
	ld [wExpToNextLevel], a
	ret

.AlreadyAtMaxLevel:
	ld hl, wExpToNextLevel
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

.Status_Type:
	db   "じょうたい／"
	next "タイプ／@"

.OK_str:
	db "ふつう@"

.ExpPointStr:
	db "　けいけんち　@"

.LevelUpStr:
	db "あと@"

.ToStr:
	db "で@"

.PkrsStr:
	db "ポケルス@"

StatsScreen_PlaceVerticalDivider:
	hlcoord 7, 0
	ld bc, SCREEN_WIDTH
	ld d, SCREEN_HEIGHT
.loop
	ld a, $31 ; vertical divider
	ld [hl], a
	add hl, bc
	dec d
	jr nz, .loop
	ret

StatsScreen_PlacePageSwitchArrows:
; place "◀ページ▶"
	hlcoord 2, 16
	ld a, $32
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	ret

StatsScreen_PlaceShinyIcon:
	ld bc, wTempMonDVs
	callfar CheckShininess
	ret nc
	hlcoord 6, 8
	ld [hl], '⁂'
	ret

LoadGreenPage:
	push bc
	push bc
	xor a
	ldh [hBGMapMode], a
	ld b, GREEN_PAGE
	call StatsScreen_LoadPageIndicators

; Load graphics
	hlcoord 8, 0
	lb bc, 18, 12
	call ClearBox
; item info
	hlcoord 8, 1
	ld de, .Item
	call PlaceString
	ld a, [wTempMonItem]
	and a
	ld de, .None
	jr z, .got_item_name
	ld b, a
	farcall TimeCapsule_ReplaceTeruSama
	ld a, b
	ld [wNamedObjectIndex], a
	call GetItemName
.got_item_name
	hlcoord 12, 2
	call PlaceString
; move info
	ld hl, wTempMonMoves
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	call CopyBytes
	hlcoord 8, 4
	ld b, 12
	ld c, 10
	call Textbox
	hlcoord 10, 4
	ld de, .Move
	call PlaceString
	hlcoord 9, 6
	ld a, SCREEN_WIDTH * 3
	ld [wListMovesLineSpacing], a
	call ListMoves
	hlcoord 11, 7
	ld a, SCREEN_WIDTH * 3
	ld [wListMovesLineSpacing], a
	call ListMovePP

; Load palettes / place frontpic
	pop bc
	farcall LoadStatsScreenPals
	call WaitBGMap
	ld a, 1
	ldh [hBGMapMode], a
	pop bc
	ld a, b
	and a
	jp z, StatsScreen_PlaceFrontpic
	ret

.Item:
	db "もちもの@"

.None:
	db "なし@"

.Move:
	db "　つかえるわざ　@"

LoadBluePage:
	push bc
	push bc
	xor a
	ldh [hBGMapMode], a
	ld b, BLUE_PAGE
	call StatsScreen_LoadPageIndicators

; Load graphics
	hlcoord 8, 0
	lb bc, 18, 12
	call ClearBox
	call .PlaceOTInfo
	hlcoord 8, 6
	ld b, 10
	ld c, 10
	call Textbox
	hlcoord 9, 8
	ld bc, 6
	call PrintTempMonStats

; Load palettes / place frontpic
	pop bc
	farcall LoadStatsScreenPals
	call WaitBGMap
	ld a, 1
	ldh [hBGMapMode], a
	pop bc
	ld a, b
	and a
	jp z, StatsScreen_PlaceFrontpic
	ret

.PlaceOTInfo:
	hlcoord 9, 1
	ld de, IDNoOTString
	call PlaceString
	hlcoord 12, 1
	ld de, wTempMonID
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	ld hl, .OTNamePointers
	call GetNicknamePointer
; OT name
	ld a, [wMonType]
	cp BOXMON
	ld a, BANK(sBoxMonOTs)
	call z, OpenSRAM
	ld de, wStringBuffer1
	push de
	ld bc, NAME_LENGTH
	call CopyBytes
	pop de
	ld a, [wMonType]
	cp BOXMON
	call z, CloseSRAM
	callfar CorrectNickErrors
	hlcoord 12, 3
	call PlaceString
	ret

.OTNamePointers:
	dw wPartyMonOTs
	dw wOTPartyMonOTs
	dw sBoxMonOTs
	dw wBufferMonOT

IDNoOTString:
	db "<ID>№／"
	next "おや／"
	next "@"

StatsScreen_PlaceFrontpic:
	push bc
	call SetDefaultBGPAndOBP
	ld hl, wTempMonDVs
	call GetUnownLetter
	hlcoord 0, 1
	ld a, [wCurPartySpecies]
	cp UNOWN
	jr z, .unown

	call PrepMonFrontpic
	jr .play_cry

.unown
	xor a
	ld [wBoxAlignment], a
	call _PrepMonFrontpic

.play_cry
	ld a, [wCurPartySpecies]
	call PlayMonCry
	pop bc
	ld b, 1
	ret

EggStatsScreen:
	ld hl, wCurHPPal
	call SetHPPal
	ld b, SCGB_STATS_SCREEN_HP_PALS
	call GetSGBLayout
	call StatsScreen_PlaceVerticalDivider
	hlcoord 2, 9
	ld de, EggString
	call PlaceString
	hlcoord 9, 1
	ld de, IDNoOTString
	call PlaceString
	hlcoord 12, 1
	ld de, FiveQMarkString
	call PlaceString
	hlcoord 12, 3
	ld de, FiveQMarkString
	call PlaceString
	ld a, [wTempMonHappiness] ; egg status
	ld de, EggSoonString
	cp $6
	jr c, .picked
	ld de, EggCloseString
	cp $b
	jr c, .picked
	ld de, EggMoreTimeString
	cp $29
	jr c, .picked
	ld de, EggALotMoreTimeString
.picked
	hlcoord 9, 6
	call PlaceString
	call WaitBGMap
	ld a, 1
	ldh [hBGMapMode], a
	call SetDefaultBGPAndOBP
	hlcoord 0, 1
	call PrepMonFrontpic
	ld a, [wTempMonHappiness]
	cp 6
	ret nc
	ld de, SFX_2_BOOPS
	call PlaySFX
	call WaitSFX
	ret

EggString:
	db "タマゴ@"

FiveQMarkString:
	db "？？？？？@"

EggSoonString:
	db   "なかから　おとが"
	next "きこえてくる"
	next "もうすぐ　うまれそう！@"

EggCloseString:
	db   "ときどき　なかで"
	next "うごいて　いるようだ"
	next "うまれるまで"
	next "もうちょっと　かな？@"

EggMoreTimeString:
	db   "なにが　うまれて"
	next "くるのかな？"
	next "うまれるまで"
	next "まだまだ　かかりそう@"

EggALotMoreTimeString:
	db   "この　タマゴは"
	next "うまれるまで　かなり"
	next "かかりそう@"

StatsScreen_LoadPageIndicators:
	hlcoord 1, 14
	ld a, $36 ; first of 4 small square tiles
	call .load_square
	hlcoord 3, 14
	ld a, $36 ; " " " "
	call .load_square
	hlcoord 5, 14
	ld a, $36 ; " " " "
	call .load_square
	ld a, b
	cp GREEN_PAGE
	ld a, $3a ; first of 4 large square tiles
	hlcoord 1, 14 ; PINK_PAGE (< GREEN_PAGE)
	jr c, .load_square
	hlcoord 3, 14 ; GREEN_PAGE (= GREEN_PAGE)
	jr z, .load_square
	hlcoord 5, 14 ; BLUE_PAGE (> GREEN_PAGE)
.load_square
	ld [hli], a
	inc a
	ld [hld], a
	push bc
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	ret

GetNicknamePointer:
	ld a, [wMonType]
	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMonType]
	cp TEMPMON
	ret z
	ld a, [wCurPartyMon]
	jp SkipNames
