	object_const_def
	const ROUTE21_SWIMMER_GIRL
	const ROUTE21_SWIMMER_GUY
	const ROUTE21_FISHER

Route21_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerSwimmermSeth:
	trainer SWIMMERM, SETH, EVENT_BEAT_SWIMMERM_SETH, SwimmermSethSeenText, SwimmermSethBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmermSethAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmerfNikki:
	trainer SWIMMERF, NIKKI, EVENT_BEAT_SWIMMERF_NIKKI, SwimmerfNikkiSeenText, SwimmerfNikkiBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmerfNikkiAfterBattleText
	waitbutton
	closetext
	end

TrainerFisherArnold:
	trainer FISHER, ARNOLD, EVENT_BEAT_FISHER_ARNOLD, FisherArnoldSeenText, FisherArnoldBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FisherArnoldAfterBattleText
	waitbutton
	closetext
	end

SwimmermSethSeenText:
	text "がんばれ！"
	line "りくち<GA>みえてき<TA!>"
	done

SwimmermSethBeatenText:
	text "ざっぱーん！"
	done

SwimmermSethAfterBattleText:
	text "グレン　タウン<NO>ふんかこうに"
	line "かっこつけた　ヤツ　ひとり　いたな"
	done

SwimmerfNikkiSeenText:
	text "あ！　きみ！"

	para "いま　<WATASHI><NI>サンオイル"
	line "ぬりたいと　おもったでしょ！"
	done

SwimmerfNikkiBeatenText:
	text "ひやけ<GA>き<NI>なるわ<⋯>"
	done

SwimmerfNikkiAfterBattleText:
	text "シミ　ソバカス<GA>しんぱいな"
	line "としごろ　なのよ　<WATASHI>"
	done

FisherArnoldSeenText:
	text "つりも　あき<TA!>"
	line "よし！　しょうぶだ！"
	done

FisherArnoldBeatenText:
	text "ざんぱい　だ<⋯>"
	done

FisherArnoldAfterBattleText:
	text "おとなしく　つり<WO>してるよ<⋯>"
	done

Route21_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event 11, 16, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfNikki, -1
	object_event  2, 30, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerSwimmermSeth, -1
	object_event 14, 22, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherArnold, -1
