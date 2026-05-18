NPCTrade::
	ld a, e
	ld [wJumptableIndex], a
	call Trade_GetDialog
	ld b, CHECK_FLAG
	call TradeFlagAction
	ld a, TRADE_DIALOG_AFTER
	jr nz, .done

	ld a, TRADE_DIALOG_INTRO
	call PrintTradeText

	call YesNoBox
	ld a, TRADE_DIALOG_CANCEL
	jr c, .done

; Select givemon from party
	ld b, PARTYMENUACTION_GIVE_MON
	farcall SelectTradeOrDayCareMon
	ld a, TRADE_DIALOG_CANCEL
	jr c, .done

	ld e, NPCTRADE_GIVEMON
	call GetTradeAttr
	ld a, [wCurPartySpecies]
	cp [hl]
	ld a, TRADE_DIALOG_WRONG
	jr nz, .done

	call CheckTradeGender
	ld a, TRADE_DIALOG_WRONG
	jr c, .done

	ld b, SET_FLAG
	call TradeFlagAction

	ld hl, NPCTradeCableText
	call PrintText

	call DoNPCTrade
	call .TradeAnimation
	call GetTradeMonNames

	ld hl, TradedForText
	call PrintText

	call RestartMapMusic

	ld a, TRADE_DIALOG_COMPLETE

.done
	call PrintTradeText
	ret

.TradeAnimation:
	call DisableSpriteUpdates
	ld a, [wJumptableIndex]
	push af
	; wTradeDialog aliases wFrameCounter, which TradeAnimation uses
	ld a, [wTradeDialog]
	push af
	predef TradeAnimation
	pop af
	ld [wTradeDialog], a
	pop af
	ld [wJumptableIndex], a
	call ReturnToMapWithSpeechTextbox
	ret

CheckTradeGender:
	xor a
	ld [wMonType], a

	ld e, NPCTRADE_GENDER
	call GetTradeAttr
	ld a, [hl]
	and a ; TRADE_GENDER_EITHER
	jr z, .matching
	cp TRADE_GENDER_MALE
	jr z, .check_male
	; TRADE_GENDER_FEMALE
	farcall GetGender
	jr nz, .not_matching
	jr .matching

.check_male
	farcall GetGender
	jr z, .not_matching

.matching
	and a
	ret

.not_matching
	scf
	ret

TradeFlagAction:
	ld hl, wTradeFlags
	ld a, [wJumptableIndex]
	ld c, a
	predef SmallFarFlagAction
	ld a, c
	and a
	ret

Trade_GetDialog:
	ld e, NPCTRADE_DIALOG
	call GetTradeAttr
	ld a, [hl]
	ld [wTradeDialog], a
	ret

DoNPCTrade:
	ld e, NPCTRADE_GIVEMON
	call GetTradeAttr
	ld a, [hl]
	ld [wPlayerTrademonSpecies], a

	ld e, NPCTRADE_GETMON
	call GetTradeAttr
	ld a, [hl]
	ld [wOTTrademonSpecies], a

	ld a, [wPlayerTrademonSpecies]
	ld de, wPlayerTrademonSpeciesName
	call GetTradeMonName
	call CopyTradeName

	ld a, [wOTTrademonSpecies]
	ld de, wOTTrademonSpeciesName
	call GetTradeMonName
	call CopyTradeName

	ld hl, wPartyMonOTs
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonOTName
	call CopyTradeName

	ld hl, wPlayerName
	ld de, wPlayerTrademonSenderName
	call CopyTradeName

	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonID
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonDVs
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfCurrentPartymon
	ld a, [hl]
	ld [wCurPartyLevel], a
	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	xor a
	ld [wMonType], a ; PARTYMON
	ld [wPokemonWithdrawDepositParameter], a ; REMOVE_PARTY
	callfar RemoveMonFromPartyOrBox
	predef TryAddMonToParty

	ld e, NPCTRADE_NICKNAME
	call GetTradeAttr
	ld de, wOTTrademonNickname
	call Trade_CopyFourCharString

	ld hl, wPartyMonNicknames
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonNickname
	call CopyTradeName

	ld e, NPCTRADE_OT_NAME
	call GetTradeAttr
	push hl
	ld de, wOTTrademonOTName
	call Trade_CopyThreeCharString
	pop hl
	ld de, wOTTrademonSenderName
	call Trade_CopyThreeCharString

	ld hl, wPartyMonOTs
	ld bc, NAME_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonOTName
	call CopyTradeName

	ld e, NPCTRADE_DVS
	call GetTradeAttr
	ld de, wOTTrademonDVs
	call Trade_CopyTwoBytes

	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonDVs
	call Trade_CopyTwoBytes

	ld e, NPCTRADE_OT_ID
	call GetTradeAttr
	ld de, wOTTrademonID + 1
	call Trade_CopyTwoBytesReverseEndian

	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonID
	call Trade_CopyTwoBytes

	ld e, NPCTRADE_ITEM
	call GetTradeAttr
	push hl
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call Trade_GetAttributeOfLastPartymon
	pop hl
	ld a, [hl]
	ld [de], a

	push af
	push bc
	push de
	push hl
	ld a, [wCurPartyMon]
	push af
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	farcall ComputeNPCTrademonStats
	pop af
	ld [wCurPartyMon], a
	pop hl
	pop de
	pop bc
	pop af
	ret

