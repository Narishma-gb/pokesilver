	object_const_def
	const MAHOGANYGYM_PRYCE
	const MAHOGANYGYM_BEAUTY1
	const MAHOGANYGYM_ROCKER1
	const MAHOGANYGYM_BEAUTY2
	const MAHOGANYGYM_ROCKER2
	const MAHOGANYGYM_ROCKER3
	const MAHOGANYGYM_GYM_GUIDE

MahoganyGym_MapScripts:
	def_scene_scripts

	def_callbacks

MahoganyGymPryceScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_PRYCE
	iftrue .FightDone
	writetext PryceText_Intro
	waitbutton
	closetext
	winlosstext PryceText_Impressed, 0
	loadtrainer PRYCE, PRYCE1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_PRYCE
	opentext
	writetext Text_ReceivedGlacierBadge
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_GLACIERBADGE
	readvar VAR_BADGES
	scall MahoganyGymActivateRockets
.FightDone:
	checkevent EVENT_GOT_TM16_ICY_WIND
	iftrue PryceScript_Defeat
	setevent EVENT_BEAT_SKIER_ROXANNE
	setevent EVENT_BEAT_SKIER_CLARISSA
	setevent EVENT_BEAT_BOARDER_RONALD
	setevent EVENT_BEAT_BOARDER_BRAD
	setevent EVENT_BEAT_BOARDER_DOUGLAS
	writetext PryceText_GlacierBadgeSpeech
	promptbutton
	verbosegiveitem TM_ICY_WIND
	iffalse MahoganyGym_NoRoomForIcyWind
	setevent EVENT_GOT_TM16_ICY_WIND
	writetext PryceText_IcyWindSpeech
	waitbutton
	closetext
	end

PryceScript_Defeat:
	writetext PryceText_CherishYourPokemon
	waitbutton
MahoganyGym_NoRoomForIcyWind:
	closetext
	end

MahoganyGymActivateRockets:
	ifequal 7, .RadioTowerRockets
	ifequal 6, .GoldenrodRockets
	end

.GoldenrodRockets:
	jumpstd GoldenrodRocketsScript

.RadioTowerRockets:
	jumpstd RadioTowerRocketsScript

TrainerSkierRoxanne:
	trainer SKIER, ROXANNE, EVENT_BEAT_SKIER_ROXANNE, SkierRoxanneSeenText, SkierRoxanneBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SkierRoxanneAfterBattleText
	waitbutton
	closetext
	end

TrainerSkierClarissa:
	trainer SKIER, CLARISSA, EVENT_BEAT_SKIER_CLARISSA, SkierClarissaSeenText, SkierClarissaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SkierClarissaAfterBattleText
	waitbutton
	closetext
	end

TrainerBoarderRonald:
	trainer BOARDER, RONALD, EVENT_BEAT_BOARDER_RONALD, BoarderRonaldSeenText, BoarderRonaldBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BoarderRonaldAfterBattleText
	waitbutton
	closetext
	end

TrainerBoarderBrad:
	trainer BOARDER, BRAD, EVENT_BEAT_BOARDER_BRAD, BoarderBradSeenText, BoarderBradBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BoarderBradAfterBattleText
	waitbutton
	closetext
	end

TrainerBoarderDouglas:
	trainer BOARDER, DOUGLAS, EVENT_BEAT_BOARDER_DOUGLAS, BoarderDouglasSeenText, BoarderDouglasBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BoarderDouglasAfterBattleText
	waitbutton
	closetext
	end

MahoganyGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_PRYCE
	iftrue .MahoganyGymGuideWinScript
	writetext MahoganyGymGuideText
	waitbutton
	closetext
	end

.MahoganyGymGuideWinScript:
	writetext MahoganyGymGuideWinText
	waitbutton
	closetext
	end

MahoganyGymStatue:
	checkflag ENGINE_GLACIERBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, PRYCE, PRYCE1
	jumpstd GymStatue2Script

PryceText_Intro:
	text "#も　ひとも"
	line "いきていると　いろいろ　ある"

	para "<WATASHI>も　いろいろ"
	line "つらいこと<WO>あじわった"

	para "じんせい<NO>せんぱい　として"
	line "それ<WO>おしえて　やろう"

	para "きみ<GA>うまれるまえから"
	line "#と　いっしょ<NI>いる"
	cont "おいそれと　まけたり<WA>せん"

	para "ふゆ<NO>ヤナギと　よばれる"
	line "そ<NO>じつりょく　みせてやろうかの"
	done

PryceText_Impressed:
	text "うんうん"
	line "みごとな　たたかいっぷり"

	para "そ<NO>つよい　きもち<GA>あれば"
	line "なに<GA>あ<TTE>も"
	cont "のりこえて　いけるだろうよ"

	para "うむ！"
	line "こ<NO>バッジ<WO>も<TTE>いきなさい"
	done

