	object_const_def
	const GOLDENRODCITY_POKEFAN_M1
	const GOLDENRODCITY_YOUNGSTER1
	const GOLDENRODCITY_COOLTRAINER_F1
	const GOLDENRODCITY_COOLTRAINER_F2
	const GOLDENRODCITY_YOUNGSTER2
	const GOLDENRODCITY_LASS
	const GOLDENRODCITY_GRAMPS
	const GOLDENRODCITY_ROCKETSCOUT
	const GOLDENRODCITY_ROCKET1
	const GOLDENRODCITY_ROCKET2
	const GOLDENRODCITY_ROCKET3
	const GOLDENRODCITY_ROCKET4
	const GOLDENRODCITY_ROCKET5
	const GOLDENRODCITY_ROCKET6

GoldenrodCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, GoldenrodCityFlypointCallback

GoldenrodCityFlypointCallback:
	setflag ENGINE_FLYPOINT_GOLDENROD
	setflag ENGINE_REACHED_GOLDENROD
	endcallback

GoldenrodCityPokefanMScript:
	jumptextfaceplayer GoldenrodCityPokefanMText

GoldenrodCityYoungster1Script:
	jumptextfaceplayer GoldenrodCityYoungster1Text

GoldenrodCityCooltrainerF1Script:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .ClearedRadioTower
	writetext GoldenrodCityCooltrainerF1Text
	waitbutton
	closetext
	end

.ClearedRadioTower:
	writetext GoldenrodCityCooltrainerF1Text_ClearedRadioTower
	waitbutton
	closetext
	end

GoldenrodCityCooltrainerF2Script:
	faceplayer
	opentext
	checkflag ENGINE_RADIO_CARD
	iftrue .GotRadioCard
	writetext GoldenrodCityCooltrainerF2Text
	waitbutton
	closetext
	end

.GotRadioCard:
	writetext GoldenrodCityCooltrainerF2Text_GotRadioCard
	waitbutton
	closetext
	end

GoldenrodCityYoungster2Script:
	jumptextfaceplayer GoldenrodCityYoungster2Text

GoldenrodCityLassScript:
	jumptextfaceplayer GoldenrodCityLassText

GoldenrodCityGrampsScript:
	jumptextfaceplayer GoldenrodCityGrampsText

GoldenrodCityRocketScoutScript:
	opentext
	writetext GoldenrodCityRocketScoutText1
	promptbutton
	faceplayer
	writetext GoldenrodCityRocketScoutText2
	waitbutton
	closetext
	turnobject GOLDENRODCITY_ROCKETSCOUT, UP
	end

GoldenrodCityRocket1Script:
	jumptextfaceplayer GoldenrodCityRocket1Text

GoldenrodCityRocket2Script:
	jumptextfaceplayer GoldenrodCityRocket2Text

GoldenrodCityRocket3Script:
	jumptextfaceplayer GoldenrodCityRocket3Text

GoldenrodCityRocket4Script:
	jumptextfaceplayer GoldenrodCityRocket4Text

GoldenrodCityRocket5Script:
	jumptextfaceplayer GoldenrodCityRocket5Text

GoldenrodCityRocket6Script:
	jumptextfaceplayer GoldenrodCityRocket6Text

GoldenrodCityStationSign:
	jumptext GoldenrodCityStationSignText

GoldenrodCityRadioTowerSign:
	jumptext GoldenrodCityRadioTowerSignText

GoldenrodDeptStoreSign:
	jumptext GoldenrodDeptStoreSignText

GoldenrodGymSign:
	jumptext GoldenrodGymSignText

GoldenrodCitySign:
	jumptext GoldenrodCitySignText

GoldenrodCityBikeShopSign:
	jumptext GoldenrodCityBikeShopSignText

GoldenrodCityGameCornerSign:
	jumptext GoldenrodCityGameCornerSignText

GoldenrodCityNameRaterSign:
	jumptext GoldenrodCityNameRaterSignText

