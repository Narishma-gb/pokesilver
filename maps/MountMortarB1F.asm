	object_const_def
	const MOUNTMORTARB1F_POKE_BALL1
	const MOUNTMORTARB1F_POKE_BALL2
	const MOUNTMORTARB1F_BOULDER
	const MOUNTMORTARB1F_KIYO

MountMortarB1F_MapScripts:
	def_scene_scripts

	def_callbacks

MountMortarB1FKiyoScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_TYROGUE_FROM_KIYO
	iftrue .GotTyrogue
	checkevent EVENT_BEAT_BLACKBELT_KIYO
	iftrue .BeatKiyo
	writetext MountMortarB1FKiyoIntroText
	waitbutton
	closetext
	winlosstext MountMortarB1FKiyoWinText, 0
	loadtrainer BLACKBELT_T, KIYO
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BLACKBELT_KIYO
	opentext
.BeatKiyo:
	writetext MountMortarB1FTyrogueRewardText
	promptbutton
	waitsfx
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .NoRoom
	writetext MountMortarB1FReceiveMonText
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke TYROGUE, 10
	setevent EVENT_GOT_TYROGUE_FROM_KIYO
.GotTyrogue:
	writetext MountMortarB1FKiyoGotTyrogueText
	waitbutton
	closetext
	end

.NoRoom:
	writetext MountMortarB1FKiyoFullPartyText
	waitbutton
	closetext
	end

MountMortarB1FBoulder:
	jumpstd StrengthBoulderScript

MountMortarB1FHyperPotion:
	itemball HYPER_POTION

MountMortarB1FFullHeal:
	itemball FULL_HEAL

MountMortarB1FHiddenMaxRevive:
	hiddenitem MAX_REVIVE, EVENT_MOUNT_MORTAR_B1F_HIDDEN_MAX_REVIVE

MountMortarB1FKiyoIntroText:
	text "オスッ！"
	line "わし<GA>カラテ　だいおう　である！"

	para "くらい　ほらあなで　ひとり"
	line "しゅぎょう<WO>する　おとこだ！"

	para "おい！"
	line "おぬし！"
	cont "わしと　たたかえっ！"
	cont "トオリャー！"
	done

MountMortarB1FKiyoWinText:
	text "ウオリャ！"
	line "だー！　やられたあー！"
	done

MountMortarB1FTyrogueRewardText:
	text "むむ<⋯>　むねんっ！"
	line "まだ　しゅぎょう<GA>たりぬか<⋯>！"

	para "くやしい<GA>まけ<WA>まけ！"
	line "いさぎよく　みとめるぞ！"

	para "おぬし！　かった　あかしとして"
	line "わし<NO>だいじな"
	cont "かくとう　#<WO>わたす！"
	done

MountMortarB1FReceiveMonText:
	text "<PLAYER><WA>カラテ　だいおうから"
	line "バルキー<WO>もらっ<TA!>"
	done

MountMortarB1FKiyoGotTyrogueText:
	text "バルキー<WA>かくとうタイプ！"

	para "そだてると　つよーい　#に"
	line "しんか　するらしいのだ！"

	para "おぬしも　がんばれっ！"
	line "わしも　しゅぎょう<WO>つづけるのだ！"
	cont "ウオッスッ！"
	done

MountMortarB1FKiyoFullPartyText:
	text "ウスッ！"
	line "いっぱいで　もてないぞ！"
	done

MountMortarB1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  3, MOUNT_MORTAR_1F_INSIDE, 5
	warp_event 19, 29, MOUNT_MORTAR_1F_OUTSIDE, 7

	def_coord_events

	def_bg_events
	bg_event  4,  6, BGEVENT_ITEM, MountMortarB1FHiddenMaxRevive

	def_object_events
	object_event 31, 17, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, MountMortarB1FHyperPotion, EVENT_MOUNT_MORTAR_B1F_HYPER_POTION
	object_event  4, 16, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, MountMortarB1FFullHeal, EVENT_MOUNT_MORTAR_B1F_FULL_HEAL
	object_event  9, 10, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MountMortarB1FBoulder, -1
	object_event 13,  4, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, MountMortarB1FKiyoScript, -1
