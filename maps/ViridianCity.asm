	object_const_def
	const VIRIDIANCITY_GRAMPS1
	const VIRIDIANCITY_GRAMPS2
	const VIRIDIANCITY_FISHER
	const VIRIDIANCITY_YOUNGSTER

ViridianCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, ViridianCityFlypointCallback

ViridianCityFlypointCallback:
	setflag ENGINE_FLYPOINT_VIRIDIAN
	endcallback

ViridianCityCoffeeGramps:
	faceplayer
	opentext
	writetext ViridianCityCoffeeGrampsQuestionText
	yesorno
	iffalse .no
	writetext ViridianCityCoffeeGrampsBelievedText
	waitbutton
	closetext
	end

.no:
	writetext ViridianCityCoffeeGrampsDoubtedText
	waitbutton
	closetext
	end

ViridianCityGrampsNearGym:
	faceplayer
	opentext
	checkevent EVENT_BLUE_IN_CINNABAR
	iftrue .BlueReturned
	writetext ViridianCityGrampsNearGymText
	waitbutton
	closetext
	end

.BlueReturned:
	writetext ViridianCityGrampsNearGymBlueReturnedText
	waitbutton
	closetext
	end

ViridianCityDreamEaterFisher:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM42_DREAM_EATER
	iftrue .GotDreamEater
	writetext ViridianCityDreamEaterFisherText
	promptbutton
	verbosegiveitem TM_DREAM_EATER
	iffalse .NoRoomForDreamEater
	setevent EVENT_GOT_TM42_DREAM_EATER
.GotDreamEater:
	writetext ViridianCityDreamEaterFisherGotDreamEaterText
	waitbutton
.NoRoomForDreamEater:
	closetext
	end

ViridianCityYoungsterScript:
	jumptextfaceplayer ViridianCityYoungsterText

ViridianCitySign:
	jumptext ViridianCitySignText

ViridianGymSign:
	jumptext ViridianGymSignText

ViridianCityWelcomeSign:
	jumptext ViridianCityWelcomeSignText

TrainerHouseSign:
	jumptext TrainerHouseSignText

ViridianCityPokecenterSign:
	jumpstd PokecenterSignScript

ViridianCityMartSign:
	jumpstd MartSignScript

ViridianCityCoffeeGrampsQuestionText:
	text "ういーっ！　ひっく<⋯>　まちやがれ！"
	line "わし<NO>はなし<WO>きけ！"

	para "こうみえても　むかしは"
	line "#<WO>つかまえるのが"
	cont "うまかったんじゃ！"

	para "しんじて　くれるかの？"
	done

ViridianCityCoffeeGrampsBelievedText:
	text "そうじゃろ　そうじゃろ"
	line "うんうん"
	done

ViridianCityCoffeeGrampsDoubtedText:
	text "なに<WO>こわっぱ　が！"

	para "わし<GA>もうすこし　わかけりゃ"
	line "おてほん<WO>みせて　やったのにな"
	done

ViridianCityGrampsNearGymText:
	text "さいきんまで　こ<NO>ジムには"
	line "リーダー<GA>いなかったのじゃ"

	para "さいきん　マサラ<NO>わかものが"
	line "リーダー<NI>なった　そうじゃが"
	cont "<⋯>はて　いま　るす　じゃの"
	done

ViridianCityGrampsNearGymBlueReturnedText:
	text "リーダーと　たたかうのかい？"
	line "がんばりなさいよ"
	done

ViridianCityDreamEaterFisherText:
	text "ふあー！"
	line "ひなたぼっこ　してて"
	cont "ねむ<TTE>　しまっ<TA!>"

	para "<⋯>　へんな　ゆめ<WO>みた"
	line "スリープ<GA>ゆめ<WO>く<TTE>い<TA!>"
	cont "<⋯>およ？　ぼく　いつのまに"
	cont "<TM>　も<TTE>るけど？"

	para "うーん"
	line "きみ<GA>わるい！"
	cont "これ　きみ<NI>あげる！"
	done

ViridianCityDreamEaterFisherGotDreamEaterText:
	text "<TM>４２<NO>なかみは<⋯>"
	line "ゆめくい　だよ<⋯>"
	cont "<⋯>　ぐー<⋯>"
	done

ViridianCityYoungsterText:
	text "トキワのもりには"
	line "みえない　どうぐ<GA>いっぱい"
	cont "おちている<TTE>　はなし　だよ！"
	done

ViridianCitySignText:
	text "<KOKO_WA>トキワ　シティ"
	line "トキワ<WA>みどり　えいえんのいろ"
	done

ViridianGymSignText:
	text "トキワ　シティ　#ジム"
	line "リーダー　<⋯>"
	cont "あと<WA>もじ<GA>よめない！"
	done

ViridianCityWelcomeSignText:
	text "セキエイこうげん　いりぐち　<NO>まち"
	line "トキワ　シティへ　ようこそ！"
	done

TrainerHouseSignText:
	text "<TRAINER>　ハウス"
	line "つわもの<NO>つどう　ばしょ"
	done

ViridianCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 32,  7, VIRIDIAN_GYM, 1
	warp_event 21,  9, VIRIDIAN_NICKNAME_SPEECH_HOUSE, 1
	warp_event 23, 15, TRAINER_HOUSE_1F, 1
	warp_event 29, 19, VIRIDIAN_MART, 2
	warp_event 23, 25, VIRIDIAN_POKECENTER_1F, 1

	def_coord_events

	def_bg_events
	bg_event 17, 17, BGEVENT_READ, ViridianCitySign
	bg_event 27,  7, BGEVENT_READ, ViridianGymSign
	bg_event 19,  1, BGEVENT_READ, ViridianCityWelcomeSign
	bg_event 21, 15, BGEVENT_READ, TrainerHouseSign
	bg_event 24, 25, BGEVENT_READ, ViridianCityPokecenterSign
	bg_event 30, 19, BGEVENT_READ, ViridianCityMartSign

	def_object_events
	object_event 18,  5, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianCityCoffeeGramps, -1
	object_event 30,  8, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ViridianCityGrampsNearGym, -1
	object_event  6, 23, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ViridianCityDreamEaterFisher, -1
	object_event 17, 21, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 3, 3, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ViridianCityYoungsterScript, -1
