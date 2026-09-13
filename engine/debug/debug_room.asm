Functionfc000:
	ld hl, wStringBuffer2
	ld a, [wCurDay]
	ld [hli], a
	ldh a, [hHours]
	ld [hli], a
	ldh a, [hMinutes]
	ld [hli], a
	ldh a, [hSeconds]
	ld [hli], a
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call .asm_fc01f
	pop af
	ld [wOptions], a
	ret

.asm_fc01f:
	ld hl, .text_fc058
	call PrintText
	call .asm_fc03f
	call WaitBGMap

.asm_fc02b
	call .asm_fc064
	push af
	call .asm_fc03f
	call WaitBGMap
	pop af
	jr nc, .asm_fc02b

	cp $1
	ret z
	call InitTime
	ret

.asm_fc03f:
	hlcoord 1, 14
	ld de, wStringBuffer2 + 1
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	hlcoord 1, 16
	ld de, wStringBuffer2 + 2
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ret

.text_fc058:
	text "　　　じ"
	line "　　　ふん"
	done

.asm_fc064:
	call JoyTextDelay_ForcehJoyDown
	ld a, c
	bit B_PAD_UP, a
	jr nz, .up
	bit B_PAD_DOWN, a
	jr nz, .down
	bit B_PAD_LEFT, a
	jr nz, .left
	bit B_PAD_RIGHT, a
	jr nz, .right
	bit B_PAD_A, a
	jr nz, .a
	bit B_PAD_B, a
	jr nz, .b
	jr .done

.b
	ld a, 1
	scf
	ret

.a
	ld a, 2
	scf
	ret

.up
	ld hl, wStringBuffer2 + 1
	inc [hl]
	ld a, [hl]
	cp 24
	jr c, .done
	ld [hl], 0
	jr .done

.down
	ld hl, wStringBuffer2 + 1
	dec [hl]
	ld a, [hl]
	cp -1
	jr nz, .done
	ld [hl], 23
	jr .done

.right
	ld hl, wStringBuffer2 + 2
	inc [hl]
	ld a, [hl]
	cp 60
	jr c, .done
	ld [hl], 0
	jr .done

.left
	ld hl, wStringBuffer2 + 2
	dec [hl]
	ld a, [hl]
	cp -1
	jr nz, .done
	ld [hl], 59

.done
	xor a
	ret

_Debug_RTC:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	xor a
	ld [wd0c5], a
	ld [wd0c6], a
	call .asm_fc0da
	call .asm_fc0f5
	pop af
	ld [wOptions], a
	call ClearTilemap
	ret

.asm_fc0da:
	call GetClock
	ldh a, [hRTCDayLo]
	ld [wd0c8], a
	ldh a, [hRTCHours]
	ld [wd0c9], a
	ldh a, [hRTCMinutes]
	ld [wd0ca], a
	ldh a, [hRTCSeconds]
	ld [wd0cb], a
	call .asm_fc242
	ret

.asm_fc0f5:
	call .asm_fc106
	push af
	call GetClock
	call .asm_fc171
	call .asm_fc1c8
	pop af
	jr nc, .asm_fc0f5
	ret

.asm_fc106:
	call JoyTextDelay_ForcehJoyDown
	ld a, c
	bit B_PAD_UP, a
	jr nz, .up
	bit B_PAD_DOWN, a
	jr nz, .down
	bit B_PAD_LEFT, a
	jr nz, .left
	bit B_PAD_RIGHT, a
	jr nz, .right
	bit B_PAD_A, a
	jr nz, .a
	bit B_PAD_B, a
	jr nz, .b
	bit B_PAD_SELECT, a
	jr nz, .select
	xor a
	ret

.up
	ld hl, wd0c5
	ld a, [hl]
	and a
	jr z, .asm_fc132
	dec [hl]
	xor a
	ret

.asm_fc132
	ld [hl], $04
	xor a
	ret

.down
	ld hl, wd0c5
	ld a, [hl]
	cp $04
	jr z, .asm_fc141
	inc [hl]
	xor a
	ret

.asm_fc141
	ld [hl], $0
	xor a
	ret

.left
	call .asm_fc199
	dec [hl]
	xor a
	ret

.right
	call .asm_fc199
	inc [hl]
	xor a
	ret

.a
	call .asm_fc1a0
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	inc hl
	inc hl
	ld a, [hl]
	cp $ff
	jr z, .asm_fc167
	ld c, a
	ld a, [de]
	ld b, a
	call .asm_fc2b5
	xor a
	ret

.asm_fc167
	jp Reset


.b
	scf
	ret

.select
	call .asm_fc0da
	xor a
	ret

.asm_fc171:
	ld a, [wd0c5]
	ld c, a
	ld a, [wd0c6]
	cp c
	jr z, .asm_fc180
	call .asm_fc18f
	ld [hl], '　'
.asm_fc180
	ld a, [wd0c5]
	call .asm_fc18f
	ld [hl], '▶'
	ld a, [wd0c5]
	ld [wd0c6], a
	ret

.asm_fc18f:
	hlcoord 9, 8
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes
	ret

.asm_fc199:
	call .asm_fc1a0
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.asm_fc1a0:
	ld hl, .data_fc1af
	ld a, [wd0c5]
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	ret

.data_fc1af:
	dw wd0c8, hRTCDayLo
	db 11
	dw wd0c9, hRTCHours
	db 10
	dw wd0ca, hRTCMinutes
	db 9
	dw wd0cb, hRTCSeconds
	db 8
	dw wd0cc, wd0cc
	db -1

.asm_fc1c8:
	hlcoord 10, 3
	ldh a, [hRTCDayHi]
	call .asm_fc321
	hlcoord 10, 8
	ld de, wd0c8
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	hlcoord 15, 8
	ld de, hRTCDayLo
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	hlcoord 10, 10
	ld de, wd0c9
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	hlcoord 15, 10
	ld de, hRTCHours
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	hlcoord 10, 12
	ld de, wd0ca
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	hlcoord 15, 12
	ld de, hRTCMinutes
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	hlcoord 10, 14
	ld de, wd0cb
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	hlcoord 15, 14
	ld de, hRTCSeconds
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ret

.asm_fc321:
	push bc
	ld c, a
	ld b, 8
.asm_fc235
	sla c
	ld a, '０'
	jr nc, .asm_fc23c
	inc a ; '１'
.asm_fc23c
	ld [hli], a
	dec b
	jr nz, .asm_fc235
	pop bc
	ret

.asm_fc242:
	hlcoord 1, 3
	ld de, .text_fc282
	call PlaceString
	hlcoord 9, 6
	ld de, .text_fc28a
	call PlaceString
	hlcoord 1, 8
	ld de, .text_fc294
	call PlaceString
	hlcoord 1, 10
	ld de, .text_fc29b
	call PlaceString
	hlcoord 1, 12
	ld de, .text_fc2a1
	call PlaceString
	hlcoord 1, 14
	ld de, .text_fc2a8
	call PlaceString
	hlcoord 10, 16
	ld de, .text_fc2b0
	call PlaceString
	ret

.text_fc282:
	db "フラグレジスタ@"
.text_fc28a:
	db "せってい　じっさい@"
.text_fc294:
	db "にちカウンタ@"
.text_fc29b:
	db "じカウンタ@"
.text_fc2a1:
	db "ふんカウンタ@"
.text_fc2a8:
	db "びょうカウンタ@"
.text_fc2b0:
	db "リセット@"

.asm_fc2b5:
	ld a, RAMG_SRAM_ENABLE
	ld [rRAMG], a
	call LatchClock
	ld hl, rRAMB
	ld de, rRTCREG
	ld [hl], c
	ld a, b
	ld [de], a
	call CloseSRAM
	ret

; _DebugMenu.Jumptable indexes
	const_def
	const DEBUGMENU_FIGHT      ; 0
	const DEBUGMENU_LINK       ; 1
	const DEBUGMENU_FIELD      ; 2
	const DEBUGMENU_SOUNDTEST  ; 3
	const DEBUGMENU_POKEMONPAL ; 4
	const DEBUGMENU_TRAINERPAL ; 5
	const DEBUGMENU_OTHER      ; 6
	const DEBUGMENU_CLOCK      ; 7

_DebugMenu:
	call ClearTilemap
	call ClearWindowData
	call LoadStandardFont
	call LoadFontsBattleExtra
	call ClearSprites
	call GetMemSGBLayout
	call SetDefaultBGPAndOBP
	xor a
	ld [wWhichIndexSet], a
	ld hl, .MenuHeader
	call LoadMenuHeader
	call DoNthMenu
	call CloseWindow
	ret c
	call MenuJumptable
	jr _DebugMenu

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 5, 0, 13, 17
	dw .MenuData
	db 1 ; default option

.MenuData
	db STATICMENU_CURSOR | STATICMENU_WRAP ; flags
	db 0 ; items
	dw .items
	dw PlaceNthMenuStrings
	dw .Jumptable

.Jumptable
	dw Functionfc36b, .String_Fight
	dw Functionfc364, .String_Link
	dw Functionfc35d, .String_Field
	dw Functionfc37b, .String_Sound
	dw Functionfc382, .String_Mon
	dw Functionfc392, .String_Trainer
	dw Functionfc39e, .String_Other
	dw Functionfc39f, .String_Clock

.String_Fight:   db "ファイト@"
.String_Link:    db "つうしんよう@"
.String_Field:   db "フィールド@"
.String_Sound:   db "サウンド@"
.String_Mon:     db "モンスター@"
.String_Trainer: db "トレーナー@"
.String_Other:   db "そのた@"
.String_Clock:   db "とけいきのう@"

.items:
	db 8
	db DEBUGMENU_FIGHT
	db DEBUGMENU_LINK
	db DEBUGMENU_FIELD
	db DEBUGMENU_SOUNDTEST
	db DEBUGMENU_CLOCK
	db DEBUGMENU_POKEMONPAL
	db DEBUGMENU_TRAINERPAL
	db DEBUGMENU_OTHER
	db -1

Functionfc35d:
	farcall Function5c3e
	ret

Functionfc364:
	farcall Function5c5e
	ret

Functionfc36b:
	ld hl, wDebugFlags
	set DEBUG_BATTLE_F, [hl]
	predef FightDebugMenu
	ld hl, wDebugFlags
	res DEBUG_BATTLE_F, [hl]
	ret

Functionfc37b:
	farcall Functionfdc21
	ret

Functionfc382:
	xor a
	ld [wDebugColorIsTrainer], a
	farcall DebugColorPicker
	ld a, $e4
	call DmgToCgbBGPals
	ret

Functionfc392:
	ld a, 1
	ld [wDebugColorIsTrainer], a
	farcall DebugColorPicker
	ret

Functionfc39e:
	ret

Functionfc39f:
	farcall _Debug_RTC
	ret

Functionfc3a6:
	call Functionfc4f3
	ld a, HIGH(MAX_MONEY >> 8)
	ld [wMoney], a
	ld a, HIGH(MAX_MONEY) ; mid
	ld [wMoney + 1], a
	ld a, LOW(MAX_MONEY)
	ld [wMoney + 2], a
	xor a
	ld [wCoins], a
	ld a, 99
	ld [wCoins + 1], a
	call Functionfc488
	ld b, $14
	ld c, $05 ; useless
	ld c, $1e
	call Functionfc4a8
	call Functionfc430
	ld de, Data_fc453
	call Functionfc43d
	ld hl, wPokedexCaught
	call Functionfc425
	ld hl, wPokedexSeen
	call Functionfc425
	ld hl, wUnownDex
	ld [hl], $01
	ld hl, wFirstUnownSeen
	ld [hl], $7
	call Functionfc418
	call Functionfc523
	call Functionfc4e4
	farcall InitRoamMons
	call Functionfc4eb
	ld a, $0c
	ld [wStringBuffer2 + 1], a
	ld a, $22
	ld [wStringBuffer2 + 2], a
	call InitTimeOfDay
	call Random
	ld [wLuckyIDNumber], a
	call Random
	ld [wLuckyIDNumber + 1], a
	ret

Functionfc418:
	ld a, $01
	ld b, $0a
	ld hl, wPhoneList
.loop
	ld [hli], a
	inc a
	dec b
	jr nz, .loop
	ret

