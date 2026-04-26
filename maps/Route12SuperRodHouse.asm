	object_const_def
	const ROUTE12SUPERRODHOUSE_FISHING_GURU

Route12SuperRodHouse_MapScripts:
	def_scene_scripts

	def_callbacks

Route12SuperRodHouseFishingGuruScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_SUPER_ROD
	iftrue .GotSuperRod
	writetext OfferSuperRodText
	yesorno
	iffalse .Refused
	writetext GiveSuperRodText
	promptbutton
	verbosegiveitem SUPER_ROD
	iffalse .NoRoom
	setevent EVENT_GOT_SUPER_ROD
.GotSuperRod:
	writetext GaveSuperRodText
	waitbutton
	closetext
	end

.Refused:
	writetext DontWantSuperRodText
	waitbutton
.NoRoom:
	closetext
	end

SuperRodHouseBookshelf: ; unreferenced
	jumpstd PictureBookshelfScript

OfferSuperRodText:
	text "わし<WA>つりオヤジ　おとうと！"
	line "キミ<WA>つり<GA>すきそうな"
	cont "かお<WO>しておるな！"
	cont "わし<NO>め　<NI>くるい<WA>ない！"

	para "どうじゃ？"
	line "あたりだろう？"
	done

GiveSuperRodText:
	text "うむ　うむ！"
	line "おもった　とおりじゃ！"
	cont "つりずき<NO>キミ<NI>これ<WO>やろう！"
	cont "すごいつりざお　じゃ！"
	done

GaveSuperRodText:
	text "いろんな　ところで"
	line "つり<WO>たのしんでくれ！"

	para "つかう　つりざおで"
	line "つれる　#<GA>ちがうぞ！"
	done

DontWantSuperRodText:
	text "ありゃ？"
	line "わし<NO>よそう<GA>はずれたな<⋯>"
	done

Route12SuperRodHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_12, 1
	warp_event  3,  7, ROUTE_12, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route12SuperRodHouseFishingGuruScript, -1
