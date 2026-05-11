	object_const_def
	const PEWTERGYM_BROCK
	const PEWTERGYM_YOUNGSTER
	const PEWTERGYM_GYM_GUIDE

PewterGym_MapScripts:
	def_scene_scripts

	def_callbacks

PewterGymBrockScript:
	faceplayer
	opentext
	checkflag ENGINE_BOULDERBADGE
	iftrue .FightDone
	writetext BrockIntroText
	waitbutton
	closetext
	winlosstext BrockWinLossText, 0
	loadtrainer BROCK, BROCK1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_BROCK
	setevent EVENT_BEAT_CAMPER_JERRY
	opentext
	writetext ReceivedBoulderBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_BOULDERBADGE
	writetext BrockBoulderBadgeText
	waitbutton
	closetext
	end

.FightDone:
	writetext BrockFightDoneText
	waitbutton
	closetext
	end

TrainerCamperJerry:
	trainer CAMPER, JERRY, EVENT_BEAT_CAMPER_JERRY, CamperJerrySeenText, CamperJerryBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CamperJerryAfterBattleText
	waitbutton
	closetext
	end

PewterGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_BROCK
	iftrue .PewterGymGuideWinScript
	writetext PewterGymGuideText
	waitbutton
	closetext
	end

.PewterGymGuideWinScript:
	writetext PewterGymGuideWinText
	waitbutton
	closetext
	end

PewterGymStatue:
	checkflag ENGINE_BOULDERBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, BROCK, BROCK1
	jumpstd GymStatue2Script

BrockIntroText:
	text "タケシ『ジョウトから"
	line "ちょうせんと<WA>めずらしい！"

	para "おれ<WA>ニビ　#　ジム"
	line "リーダー<NO>タケシ！"
	cont "いわ　タイプ<NO>エキスパートさ！"

	para "ちょっとや　そっと<NO><KOUGEKI>じゃ"
	line "おれ<NO>#たち<WA>へいき"
	cont "いたくも　かゆくも　ないぜ！"

	para "かか<TTE>こい！"
	done

BrockWinLossText:
	text "タケシ『<⋯>まもり<WO>うわまわる"
	line "きょうれつな　<KOUGEKI><⋯>"
	cont "おれ<NO>よそう　いじょうだ<⋯>！"

	para "さあ　こ<NO>バッジを"
	line "も<TTE>い<TTE>　くれ！"
	done

ReceivedBoulderBadgeText:
	text "<PLAYER><WA>タケシから"
	line "グレーバッジ<WO>もらっ<TA!>"
	done

BrockBoulderBadgeText:
	text "タケシ『ありがとう"
	line "<PLAYER>くん！"
	cont "いい　しあい<GA>でき<TA!>"

	para "ぼく<NO>グレーバッジで"
	line "きみ<NO>#は"
	cont "さら<NI>つよくなるよ"
	cont "ちょっと　くやしい　けどね！"
	done

BrockFightDoneText:
	text "タケシ『よのなか<WA>ひろいな<⋯>"
	line "こんな<NI>つよい　<TRAINER>が"
	cont "まだまだ　たくさん　いるんだ"

	para "おれも　もっと　もっと"
	line "つよい　<TRAINER><NI>なるよ！"
	done

CamperJerrySeenText:
	text "<KOKO_WA>いわ　#を"
	line "あつかう　<TRAINER><NO>ジム！"

	para "いわタイプ<WA>ぼうぎょりょくが"
	line "たかい　からな！"

	para "たたかい<GA>ながびくぜ！"
	line "かくご　しろよ！"
	done

CamperJerryBeatenText:
	text "たたかい<WA>かたなくちゃ<⋯>"
	done

CamperJerryAfterBattleText:
	text "タケシさん<WA>つよいぜ！"
	line "ゆだん　すると　いたい　め<NI>あうぜ"
	cont "ジョウト<NO><TRAINER>！"
	done

PewterGymGuideText:
	text "おーす　みらい<NO>チャンピオン！"
	line "ちょうし　よさそう　だなあ！"

	para "カントー<NO>ジム　リーダーと"
	line "たたか<TTE>るかい？"

	para "ジョウト<NI>まけず　おとらず"
	line "てごわい　ヤツら　だぜ！"
	done

PewterGymGuideWinText:
	text "さす<GA>みらい<NO>チャンピオン！"
	line "あぶなげない　たたかい　だったぜ！"
	cont "かんどう　したよ　いや　ホント！"
	done

PewterGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 13, PEWTER_CITY, 2
	warp_event  5, 13, PEWTER_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  2, 11, BGEVENT_READ, PewterGymStatue
	bg_event  7, 11, BGEVENT_READ, PewterGymStatue

	def_object_events
	object_event  5,  1, SPRITE_BROCK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, PewterGymBrockScript, -1
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerCamperJerry, -1
	object_event  6, 11, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 1, PewterGymGuideScript, -1