Functionfc425:
	ld b, $1f
	ld a, $ff
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ld [hl], $07
	ret

Functionfc430:
	nop
	ld b, $39
	ld a, $01
	ld hl, wTMsHMs
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

Functionfc43d:
	ld hl, wNumItems
.loop
	ld a, [de]
	cp -1
	ret z
	ld [wCurItem], a
	inc de
	ld a, [de]
	inc de
	ld [wItemQuantityChange], a
	call ReceiveItem
	jr .loop

Functionfc452:
	ret

Data_fc453:
	db BICYCLE,      1
	db OLD_ROD,      1
	db GOOD_ROD,     1
	db SUPER_ROD,    1
	db COIN_CASE,    1
	db ITEMFINDER,   1
	db FLOWER_MAIL,  6
	db SURF_MAIL,    6
	db LITEBLUEMAIL, 6
	db PORTRAITMAIL, 6
	db LOVELY_MAIL,  6
	db EON_MAIL,     6
	db MORPH_MAIL,   6
	db BLUESKY_MAIL, 6
	db MUSIC_MAIL,   6
	db MIRAGE_MAIL,  6
	db MASTER_BALL, 99
	db ULTRA_BALL,  99
	db POKE_BALL,   99
	db HEAVY_BALL,  99
	db LEVEL_BALL,  99
	db LURE_BALL,   99
	db FAST_BALL,   99
	db POTION,      30
	db RARE_CANDY,  20
	db FULL_HEAL,   99
	db -1

Functionfc488:
	call Random
	and %11
	jr z, Functionfc488
	dec a
	ld b, a
	add a
	add b
	add MEGANIUM
	ld b, 80
	call .AddToParty
	ret

.AddToParty:
	ld [wCurPartySpecies], a
	ld a, b
	ld [wCurPartyLevel], a
	predef TryAddMonToParty
	ret

Functionfc4a8:
	ld a, c
	and a
	ret z
	ld a, b
	ld [wCurPartyLevel], a
.loop
	push bc
	xor a
	ld [wEnemySubStatus5], a
	call .asm_fc4d5
	ld [wTempEnemyMonSpecies], a
	ld hl, wCurPartyLevel
	inc [hl]
	farcall LoadEnemyMon
	ld a, [wTempEnemyMonSpecies]
	ld [wCurPartySpecies], a
	farcall SendMonIntoBox
	pop bc
	dec c
	jr nz, .loop
	ret

.asm_fc4d5:
	call Random
	and a
	jr z, .asm_fc4d5
	cp $f6
	jr nc, .asm_fc4d5
	cp $c9
	jr z, .asm_fc4d5
	ret

Functionfc4e4:
	farcall SetAllDecorationFlags
	ret

Functionfc4eb:
	ld de, $1f
	ld b, $01
	jp EventFlagAction

Functionfc4f3:
	call Random
	cp $42
	jr nc, Functionfc4f3
	ld c, a
	ld b, 0
	ld hl, TrainerGroups
	add hl, bc
	add hl, bc
	ld a, BANK(TrainerGroups)
	call GetFarWord
	ld de, wPlayerName
	ld bc, NAME_LENGTH
	ld a, BANK(Trainers)
	call FarCopyBytes
	ld hl, .string_fc51f
	ld de, wRivalName
	ld bc, NAME_LENGTH
	call CopyBytes
	ret

.string_fc51f:
	db "レッド@"

Functionfc523:
	ld hl, wStatusFlags
	set STATUSFLAGS_POKEDEX_F, [hl]
	ld hl, wPokegearFlags
	set POKEGEAR_OBTAINED_F, [hl]
	ld hl, wPokegearFlags
	set POKEGEAR_RADIO_CARD_F, [hl]
	ld hl, wPokegearFlags
	set POKEGEAR_PHONE_CARD_F, [hl]
	ld hl, wPokegearFlags
	set POKEGEAR_MAP_CARD_F, [hl]
	ret

	db 0 ; unused

; FieldDebugMenuHeader.Jumptable constants
	const_def
	const FIELDDEBUG_CLOSE_MENU               ; 0
	const FIELDDEBUG_GO_TO_NEXT_PAGE          ; 1
	const FIELDDEBUG_MINIGAMES                ; 2
	const FIELDDEBUG_DUMMY_SPRITE_VIEWER      ; 3   (unused)
	const FIELDDEBUG_TOOLGEAR                 ; 4
	const FIELDDEBUG_TEST1_CATCH_TUTORIAL     ; 5
	const FIELDDEBUG_TEST2_HOF_CREDITS        ; 6
	const FIELDDEBUG_TEST3_RADIO_TOWER_ROCKET ; 7
	const FIELDDEBUG_TEST4_FILL_PC_ITEMS      ; 8
	const FIELDDEBUG_HEAL_POKEMON             ; 9
	const FIELDDEBUG_WARP                     ; $a
	const FIELDDEBUG_PC_MENU                  ; $b
	const FIELDDEBUG_CHANGE_MON_OTID          ; $c
	const FIELDDEBUG_POKEMON_MAKER            ; $d
	const FIELDDEBUG_RTC                      ; $e
	const FIELDDEBUG_ELEVATOR                 ; $f  (unused)
	const FIELDDEBUG_LOG                      ; $10 (unused)
	const FIELDDEBUG_ITEM_DISPENSER           ; $11
	const FIELDDEBUG_BUG_CONTEST_TIMER        ; $12 (unused)
	const FIELDDEBUG_DAYCARE_BREEDING         ; $13
	const FIELDDEBUG_EGG_HATCH                ; $14

FieldDebugMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 7, 17
	dw .MenuData
	db 1 ; default option

.MenuData
	db STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP | STATICMENU_CURSOR ; flags
	db 0 ; items
	dw .Pages
	dw PlaceNthMenuStrings
	dw .Jumptable

.Jumptable
	dw FieldDebugMenu.close,       .String_Close
	dw FieldDebugMenu.goToNext,    .String_Next
	dw FieldDebug_Minigames,       .String_Game
	dw FieldDebug_SpriteViewer,    .String_Character
	dw FieldDebug_Toolgear,        .String_Toolgear
	dw FieldDebug_Test1,           .String_Test1
	dw FieldDebug_Test2,           .String_Test2
	dw FieldDebug_Test3,           .String_Test3
	dw FieldDebug_Test4,           .String_Test4
	dw FieldDebug_HealPokemon,     .String_Heal
	dw FieldDebug_Warp,            .String_Warp
	dw FieldDebug_PCMenu,          .String_PC
	dw FieldDebug_MonOTID,         .String_Test
	dw FieldDebug_PokemonMaker,    .String_Maker
	dw FieldDebug_RTC,             .String_Timer
	dw FieldDebug_Elevator,        .String_Floor
	dw FieldDebug_Log,             .String_Log
	dw FieldDebug_ItemDispenser,   .String_Item
	dw FieldDebug_BugContestTimer, .String_Contest
	dw FieldDebug_DaycareBreeding, .String_Breed
	dw FieldDebug_EggHatch,        .String_Hatch

.String_Close:     db "とじる@"
.String_Game:      db "ゲーム@"
.String_Warp:      db "ワープ@"
.String_Test1:     db "テスト１@"
.String_Test2:     db "テスト２@"
.String_Test3:     db "テスト３@"
.String_Test4:     db "テスト４@"
.String_Heal:      db "かいふく@"
.String_Next:      db "つぎ▶@"
.String_PC:        db "パソコン@"
.String_Character: db "キャラ@"
.String_Toolgear:  db "ツールギア@"
.String_Test:      db "じっけん@"
.String_Maker:     db "つくる@"
.String_Floor:     db "フロア@"
	db "たまご@" ; unreferenced
.String_Log:       db "きろく@"
.String_Timer:     db "タイマー@"
.String_Item:      db "どうぐ@"
.String_Contest:   db "むしとり@"
.String_Breed:     db "こづくり@"
.String_Hatch:     db "うまれる@"

.Pages:
	; page 0
	db 7
	db FIELDDEBUG_GO_TO_NEXT_PAGE
	db FIELDDEBUG_WARP
	db FIELDDEBUG_DAYCARE_BREEDING
	db FIELDDEBUG_POKEMON_MAKER
	db FIELDDEBUG_TOOLGEAR
	db FIELDDEBUG_PC_MENU
	db FIELDDEBUG_CLOSE_MENU
	db -1 ; end

	; page 1
	db 7
	db FIELDDEBUG_GO_TO_NEXT_PAGE
	db FIELDDEBUG_ITEM_DISPENSER
	db FIELDDEBUG_HEAL_POKEMON
	db FIELDDEBUG_CHANGE_MON_OTID
	db FIELDDEBUG_MINIGAMES
	db FIELDDEBUG_RTC
	db FIELDDEBUG_CLOSE_MENU
	db -1 ; end

	; page 2
	db 7
	db FIELDDEBUG_GO_TO_NEXT_PAGE
	db FIELDDEBUG_TEST1_CATCH_TUTORIAL
	db FIELDDEBUG_TEST2_HOF_CREDITS
	db FIELDDEBUG_TEST3_RADIO_TOWER_ROCKET
	db FIELDDEBUG_TEST4_FILL_PC_ITEMS
	db FIELDDEBUG_EGG_HATCH
	db FIELDDEBUG_CLOSE_MENU
	db -1 ; end

; FieldDebugMenu.ReturnJumptable constants
	const_def
	const FIELDDEBUG_RETURN_REOPEN      ; 0
	const FIELDDEBUG_RETURN_QUIT        ; 1
	const FIELDDEBUG_RETURN_CLOSE       ; 2
	const FIELDDEBUG_RETURN_EXIT        ; 3
	const FIELDDEBUG_RETURN_SCRIPT_EXIT ; 4

FieldDebugMenu::
	call ReanchorMap
	ld de, SFX_MENU
	call PlaySFX
	ld hl, FieldDebugMenuHeader
	call LoadMenuHeader
	ld a, 0
	ld [wWhichIndexSet], a
.Reopen
	call UpdateTimePals
	call UpdateSprites
	ld a, [wcfbf]
	ld [wMenuCursorPosition], a
	call DoNthMenu
	jr c, .Quit
	ld a, [wMenuCursorPosition]
	ld [wcfbf], a
	call PlaceHollowCursor
	ld a, [wMenuJoypad]
	cp PAD_A
	jr z, .a_button
	call .left_right
	jr .asm_fc665

.a_button:
	ld a, [wMenuSelection]
	ld hl, FieldDebugMenuHeader.Jumptable
	call MenuJumptable

.asm_fc665:
	ld hl, .ReturnJumptable
	rst JumpTable
	ret

.ReturnJumptable:
	dw .Reopen
	dw .Quit
	dw .CloseText
	dw .Exit
	dw .ScriptExit

.Quit:
	call CloseWindow
.CloseText:
	push af
	call CloseText
	pop af
	ret

.Exit:
	call ExitMenu
	ld a, HMENURETURN_SCRIPT
	ldh [hMenuReturn], a
	jr .CloseText

.ScriptExit:
	call ExitMenu
	ld hl, wQueuedScriptAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wQueuedScriptBank]
	rst FarCall
	ld a, HMENURETURN_SCRIPT
	ldh [hMenuReturn], a
	jr .CloseText

.close:
	ld a, FIELDDEBUG_RETURN_QUIT
	ret

.left_right:
	ld a, [wMenuJoypad]
	cp PAD_LEFT
	jr z, .left_button
	ld a, [wWhichIndexSet]
	inc a
	cp 3
	jr nz, .next_page
	xor a
.next_page
	ld [wWhichIndexSet], a
	jr .page_done

.left_button
	ld a, [wWhichIndexSet]
	dec a
	cp -1
	jr nz, .prev_page
	ld a, 2
.prev_page
	ld [wWhichIndexSet], a
	jr .page_done

.goToNext:
; the "つぎ▶" entry only toggles between pages 0 and 1
	ld a, [wWhichIndexSet]
	and a
	jr z, .set_page_1
	xor a
	jr .store_page

.set_page_1
	ld a, 1
.store_page
	ld [wWhichIndexSet], a
.page_done
	ld de, SFX_MENU
	call PlaySFX
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

Functionfc6d7:
	call MenuTextbox
	ld a, PAD_A | PAD_B
	call .getJoypad
	call CloseWindow
	ret

