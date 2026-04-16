DEF CELADONGAMECORNERPRIZEROOM_TM32_COINS    EQU 1500
DEF CELADONGAMECORNERPRIZEROOM_TM29_COINS    EQU 3500
DEF CELADONGAMECORNERPRIZEROOM_TM15_COINS    EQU 7500
DEF CELADONGAMECORNERPRIZEROOM_MR_MIME_COINS EQU 3333
DEF CELADONGAMECORNERPRIZEROOM_EEVEE_COINS   EQU 6666
DEF CELADONGAMECORNERPRIZEROOM_PORYGON_COINS EQU 9999

	object_const_def
	const CELADONGAMECORNERPRIZEROOM_GENTLEMAN
	const CELADONGAMECORNERPRIZEROOM_PHARMACIST

CeladonGameCornerPrizeRoom_MapScripts:
	def_scene_scripts

	def_callbacks

CeladonGameCornerPrizeRoomGentlemanScript:
	jumptextfaceplayer CeladonGameCornerPrizeRoomGentlemanText

CeladonGameCornerPrizeRoomPharmacistScript:
	jumptextfaceplayer CeladonGameCornerPrizeRoomPharmacistText

CeladonGameCornerPrizeRoomTMVendor:
	faceplayer
	opentext
	writetext CeladonPrizeRoom_PrizeVendorIntroText
	waitbutton
	checkitem COIN_CASE
	iffalse CeladonPrizeRoom_NoCoinCase
	writetext CeladonPrizeRoom_AskWhichPrizeText
CeladonPrizeRoom_tmcounterloop:
	special DisplayCoinCaseBalance
	loadmenu CeladonPrizeRoom_TMMenuHeader
	verticalmenu
	closewindow
	ifequal 1, .DoubleTeam
	ifequal 2, .Psychic
	ifequal 3, .HyperBeam
	sjump CeladonPrizeRoom_CancelPurchaseScript

.DoubleTeam:
	checkcoins CELADONGAMECORNERPRIZEROOM_TM32_COINS
	ifequal HAVE_LESS, CeladonPrizeRoom_notenoughcoins
	getitemname STRING_BUFFER_3, TM_DOUBLE_TEAM
	scall CeladonPrizeRoom_askbuy
	iffalse CeladonPrizeRoom_CancelPurchaseScript
	giveitem TM_DOUBLE_TEAM
	iffalse CeladonPrizeRoom_notenoughroom
	takecoins CELADONGAMECORNERPRIZEROOM_TM32_COINS
	sjump CeladonPrizeRoom_purchased

.Psychic:
	checkcoins CELADONGAMECORNERPRIZEROOM_TM29_COINS
	ifequal HAVE_LESS, CeladonPrizeRoom_notenoughcoins
	getitemname STRING_BUFFER_3, TM_PSYCHIC_M
	scall CeladonPrizeRoom_askbuy
	iffalse CeladonPrizeRoom_CancelPurchaseScript
	giveitem TM_PSYCHIC_M
	iffalse CeladonPrizeRoom_notenoughroom
	takecoins CELADONGAMECORNERPRIZEROOM_TM29_COINS
	sjump CeladonPrizeRoom_purchased

.HyperBeam:
	checkcoins CELADONGAMECORNERPRIZEROOM_TM15_COINS
	ifequal HAVE_LESS, CeladonPrizeRoom_notenoughcoins
	getitemname STRING_BUFFER_3, TM_HYPER_BEAM
	scall CeladonPrizeRoom_askbuy
	iffalse CeladonPrizeRoom_CancelPurchaseScript
	giveitem TM_HYPER_BEAM
	iffalse CeladonPrizeRoom_notenoughroom
	takecoins CELADONGAMECORNERPRIZEROOM_TM15_COINS
	sjump CeladonPrizeRoom_purchased

CeladonPrizeRoom_askbuy:
	writetext CeladonPrizeRoom_ConfirmPurchaseText
	yesorno
	end

CeladonPrizeRoom_purchased:
	waitsfx
	playsound SFX_TRANSACTION
	writetext CeladonPrizeRoom_HereYouGoText
	waitbutton
	sjump CeladonPrizeRoom_tmcounterloop

CeladonPrizeRoom_notenoughcoins:
	writetext CeladonPrizeRoom_NotEnoughCoinsText
	waitbutton
	closetext
	end

CeladonPrizeRoom_notenoughroom:
	writetext CeladonPrizeRoom_NotEnoughRoomText
	waitbutton
	closetext
	end

CeladonPrizeRoom_CancelPurchaseScript:
	writetext CeladonPrizeRoom_ComeAgainText
	waitbutton
	closetext
	end

CeladonPrizeRoom_NoCoinCase:
	writetext CeladonPrizeRoom_NoCoinCaseText
	waitbutton
	closetext
	end

CeladonPrizeRoom_TMMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db "わざマシン３２　{d:CELADONGAMECORNERPRIZEROOM_TM32_COINS}@"
	db "わざマシン２９　{d:CELADONGAMECORNERPRIZEROOM_TM29_COINS}@"
	db "わざマシン１５　{d:CELADONGAMECORNERPRIZEROOM_TM15_COINS}@"
	db "やめる@"

