	object_const_def
	const ROUTE9_YOUNGSTER1
	const ROUTE9_LASS1
	const ROUTE9_YOUNGSTER2
	const ROUTE9_LASS2
	const ROUTE9_POKEFAN_M1
	const ROUTE9_POKEFAN_M2

Route9_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerCamperDean:
	trainer CAMPER, DEAN, EVENT_BEAT_CAMPER_DEAN, CamperDeanSeenText, CamperDeanBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CamperDeanAfterBattleText
	waitbutton
	closetext
	end

TrainerPicnickerHeidi:
	trainer PICNICKER, HEIDI, EVENT_BEAT_PICNICKER_HEIDI, PicnickerHeidiSeenText, PicnickerHeidiBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PicnickerHeidiAfterBattleText
	waitbutton
	closetext
	end

TrainerCamperSid:
	trainer CAMPER, SID, EVENT_BEAT_CAMPER_SID, CamperSidSeenText, CamperSidBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CamperSidAfterBattleText
	waitbutton
	closetext
	end

TrainerPicnickerEdna:
	trainer PICNICKER, EDNA, EVENT_BEAT_PICNICKER_EDNA, PicnickerEdnaSeenText, PicnickerEdnaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PicnickerEdnaAfterBattleText
	waitbutton
	closetext
	end

TrainerHikerTim:
	trainer HIKER, TIM, EVENT_BEAT_HIKER_TIM, HikerTimSeenText, HikerTimBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext HikerTimAfterBattleText
	waitbutton
	closetext
	end

TrainerHikerSidney:
	trainer HIKER, SIDNEY, EVENT_BEAT_HIKER_SIDNEY, HikerSidneySeenText, HikerSidneyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext HikerSidneyAfterBattleText
	waitbutton
	closetext
	end

Route9Sign:
	jumptext Route9SignText

Route9HiddenEther:
	hiddenitem ETHER, EVENT_ROUTE_9_HIDDEN_ETHER

CamperDeanSeenText:
	text "イワヤマ　トンネルを"
	line "たんけんし<NI>きたのさ！"
	done

CamperDeanBeatenText:
	text "や　やばい！"
	done

CamperDeanAfterBattleText:
	text "トンネル　はいるまえに"
	line "#　キズついちゃった"
	cont "#　センター　いこうっと！"
	done

PicnickerHeidiSeenText:
	text "あなた　ピクニック　したこと　ある？"
	line "と<TTE>も　おもしろいのよ！"
	done

PicnickerHeidiBeatenText:
	text "いやーん！"
	done

PicnickerHeidiAfterBattleText:
	text "たくさん　おかし<WO>つく<TTE>"
	line "みんなで　たべるの！"
	cont "おいしいわよ！"
	done

CamperSidSeenText:
	text "おい　おまえ！"
	line "タバコ<NO>ポイすて　きんしだよ！"
	done

CamperSidBeatenText:
	text "ちゅういした　だけ　なのに<⋯>"
	done

CamperSidAfterBattleText:
	text "タバコなんて　す<TTE>　ないね"
	line "ボク<NO>みまちがえ　だった"
	done

PicnickerEdnaSeenText:
	text "ゴミ<WA>きちんと　じぶんで"
	line "もちかえらなくちゃ　いけないのよ！"
	done

PicnickerEdnaBeatenText:
	text "ああ<⋯>"
	line "まけちゃった<⋯>"
	done

PicnickerEdnaAfterBattleText:
	text "でんきも　たいせつ　だけど"
	line "しぜんも　たいせつ<NI>してね"
	done

HikerTimSeenText:
	text "やーまー<WA>しろーがねー<⋯>"

	para "シロガネ<TTE>　やまが"
	line "ジョウト<NI>あるでしょ？"
	done

HikerTimBeatenText:
	text "うた<NI>むちゅうで"
	line "#　おろそか<⋯>"
	done

HikerTimAfterBattleText:
	text "たたかい<WA>しゅうちゅうりょく！"
	done

HikerSidneySeenText:
	text "ヒミツ<WO>おしえて　あげよう！"
	line "でも　そのまえ<NI>#だ！"
	done

HikerSidneyBeatenText:
	text "くそ！"
	line "まけたか！"
	done

HikerSidneyAfterBattleText:
	text "ほそい　かわ<WO>わたると"
	line "おおきな　はつでんしょ<GA>あるぜ"
	done

Route9SignText:
	text "<KOKO_WA>９<ROUTE>"
	line "ハナダ　<⋯>　イワヤマ　トンネル"
	done

Route9_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 48, 15, ROCK_TUNNEL_1F, 1

	def_coord_events

	def_bg_events
	bg_event 15,  7, BGEVENT_READ, Route9Sign
	bg_event 10,  5, BGEVENT_ITEM, Route9HiddenEther

	def_object_events
	object_event 23, 11, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerCamperDean, -1
	object_event 35,  8, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerPicnickerHeidi, -1
	object_event 11,  2, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerCamperSid, -1
	object_event  9, 10, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 1, TrainerPicnickerEdna, -1
	object_event 32,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 4, TrainerHikerTim, -1
	object_event 33, 15, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 4, TrainerHikerSidney, -1