.getJoypad:
	push bc
	ld b, a
.loop
	call GetJoypad
	ldh a, [hJoyPressed]
	and b
	jr z, .loop
	pop bc
	ret

Functionfc6ef:
	ld hl, .text_fc6f6
	call MenuTextboxBackup
	ret

.text_fc6f6:
	text "げんざい　このきのうは"
	line "つかうことが　できません"
	prompt

FieldDebug_ItemDispenser:
	call LoadStandardMenuHeader
	call .asm_fc721
.asm_fc716
	call .asm_fc72a
	jr nc, .asm_fc716
	call ExitMenu
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.asm_fc721:
	ld a, $1
	ld [wd0c5], a
	ld [wd0c6], a
	ret

.asm_fc72a:
	call Functionfc7e7
	call WaitBGMap
	call Functionfc78f
	ret c
	jr z, .asm_fc72a
IF DEF(_REV0)
	ld a, [wd0c5]
	and a
	ret z
ENDC
	call .asm_fc740
	and a
	ret

.asm_fc740:
	ld hl, wNumItems
	ld a, [wd0c5]
	ld [wCurItem], a
	ld a, [wd0c6]
	ld [wItemQuantityChange], a
	call ReceiveItem
	jr c, .asm_fc75b
	ld hl, .text_fc768
	call MenuTextboxWaitButton
	ret

.asm_fc75b:
	ld de, SFX_FULL_HEAL
	call PlaySFX
	ld hl, .text_fc77d
	call MenuTextboxWaitButton
	ret

.text_fc768:
	text "どうぐを　リュックに"
	line "いれられません！"
	done

.text_fc77d:
	text_ram wStringBuffer1
	text "を　"
	line "リュックにいれました"
	done

Functionfc78f:
	call JoyTextDelay_ForcehJoyDown
	ld a, c
	bit B_PAD_UP, a
	jr nz, .up
	bit B_PAD_DOWN, a
	jr nz, .down
	bit B_PAD_LEFT, a
	jr nz, .left
	bit B_PAD_RIGHT, a
	jr nz, .right
	bit B_PAD_B, a
	jr nz, .b
	bit B_PAD_A, a
	jr nz, .a
	jr Functionfc78f

.up
	ld hl, wd0c5
IF DEF(_REV0)
	ld a, [hl]
	cp $fb
	jr z, .asm_fc7b8
ENDC
	inc [hl]
	xor a
	ret

IF DEF(_REV0)
.asm_fc7b8
	ld [hl], 1
	xor a
	ret
ENDC

.down
	ld hl, wd0c5
IF DEF(_REV0)
	ld a, [hl]
	cp 1
	jr z, .asm_fc7c7
ENDC
	dec [hl]
	xor a
	ret

IF DEF(_REV0)
.asm_fc7c7
	ld [hl], $fb
	xor a
	ret
ENDC

.left
	ld hl, wd0c6
	dec [hl]
	jr nz, .asm_fc7d3
	ld [hl], $63
.asm_fc7d3
	xor a
	ret

.right
	ld hl, wd0c6
	inc [hl]
	cp $64
	jr c, .asm_fc7df
	ld [hl], 1
.asm_fc7df
	xor a
	ret

.b
	scf
	ret

.a
	ld a, 1
	and a
	ret

Functionfc7e7:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
	ld a, [wd0c5]
	ld [wNamedObjectIndex], a
	call GetItemName
	ld hl, .text_fc80b
	call PrintText
	pop af
	ldh [hBGMapMode], a
	pop af
	ld [wOptions], a
	ret

.text_fc80b:
	text "ばんごう@"
	text_decimal wd0c5, 1, 3
	text_start
	line "@"
	text_ram wStringBuffer1
	text "　　×@"
	text_decimal wd0c6, 1, 2
	text_end

FieldDebug_BugContestTimer:
	ld hl, .text_fc85e
	call MenuTextbox
.asm_fc82b
	call UpdateTime
	farcall CheckBugContestTimer
	hlcoord 5, 16
	ld de, wBugContestMinsRemaining
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	hlcoord 8, 16
	ld de, wBugContestSecsRemaining
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	call WaitBGMap
	call GetJoypad
	ldh a, [hJoyPressed]
	and PAD_A | PAD_B
	jr z, .asm_fc82b
	call ExitMenu
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.text_fc85e:
	text "たいかい　のこりじかん"
	done

FieldDebug_SpriteViewer:
; this was a sprite viewer screen in SW97 Debug. It's been dummied out in this version.
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_Toolgear:
	call Functionfc8dc
	jr c, .asm_fc888
	ld a, [wMenuCursorY]
	dec a
	ld hl, .Jumptable
	rst JumpTable
	ret

.Jumptable:
	dw .asm_fc8bc
	dw .asm_fc8cd
	dw .asm_fc899
	dw .asm_fc88b
	dw .asm_fc892
	dw .asm_fc8c7

.asm_fc888:
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.asm_fc88b:
	ld hl, wd55c
	set 7, [hl]
	jr .asm_fc89f

.asm_fc892:
	ld hl, wd55c
	res 7, [hl]
	jr .asm_fc89f

.asm_fc899:
	farcall Functionfc000
.asm_fc89f
	farcall FadeOutToWhite
	farcall UpdateTimeOfDayPal
	ld b, SCGB_MAPPALS
	call GetSGBLayout
	farcall FadeInFromWhite
	call UpdateTimePals
	ld a, FIELDDEBUG_RETURN_QUIT
	ret

.asm_fc8bc:
	call Function1e7c
	ld hl, wd55c
	res 0, [hl]
	ld a, FIELDDEBUG_RETURN_QUIT
	ret

.asm_fc8c7:
	call Function1e82
	ld a, FIELDDEBUG_RETURN_QUIT
	ret

.asm_fc8cd:
	call .asm_fc8d3
	ld a, FIELDDEBUG_RETURN_QUIT
	ret

.asm_fc8d3:
	call Function1e7c
	ld hl, wd55c
	set 0, [hl]
	ret

Functionfc8dc:
	ld hl, .menu_fc4902
	call LoadMenuHeader
	call .asm_fc8ef
	ld [wMenuCursorPosition], a
	call VerticalMenu
	call CloseWindow
	ret

.asm_fc8ef:
	ld a, [wUnusedReanchorBGMapFlags]
	bit 0, a
	ld a, $3
	ret nz
	ld hl, wd55c
	bit 0, [hl]
	ld a, $1
	ret nz
	ld a, $2
	ret

.menu_fc4902:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 7, 14
	dw .MenuData
	db 1 ; default option

.MenuData
	db STATICMENU_CURSOR ; flags
	db 6 ; items
	db "とけい@"
	db "ざひょう@"
	db "アジャスト@"
	db "６０びょう@"
	db "２４じかん@"
	db "けす@"

FieldDebug_HealPokemon:
	predef HealParty
	ld hl, .text_fc938
	call MenuTextboxBackup
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.text_fc938:
	text "#の　たいりょくを"
	line "かいふくしました"
	prompt

FieldDebug_Warp:
	xor a
	ldh [hMapAnims], a
	call LoadStandardMenuHeader
	call ClearSprites
	ld a, 0
	ld [wCurPartyMon], a
	farcall EntireFlyMap
	ld a, e
	ld [wMenuSelection], a
	call CloseSubmenu
	ld a, [wMenuSelection]
	cp $ff
	jr z, .cancel
	ld a, [wMenuSelection]
	cp $ff
	jr z, .cancel
	cp $1c
	jr nc, .cancel
	ld [wDefaultSpawnpoint], a
	ld hl, wStateFlags
	set 6, [hl]
	ldh a, [hROMBank]
	ld hl, Function_fca53
	call FarQueueScript
	ld de, SFX_ELEVATOR_END
	call PlaySFX
	call DelayFrame
	ld a, FIELDDEBUG_RETURN_SCRIPT_EXIT
	ret

.cancel
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

Menu_fc998: ; unreferenced
	db MENU_BACKUP_TILES ; flags
	menu_coords 1, 1, 11, 10
	dw .MenuData
	db 1 ; default option

.MenuData
	db 0 ; flags
	db 4, 0 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL ; item format
	dba .data_fca3b
	dba .asm_fc9b0
	dba NULL
	dba NULL

.asm_fc9b0:
	push de
	ld a, [wMenuSelection]
	call .asm_fc9bc
	pop hl
	call PlaceString
	ret

.asm_fc9bc:
	ld hl, .data_fc9c5
	call GetNthString
	ld d, h
	ld e, l
	ret

.data_fc9c5:
	db "じぶんのうち@"
	db "マサラ@"
	db "トキワ@"
	db "ニビ@"
	db "ハナダ@"
	db "イワヤマトンネルまえ@"
	db "クチバ@"
	db "シオン@"
	db "ヤマブキ@"
	db "タマムシ@"
	db "セキチク@"
	db "グレン@"
	db "ワカバ@"
	db "ヨシノ@"
	db "キキョウ@"
	db "ヒワダ@"
	db "タンバ@"
	db "コガネ@"
	db "アサギ@"
	db "エンジュ@"
	db "チョウジ@"
	db "イカリの　みずうみ@"
	db "フスベ@"
	db "シロガネ@"

.data_fca3b:
	db 14
	db 15
	db 16
	db 18
	db 19
	db 20
	db 21
	db 22
	db 23
	db 24
	db 25
	db 26
	db 02
	db 03
	db 04
	db 05
	db 06
	db 07
	db 08
	db 09
	db 10
	db 11
	db 12
	db -1

Function_fca53:
	call .asm_fca5f
	ldh a, [hROMBank]
	ld hl, .WarpScript
	call FarQueueScript
	ret

.asm_fca5f:
	ld hl, .text_fca66
	call Functionfc6d7
	ret

.text_fca66:
	text "ワープします！"
	done

.WarpScript:
	applymovement PLAYER, .TeleportFrom
	newloadmap MAPSETUP_TELEPORT
	applymovement PLAYER, .TeleportTo
	end

.TeleportFrom:
	teleport_from
	step_end

.TeleportTo:
	teleport_to
	step_end

FieldDebug_MonOTID:
	call LoadStandardMenuHeader
	call .asm_fca8d
	call CloseWindow
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.asm_fca8a: ; unreferenced
	ld a, 0
	ret

.asm_fca8d:
	ld hl, wStringBuffer2
	ld bc, $5
	xor a
	call ByteFill
	ld a, $4
	ld [wStringBuffer2 + 5], a
	ld hl, .text_fcaca
	call PrintText
.asm_fcaa2
	call .asm_fcae2
.asm_fcaa5
	call JoyTextDelay
	ldh a, [hJoyLast]
	ld b, a
	and $1
	jr nz, .asm_fcabe
	ld a, b
	and $f0
	jr z, .asm_fcaa5
	call .asm_fcb0a
	ld c, 3
	call DelayFrames
	jr .asm_fcaa2

.asm_fcabe:
	call .asm_fcb5a
	ld a, h
	ld [wPartyMon1ID], a
	ld a, l
	ld [wPartyMon1ID + 1], a
	ret

.text_fcaca:
	text "へんこうするナンバーを"
	line "してい　してください"
	done

.asm_fcae2:
	hlcoord 14, 15
	ld de, wStringBuffer2
	ld c, $5
.asm_fcaea
	ld a, [de]
	add $f6
	ld [hli], a
	inc de
	dec c
	jr nz, .asm_fcaea
	hlcoord 14, 16
	ld bc, $5
	ld a, '　'
	call ByteFill
	hlcoord 14, 16
	ld a, [wStringBuffer2 + 5]
	ld e, a
	ld d, 0
	add hl, de
	ld [hl], $61
	ret

.asm_fcb0a:
	ld a, b
	and $20
	jr nz, .asm_fcb1f
	ld a, b
	and $10
	jr nz, .asm_fcb29
	ld a, b
	and $40
	jr nz, .asm_fcb34
	ld a, b
	and $80
	jr nz, .asm_fcb42
	ret

.asm_fcb1f:
	ld a, [wStringBuffer2 + 5]
	and a
	ret z
	dec a
	ld [wStringBuffer2 + 5], a
	ret

.asm_fcb29:
	ld a, [wStringBuffer2 + 5]
	cp $4
	ret z
	inc a
	ld [wStringBuffer2 + 5], a
	ret

