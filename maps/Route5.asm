	object_const_def
	const ROUTE5_POKEFAN_M

Route5_MapScripts:
	def_scene_scripts

	def_callbacks

Route5PokefanMScript:
	jumptextfaceplayer Route5PokefanMText

Route5UndergroundPathSign:
	jumptext Route5UndergroundPathSignText

HouseForSaleSign:
	jumptext HouseForSaleSignText

Route5PokefanMText:
	text "はつでんしょ<NO>じこが"
	line "かいけつ　するまで"
	cont "つうこうきんし　なんだ<TTE>！"
	done

Route5UndergroundPathSignText:
	text "ここから　ちかつうろ"
	line "ハナダシティ　<⋯>　クチバシティ"
	done

HouseForSaleSignText:
	text "<⋯>かみ<GA>は<TTE>　ある！"
	cont "うりや<⋯>"
	cont "だれも　すんでない　みたい<⋯>"
	done

Route5_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 17, 15, ROUTE_5_UNDERGROUND_PATH_ENTRANCE, 1
	warp_event  8, 17, ROUTE_5_SAFFRON_GATE, 1
	warp_event  9, 17, ROUTE_5_SAFFRON_GATE, 2
	warp_event 10, 11, ROUTE_5_CLEANSE_TAG_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 17, 17, BGEVENT_READ, Route5UndergroundPathSign
	bg_event 10, 11, BGEVENT_READ, HouseForSaleSign

	def_object_events
	object_event 17, 16, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route5PokefanMScript, EVENT_ROUTE_5_6_POKEFAN_M_BLOCKS_UNDERGROUND_PATH
