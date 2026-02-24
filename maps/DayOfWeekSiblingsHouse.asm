	object_const_def
	const DAYOFWEEKSIBLINGSHOUSE_POKEDEX

DayOfWeekSiblingsHouse_MapScripts:
	def_scene_scripts

	def_callbacks

DayOfWeekSiblingsHousePokedexScript:
	opentext
	writetext DayOfWeekSiblingsHousePokedexText1
	yesorno
	iffalse .End
	writetext DayOfWeekSiblingsHousePokedexText2
	yesorno
	iffalse .End
	writetext DayOfWeekSiblingsHousePokedexText3
	waitbutton
.End:
	closetext
	end

DayOfWeekSiblingsHousePokedexText1:
	text "<⋯>ノート<NI>なにか　かいてある！"
	line "よみますか？"
	done

DayOfWeekSiblingsHousePokedexText2:
	text "<⋯>#　<TRAINER>に"
	line "きょうりょく　することが"
	cont "<WATASHI>たち　きょうだい<NO>よろこび"

	para "<TRAINER><NI>はなしかけられたら"
	line "べんりな　どうぐ<WO>あげましょう！"

	para "おとうと　いもうと　たちへ"
	line "ちょうじょ　ツキコ　より<⋯>"

	para "つぎ<NO>ページも　よむ？"
	done

DayOfWeekSiblingsHousePokedexText3:
	text "げつようび<NO>ツキコ"
	line "<⋯>　４０ばん　すいどう"

	para "かようび<NO>ヒコ"
	line "<⋯>　２９<ROUTE>"

	para "すいようび<NO>ミズオ"
	line "<⋯>　いかりのみずうみ"

	para "もくようび<NO>モクオ"
	line "<⋯>　３６<ROUTE>"

	para "きんようび<NO>カネコ"
	line "<⋯>　３２<ROUTE>"

	para "どようび<NO>ツチオ"
	line "<⋯>　フスベ　シティ"

	para "にちようび<NO>ニチオ"
	line "<⋯>　３７<ROUTE>"
	done

DayOfWeekSiblingsHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_26, 3
	warp_event  3,  7, ROUTE_26, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  3, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayOfWeekSiblingsHousePokedexScript, -1