.asm_fcb34:
	call .asm_fcb4f
	ld a, [hl]
	cp $9
	jr z, .asm_fcb3f
	inc a
	ld [hl], a
	ret

.asm_fcb3f:
	ld [hl], 0
	ret

.asm_fcb42:
	call .asm_fcb4f
	ld a, [hl]
	and a
	jr z, .asm_fcb4c
	dec a
	ld [hl], a
	ret

.asm_fcb4c
	ld [hl], $9
	ret

.asm_fcb4f:
	ld a, [wStringBuffer2 + 5]
	ld e, a
	ld d, 0
	ld hl, wStringBuffer2
	add hl, de
	ret

.asm_fcb5a:
	ld hl, 0
	ld de, wStringBuffer2 + 4
	ld bc, 1
	call .asm_fcb7b
	ld bc, 10
	call .asm_fcb7b
	ld bc, 100
	call .asm_fcb7b
	ld bc, 1000
	call .asm_fcb7b
	ld bc, 10000

.asm_fcb7b:
	ld a, [de]
	dec de
	push hl
	ld hl, 0
	call AddNTimes
	ld c, l
	ld b, h
	pop hl
	add hl, bc
	ret

FieldDebug_PokemonMaker:
	call LoadStandardMenuHeader
	farcall _FieldDebug_PokemonMaker
	call CloseWindow
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_PCMenu:
	farcall PokemonCenterPC
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_Elevator:
	call .asm_fcba7
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.asm_fcba7:
	ld b, BANK(.data_fcbb3)
	ld de, .data_fcbb3
	farcall Elevator
	ret

.data_fcbb3:
	db 6
	elevfloor FLOOR_6F, 2, CELADON_DEPT_STORE_6F
	elevfloor FLOOR_5F, 3, CELADON_DEPT_STORE_5F
	elevfloor FLOOR_4F, 3, CELADON_DEPT_STORE_4F
	elevfloor FLOOR_3F, 3, CELADON_DEPT_STORE_3F
	elevfloor FLOOR_2F, 3, CELADON_DEPT_STORE_2F
	elevfloor FLOOR_1F, 4, CELADON_DEPT_STORE_1F
	db -1

FieldDebug_Minigames:
	call .asm_fcbd3
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.asm_fcbd3:
	ld hl, .MenuHeader
	call LoadMenuHeader
	call VerticalMenu
	push af
	call .asm_fcbff
	pop af
	call CloseWindow
	ret c
	ld hl, .text_fcc4e
	call MenuTextbox
	call YesNoBox
	call CloseWindow
	ret c
	call FadeToMenu
	ld hl, wQueuedScriptBank
	call CallPointerAt
	call CloseSubmenu
	ret

.asm_fcbff:
	ld a, [wMenuCursorY]
	dec a
	call CopyNameFromMenu
	ld a, [wMenuCursorY]
	dec a
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld [wQueuedScriptBank], a
	ld a, [hli]
	ld [wQueuedScriptAddr], a
	ld a, [hl]
	ld [wQueuedScriptAddr + 1], a
	ret

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 10, 10
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 3 ; items
	db "スロットマシン@"
	db "ポーカーゲーム@"
	db "ペアゲーム@"

	db "ピクロス@" ; unreferenced

.Jumptable:
	dba _SlotMachine
	dba _CardFlip
	dba _MemoryGame

.text_fcc4e:
	text_ram wStringBuffer2
	text "で　"
	line "あそびますか？"
	done

FieldDebug_RTC:
	call FadeToMenu
	farcall BlankScreen
	farcall _Debug_RTC
	call CloseSubmenu
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_Log:
	ld hl, .text_fcc92
	call MenuTextbox
	ld a, BANK(sRTCStatusFlags)
	call OpenSRAM
	ld a, [sRTCStatusFlags]
	call CloseSRAM
	hlcoord 2, 16
	call .asm_fccb8
	call PromptButton
	call CloseWindow
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.text_fcc92:
	text "やせいの#とたたかった"
	line "かいすう　@"
	text_decimal wd91d, 2, 5
	text "かい"

	para "タイマーのステータス"
	done

.asm_fccb8:
	push bc
	ld c, a
	ld b, $8
.asm_fccbc
	sla c
	ld a, $f6
	jr nc, .asm_fccc3
	inc a
.asm_fccc3
	ld [hli], a
	dec b
	jr nz, .asm_fccbc
	pop bc
	ret

FieldDebug_DaycareBreeding:
	ld a, [wDayCareMan]
	bit DAYCAREMAN_HAS_MON_F, a
	jr z, .asm_fccfb
	ld a, [wDayCareLady]
	bit DAYCARELADY_HAS_MON_F, a
	jr z, .asm_fccfb
	farcall CheckBreedmonCompatibility
	ld a, [wBreedingCompatibility]
	and a
	jr z, .asm_fcd1a
	cp $ff
	jr z, .asm_fcd1a
	ld hl, .text_fcd2e
	call MenuTextbox
	call YesNoBox
	call ExitMenu
	jr c, .asm_fccf8
	call .asm_fcd49

.asm_fccf8
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.asm_fccfb
	ld hl, .text_fcd04
	call MenuTextboxBackup
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.text_fcd04:
	text "２たい　いないので"
	line "こづくり　できません"
	prompt

.asm_fcd1a:
	ld hl, .text_fcd23
	call MenuTextboxBackup
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.text_fcd23:
	text "こづくりできません"
	prompt

.text_fcd2e:
	text "あいしょう　@"
	text_decimal wTextDecimalByte, 1, 3
	text "です"
	line "こづくり　しますか？"
	done

.asm_fcd49:
	ld hl, wDayCareMan
	res DAYCAREMAN_MONS_COMPATIBLE_F, [hl]
	set DAYCAREMAN_HAS_EGG_F, [hl]
	ret

FieldDebug_EggHatch:
	call .asm_fcd79
	jr c, .asm_fcd5f
	ld hl, .text_fcd68
	call MenuTextboxBackup
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.asm_fcd5f
	ld hl, .text_fcd72
	call MenuTextboxBackup
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.text_fcd68:
	text "タマゴが　ない！"
	prompt

.text_fcd72:
	text "うまれる！"
	prompt

.asm_fcd79:
	ld hl, wPartySpecies
	ld c, 0
.asm_fcd7e
	ld a, [hli]
	cp -1
	jr z, .asm_fcd9d
	cp EGG
	jr z, .asm_fcd8a
	inc c
	jr .asm_fcd7e

.asm_fcd8a
	ld a, c
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Happiness
	call AddNTimes
	ld [hl], $01
	ld a, '　'
	ld [wStepCount], a
	scf
	ret

.asm_fcd9d
	xor a
	ret

FieldDebug_Test1:
	ld a, 1
	ld de, Script_Test1
	jr FieldDebug_ScriptTestCommon

FieldDebug_Test2:
	ld a, 2
	ld de, Script_Test2
	jr FieldDebug_ScriptTestCommon

FieldDebug_Test3:
	ld a, 3
	ld de, Script_Test3
	jr FieldDebug_ScriptTestCommon

FieldDebug_Test4:
	ld a, 4
	ld de, Script_Test4
	jr FieldDebug_ScriptTestCommon ; useless

FieldDebug_ScriptTestCommon:
	ld [wStringBuffer2], a
	push de
	ld hl, .text_fcddb
	call MenuTextbox
	call YesNoBox
	call CloseWindow
	pop de
	jr c, .asm_fcdd8
	ld h, d
	ld l, e
	ld a, BANK(Script_Tests)
	call FarQueueScript
	ld a, FIELDDEBUG_RETURN_EXIT
	ret

.asm_fcdd8
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.text_fcddb:
	text "イベント@"
	text_decimal wStringBuffer2, 1, 2
	text "を　テストしますか？"
	done

Script_Tests: ; used by FieldDebug_ScriptTestCommon
Script_Test1:
	sjump Script_CatchTutorial

Script_Test2:
	sjump Script_HOFCredits

Script_Test3:
	sjump Script_RadioTowerTakeover

Script_Test4:
	sjump Script_GivePCItems

Script_MinigameMenu: ; unreferenced
	opentext
	loadmenu .MenuHeader
.loop
	writetext .text_fce3d
	verticalmenu
	ifequal $00, .done
	scall .script_fce12
	sjump .loop

.done
	closewindow
	closetext
	end

.script_fce12
	ifequal $01, .UnownPuzzle
	ifequal $02, .SlotMachine
	ifequal $03, .CardFlip
	ifequal $04, .MemoryGame
	ifequal $05, .script_fce37
	end

.UnownPuzzle
	special UnownPuzzle
	end

.SlotMachine
	special SlotMachine
	end

.CardFlip
	special CardFlip
	end

.MemoryGame
	special UnusedMemoryGame
	end

.script_fce37
	special ClearBGPalettesBufferScreen
	reloadmap
	reanchormap $90
; bug: the 'end' command is wasted by 'reanchormap' unused argument
; this will fail to stop and continue to execute script commands

.text_fce3d:
	text "どれで　あそぶ？"
	done

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 10, 12
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 5 ; items
	db "１５パズル@"
	db "スロットマシン@"
	db "ポーカーゲーム@"
	db "ペアゲーム@"
	db "ピクロス@"

Script_CatchTutorial:
	loadwildmon RATTATA, 5
	catchtutorial BATTLETYPE_TUTORIAL
	end

Script_HOF: ; unreferenced
	halloffame
	loadmem wSpawnAfterChampion, SPAWN_LANCE
	end

Script_ProfOaksPC: ; unreferenced
	opentext
	special ProfOaksPCBoot
	closetext
	end

Script_GiveEgg: ; unreferenced
	giveegg ABRA, 20
	end

Script_GiveMail: ; unreferenced
	opentext
	writetext .text_fce91
	verbosegiveitem FLOWER_MAIL, 99
	closetext
	end

.text_fce91
	text "これを　あげよう"
	prompt

Script_Swarm: ; unreferenced
	swarm DARK_CAVE_VIOLET_ENTRANCE
	end

Script_HOFCredits:
	warpfacing UP, HALL_OF_FAME, 4, 3
	playmusic MUSIC_NONE
	reanchormap
	setval HEALMACHINE_HALL_OF_FAME
	special HealMachineAnim
	closetext
	halloffame
	end

Script_RadioTowerTakeover:
	callstd RadioTowerRocketsScript
	callstd GoldenrodRocketsScript
	end

Script_fceb9: ; unreferenced
	warpfacing UP, TEAM_ROCKET_BASE_B1F, 4, 14
	end

Script_GivePCItems:
	callasm .GiveItems
	end

.GiveItems:
	ld hl, wNumPCItems
	ld [hl], 50
	inc hl
	ld a, MASTER_BALL
	ld c, 50
.loop
	ld [hli], a
	ld [hl], 99
	inc hl
	inc a
	dec c
	jr nz, .loop
	ld [hl], -1
	ret

FightDebugMenu:
	ld a, $01
	ldh [hInMenu], a
	ld a, 1 << RISINGBADGE
	ld [wJohtoBadges], a
	ld hl, wNumKeyItems
	xor a
	ld [hli], a
	dec a
	ld [hl], a
	xor a
	ld hl, wNumBalls
	ld [hli], a
	dec a
	ld [hl], a
	ld hl, wNumItems
	xor a
	ld [hli], a
	dec a
	ld [hld], a
	ld de, .data_fcfb7
.loop
	ld a, [de]
	cp -1
	jr z, .asm_fcf10
	inc de
	ld [wCurItem], a
	ld a, [de]
	inc de
	ld [wItemQuantityChange], a
	push de
	call ReceiveItem
	pop de
	jr .loop
.asm_fcf10
	callfar StatsScreen_LoadFont
	call ClearTilemap
	call ClearSprites
	hlcoord 0, 0
	ld b, 1
	ld c, 18
	call Textbox
	hlcoord 6, 1
	ld de, Text_fd6f2
	call PlaceString
	hlcoord 4, 4
	ld de, Text_fd6fb
	call PlaceString
	hlcoord 1, 6
	ld de, Text_fd70a
	call PlaceString
	xor a
	ld [wCurPartyMon], a
	ld [wEnemyMonSpecies], a
	ld [wEnemyMonLevel], a
	ld [wTrainerClass], a
	ld [wdcb3], a
	ld b, a
	ld c, a
	ld hl, wOTPartySpecies
	call .asm_fcfae
	ld hl, wPartyCount
	call .asm_fcfae
	ld de, wPartySpecies
	hlcoord 4, 6
