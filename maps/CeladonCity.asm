	object_const_def
	const CELADONCITY_FISHER
	const CELADONCITY_POLIWAG
	const CELADONCITY_TEACHER1
	const CELADONCITY_GRAMPS1
	const CELADONCITY_GRAMPS2
	const CELADONCITY_YOUNGSTER1
	const CELADONCITY_YOUNGSTER2
	const CELADONCITY_TEACHER2
	const CELADONCITY_LASS

CeladonCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, CeladonCityFlypointCallback

CeladonCityFlypointCallback:
	setflag ENGINE_FLYPOINT_CELADON
	endcallback

CeladonCityFisherScript:
	jumptextfaceplayer CeladonCityFisherText

CeladonCityPoliwrath:
	opentext
	writetext CeladonCityPoliwrathText
	cry POLIWRATH
	waitbutton
	closetext
	end

CeladonCityTeacher1Script:
	jumptextfaceplayer CeladonCityTeacher1Text

CeladonCityGramps1Script:
	jumptextfaceplayer CeladonCityGramps1Text

CeladonCityGramps2Script:
	jumptextfaceplayer CeladonCityGramps2Text

CeladonCityYoungster1Script:
	jumptextfaceplayer CeladonCityYoungster1Text

CeladonCityYoungster2Script:
	jumptextfaceplayer CeladonCityYoungster2Text

CeladonCityTeacher2Script:
	jumptextfaceplayer CeladonCityTeacher2Text

CeladonCityLassScript:
	jumptextfaceplayer CeladonCityLassText

CeladonCitySign:
	jumptext CeladonCitySignText

CeladonGymSign:
	jumptext CeladonGymSignText

CeladonCityDeptStoreSign:
	jumptext CeladonCityDeptStoreSignText

CeladonCityMansionSign:
	jumptext CeladonCityMansionSignText

CeladonCityGameCornerSign:
	jumptext CeladonCityGameCornerSignText

CeladonCityTrainerTips:
	jumptext CeladonCityTrainerTipsText

CeladonCityPokecenterSign:
	jumpstd PokecenterSignScript

CeladonCityHiddenPpUp:
	hiddenitem PP_UP, EVENT_CELADON_CITY_HIDDEN_PP_UP

CeladonCityFisherText:
	text "こいつ　おれ<NO>あいか<TA!>"
	line "ニョロボン！"

	para "こいつも　いつかは"
	line "かえる#<NI>なるのかな？"
	done

CeladonCityPoliwrathText:
	text "ニョロボン『ゲロゲーロ！"
	done

CeladonCityTeacher1Text:
	text "あーん！"
	line "スロットで　また　まけちゃった"

	para "さいきん　おんなのこも"
	line "スロット<NI>むちゅう　なのよ！"
	cont "あなたも　あそんで　みたら？"
	done

CeladonCityGramps1Text:
	text "ちかごろ　ベトベターが"
	line "しゅつぼつ　するよう<NI>な<TTE>な"

	para "ほれ　いえのまえ<NO>いけ　にも"
	line "ベトベター<GA>いるのじゃ！"

	para "どこから　や<TTE>きたのじゃろう？"
	line "こまったのう<⋯>"
	done

CeladonCityGramps2Text:
	text "にひひ！　こ<NO>ジム<WA>ええ！"
	line "おんなのこ　ばっかし　じゃ！"
	done

CeladonCityYoungster1Text:
	text "ボク<NO>ヒミツ　おしえてあげる！"

	para "じつはね　タマムシ　マンションには"
	line "ひみつ<NO>うらぐち<GA>あるんだよ！"
	done

CeladonCityYoungster2Text:
	text "そこ<NO>しょくどうで"
	line "おおぐいコンテスト　してんだけど<⋯>"
	cont "みてるだけで　おなか　いっぱい<⋯>！"
	done

CeladonCityTeacher2Text:
	text "タマムシ　デパートは"
	line "しなぞろえ　ナンバー　ワン！"
	cont "ほしい　もの<GA>なんでも　かえるわ！"

	para "<⋯>　<TTE>　<WATASHI>"
	line "うりこみ<NO>ひと　みたいね！"
	done

CeladonCityLassText:
	text "<⋯>　どうろ<NO>もようを"
	line "じっと　みながら　あるいてたら"
	cont "め<GA>チカチカ　しちゃっ<TA!>"
	done

CeladonCitySignText:
	text "<KOKO_WA>タマムシ　シティ"
	line "タマムシ　にじいろ　ゆめ<NO>いろ"
	done

CeladonGymSignText:
	text "タマムシ　シティ　#ジム"
	line "リーダー　エリカ"
	cont "しぜん<WO>あいする　おじょうさま"
	done

CeladonCityDeptStoreSignText:
	text "ほしいも<NO>きっと　みつかる！"
	line "タマムシ　デパート"
	done

CeladonCityMansionSignText:
	text "タマムシ　マンション"
	done

CeladonCityGameCornerSignText:
	text "<KOKO_WA>みんな<NO>あそびば"
	line "タマムシ　ゲームコーナー"
	done

CeladonCityTrainerTipsText:
	text "<⋯>　おとくな　けいじばん！"

	para "エフェクトガードは"
	line "ほのお　や　みず　でんき　など"

	para "とくしゅな　<KOUGEKI>　から"
	line "#<WO>まも<TTE>　くれる！"

	para "どうぐ<NO>おかいもとめは"
	line "タマムシ　デパートで　どうぞ！"
	done

CeladonCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  9, CELADON_DEPT_STORE_1F, 1
	warp_event 16,  9, CELADON_MANSION_1F, 1
	warp_event 16,  3, CELADON_MANSION_1F, 3
	warp_event 17,  3, CELADON_MANSION_1F, 3
	warp_event 29,  9, CELADON_POKECENTER_1F, 1
	warp_event 18, 19, CELADON_GAME_CORNER, 1
	warp_event 23, 19, CELADON_GAME_CORNER_PRIZE_ROOM, 1
	warp_event 10, 29, CELADON_GYM, 1
	warp_event 25, 29, CELADON_CAFE, 1

	def_coord_events

	def_bg_events
	bg_event 23, 21, BGEVENT_READ, CeladonCitySign
	bg_event 11, 31, BGEVENT_READ, CeladonGymSign
	bg_event  6,  9, BGEVENT_READ, CeladonCityDeptStoreSign
	bg_event 13,  9, BGEVENT_READ, CeladonCityMansionSign
	bg_event 19, 21, BGEVENT_READ, CeladonCityGameCornerSign
	bg_event 29, 21, BGEVENT_READ, CeladonCityTrainerTips
	bg_event 30,  9, BGEVENT_READ, CeladonCityPokecenterSign
	bg_event 37, 21, BGEVENT_ITEM, CeladonCityHiddenPpUp

	def_object_events
	object_event 26, 11, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonCityFisherScript, -1
	object_event 27, 11, SPRITE_POLIWAG, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonCityPoliwrath, -1
	object_event 20, 24, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonCityTeacher1Script, -1
	object_event 14, 16, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CeladonCityGramps1Script, -1
	object_event  8, 31, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonCityGramps2Script, -1
	object_event 18, 13, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeladonCityYoungster1Script, -1
	object_event 24, 33, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonCityYoungster2Script, -1
	object_event  6, 14, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonCityTeacher2Script, -1
	object_event  7, 22, SPRITE_LASS, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonCityLassScript, -1