GoldenrodCityUndergroundSignNorth:
	jumptext GoldenrodCityUndergroundSignNorthText

GoldenrodCityUndergroundSignSouth:
	jumptext GoldenrodCityUndergroundSignSouthText

GoldenrodCityPokecenterSign:
	jumpstd PokecenterSignScript

GoldenrodCityPokefanMText:
	text "<KOKO_WA>とう<GA>ふるくな<TTE>"
	line "たおれそう<NI>なったのを"
	cont "さいしん<NO>ラジオきょく<NI>したんだ"
	done

GoldenrodCityYoungster1Text:
	text "じてんしゃや<GA>あたらしく　できたが"
	line "どこ<NI>あるの？"
	cont "ぜんぜん　みあたらないよ"
	done

GoldenrodCityCooltrainerF1Text:
	text "あ<NO>くろずくめ<NO>ひと<TTE>"
	line "<ROCKET><NO>まねしてるのかしら？"
	cont "おかしな　ひと！"
	done

GoldenrodCityCooltrainerF1Text_ClearedRadioTower:
	text "あ<NO>くろずくめ<NO>ひと<TTE>"
	line "ほんと<NI><ROCKET>　だったの？"
	cont "いまでも　しんじられないわ"
	done

GoldenrodCityCooltrainerF2Text:
	text "コガネといえば　ラジオとう！"

	para "いまなら　キャンペーンで"
	line "ポケギアで　ラジオ<GA>きけるように"
	cont "してもらえるんです<TTE>！"
	done

GoldenrodCityCooltrainerF2Text_GotRadioCard:
	text "あら　あなた<NO>ポケギア"
	line "ラジオ<GA>きけるのね！"
	done

GoldenrodCityYoungster2Text:
	text "へへへ<⋯>"
	line "ひゃっかてん<NO>ちかそうこで"
	cont "かくれんぼ　してたら　おこられた"
	done

GoldenrodCityLassText:
	text "そこ<NO>いえで"
	line "#<NO>ニックネームを"
	cont "うらな<TTE>　もらえるわ"

	para "#<NI>いい　なまえを"
	line "つけなおす　ことだ<TTE>　できるのよ"
	done

GoldenrodCityGrampsText:
	text "しかしまあ　でっかい　まち　だな！"
	line "ひろすぎて　どこ<NI>なにがあるか"
	cont "ぜんぜん　わからんわい"
	done

GoldenrodCityRocketScoutText1:
	text "ここ<GA>ラジオとうか<⋯>"
	done

GoldenrodCityRocketScoutText2:
	text "なんだよ　おまえ　むこういけ！"
	done

GoldenrodCityRocket1Text:
	text "おら　うろちょろ　してんな！"
	line "じゃまだ　じゃま！"
	done

GoldenrodCityRocket2Text:
	text "ラジオとう<WO>のっと<TTE><⋯>"

	para "なんだ！"
	line "こどもに<WA>かんけい　ない！"
	done

GoldenrodCityRocket3Text:
	text "#？"
	line "かねもうけ<NO>どうぐ　だろ！"
	done

GoldenrodCityRocket4Text:
	text "もうすぐ　おれたち<NO>やぼうが<⋯>"
	line "これまで　ながかったなぁ<⋯>"
	done

GoldenrodCityRocket5Text:
	text "おらあ！"
	line "こども<GA>なんのようだ！？"
	cont "あっち　いけー！"
	done

GoldenrodCityRocket6Text:
	text "おまえも　<ROCKET>の"
	line "おそろしさ<WO>おもいしる<GA>いい"
	done

GoldenrodCityStationSignText:
	text "<KOKO_WA>コガネ　えき"
	done

GoldenrodCityRadioTowerSignText:
	text "コガネ　ラジオとう"
	done

GoldenrodDeptStoreSignText:
	text "#　グッズなら"
	line "なんでもそろう　コガネ　ひゃっかてん"
	done

GoldenrodGymSignText:
	text "コガネ　シティ　#ジム"
	line "リーダー　アカネ"
	cont "ダイナマイト　プリティ　ギャル！"
	done

