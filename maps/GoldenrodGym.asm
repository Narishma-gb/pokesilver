	object_const_def
	const GOLDENRODGYM_WHITNEY
	const GOLDENRODGYM_LASS1
	const GOLDENRODGYM_LASS2
	const GOLDENRODGYM_BEAUTY1
	const GOLDENRODGYM_BEAUTY2
	const GOLDENRODGYM_GYM_GUIDE

GoldenrodGym_MapScripts:
	def_scene_scripts
	scene_script GoldenrodGymNoop1Scene, SCENE_GOLDENRODGYM_NOOP
	scene_script GoldenrodGymNoop2Scene, SCENE_GOLDENRODGYM_WHITNEY_STOPS_CRYING

	def_callbacks

GoldenrodGymNoop1Scene:
	end

GoldenrodGymNoop2Scene:
	end

GoldenrodGymWhitneyScript:
	faceplayer
	checkevent EVENT_BEAT_WHITNEY
	iftrue .FightDone
	opentext
	writetext WhitneyBeforeText
	waitbutton
	closetext
	winlosstext WhitneyShouldntBeSoSeriousText, 0
	loadtrainer WHITNEY, WHITNEY1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_WHITNEY
	setevent EVENT_MADE_WHITNEY_CRY
	setscene SCENE_GOLDENRODGYM_WHITNEY_STOPS_CRYING
	setevent EVENT_BEAT_BEAUTY_VICTORIA
	setevent EVENT_BEAT_BEAUTY_SAMANTHA
	setevent EVENT_BEAT_LASS_CARRIE
	setevent EVENT_BEAT_LASS_BRIDGET
.FightDone:
	opentext
	checkevent EVENT_MADE_WHITNEY_CRY
	iffalse .StoppedCrying
	writetext WhitneyYouMeanieText
	waitbutton
	closetext
	end

.StoppedCrying:
	checkevent EVENT_GOT_TM45_ATTRACT
	iftrue .GotAttract
	checkflag ENGINE_PLAINBADGE
	iftrue .GotPlainBadge
	writetext WhitneyWhatDoYouWantText
	promptbutton
	waitsfx
	writetext PlayerReceivedPlainBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_PLAINBADGE
	readvar VAR_BADGES
	scall GoldenrodGymActivateRockets
.GotPlainBadge:
	writetext WhitneyPlainBadgeText
	promptbutton
	verbosegiveitem TM_ATTRACT
	iffalse .NoRoomForAttract
	setevent EVENT_GOT_TM45_ATTRACT
	writetext WhitneyAttractText
	waitbutton
	closetext
	end

.GotAttract:
	writetext WhitneyGoodCryText
	waitbutton
.NoRoomForAttract:
	closetext
	end

GoldenrodGymActivateRockets:
	ifequal 7, .RadioTowerRockets
	ifequal 6, .GoldenrodRockets
	end

.GoldenrodRockets:
	jumpstd GoldenrodRocketsScript

.RadioTowerRockets:
	jumpstd RadioTowerRocketsScript

TrainerLassCarrie:
	trainer LASS, CARRIE, EVENT_BEAT_LASS_CARRIE, LassCarrieSeenText, LassCarrieBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext LassCarrieAfterBattleText
	waitbutton
	closetext
	end

WhitneyCriesScript:
	showemote EMOTE_SHOCK, GOLDENRODGYM_LASS2, 15
	applymovement GOLDENRODGYM_LASS2, BridgetWalksUpMovement
	turnobject PLAYER, DOWN
	opentext
	writetext BridgetWhitneyCriesText
	waitbutton
	closetext
	applymovement GOLDENRODGYM_LASS2, BridgetWalksAwayMovement
	setscene SCENE_GOLDENRODGYM_NOOP
	clearevent EVENT_MADE_WHITNEY_CRY
	end

TrainerLassBridget:
	trainer LASS, BRIDGET, EVENT_BEAT_LASS_BRIDGET, LassBridgetSeenText, LassBridgetBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext LassBridgetAfterBattleText
	waitbutton
	closetext
	end

TrainerBeautyVictoria:
	trainer BEAUTY, VICTORIA, EVENT_BEAT_BEAUTY_VICTORIA, BeautyVictoriaSeenText, BeautyVictoriaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BeautyVictoriaAfterBattleText
	waitbutton
	closetext
	end

TrainerBeautySamantha:
	trainer BEAUTY, SAMANTHA, EVENT_BEAT_BEAUTY_SAMANTHA, BeautySamanthaSeenText, BeautySamanthaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BeautySamanthaAfterBattleText
	waitbutton
	closetext
	end

GoldenrodGymGuideScript:
	faceplayer
	checkevent EVENT_BEAT_WHITNEY
	iftrue .GoldenrodGymGuideWinScript
	opentext
	writetext GoldenrodGymGuideText
	waitbutton
	closetext
	end

.GoldenrodGymGuideWinScript:
	opentext
	writetext GoldenrodGymGuideWinText
	waitbutton
	closetext
	end

GoldenrodGymStatue:
	checkflag ENGINE_PLAINBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, WHITNEY, WHITNEY1
	jumpstd GymStatue2Script

BridgetWalksUpMovement:
	step LEFT
	turn_head UP
	step_end

BridgetWalksAwayMovement:
	step RIGHT
	turn_head LEFT
	step_end

WhitneyBeforeText:
	text "はーい！"
	line "うち<GA>アカネちゃーん！！"

	para "みんな　#　や<TTE>るやん"
	line "うちも　はじめたら"
	cont "もー　めっちゃ　かわいーて！"

	para "えー　ちょうせん　するの？"
	line "ゆうとくけど　うち"
	cont "めっちゃ　つよいで！"
	done

