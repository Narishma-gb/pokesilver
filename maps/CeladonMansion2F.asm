CeladonMansion2F_MapScripts:
	def_scene_scripts

	def_callbacks

CeladonMansion2FComputer:
	jumptext CeladonMansion2FComputerText

CeladonMansion2FMeetingRoomSign:
	jumptext CeladonMansion2FMeetingRoomSignText

CeladonMansion2FBookshelf:
	jumpstd DifficultBookshelfScript

CeladonMansion2FComputerText:
	text "<PLAYER>は"
	line "<PC><NO>スイッチ<WO>いれ<TA!>"

	para "<⋯>　<⋯>　<⋯>"

	para "でんし　メール<WO>かいてる"
	line "とちゅう　みたいだ！"

	para "<⋯>　<⋯>　<⋯>"

	para "ひさしぶり<NI>カントーへ"
	line "きて　ください！"

	para "ずいぶん　さまがわり　したので"
	line "おどろくと　おもいますよ！"

	para "ジョウトで<WA>すがた<WO>みせない"
	line "#も　たくさん　います"

	para "<⋯>　プロデューサー　へ"

	para "<⋯>　<⋯>　<⋯>"
	done

CeladonMansion2FMeetingRoomSignText:
	text "ゲームフリークほんかん"
	line "おうせつ　しつ"
	done

CeladonMansion2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  0, CELADON_MANSION_1F, 4
	warp_event  1,  0, CELADON_MANSION_3F, 2
	warp_event  6,  0, CELADON_MANSION_3F, 3
	warp_event  7,  0, CELADON_MANSION_1F, 5

	def_coord_events

	def_bg_events
	bg_event  0,  3, BGEVENT_READ, CeladonMansion2FComputer
	bg_event  5,  8, BGEVENT_UP, CeladonMansion2FMeetingRoomSign
	bg_event  2,  3, BGEVENT_READ, CeladonMansion2FBookshelf

	def_object_events
