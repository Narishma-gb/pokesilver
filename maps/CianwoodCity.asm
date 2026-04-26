	object_const_def
	const CIANWOODCITY_STANDING_YOUNGSTER
	const CIANWOODCITY_POKEFAN_M
	const CIANWOODCITY_LASS
	const CIANWOODCITY_ROCK1
	const CIANWOODCITY_ROCK2
	const CIANWOODCITY_ROCK3
	const CIANWOODCITY_ROCK4
	const CIANWOODCITY_ROCK5
	const CIANWOODCITY_ROCK6
	const CIANWOODCITY_POKEFAN_F

CianwoodCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, CianwoodCityFlypointCallback

CianwoodCityFlypointCallback:
	setflag ENGINE_FLYPOINT_CIANWOOD
	endcallback

CianwoodCityChucksWife:
	faceplayer
	opentext
	checkevent EVENT_GOT_HM02_FLY
	iftrue .GotFly
	writetext ChucksWifeEasierToFlyText
	promptbutton
	checkevent EVENT_BEAT_CHUCK
	iftrue .BeatChuck
	writetext ChucksWifeBeatChuckText
	waitbutton
	closetext
	end

.BeatChuck:
	writetext ChucksWifeGiveHMText
	promptbutton
	verbosegiveitem HM_FLY
	iffalse .Done
	setevent EVENT_GOT_HM02_FLY
	writetext ChucksWifeFlySpeechText
	promptbutton
.GotFly:
	writetext ChucksWifeChubbyText
	waitbutton
.Done:
	closetext
	end

CianwoodCityYoungster:
	jumptextfaceplayer CianwoodCityYoungsterText

CianwoodCityPokefanM:
	jumptextfaceplayer CianwoodCityPokefanMText

CianwoodCityLass:
	jumptextfaceplayer CianwoodCityLassText

CianwoodCityUnusedScript: ; unreferenced
	jumptextfaceplayer CianwoodCityUnusedText

CianwoodCitySign:
	jumptext CianwoodCitySignText

CianwoodGymSign:
	jumptext CianwoodGymSignText

CianwoodPharmacySign:
	jumptext CianwoodPharmacySignText

CianwoodPhotoStudioSign:
	jumptext CianwoodPhotoStudioSignText

CianwoodPokecenterSign:
	jumpstd PokecenterSignScript

CianwoodCityRock:
	jumpstd SmashRockScript

CianwoodCityHiddenRevive:
	hiddenitem REVIVE, EVENT_CIANWOOD_CITY_HIDDEN_REVIVE

CianwoodCityHiddenMaxEther:
	hiddenitem MAX_ETHER, EVENT_CIANWOOD_CITY_HIDDEN_MAX_ETHER

ChucksWifeEasierToFlyText:
	text "あ<NO>うみ<WO>わた<TTE>きたの？"
	line "それ<WA>たいへん　だったでしょ"

	para "#<GA>そら<WO>とぶ　わざを"
	line "おぼえていれば　らく　なんだけど<⋯>"
	done

ChucksWifeBeatChuckText:
	text "ジムバッジ<GA>ないと　つかえないのよ"
	line "あなた　このまち<NO>ジムリーダーに"
	cont "かったら　また　いらっしゃい"
	cont "いいもの<WO>あげるから"
	done

ChucksWifeGiveHMText:
	text "それ<WA>タンバ<NO>ジムバッジ！"

	para "じゃあ　こ<NO>ひでんマシンを"
	line "も<TTE>いくと　いいわ"
	done

ChucksWifeFlySpeechText:
	text "そらをとぶ<WO>おぼえさせると"
	line "いままで　いった　ばしょに"
	cont "いっしゅんで　いけるよう<NI>なるわ"
	done

ChucksWifeChubbyText:
	text "ふふふ　うち<NO>だんなったら"
	line "あなた<NI>まけたから　とっくんね"

	para "いいのよ　さいきん"
	line "おなか　たるんできたから"
	done

CianwoodCityYoungsterText:
	text "そらをとぶ　わざ<GA>つかえると"
	line "アサギシティにも　すぐ　いけるよね！"
	done

CianwoodCityPokefanMText:
	text "まち<NO>きたにある　いわ<WO>くだくと"
	line "いろんな　もの<GA>でてくるんだわ"

	para "いわ<WO>こわしたきゃ"
	line "#<NI>いわくだきを"
	cont "させりゃあ　いいんだわ"
	done

CianwoodCityLassText:
	text "ジムリーダー<NO>シジマさん"
	line "かくとう#　きたえるのに"
	cont "じぶん<GA>あいて　してあげるのよ"
	done

CianwoodCityUnusedText:
	text "ここと　アサギ<NO>あいだに"
	line "いくつか　しま<GA>あったでしょ"

	para "なかに<WA>うみのかみさまが"
	line "すんでいる<TTE>　はなし　なの"
	done

CianwoodCitySignText:
	text "<KOKO_WA>タンバ　シティ"
	line "あらなみ<NI>かこまれた　うみのまち"
	done

CianwoodGymSignText:
	text "タンバ　シティ　#ジム"
	line "リーダー　シジマ"
	cont "うなる　こぶしで　かたる　おとこ"
	done

CianwoodPharmacySignText:
	text "そうぎょう　５００ねん"
	line "タンバ　くすりや"
	cont "くすり<NO>そうだん　ま<TTE>おります"
	done

CianwoodPhotoStudioSignText:
	text "タンバ　しゃしんオヤジ"
	line "たび<NO>きねん<NI>１まい　どうぞ"
	done

CianwoodCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 17, 41, MANIAS_HOUSE, 1
	warp_event  8, 43, CIANWOOD_GYM, 1
	warp_event 23, 43, CIANWOOD_POKECENTER_1F, 1
	warp_event 15, 47, CIANWOOD_PHARMACY, 1
	warp_event  9, 31, CIANWOOD_PHOTO_STUDIO, 1
	warp_event 15, 37, CIANWOOD_LUGIA_SPEECH_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 20, 34, BGEVENT_READ, CianwoodCitySign
	bg_event  7, 45, BGEVENT_READ, CianwoodGymSign
	bg_event 24, 43, BGEVENT_READ, CianwoodPokecenterSign
	bg_event 19, 47, BGEVENT_READ, CianwoodPharmacySign
	bg_event  8, 32, BGEVENT_READ, CianwoodPhotoStudioSign
	bg_event  8, 16, BGEVENT_ITEM, CianwoodCityHiddenRevive
	bg_event  5, 29, BGEVENT_ITEM, CianwoodCityHiddenMaxEther

	def_object_events
	object_event 21, 37, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CianwoodCityYoungster, -1
	object_event 17, 31, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityPokefanM, -1
	object_event 14, 42, SPRITE_LASS, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityLass, -1
	object_event  8, 16, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityRock, -1
	object_event 11, 15, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityRock, -1
	object_event  6, 24, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityRock, -1
	object_event  5, 29, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityRock, -1
	object_event 10, 27, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityRock, -1
	object_event  7, 17, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityRock, -1
	object_event 10, 46, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityChucksWife, -1
