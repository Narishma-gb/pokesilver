	object_const_def
	const ROUTE1_YOUNGSTER
	const ROUTE1_COOLTRAINER_F
	const ROUTE1_FRUIT_TREE

Route1_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerSchoolboyDanny:
	trainer SCHOOLBOY, DANNY, EVENT_BEAT_SCHOOLBOY_DANNY, SchoolboyDannySeenText, SchoolboyDannyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SchoolboyDannyAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainerfQuinn:
	trainer COOLTRAINERF, QUINN, EVENT_BEAT_COOLTRAINERF_QUINN, CooltrainerfQuinnSeenText, CooltrainerfQuinnBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainerfQuinnAfterBattleText
	waitbutton
	closetext
	end

Route1Sign:
	jumptext Route1SignText

Route1FruitTree:
	fruittree FRUITTREE_ROUTE_1

SchoolboyDannySeenText:
	text "<TRAINER>と　であったら"
	line "まず　しょうぶ！"
	done

SchoolboyDannyBeatenText:
	text "まけこしだー！"
	done

SchoolboyDannyAfterBattleText:
	text "<TRAINER>にと<TTE>　しょうぶは"
	line "あいさつ　みたいな　ものだね"
	done

CooltrainerfQuinnSeenText:
	text "ちょっと　キミ！"
	line "<WATASHI>と　しょうぶ　しない？"
	done

CooltrainerfQuinnBeatenText:
	text "まけた<⋯>！"
	done

CooltrainerfQuinnAfterBattleText:
	text "つよいわね　キミ"
	line "そうとう　しゅぎょう　してるわ"
	done

Route1SignText:
	text "<KOKO_WA>１<ROUTE>"
	line "マサラタウン　<⋯>　トキワシティ"
	done

Route1_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event  7, 27, BGEVENT_READ, Route1Sign

	def_object_events
	object_event  7, 17, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSchoolboyDanny, -1
	object_event  3, 26, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_RIGHT, 1, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerCooltrainerfQuinn, -1
	object_event  3,  7, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route1FruitTree, -1
