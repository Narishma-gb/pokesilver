	object_const_def
	const RADIOTOWER4F_FISHER
	const RADIOTOWER4F_TEACHER
	const RADIOTOWER4F_GROWLITHE
	const RADIOTOWER4F_ROCKET1
	const RADIOTOWER4F_ROCKET2
	const RADIOTOWER4F_ROCKET_GIRL
	const RADIOTOWER4F_SCIENTIST

RadioTower4F_MapScripts:
	def_scene_scripts

	def_callbacks

RadioTower4FFisherScript:
	jumptextfaceplayer RadioTower4FFisherText

RadioTower4FDJMaryScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_PINK_BOW_FROM_MARY
	iftrue .GotPinkBow
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .ClearedRockets
	writetext RadioTower4FDJMaryText
	waitbutton
	closetext
	end

.ClearedRockets:
	writetext RadioTower4FDJMaryText_ClearedRockets
	promptbutton
	verbosegiveitem PINK_BOW
	iffalse .NoRoom
	writetext RadioTower4FDJMaryText_GivePinkBow
	waitbutton
	closetext
	setevent EVENT_GOT_PINK_BOW_FROM_MARY
	end

.GotPinkBow:
	writetext RadioTower4FDJMaryText_After
	waitbutton
.NoRoom:
	closetext
	end

RadioTowerMeowth:
	opentext
	writetext RadioTowerMeowthText
	cry MEOWTH
	waitbutton
	closetext
	end

TrainerGruntM10:
	trainer GRUNTM, GRUNTM_10, EVENT_BEAT_ROCKET_GRUNTM_10, GruntM10SeenText, GruntM10BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM10AfterBattleText
	waitbutton
	closetext
	end

TrainerExecutivem2:
	trainer EXECUTIVEM, EXECUTIVEM_2, EVENT_BEAT_ROCKET_EXECUTIVEM_2, Executivem2SeenText, Executivem2BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext Executivem2AfterBattleText
	waitbutton
	closetext
	end

TrainerGruntF4:
	trainer GRUNTF, GRUNTF_4, EVENT_BEAT_ROCKET_GRUNTF_4, GruntF4SeenText, GruntF4BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntF4AfterBattleText
	waitbutton
	closetext
	end

TrainerScientistRich:
	trainer SCIENTIST, RICH, EVENT_BEAT_SCIENTIST_RICH, ScientistRichSeenText, ScientistRichBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext ScientistRichAfterBattleText
	waitbutton
	closetext
	end

RadioTower4FProductionSign:
	jumptext RadioTower4FProductionSignText

RadioTower4FStudio2Sign:
	jumptext RadioTower4FStudio2SignText

RadioTower4FFisherText:
	text "いせき<NI>あそび<NI>いったとき"
	line "ラジオ<WO>きいたら"
	cont "しらない　ほうそう<GA>きこえてきたよ"
	done

RadioTower4FDJMaryText:
	text "クルミ『どうして<⋯>"
	line "こんな　め<NI>あうの<⋯>？"

	para "ニャースちゃん　たすけてー！"
	done

RadioTower4FDJMaryText_ClearedRockets:
	text "クルミ『あっ　きみー"
	line "あたし<WO>たすけてくれた　ひとだー"

	para "じゃあ　これ"
	line "あたし<NO>きもち！"
	done

RadioTower4FDJMaryText_GivePinkBow:
	text "クルミ『それ<TTE>"
	line "ノーマルタイプ<NO>わざ<WO>つかう"
	cont "#<NI>ぴったり<TTE>　かんじ！"
	done

RadioTower4FDJMaryText_After:
	text "クルミ『<WATASHI>と　オーキドはかせの"
	line "#こうざ　きいてねー！"
	done

RadioTowerMeowthText:
	text "ニャース『<⋯>　にゃあ"
	done

GruntM10SeenText:
	text "きょくちょう<WO>たすけだす　つもりか"
	line "それ<WA>むり　<TTE>もんだ"
	cont "ここで　おれ<NI>たおされちまうからな"
	done

GruntM10BeatenText:
	text "オー　マイガッ！"
	done

GruntM10AfterBattleText:
	text "なんてこったい！"
	line "おれ<GA>たおされちまう　とは"
	done

Executivem2SeenText:
	text "まちな！　<ROCKET>の"
	line "とりで　といわれた　こ<NO>オレだ！"
	cont "これいじょう　さきに<WA>いかせない！"
	done

Executivem2BeatenText:
	text "とりで<GA>くずれた<⋯>"
	done

Executivem2AfterBattleText:
	text "おまえ<WO>そんけい　して"
	line "ちゅうこく　してやろう"

	para "いまからでも　おそくはない"
	line "ひきかえした　ほう<GA>いいぞ<⋯>"
	done

GruntF4SeenText:
	text "#<GA>かわいくないのか　<TTE>？"
	line "そうねえ　ここで　あんた<NO>#"
	cont "たおしたら　かわいいわねえ"
	done

GruntF4BeatenText:
	text "もう！"
	line "やく<NI>たたないんだから！"
	done

GruntF4AfterBattleText:
	text "あたし<WA>あたし<GA>かわいいの！"
	line "#なんて　どうでも　いいわ！"
	done

ScientistRichSeenText:
	text "すばらしい！"

	para "こ<NO>ラジオとう<NO>しせつ　なら"
	line "<WATASHI>たち<NO>やぼう<WO>かなえられる"
	done

ScientistRichBeatenText:
	text "ふむふむ"
	line "いだいな　けいかく<NO>まえに"
	cont "じゃま<WA>つきものと　いうわけか"
	done

ScientistRichAfterBattleText:
	text "きみ　なんか<NI>じゃま　される"
	line "<ROCKET>　だと　おも<TTE>るのか？"
	done

RadioTower4FProductionSignText:
	text "４かい　<⋯>　せいさくしつ"
	done

RadioTower4FStudio2SignText:
	text "４かい　<⋯>　だい２スタジオ"
	done

RadioTower4F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  0, RADIO_TOWER_5F, 1
	warp_event  9,  0, RADIO_TOWER_3F, 2
	warp_event 12,  0, RADIO_TOWER_5F, 2
	warp_event 17,  0, RADIO_TOWER_3F, 3

	def_coord_events

	def_bg_events
	bg_event  7,  0, BGEVENT_READ, RadioTower4FProductionSign
	bg_event 15,  0, BGEVENT_READ, RadioTower4FStudio2Sign

	def_object_events
	object_event  6,  4, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower4FFisherScript, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	object_event 14,  6, SPRITE_TEACHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTower4FDJMaryScript, -1
	object_event 12,  7, SPRITE_GROWLITHE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTowerMeowth, -1
	object_event  5,  6, SPRITE_ROCKET, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM10, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 14,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 2, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerExecutivem2, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 12,  4, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerGruntF4, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  4,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerScientistRich, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
