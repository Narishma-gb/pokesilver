	object_const_def
	const ECRUTEAKCITY_GRAMPS1
	const ECRUTEAKCITY_GRAMPS2
	const ECRUTEAKCITY_LASS1
	const ECRUTEAKCITY_LASS2
	const ECRUTEAKCITY_FISHER
	const ECRUTEAKCITY_YOUNGSTER

EcruteakCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, EcruteakCityFlypointCallback

EcruteakCityFlypointCallback:
	setflag ENGINE_FLYPOINT_ECRUTEAK
	endcallback

EcruteakCityGramps1Script:
	jumptextfaceplayer EcruteakCityGramps1Text

EcruteakCityGramps2Script:
	jumptextfaceplayer EcruteakCityGramps2Text

EcruteakCityLass1Script:
	jumptextfaceplayer EcruteakCityLass1Text

EcruteakCityLass2Script:
	faceplayer
	opentext
	checkevent EVENT_RELEASED_THE_BEASTS
	iftrue .ReleasedBeasts
	writetext EcruteakCityLass2Text
	waitbutton
	closetext
	end

.ReleasedBeasts:
	writetext EcruteakCityLass2Text_ReleasedBeasts
	waitbutton
	closetext
	end

EcruteakCityFisherScript:
	faceplayer
	opentext
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue .JasmineReturned
	writetext EcruteakCityFisherText
	waitbutton
	closetext
	end

.JasmineReturned:
	writetext EcruteakCityFisherText_JasmineReturned
	waitbutton
	closetext
	end

EcruteakCityYoungsterScript:
	jumptextfaceplayer EcruteakCityYoungsterText

EcruteakCitySign:
	jumptext EcruteakCitySignText

TinTowerSign:
	jumptext TinTowerSignText

EcruteakGymSign:
	jumptext EcruteakGymSignText

EcruteakDanceTheaterSign:
	jumptext EcruteakDanceTheaterSignText

BurnedTowerSign:
	jumptext BurnedTowerSignText

EcruteakCityPokecenterSign:
	jumpstd PokecenterSignScript

EcruteakCityMartSign:
	jumpstd MartSignScript

EcruteakCityHiddenHyperPotion:
	hiddenitem HYPER_POTION, EVENT_ECRUTEAK_CITY_HIDDEN_HYPER_POTION

UnusedMissingDaughterText: ; unreferenced
	text "おろおろ<⋯>"
	line "わし<NO>むすめ<GA>いなくなった"

	para "まさか"
	line "やけた　とう<NI>いったのか？"

	para "あそこ<WA>かみかくし<NI>あうから"
	line "ちかづくな<TTE>　いったあったのに"
	cont "どうしたら　いいものか<⋯>"
	done

EcruteakCityGramps1Text:
	text "エンジュに<WA>にしと　ひがしに"
	line "２つ<NO>とう<GA>あったらしいが<⋯>"
	done

EcruteakCityGramps2Text:
	text "ほっほう　おわかいの"
	line "まいこさん<NO>おどり<WA>おぼえたか"

	para "いま　おどりば<NI>いくと"
	line "へんな　だんなさんから"
	cont "いいもの<GA>もらえる　らしいぞ"
	done

EcruteakCityLass1Text:
	text "これから　おどりばで"
	line "おどり<NO>れんしゅう　するの"
	cont "よかったら　あなたも　どう？"
	done

EcruteakCityLass2Text:
	text "ここ<NI>あった　とう<⋯>"
	line "ほんとう<WA>もっと　たかかったけど"
	cont "かじで　やけて　しまったんだ<TTE>"
	done

EcruteakCityLass2Text_ReleasedBeasts:
	text "３びき<NO>おおきな　#"
	line "あちこち<NI>はしりさ<TTE>いったわ"
	cont "なんだったのかしら？"
	done

