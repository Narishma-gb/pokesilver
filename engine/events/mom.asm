BankOfMom:
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	xor a
	ld [wJumptableIndex], a
.loop
	ld a, [wJumptableIndex]
	bit JUMPTABLE_EXIT_F, a
	jr nz, .done
	call .RunJumptable
	jr .loop

.done
	pop af
	ldh [hInMenu], a
	ret

.RunJumptable:
	jumptable .dw, wJumptableIndex

.dw
	dw .CheckIfBankInitialized
	dw .InitializeBank
	dw .IsThisAboutYourMoney
	dw .AccessBankOfMom
	dw .StoreMoney
	dw .TakeMoney
	dw .StopOrStartSavingMoney
	dw .JustDoWhatYouCan
	dw .Quit

.CheckIfBankInitialized:
	ld a, [wMomSavingMoney]
	bit MOM_ACTIVE_F, a
	jr nz, .savingmoneyalready
	set MOM_ACTIVE_F, a
	ld [wMomSavingMoney], a
	ld a, $1
	jr .done_0

.savingmoneyalready
	ld a, $2

.done_0
	ld [wJumptableIndex], a
	ret

.InitializeBank:
	ld hl, MomLeavingText1
	call PrintText
	call YesNoBox
	jr c, .DontSaveMoney
	ld hl, MomLeavingText2
	call PrintText
	ld a, (1 << MOM_ACTIVE_F) | (1 << MOM_SAVING_SOME_MONEY_F)
	jr .done_1

.DontSaveMoney:
	ld a, 1 << MOM_ACTIVE_F

.done_1
	ld [wMomSavingMoney], a
	ld hl, MomLeavingText3
	call PrintText
	ld a, $8
	ld [wJumptableIndex], a
	ret

.IsThisAboutYourMoney:
	ld hl, MomIsThisAboutYourMoneyText
	call PrintText
	call YesNoBox
	jr c, .nope
	ld a, $3
	jr .done_2

.nope
	ld a, $7

.done_2
	ld [wJumptableIndex], a
	ret

.AccessBankOfMom:
	ld hl, MomBankWhatDoYouWantToDoText
	call PrintText
	call LoadStandardMenuHeader
	ld hl, BankOfMom_MenuHeader
	call CopyMenuHeader
	call VerticalMenu
	call CloseWindow
	jr c, .cancel
	ld a, [wMenuCursorY]
	cp $1
	jr z, .withdraw
	cp $2
	jr z, .deposit
	cp $3
	jr z, .stopsaving

.cancel
	ld a, $7
	jr .done_3

.withdraw
	ld a, $5
	jr .done_3

.deposit
	ld a, $4
	jr .done_3

.stopsaving
	ld a, $6

.done_3
	ld [wJumptableIndex], a
	ret

.StoreMoney:
	ld hl, MomStoreMoneyText
	call PrintText
	xor a
	ld hl, wStringBuffer2
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, 5
	ld [wMomBankDigitCursorPosition], a
	call LoadStandardMenuHeader
	call Mom_SetUpDepositMenu
	call Mom_Wait10Frames
	call Mom_WithdrawDepositMenuJoypad
	call CloseWindow
	jr c, .CancelDeposit
	ld hl, wStringBuffer2
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	jr z, .CancelDeposit
	ld de, wMoney
	ld bc, wStringBuffer2
	farcall CompareMoney
	jr c, .InsufficientFundsInWallet
	ld hl, wStringBuffer2
	ld de, wStringBuffer2 + 3
	ld bc, 3
	call CopyBytes
	ld bc, wMomsMoney
	ld de, wStringBuffer2
	farcall GiveMoney
	jr c, .NotEnoughRoomInBank
	ld bc, wStringBuffer2 + 3
	ld de, wMoney
	farcall TakeMoney
	ld hl, wStringBuffer2
	ld de, wMomsMoney
	ld bc, 3
	call CopyBytes
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	ld hl, MomStoredMoneyText
	call PrintText
	ld a, $8
	jr .done_4

.InsufficientFundsInWallet:
	ld hl, MomInsufficientFundsInWalletText
	call PrintText
	ret

.NotEnoughRoomInBank:
	ld hl, MomNotEnoughRoomInBankText
	call PrintText
	ret

.CancelDeposit:
	ld a, $7

.done_4
	ld [wJumptableIndex], a
	ret