.asm_fcf65
	push hl
	push bc
	dec hl
	ld a, '▶'
	ld [hl], a
	ld bc, $b
	add hl, bc
	ld a, '　'
	ld [hl], a
	push de
	pop de
	pop bc
	pop hl
.asm_fcf76
	push bc
	push de
	call DelayFrame
	call JoyTextDelay
	pop de
	pop bc
	ldh a, [hJoyLast]
	bit B_PAD_A, a
	jp nz, .asm_fcff6
	bit B_PAD_B, a
	jp nz, .asm_fd035
	bit B_PAD_START, a
	jp nz, .asm_fd167
	bit B_PAD_RIGHT, a
	jp nz, .asm_fd086
	bit B_PAD_UP, a
	jp nz, .asm_fd042
	bit B_PAD_DOWN, a
	jp nz, .asm_fd065
	bit B_PAD_SELECT, a
	jr z, .asm_fcf76
	ld hl, wDebugFlags
	res DEBUG_BATTLE_F, [hl]
	predef_jump DebugMenu

.asm_fcfae:
	xor a
rept 6
	ld [hli], a
endr
	ld [hl], a
	ret

.data_fcfb7:
	db MASTER_BALL,  99
	db ULTRA_BALL,   99
	db GREAT_BALL,   99
	db POKE_BALL,    99
	db HEAVY_BALL,   99
	db LEVEL_BALL,   99
	db LURE_BALL,    99
	db FAST_BALL,    99
	db FRIEND_BALL,  99
	db MOON_BALL,    99
	db LOVE_BALL,    99
	db FULL_RESTORE, 99
	db REVIVE,       99
	db MAX_REVIVE,   99
	db X_ATTACK,     99
	db X_DEFEND,     99
	db X_SPEED,      99
	db X_SPECIAL,    99
	db ETHER,        99
	db MAX_ETHER,    99
	db ELIXER,       99
	db GUARD_SPEC,   99
	db POKE_DOLL,    99
	db X_ACCURACY,   99
	db FULL_HEAL,    99
	db SUPER_POTION, 99
	db ANTIDOTE,     99
	db BURN_HEAL,    99
	db ICE_HEAL,     99
	db AWAKENING,    99
	db PARLYZ_HEAL,  99
	db -1

.asm_fcff6:
	inc b
	ld a, b
	cp $fe
	jr c, .asm_fcffe
	xor a
	ld b, a
.asm_fcffe
	ld [de], a
	ld [wNamedObjectIndex], a
	push bc
	push hl
	push de
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	inc hl
	push hl
	ld de, Text_fd776
	call PlaceString
	ld bc, $ffec
	add hl, bc
	ld de, Text_fd776
	call PlaceString
	pop hl
	ld a, [wNamedObjectIndex]
	and a
	jr nz, .asm_fd029
	ld de, Text_fd77c
	jr .asm_fd02c
.asm_fd029
	call GetPokemonName
.asm_fd02c
	call PlaceString
	pop de
	pop hl
	pop bc
	jp .asm_fcf76

.asm_fd035:
	dec b
	ld a, b
	cp $fe
	jp c, .asm_fcffe
	ld a, $fd
	ld b, a
	jp .asm_fcffe

.asm_fd042:
	ld a, [wCurPartyMon]
	dec a
	cp -1
	jp z, .asm_fcf76
	ld [wCurPartyMon], a
	dec de
	dec hl
	ld a, '　'
	ld [hl], a
	push bc
	ld bc, -SCREEN_WIDTH * 2
	add hl, bc
	pop bc
	ld a, '▶'
	ld [hl], a
	inc hl
	push hl
	call .asm_fd14c
	pop hl
	jp .asm_fcf76

.asm_fd065:
	ld a, [wCurPartyMon]
	inc a
	cp PARTY_LENGTH
	jp nc, .asm_fcf76
	ld [wCurPartyMon], a
	inc de
	dec hl
	ld a, '　'
	ld [hl], a
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	ld a, '▶'
	ld [hl], a
	inc hl
	push hl
	call .asm_fd14c
	pop hl
	jp .asm_fcf76

.asm_fd086:
	push hl
	push bc
	dec hl
	ld a, '　'
	ld [hl], a
	ld bc, $0b
	add hl, bc
	ld a, '▶'
	ld [hl], a
	pop bc
	pop hl
.asm_fd095
	push bc
	push de
	call DelayFrame
	call JoyTextDelay
	pop de
	pop bc

	ldh a, [hJoyLast]
	bit B_PAD_A, a
	jp nz, .asm_fd0c1
	bit B_PAD_B, a
	jp nz, .asm_fd0ea
	bit B_PAD_START, a
	jp nz, .asm_fd167
	bit B_PAD_LEFT, a
	jp nz, .asm_fcf65
	bit B_PAD_UP, a
	jp nz, .asm_fd0fa
	bit B_PAD_DOWN, a
	jp nz, .asm_fd123
	jr .asm_fd095

.asm_fd0c1:
	inc c
	ld a, c
	cp $65
	jr c, .asm_fd0ca
	ld a, $1
	ld c, a
.asm_fd0ca
	ld a, [wCurPartyMon]
	push de
	ld de, wOTPartySpecies
	add e
	ld e, a
	jr nc, .asm_fd0d6
	inc d
.asm_fd0d6
	ld a, c
	ld [de], a
	push bc
	push hl
	ld bc, $b
	add hl, bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	pop hl
	pop bc
	pop de
	jp .asm_fd095

.asm_fd0ea:
	dec c
	ld a, c
	cp $65
	jr nc, .asm_fd0f4
	and a
	jp nz, .asm_fd0ca
.asm_fd0f4
	ld a, $64
	ld c, a
	jp .asm_fd0ca

.asm_fd0fa:
	ld a, [wCurPartyMon]
	dec a
	cp $ff
	jp z, .asm_fd095
	ld [wCurPartyMon], a
	dec de
	push hl
	ld bc, $a
	add hl, bc
	ld a, '　'
	ld [hl], a
	pop hl
	ld bc, -SCREEN_WIDTH * 2
	add hl, bc
	push hl
	ld bc, $a
	add hl, bc
	ld a, '▶'
	ld [hl], a
	call .asm_fd14c
	pop hl
	jp .asm_fd095


.asm_fd123:
	ld a, [wCurPartyMon]
	inc a
	cp PARTY_LENGTH
	jp nc, .asm_fd095
	ld [wCurPartyMon], a
	inc de
	push hl
	ld bc, $a
	add hl, bc
	ld a, '　'
	ld [hl], a
	pop hl
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	push hl
	ld bc, $a
	add hl, bc
	ld a, '▶'
	ld [hl], a
	call .asm_fd14c
	pop hl
	jp .asm_fd095

.asm_fd14c:
	ld hl, wPartySpecies
	ld a, [wCurPartyMon]
	add l
	ld l, a
	jr nc, .asm_fd157
	inc h
.asm_fd157
	ld a, [hl]
	ld b, a
	ld hl, wOTPartySpecies
	ld a, [wCurPartyMon]
	add l
	ld l, a
	jr nc, .asm_fd164
	inc h
.asm_fd164
	ld a, [hl]
	ld c, a
	ret

.asm_fd167:
	ld hl, wPartyCount
	ld de, wOTPartyCount
	xor a
	ld [hl], a
	inc hl
	ld a, [hli]
	ld b, a
	ld c, $6
	xor a
	ld [wBattleMode], a
.asm_fd178
	ld a, b
	ld [wCurPartySpecies], a
	ld a, [hl]
	ld b, a
	inc de
	ld a, [de]
	and a
	jr z, .asm_fd19b
	ld [wCurPartyLevel], a
	xor a
	ld [wMonType], a
	ld a, [wCurPartySpecies]
	and a
	jr z, .asm_fd19b
	push hl
	push de
	push bc
	predef TryAddMonToParty
	pop bc
	pop de
	pop hl
.asm_fd19b
	inc hl
	dec c
	jr nz, .asm_fd178
	ld b, $7
	ld hl, wPartySpecies
	ld de, wOTPartyCount
.asm_fd1a7
	inc de
	dec b
	jp z, FightDebugMenu
	ld a, [hli]
	and a
	jr z, .asm_fd1a7
	ld a, [de]
	and a
	jr z, .asm_fd1a7
	hlcoord 0, 3
	ld b, $f
	ld c, $14
	call ClearBox

; redundant
	hlcoord 0, 3
	ld b, $f
	ld c, $14
	call ClearBox
	hlcoord 0, 3
	ld b, $f
	ld c, $14
	call ClearBox

	ld c, $14
	call DelayFrames
	ld a, 1
	ld [wBattleMode], a
	ld de, Text_fd782
	ld a, [wdcb3]
	cp $65
	jr c, .asm_fd1ee
	ld a, $2
	ld [wBattleMode], a
	ld de, Text_fd78c
.asm_fd1ee
	hlcoord 1, 4
	call PlaceString
	hlcoord 1, 6
	ld de, Text_fd796
	call PlaceString
	hlcoord 0, 9
	ld b, $9
	ld c, $14
	call ClearBox
	ld a, [wEnemyMonSpecies]
	ld b, a
	ld a, [wBattleMode]
	dec a
	jr z, .asm_fd244
	ld a, [wTrainerClass]
	ld [wNamedObjectIndex], a
	ld b, a
	ld de, wNamedObjectIndex
	hlcoord 1, 8
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	hlcoord 5, 8
	ld de, Text_fd7bc
	call PlaceString
	ld a, [wTrainerClass]
	ld c, a
	callfar GetOTName
	hlcoord 5, 8
	ld de, wOTClassName
	call PlaceString
	pop bc
	jr .asm_fd269

.asm_fd244:
	ld a, b
	and a
	jr z, .asm_fd269
	ld de, wNamedObjectIndex
	ld [de], a
	hlcoord 1, 8
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	hlcoord 5, 8
	ld de, Text_fd7bc
	call PlaceString
	call GetPokemonName
	hlcoord 5, 8
	call PlaceString
	pop bc

.asm_fd269
	ld a, [wEnemyMonLevel]
	ld c, a
	ld de, wNamedObjectIndex
	ld [de], a
	hlcoord 16, 8
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	pop bc

.asm_fd27c
	ld a, '　'
	ldcoord_a 0, 8
	ldcoord_a 15, 8
	ld a, '▶'
	ldcoord_a 0, 4

.asm_fd289
	push bc
	call DelayFrame
	call JoyTextDelay
	pop bc
	ldh a, [hJoyLast]
	bit B_PAD_A, a
	jp nz, .asm_fd2a4
	bit B_PAD_START, a
	jp nz, .asm_fd5d7
	bit B_PAD_DOWN, a
	jp nz, .asm_fd2ff
	jr .asm_fd289

.asm_fd2a4:
	hlcoord 1, 8
	ld de, Text_fd7a9
	call PlaceString
	hlcoord 5, 7
	ld de, Text_fd7bc
	call PlaceString
	xor a
	ld b, a
	ld c, a
	ld a, [wBattleMode]
	dec a
	jr nz, .asm_fd2df
	ld a, $2
	ld [wBattleMode], a
	ld a, '　'
	ldcoord_a 4, 3
	hlcoord 1, 4
	ld de, Text_fd78c
	call PlaceString
	hlcoord 0, 9
	ld b, $9
	ld c, $14
	call ClearBox
	jp .asm_fd289


.asm_fd2df
	ld a, $1
	ld [wBattleMode], a
	ld a, '　'
	ldcoord_a 1, 3
	hlcoord 1, 4
	ld de, Text_fd782
	call PlaceString
	hlcoord 0, 9
	ld b, $9
	ld c, $14
	call ClearBox
	jp .asm_fd289

.asm_fd2ff
	ld a, '▶'
	ldcoord_a 0, 8
	ld a, '　'
	ldcoord_a 15, 8
	ldcoord_a 0, 4

