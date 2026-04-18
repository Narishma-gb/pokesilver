	object_const_def
	const CERULEANGYM_ROCKET
	const CERULEANGYM_MISTY
	const CERULEANGYM_SWIMMER_GIRL1
	const CERULEANGYM_SWIMMER_GIRL2
	const CERULEANGYM_SWIMMER_GUY
	const CERULEANGYM_GYM_GUIDE

CeruleanGym_MapScripts:
	def_scene_scripts
	scene_script CeruleanGymNoopScene,         SCENE_CERULEANGYM_NOOP
	scene_script CeruleanGymGruntRunsOutScene, SCENE_CERULEANGYM_GRUNT_RUNS_OUT

	def_callbacks

CeruleanGymNoopScene:
	end

CeruleanGymGruntRunsOutScene:
	sdefer CeruleanGymGruntRunsOutScript
	end

CeruleanGymGruntRunsOutScript:
	applymovement CERULEANGYM_ROCKET, CeruleanGymGruntRunsDownMovement
	playsound SFX_TACKLE
	applymovement CERULEANGYM_ROCKET, CeruleanGymGruntRunsIntoYouMovement
	playmusic MUSIC_ROCKET_ENCOUNTER
	opentext
	writetext CeruleanGymGruntIntroText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, CERULEANGYM_ROCKET, 15
	applymovement CERULEANGYM_ROCKET, CeruleanGymGruntBacksAwayMovement
	opentext
	writetext CeruleanGymGruntBigMistakeText
	waitbutton
	closetext
	applymovement CERULEANGYM_ROCKET, CeruleanGymGruntMovesCloseMovement
	opentext
	writetext CeruleanGymGruntByeText
	waitbutton
	closetext
	applymovement CERULEANGYM_ROCKET, CeruleanGymGruntRunsOutMovement
	playsound SFX_EXIT_BUILDING
	disappear CERULEANGYM_ROCKET
	setevent EVENT_MET_ROCKET_GRUNT_AT_CERULEAN_GYM
	clearevent EVENT_ROUTE_24_ROCKET
	clearevent EVENT_ROUTE_25_MISTY_BOYFRIEND
	setscene SCENE_CERULEANGYM_NOOP
	setmapscene ROUTE_25, SCENE_ROUTE25_MISTYS_DATE
	setmapscene POWER_PLANT, SCENE_POWERPLANT_NOOP
	waitsfx
	special RestartMapMusic
	pause 15
	turnobject PLAYER, DOWN
	pause 15
	end

CeruleanGymMistyScript:
	faceplayer
	opentext
	checkflag ENGINE_CASCADEBADGE
	iftrue .FightDone
	writetext MistyIntroText
	waitbutton
	closetext
	winlosstext MistyWinLossText, 0
	loadtrainer MISTY, MISTY1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_MISTY
	setevent EVENT_BEAT_SWIMMERF_DIANA
	setevent EVENT_BEAT_SWIMMERF_BRIANA
	setevent EVENT_BEAT_SWIMMERM_PARKER
	opentext
	writetext ReceivedCascadeBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_CASCADEBADGE
.FightDone:
	writetext MistyFightDoneText
	waitbutton
	closetext
	end

TrainerSwimmerfDiana:
	trainer SWIMMERF, DIANA, EVENT_BEAT_SWIMMERF_DIANA, SwimmerfDianaSeenText, SwimmerfDianaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmerfDianaAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmerfBriana:
	trainer SWIMMERF, BRIANA, EVENT_BEAT_SWIMMERF_BRIANA, SwimmerfBrianaSeenText, SwimmerfBrianaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmerfBrianaAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmermParker:
	trainer SWIMMERM, PARKER, EVENT_BEAT_SWIMMERM_PARKER, SwimmermParkerSeenText, SwimmermParkerBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmermParkerAfterBattleText
	waitbutton
	closetext
	end

CeruleanGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_MISTY
	iftrue .CeruleanGymGuideWinScript
	writetext CeruleanGymGuideText
	waitbutton
	closetext
	end

.CeruleanGymGuideWinScript:
	writetext CeruleanGymGuideWinText
	waitbutton
	closetext
	end

CeruleanGymHiddenMachinePart:
	hiddenitem MACHINE_PART, EVENT_FOUND_MACHINE_PART_IN_CERULEAN_GYM

CeruleanGymStatue1:
	checkevent EVENT_TRAINERS_IN_CERULEAN_GYM
	iffalse CeruleanGymStatue
	opentext
	writetext CeruleanGymNote1Text
	waitbutton
	closetext
	end

CeruleanGymStatue2:
	checkevent EVENT_TRAINERS_IN_CERULEAN_GYM
	iffalse CeruleanGymStatue
	opentext
	writetext CeruleanGymNote2Text
	waitbutton
	closetext
	end

CeruleanGymStatue:
	checkflag ENGINE_CASCADEBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, MISTY, MISTY1
	jumpstd GymStatue2Script

CeruleanGymGruntRunsDownMovement:
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	step_end

CeruleanGymGruntRunsOutMovement:
	big_step RIGHT
	big_step DOWN
	step_end

CeruleanGymGruntRunsIntoYouMovement:
	fix_facing
	set_sliding
	jump_step UP
	remove_sliding
	remove_fixed_facing
	step_sleep 8
	step_sleep 8
	step DOWN
	step DOWN
	step_end

