	object_const_def
	const OLIVINEGOODRODHOUSE_FISHING_GURU

OlivineGoodRodHouse_MapScripts:
	def_scene_scripts

	def_callbacks

GoodRodGuru:
	faceplayer
	opentext
	checkevent EVENT_GOT_GOOD_ROD
	iftrue .AlreadyGotItem
	writetext OfferGoodRodText
	yesorno
	iffalse .DontWantIt
	writetext GiveGoodRodText
	promptbutton
	verbosegiveitem GOOD_ROD
	writetext GaveGoodRodText
	waitbutton
	closetext
	setevent EVENT_GOT_GOOD_ROD
	end

.DontWantIt:
	writetext DontWantGoodRodText
	waitbutton
	closetext
	end

.AlreadyGotItem:
	writetext HaveGoodRodText
	waitbutton
	closetext
	end

GoodRodHouseBookshelf: ; unreferenced
	jumpstd PictureBookshelfScript

OfferGoodRodText:
	text "アサギと　いえば　うみ！"
	line "うみと　いえば　つり！"

	para "わし<WA>ここで　３０ねん"
	line "つり<WO>しとるんだ"

	para "きみも　うみ<NI>むか<TTE>"
	line "つりで　ちょうせん　してみるかね？"
	done

GiveGoodRodText:
	text "おっほっほう！"
	line "つりびと　たんじょうだ！"
	done

GaveGoodRodText:
	text "うみ　だけじゃなく"
	line "みず<NO>ある　ところなら"
	cont "どこでも　つりざお　つかうといいぞ"
	done

DontWantGoodRodText:
	text "なんじゃと！"
	line "つり<GA>きらい！　しんじられんのお"
	done

HaveGoodRodText:
	text "どう？　おおも<NO>つれたかね？"
	done

OlivineGoodRodHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, OLIVINE_CITY, 6
	warp_event  3,  7, OLIVINE_CITY, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoodRodGuru, -1
