	object_const_def
	const CINNABARISLAND_BLUE

CinnabarIsland_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, CinnabarIslandFlypointCallback

CinnabarIslandFlypointCallback:
	setflag ENGINE_FLYPOINT_CINNABAR
	endcallback

CinnabarIslandBlue:
	faceplayer
	opentext
	writetext CinnabarIslandBlueText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	applymovement CINNABARISLAND_BLUE, CinnabarIslandBlueTeleport
	disappear CINNABARISLAND_BLUE
	clearevent EVENT_VIRIDIAN_GYM_BLUE
	end

CinnabarIslandGymSign:
	jumptext CinnabarIslandGymSignText

CinnabarIslandSign:
	jumptext CinnabarIslandSignText

CinnabarIslandPokecenterSign:
	jumpstd PokecenterSignScript

CinnabarIslandHiddenRareCandy:
	hiddenitem RARE_CANDY, EVENT_CINNABAR_ISLAND_HIDDEN_RARE_CANDY

CinnabarIslandBlueTeleport:
	teleport_from
	step_end

CinnabarIslandBlueText:
	text "だれだ　おまえ？"
	line "#　<TRAINER><TTE>　ことは"
	cont "みれば　すぐ<NI>わかるけどな<⋯>"

	para "オレ<NO>なまえ<WA>グリーン！"
	line "チャンピオン<NI>なった　おとこさ！"
	cont "まあ　すこしだけ　だったけどな<⋯>"
	cont "レッドのヤローに"
	cont "ジャマされちまった　からな<⋯>！"

	para "ところで　おまえ　なにか　ようか？"
	line "オレと　たたかいたいのか？"

	para "<⋯>　わりぃ　<GA>いま"
	line "たたかう　きぶんじゃ　ねーんだ"

	para "みろよ　こ<NO>ありさま<⋯>"

	para "かざん<GA>ちょっと　ふんかしたら"
	line "まち　ひとつ　なくなっちまった"

	para "#　しょうぶで"
	line "かった　まけた　い<TTE>も"
	cont "しぜん<NO>みぶるい　ひとつで"
	cont "オレたち<WA>まけちまうんだ<⋯>"

	para "<⋯>　<⋯>　<⋯>"
	line "<⋯>　<⋯>　<⋯>"
	cont "まあ　いいや"
	cont "オレ<WA><TRAINER>だからな"
	cont "つよい　ヤツ<GA>いたら"
	cont "たたかいたく　なるんだけどな"

	para "おまえ　オレと　たたかいたければ"
	line "トキワ<NO>ジム<NI>こいよ"
	cont "そのとき　あいてして　やるぜ"
	done

CinnabarIslandGymSignText:
	text "<⋯>はりがみ<GA>は<TTE>ある！"

	para "グレン　タウン<NO>ジムは"
	line "ふたごじま　<NI>うつりました"
	cont "<⋯>　カツラ"
	done

CinnabarIslandSignText:
	text "<KOKO_WA>グレン　タウン"
	line "グレン<NO>あか<WA>じょうねつ<NO>いろ"
	done

CinnabarIsland_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 11, 11, CINNABAR_POKECENTER_1F, 1

	def_coord_events

	def_bg_events
	bg_event 12, 11, BGEVENT_READ, CinnabarIslandPokecenterSign
	bg_event  9, 11, BGEVENT_READ, CinnabarIslandGymSign
	bg_event  7,  7, BGEVENT_READ, CinnabarIslandSign
	bg_event  9,  1, BGEVENT_ITEM, CinnabarIslandHiddenRareCandy

	def_object_events
	object_event  9,  6, SPRITE_BLUE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CinnabarIslandBlue, EVENT_BLUE_IN_CINNABAR
