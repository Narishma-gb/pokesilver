	object_const_def
	const ROUTE3_FISHER1
	const ROUTE3_YOUNGSTER1
	const ROUTE3_YOUNGSTER2
	const ROUTE3_FISHER2

Route3_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerFirebreatherOtis:
	trainer FIREBREATHER, OTIS, EVENT_BEAT_FIREBREATHER_OTIS, FirebreatherOtisSeenText, FirebreatherOtisBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FirebreatherOtisAfterBattleText
	waitbutton
	closetext
	end

TrainerYoungsterWarren:
	trainer YOUNGSTER, WARREN, EVENT_BEAT_YOUNGSTER_WARREN, YoungsterWarrenSeenText, YoungsterWarrenBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext YoungsterWarrenAfterBattleText
	waitbutton
	closetext
	end

TrainerYoungsterJimmy:
	trainer YOUNGSTER, JIMMY, EVENT_BEAT_YOUNGSTER_JIMMY, YoungsterJimmySeenText, YoungsterJimmyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext YoungsterJimmyAfterBattleText
	waitbutton
	closetext
	end

TrainerFirebreatherBurt:
	trainer FIREBREATHER, BURT, EVENT_BEAT_FIREBREATHER_BURT, FirebreatherBurtSeenText, FirebreatherBurtBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FirebreatherBurtAfterBattleText
	waitbutton
	closetext
	end

Route3MtMoonSquareSign:
	jumptext Route3MtMoonSquareSignText

FirebreatherOtisSeenText:
	text "あー！"
	line "きょうも　いい　てんきだーっ！"
	done

FirebreatherOtisBeatenText:
	text "てんき<WA>はれ　でも"
	line "オレ<NO>こころ<WA>あめ<⋯>"
	done

FirebreatherOtisAfterBattleText:
	text "あめ　ふると"
	line "ひ　<GA>つきにくいんだよね"
	cont "ボッ！"
	done

YoungsterWarrenSeenText:
	text "うーん<⋯>"
	line "どうしようかなあ<⋯>"
	done

YoungsterWarrenBeatenText:
	text "やっぱり　まけた<⋯>"
	done

YoungsterWarrenAfterBattleText:
	text "きみ　つよそうだから"
	line "たたかう<NO>こわかったんだ　ぼく<⋯>"
	done

YoungsterJimmySeenText:
	text "ぼく<WA>かぜのこ"
	line "げんきな　こ！"
	done

YoungsterJimmyBeatenText:
	text "ぴゅー！"
	done

YoungsterJimmyAfterBattleText:
	text "いちねんじゅう　たんパン！"
	line "これ<GA>おいら<NO>ポリシーさ！"
	done

FirebreatherBurtSeenText:
	text "よ<TTE>らっしゃい"
	line "みてらっしゃい！"
	done

FirebreatherBurtBeatenText:
	text "アチーッ！"
	done

FirebreatherBurtAfterBattleText:
	text "カントー　いちばんの"
	line "ひふき　げいにんと<WA>おれのこと！"
	cont "<⋯>#　しょうぶ<WA>まけたけど"
	done

Route3MtMoonSquareSignText:
	text "おつきみやま　ひろば"
	line "<⋯>かいだん<WO>のぼ<TTE>　すぐ！"
	done

Route3_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 52,  1, MOUNT_MOON, 1

	def_coord_events

	def_bg_events
	bg_event 49, 13, BGEVENT_READ, Route3MtMoonSquareSign

	def_object_events
	object_event 26, 12, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerFirebreatherOtis, -1
	object_event 11,  2, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerYoungsterWarren, -1
	object_event 20,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerYoungsterJimmy, -1
	object_event 49,  5, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerFirebreatherBurt, -1
