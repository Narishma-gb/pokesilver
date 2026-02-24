	object_const_def
	const ROUTE27SANDSTORMHOUSE_GRANNY

Route27SandstormHouse_MapScripts:
	def_scene_scripts

	def_callbacks

SandstormHouseWoman:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM37_SANDSTORM
	iftrue .AlreadyGotItem
	special GetFirstPokemonHappiness
	writetext SandstormHouseWomanText1
	promptbutton
	ifgreater 150 - 1, .Loyal
	sjump .Disloyal

.Loyal:
	writetext SandstormHouseWomanLoyalText
	promptbutton
	verbosegiveitem TM_SANDSTORM
	iffalse .Done
	setevent EVENT_GOT_TM37_SANDSTORM
.AlreadyGotItem:
	writetext SandstormHouseSandstormDescription
	waitbutton
.Done:
	closetext
	end

.Disloyal:
	writetext SandstormHouseWomanDisloyalText
	waitbutton
	closetext
	end

SandstormHouseBookshelf:
	jumpstd MagazineBookshelfScript

SandstormHouseWomanText1:
	text "ひょひょひょ"
	line "#つれて　どこ　いくんじゃ？"

	para "#　リーグか"
	line "かちぬけるほど　つよい"
	cont "きずな<WO>も<TTE>おるのか？"

	para "どれどれ　おぬし<NO>#<⋯>"
	done

SandstormHouseWomanLoyalText:
	text "おお　けっこう　なついとるの"
	line "いい<TRAINER>　みると　うれしいの"

	para "これ<WA>せんべつ！"
	line "も<TTE>　いきなさいよ"
	done

SandstormHouseSandstormDescription:
	text "<TM>３７<WA>すなあらし！"

	para "つかうと　おたがい　ダメージをうける"
	line "じょうきゅうしゃ　むけ<NO>わざ"

	para "まっ　がんばりなさいよ"
	done

SandstormHouseWomanDisloyalText:
	text "もうちっと　なついてもらわんと"
	line "かちぬくの<WA>きびしそうじゃの"

	para "<TRAINER>と　#<WO>つなぐのは"
	line "しんらい　じゃからの"
	done

Route27SandstormHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_27, 1
	warp_event  3,  7, ROUTE_27, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, SandstormHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, SandstormHouseBookshelf

	def_object_events
	object_event  2,  4, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SandstormHouseWoman, -1
