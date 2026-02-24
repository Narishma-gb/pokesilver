DEF GOLDENRODGAMECORNER_TM25_COINS      EQU 5500
DEF GOLDENRODGAMECORNER_TM14_COINS      EQU 5500
DEF GOLDENRODGAMECORNER_TM38_COINS      EQU 5500
DEF GOLDENRODGAMECORNER_ABRA_COINS      EQU 200
DEF GOLDENRODGAMECORNER_SANDSHREW_COINS EQU 700
DEF GOLDENRODGAMECORNER_EKANS_COINS     EQU 700
DEF GOLDENRODGAMECORNER_DRATINI_COINS   EQU 2100

	object_const_def
	const GOLDENRODGAMECORNER_CLERK
	const GOLDENRODGAMECORNER_RECEPTIONIST1
	const GOLDENRODGAMECORNER_RECEPTIONIST2
	const GOLDENRODGAMECORNER_PHARMACIST1
	const GOLDENRODGAMECORNER_PHARMACIST2
	const GOLDENRODGAMECORNER_POKEFAN_M1
	const GOLDENRODGAMECORNER_COOLTRAINER_M
	const GOLDENRODGAMECORNER_POKEFAN_F
	const GOLDENRODGAMECORNER_COOLTRAINER_F
	const GOLDENRODGAMECORNER_GENTLEMAN
	const GOLDENRODGAMECORNER_POKEFAN_M2

GoldenrodGameCorner_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodGameCornerCoinVendorScript:
	jumpstd GameCornerCoinVendorScript

GoldenrodGameCornerTMVendorScript:
	faceplayer
	opentext
	writetext GoldenrodGameCornerPrizeVendorIntroText
	waitbutton
	checkitem COIN_CASE
	iffalse GoldenrodGameCornerPrizeVendor_NoCoinCaseScript
	writetext GoldenrodGameCornerPrizeVendorWhichPrizeText
GoldenrodGameCornerTMVendor_LoopScript:
	special DisplayCoinCaseBalance
	loadmenu GoldenrodGameCornerTMVendorMenuHeader
	verticalmenu
	closewindow
	ifequal 1, .Thunder
	ifequal 2, .Blizzard
	ifequal 3, .FireBlast
	sjump GoldenrodGameCornerPrizeVendor_CancelPurchaseScript

.Thunder:
	checkcoins GOLDENRODGAMECORNER_TM25_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	getitemname STRING_BUFFER_3, TM_THUNDER
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	giveitem TM_THUNDER
	iffalse GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	takecoins GOLDENRODGAMECORNER_TM25_COINS
	sjump GoldenrodGameCornerTMVendor_FinishScript

.Blizzard:
	checkcoins GOLDENRODGAMECORNER_TM14_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	getitemname STRING_BUFFER_3, TM_BLIZZARD
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	giveitem TM_BLIZZARD
	iffalse GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	takecoins GOLDENRODGAMECORNER_TM14_COINS
	sjump GoldenrodGameCornerTMVendor_FinishScript

.FireBlast:
	checkcoins GOLDENRODGAMECORNER_TM38_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	getitemname STRING_BUFFER_3, TM_FIRE_BLAST
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	giveitem TM_FIRE_BLAST
	iffalse GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	takecoins GOLDENRODGAMECORNER_TM38_COINS
	sjump GoldenrodGameCornerTMVendor_FinishScript

GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript:
	writetext GoldenrodGameCornerPrizeVendorConfirmPrizeText
	yesorno
	end

GoldenrodGameCornerTMVendor_FinishScript:
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	sjump GoldenrodGameCornerTMVendor_LoopScript

GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript:
	writetext GoldenrodGameCornerPrizeVendorNeedMoreCoinsText
	waitbutton
	closetext
	end

GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript:
	writetext GoldenrodGameCornerPrizeVendorNoMoreRoomText
	waitbutton
	closetext
	end

GoldenrodGameCornerPrizeVendor_CancelPurchaseScript:
	writetext GoldenrodGameCornerPrizeVendorQuitText
	waitbutton
	closetext
	end

GoldenrodGameCornerPrizeVendor_NoCoinCaseScript:
	writetext GoldenrodGameCornerPrizeVendorNoCoinCaseText
	waitbutton
	closetext
	end

GoldenrodGameCornerTMVendorMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db "わざマシン２５　５５００@"
	db "わざマシン１４　５５００@"
	db "わざマシン３８　５５００@"
	db "やめる@"

GoldenrodGameCornerPrizeMonVendorScript:
	faceplayer
	opentext
	writetext GoldenrodGameCornerPrizeVendorIntroText
	waitbutton
	checkitem COIN_CASE
	iffalse GoldenrodGameCornerPrizeVendor_NoCoinCaseScript
	writetext GoldenrodGameCornerPrizeVendorWhichPrizeText
	checkver
	iftrue .Silver_Loop

