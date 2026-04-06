	object_const_def
	const ECRUTEAKITEMFINDERHOUSE_COOLTRAINER_M
	const ECRUTEAKITEMFINDERHOUSE_POKEDEX

EcruteakItemfinderHouse_MapScripts:
	def_scene_scripts

	def_callbacks

EcruteakItemfinderGuy:
	faceplayer
	opentext
	checkevent EVENT_GOT_ITEMFINDER
	iftrue .itemfinder
	writetext EcruteakItemfinderAdventureText
	yesorno
	iffalse .no
	writetext EcruteakItemfinderTrueSpiritText
	promptbutton
	verbosegiveitem ITEMFINDER
	setevent EVENT_GOT_ITEMFINDER
.itemfinder:
	writetext ItemfinderExplanationText
	waitbutton
	closetext
	end

.no:
	writetext EcruteakItemfinderToEachHisOwnText
	waitbutton
	closetext
	end

EcruteakHistoryBook:
	opentext
	writetext EcruteakHistoryBookText
	yesorno
	iftrue .ReadBook
	closetext
	end

.ReadBook:
	writetext EcruteakTwoTowersText
	yesorno
	iftrue .KeepReading
	closetext
	end

.KeepReading:
	writetext EcruteakThreeMonText
	waitbutton
	closetext
	end

ItemFinderHouseRadio:
	jumpstd Radio2Script

EcruteakItemfinderAdventureText:
	text "ほう！　#と　いっしょに"
	line "たんけん<NO>たび<WO>しているのか"

	para "たんけんと　いえば　たからさがし！"
	line "そう　おもうだろ？"
	done

EcruteakItemfinderTrueSpiritText:
	text "おお！"
	line "おとこ<NO>ロマン<GA>わか<TTE>るな"

	para "きにいっ<TA!>"
	line "これ<WO>も<TTE>いきな！"
	done

ItemfinderExplanationText:
	text "みえなくても　あちこちに"
	line "どうぐ<GA>おちている"

	para "ダウジングマシン<WO>つかうと"
	line "きみ<NO>ちかくに"
	cont "どうぐ<GA>おちているか　どうか"
	cont "しらべること<GA>できる"

	para "ただし　どこ<NI>おちているかまでは"
	line "わからないから　じぶんで　さがせよ"

	para "そうだ！"
	line "エンジュ<NO>やけた　とう　にも"
	cont "たから<GA>あるという　ウワサだな"
	done

EcruteakItemfinderToEachHisOwnText:
	text "<⋯>　そうか"
	line "まあ　ひと　それぞれだ"
	done

EcruteakHistoryBookText:
	text "エンジュ<NO>れきし<⋯>"

	para "よんでみますか？"
	done

EcruteakTwoTowersText:
	text "エンジュに<WA>２つ<NO>とう<GA>あり"
	line "それぞれ　#が"
	cont "まいおりる　ばしょ　でした"

	para "です<GA>とう<GA>もえていらい"
	line "#<WO>みかけなくなった<⋯>"
	cont "そう　つたえられています"

	para "つづき<WO>よみますか？"
	done

EcruteakThreeMonText:
	text "また　エンジュには"
	line "まち<NO>まわり<WO>かけめぐる"
	cont "#たち<GA>いました"

	para "それぞれ"
	line "かみなり　ほのお　みず　の"
	cont "うまれかわり　と　いわれてました"

	para "です<GA>じぶんたちの"
	line "つよすぎる　ちから<WO>もてあまし"
	cont "あちこち<NO>くさむらを"
	cont "かぜのよう<NI>かけぬけていた<⋯>"
	cont "そう　つたえられています"
	done

EcruteakItemfinderHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 11
	warp_event  4,  7, ECRUTEAK_CITY, 11

	def_coord_events

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, ItemFinderHouseRadio

	def_object_events
	object_event  2,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakItemfinderGuy, -1
	object_event  3,  3, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakHistoryBook, -1