.TakeMoney:
	ld hl, MomTakeMoneyText
	call PrintText
	xor a
	ld hl, wStringBuffer2
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, 5
	ld [wMomBankDigitCursorPosition], a
	call LoadStandardMenuHeader
	call Mom_SetUpWithdrawMenu
	call Mom_Wait10Frames
	call Mom_WithdrawDepositMenuJoypad
	call CloseWindow
	jr c, .CancelWithdraw
	ld hl, wStringBuffer2
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	jr z, .CancelWithdraw
	ld hl, wStringBuffer2
	ld de, wStringBuffer2 + 3
	ld bc, 3
	call CopyBytes
	ld de, wMomsMoney
	ld bc, wStringBuffer2
	farcall CompareMoney
	jr c, .InsufficientFundsInBank
	ld bc, wMoney
	ld de, wStringBuffer2
	farcall GiveMoney
	jr c, .NotEnoughRoomInWallet
	ld bc, wStringBuffer2 + 3
	ld de, wMomsMoney
	farcall TakeMoney
	ld hl, wStringBuffer2
	ld de, wMoney
	ld bc, 3
	call CopyBytes
	ld de, SFX_TRANSACTION
	call PlaySFX
	call WaitSFX
	ld hl, MomTakenMoneyText
	call PrintText
	ld a, $8
	jr .done_5

.InsufficientFundsInBank:
	ld hl, MomHaventSavedThatMuchText
	call PrintText
	ret

.NotEnoughRoomInWallet:
	ld hl, MomNotEnoughRoomInWalletText
	call PrintText
	ret

.CancelWithdraw:
	ld a, $7

.done_5
	ld [wJumptableIndex], a
	ret

.StopOrStartSavingMoney:
	ld hl, MomSaveMoneyText
	call PrintText
	call YesNoBox
	jr c, .StopSavingMoney
	ld a, (1 << MOM_ACTIVE_F) | (1 << MOM_SAVING_SOME_MONEY_F)
	ld [wMomSavingMoney], a
	ld hl, MomStartSavingMoneyText
	call PrintText
	ld a, $8
	ld [wJumptableIndex], a
	ret

.StopSavingMoney:
	ld a, 1 << MOM_ACTIVE_F
	ld [wMomSavingMoney], a
	ld a, $7
	ld [wJumptableIndex], a
	ret

.JustDoWhatYouCan:
	ld hl, MomJustDoWhatYouCanText
	call PrintText

.Quit:
	ld hl, wJumptableIndex
	set JUMPTABLE_EXIT_F, [hl]
	ret

Mom_SetUpWithdrawMenu:
	ld de, Mon_WithdrawString
	jr Mom_ContinueMenuSetup

Mom_SetUpDepositMenu:
	ld de, Mom_DepositString
Mom_ContinueMenuSetup:
	push de
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	lb bc, 6, 18
	call Textbox
	hlcoord 1, 2
	ld de, Mom_SavedString
	call PlaceString
	hlcoord 12, 2
	ld de, wMomsMoney
	lb bc, 3, 6
	call PrintNum
	ld [hl], '円'
	hlcoord 1, 4
	ld de, Mom_HeldString
	call PlaceString
	hlcoord 12, 4
	ld de, wMoney
	lb bc, 3, 6
	call PrintNum
	ld [hl], '円'
	hlcoord 1, 6
	pop de
	call PlaceString
	hlcoord 12, 6
	ld de, wStringBuffer2
	lb bc, PRINTNUM_LEADINGZEROS | 3, 6
	call PrintNum
	ld [hl], '円'
	call UpdateSprites
	call CGBOnly_CopyTilemapAtOnce
	ret

Mom_Wait10Frames:
	ld c, 10
	call DelayFrames
	ret

Mom_WithdrawDepositMenuJoypad:
.loop
	call JoyTextDelay
	ld hl, hJoyPressed
	ld a, [hl]
	and PAD_B
	jr nz, .pressedB
	ld a, [hl]
	and PAD_A
	jr nz, .pressedA
	call .dpadaction
	xor a
	ldh [hBGMapMode], a
	hlcoord 12, 6
	ld bc, 6
	ld a, '　'
	call ByteFill
	hlcoord 12, 6
	ld de, wStringBuffer2
	lb bc, PRINTNUM_LEADINGZEROS | 3, 6
	call PrintNum
	ld [hl], '円'
	ldh a, [hVBlankCounter]
	and $10
	jr nz, .skip
	hlcoord 12, 6
	ld a, [wMomBankDigitCursorPosition]
	ld c, a
	ld b, 0
	add hl, bc
	ld [hl], '　'

