	object_const_def
	const TRAINERHOUSE1F_RECEPTIONIST
	const TRAINERHOUSE1F_COOLTRAINER_M
	const TRAINERHOUSE1F_COOLTRAINER_F
	const TRAINERHOUSE1F_YOUNGSTER
	const TRAINERHOUSE1F_GENTLEMAN

TrainerHouse1F_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerHouse1FReceptionistScript:
	jumptextfaceplayer TrainerHouse1FReceptionistText

TrainerHouse1FCooltrainerMScript:
	jumptextfaceplayer TrainerHouse1FCooltrainerMText

TrainerHouse1FCooltrainerFScript:
	jumptextfaceplayer TrainerHouse1FCooltrainerFText

TrainerHouse1FYoungsterScript:
	jumptextfaceplayer TrainerHouse1FYoungsterText

TrainerHouse1FGentlemanScript:
	jumptextfaceplayer TrainerHouse1FGentlemanText

TrainerHouseSign1:
	jumptext TrainerHouseSign1Text

TrainerHouseSign2:
	jumptext TrainerHouseSign2Text

TrainerHouseIllegibleBook:
	jumptext TrainerHouseIllegibleText

TrainerHouse1FReceptionistText:
	text "<KOKO_WA><TRAINER>　ハウス"
	line "トキワ　シティ<NO>しん　めいしょ！"
	cont "<TRAINER><NO>しゃこうのば　です！"

	para "ちか<NO>れんしゅうじょうで"
	line "たいせんも　できますよ！"
	done

TrainerHouse1FCooltrainerMText:
	text "トキワ<WA>セキエイこうげんに"
	line "いちばん　ちかい　まち"

	para "セキエイこうげん<WO>めざす"
	line "<TRAINER><GA>たくさん　たちよるから"
	cont "こ<NO>しせつ<GA>できたのさ"
	done

TrainerHouse1FCooltrainerFText:
	text "ちか<NO>へやで"
	line "れんしゅう　じあい<WO>してるの"

	para "ジョウト<NO><TRAINER><NO>じつりょく"
	line "みせて　ほしいわ！"
	done

TrainerHouse1FYoungsterText:
	text "いろんな　まちへ　い<TTE>"
	line "いろんな　ひとと　たたかわないと"
	cont "チャンピオン<NI>なれない　かなあ"

	para "マサラ<NO>チャンピオンも"
	line "カントー　ぜんぶ<NO>まちを"
	cont "たびして　あるいたんだ<TTE>！"
	done

TrainerHouse1FGentlemanText:
	text "ふー<⋯>"
	line "#　しょうぶ<NI>つかれたから"
	cont "ひとやすみ<⋯>"
	done

TrainerHouseSign1Text:
	text "ちか　トレーニングじょう"
	line "れんしゅう　じあい<WO>かいさい！"
	cont "うでじまん<NO><TRAINER>は"
	cont "ふる<TTE>　ごさんか　ください！"
	done

TrainerHouseSign2Text:
	text "ルール　きせい<WA>ありません！"
	line "どうろ　で<NO>フリーバトルと"
	cont "おなじ　です！"
	done

TrainerHouseIllegibleText:
	text "<⋯>　な<NI>なに"
	line "たいせん　こうりゃく　メモ<⋯>？"

	para "イワーク<GA>あるいた　あと"
	line "みたいな　もじで　よめない<⋯>！"
	done

TrainerHouse1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2, 13, VIRIDIAN_CITY, 3
	warp_event  3, 13, VIRIDIAN_CITY, 3
	warp_event  8,  2, TRAINER_HOUSE_B1F, 1

	def_coord_events

	def_bg_events
	bg_event  5,  0, BGEVENT_READ, TrainerHouseSign1
	bg_event  7,  0, BGEVENT_READ, TrainerHouseSign2
	bg_event  7, 10, BGEVENT_READ, TrainerHouseIllegibleBook

	def_object_events
	object_event  0, 11, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TrainerHouse1FReceptionistScript, -1
	object_event  7, 11, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TrainerHouse1FCooltrainerMScript, -1
	object_event  6,  2, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TrainerHouse1FCooltrainerFScript, -1
	object_event  4,  8, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TrainerHouse1FYoungsterScript, -1
	object_event  2,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TrainerHouse1FGentlemanScript, -1