EcruteakCityFisherText:
	text "きいた　はなし　だけど"
	line "アサギシティ<NO>とうだい<⋯>"

	para "くらやみ<WO>てらす　#が"
	line "ばてちゃ<TTE>　たいへん　らしいな"
	done

EcruteakCityFisherText_JasmineReturned:
	text "アサギ<NO>とうだい#"
	line "びょうき　なおったんだ<TTE>"
	cont "これで　よるも　ふね<GA>だせる<TTE>よ"
	done

EcruteakCityYoungsterText:
	text "いかりのみずうみで"
	line "#<GA>あばれまわ<TTE>るんだ<TTE>"
	cont "い<TTE>みたいなあ"
	done

EcruteakCitySignText:
	text "<KOKO_WA>エンジュ　シティ"
	line "むかしと　いまが"
	cont "どうじ<NI>ながれる　れきし<NO>まち"
	done

TinTowerSignText:
	text "スズ<NO>とう"

	para "でんせつ<NO>#<GA>まいおりると"
	line "つたえられて　います"
	done

EcruteakGymSignText:
	text "エンジュ　シティ　#ジム"
	line "リーダー　マツバ"
	cont "せんりがん<WO>もつ　しゅげんじゃ"
	done

EcruteakDanceTheaterSignText:
	text "エンジュ　おどりば"
	line "ただしい　よびかた<WA>かぶれんじょう"
	done

BurnedTowerSignText:
	text "やけた　とう"

	para "なぞ<NO>おおかじで　やけました"
	line "きけんなので　ちかよらないでください"
	done

EcruteakCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 35, 26, ROUTE_42_ECRUTEAK_GATE, 1
	warp_event 35, 27, ROUTE_42_ECRUTEAK_GATE, 2
	warp_event 18, 11, ECRUTEAK_TIN_TOWER_ENTRANCE, 1
	warp_event 20,  2, ECRUTEAK_TIN_TOWER_BACK_ENTRANCE, 1
	warp_event 20,  3, ECRUTEAK_TIN_TOWER_BACK_ENTRANCE, 2
	warp_event 23, 27, ECRUTEAK_POKECENTER_1F, 1
	warp_event  5, 21, ECRUTEAK_LUGIA_SPEECH_HOUSE, 1
	warp_event 23, 21, DANCE_THEATER, 1
	warp_event 29, 21, ECRUTEAK_MART, 2
	warp_event  6, 27, ECRUTEAK_GYM, 1
	warp_event 13, 27, ECRUTEAK_ITEMFINDER_HOUSE, 1
	warp_event 37,  7, TIN_TOWER_1F, 1
	warp_event  5,  5, BURNED_TOWER_1F, 1
	warp_event  0, 18, ROUTE_38_ECRUTEAK_GATE, 3
	warp_event  0, 19, ROUTE_38_ECRUTEAK_GATE, 4

	def_coord_events

	def_bg_events
	bg_event 15, 21, BGEVENT_READ, EcruteakCitySign
	bg_event 38, 10, BGEVENT_READ, TinTowerSign
	bg_event  8, 28, BGEVENT_READ, EcruteakGymSign
	bg_event 21, 21, BGEVENT_READ, EcruteakDanceTheaterSign
	bg_event  2, 10, BGEVENT_READ, BurnedTowerSign
	bg_event 24, 27, BGEVENT_READ, EcruteakCityPokecenterSign
	bg_event 30, 21, BGEVENT_READ, EcruteakCityMartSign
	bg_event 23, 14, BGEVENT_ITEM, EcruteakCityHiddenHyperPotion

	def_object_events
	object_event 18, 15, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakCityGramps1Script, -1
	object_event 20, 21, SPRITE_GRAMPS, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakCityGramps2Script, -1
	object_event 21, 29, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, EcruteakCityLass1Script, -1
	object_event  3,  9, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakCityLass2Script, -1
	object_event  9, 22, SPRITE_FISHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, EcruteakCityFisherScript, -1
	object_event 10, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakCityYoungsterScript, -1
