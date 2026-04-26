	object_const_def
	const MANIASHOUSE_ROCKER

ManiasHouse_MapScripts:
	def_scene_scripts

	def_callbacks

ManiaScript:
	faceplayer
	opentext
	checkevent EVENT_MANIA_TOOK_SHUCKIE_OR_LET_YOU_KEEP_HIM
	iftrue .default_postevent
	checkevent EVENT_GOT_SHUCKIE
	iftrue .alreadyhaveshuckie
	writetext ManiaText_AskLookAfterShuckle
	yesorno
	iffalse .refusetotakeshuckie
	special GiveShuckle
	iffalse .partyfull
	writetext ManiaText_TakeCareOfShuckle
	promptbutton
	waitsfx
	writetext ManiaText_GotShuckle
	playsound SFX_KEY_ITEM
	waitsfx
	closetext
	setevent EVENT_GOT_SHUCKIE
	end

.alreadyhaveshuckie
	checkflag ENGINE_GOT_SHUCKIE_TODAY
	iffalse .returnshuckie
	writetext ManiaText_TakeCareOfShuckle
	waitbutton
	closetext
	end

.partyfull
	writetext ManiaText_PartyFull
	waitbutton
	closetext
	end

.refusetotakeshuckie
	writetext ManiaText_IfHeComesBack
	waitbutton
	closetext
	end

.returnshuckie
	writetext ManiaText_CanIHaveMyMonBack
	yesorno
	iffalse .refused
	special ReturnShuckie
	ifequal SHUCKIE_WRONG_MON, .wrong
	ifequal SHUCKIE_REFUSED, .refused
	ifequal SHUCKIE_HAPPY, .superhappy
	ifequal SHUCKIE_FAINTED, .default_postevent
	; SHUCKIE_RETURNED
	writetext ManiaText_ThankYou
	waitbutton
	closetext
	setevent EVENT_MANIA_TOOK_SHUCKIE_OR_LET_YOU_KEEP_HIM
	end

.wrong
	writetext ManiaText_ShuckleNotThere
	waitbutton
	closetext
	end

.superhappy
	writetext ManiaText_ShuckleLikesYou
	waitbutton
	closetext
	setevent EVENT_MANIA_TOOK_SHUCKIE_OR_LET_YOU_KEEP_HIM
	end

.refused
	writetext ManiaText_SameAsBeingRobbed
	waitbutton
	closetext
	end

.nothingleft ; unreferenced
	writetext ManiaText_ShuckleIsYourLastMon
	waitbutton
	closetext
	end

.default_postevent
	writetext ManiaText_HappinessSpeech
	waitbutton
	closetext
	end

ManiasHouseUnusedBookshelf: ; unreferenced
	jumpstd PictureBookshelfScript

ManiaText_AskLookAfterShuckle:
	text "な　なんてことだ<⋯>"

	para "きみと　おなじくらい<NO>としごろで"
	line "めつき<GA>するどくて"
	cont "かみのけ　ながくて"
	cont "なんだか　こわそうな　しょうねんに"
	cont "だいじな　#<WO>とられたよ！"

	para "てもと<NI>１ぴき　のこ<TTE>いるけど"
	line "また　おそわれたら　どうしよう<⋯>"

	para "きみ　つよそうだな"
	line "しばらく　#　あずか<TTE>よ！"
	done

ManiaText_TakeCareOfShuckle:
	text "じゃ　じゃあ　たのむ！"
	line "だいじ<NI>してや<TTE>くれよ"
	done

ManiaText_GotShuckle:
	text "<PLAYER><WA>マニアから"
	line "#<WO>あずかっ<TA!>"
	done

ManiaText_PartyFull:
	text "#　いっぱいだよ"
	done

ManiaText_IfHeComesBack:
	text "そ　そんなあ"
	line "また　おそわれたら　どうしよう"
	done

ManiaText_CanIHaveMyMonBack:
	text "ぼく<NO>#　げんき？"

	para "もう　おそわれそう<NI>ないし"
	line "#　かえしてほしいんだ"
	done

ManiaText_ThankYou:
	text "ありがとう！"
	done

ManiaText_ShuckleNotThere:
	text "ぼく<NO>#　いないじゃん"
	done

ManiaText_ShuckleLikesYou:
	text "ぼく<NO>#"
	line "きみ<NI>なついちゃ<TTE>るな"

	para "わかっ<TA!>　#<WA>ゆずる！"
	line "そのかわり　だいじ<NI>してくれよ"
	done

ManiaText_SameAsBeingRobbed:
	text "そ　そんなあ"
	line "だったら　おそわれたのと　おなじだ"
	done

ManiaText_HappinessSpeech:
	text "#にと<TTE>　しあわせ　なのは"
	line "だいじ<NI>してくれる　ひとと"
	cont "いっしょ<NI>いること　じゃないかな"
	done

ManiaText_ShuckleIsYourLastMon:
	text "ボク<GA>そ<NO>#<WO>うけとると"
	; bug: missing "line" character
	db   "キミ<WA>たたかえなく　なっちゃうね！"
	done

ManiasHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CIANWOOD_CITY, 1
	warp_event  3,  7, CIANWOOD_CITY, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ManiaScript, -1
