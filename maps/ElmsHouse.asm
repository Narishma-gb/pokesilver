	object_const_def
	const ELMSHOUSE_ELMS_WIFE
	const ELMSHOUSE_ELMS_SON

ElmsHouse_MapScripts:
	def_scene_scripts

	def_callbacks

ElmsWife:
	jumptextfaceplayer ElmsWifeText

ElmsSon:
	jumptextfaceplayer ElmsSonText

ElmsHousePC:
	jumptext ElmsHousePCText

ElmsHouseBookshelf:
	jumpstd DifficultBookshelfScript

ElmsWifeText:
	text "あら　<PLAYER>くん！"

	para "うち<NO>だんな"
	line "なんだか　いそがしそうだけど"
	cont "むり　してないかしら？"

	para "#<NO>けんきゅう<NI>なると"
	line "むちゅうで　ごはんも　たべないのよ"
	done

ElmsSonText:
	text "ぼく　おおきくなったら"
	line "おとうさん<NO>おてつだい<WO>する！"

	para "そして　すごい"
	line "#はかせ<NI>なるんだ！"
	done

ElmsHouseLabFoodText: ; unreferenced
	text "しょくじ<NO>じゅんび<GA>してある"
	line "けんきゅうしょ<NO>ぶん　かな？"
	done

ElmsHousePokemonFoodText: ; unreferenced
	text "しょくじ<NO>じゅんび<GA>してある"
	line "こっち<WA>#よう　かな？"
	done

ElmsHousePCText:
	text "#<WA>どこから　きて"
	line "どこへ　いくのか？"

	para "なぜ　うまれてくる　しゅんかんを"
	line "だれも　みたこと<GA>ないのか？"

	para "<WATASHI><WA>それ<WO>しりたい！"
	line "じんせい<NO>すべて<WO>かけて"
	cont "けんきゅう　するつもりだ！"

	para "<⋯>　<⋯>　<⋯>"

	para "ウツギはかせ<GA>まとめている"
	line "けんきゅう　はっぴょう<NO>いちぶだ！"
	done

ElmsHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, NEW_BARK_TOWN, 4
	warp_event  3,  7, NEW_BARK_TOWN, 4

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, ElmsHousePC
	bg_event  6,  1, BGEVENT_READ, ElmsHouseBookshelf
	bg_event  7,  1, BGEVENT_READ, ElmsHouseBookshelf

	def_object_events
	object_event  1,  5, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ElmsWife, -1
	object_event  5,  4, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ElmsSon, -1
