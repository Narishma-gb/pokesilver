	object_const_def
	const CELADONGYM_ERIKA
	const CELADONGYM_LASS1
	const CELADONGYM_LASS2
	const CELADONGYM_BEAUTY
	const CELADONGYM_TWIN1
	const CELADONGYM_TWIN2

CeladonGym_MapScripts:
	def_scene_scripts

	def_callbacks

CeladonGymErikaScript:
	faceplayer
	opentext
	checkflag ENGINE_RAINBOWBADGE
	iftrue .FightDone
	writetext ErikaBeforeBattleText
	waitbutton
	closetext
	winlosstext ErikaBeatenText, 0
	loadtrainer ERIKA, ERIKA1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_ERIKA
	setevent EVENT_BEAT_LASS_MICHELLE
	setevent EVENT_BEAT_PICNICKER_TANYA
	setevent EVENT_BEAT_BEAUTY_JULIA
	setevent EVENT_BEAT_TWINS_JO_AND_ZOE
	opentext
	writetext PlayerReceivedRainbowBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_RAINBOWBADGE
.FightDone:
	checkevent EVENT_GOT_TM19_GIGA_DRAIN
	iftrue .GotGigaDrain
	writetext ErikaExplainTMText
	promptbutton
	verbosegiveitem TM_GIGA_DRAIN
	iffalse .GotGigaDrain
	setevent EVENT_GOT_TM19_GIGA_DRAIN
.GotGigaDrain:
	writetext ErikaAfterBattleText
	waitbutton
	closetext
	end

TrainerLassMichelle:
	trainer LASS, MICHELLE, EVENT_BEAT_LASS_MICHELLE, LassMichelleSeenText, LassMichelleBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext LassMichelleAfterBattleText
	waitbutton
	closetext
	end

TrainerPicnickerTanya:
	trainer PICNICKER, TANYA, EVENT_BEAT_PICNICKER_TANYA, PicnickerTanyaSeenText, PicnickerTanyaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PicnickerTanyaAfterBattleText
	waitbutton
	closetext
	end

TrainerBeautyJulia:
	trainer BEAUTY, JULIA, EVENT_BEAT_BEAUTY_JULIA, BeautyJuliaSeenText, BeautyJuliaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BeautyJuliaAfterBattleText
	waitbutton
	closetext
	end

TrainerTwinsJoAndZoe1:
	trainer TWINS, JOANDZOE1, EVENT_BEAT_TWINS_JO_AND_ZOE, TwinsJoAndZoe1SeenText, TwinsJoAndZoe1BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext TwinsJoAndZoe1AfterBattleText
	waitbutton
	closetext
	end

TrainerTwinsJoAndZoe2:
	trainer TWINS, JOANDZOE2, EVENT_BEAT_TWINS_JO_AND_ZOE, TwinsJoAndZoe2SeenText, TwinsJoAndZoe2BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext TwinsJoAndZoe2AfterBattleText
	waitbutton
	closetext
	end

CeladonGymStatue:
	checkflag ENGINE_RAINBOWBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, ERIKA, ERIKA1
	jumpstd GymStatue2Script

ErikaBeforeBattleText:
	text "エリカ『はあーい<⋯>"
	line "よい　おてんき　ですね"
	cont "<⋯>　つい　ウトウト"
	cont "ねむ<TTE>　しまい　そうだわ<⋯>"

	para "わたくし　タマムシ　ジムの"
	line "エリカと　もうします"

	para "<⋯>　<⋯>まあ！"
	line "ジョウトから　はるばると"

	para "<⋯>　えっ"
	line "しあい<NO>もうしこみ　ですの？"

	para "そんな<⋯>"
	line "わたくし　まけませんわよ"
	done

ErikaBeatenText:
	text "エリカ『<⋯>！"
	line "まいり　ましたわ"

	para "おつよい　ですのね<⋯>"

	para "こ<NO>レインボーバッジ"
	line "さしあげますわ"
	done

PlayerReceivedRainbowBadgeText:
	text "<PLAYER>は"
	line "レインボーバッジ<WO>もらっ<TA!>"
	done

ErikaExplainTMText:
	text "エリカ『すばらしい　しあい　でしたわ"
	line "わたくし　かんどう　いたしました"
	cont "こ<NO><TM><WO>さしあげますわ"

	para "ギガドレイン　とい<TTE>"
	line "あたえた　ダメージ<NO>はんぶんが"
	cont "#<NO>えいよう<NI>なる"
	cont "すばらしい　わざ　です"

	para "よろしかったら"
	line "おつかい<NI>な<TTE>"
	done

ErikaAfterBattleText:
	text "エリカ『まける　というのは"
	line "くやしい　も<NO>ですね<⋯>"

	para "しかし　つよい　かた<GA>いらっしゃる"
	line "こと<WA>はげみにも　なりますわ"
	done

LassMichelleSeenText:
	text "<KOKO_WA>ねー！"
	line "おんなのこ　しか"
	cont "はいっちゃ　いけないの！"
	done

LassMichelleBeatenText:
	text "ああん　くやしい！"
	done

LassMichelleAfterBattleText:
	text "べつ<NI>おとこのこが"
	line "きらい<TTE>　わけ　じゃないの"

	para "おんなのこ　どうし　でしか"
	line "できない　はなしも　あるでしょ"
	done

PicnickerTanyaSeenText:
	text "えーっ　#しょうぶ　なの？"
	line "どきどき　するけど　や<TTE>みようかな"
	done

PicnickerTanyaBeatenText:
	text "えーっ　ウソでしょー"
	done

PicnickerTanyaAfterBattleText:
	text "えーっ　そんな<NI>バッジも<TTE>るの"
	line "だったら　かてないよお"
	done

BeautyJuliaSeenText:
	text "あら？　おはなと　<WATASHI>"
	line "どっち<NI>みとれたの？"
	done

BeautyJuliaBeatenText:
	text "やあねえ　もう！"
	done

BeautyJuliaAfterBattleText:
	text "どうしたら　エリカさん　みたいに"
	line "おしとやか<NI>なれるのかしら？"
	done

TwinsJoAndZoe1SeenText:
	text "エリカおねえちゃん<NI>おそわった"
	line "#のわざ　みせる　でしゅ！"
	done

TwinsJoAndZoe1BeatenText:
	text "まけちった　でしゅ<⋯>"
	done

TwinsJoAndZoe1AfterBattleText:
	text "エリカおねえちゃんに"
	line "しかえし　して　もらう　でしゅ！"
	done

TwinsJoAndZoe2SeenText:
	text "エリカおねえちゃんは"
	line "わたちたち<GA>まもる　でしゅ！"
	done

TwinsJoAndZoe2BeatenText:
	text "かてなかった　でしゅ<⋯>"
	done

TwinsJoAndZoe2AfterBattleText:
	text "エリカおねえちゃんは"
	line "もっと　つよい　でしゅ！"
	done

CeladonGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, CELADON_CITY, 8
	warp_event  5, 17, CELADON_CITY, 8

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, CeladonGymStatue
	bg_event  6, 15, BGEVENT_READ, CeladonGymStatue

	def_object_events
	object_event  5,  3, SPRITE_ERIKA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonGymErikaScript, -1
	object_event  7,  8, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerLassMichelle, -1
	object_event  2,  8, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerPicnickerTanya, -1
	object_event  3,  5, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerBeautyJulia, -1
	object_event  4, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsJoAndZoe1, -1
	object_event  5, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsJoAndZoe2, -1