GetTradeAttr:
	ld d, 0
	push de
	ld a, [wJumptableIndex]
	and $f
	swap a
	ld e, a
	ld d, 0
	ld hl, NPCTrades
	add hl, de
	pop de
	add hl, de
	ret

Trade_GetAttributeOfCurrentPartymon:
	ld a, [wCurPartyMon]
	call AddNTimes
	ret

Trade_GetAttributeOfLastPartymon:
	ld a, [wPartyCount]
	dec a
	call AddNTimes
	ld e, l
	ld d, h
	ret

GetTradeMonName:
	push de
	ld [wNamedObjectIndex], a
	call GetBasePokemonName
	ld hl, wStringBuffer1
	pop de
	ret

CopyTradeName:
	ld bc, NAME_LENGTH
	call CopyBytes
	ret

Trade_CopyFourCharString:
	ld bc, 4
	call CopyBytes
	ld a, '@'
	ld [de], a
	ret

Trade_CopyThreeCharString:
	ld bc, 3
	call CopyBytes
	ld a, '@'
	ld [de], a
	ret

Trade_CopyTwoBytes:
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret

Trade_CopyTwoBytesReverseEndian:
	ld a, [hli]
	ld [de], a
	dec de
	ld a, [hl]
	ld [de], a
	ret

GetTradeMonNames:
	ld e, NPCTRADE_GETMON
	call GetTradeAttr
	ld a, [hl]
	call GetTradeMonName

	ld de, wStringBuffer2
	call CopyTradeName

	ld e, NPCTRADE_GIVEMON
	call GetTradeAttr
	ld a, [hl]
	call GetTradeMonName

	ld de, wMonOrItemNameBuffer
	call CopyTradeName

	ld hl, wStringBuffer1
.loop
	ld a, [hli]
	cp '@'
	jr nz, .loop

	dec hl
	push hl
	ld e, NPCTRADE_GENDER
	call GetTradeAttr
	ld a, [hl]
	pop hl
	and a ; TRADE_GENDER_EITHER
	ret z
	cp TRADE_GENDER_MALE
	ld a, '♂'
	jr z, .done
	; TRADE_GENDER_FEMALE
	ld a, '♀'
.done
	ld [hli], a
	ld [hl], '@'
	ret

INCLUDE "data/events/npc_trades.asm"

PrintTradeText:
	push af
	call GetTradeMonNames
	pop af
	ld e, a
	ld d, 0
	ld hl, TradeTexts
rept 6
	add hl, de
endr
	ld a, [wTradeDialog]
	ld e, a
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	ret

TradeTexts:
; entries correspond to TRADE_DIALOG_* × TRADE_DIALOGSET_* constants
	table_width 2
; TRADE_DIALOG_INTRO
	dw NPCTradeIntroText1
	dw NPCTradeIntroText2
	dw NPCTradeIntroText3
; TRADE_DIALOG_CANCEL
	dw NPCTradeCancelText1
	dw NPCTradeCancelText2
	dw NPCTradeCancelText3
