	object_const_def
	const CELADONDEPTSTORE1F_RECEPTIONIST
	const CELADONDEPTSTORE1F_GENTLEMAN
	const CELADONDEPTSTORE1F_TEACHER

CeladonDeptStore1F_MapScripts:
	def_scene_scripts

	def_callbacks

CeladonDeptStore1FReceptionistScript:
	jumptextfaceplayer CeladonDeptStore1FReceptionistText

CeladonDeptStore1FGentlemanScript:
	jumptextfaceplayer CeladonDeptStore1FGentlemanText

CeladonDeptStore1FTeacherScript:
	jumptextfaceplayer CeladonDeptStore1FTeacherText

CeladonDeptStore1FDirectory:
	jumptext CeladonDeptStore1FDirectoryText

CeladonDeptStore1FElevatorButton:
	jumpstd ElevatorButtonScript

CeladonDeptStore1FReceptionistText:
	text "いらっしゃいませ！"
	line "タマムシ　デパート<NI>ようこそ！"

	para "かく　フロア<NO>あんないは"
	line "みぎ<NO>ボード<WO>ごらん　ください"
	done

CeladonDeptStore1FGentlemanText:
	text "しまいてんの"
	line "コガネ　ひゃっかてん　<NI>あわせて"
	cont "こ<NO>デパートも"
	cont "かいそう　した　らしいよ"
	done

CeladonDeptStore1FTeacherText:
	text "はじめて　きたけど<⋯>"
	line "すごく　おおきくて"
	cont "まよっちゃいそうだわ！"
	done

CeladonDeptStore1FDirectoryText:
	text "１かい　<⋯>　サービス·カウンター"
	line "２かい　<⋯>　<TRAINER>ズ·ショップ"
	cont "３かい　<⋯>　<TM>·ショップ"
	cont "４かい　<⋯>　ワイズマン·ギフト"
	cont "５かい　<⋯>　ドラッグ·ストア"
	cont "６かい　<⋯>　じどう　はんばいき"
	done

CeladonDeptStore1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  7, CELADON_CITY, 1
	warp_event  8,  7, CELADON_CITY, 1
	warp_event 15,  0, CELADON_DEPT_STORE_2F, 2
	warp_event  2,  0, CELADON_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_READ, CeladonDeptStore1FDirectory
	bg_event  3,  0, BGEVENT_READ, CeladonDeptStore1FElevatorButton

	def_object_events
	object_event 10,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore1FReceptionistScript, -1
	object_event 11,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore1FGentlemanScript, -1
	object_event  5,  3, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonDeptStore1FTeacherScript, -1
