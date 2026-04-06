	object_const_def
	const ROUTE20_SWIMMER_GIRL1
	const ROUTE20_SWIMMER_GIRL2
	const ROUTE20_SWIMMER_GUY

Route20_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route20ClearRocksCallback

Route20ClearRocksCallback:
	setevent EVENT_CINNABAR_ROCKS_CLEARED
	endcallback

TrainerSwimmerfNicole:
	trainer SWIMMERF, NICOLE, EVENT_BEAT_SWIMMERF_NICOLE, SwimmerfNicoleSeenText, SwimmerfNicoleBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmerfNicoleAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmerfLori:
	trainer SWIMMERF, LORI, EVENT_BEAT_SWIMMERF_LORI, SwimmerfLoriSeenText, SwimmerfLoriBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmerfLoriAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmermCameron:
	trainer SWIMMERM, CAMERON, EVENT_BEAT_SWIMMERM_CAMERON, SwimmermCameronSeenText, SwimmermCameronBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmermCameronAfterBattleText
	waitbutton
	closetext
	end

CinnabarGymSign:
	jumptext CinnabarGymSignText

SwimmerfNicoleSeenText:
	text "みず<NO>なか<NI>はいると"
	line "からだ<GA>かるくなった　き<GA>するわ"
	done

SwimmerfNicoleBeatenText:
	text "いやーん！"
	done

SwimmerfNicoleAfterBattleText:
	text "すいえい<WA>ぜんしん<WO>つかうから"
	line "と<TTE>も　けんこう<NI>いいのよ！"
	done

SwimmerfLoriSeenText:
	text "すごい　バッジ<NO>かずね！"
	line "しょうぶ　しましょう！"
	done

SwimmerfLoriBeatenText:
	text "やだー！"
	done

SwimmerfLoriAfterBattleText:
	text "みずで　つかう　ひでんわざは"
	line "なみのり　だけじゃ　ないのよね"
	done

SwimmermCameronSeenText:
	text "このまま　ジョウトまで"
	line "およぐこと<WA>ムリだろうなあ"
	done

SwimmermCameronBeatenText:
	text "うひーっ！"
	done

SwimmermCameronAfterBattleText:
	text "うみ<NO>ほかにも　いけや　かわ<TTE>"
	line "あちこち<NI>あるよなあ<⋯>"
	done

CinnabarGymSignText:
	text "<⋯>　はりがみ<GA>は<TTE>　ある！"

	para "グレンタウン<NO>ジム<WA>ここ！"
	line "ジムリーダー　カツラ"
	done

Route20_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 38,  7, SEAFOAM_GYM, 1

	def_coord_events

	def_bg_events
	bg_event 37, 11, BGEVENT_READ, CinnabarGymSign

	def_object_events
	object_event 52,  8, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfNicole, -1
	object_event 45, 13, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfLori, -1
	object_event 12, 13, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermCameron, -1
