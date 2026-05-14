	object_const_def
	const ROUTE37_WEIRD_TREE1
	const ROUTE37_WEIRD_TREE2
	const ROUTE37_YOUNGSTER
	const ROUTE37_FRUIT_TREE1
	const ROUTE37_SUNNY
	const ROUTE37_FRUIT_TREE2
	const ROUTE37_FRUIT_TREE3

Route37_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route37SunnyCallback

Route37SunnyCallback:
	readvar VAR_WEEKDAY
	ifequal SUNDAY, .SunnyAppears
	disappear ROUTE37_SUNNY
	endcallback

.SunnyAppears:
	appear ROUTE37_SUNNY
	endcallback

TrainerTwinsAnnandanne1:
	trainer TWINS, ANNANDANNE1, EVENT_BEAT_TWINS_ANN_AND_ANNE, TwinsAnnandanne1SeenText, TwinsAnnandanne1BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext TwinsAnnandanne1AfterBattleText
	waitbutton
	closetext
	end

TrainerTwinsAnnandanne2:
	trainer TWINS, ANNANDANNE2, EVENT_BEAT_TWINS_ANN_AND_ANNE, TwinsAnnandanne2SeenText, TwinsAnnandanne2BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext TwinsAnnandanne2AfterBattleText
	waitbutton
	closetext
	end

TrainerPsychicGreg:
	trainer PSYCHIC_T, GREG, EVENT_BEAT_PSYCHIC_GREG, PsychicGregSeenText, PsychicGregBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PsychicGregAfterBattleText
	waitbutton
	closetext
	end

SunnyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_MAGNET_FROM_SUNNY
	iftrue SunnySundayScript
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, SunnyNotSundayScript
	checkevent EVENT_MET_SUNNY_OF_SUNDAY
	iftrue .MetSunny
	writetext MeetSunnyText
	promptbutton
	setevent EVENT_MET_SUNNY_OF_SUNDAY
.MetSunny:
	writetext SunnyGivesGiftText1
	promptbutton
	verbosegiveitem MAGNET
	iffalse SunnyDoneScript
	setevent EVENT_GOT_MAGNET_FROM_SUNNY
	writetext SunnyGaveGiftText
	waitbutton
	closetext
	end

SunnySundayScript:
	writetext SunnySundayText
	waitbutton
SunnyDoneScript:
	closetext
	end

SunnyNotSundayScript:
	writetext SunnyNotSundayText
	waitbutton
	closetext
	end

Route37Sign:
	jumptext Route37SignText

Route37FruitTree1:
	fruittree FRUITTREE_ROUTE_37_1

Route37FruitTree2:
	fruittree FRUITTREE_ROUTE_37_2

Route37FruitTree3:
	fruittree FRUITTREE_ROUTE_37_3

Route37HiddenEther:
	hiddenitem ETHER, EVENT_ROUTE_37_HIDDEN_ETHER

TwinsAnnandanne1SeenText:
	text "マナ『カナと　ふたり"
	line "ちから　あわせて　がんばるです！"
	done

TwinsAnnandanne1BeatenText:
	text "マナとカナ『むう"
	line "おにいちゃん　いじわる　です"
	done

TwinsAnnandanne1AfterBattleText:
	text "マナ『おねえちゃんと　#の"
	line "かんがえてること　わかるですの"
	done

TwinsAnnandanne2SeenText:
	text "カナ『マナと　ふたり"
	line "ちから　あわせて　がんばるです！"
	done

TwinsAnnandanne2BeatenText:
	text "マナとカナ『むう"
	line "おにいちゃん　いじわる　です"
	done

TwinsAnnandanne2AfterBattleText:
	text "カナ『あたしたち　ふたりと"
	line "#<WA>おなじ　きもち　なの"
	done

PsychicGregSeenText:
	text "#　ねむらされると"
	line "なにも　できなくなる"
	cont "そ<NO>こわさ　おしえてやる！"
	done

PsychicGregBeatenText:
	text "まけた<⋯>"
	line "かなり　かなしいなあ"
	done

PsychicGregAfterBattleText:
	text "ねむらせたり　まひさせたり"
	line "あいて<NO>じゆう<WO>うばうのは"
	cont "じゅうような　テクニック　だね"
	done

MeetSunnyText:
	text "ニチオ『ぼくねー"
	line "にちようび<NO>ニチオ　だよ！"
	done

SunnyGivesGiftText1:
	text "おにいちゃん<NI>あったらね"
	line "これ　わたせ<TTE>　いわれてんの！"
	done

SunnyGaveGiftText:
	text "ニチオ『それはねー"

	para "えっとねー"

	para "<⋯>　なんだったかなあ？"

	para "<⋯>　<⋯>　<⋯>"

	para "あ！"
	line "おもいだしたあ！"

	para "でんきタイプ<NO>わざ<WO>おぼえた"
	line "#<NI>もたせると"
	cont "わざ<NO>いりょく<GA>つよくなる<TTE>！"
	cont "ツキコ　おねえちゃん<GA>い<TTE>たよ！"
	done

SunnySundayText:
	text "ニチオ『ツキコ　おねえちゃんとー"
	line "ヒコ　おねえちゃんとー"
	cont "ミズオ　おにいちゃんとー"
	cont "モクオ　おにいちゃんとー"
	cont "カネコ　おねえちゃんとー"
	cont "ツチオ　おにいちゃん！"

	para "ぼく　すえっこ　なんだ！"
	done

SunnyNotSundayText:
	text "ニチオ『きょう<WA>にちようびじゃ"
	line "ないのー？"
	cont "えっとねー　わすれちゃっ<TA!>"
	done

Route37SignText:
	text "<KOKO_WA>３７<ROUTE>"
	done

Route37_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event  5,  3, BGEVENT_READ, Route37Sign
	bg_event  4,  2, BGEVENT_ITEM, Route37HiddenEther

	def_object_events
	object_event  6, 12, SPRITE_WEIRD_TREE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsAnnandanne1, -1
	object_event  7, 12, SPRITE_WEIRD_TREE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsAnnandanne2, -1
	object_event  9,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPsychicGreg, -1
	object_event 13,  5, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route37FruitTree1, -1
	object_event 16,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SunnyScript, EVENT_ROUTE_37_SUNNY_OF_SUNDAY
	object_event 16,  5, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route37FruitTree2, -1
	object_event 15,  7, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route37FruitTree3, -1