CeladonGameCornerPrizeRoomPokemonVendor:
	faceplayer
	opentext
	writetext CeladonPrizeRoom_PrizeVendorIntroText
	waitbutton
	checkitem COIN_CASE
	iffalse CeladonPrizeRoom_NoCoinCase
	writetext CeladonPrizeRoom_AskWhichPrizeText
.loop
	special DisplayCoinCaseBalance
	loadmenu .MenuHeader
	verticalmenu
	closewindow
	ifequal 1, .MrMime
	ifequal 2, .Eevee
	ifequal 3, .Porygon
	sjump CeladonPrizeRoom_CancelPurchaseScript

.MrMime:
	checkcoins CELADONGAMECORNERPRIZEROOM_MR_MIME_COINS
	ifequal HAVE_LESS, CeladonPrizeRoom_notenoughcoins
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, CeladonPrizeRoom_notenoughroom
	getmonname STRING_BUFFER_3, MR__MIME
	scall CeladonPrizeRoom_askbuy
	iffalse CeladonPrizeRoom_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext CeladonPrizeRoom_HereYouGoText
	waitbutton
	givepoke MR__MIME, 15
	takecoins CELADONGAMECORNERPRIZEROOM_MR_MIME_COINS
	sjump .loop

.Eevee:
	checkcoins CELADONGAMECORNERPRIZEROOM_EEVEE_COINS
	ifequal HAVE_LESS, CeladonPrizeRoom_notenoughcoins
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, CeladonPrizeRoom_notenoughroom
	getmonname STRING_BUFFER_3, EEVEE
	scall CeladonPrizeRoom_askbuy
	iffalse CeladonPrizeRoom_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext CeladonPrizeRoom_HereYouGoText
	waitbutton
	givepoke EEVEE, 15
	takecoins CELADONGAMECORNERPRIZEROOM_EEVEE_COINS
	sjump .loop

.Porygon:
	checkcoins CELADONGAMECORNERPRIZEROOM_PORYGON_COINS
	ifequal HAVE_LESS, CeladonPrizeRoom_notenoughcoins
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, CeladonPrizeRoom_notenoughroom
	getmonname STRING_BUFFER_3, PORYGON
	scall CeladonPrizeRoom_askbuy
	iffalse CeladonPrizeRoom_CancelPurchaseScript
	waitsfx
	playsound SFX_TRANSACTION
	writetext CeladonPrizeRoom_HereYouGoText
	waitbutton
	givepoke PORYGON, 20
	takecoins CELADONGAMECORNERPRIZEROOM_PORYGON_COINS
	sjump .loop

.MenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 2, 15, TEXTBOX_Y - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	db 4 ; items
	db "バリヤード　　　{d:CELADONGAMECORNERPRIZEROOM_MR_MIME_COINS}@"
	db "イーブイ　　　　{d:CELADONGAMECORNERPRIZEROOM_EEVEE_COINS}@"
	db "ポリゴン　　　　{d:CELADONGAMECORNERPRIZEROOM_PORYGON_COINS}@"
	db "やめる@"

CeladonGameCornerPrizeRoomGentlemanText:
	text "バリヤード<GA>ほしかったのに<⋯>"
	line "コイン<GA>あと　１００まい"
	cont "たらなかった<⋯>！"
	done

CeladonGameCornerPrizeRoomPharmacistText:
	text "ふううううう<⋯>"

	para "あまり　アツく　ならないよう"
	line "き<WO>つけなければ<⋯>"

	para "おかね<WO>ぜんぶ　なくしたら"
	line "しかた<GA>ない　からね<⋯>"
	done

CeladonPrizeRoom_PrizeVendorIntroText:
	text "いらっしゃいませ！"

	para "ゲームで　ためた　コインは"
	line "こちらで　おすきな"
	cont "けいひんと　こうかん　します！"
	done

CeladonPrizeRoom_AskWhichPrizeText:
	text "どれ<GA>いいですか？"
	done

CeladonPrizeRoom_ConfirmPurchaseText:
	text "@"
	text_ram wStringBuffer3
	text "で　いいですね？"
	done

CeladonPrizeRoom_HereYouGoText:
	text "はい　どうぞ！"
	done

CeladonPrizeRoom_NotEnoughCoinsText:
	text "コイン<GA>たりませんね"
	done

CeladonPrizeRoom_NotEnoughRoomText:
	text "それいじょう　もてない　ですよ"
	done

CeladonPrizeRoom_ComeAgainText:
	text "あら　そうですか"
	line "コイン　ためて　きてくださいね！"
	done

CeladonPrizeRoom_NoCoinCaseText:
	text "あれ？"
	line "コインケース<GA>ありませんね"
	done

CeladonGameCornerPrizeRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  5, CELADON_CITY, 7
	warp_event  3,  5, CELADON_CITY, 7

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, CeladonGameCornerPrizeRoomTMVendor
	bg_event  4,  1, BGEVENT_READ, CeladonGameCornerPrizeRoomPokemonVendor

	def_object_events
	object_event  0,  2, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonGameCornerPrizeRoomGentlemanScript, -1
	object_event  4,  4, SPRITE_PHARMACIST, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonGameCornerPrizeRoomPharmacistScript, -1
