	object_const_def
	const VIRIDIANGYM_BLUE
	const VIRIDIANGYM_GYM_GUIDE

ViridianGym_MapScripts:
	def_scene_scripts

	def_callbacks

ViridianGymBlueScript:
	faceplayer
	opentext
	checkflag ENGINE_EARTHBADGE
	iftrue .FightDone
	writetext LeaderBlueBeforeText
	waitbutton
	closetext
	winlosstext LeaderBlueWinText, 0
	loadtrainer BLUE, BLUE1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BLUE
	opentext
	writetext Text_ReceivedEarthBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_EARTHBADGE
	writetext LeaderBlueAfterText
	waitbutton
	closetext
	end

.FightDone:
	writetext LeaderBlueEpilogueText
	waitbutton
	closetext
	end

ViridianGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_BLUE
	iftrue .ViridianGymGuideWinScript
	writetext ViridianGymGuideText
	waitbutton
	closetext
	end

.ViridianGymGuideWinScript:
	writetext ViridianGymGuideWinText
	waitbutton
	closetext
	end

ViridianGymStatue:
	checkflag ENGINE_EARTHBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script

.Beaten:
	gettrainername STRING_BUFFER_4, BLUE, BLUE1
	jumpstd GymStatue2Script

LeaderBlueBeforeText:
	text "グリーン『よお　きたな"

	para "グレンじゃ　ちょっと"
	line "ナーバス<NI>なった　けど"
	cont "いま<WA>むしょうに"
	cont "たたかいたい　きぶん　だぜ！"

	para "<⋯>　<⋯>　<⋯>"

	para "おまえ<GA>ジョウトのジムを"
	line "ぜんぶ　せい<WA>した<TTE>？"

	para "ジョウト<NO>レベルが"
	line "ひくいんじゃ　ねえのか？"

	para "まあ　いいさ"
	line "たたかえば　わかることだ"
	cont "おまえ<NO>じつりょくが"
	cont "ホンモノか　どうかはな！"

	para "いくぜ！"
	line "ジョウト<NO>ぼうず！"
	done

LeaderBlueWinText:
	text "グリーン『バカなっ！"

	para "オレ<GA>こんな　ヤツに"
	line "まける　なんてっ！！"

	para "<⋯>　<⋯>　<⋯>"
	line "<⋯>　ちっ　しょうがねえ"
	cont "ほら　グリーンバッジだ"
	cont "おまえ<NI>やるよ！"
	done

Text_ReceivedEarthBadge:
	text "<PLAYER><WA>グリーンから"
	line "グリーンバッジ<WO>もらっ<TA!>"
	done

LeaderBlueAfterText:
	text "グリーン『<⋯>　<⋯>　<⋯>"

	para "オレ<GA>まちが<TTE>たよ"
	line "おまえ<WA>ほんも<NO>だよ"
	cont "つよい　<TRAINER>だ！"
	cont "すなお<NI>みとめるぜ！"

	para "だがな！"
	line "わすれるな！"

	para "いつか　オレ<GA>おまえを"
	line "たおすからなっ！"
	done

LeaderBlueEpilogueText:
	text "グリーン『いいか！"

	para "オレ<GA>たおすまで"
	line "まけるんじゃねーぞ！"
	done

ViridianGymGuideText:
	text "おーす！"
	line "みらい<NO>チャンピオン！"
	cont "ちょうし<WA>どうだい？"
	cont "こうちょう　そうだな！"

	para "３ねんまえ　チャンピオンと"
	line "たたかった　おとこが"
	cont "こ<NO>ジム<NO>リーダーだ"

	para "てごわいぜ！"
	line "がんばれよ！"
	done

ViridianGymGuideWinText:
	text "さす<GA>つよいねっ！"
	line "オレ　なみだ<GA>でてきたよ"
	cont "かんどうてきな　しょうぶ　だったぜ！"
	done

ViridianGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, VIRIDIAN_CITY, 1
	warp_event  5, 17, VIRIDIAN_CITY, 1

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, ViridianGymStatue
	bg_event  6, 13, BGEVENT_READ, ViridianGymStatue

	def_object_events
	object_event  5,  3, SPRITE_BLUE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ViridianGymBlueScript, EVENT_VIRIDIAN_GYM_BLUE
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ViridianGymGuideScript, EVENT_VIRIDIAN_GYM_BLUE