CeruleanGymGruntMovesCloseMovement:
	big_step DOWN
	step_end

CeruleanGymGruntBacksAwayMovement:
	fix_facing
	slow_step UP
	remove_fixed_facing
	step_end

CeruleanGymGruntIntroText:
	text "オー！　ソーリー！"
	line "ユー　け<GA>ナッシング　ですかー？"
	cont "<WATASHI>　ベリー　ビジーね！"
	cont "ユーと　ゆっくり　トーキング"
	cont "できませーん！"
	cont "だれか<NI>みられたら"
	cont "<WATASHI>　こまりまーす！"
	done

CeruleanGymGruntBigMistakeText:
	text "<⋯>オー　ノー！"
	line "すで<NI>ユー<NI>みられまし<TA!>"
	cont "ビッグ　マイ　ミステイク！"
	done

CeruleanGymGruntByeText:
	text "ヘイ　ユー！"
	line "このこと　フォーゲットするね！"
	cont "ユー<WA>なにも　みない"
	cont "きかない　しらないね！"

	para "バイ　キッド！"
	line "ロング　グッドバイ！！"
	done

CeruleanGymNote1Text:
	text "ちょっと　でかけてます"
	line "<⋯>　ジム　リーダー　カスミ"
	done

CeruleanGymNote2Text:
	text "カスミさん<GA>いないので"
	line "あそび<NI>い<TTE>ます"
	cont "<⋯>　ジム　<TRAINER>　いちどう"
	done

MistyIntroText:
	text "カスミ『きたわね！"
	line "オジャマムシくん！"

	para "ジョウト<NO>ジム　バッジを"
	line "たくさん　も<TTE>る　みたいだけど"
	cont "なめて　もらっちゃ　こまるわ！"

	para "<WATASHI><NO>みずタイプ<NO>#は"
	line "つよいわよっ！"
	done

MistyWinLossText:
	text "カスミ『やるじゃない<⋯>"

	para "あんた<NO>じつりょく"
	line "すなお<NI>みとめるわ<⋯>"

	para "はい　これ"
	line "ブルーバッジよ！"
	done

ReceivedCascadeBadgeText:
	text "<PLAYER><WA>カスミから"
	line "ブルーバッジ<WO>もらっ<TA!>"
	done

MistyFightDoneText:
	text "カスミ『つよい　<TRAINER>が"
	line "ジョウトに<WA>たくさん　いるの？"
	cont "あんた　みたいに"

	para "あたしも　いつか　たび<NI>でて"
	line "つよい　<TRAINER>と　たたかうわ！"
	done

SwimmerfDianaSeenText:
	text "ゴメンねー　るす　しちゃ<TTE>！"
	line "さっそく　しょうぶ　しましょうか！"
	done

SwimmerfDianaBeatenText:
	text "まいったわ！"
	line "<WATASHI><NO>まけ！"
	done

SwimmerfDianaAfterBattleText:
	text "おとなしく　およいでまーす"
	done

SwimmerfBrianaSeenText:
	text "わたくし<NO>かれいな"
	line "およぎ<WO>みても　びびらないでよ！"
	done

SwimmerfBrianaBeatenText:
	text "ぜんぜん　びび<TTE>ない<⋯>"
	line "すごく　れいせい　だわ<⋯>！"
	done

SwimmerfBrianaAfterBattleText:
	text "わたくし<WO>たおした　から<TTE>"
	line "あんしんしない　ことね！"
	cont "カスミ<WA>ほんと　つよいわよ！"
	done

SwimmermParkerSeenText:
	text "おわっぷ！"

	para "まず<WA>おれ<GA>あいてだ！"
	line "かか<TTE>　こい！"
	done

SwimmermParkerBeatenText:
	text "こんな　はず<WA>ない"
	done

SwimmermParkerAfterBattleText:
	text "カスミ<WA>ここ　すうねんで"
	line "どんどん　つよく　な<TTE>るんだ！"
	cont "ゆだん　しない　ことだな！"
	cont "いたい　め　<NI>あうぜ！"
	done

CeruleanGymGuideText:
	text "おーす！"
	line "みらい<NO>チャンピオン！"

	para "カスミたち<GA>いないもんだから"
	line "オレっちも　あそび<NI>いっちゃっ<TA!>"
	cont "わははははっ！"
	done

CeruleanGymGuideWinText:
	text "さすが<NI>つよいな！"
	line "いい　たたかい　だったぜ！"
	done

CeruleanGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 15, CERULEAN_CITY, 5
	warp_event  5, 15, CERULEAN_CITY, 5

	def_coord_events

	def_bg_events
	bg_event  3,  8, BGEVENT_ITEM, CeruleanGymHiddenMachinePart
	bg_event  2, 13, BGEVENT_READ, CeruleanGymStatue1
	bg_event  6, 13, BGEVENT_READ, CeruleanGymStatue2

	def_object_events
	object_event  4, 10, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_CERULEAN_GYM_ROCKET
	object_event  5,  3, SPRITE_MISTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeruleanGymMistyScript, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  4,  6, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfDiana, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  1,  9, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerSwimmerfBriana, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  8,  9, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermParker, EVENT_TRAINERS_IN_CERULEAN_GYM
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CeruleanGymGuideScript, EVENT_TRAINERS_IN_CERULEAN_GYM