.Gold_Loop:
	special DisplayCoinCaseBalance
	loadmenu .Gold_MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .Gold_Abra
	ifequal 2, .Gold_Ekans
	ifequal 3, .Gold_Dratini
	sjump GoldenrodGameCornerPrizeVendor_CancelPurchaseScript

.Gold_Abra:
	checkcoins GOLDENRODGAMECORNER_ABRA_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	getmonname STRING_BUFFER_3, ABRA
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	givepoke ABRA, 10
	takecoins GOLDENRODGAMECORNER_ABRA_COINS
	sjump .Gold_Loop

.Gold_Ekans:
	checkcoins GOLDENRODGAMECORNER_EKANS_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	getmonname STRING_BUFFER_3, EKANS
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	givepoke EKANS, 10
	takecoins GOLDENRODGAMECORNER_EKANS_COINS
	sjump .Gold_Loop

.Gold_Dratini:
	checkcoins GOLDENRODGAMECORNER_DRATINI_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	getmonname STRING_BUFFER_3, DRATINI
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	givepoke DRATINI, 10
	takecoins GOLDENRODGAMECORNER_DRATINI_COINS
	sjump .Gold_Loop

.Gold_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .Gold_MenuData
	db 1 ; default option

.Gold_MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db "ケーシィ　　　　　２００@"
	db "アーボ　　　　　　７００@"
	db "ミニリュウ　　　２１００@"
	db "やめる@"

.Silver_Loop:
	special DisplayCoinCaseBalance
	loadmenu .Silver_MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .Silver_Abra
	ifequal 2, .Silver_Sandshrew
	ifequal 3, .Silver_Dratini
	sjump GoldenrodGameCornerPrizeVendor_CancelPurchaseScript

.Silver_Abra:
	checkcoins GOLDENRODGAMECORNER_ABRA_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	getmonname STRING_BUFFER_3, ABRA
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	givepoke ABRA, 10
	takecoins GOLDENRODGAMECORNER_ABRA_COINS
	sjump .Silver_Loop

.Silver_Sandshrew:
	checkcoins GOLDENRODGAMECORNER_SANDSHREW_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	getmonname STRING_BUFFER_3, SANDSHREW
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	givepoke SANDSHREW, 10
	takecoins GOLDENRODGAMECORNER_SANDSHREW_COINS
	sjump .Silver_Loop

.Silver_Dratini:
	checkcoins GOLDENRODGAMECORNER_DRATINI_COINS
	ifequal HAVE_LESS, GoldenrodGameCornerPrizeVendor_NotEnoughCoinsScript
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, GoldenrodGameCornerPrizeMonVendor_NoRoomForPrizeScript
	getmonname STRING_BUFFER_3, DRATINI
	scall GoldenrodGameCornerPrizeVendor_ConfirmPurchaseScript
	iffalse GoldenrodGameCornerPrizeVendor_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext GoldenrodGameCornerPrizeVendorHereYouGoText
	waitbutton
	givepoke DRATINI, 10
	takecoins GOLDENRODGAMECORNER_DRATINI_COINS
	sjump .Silver_Loop

.Silver_MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .Silver_MenuData
	db 1 ; default option

.Silver_MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db "ケーシィ　　　　　２００@"
	db "サンド　　　　　　７００@"
	db "ミニリュウ　　　２１００@"
	db "やめる@"

GoldenrodGameCornerPharmacistScript:
	faceplayer
	opentext
	writetext GoldenrodGameCornerPharmacistText
	waitbutton
	closetext
	turnobject LAST_TALKED, LEFT
	end

GoldenrodGameCornerPokefanM1Script:
	faceplayer
	opentext
	writetext GoldenrodGameCornerPokefanM1Text
	waitbutton
	closetext
	turnobject GOLDENRODGAMECORNER_POKEFAN_M1, RIGHT
	end

GoldenrodGameCornerCooltrainerMScript:
	faceplayer
	opentext
	writetext GoldenrodGameCornerCooltrainerMText
	waitbutton
	closetext
	turnobject GOLDENRODGAMECORNER_COOLTRAINER_M, LEFT
	end

GoldenrodGameCornerPokefanFScript:
	faceplayer
	opentext
	writetext GoldenrodGameCornerPokefanFText
	waitbutton
	closetext
	turnobject GOLDENRODGAMECORNER_POKEFAN_F, RIGHT
	end

GoldenrodGameCornerCooltrainerFScript:
	jumptextfaceplayer GoldenrodGameCornerCooltrainerFText

GoldenrodGameCornerGentlemanScript:
	faceplayer
	opentext
	writetext GoldenrodGameCornerGentlemanText
	waitbutton
	closetext
	turnobject GOLDENRODGAMECORNER_GENTLEMAN, RIGHT
	end

GoldenrodGameCornerPokefanM2Script:
	jumptextfaceplayer GoldenrodGameCornerPokefanM2Text

GoldenrodGameCornerSlotsMachineScript:
	random 6
	ifequal 0, GoldenrodGameCornerLuckySlotsMachineScript
	reanchormap
	setval FALSE
	special SlotMachine
	closetext
	end

