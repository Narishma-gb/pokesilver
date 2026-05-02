	object_const_def
	const LAKEOFRAGEHIDDENPOWERHOUSE_FISHER

LakeOfRageHiddenPowerHouse_MapScripts:
	def_scene_scripts

	def_callbacks

HiddenPowerGuy:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM10_HIDDEN_POWER
	iftrue .AlreadyGotItem
	writetext HiddenPowerGuyText1
	promptbutton
	verbosegiveitem TM_HIDDEN_POWER
	iffalse .Done
	setevent EVENT_GOT_TM10_HIDDEN_POWER
	writetext HiddenPowerGuyText2
	waitbutton
	closetext
	end
.AlreadyGotItem:
	writetext HiddenPowerGuyText3
	waitbutton
.Done:
	closetext
	end

HiddenPowerHouseBookshelf:
	jumpstd DifficultBookshelfScript

HiddenPowerGuyText1:
	text "<⋯>　<⋯>　<⋯>"
	line "わざわざ　こんな　ところまで<⋯>"

	para "わし<WA>ここで　めいそう　することで"
	line "あらたな　ちから<WO>みにつけ<TA!>"

	para "そ<NO>ちから"
	line "きみ<NO>#にも　わけよう"
	cont "これ<WO>も<TTE>いきなさい"
	done

HiddenPowerGuyText2:
	text "<⋯>　わかるか"
	line "それ<WA>めざめるパワー！"

	para "#<NO>ちから<WO>ひきだし"
	line "<KOUGEKI>　する　わざ！"

	para "ただし　おぼえさせた　#により"
	line "タイプと　いりょく<WA>ちが<TTE>くる"
	done

HiddenPowerGuyText3:
	text "ただいま　めいそうちゅう<⋯>　<⋯>"
	done

LakeOfRageHiddenPowerHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, LAKE_OF_RAGE, 1
	warp_event  3,  7, LAKE_OF_RAGE, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, HiddenPowerHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, HiddenPowerHouseBookshelf

	def_object_events
	object_event  2,  3, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, HiddenPowerGuy, -1