.asm_fd30c
	push bc
	call DelayFrame
	call JoyTextDelay
	pop bc
	ldh a, [hJoyLast]
	bit B_PAD_A, a
	jp nz, .asm_fd336
	bit B_PAD_B, a
	jp nz, .asm_fd3ac
	bit B_PAD_START, a
	jp nz, .asm_fd5d7
	bit B_PAD_RIGHT, a
	jp nz, .asm_fd3e4
	bit B_PAD_UP, a
	jp nz, .asm_fd27c
	bit B_PAD_DOWN, a
	jp nz, .asm_fd4c5
	jr .asm_fd30c

.asm_fd336
	push bc
	hlcoord 5, 7
	ld de, Text_fd7bc
	call PlaceString
	hlcoord 5, 8
	ld de, Text_fd7bc
	call PlaceString
	pop bc
	ld a, [wBattleMode]
	dec a
	jr z, .asm_fd383
	inc b
	ld a, b
	cp $43
	jr c, .asm_fd358
	ld b, $1
.asm_fd358
	ld a, b
	ld [wNamedObjectIndex], a
	ld de, wNamedObjectIndex
	hlcoord 1, 8
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ld a, [wNamedObjectIndex]
	ld [wTrainerClass], a
	ld c, a
	callfar GetOTName
	hlcoord 5, 8
	ld de, wOTClassName
	call PlaceString
	pop bc
	jp .asm_fd30c

.asm_fd383
	inc b
	ld a, b
	cp $fe
	jr c, .asm_fd38b
	ld b, $1
.asm_fd38b
	ld a, b
	ld [wNamedObjectIndex], a
	ld de, wNamedObjectIndex
	hlcoord 1, 8
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	call GetPokemonName
	hlcoord 5, 8
	call PlaceString
	pop bc
	call .asm_fd445
	jp .asm_fd30c

.asm_fd3ac
	push bc
	hlcoord 5, 7
	ld de, Text_fd7bc
	call PlaceString
	hlcoord 5, 8
	ld de, Text_fd7bc
	call PlaceString
	pop bc
	ld a, [wBattleMode]
	dec a
	jr z, .asm_fd3d5
	dec b
	ld a, b
	cp $43
	jr nc, .asm_fd3d0
	and a
	jp nz, .asm_fd358
.asm_fd3d0
	ld b, $3d
	jp .asm_fd358

.asm_fd3d5
	dec b
	ld a, b
	cp $fe
	jr nc, .asm_fd3df
	and a
	jp nz, .asm_fd38b
.asm_fd3df
	ld b, $fd
	jp .asm_fd38b

.asm_fd3e4
	ld a, '　'
	ldcoord_a 0, 8
	ld a, '▶'
	ldcoord_a 15, 8
.asm_fd3ee
	push bc
	call DelayFrame
	call JoyTextDelay
	pop bc
	ldh a, [hJoyLast]
	bit B_PAD_A, a
	jp nz, .asm_fd418
	bit B_PAD_B, a
	jp nz, .asm_fd436
	bit B_PAD_START, a
	jp nz, .asm_fd5d7
	bit B_PAD_LEFT, a
	jp nz, .asm_fd2ff
	bit B_PAD_UP, a
	jp nz, .asm_fd27c
	bit B_PAD_DOWN, a
	jp nz, .asm_fd4c5
	jr .asm_fd3ee

.asm_fd418
	inc c
	ld a, c
	cp $65
	jr c, .asm_fd420
	ld c, $1
.asm_fd420
	hlcoord 16, 8
	ld a, c
	ld de, wCurPartyLevel
	ld [de], a
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	pop bc
	call .asm_fd445
	jp .asm_fd3ee

.asm_fd436
	dec c
	ld a, c
	cp $65
	jr nc, .asm_fd440
	and a
	jp nz, .asm_fd420
.asm_fd440
	ld c, $64
	jp .asm_fd420

.asm_fd445:
	ld a, [wBattleMode]
	dec a
	ret nz
	push bc
	ld a, b
	ld [wCurPartySpecies], a
	hlcoord 0, 9
	ld b, $9
	ld c, $14
	call ClearBox
	xor a
	ld [wd0c5], a
	ld hl, wListMoves_MoveIndicesBuffer
	ld bc, $4
	call ByteFill
	ld de, wListMoves_MoveIndicesBuffer
	predef FillMoves
	ld a, SCREEN_WIDTH * 2
	ld [wListMovesLineSpacing], a
	hlcoord 5, 10
	predef ListMoves
	call .asm_fd5c6
	hlcoord 1, 10
	ld de, wListMoves_MoveIndicesBuffer
	ld b, $4
.asm_fd486
	ld a, [de]
	and a
	jr z, .asm_fd4c3
	push bc
	push hl
	push de
	push hl
	ld de, wStringBuffer1
	ld [de], a
	lb bc, 1, 3
	push af
	call PrintNum
	pop af
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld de, wStringBuffer1
	ld [de], a
	pop hl
	ld bc, $f
	add hl, bc
	lb bc, 1, 3
	call PrintNum
	pop de
	pop hl
	inc de
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	pop bc
	dec b
	jr nz, .asm_fd486
.asm_fd4c3
	pop bc
	ret

.asm_fd4c5
	hlcoord 0, 8
	ld [hl], '　'
	hlcoord 15, 8
	ld [hl], '　'
	ld a, [wBattleMode]
	dec a
	jp nz, .asm_fd2ff
	push bc
	hlcoord 0, 10
	ld [hl], '▶'
	ld de, wListMoves_MoveIndicesBuffer
	ld b, $1
.asm_fd4e1
	call DelayFrame
	call JoyTextDelay
	ldh a, [hJoyLast]
	bit B_PAD_A, a
	jp nz, .asm_fd504
	bit B_PAD_B, a
	jp nz, .asm_fd50c
	bit B_PAD_START, a
	jp nz, .asm_fd5c2
	bit B_PAD_UP, a
	jp nz, .asm_fd593
	bit B_PAD_DOWN, a
	jp nz, .asm_fd5a5
	jr .asm_fd4e1

.asm_fd504
	ld a, [de]
	inc a
	cp $fc
	jr c, .asm_fd535
	jr .asm_fd516

.asm_fd50c
	ld a, [de]
	and a
	ld a, $fb
	jr z, .asm_fd535
	ld a, [de]
	dec a
	jr nz, .asm_fd535

.asm_fd516
	xor a
	ld [de], a
	push de
	push bc
	push hl
	ld bc, $ffed
	add hl, bc
	lb bc, 2, 11
	call ClearBox
	pop hl
	push hl
	ld bc, $11
	add hl, bc
	ld a, '　'
	ld [hli], a
	ld [hl], a
	pop hl
	pop bc
	pop de
	jp .asm_fd4e1

.asm_fd535
	ld [de], a
	ld [wCurSpecies], a
	push hl
	push de
	push bc
	push hl
	push hl
	ld bc, $ffed
	add hl, bc
	lb bc, 2, 11
	call ClearBox
	pop hl
	push hl
	ld bc, $11
	add hl, bc
	ld a, '　'
	ld [hli], a
	ld [hl], a
	pop hl
	ld de, wCurSpecies
	lb bc, 1, 3
	inc hl
	call PrintNum
	ld a, MOVE_NAME
	ld [wNamedObjectType], a
	call GetName
	ld de, wStringBuffer1
	inc hl
	call PlaceString
	ld a, [wCurSpecies]
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld de, wStringBuffer1
	ld [de], a
	pop hl
	ld bc, $10
	add hl, bc
	lb bc, 1, 3
	call PrintNum
	pop bc
	pop de
	pop hl
	jp .asm_fd4e1

.asm_fd593
	ld [hl], '　'
	dec b
	jp z, .asm_fd5be
	dec de
	push bc
	ld bc, -SCREEN_WIDTH * 2
	add hl, bc
	pop bc
	ld [hl], '▶'
	jp .asm_fd4e1

.asm_fd5a5
	inc b
	ld a, b
	cp $5
	jr nc, .asm_fd5b9
	inc de
	ld [hl], '　'
	push bc
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	pop bc
	ld [hl], '▶'
	jp .asm_fd4e1

.asm_fd5b9
	ld b, $4
	jp .asm_fd4e1

.asm_fd5be
	pop bc
	jp .asm_fd2ff

.asm_fd5c2
	pop bc
	jp .asm_fd5d7

.asm_fd5c6:
	hlcoord 13, 10
	ld de, $27
	ld b, $4
	ld a, $3e
.asm_fd5d0
	ld [hli], a
	ld [hl], a
	add hl, de
	dec b
	jr nz, .asm_fd5d0
	ret

.asm_fd5d7
	ld a, b
	and a
	jp z, .asm_fd27c
	ld a, c
	and a
	jp z, .asm_fd27c
	ld a, [wBattleMode]
	dec a
	jr z, .asm_fd5f1
	ld a, b
	ld [wOtherTrainerClass], a
	ld a, c
	ld [wOtherTrainerID], a
	jr .asm_fd5f9

.asm_fd5f1
	ld a, c
	ld [wCurPartyLevel], a
	ld a, b
	ld [wTempWildMonSpecies], a
.asm_fd5f9
	call SetDefaultBGPAndOBP
	ld a, 1 << RISINGBADGE
	ld [wJohtoBadges], a
	ld hl, Text_fd7c7
	ld de, wPlayerName
	ld bc, NAME_LENGTH
	call CopyBytes
	predef StartBattle
	ld a, $1
	ldh [hBGMapMode], a
	ldh [hInMenu], a
	xor a
	ld [wNumFleeAttempts], a
	ld hl, wPlayerSubStatus1
	ld bc, wEnemySubStatus1 - wPlayerSubStatus1
	call ByteFill
	ld hl, wEnemySubStatus1
	ld bc, wPlayerRolloutCount - wEnemySubStatus1
	call ByteFill
	call LoadStandardFont
	callfar StatsScreen_LoadFont
	call ClearTilemap
	call ClearSprites
	ld a, $e4
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	call DmgToCgbObjPals
	hlcoord 0, 0
	ld b, $1
	ld c, $12
	call Textbox
	hlcoord 6, 1
	ld de, Text_fd6f2
	call PlaceString
	hlcoord 4, 4
	ld de, Text_fd6fb
	call PlaceString
	hlcoord 1, 6
	ld de, Text_fd70a
	call PlaceString
	ld de, wPartyCount
	xor a
	ld [de], a
	ld [wCurPartyMon], a
	inc de
	hlcoord 4, 6
	push de
	push hl
.asm_fd67b
	ld a, [wCurPartyMon]
	ld de, wPartySpecies
	add e
	ld e, a
	jr nc, .asm_fd686
	inc d
.asm_fd686
	ld a, [de]
	cp $ff
	jp z, .asm_fd6e1
	ld [wNamedObjectIndex], a
	push hl
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	inc hl
	ld de, Text_fd776
	call PlaceString
	call GetPokemonName
	call PlaceString
	pop hl
	push hl
	ld bc, $b
	add hl, bc
	push hl
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld a, [de]
	ld [wCurPartyLevel], a
	pop hl
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ld a, [wCurPartyMon]
	ld de, wOTPartySpecies
	add e
	ld e, a
	jr nc, .asm_fd6ce
	inc d
.asm_fd6ce
	ld a, [wCurPartyLevel]
	ld [de], a
	pop hl
	ld a, [wCurPartyMon]
	inc a
	ld [wCurPartyMon], a
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	jp .asm_fd67b

.asm_fd6e1
	pop hl
	pop de
	ld a, [wPartyMon1Species]
	ld b, a
	ld a, [wPartyMon1Level]
	ld c, a
	xor a
	ld [wCurPartyMon], a
	jp .asm_fcf65

Text_fd6f2:
	db "テスト　ファイト@"
Text_fd6fb:
	db "№．　　なまえ　　　　レベル@"
Text_fd70a:
	db   "１．▶０００　ーーーーー　　０００"
	next "２．　０００　ーーーーー　　０００"
	next "３．　０００　ーーーーー　　０００"
	next "４．　０００　ーーーーー　　０００"
	next "５．　０００　ーーーーー　　０００"
	next "６．　０００　ーーーーー　　０００@"
Text_fd776:
	db "　　　　　@"
Text_fd77c:
	db "ーーーーー@"
Text_fd782:
	db "ワイルドモンスター@"