GoldenrodGameCornerLuckySlotsMachineScript:
	reanchormap
	setval TRUE
	special SlotMachine
	closetext
	end

GoldenrodGameCornerCardFlipMachineScript:
	reanchormap
	special CardFlip
	closetext
	end

GoldenrodGameCornerPrizeVendorIntroText:
	text "いらっしゃいませ！"

	para "ゲームで　ためた　コインは"
	line "こちらで　おすきな"
	cont "けいひんと　こうかん　します！"
	done

GoldenrodGameCornerPrizeVendorWhichPrizeText:
	text "どれ<GA>いいですか？"
	done

GoldenrodGameCornerPrizeVendorConfirmPrizeText:
	text "@"
	text_ram wStringBuffer3
	text "で　いいですね？"
	done

GoldenrodGameCornerPrizeVendorHereYouGoText:
	text "はい　どうぞ！"
	done

GoldenrodGameCornerPrizeVendorNeedMoreCoinsText:
	text "コイン<GA>たりませんね"
	done

GoldenrodGameCornerPrizeVendorNoMoreRoomText:
	text "それいじょう　もてない　ですよ"
	done

GoldenrodGameCornerPrizeVendorQuitText:
	text "あら　そうですか"
	line "コイン　ためて　きてくださいね！"
	done

GoldenrodGameCornerPrizeVendorNoCoinCaseText:
	text "あれ？"
	line "コインケース<GA>ありませんね"
	done

GoldenrodGameCornerPharmacistText:
	text "いつも　こ<NO>スロットで　あそんでる"
	line "なんだか　ほか<NI>くらべて"
	cont "でやすいような　き<GA>するんだ"
	done

GoldenrodGameCornerPokefanM1Text:
	text "さいしんがた<NO>スロット<WA>いいねえ"
	line "タマムシで　あそんでた　ときより"
	cont "ちょうせん　しがい<GA>あるよ！"
	done

GoldenrodGameCornerCooltrainerMText:
	text "じんせい　いっぱつ　しょうぶ！"
	line "めく<TTE>　めくりまくるぜ！"
	done

GoldenrodGameCornerPokefanFText:
	text "カードめくり<⋯>"

	para "じぶんで　よそう<WO>たてやすいから"
	line "ばいりつ<WA>ひくくても"
	cont "スロットより　すきなのよ"
	done

GoldenrodGameCornerCooltrainerFText:
	text "もう　かつまで　やめないわよ！"
	done

GoldenrodGameCornerGentlemanText:
	text "じぶん<NO>#に"
	line "ふぶき<WO>おぼえさせたよ"

	para "コイン<WO>ためる<NO>たいへんだったが"
	line "それだけ<NO>かち<GA>あるよ"
	done

GoldenrodGameCornerPokefanM2Text:
	text "スロットでも　かてない"
	line "カードめくりでも　かてない"

	para "あたま<NI>きたから　ちかつうろに"
	line "コインケース<WO>すてたよ！"
	done

GoldenrodGameCorner_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2, 13, GOLDENROD_CITY, 11
	warp_event  3, 13, GOLDENROD_CITY, 11

	def_coord_events

	def_bg_events
	bg_event  6,  6, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6,  7, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6,  8, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6,  9, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6, 10, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  6, 11, BGEVENT_RIGHT, GoldenrodGameCornerSlotsMachineScript
	bg_event  7,  6, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  7,  7, BGEVENT_READ, GoldenrodGameCornerLuckySlotsMachineScript
	bg_event  7,  8, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  7,  9, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  7, 10, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event  7, 11, BGEVENT_LEFT, GoldenrodGameCornerSlotsMachineScript
	bg_event 12,  6, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event 12,  7, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event 12,  8, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event 12,  9, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event 12, 10, BGEVENT_READ, GoldenrodGameCornerSlotsMachineScript
	bg_event 12, 11, BGEVENT_RIGHT, GoldenrodGameCornerSlotsMachineScript
	bg_event 13,  6, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 13,  7, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 13,  8, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 13,  9, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 13, 10, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 13, 11, BGEVENT_LEFT, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18,  6, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18,  7, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18,  8, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18,  9, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18, 10, BGEVENT_READ, GoldenrodGameCornerCardFlipMachineScript
	bg_event 18, 11, BGEVENT_RIGHT, GoldenrodGameCornerCardFlipMachineScript

	def_object_events
	object_event  3,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerCoinVendorScript, -1
	object_event 16,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerTMVendorScript, -1
	object_event 18,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPrizeMonVendorScript, -1
	object_event  8,  7, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, DAY, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPharmacistScript, -1
	object_event  8,  7, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, NITE, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPharmacistScript, -1
	object_event 11, 10, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPokefanM1Script, -1
	object_event 14,  8, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerCooltrainerMScript, -1
	object_event 17,  6, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPokefanFScript, -1
	object_event 10,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerCooltrainerFScript, -1
	object_event  5, 10, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerGentlemanScript, -1
	object_event  2,  9, SPRITE_POKEFAN_M, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodGameCornerPokefanM2Script, -1
