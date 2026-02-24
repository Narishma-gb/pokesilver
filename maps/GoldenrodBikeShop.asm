	object_const_def
	const GOLDENRODBIKESHOP_CLERK

GoldenrodBikeShop_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodBikeShopNoopScene: ; unreferenced
	end

GoldenrodBikeShopClerkScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_BICYCLE
	iftrue .GotBicycle
	writetext GoldenrodBikeShopClerkIntroText
	yesorno
	iffalse .Refused
	writetext GoldenrodBikeShopClerkAgreedText
	promptbutton
	waitsfx
	giveitem BICYCLE
	writetext BorrowedABicycleText
	playsound SFX_KEY_ITEM
	waitsfx
	itemnotify
	setflag ENGINE_BIKE_SHOP_CALL_ENABLED
	setevent EVENT_GOT_BICYCLE
.GotBicycle:
	writetext GoldenrodBikeShopClerkFirstRateBikesText
	waitbutton
	closetext
	end

.Refused:
	writetext GoldenrodBikeShopClerkRefusedText
	waitbutton
	closetext
	end

GoldenrodBikeShopJustReleasedCompactBike: ; unreferenced
	jumptext GoldenrodBikeShopJustReleasedCompactBikeText

GoldenrodBikeShopBicycle:
	jumptext GoldenrodBikeShopBicycleText

GoldenrodBikeShopClerkIntroText:
	text "はあ<⋯>"
	line "わざわざ　コガネ<NI>きたけど"
	cont "じてんしゃ　ぜんぜん　うれない"

	para "どうだろう？"
	line "きみ　じてんしゃ<NI>のりまく<TTE>"
	cont "せんでん　してくれない？"
	done

GoldenrodBikeShopClerkAgreedText:
	text "ほ　ほんと？"

	para "じゃあ　なまえと　でんわばんごう"
	line "おしえてよ"
	cont "じてんしゃ<WO>かすからさ"
	done

BorrowedABicycleText:
	text "<PLAYER>は"
	line "じてんしゃ<WO>かり<TA!>"
	done

GoldenrodBikeShopClerkFirstRateBikesText:
	text "ミラクル　サイクル<NO>じてんしゃは"
	line "せいのう　ばつぐん　だからね！"
	cont "どんな　みちも　スイスイ　はしるよ！"
	done

GoldenrodBikeShopClerkRefusedText:
	text "はあ<⋯>"
	line "ひと<NO>やさしさ<NI>ふれたいよ"
	done

BikeShopPhoneCallerText:
	text "やあ　<PLAYER>くん"
	line "さいきん　じてんしゃ　うれてるよ！"

	para "きみ<GA>じてんしゃ<NI>の<TTE>"
	line "せんでん　してくれてるからだね"

	para "おれい　といっちゃ　なんだけど"
	line "かしている　じてんしゃ"
	cont "きみ<NO>もの<NI>してください！"

	para "ほんと　ありがとう　だよ"
	done

GoldenrodBikeShopJustReleasedCompactBikeText:
	text "つい<NI>はつばい！"
	line "さいこうきゅう　コンパクト　サイクル"
	done

GoldenrodBikeShopBicycleText:
	text "ピッカピカ<NO>じてんしゃだ！"
	done

GoldenrodBikeShop_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 2
	warp_event  3,  7, GOLDENROD_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  1,  2, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  0,  3, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  1,  3, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  0,  5, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  1,  5, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  0,  6, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  1,  6, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  6,  6, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  7,  6, BGEVENT_READ, GoldenrodBikeShopBicycle

	def_object_events
	object_event  7,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodBikeShopClerkScript, -1
