	object_const_def
	const ROUTE6_POKEFAN_M

Route6_MapScripts:
	def_scene_scripts

	def_callbacks

Route6PokefanMScript:
	jumptextfaceplayer Route6PokefanMText

Route6UndergroundPathSign:
	jumptext Route6UndergroundPathSignText

Route6PokefanMText:
	text "はつでんしょ<NO>じこが"
	line "かいけつ　するまで"
	cont "つうこうきんし　なんだ<TTE>！"
	done

Route6UndergroundPathSignText:
	text "ここから　ちかつうろ"
	line "ハナダシティ　<⋯>　クチバシティ"
	done

Route6_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 17,  3, ROUTE_6_UNDERGROUND_PATH_ENTRANCE, 1
	warp_event  6,  1, ROUTE_6_SAFFRON_GATE, 3

	def_coord_events

	def_bg_events
	bg_event 19,  5, BGEVENT_READ, Route6UndergroundPathSign

	def_object_events
	object_event 17,  4, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 2, Route6PokefanMScript, EVENT_ROUTE_5_6_POKEFAN_M_BLOCKS_UNDERGROUND_PATH