Text_fd78c:
	db "ディーラー　　　　@"
Text_fd796:
	db   "№．　　なまえ　　　　　　　　レベル"
	next ""
Text_fd7a9:
	db   "０００　ーーーーーーーーーー　０００@"
Text_fd7bc:
	db "　　　　　　　　　　@"
Text_fd7c7:
	db "ゴールド@@"

Data_fd7cd: ; unreferenced
	db BRIGHTPOWDER, 99
	db GREAT_BALL,   99
	db ICE_HEAL,     99
	db HYPER_POTION, 99
	db SUPER_POTION, 99
	db POTION,       99
	db ESCAPE_ROPE,  99
	db REPEL,        99
	db -1

_FieldDebug_PokemonMaker:
	ld a, BANK(sBox)
	call OpenSRAM
	ld a, [sBoxCount]
	cp MONS_PER_BOX
	call CloseSRAM
	jp nc, .asm_fdb49
	call ClearTilemap
	call UpdateSprites
	ld a, [wOptions]
	push af
	set NO_TEXT_SCROLL, a
	ld [wOptions], a
	xor a
	ld hl, wddee
	ld [hli], a
	ld [hli], a
	ld [hl], a
	inc a
	ldh [hInMenu], a
	ld [wCurItem], a
	ld a, [wCurPartySpecies]
	cp $fc
	jr c, .asm_fd816
	ld a, $1
	ld [wCurPartySpecies], a
.asm_fd816
	ld a, [wCurPartyLevel]
	dec a
	cp $64
	jr c, .asm_fd823
	ld a, $1
	ld [wCurPartyLevel], a
.asm_fd823
	hlcoord 0, 3
	ld [hl], '　'
	hlcoord 0, 1
	ld [hl], '▶'
	call .asm_fd860
.asm_fd830
	call DelayFrame
	call JoyTextDelay
	ldh a, [hJoyLast]
	bit B_PAD_A, a
	jp nz, .asm_fd849
	bit B_PAD_B, a
	jp nz, .asm_fd856
	bit B_PAD_DOWN, a
	jp nz, .asm_fd88f
	jr .asm_fd830

.asm_fd849
	ld hl, wCurPartySpecies
	inc [hl]
	ld a, [hl]
	cp $fc
	jr c, .asm_fd823
	ld [hl], $1
	jr .asm_fd823

.asm_fd856
	ld hl, wCurPartySpecies
	dec [hl]
	jr nz, .asm_fd823
	ld [hl], $fb
	jr .asm_fd823

.asm_fd860:
	hlcoord 1, 0
	ld b, $2
	ld c, $9
	call ClearBox
	hlcoord 1, 1
	ld de, wCurPartySpecies
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	inc hl
	push hl
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	pop hl
	call PlaceString
	ld a, [wNamedObjectIndex]
	ld [wCurSpecies], a
	call GetBaseData
	ret

.asm_fd88f
	hlcoord 0, 1
	ld [hl], '　'
	hlcoord 0, 3
	ld [hl], '▶'
	hlcoord 0, 5
	ld [hl], '　'
	call .asm_fd8db
	call .asm_fd8e8
.asm_fd8a4
	call DelayFrame
	call JoyTextDelay
	ld hl, wCurPartyLevel
	ldh a, [hJoyLast]
	bit B_PAD_A, a
	jp nz, .asm_fd8ca
	bit B_PAD_B, a
	jp nz, .asm_fd8d4
	bit B_PAD_START, a
	jp nz, .asm_fdadc
	bit B_PAD_UP, a
	jp nz, .asm_fd823
	bit B_PAD_DOWN, a
	jp nz, .asm_fd936
	jr .asm_fd8a4

.asm_fd8ca
	inc [hl]
	ld a, [hl]
	cp $65
	jr c, .asm_fd88f
	ld [hl], $1
	jr .asm_fd88f

.asm_fd8d4
	dec [hl]
	jr nz, .asm_fd88f
	ld [hl], $64
	jr .asm_fd88f

.asm_fd8db:
	hlcoord 1, 3
	ld de, wCurPartyLevel
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ret

.asm_fd8e8:
	hlcoord 1, 4
	ld b, $8
	ld c, $b
	call ClearBox
	ld hl, wListMoves_MoveIndicesBuffer
	ld bc, $4
	xor a
	call ByteFill
	xor a
	ld [wd0c5], a
	ld de, wListMoves_MoveIndicesBuffer
	predef FillMoves
	hlcoord 1, 5
	ld de, wListMoves_MoveIndicesBuffer
	ld b, $4
.asm_fd910
	ld a, [de]
	inc de
	and a
	jr z, .asm_fd935
	push de
	push bc
	push hl
	ld [wNamedObjectIndex], a
	ld de, wNamedObjectIndex
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	inc hl
	call GetMoveName
	call PlaceString
	pop hl
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	pop bc
	pop de
	dec b
	jr nz, .asm_fd910
.asm_fd935
	ret

.asm_fd936
	ld de, wListMoves_MoveIndicesBuffer
	hlcoord 0, 5
	ld b, $1
.asm_fd93e
	call .asm_fd99b
.asm_fd941
	call DelayFrame
	push de
	push bc
	call JoyTextDelay
	pop bc
	pop de
	ldh a, [hJoyLast]
	bit B_PAD_A, a
	jp nz, .asm_fd968
	bit B_PAD_B, a
	jp nz, .asm_fd974
	bit B_PAD_START, a
	jp nz, .asm_fdadc
	bit B_PAD_UP, a
	jp nz, .asm_fd97e
	bit B_PAD_DOWN, a
	jp nz, .asm_fd98b
	jr .asm_fd941

.asm_fd968
	ld a, [de]
	inc a
	ld [de], a
	cp $fc
	jr c, .asm_fd93e
	ld a, $1
	ld [de], a
	jr .asm_fd93e

.asm_fd974
	ld a, [de]
	dec a
	ld [de], a
	jr nz, .asm_fd93e
	ld a, $fb
	ld [de], a
	jr .asm_fd93e

.asm_fd97e
	dec de
	dec b
	jp z, .asm_fd88f
	push bc
	ld bc, -SCREEN_WIDTH * 2
	add hl, bc
	pop bc
	jr .asm_fd93e

.asm_fd98b
	inc de
	inc b
	ld a, b
	cp $5
	jp z, .asm_fd9e6
	push bc
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	pop bc
	jr .asm_fd93e

.asm_fd99b:
	push hl
	push de
	push bc
	push hl
	push de
	ld bc, $ffed
	add hl, bc
	lb bc, $2, $b
	call ClearBox
	pop de
	pop hl
	push hl
	ld [hl], '▶'
	ld bc, -SCREEN_WIDTH * 2
	add hl, bc
	ld [hl], '　'
	ld bc, SCREEN_WIDTH * 4
	add hl, bc
	ld [hl], '　'
	pop hl
	inc hl
	ld a, [de]
	ld de, wNamedObjectIndex
	ld [de], a
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	ld a, [wNamedObjectIndex]
	and a
	jr z, .asm_fd9d8
	call .asm_fd9dc
	inc hl
	call GetMoveName
	call PlaceString
.asm_fd9d8
	pop bc
	pop de
	pop hl
	ret

.asm_fd9dc:
	push hl
	call .asm_fdb5d
	pop hl
	jr c, .asm_fd9e5
	ld [hl], '×'
.asm_fd9e5
	ret

.asm_fd9e6
	ld de, wddee
	hlcoord 0, 13
	ld b, $1
.asm_fd9ee
	call .asm_fda49
.asm_fd9f1
	call DelayFrame
	push de
	push bc
	call JoyTextDelay
	pop bc
	pop de
	ldh a, [hJoyLast]
	bit B_PAD_A, a
	jp nz, .asm_fda18
	bit B_PAD_B, a
	jp nz, .asm_fda1d
	bit B_PAD_START, a
	jp nz, .asm_fdadc
	bit B_PAD_UP, a
	jp nz, .asm_fda22
	bit B_PAD_DOWN, a
	jp nz, .asm_fda3a
	jr .asm_fd9f1

.asm_fda18
	ld a, [de]
	inc a
	ld [de], a
	jr .asm_fd9ee

.asm_fda1d
	ld a, [de]
	dec a
	ld [de], a
	jr .asm_fd9ee

.asm_fda22
	dec de
	dec b
	jp z, .asm_fda2f
	push bc
	ld bc, -SCREEN_WIDTH * 2
	add hl, bc
	pop bc
	jr .asm_fd9ee

.asm_fda2f
	ld de, wListMoves_MoveIndicesBuffer + 3
	hlcoord 0, 11
	ld b, $4
	jp .asm_fd93e

.asm_fda3a
	ld a, b
	cp $3
	jr z, .asm_fd9ee
	inc b
	inc de
	push bc
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	pop bc
	jr .asm_fd9ee

.asm_fda49:
	push hl
	push de
	push bc
	push hl
	ld [hl], '▶'
	ld bc, -SCREEN_WIDTH * 2
	add hl, bc
	ld [hl], '　'
	ld bc, SCREEN_WIDTH * 4
	add hl, bc
	ld [hl], '　'
	pop hl
	inc hl
	ld a, [de]
	ld de, wNamedObjectIndex
	ld [de], a
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	call .asm_fda6f
	pop bc
	pop de
	pop hl
	ret

.asm_fda6f:
	hlcoord 12, 0
	ld b, $12
	ld c, $8
	call ClearBox
	hlcoord 13, 1
	ld de, .text_fdac1
	call PlaceString
	ld b, NUM_EXP_STATS * 2
	ld hl, wTempMonStatExp
	ld a, [wddf0]
.asm_fda8a
	ld [hli], a
	dec b
	jr nz, .asm_fda8a
	ld a, [wddee]
	ld [hli], a ; wTempMonDVs
	ld a, [wddee + 1]
	ld [hl], a
	ld hl, wTempMonStatExp - 1
	ld de, wTempMonMaxHP
	ld b, TRUE
	predef CalcMonStats
	hlcoord 17, 1
	ld de, wTempMonMaxHP
	ld b, $6
.asm_fdaab
	push bc
	push de
	push hl
	lb bc, PRINTNUM_LEADINGZEROS | 2, 3
	call PrintNum
	pop hl
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	pop de
	inc de
	inc de
	pop bc
	dec b
	jr nz, .asm_fdaab
	ret

.text_fdac1:
	db   "たいりき"
	next "<KOUGEKI>"
	next "ぼうぎょ"
	next "すばやさ"
	next "とくこう"
	next "とくぼう@"

.asm_fdadc:
	ld a, [wCurPartyLevel]
	ld [wEnemyMonLevel], a
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wCurPartySpecies]
	ld [wEnemyMonSpecies], a
	ld hl, wEnemyMonHP
	ld a, [wTempMonMaxHP]
	ld [hli], a
	ld a, [wTempMonMaxHP + 1]
	ld [hli], a
	xor a
	ld [wEnemyMonStatus], a
	ld [wEnemyMonStatus + 1], a
	ld hl, wEnemyMonMoves
	ld a, [wListMoves_MoveIndicesBuffer]
	ld [hli], a
	ld a, [wListMoves_MoveIndicesBuffer + 1]
	ld [hli], a
	ld a, [wListMoves_MoveIndicesBuffer + 2]
	ld [hli], a
	ld a, [wListMoves_MoveIndicesBuffer + 3]
	ld [hl], a
	ld hl, wEnemyMonPP
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, [wddee]
	ld [wEnemyMonDVs], a
	ld a, [wddee + 1]
	ld [wEnemyMonDVs + 1], a
	predef SendMonIntoBox
	ld a, $1
	call OpenSRAM
	ld b, NUM_EXP_STATS * 2
	ld hl, sBoxMon1HPExp
	ld a, [wddf0]
.asm_fdb3c
	ld [hli], a
	dec b
	jr nz, .asm_fdb3c
	call CloseSRAM
	pop af
	ld [wOptions], a
	jr .asm_fdb4f
.asm_fdb49
	ld hl, .text_fdb50
	call PrintText
.asm_fdb4f
	ret

.text_fdb50:
	text "ボックスが　いっぱい！"
	done

