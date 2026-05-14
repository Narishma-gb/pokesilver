	object_const_def
	const ROUTE40_OLIVINE_RIVAL1
	const ROUTE40_OLIVINE_RIVAL2
	const ROUTE40_SWIMMER_GIRL1
	const ROUTE40_SWIMMER_GIRL2
	const ROUTE40_ROCK1
	const ROUTE40_ROCK2
	const ROUTE40_ROCK3
	const ROUTE40_LASS
	const ROUTE40_MONICA

Route40_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, Route40MonicaCallback

Route40MonicaCallback:
	readvar VAR_WEEKDAY
	ifequal MONDAY, .MonicaAppears
	disappear ROUTE40_MONICA
	endcallback

.MonicaAppears:
	appear ROUTE40_MONICA
	endcallback

TrainerSwimmerfElaine:
	trainer SWIMMERF, ELAINE, EVENT_BEAT_SWIMMERF_ELAINE, SwimmerfElaineSeenText, SwimmerfElaineBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmerfElaineAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmerfPaula:
	trainer SWIMMERF, PAULA, EVENT_BEAT_SWIMMERF_PAULA, SwimmerfPaulaSeenText, SwimmerfPaulaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmerfPaulaAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmermSimon:
	trainer SWIMMERM, SIMON, EVENT_BEAT_SWIMMERM_SIMON, SwimmermSimonSeenText, SwimmermSimonBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmermSimonAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmermRandall:
	trainer SWIMMERM, RANDALL, EVENT_BEAT_SWIMMERM_RANDALL, SwimmermRandallSeenText, SwimmermRandallBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmermRandallAfterBattleText
	waitbutton
	closetext
	end

Route40Lass1Script:
	jumptextfaceplayer Route40Lass1Text

MonicaScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_SHARP_BEAK_FROM_MONICA
	iftrue .Monday
	readvar VAR_WEEKDAY
	ifnotequal MONDAY, .NotMonday
	checkevent EVENT_MET_MONICA_OF_MONDAY
	iftrue .MetMonica
	writetext MeetMonicaText
	promptbutton
	setevent EVENT_MET_MONICA_OF_MONDAY
.MetMonica:
	writetext MonicaGivesGiftText
	promptbutton
	verbosegiveitem SHARP_BEAK
	iffalse .done
	setevent EVENT_GOT_SHARP_BEAK_FROM_MONICA
	writetext MonicaGaveGiftText
	waitbutton
	closetext
	end

.Monday:
	writetext MonicaMondayText
	waitbutton
.done:
	closetext
	end

.NotMonday:
	writetext MonicaNotMondayText
	waitbutton
	closetext
	end

Route40Sign:
	jumptext Route40SignText

Route40Rock:
	jumpstd SmashRockScript

Route40HiddenHyperPotion:
	hiddenitem HYPER_POTION, EVENT_ROUTE_40_HIDDEN_HYPER_POTION

Route40_StepRightUp6Movement: ; unreferenced
	step RIGHT
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step_end

Route40_StepUp5Movement: ; unreferenced
	step UP
	step UP
	step UP
	step UP
	step UP
	step_end

Route40_StepUp4Movement: ; unreferenced
	step UP
	step UP
	step UP
	step UP
	step_end

SwimmermSimonSeenText:
	text "みず<NI>はいる　まえには"
	line "じゅんび　うんどう！"

	para "これ<WA>きほん　だからな！"
	done

SwimmermSimonBeatenText:
	text "うー　まいっ<TA!>"
	done

SwimmermSimonAfterBattleText:
	text "ここから　タンバまで"
	line "けっこう　きょり<GA>あるぞ！"
	done

SwimmermRandallSeenText:
	text "しょうねん"
	line "#<NI>のらず　およぎなさい！"
	done

SwimmermRandallBeatenText:
	text "まけちゃった"
	done

SwimmermRandallAfterBattleText:
	text "およぐの<WA>ぜんしん<WO>つかうから"
	line "けんこう<NI>いいこと　なのだ！"
	done

SwimmerfElaineSeenText:
	text "タンバまで　およぎきる　つもり？"

	para "そのまえ<NI>ちょっと"
	line "ひとしょうぶ　しない？"
	done

SwimmerfElaineBeatenText:
	text "<WATASHI><NO>まけね"
	done

SwimmerfElaineAfterBattleText:
	text "およぎじゃ　<WATASHI><NO>ほうが"
	line "うえ　だと　おもうんだけどな"
	done

SwimmerfPaulaSeenText:
	text "うきわ<NO>かわりに"
	line "うみ<NO>#<NI>つかま<TTE>るの"
	done

SwimmerfPaulaBeatenText:
	text "うーん"
	line "くらくら　しちゃう"
	done

SwimmerfPaulaAfterBattleText:
	text "こうや<TTE>　ぷかぷか　うかんでると"
	line "なみ<NI>ながされちゃうのよ"
	done

Route40Lass1Text:
	text "ここからじゃ　みえないけど"
	line "おおきな　うみ<WO>こえていくと"
	cont "タンバ<TTE>　まち<GA>あるのよ"
	done

MeetMonicaText:
	text "ツキコ『はじめまして！"
	line "<WATASHI>　げつようび<NO>ツキコ　です"
	done

MonicaGivesGiftText:
	text "おちかづき<NO>しるし<NI>はい　これ！"
	done

MonicaGaveGiftText:
	text "ツキコ『それ<WA>ひこうタイプの"
	line "<KOUGEKI>りょく<WO>あげる　どうぐ"

	para "あなた<NO>とり#に"
	line "もたせると　いいわよ！"
	done

MonicaMondayText:
	text "ツキコ『<WATASHI>の"
	line "おとうと　や　いもうと　たちが"
	cont "いろんな　ばしょ<NI>いるわ"

	para "さがして　みてね！"
	done

MonicaNotMondayText:
	text "ツキコ『きょう<WA>げつようびじゃ"
	line "ないみたいね<⋯>"
	cont "ざんねんだわ"
	done

Route40SignText:
	text "<KOKO_WA>４０ばん　すいどう"
	line "タンバシティ　<⋯>　アサギシティ"
	done

Route40_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event 16,  8, BGEVENT_READ, Route40Sign
	bg_event 11,  7, BGEVENT_ITEM, Route40HiddenHyperPotion

	def_object_events
	object_event 14, 15, SPRITE_OLIVINE_RIVAL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerSwimmermSimon, -1
	object_event 18, 30, SPRITE_OLIVINE_RIVAL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 5, TrainerSwimmermRandall, -1
	object_event  3, 19, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 4, TrainerSwimmerfElaine, -1
	object_event 10, 25, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfPaula, -1
	object_event 12,  8, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40Rock, -1
	object_event 11,  7, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40Rock, -1
	object_event 13,  6, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40Rock, -1
	object_event 13, 10, SPRITE_LASS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route40Lass1Script, -1
	object_event 10,  6, SPRITE_BEAUTY, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MonicaScript, EVENT_ROUTE_40_MONICA_OF_MONDAY
