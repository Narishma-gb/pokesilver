DEF ROUTE39FARMHOUSE_MILK_PRICE EQU 500

	object_const_def
	const ROUTE39FARMHOUSE_POKEFAN_M
	const ROUTE39FARMHOUSE_POKEFAN_F

Route39Farmhouse_MapScripts:
	def_scene_scripts

	def_callbacks

PokefanM_DairyFarmer:
	faceplayer
	opentext
	checkevent EVENT_HEALED_MOOMOO
	iftrue FarmerMScript_SellMilk
	writetext FarmerMText_SickCow
	waitbutton
	closetext
	setevent EVENT_TALKED_TO_FARMER_ABOUT_MOOMOO
	end

FarmerMScript_SellMilk:
	checkitem MOOMOO_MILK
	iftrue FarmerMScript_Milking
	writetext FarmerMText_BuyMilk
	special PlaceMoneyTopRight
	yesorno
	iffalse FarmerMScript_NoSale
	checkmoney YOUR_MONEY, ROUTE39FARMHOUSE_MILK_PRICE
	ifequal HAVE_LESS, FarmerMScript_NoMoney
	giveitem MOOMOO_MILK
	iffalse FarmerMScript_NoRoom
	takemoney YOUR_MONEY, ROUTE39FARMHOUSE_MILK_PRICE
	special PlaceMoneyTopRight
	waitsfx
	playsound SFX_TRANSACTION
	writetext FarmerMText_GotMilk
	promptbutton
	itemnotify
	closetext
	end

FarmerMScript_NoMoney:
	writetext FarmerMText_NoMoney
	waitbutton
	closetext
	end

FarmerMScript_NoRoom:
	writetext FarmerMText_NoRoom
	waitbutton
	closetext
	end

FarmerMScript_NoSale:
	writetext FarmerMText_NoSale
	waitbutton
	closetext
	end

FarmerMScript_Milking:
	writetext FarmerMText_Milking
	waitbutton
	closetext
	end

PokefanF_SnoreFarmer:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM13_SNORE_FROM_MOOMOO_FARM
	iftrue FarmerFScript_GotSnore
	checkevent EVENT_HEALED_MOOMOO
	iftrue FarmerFScript_GiveSnore
	writetext FarmerFText_InTrouble
	waitbutton
	closetext
	end

FarmerFScript_GiveSnore:
	writetext FarmerFText_HealedMiltank
	promptbutton
	verbosegiveitem TM_SNORE
	iffalse FarmerFScript_NoRoomForSnore
	setevent EVENT_GOT_TM13_SNORE_FROM_MOOMOO_FARM
FarmerFScript_GotSnore:
	writetext FarmerFText_SnoreSpeech
	waitbutton
FarmerFScript_NoRoomForSnore:
	closetext
	end

FarmhouseBookshelf:
	jumpstd PictureBookshelfScript

FarmerMText_SickCow:
	text "オラ<NO>ミルタンク"
	line "ミルク<WO>ださなくな<TTE>んだー"

	para "オラんち<NO>ミルク<WA>ゆうめいだ"
	line "みんな　のみてえ　い<TTE>るのにのー"

	para "きのみ<WO>いっぱい　たべさせりゃ"
	line "げんき<NI>な<TTE>"
	cont "おいしい　ミルク<WO>たくさん"
	cont "だしてくれるんだけどもな"
	done

FarmerMText_BuyMilk:
	text "ぼくじょう　じまんの"
	line "モーモーミルク<WA>いらんかー？"

	para "#<NI>のませりゃ"
	line "たいりょく　かいふく　<TTE>もんだ！"

	para "いまなら　{d:ROUTE39FARMHOUSE_MILK_PRICE}円だー"
	done

FarmerMText_GotMilk:
	text "たっぷり　のんでくれー！"
	done

FarmerMText_NoMoney:
	text "あやや　おかね<GA>たりないねー！"
	done

FarmerMText_NoRoom:
	text "あやや　にもつ<GA>いっぱいだなー！"
	done

FarmerMText_NoSale:
	text "いらんかー？"
	line "じゃ　また　きてくれなー"
	done

FarmerMText_Milking:
	text "んじゃ　ちちしぼりでも　はじめっかー"
	done

FarmerFText_InTrouble:
	text "うち<NO>ミルクは"
	line "カントーにも　しゅっか　してるんだ"

	para "でも　ミルタンクが"
	line "おいしい　ミルク　だしてくれんと"
	cont "オラたちも　こまるんだー"
	done

FarmerFText_HealedMiltank:
	text "ミルタンクが"
	line "おいしい　ミルク　だしはじめたのは"
	cont "あんた<NO>おかげだー"

	para "これ　あんた<NI>やるよ"
	line "うけと<TTE>くれー"
	done

Text_ReceivedTM13: ; unreferenced
	text "<PLAYER>は"
	line "<TM>１３<WO>もらっ<TA!>"
	done

FarmerFText_SnoreSpeech:
	text "それ<WA>いびき　<TTE>　わざ　だぁ"

	para "ねむ<TTE>いる　ときしか　つかえない"
	line "めずらしい　わざ　だからなぁ"
	cont "よく　かんがえて　つかえよぉ"
	done

Route39Farmhouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_39, 2
	warp_event  3,  7, ROUTE_39, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, FarmhouseBookshelf
	bg_event  1,  1, BGEVENT_READ, FarmhouseBookshelf

	def_object_events
	object_event  3,  2, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PokefanM_DairyFarmer, -1
	object_event  5,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, PokefanF_SnoreFarmer, -1