Text_ReceivedGlacierBadge:
	text "<PLAYER><WA>ヤナギから"
	line "アイスバッジ<WO>もらっ<TA!>"
	done

PryceText_GlacierBadgeSpeech:
	text "それ<WO>も<TTE>おると"
	line "とくしゅのうりょく<GA>たかくなる"

	para "それから"
	line "あれくるう　うず<NO>うえ<WO>すすめる"
	cont "うずしお　なる　わざも　つかえる"

	para "それから　こいつは"
	line "わしから<NO>せんべつ　だよ"
	done

PryceText_IcyWindSpeech:
	text "そいつ<WA>こごえるかぜ"

	para "ダメージ<WO>あたえつつ"
	line "すばやさ<WO>さげる<⋯>"

	para "まさ<NI>ふゆ<NO>きびしさを"
	line "かんじさせる　わざ　よ"
	done

PryceText_CherishYourPokemon:
	text "こおりと　ゆき<GA>とければ<⋯>"
	line "はる<NI>なる"

	para "きみ<WA>これから　ながいじかん"
	line "#と　いっしょ<NI>いられる"
	cont "それ<WO>たいせつ　にな"
	done

BoarderRonaldSeenText:
	text "きみ<NO>#　こおらせて"
	line "なにも　できなく　してやるぜ！"
	done

BoarderRonaldBeatenText:
	text "こっち<GA>なにも　できなかったか"
	done

BoarderRonaldAfterBattleText:
	text "そういえば<⋯>　こおらされても"
	line "つかえる　わざも　あるらしいな"
	done

BoarderBradSeenText:
	text "こ<NO>チョウジジムは"
	line "つるつる　すべ<TTE>　たのしいだろ？"

	para "だから<TTE>　オレたち"
	line "あそんでるわけじゃ　ないぜ！"
	done

BoarderBradBeatenText:
	text "すこし<WA>オレたち<NO>ほんき"
	line "わか<TTE>くれたか？"
	done

BoarderBradAfterBattleText:
	text "こ<NO>ジム<WA>いいぜ"
	line "いつだ<TTE>　#と　いっしょに"
	cont "すべ<TTE>　いられるもんな！"
	done

BoarderDouglasSeenText:
	text "おれ<WA>ヤナギさん<NO>つよさ"
	line "そ<NO>ひみつ<WO>し<TTE>いるぜ！"
	done

BoarderDouglasBeatenText:
	text "しょうがない"
	line "ひみつ<WO>おしえて　やろう"
	done

BoarderDouglasAfterBattleText:
	text "ヤナギさん<GA>つよい　りゆう<⋯>"

	para "それ<WA>まいにち"
	line "つめたい　たき<NI>うたれて"
	cont "みも　こころも　きたえてるからだ！"
	done

SkierRoxanneSeenText:
	text "ジムリーダー<NO>ヤナギさんに"
	line "あいたいなら　かんがえて"
	cont "すべる　ひつよう<GA>あるわよ！"
	done

SkierRoxanneBeatenText:
	text "もおー"
	line "スキーだったら　まけてないのに<⋯>"
	done

SkierRoxanneAfterBattleText:
	text "きちんと　すべらないと"
	line "いきたいところへ　いけないのが"
	cont "このジム<NO>だいごみ　なのよね"
	done

SkierClarissaSeenText:
	text "みてよ！　かれいな　シュプール！！"
	done

SkierClarissaBeatenText:
	text "いやん！"
	line "びっくりして　しりもち　ついちゃった"
	done

SkierClarissaAfterBattleText:
	text "#しょうぶ　なのに"
	line "スキーのうでまえ　じまん　しちゃった"
	done

MahoganyGymGuideText:
	text "ヤナギさん<WA>#と　５０ねんも"
	line "つきあ<TTE>いる　つわもの！"

	para "こおりタイプ<NO>わざで"
	line "あいて<NO>#を"
	cont "こおらせるの<GA>とくい　という！"

	para "だったら　こっちは"
	line "もえる　じょうねつで　とかしてやれ！"
	done

MahoganyGymGuideWinText:
	text "ヤナギさんも　すごいが"
	line "かった　おまえも　すごかったぞ！"

	para "ねんれい<WO>こえた"
	line "あつい　バトル　だったぜ！"
	done

MahoganyGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, MAHOGANY_TOWN, 3
	warp_event  5, 17, MAHOGANY_TOWN, 3

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, MahoganyGymStatue
	bg_event  6, 15, BGEVENT_READ, MahoganyGymStatue

	def_object_events
	object_event  5,  3, SPRITE_PRYCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, MahoganyGymPryceScript, -1
	object_event  4,  6, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerSkierRoxanne, -1
	object_event  0, 17, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerBoarderRonald, -1
	object_event  9, 17, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerSkierClarissa, -1
	object_event  5,  9, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerBoarderBrad, -1
	object_event  2,  4, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerBoarderDouglas, -1
	object_event  7, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, MahoganyGymGuideScript, -1