.skip
	call WaitBGMap
	jr .loop

.pressedB
	scf
	ret

.pressedA
	and a
	ret

.dpadaction
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_UP
	jr nz, .incrementdigit
	ld a, [hl]
	and PAD_DOWN
	jr nz, .decrementdigit
	ld a, [hl]
	and PAD_LEFT
	jr nz, .movecursorleft
	ld a, [hl]
	and PAD_RIGHT
	jr nz, .movecursorright
	and a
	ret

.movecursorleft
	ld hl, wMomBankDigitCursorPosition
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ret

.movecursorright
	ld hl, wMomBankDigitCursorPosition
	ld a, [hl]
	cp 5
	ret nc
	inc [hl]
	ret

.incrementdigit
	ld hl, .DigitQuantities
	call .getdigitquantity
	ld c, l
	ld b, h
	ld de, wStringBuffer2
	farcall GiveMoney
	ret

.decrementdigit
	ld hl, .DigitQuantities
	call .getdigitquantity
	ld c, l
	ld b, h
	ld de, wStringBuffer2
	farcall TakeMoney
	ret

.getdigitquantity
	ld a, [wMomBankDigitCursorPosition]
	push de
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	add hl, de
	pop de
	ret

.DigitQuantities:
	for x, 5, -1, -1
		bigdt 10**x
	endr
	for x, 5, -1, -1
		bigdt 10**x
	endr
	for x, 5, -1, -1
		bigdt 9 * 10**x
	endr

MomLeavingText1:
	text "あら　かわいい　#ね"
	line "どうしたの？"

	para "⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯"
	line "⋯⋯そう⋯⋯　ぼうけんに　でるのね"

	para "よーし！"
	line "おかあさんも　きょうりょく　するわよ"
	cont "なに<GA>できるかしら⋯⋯？"

	para "そうだ！"
	line "おかねを　あずかってあげる"

	para "ながい　たびに　なりそうだもんね"
	line "おかねは　だいじに　しないと！"

	para "どう　ちょきん　する？"
	done

MomLeavingText2:
	text "わかったわ　ちょきん　するのね"
	line "まかせておいて！"

	para "⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯"
	prompt

MomLeavingText3:
	text "⋯⋯きをつけてね"

	para "#は　だいじな　ともだち"
	line "ちからを　あわせて　がんばるのよ！"

	para "いってらっしゃい！"
	done

MomIsThisAboutYourMoneyText:
	text "おかえり！"
	line "がんばっているみたいね"

	para "２かいは　ちゃんと　かたづいてるわよ"
	line "それとも　ちょきんのことかしら？"
	done

MomBankWhatDoYouWantToDoText:
	text "なにを　するの？"
	done

MomStoreMoneyText:
	text "いくら　あずけるの？"
	done

MomTakeMoneyText:
	text "いくら　ひきだすの？"
	done

MomSaveMoneyText:
	text "ちょきん　する？"
	done

MomHaventSavedThatMuchText:
	text "そんなに　あずかって　ないわよ"
	prompt

MomNotEnoughRoomInWalletText:
	text "そんなに　もっていけないわよ"
	prompt

MomInsufficientFundsInWalletText:
	text "そんなに　もってないじゃない"
	prompt

MomNotEnoughRoomInBankText:
	text "そんなに　あずかれないわよ"
	prompt

MomStartSavingMoneyText:
	text "わかったわ　ちょきん　するのね"
	line "まかせておいて！"

	para "<PLAYER>！　がんばってね！"
	done

MomStoredMoneyText:
	text "たいせつに　あずかるわ"
	line "がんばってね！"
	done

MomTakenMoneyText:
	text "<PLAYER>！　がんばってね！"
	done

MomJustDoWhatYouCanText:
	text "むり　しないでね"
	done

Mom_SavedString:
	db "あずけている　きんがく@"

Mon_WithdrawString:
	db "ひきだす　きんがく@"

Mom_DepositString:
	db "あずける　きんがく@"

Mom_HeldString:
	db "もっている　きんがく@"

BankOfMom_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 7, 10
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db "ひきだす@"
	db "あずける@"
	db "へんこう@"
	db "やめる@"
