	object_const_def
	const RADIOTOWER2F_SUPER_NERD
	const RADIOTOWER2F_TEACHER
	const RADIOTOWER2F_ROCKET1
	const RADIOTOWER2F_ROCKET2
	const RADIOTOWER2F_ROCKET3
	const RADIOTOWER2F_ROCKET_GIRL
	const RADIOTOWER2F_BLACK_BELT1
	const RADIOTOWER2F_BLACK_BELT2
	const RADIOTOWER2F_JIGGLYPUFF

RadioTower2F_MapScripts:
	def_scene_scripts

	def_callbacks

RadioTower2FNoopScene: ; unreferenced
	end

RadioTower2FSuperNerdScript:
	jumptextfaceplayer RadioTower2FSuperNerdText

RadioTower2FTeacherScript:
	faceplayer
	opentext
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue .Rockets
	writetext RadioTower2FTeacherText
	waitbutton
	closetext
	end

.Rockets:
	writetext RadioTower2FTeacherText_Rockets
	waitbutton
	closetext
	end

RadioTowerJigglypuff:
	opentext
	writetext RadioTowerJigglypuffText
	cry JIGGLYPUFF
	waitbutton
	closetext
	end

RadioTower2FBlackBelt1Script:
	jumptextfaceplayer RadioTower2FBlackBelt1Text

RadioTower2FBlackBelt2Script:
	jumptextfaceplayer RadioTower2FBlackBelt2Text

TrainerGruntM4:
	trainer GRUNTM, GRUNTM_4, EVENT_BEAT_ROCKET_GRUNTM_4, GruntM4SeenText, GruntM4BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM4AfterBattleText
	waitbutton
	closetext
	end

TrainerGruntM5:
	trainer GRUNTM, GRUNTM_5, EVENT_BEAT_ROCKET_GRUNTM_5, GruntM5SeenText, GruntM5BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM5AfterBattleText
	waitbutton
	closetext
	end

TrainerGruntM6:
	trainer GRUNTM, GRUNTM_6, EVENT_BEAT_ROCKET_GRUNTM_6, GruntM6SeenText, GruntM6BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM6AfterBattleText
	waitbutton
	closetext
	end

TrainerGruntF2:
	trainer GRUNTF, GRUNTF_2, EVENT_BEAT_ROCKET_GRUNTF_2, GruntF2SeenText, GruntF2BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntF2AfterBattleText
	waitbutton
	closetext
	end

RadioTower2FSalesSign:
	jumptext RadioTower2FSalesSignText

RadioTower2FOaksPKMNTalkSign:
	jumptext RadioTower2FOaksPKMNTalkSignText

RadioTower2FPokemonRadioSign:
	jumptext RadioTower2FPokemonRadioSignText

RadioTower2FBookshelf:
	jumpstd MagazineBookshelfScript

RadioTower2FSuperNerdText:
	text "どこでも　ラジオ<WA>きけるからね！"
	line "どこでも　ラジオ<WO>きいてくれよ！"
	done

RadioTower2FTeacherText:
	text "ラジオから　ながれる　こもりうたでも"
	line "#<WA>ねむっちゃうのよ"
	done

RadioTower2FTeacherText_Rockets:
	text "ラジオきょく<WO>せんりょう　して"
	line "どうする　つもり　なのかしら<⋯>？"
	done

RadioTowerJigglypuffText:
	text "プリンちゃん『ぷう<⋯>　ぷぷう<⋯>"
	done

RadioTower2FBlackBelt1Text:
	text "ここからうえ<WA>かんけいしゃ　いがい"
	line "たちいりきんし　なんだ<⋯>"

	para "むかし<WA>そんなこと　なかったのに"
	line "いま<NO>きょくちょう　おかしいよ"
	done

RadioTower2FBlackBelt2Text:
	text "どこでも　けんがく　じゆう　だよ"
	line "むかし<NO>よう<NI>やさしい"
	cont "きょくちょう<NI>もどったんだよ！"
	done

GruntM4SeenText:
	text "３ねんまえ　<ROCKET>は"
	line "かいさん<NI>おいこまれた<⋯>"

	para "だ<GA>われわれは"
	line "ここで　ふっかつ　するのだ！"
	done

GruntM4BeatenText:
	text "ぐう"
	line "かわいくない　やつ"
	done

GruntM4AfterBattleText:
	text "おまえ　なんかに"
	line "ふっかつ<NO>じゃま<WA>させないぞ！"
	done

GruntM5SeenText:
	text "おれたちは"
	line "#　マフィア　<ROCKET>！"
	cont "わるいこと　だいすき　なのさ"

	para "おっと　おじけづいたか？"
	done

GruntM5BeatenText:
	text "せいぎ<NO>みかた<NO>つもりか？"
	done

GruntM5AfterBattleText:
	text "べつ<NI>おれたちは"
	line "わるいこと　してるわけ　じゃない！"
	cont "ただ　すきなこと<WO>してるだけさ"
	done

GruntM6SeenText:
	text "おいおい！"
	line "おれたち<NO>じゃま<WO>するんじゃねえ"
	done

GruntM6BeatenText:
	text "うう<⋯>　まいった"
	done

GruntM6AfterBattleText:
	text "かんぶたち<WA>ここ<WO>のっとり"
	line "でかいこと<WO>する　つもりらしい"
	cont "さーて　なに<WO>するのかな？"
	done

GruntF2SeenText:
	text "ほほほ！"
	line "かんたん<NI>せんりょう　できて"
	cont "たいくつ　だったの！"

	para "あなた　たのしませて　くれる？"
	done

GruntF2BeatenText:
	text "あなた　なにもの！？"
	done

GruntF2AfterBattleText:
	text "<WATASHI>より　つよいなんて<⋯>"

	para "ゆるせない！"
	done

RadioTower2FSalesSignText:
	text "２かい　<⋯>　えいぎょうぶ"
	done

RadioTower2FOaksPKMNTalkSignText:
	text "オーキドはかせ<NO>#こうざ"
	line "こうひょう　ほうそうちゅう！"
	done

RadioTower2FPokemonRadioSignText:
	text "２４じかん　いつでも"
	line "どこでも　#ラジオ"
	done

RadioTower2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  0, RADIO_TOWER_3F, 1
	warp_event 15,  0, RADIO_TOWER_1F, 3

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_READ, RadioTower2FSalesSign
	bg_event  5,  0, BGEVENT_READ, RadioTower2FOaksPKMNTalkSign
	bg_event  9,  1, BGEVENT_READ, RadioTower2FBookshelf
	bg_event 10,  1, BGEVENT_READ, RadioTower2FBookshelf
	bg_event 11,  1, BGEVENT_READ, RadioTower2FBookshelf
	bg_event 13,  0, BGEVENT_READ, RadioTower2FPokemonRadioSign

	def_object_events
	object_event  5,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTower2FSuperNerdScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 13,  2, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower2FTeacherScript, -1
	object_event  1,  4, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM4, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  8,  4, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM5, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  4,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerGruntM6, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 10,  5, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerGruntF2, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  0,  1, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RadioTower2FBlackBelt1Script, EVENT_RADIO_TOWER_BLACKBELT_BLOCKS_STAIRS
	object_event  1,  1, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RadioTower2FBlackBelt2Script, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	object_event 12,  1, SPRITE_JIGGLYPUFF, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RadioTowerJigglypuff, -1