GoldenrodCitySignText:
	text "<KOKO_WA>コガネ　シティ"
	line "ごうか　けんらん"
	cont "きんぴか　にぎやか　はなやかな　まち"
	done

GoldenrodCityBikeShopSignText:
	text "どんな　ところも　スイスイ！"

	para "じてんしゃ　<NO>ことなら"
	line "ここ　ミラクル　サイクルへ！"
	done

GoldenrodCityGameCornerSignText:
	text "みんな<NO>あそびば！"
	line "<⋯>　コガネ　ゲーム　コーナー"
	done

GoldenrodCityNameRaterSignText:
	text "<KOKO_WA>せいめいはんだんし　のいえ"
	line "#<NO>なまえ　うらないます"
	done

GoldenrodCityUndergroundSignNorthText:
	text "ここから　ちかつうろ"
	done

GoldenrodCityUndergroundSignSouthText:
	text "ここから　ちかつうろ"
	done

GoldenrodCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 24,  7, GOLDENROD_GYM, 1
	warp_event 29, 29, GOLDENROD_BIKE_SHOP, 1
	warp_event 31, 21, GOLDENROD_HAPPINESS_RATER, 1
	warp_event  5, 25, BILLS_FAMILYS_HOUSE, 1
	warp_event  9, 13, GOLDENROD_MAGNET_TRAIN_STATION, 2
	warp_event 33,  5, GOLDENROD_FLOWER_SHOP, 1
	warp_event 15, 27, GOLDENROD_POKECENTER_1F, 1
	warp_event 33,  9, GOLDENROD_PP_SPEECH_HOUSE, 1
	warp_event 15,  7, GOLDENROD_NAME_RATER, 1
	warp_event 24, 27, GOLDENROD_DEPT_STORE_1F, 1
	warp_event 14, 21, GOLDENROD_GAME_CORNER, 1
	warp_event  5, 15, RADIO_TOWER_1F, 1
	warp_event 19,  1, ROUTE_35_GOLDENROD_GATE, 3
	warp_event  9,  5, GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES, 8
	warp_event 11, 29, GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES, 5

	def_coord_events

	def_bg_events
	bg_event 10, 14, BGEVENT_READ, GoldenrodCityStationSign
	bg_event  4, 17, BGEVENT_READ, GoldenrodCityRadioTowerSign
	bg_event 26, 27, BGEVENT_READ, GoldenrodDeptStoreSign
	bg_event 26,  9, BGEVENT_READ, GoldenrodGymSign
	bg_event 22, 18, BGEVENT_READ, GoldenrodCitySign
	bg_event 28, 30, BGEVENT_READ, GoldenrodCityBikeShopSign
	bg_event 16, 22, BGEVENT_READ, GoldenrodCityGameCornerSign
	bg_event 12,  7, BGEVENT_READ, GoldenrodCityNameRaterSign
	bg_event  8,  6, BGEVENT_READ, GoldenrodCityUndergroundSignNorth
	bg_event 12, 30, BGEVENT_READ, GoldenrodCityUndergroundSignSouth
	bg_event 16, 27, BGEVENT_READ, GoldenrodCityPokecenterSign

	def_object_events
	object_event  7, 18, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityPokefanMScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 30, 17, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityYoungster1Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 12, 16, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodCityCooltrainerF1Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 20, 26, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityCooltrainerF2Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 19, 17, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodCityYoungster2Script, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 17, 10, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodCityLassScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 11, 27, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityGrampsScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event  4, 16, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityRocketScoutScript, EVENT_GOLDENROD_CITY_ROCKET_SCOUT
	object_event 28, 20, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityRocket1Script, EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	object_event  8, 15, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityRocket2Script, EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	object_event 16, 23, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityRocket3Script, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 29, 20, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityRocket4Script, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 29,  7, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityRocket5Script, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 30, 10, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodCityRocket6Script, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