; TRADE_DIALOG_WRONG
	dw NPCTradeWrongText1
	dw NPCTradeWrongText2
	dw NPCTradeWrongText3
; TRADE_DIALOG_COMPLETE
	dw NPCTradeCompleteText1
	dw NPCTradeCompleteText2
	dw NPCTradeCompleteText3
; TRADE_DIALOG_AFTER
	dw NPCTradeAfterText1
	dw NPCTradeAfterText2
	dw NPCTradeAfterText3
	assert_table_length NUM_TRADE_DIALOGS * NUM_TRADE_DIALOGSETS

NPCTradeCableText:
	text "じゃあ"
	line "ケーブルを　つないで<⋯>と"
	prompt

TradedForText:
	; traded givemon for getmon
	text "<PLAYER>は　@"
	text_ram wMonOrItemNameBuffer
	text "と"
	line "@"
	text_ram wStringBuffer2
	text "を　こうかんした！@"
	text_asm
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld hl, .done
	ret

.done
	sound_dex_fanfare_80_109
	text_pause
	text_end

NPCTradeIntroText1:
	text "ボク　#　あつめてるんだ！"
	line "キミは　@"
	text_ram wStringBuffer1
	text "を　もってる？"

	para "ボクの　@"
	text_ram wStringBuffer2
	text "と"
	line "こうかん　しようよ？"
	done

NPCTradeCancelText1:
	text "とりかえて　くれないの？"
	line "ちぇっ　がっかりだなあ<⋯>"
	done

NPCTradeWrongText1:
	text "あれ<⋯>？"
	line "@"
	text_ram wStringBuffer1
	text "じゃ　ないよ"
	cont "ちぇっ　ざんねんだなあ<⋯>"
	done

NPCTradeCompleteText1:
	text "やったあ！"
	line "@"
	text_ram wStringBuffer1
	text "<GA>てにはいった！"
	cont "サンキュー！"
	done

NPCTradeAfterText1:
	text "やあっ！"
	line "ボクと　とりかえた　@"
	text_ram wStringBuffer2
	text_start
	cont "げんき？"
	done

NPCTradeIntroText2:
	text "なあ　きみ<⋯>"
	line "さがしてる　#<GA>いるんだ"

	para "もし　@"
	text_ram wStringBuffer1
	text "を　もってたら"
	line "わしの　@"
	text_ram wStringBuffer2
	text "と"
	cont "こうかん　してくれないか？"
	done

NPCTradeCancelText2:
	text "キミも　もってないのか<⋯>"
	line "ざんねんだなあ<⋯>"
	done

NPCTradeWrongText2:
	text_ram wStringBuffer1
	text "を　もってないのか？"
	line "じゃあ　しょうがないね<⋯>"
	done

NPCTradeCompleteText2:
	text "おお！"
	line "ありがとう！"

	para "やっと　@"
	text_ram wStringBuffer1
	text "が"
	line "てに　はいったよ！"
	done

NPCTradeAfterText2:
	text "おお！"

	para "キミから　もらった@"
	text_ram wMonOrItemNameBuffer
	text "は"
	line "すごく　げんきだよ！"
	done

NPCTradeIntroText3:
	text_ram wMonOrItemNameBuffer
	text "って　かわいいわよね！"
	line "でも　わたし　もってないの<⋯>"
	cont "あなた　@"
	text_ram wStringBuffer1
	text "　もってる？"

	para "わたしの　@"
	text_ram wStringBuffer2
	text "と"
	line "こうかん　しましょうよ！"
	done

NPCTradeCancelText3:
	text "こうかんして　くれないの？"
	line "えーっ<⋯>　がっかり<⋯>"
	done

NPCTradeWrongText3:
	text_ram wStringBuffer1
	text "じゃ　ないわよ　それ"
	line "つかまえたら　とりかえてね！"
	done

NPCTradeCompleteText3:
	text "わあ！　ありがとうっ！"
	line "@"
	text_ram wMonOrItemNameBuffer
	text "　ほしかったのっ！"
	done

NPCTradeAfterText3:
	text "こうかんした　@"
	text_ram wStringBuffer2
	text "　げんき？"
	line "@"
	text_ram wMonOrItemNameBuffer
	text "は　すっごく　かわいいわ！"
	done
