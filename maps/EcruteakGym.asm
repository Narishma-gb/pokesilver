	object_const_def
	const ECRUTEAKGYM_MORTY
	const ECRUTEAKGYM_SAGE1
	const ECRUTEAKGYM_SAGE2
	const ECRUTEAKGYM_GRANNY1
	const ECRUTEAKGYM_GRANNY2
	const ECRUTEAKGYM_GYM_GUIDE

EcruteakGym_MapScripts:
	def_scene_scripts

	def_callbacks

EcruteakGymMortyScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_MORTY
	iftrue .FightDone
	writetext MortyIntroText
	waitbutton
	closetext
	winlosstext MortyWinLossText, 0
	loadtrainer MORTY, MORTY1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_MORTY
	opentext
	writetext Text_ReceivedFogBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_FOGBADGE
	readvar VAR_BADGES
	scall EcruteakGymActivateRockets
	setmapscene ECRUTEAK_TIN_TOWER_ENTRANCE, SCENE_ECRUTEAKTINTOWERENTRANCE_NOOP
.FightDone:
	checkevent EVENT_GOT_TM30_SHADOW_BALL
	iftrue .GotShadowBall
	setevent EVENT_BEAT_SAGE_JEFFREY
	setevent EVENT_BEAT_SAGE_PING
	setevent EVENT_BEAT_MEDIUM_MARTHA
	setevent EVENT_BEAT_MEDIUM_GRACE
	writetext MortyText_FogBadgeSpeech
	promptbutton
	verbosegiveitem TM_SHADOW_BALL
	iffalse .NoRoomForShadowBall
	setevent EVENT_GOT_TM30_SHADOW_BALL
	writetext MortyText_ShadowBallSpeech
	waitbutton
	closetext
	end

.GotShadowBall:
	writetext MortyFightDoneText
	waitbutton
.NoRoomForShadowBall:
	closetext
	end

EcruteakGymActivateRockets:
	ifequal 7, .RadioTowerRockets
	ifequal 6, .GoldenrodRockets
	end

.GoldenrodRockets:
	jumpstd GoldenrodRocketsScript

.RadioTowerRockets:
	jumpstd RadioTowerRocketsScript

TrainerSageJeffrey:
	trainer SAGE, JEFFREY, EVENT_BEAT_SAGE_JEFFREY, SageJeffreySeenText, SageJeffreyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SageJeffreyAfterBattleText
	waitbutton
	closetext
	end

TrainerSagePing:
	trainer SAGE, PING, EVENT_BEAT_SAGE_PING, SagePingSeenText, SagePingBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SagePingAfterBattleText
	waitbutton
	closetext
	end

TrainerMediumMartha:
	trainer MEDIUM, MARTHA, EVENT_BEAT_MEDIUM_MARTHA, MediumMarthaSeenText, MediumMarthaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext MediumMarthaAfterBattleText
	waitbutton
	closetext
	end

TrainerMediumGrace:
	trainer MEDIUM, GRACE, EVENT_BEAT_MEDIUM_GRACE, MediumGraceSeenText, MediumGraceBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext MediumGraceAfterBattleText
	waitbutton
	closetext
	end

EcruteakGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_MORTY
	iftrue .EcruteakGymGuideWinScript
	writetext EcruteakGymGuideText
	waitbutton
	closetext
	end

.EcruteakGymGuideWinScript:
	writetext EcruteakGymGuideWinText
	waitbutton
	closetext
	end

EcruteakGymStatue:
	checkflag ENGINE_FOGBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, MORTY, MORTY1
	jumpstd GymStatue2Script

MortyIntroText:
	text "よく　きたね"

	para "エンジュでは"
	line "むかしから　#を"
	cont "かみさまとして　まつ<TTE>いた"

	para "そして　しん<NO>じつりょく<WO>もつ"
	line "<TRAINER><NO>まえに"
	cont "でんせつの#<WA>まいおりる<⋯>"
	cont "そう　つたえられている"

	para "ぼく<WA>そ<NO>いいつたえ<WO>しんじ"
	line "うまれたときから　ずっと　ここで"
	cont "ひみつ<NO>しゅぎょう<WO>している"

	para "そ<NO>おかげで"
	line "ほか<NO>ひとに<WA>みえない　ものも"
	cont "みえるよう<NI>なった"

	para "もうすこし<⋯>"

	para "もうすこしで"
	line "でんせつ<NO>#<NI>あえる"
	cont "そんな　みらい<GA>みえそうなんだ"

	para "そのため<NO>しゅぎょう"
	line "きみ　にも"
	cont "きょうりょく　してもらうよ"
	done

MortyWinLossText:
	text "まだ　たりないのか"

	para "わかった"
	line "こ<NO>バッジ<WA>きみ<NO>ものだよ！"
	done

Text_ReceivedFogBadge:
	text "<PLAYER><WA>マツバから"
	line "ファントムバッジ<WO>もらっ<TA!>"
	done

MortyText_FogBadgeSpeech:
	text "ファントムバッジ<WO>も<TTE>いると"
	line "レベル５０まで<NO>#なら"
	cont "どんな#も　きみ<NI>したがう"

	para "あと　なみのり　という"
	line "わざ<GA>つかえるようになる"

	para "それから　これも　ゆずろう"
	done

MortyText_ShadowBallSpeech:
	text "なかみ<WA>シャドーボール"

	para "ただ　<KOUGEKI>　するだけでなく"
	line "まれ<NI>とくしゅぼうぎょも　さげる"

	para "きにいったら　つかうと　いいよ"
	done

