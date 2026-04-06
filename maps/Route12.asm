	object_const_def
	const ROUTE12_FISHER1
	const ROUTE12_FISHER2
	const ROUTE12_FISHER3
	const ROUTE12_FISHER4
	const ROUTE12_POKE_BALL1
	const ROUTE12_POKE_BALL2

Route12_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerFisherKyle:
	trainer FISHER, KYLE, EVENT_BEAT_FISHER_KYLE, FisherKyleSeenText, FisherKyleBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FisherKyleAfterBattleText
	waitbutton
	closetext
	end

TrainerFisherMartin:
	trainer FISHER, MARTIN, EVENT_BEAT_FISHER_MARTIN, FisherMartinSeenText, FisherMartinBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FisherMartinAfterBattleText
	waitbutton
	closetext
	end

TrainerFisherStephen:
	trainer FISHER, STEPHEN, EVENT_BEAT_FISHER_STEPHEN, FisherStephenSeenText, FisherStephenBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FisherStephenAfterBattleText
	waitbutton
	closetext
	end

TrainerFisherBarney:
	trainer FISHER, BARNEY, EVENT_BEAT_FISHER_BARNEY, FisherBarneySeenText, FisherBarneyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FisherBarneyAfterBattleText
	waitbutton
	closetext
	end

Route12Sign:
	jumptext Route12SignText

FishingSpotSign:
	jumptext FishingSpotSignText

Route12Calcium:
	itemball CALCIUM

Route12Nugget:
	itemball NUGGET

Route12HiddenElixer:
	hiddenitem ELIXER, EVENT_ROUTE_12_HIDDEN_ELIXER

FisherMartinSeenText:
	text "つり<WA>にんたい"
	line "#も　にんたい！"
	done

FisherMartinBeatenText:
	text "にん　にん！"
	done

FisherMartinAfterBattleText:
	text "たんきな　ボクには"
	line "つり<WA>むいてないのかも<⋯>"
	done

FisherStephenSeenText:
	text "つり　しながら　ラジオに"
	line "みみ<WO>かたむける　しあわせ！"
	done

FisherStephenBeatenText:
	text "ラジオ　ききながらだったから<⋯>"
	line "だから　まけたんだよ！"
	done

FisherStephenAfterBattleText:
	text "カントー<NO>ラジオほうそう"
	line "きいたことある？"
	cont "いろんな　ばんぐみ　や<TTE>るよ"
	done

FisherBarneySeenText:
	text "にちじょう<NO>せいかつで"
	line "たいせつなも<NO>なーんだ？"
	done

FisherBarneyBeatenText:
	text "こたえ<WA>このあと　すぐ！"
	done

FisherBarneyAfterBattleText:
	text "ボク<WA>やっぱり"
	line "でんき　だと　おもうんだ"

	para "じゃなかったら　はつでんしょが"
	line "うごかないくらいで　あんなに"
	cont "みんな<GA>あわてたり　しないよ"
	done

FisherKyleSeenText:
	text "きみ<WA>おぼえているか<⋯>！？"
	done

FisherKyleBeatenText:
	text "おぼえてるのかー！？"
	done

FisherKyleAfterBattleText:
	text "#<GA>つれる　ときの"
	line "あ<NO>さお<WO>つたわる　てごたえ！"
	cont "つり<NO>だいごみ　だよね！"
	done

Route12SignText:
	text "<KOKO_WA>１２<ROUTE>"
	line "きた　<⋯>　シオンタウン"
	done

FishingSpotSignText:
	text "<KOKO_WA>つり<NO>めいしょ"
	done

Route12_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 11, 33, ROUTE_12_SUPER_ROD_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 11, 27, BGEVENT_READ, Route12Sign
	bg_event 13,  9, BGEVENT_READ, FishingSpotSign
	bg_event 14, 13, BGEVENT_ITEM, Route12HiddenElixer

	def_object_events
	object_event  5, 15, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerFisherMartin, -1
	object_event 15, 28, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerFisherStephen, -1
	object_event 13, 39, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerFisherBarney, -1
	object_event  6,  6, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerFisherKyle, -1
	object_event  5, 43, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route12Calcium, EVENT_ROUTE_12_CALCIUM
	object_event  5, 51, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route12Nugget, EVENT_ROUTE_12_NUGGET
