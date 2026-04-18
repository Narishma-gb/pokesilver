	object_const_def
	const OLIVINEGYM_JASMINE
	const OLIVINEGYM_GYM_GUIDE

OlivineGym_MapScripts:
	def_scene_scripts

	def_callbacks

OlivineGymJasmineScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_JASMINE
	iftrue .FightDone
	writetext Jasmine_SteelTypeIntro
	waitbutton
	closetext
	winlosstext Jasmine_BetterTrainer, 0
	loadtrainer JASMINE, JASMINE1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_JASMINE
	opentext
	writetext Text_ReceivedMineralBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_MINERALBADGE
	readvar VAR_BADGES
	scall OlivineGymActivateRockets
.FightDone:
	checkevent EVENT_GOT_TM23_IRON_TAIL
	iftrue .GotIronTail
	writetext Jasmine_BadgeSpeech
	promptbutton
	verbosegiveitem TM_IRON_TAIL
	iffalse .NoRoomForIronTail
	setevent EVENT_GOT_TM23_IRON_TAIL
	writetext Jasmine_IronTailSpeech
	waitbutton
	closetext
	end

.GotIronTail:
	writetext Jasmine_GoodLuck
	waitbutton
.NoRoomForIronTail:
	closetext
	end

OlivineGymActivateRockets:
	ifequal 7, .RadioTowerRockets
	ifequal 6, .GoldenrodRockets
	end

.GoldenrodRockets:
	jumpstd GoldenrodRocketsScript

.RadioTowerRockets:
	jumpstd RadioTowerRocketsScript

OlivineGymGuideScript:
	faceplayer
	checkevent EVENT_BEAT_JASMINE
	iftrue .OlivineGymGuideWinScript
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iffalse .OlivineGymGuidePreScript
	opentext
	writetext OlivineGymGuideText
	waitbutton
	closetext
	end

.OlivineGymGuideWinScript:
	opentext
	writetext OlivineGymGuideWinText
	waitbutton
	closetext
	end

.OlivineGymGuidePreScript:
	opentext
	writetext OlivineGymGuidePreText
	waitbutton
	closetext
	end

OlivineGymStatue:
	checkflag ENGINE_MINERALBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, JASMINE, JASMINE1
	jumpstd GymStatue2Script

Jasmine_SteelTypeIntro:
	text "<⋯>　とうだい　では"
	line "ありがとう　ございました"

	para "<⋯>　でも　しょうぶ<WA>べつですね"
	line "あらためて　じこしょうかい　します"

	para "<WATASHI><WA>ジムリーダー<NO>ミカン"
	line "つかう　#は"
	cont "はがねタイプ　です"

	para "<⋯>　はがねタイプ<TTE>"
	line "ごぞんじ　ですか？"

	para "さいきん　みつかったばかりの"
	line "#<NO>タイプ　なんですの"

	para "<⋯>　あ　あのう"
	line "で<WA>はじめますね"
	done

Jasmine_BetterTrainer:
	text "<⋯>　#　<TRAINER>として"
	line "あなたのほう<GA>うわて　みたい"
	cont "つよさも　やさしさも　ね"

	para "<⋯>　で<WA>リーグ<NO>きまりどおり"
	line "バッジ<WO><WATASHI>ます"
	done

Text_ReceivedMineralBadge:
	text "<PLAYER><WA>ミカンから"
	line "スチールバッジ<WO>もらっ<TA!>"
	done

Jasmine_BadgeSpeech:
	text "<⋯>　スチールバッジには"
	line "#<NO>ぼうぎょ　りょくを"
	cont "あげる　こうか<GA>あるの"

	para "<⋯>　あのう　あと　これも　どうぞ"
	done

Text_ReceivedTM09: ; unreferenced
	text "<PLAYER><WA>ミカンから"
	line "<TM>０９<WO>もらっ<TA!>"
	done

Jasmine_IronTailSpeech:
	text "<⋯>　そ<NO><TM><WO>つかうと"
	line "アイアンテール<WO>おしえられます"
	done

Jasmine_GoodLuck:
	text "あ　あの<⋯>"
	line "あんまり　うまく　いえないけど"

	para "<⋯>　がんば<TTE>　くださいね"
	done

OlivineGymGuideText:
	text "ミカン<GA>つかう　#は"
	line "はっけん　されたばかりの"
	cont "はがね<TTE>　タイプ<WO>も<TTE>る"

	para "どんな　とくちょうか　"
	line "おれにも　よく　わか<TTE>ないんだ"
	done

OlivineGymGuideWinText:
	text "いやあ　すごかったな"
	line "はがねタイプ<⋯>"
	cont "まさ<NI>みちとのそうぐう　だったな！"
	done

OlivineGymGuidePreText:
	text "ジムリーダー<NO>ミカン"
	line "とうだい<NO>#の"
	cont "ぐあい　わるいから<TTE>"
	cont "ずっと　かんびょう　しているぜ"

	para "つよい　<TRAINER>というのは"
	line "やさしさも　も<TTE>いるんだな"
	done

OlivineGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 15, OLIVINE_CITY, 2
	warp_event  5, 15, OLIVINE_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, OlivineGymStatue
	bg_event  6, 13, BGEVENT_READ, OlivineGymStatue

	def_object_events
	object_event  5,  3, SPRITE_JASMINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineGymJasmineScript, EVENT_OLIVINE_GYM_JASMINE
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineGymGuideScript, -1
