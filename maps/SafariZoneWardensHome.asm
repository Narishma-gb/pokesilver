	object_const_def
	const SAFARIZONEWARDENSHOME_LASS

SafariZoneWardensHome_MapScripts:
	def_scene_scripts

	def_callbacks

WardensGranddaughter:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_WARDENS_GRANDDAUGHTER
	iftrue .AlreadyMet
	writetext WardensGranddaughterText1
	waitbutton
	closetext
	setevent EVENT_TALKED_TO_WARDENS_GRANDDAUGHTER
	end
.AlreadyMet:
	writetext WardensGranddaughterText2
	waitbutton
	closetext
	end

WardenPhoto:
	jumptext WardenPhotoText

SafariZonePhoto:
	jumptext SafariZonePhotoText

WardensHomeBookshelf:
	jumpstd PictureBookshelfScript

WardensGranddaughterText1:
	text "あたし<NO>おじいちゃんは"
	line "サファリゾーン<NO>えんちょうよ！"

	para "<⋯>　だったんだけど"
	line "いま　がいこくへ　りょこうちゅう"
	cont "「たび<NI>いくぞー！」　<TTE>"
	cont "ひとりで　いっちゃったわ！"

	para "そのとき　サファリゾーンを"
	line "やめちゃったの！"
	done

WardensGranddaughterText2:
	text "サファリゾーン<GA>なくな<TTE>"
	line "ざんねんが<TTE>る　ひと<GA>いるけど"
	cont "おじいちゃん　ガンコ　だったから！"
	done

WardenPhotoText:
	text "たくさん<NO>#<NI>かこまれて"
	line "えがお<NO>おじいさん<GA>うつ<TTE>る！"
	done

SafariZonePhotoText:
	text "どこか<NO>だいそうげん"
	line "めずらしい　#<GA>うつ<TTE>る！"
	done

SafariZoneWardensHome_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, FUCHSIA_CITY, 6
	warp_event  3,  7, FUCHSIA_CITY, 6

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, WardensHomeBookshelf
	bg_event  1,  1, BGEVENT_READ, WardensHomeBookshelf
	bg_event  7,  0, BGEVENT_READ, WardenPhoto
	bg_event  9,  0, BGEVENT_READ, SafariZonePhoto

	def_object_events
	object_event  2,  4, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, WardensGranddaughter, -1
