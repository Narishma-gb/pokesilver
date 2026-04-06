	object_const_def
	const ROUTE28STEELWINGHOUSE_CELEBRITY
	const ROUTE28STEELWINGHOUSE_FEAROW

Route28SteelWingHouse_MapScripts:
	def_scene_scripts
	scene_script Route28SteelWingHouseNoopScene ; unusable

	def_callbacks

Route28SteelWingHouseNoopScene:
	end

Celebrity:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM47_STEEL_WING
	iftrue .AlreadyGotItem
	writetext CelebrityText1
	promptbutton
	verbosegiveitem TM_STEEL_WING
	iffalse .Done
	setevent EVENT_GOT_TM47_STEEL_WING
.Done:
	closetext
	end
.AlreadyGotItem:
	writetext CelebrityText2
	waitbutton
	closetext
	end

CelebritysFearow:
	opentext
	writetext CelebritysFearowText
	cry FEAROW
	waitbutton
	closetext
	end

CelebrityHouseBookshelf:
	jumpstd MagazineBookshelfScript

CelebrityText1:
	text "あらま<⋯>！"
	line "みつかっちゃったわね！"

	para "<WATASHI><NO>こと"
	line "だれにも　いわないで"
	cont "これ　あげる　から"
	cont "<⋯>　おねがいよ"
	done

CelebrityText2:
	text "うれっこアイドル<WA>つらいわ"
	line "どこ<NI>い<TTE>も　ひと<GA>くるもの"
	cont "しずか<NI>くらしたいのに<⋯>"
	done

CelebritysFearowText:
	text "オニドリル『キュイン！"
	done

Route28SteelWingHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_28, 1
	warp_event  3,  7, ROUTE_28, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, CelebrityHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, CelebrityHouseBookshelf

	def_object_events
	object_event  2,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Celebrity, -1
	object_event  6,  5, SPRITE_MOLTRES, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CelebritysFearow, -1