.asm_fdb5d:
	ld a, [wCurPartySpecies]
	push af
	call .asm_fdb91
	jr c, .asm_fdb8b
	farcall GetPreEvolution
	jr nc, .asm_fdb80
	call .asm_fdb91
	jr c, .asm_fdb8b
	farcall GetPreEvolution
	jr nc, .asm_fdb80
	call .asm_fdb91
	jr c, .asm_fdb8b
.asm_fdb80
	call .asm_fdbe0
	jr c, .asm_fdb8b
	pop af
	ld [wCurPartySpecies], a
	and a
	ret

.asm_fdb8b
	pop af
	ld [wCurPartySpecies], a
	scf
	ret

.asm_fdb91:
	ld a, [wNamedObjectIndex]
	ld [wPutativeTMHMMove], a
	predef CanLearnTMHMMove
	ld a, c
	and a
	jr nz, .asm_fdbbd
	ld a, [wNamedObjectIndex]
	ld d, a
	call .asm_fdc06
.asm_fdba7
	ld a, $10
	call GetFarByte
	inc hl
	and a
	jr z, .asm_fdbbb
	ld a, $10
	call GetFarByte
	inc hl
	cp d
	jr z, .asm_fdbbd
	jr .asm_fdba7

.asm_fdbbb
	and a
	ret

.asm_fdbbd
	scf
	ret

.data_fdbbf: ; unreferenced
	db $07
	db $09
	db $0A
	db $0E
	db $10
	db $14
	db $16
	db $1C
	db $31
	db $42
	db $53
	db $59
	db $5B
	db $63
	db $64
	db $67
	db $68
	db $69
	db $72
	db $7D
	db $7E
	db $8B
	db $8E
	db $95
	db $98
	db $9A
	db $9B
	db $B2
	db $B3
	db $B4
	db $BB
	db $BE
	db -1

.asm_fdbe0:
	ld hl, EggMovePointers
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, BANK(EggMovePointers)
	call GetFarWord
.asm_fdbf1
	ld a, BANK(EggMovePointers)
	call GetFarByte
	inc hl
	cp -1
	jr z, .asm_fdc04
	ld b, a
	ld a, [wNamedObjectIndex]
	cp b
	jr nz, .asm_fdbf1
	scf
	ret

.asm_fdc04
	and a
	ret

.asm_fdc06:
	ld hl, EvosAttacksPointers
	ld b, 0
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	call GetFarWord
.asm_fdc17
	ld a, BANK(EvosAttacksPointers)
	call GetFarByte
	inc hl
	and a
	jr nz, .asm_fdc17
	ret

Functionfdc21:
	call ClearTilemap
	call ClearSprites
	ld de, MUSIC_NONE
	call PlayMusic
	ld a, $1
	ldh [hInMenu], a
	hlcoord 1, 6
	ld de, .text_fdd0f
	call PlaceString
	xor a
	ld [wcf21], a
	call .asm_fdcd4
	xor a
	ld [wcf24], a
	call .asm_fdd03
	call WaitBGMap
.asm_fdc4b
	call JoyTextDelay
	ldh a, [hJoyPressed]
	call .asm_fdc58
	call DelayFrame
	jr .asm_fdc4b

.asm_fdc58:
	bit B_PAD_B, a
	jr nz, .asm_fdca6
	bit B_PAD_START, a
	jr nz, .asm_fdcac
	ldh a, [hJoyLast]
	bit B_PAD_UP, a
	jr nz, .asm_fdc87
	bit B_PAD_DOWN, a
	jr nz, .asm_fdc96
	bit B_PAD_RIGHT, a
	jr nz, .asm_fdcb5
	bit B_PAD_LEFT, a
	jr nz, .asm_fdcc4
	bit B_PAD_A, a
	ret z
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld a, [wcf21]
	ld e, a
	ld d, 0
	jp PlayMusic

.asm_fdc87
	ld a, [wcf21]
	inc a
	cp NUM_MUSIC_SONGS
	jr nz, .asm_fdc90
	xor a
.asm_fdc90
	ld [wcf21], a
	jp .asm_fdcd4

.asm_fdc96
	ld a, [wcf21]
	dec a
	cp -1
	jr nz, .asm_fdca0
	ld a, MUSIC_POST_CREDITS
.asm_fdca0
	ld [wcf21], a
	jp .asm_fdcd4

.asm_fdca6
	ld de, MUSIC_NONE
	jp PlayMusic

.asm_fdcac
	ld a, [wcf24]
	ld e, a
	ld d, 0
	jp PlaySFX

.asm_fdcb5
	ld a, [wcf24]
	inc a
	cp NUM_SFX
	jr nz, .asm_fdcbe
	xor a
.asm_fdcbe
	ld [wcf24], a
	jp .asm_fdd03

.asm_fdcc4
	ld a, [wcf24]
	dec a
	cp -1
	jr nz, .asm_fdcce
	ld a, SFX_2_BOOPS
.asm_fdcce
	ld [wcf24], a
	jp .asm_fdd03

.asm_fdcd4:
	hlcoord 6, 5
	ld bc, 5
	ld a, '　'
	call ByteFill
	ld hl, .data_fdd2d
	ld a, [wcf21]
	ld e, a
	ld d, 0
rept 5
	add hl, de
endr
	ld de, wStringBuffer1
	push de
	ld bc, 5
	call CopyBytes
	pop de
	ld a, '@'
	ld [wStringBuffer1 + 5], a
	hlcoord 6, 6
	jp PlaceString

.asm_fdd03:
	hlcoord 6, 12
	ld de, wcf24
	lb bc, 1, 3
	jp PrintNum

.text_fdd0f:
	db   "おんがく"
	next "じょうげ　エー"
	next ""
	next "こうかおん"
	next "さゆう　　スタート@"

.data_fdd2d:
	db "ストップ　" ; MUSIC_NONE
	db "タイトル　" ; MUSIC_TITLE
	db "どうろ１　" ; MUSIC_ROUTE_1
	db "どうろ３　" ; MUSIC_ROUTE_3
	db "どうろ４　" ; MUSIC_ROUTE_12
	db "リニア　　" ; MUSIC_MAGNET_TRAIN
	db "バトル１　" ; MUSIC_KANTO_GYM_LEADER_BATTLE
	db "バトル３　" ; MUSIC_KANTO_TRAINER_BATTLE
	db "バトル４　" ; MUSIC_KANTO_WILD_BATTLE
	db "ポケセン　" ; MUSIC_POKEMON_CENTER
	db "しせん１　" ; MUSIC_HIKER_ENCOUNTER
	db "しせん２　" ; MUSIC_LASS_ENCOUNTER
	db "しせん３　" ; MUSIC_OFFICER_ENCOUNTER
	db "あさ　　　" ; MUSIC_HEAL
	db "シオン　　" ; MUSIC_LAVENDER_TOWN
	db "ちか２　　" ; MUSIC_ROUTE_2
	db "ちか３　　" ; MUSIC_MT_MOON
	db "つれてく２" ; MUSIC_SHOW_ME_AROUND
	db "カジノ　　" ; MUSIC_GAME_CORNER
	db "じてんしゃ" ; MUSIC_BICYCLE
	db "でんどう　" ; MUSIC_HALL_OF_FAME
	db "タウン１　" ; MUSIC_VIRIDIAN_CITY
	db "タウン３　" ; MUSIC_CELADON_CITY
	db "かち１　　" ; MUSIC_TRAINER_VICTORY
	db "かち２　　" ; MUSIC_WILD_VICTORY
	db "かち３　　" ; MUSIC_GYM_VICTORY
	db "かち４　　" ; MUSIC_MT_MOON_SQUARE
	db "ジム　　　" ; MUSIC_GYM
	db "マイホーム" ; MUSIC_PALLET_TOWN
	db "ラボ　　　" ; MUSIC_POKEMON_TALK
	db "オーキド　" ; MUSIC_PROF_OAK
	db "ライバル１" ; MUSIC_RIVAL_ENCOUNTER
	db "ライバル２" ; MUSIC_RIVAL_AFTER
	db "なみのり　" ; MUSIC_SURF
	db "しんか　　" ; MUSIC_EVOLUTION
	db "こうえん　" ; MUSIC_NATIONAL_PARK
	db "おしまい　" ; MUSIC_CREDITS
	db "キキョウ　" ; MUSIC_AZALEA_TOWN
	db "タウン１２" ; MUSIC_CHERRYGROVE_CITY
	db "まいこ　　" ; MUSIC_KIMONO_ENCOUNTER
	db "ちか１７　" ; MUSIC_UNION_CAVE
	db "バトル１１" ; MUSIC_JOHTO_WILD_BATTLE
	db "バトル１３" ; MUSIC_JOHTO_TRAINER_BATTLE
	db "どうろ１３" ; MUSIC_ROUTE_30
	db "ヒワダ　　" ; MUSIC_ECRUTEAK_CITY
	db "ヨシノ　　" ; MUSIC_VIOLET_CITY
	db "バトル１２" ; MUSIC_JOHTO_GYM_LEADER_BATTLE
	db "バトル１４" ; MUSIC_CHAMPION_BATTLE
	db "バトル１５" ; MUSIC_RIVAL_BATTLE
	db "バトル１６" ; MUSIC_ROCKET_BATTLE
	db "ラボ１１　" ; MUSIC_PROF_ELM
	db "ちか１１２" ; MUSIC_DARK_CAVE
	db "どうろ１５" ; MUSIC_ROUTE_29
	db "どうろ１８" ; MUSIC_ROUTE_36
	db "こうそく　" ; MUSIC_SS_AQUA
	db "しょうねん" ; MUSIC_YOUNGSTER_ENCOUNTER
	db "しょうじょ" ; MUSIC_BEAUTY_ENCOUNTER
	db "ロケット　" ; MUSIC_ROCKET_ENCOUNTER
	db "あやしい　" ; MUSIC_POKEMANIAC_ENCOUNTER
	db "ぼうさん　" ; MUSIC_SAGE_ENCOUNTER
	db "ワカバ　　" ; MUSIC_NEW_BARK_TOWN
	db "コガネ　　" ; MUSIC_GOLDENROD_CITY
	db "クチバ　　" ; MUSIC_VERMILION_CITY
	db "ラジオ　　" ; MUSIC_POKEMON_CHANNEL
	db "ふえ　　　" ; MUSIC_POKE_FLUTE_CHANNEL
	db "とう１１　" ; MUSIC_TIN_TOWER
	db "とう１１ー" ; MUSIC_SPROUT_TOWER
	db "とう１２　" ; MUSIC_BURNED_TOWER
	db "とう１４　" ; MUSIC_LIGHTHOUSE
	db "みち１１１" ; MUSIC_LAKE_OF_RAGE
	db "みち１１２" ; MUSIC_INDIGO_PLATEAU
	db "みち１１３" ; MUSIC_ROUTE_37
	db "ちか１２ー" ; MUSIC_ROCKET_HIDEOUT
	db "ちか１１３" ; MUSIC_DRAGONS_DEN
	db "バト１１２" ; MUSIC_JOHTO_WILD_BATTLE_NIGHT
	db "アンノーン" ; MUSIC_RUINS_OF_ALPH_RADIO
	db "かち２２　" ; MUSIC_CAPTURE
	db "ごうロード" ; MUSIC_ROUTE_26
	db "つれてく１" ; MUSIC_MOM
	db "とう１５　" ; MUSIC_VICTORY_ROAD
	db "こもり　　" ; MUSIC_POKEMON_LULLABY
	db "マーチ　　" ; MUSIC_POKEMON_MARCH
	db "タイトル１" ; MUSIC_GS_OPENING
	db "タイトル２" ; MUSIC_GS_OPENING_2
	db "スタート　" ; MUSIC_MAIN_MENU
	db "いせき　　" ; MUSIC_RUINS_OF_ALPH_INTERIOR
	db "せんきょ　" ; MUSIC_ROCKET_OVERTURE
	db "ぶよう　　" ; MUSIC_DANCING_HALL
	db "たいまい　" ; MUSIC_BUG_CATCHING_CONTEST_RANKING
	db "たいかい　" ; MUSIC_BUG_CATCHING_CONTEST
	db "かいでんぱ" ; MUSIC_LAKE_OF_RAGE_ROCKET_RADIO
	db "プリンタ　" ; MUSIC_PRINTER
	db "エンド２　" ; MUSIC_POST_CREDITS