WhitneyShouldntBeSoSeriousText:
	text "うう<⋯>"

	para "<⋯>　うわーん！！"
	line "ひどいよ　ひどいよ！！"

	para "むき<NI>なんないでよ！！"
	line "もお　こども　なんやから<⋯>"
	done

WhitneyYouMeanieText:
	text "わーん！！"

	para "わーん！！"

	para "<⋯>　ぐっすん　ひっぐ"
	line "<⋯>　ひどいよお！！"
	done

WhitneyWhatDoYouWantText:
	text "<⋯>ぐすん"

	para "なに？　まだ　なんか　あるの？"
	line "ああ　バッジ？"

	para "ごめん　わすれてた"
	line "はい　レギュラーバッジ"
	cont "これ<GA>ほしいんでしょ！"
	done

PlayerReceivedPlainBadgeText:
	text "<PLAYER><WA>アカネから"
	line "レギュラーバッジ<WO>もらっ<TA!>"
	done

WhitneyPlainBadgeText:
	text "レギュラーバッジ<WO>も<TTE>ると"
	line "たたか<TTE>ない　ときでも"
	cont "かいりき<NO>わざ<GA>つかえるし"
	cont "#<NO>すばやさも　あがるんよ"

	para "あと<WA>これも　あげる！"
	done

WhitneyAttractText:
	text "なかみ<WA>メロメロ　ゆーて"
	line "#<NO>みりょくを"
	cont "さいだいげん<NI>つかう　わざ　やねん"
	cont "かわいー　うち<NI>ぴったし　やろ？"
	done

WhitneyGoodCryText:
	text "ふう！"
	line "ないたら　すっきり　しちゃっ<TA!>"

	para "ほな　また　あそび<NI>おいでーな！"
	line "バイバイ！"
	done

LassCarrieSeenText:
	text "おんなのこ　だから<TTE>"
	line "ゆだん　しないほう<GA>いいわよ！"
	done

LassCarrieBeatenText:
	text "やっちゃった<⋯>"
	line "あたし<GA>ゆだん　しちゃったみたい"
	done

LassCarrieAfterBattleText:
	text "#<NO>せかい　では"
	line "メスと　オス"
	cont "どっち<GA>つよいのかしら？"
	done

LassBridgetSeenText:
	text "つよい　#　より"
	line "かわいい　#<GA>すきー！"

	para "でも　あたし<GA>も<TTE>るのは"
	line "つよくて　かわいい　#よ！"
	done

LassBridgetBeatenText:
	text "あーん　ダメダメー！"
	done

LassBridgetAfterBattleText:
	text "アカネちゃん<NI>かてるよう"
	line "がんば<TTE>るの<NI>まだまだ　なのかな"
	cont "なーんか　おちこんじゃう<⋯>"

	para "なーんてね"
	line "まけたら　つぎ　がんばればいいのよ！"
	done

BridgetWhitneyCriesText:
	text "あーあ　アカネちゃん"
	line "なかしちゃったのね"

	para "だいじょうぶ！"
	line "しばらくしたら　なきやむから"
	cont "まけると　いつも　ないちゃうのよ"
	done

BeautyVictoriaSeenText:
	text "あら　かわいい　<TRAINER>ね！"
	line "おねーさん　きにいっちゃっ<TA!>"
	cont "でも　てかげん<WA>しないわよ！"
	done

BeautyVictoriaBeatenText:
	text "えーと<⋯>"
	line "あら　おわ<TTE>る？"
	done

BeautyVictoriaAfterBattleText:
	text "おねーさん<WO>まかすなんて"
	line "すごい　すごーい！"
	cont "そ<NO>ちょうしで　がんば<TTE>ね"
	done

BeautySamanthaSeenText:
	text "ほんきで　こないと"
	line "きつーい<NO>おみまい　しちゃうわよ！"
	done

BeautySamanthaBeatenText:
	text "いやーん！！"
	line "ごめんね　<WATASHI><NO>ニャースちゃん"
	done

BeautySamanthaAfterBattleText:
	text "どんな　タイプ<NO>#も"
	line "<KOUGEKI>　できるように"
	cont "わざ<WO>おしえたんだけどな"
	done

GoldenrodGymGuideText:
	text "おーす！"
	line "みらい<NO>チャンピオン！"

	para "こ<NO>ジムは"
	line "ノーマルタイプ　#の"
	cont "つかいて<GA>あつま<TTE>いる！"

	para "たたかわせる　なら"
	line "かくとうタイプの"
	cont "#<GA>おすすめ　だな！"
	done

GoldenrodGymGuideWinText:
	text "かったか？　それ<WA>よかっ<TA!>"
	line "おれ<WA>おんなのこ<NI>みとれていたよ"
	done

GoldenrodGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2, 17, GOLDENROD_CITY, 1
	warp_event  3, 17, GOLDENROD_CITY, 1

	def_coord_events
	coord_event  8,  5, SCENE_GOLDENRODGYM_WHITNEY_STOPS_CRYING, WhitneyCriesScript

	def_bg_events
	bg_event  1, 15, BGEVENT_READ, GoldenrodGymStatue
	bg_event  4, 15, BGEVENT_READ, GoldenrodGymStatue

	def_object_events
	object_event  8,  3, SPRITE_WHITNEY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGymWhitneyScript, -1
	object_event  9, 13, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerLassCarrie, -1
	object_event  9,  6, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerLassBridget, -1
	object_event  0,  2, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBeautyVictoria, -1
	object_event 19,  5, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBeautySamantha, -1
	object_event  5, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodGymGuideScript, -1