MortyFightDoneText:
	text "そうか"

	para "きみ<WA>いろんなところ<WO>ぼうけんし"
	line "ぼく<NO>しらない　ものを"
	cont "いろいろと　みてきたんだね<⋯>"

	para "それも　うらやましいな"
	done

SageJeffreySeenText:
	text "#と　いっしょ<NI>はるをすごし"
	line "なつから　あき　そして　ふゆ"
	cont "すると　また　はる<GA>きて<⋯>"

	para "そうして　<WATASHI>たち<WA>ずっと"
	line "#と　くらしてきたのです"
	done

SageJeffreyBeatenText:
	text "かちも　まけも"
	line "いっぱい　ありましたよ"
	done

SageJeffreyAfterBattleText:
	text "#<WA>どこから　きたのかのう"
	done

SagePingSeenText:
	text "<WATASHI>たち<NO>#に"
	line "ダメージ<WO>あたえられるか？"
	done

SagePingBeatenText:
	text "おお　なかなか！"
	done

SagePingAfterBattleText:
	text "<WATASHI>たち<GA>くりだす　#は"
	line "ゴーストタイプ　ばかり"

	para "ノーマルタイプ<NO><KOUGEKI>　じゃ"
	line "ダメージ<WO>あたえられない！"
	done

MediumMarthaSeenText:
	text "かっ　かーつっ！！"
	done

MediumMarthaBeatenText:
	text "まっ　まけたー！"
	done

MediumMarthaAfterBattleText:
	text "さいご<WA>かちたい　という"
	line "きもち<NO>つよいほう<GA>かつ！"
	done

MediumGraceSeenText:
	text "みえない　ゆか<NI>とまど<TTE>おるな"
	line "<WATASHI><NI>かてたら"
	cont "いいこと<WO>おしえてやるぞよ！"
	done

MediumGraceBeatenText:
	text "なな　なんとっ！"
	done

MediumGraceAfterBattleText:
	text "よかろう"
	line "みえない　ゆか<NO>なぞ　おしえよう"

	para "<WATASHI>たち<NO>め<NO>まえ"
	line "そこ<NI>みち<WA>ある！"
	done

EcruteakGymGuideText:
	text "ここ<NO><TRAINER>たちは"
	line "ひみつ<NO>もくてき<GA>あ<TTE>"
	cont "しゅぎょう<WO>つづけていると　いう"

	para "かてば　エンジュ<NO>ひみつ<NI>ついて"
	line "なにか　おしえて　もらえるかもな"
	done

EcruteakGymGuideWinText:
	text "ふはー　<PLAYER>"
	line "よく　かてたな！"

	para "おれなんか　こわくて"
	line "すみっこで　ふるえてたぜ"
	done

EcruteakGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, ECRUTEAK_CITY, 10
	warp_event  5, 17, ECRUTEAK_CITY, 10
	warp_event  4, 14, ECRUTEAK_GYM, 4
	warp_event  2,  4, ECRUTEAK_GYM, 3
	warp_event  3,  4, ECRUTEAK_GYM, 3
	warp_event  4,  4, ECRUTEAK_GYM, 3
	warp_event  4,  5, ECRUTEAK_GYM, 3
	warp_event  6,  7, ECRUTEAK_GYM, 3
	warp_event  7,  4, ECRUTEAK_GYM, 3
	warp_event  2,  6, ECRUTEAK_GYM, 3
	warp_event  3,  6, ECRUTEAK_GYM, 3
	warp_event  4,  6, ECRUTEAK_GYM, 3
	warp_event  5,  6, ECRUTEAK_GYM, 3
	warp_event  7,  6, ECRUTEAK_GYM, 3
	warp_event  7,  7, ECRUTEAK_GYM, 3
	warp_event  4,  8, ECRUTEAK_GYM, 3
	warp_event  5,  8, ECRUTEAK_GYM, 3
	warp_event  6,  8, ECRUTEAK_GYM, 3
	warp_event  7,  8, ECRUTEAK_GYM, 3
	warp_event  2,  8, ECRUTEAK_GYM, 3
	warp_event  2,  9, ECRUTEAK_GYM, 3
	warp_event  2, 10, ECRUTEAK_GYM, 3
	warp_event  2, 11, ECRUTEAK_GYM, 3
	warp_event  4, 10, ECRUTEAK_GYM, 3
	warp_event  5, 10, ECRUTEAK_GYM, 3
	warp_event  2, 12, ECRUTEAK_GYM, 3
	warp_event  3, 12, ECRUTEAK_GYM, 3
	warp_event  4, 12, ECRUTEAK_GYM, 3
	warp_event  5, 12, ECRUTEAK_GYM, 3
	warp_event  7, 10, ECRUTEAK_GYM, 3
	warp_event  7, 11, ECRUTEAK_GYM, 3
	warp_event  7, 12, ECRUTEAK_GYM, 3
	warp_event  7, 13, ECRUTEAK_GYM, 3

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, EcruteakGymStatue
	bg_event  6, 15, BGEVENT_READ, EcruteakGymStatue

	def_object_events
	object_event  5,  1, SPRITE_MORTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, EcruteakGymMortyScript, -1
	object_event  2,  7, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerSageJeffrey, -1
	object_event  3, 13, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSagePing, -1
	object_event  7,  5, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 1, TrainerMediumMartha, -1
	object_event  7,  9, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 1, TrainerMediumGrace, -1
	object_event  7, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EcruteakGymGuideScript, -1
