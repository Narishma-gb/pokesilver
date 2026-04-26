	object_const_def
	const BLACKTHORNGYM1F_CLAIR
	const BLACKTHORNGYM1F_COOLTRAINER_M1
	const BLACKTHORNGYM1F_COOLTRAINER_M2
	const BLACKTHORNGYM1F_COOLTRAINER_F
	const BLACKTHORNGYM1F_GYM_GUIDE

BlackthornGym1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, BlackthornGym1FBouldersCallback

BlackthornGym1FBouldersCallback:
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_1
	iffalse .skip1
	changeblock 8, 2, $3b ; fallen boulder 2
.skip1
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_2
	iffalse .skip2
	changeblock 2, 4, $3a ; fallen boulder 1
.skip2
	checkevent EVENT_BOULDER_IN_BLACKTHORN_GYM_3
	iffalse .skip3
	changeblock 8, 6, $3b ; fallen boulder 2
.skip3
	endcallback

BlackthornGymClairScript:
	faceplayer
	opentext
	checkflag ENGINE_RISINGBADGE
	iftrue .AlreadyGotBadge
	checkevent EVENT_BEAT_CLAIR
	iftrue .FightDone
	writetext ClairIntroText
	waitbutton
	closetext
	winlosstext ClairWinText, 0
	loadtrainer CLAIR, CLAIR1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CLAIR
	opentext
	writetext ClairText_GoToDragonsDen
	waitbutton
	closetext
	setevent EVENT_BEAT_COOLTRAINERM_PAUL
	setevent EVENT_BEAT_COOLTRAINERM_CODY
	setevent EVENT_BEAT_COOLTRAINERM_MIKE
	setevent EVENT_BEAT_COOLTRAINERF_FRAN
	setevent EVENT_BEAT_COOLTRAINERF_LOLA
	clearevent EVENT_MAHOGANY_MART_OWNERS
	setevent EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN
	clearevent EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
	end

.FightDone:
	checkitem DRAGON_FANG
	iftrue .HasDragonFang
	writetext ClairText_WhatsTheMatter
	waitbutton
	closetext
	end

.HasDragonFang:
	writetext BlackthornGymClairText_Cheat
	waitbutton
	closetext
	end

.AlreadyGotBadge:
	checkevent EVENT_GOT_TM24_DRAGONBREATH
	iftrue .GotTM24
	writetext BlackthornGymClairText_YouKeptMeWaiting
	promptbutton
	verbosegiveitem TM_DRAGONBREATH
	iffalse .BagFull
	setevent EVENT_GOT_TM24_DRAGONBREATH
	writetext BlackthornGymClairText_DescribeTM24
	waitbutton
	closetext
	end

.GotTM24:
	writetext BlackthornGymClairText_League
	waitbutton

.BagFull:
	closetext
	end

TrainerCooltrainermPaul:
	trainer COOLTRAINERM, PAUL, EVENT_BEAT_COOLTRAINERM_PAUL, CooltrainermPaulSeenText, CooltrainermPaulBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainermPaulAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainermMike:
	trainer COOLTRAINERM, MIKE, EVENT_BEAT_COOLTRAINERM_MIKE, CooltrainermMikeSeenText, CooltrainermMikeBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainermMikeAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainerfLola:
	trainer COOLTRAINERF, LOLA, EVENT_BEAT_COOLTRAINERF_LOLA, CooltrainerfLolaSeenText, CooltrainerfLolaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainerfLolaAfterBattleText
	waitbutton
	closetext
	end

BlackthornGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CLAIR
	iftrue .BlackthornGymGuideWinScript
	writetext BlackthornGymGuideText
	waitbutton
	closetext
	end

.BlackthornGymGuideWinScript:
	writetext BlackthornGymGuideWinText
	waitbutton
	closetext
	end

BlackthornGymStatue:
	checkflag ENGINE_RISINGBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, CLAIR, CLAIR1
	jumpstd GymStatue2Script

ClairIntroText:
	text "<WATASHI><GA>イブキ！"
	line "せかいで　いちばんの"
	cont "ドラゴンつかい　よ"

	para "じつりょくも　#リーグ"
	line "してんのう<NI>だ<TTE>"
	cont "まけてなんか　ないわよ！"
	cont "どう　それでも　たたかうの？"

	para "<⋯>　そう　わかったわ"
	line "じゃ　はじめましょう！"

	para "<WATASHI>も　<TRAINER>"
	line "どんな　あいて　だ<TTE>"
	cont "ぜんりょくで　あいて　してあげる！"
	done

ClairWinText:
	text "こ<NO><WATASHI><GA>まけるなんて<⋯>"

	para "しんじられない"
	line "なにか<NO>まちがいよ<⋯>"
	done

ClairText_GoToDragonsDen:
	text "<WATASHI><WA>みとめないわ"

	para "まけて　いうのも　なんだけど"
	line "あなた<NO>じつりょく　じゃ"
	cont "#リーグ<NI>ちょうせん　なんて"
	cont "むり　よ"

	para "<⋯>　そうだわ！"

	para "こ<NO>#ジム<NO>うらに"
	line "りゅうのあな　とよばれる"
	cont "ばしょ<GA>あるの"

	para "そこ<NO>おく<NI>おかれた"
	line "りゅうのキバ<WO>と<TTE>くることが"
	cont "ドラゴンつかい<GA>いちにんまえとして"
	cont "みとめられるため<NO>ぎしき"

	para "あなたも　それ<GA>できれば"
	line "ジムバッジ<WO>わたす<NI>ふさわしい"
	cont "<TRAINER>として　みとめるわ！"
	done

ClairText_WhatsTheMatter:
	text "イブキ『どうしたの？"

	para "<WATASHI><NI>かてたのが"
	line "まぐれ　じゃないなら"
	cont "と<TTE>くるくらい　かんたん　でしょ？"
	done

BlackthornGymClairText_Cheat:
	text "イブキ『それ<WA>りゅうのあなで"
	line "と<TTE>きた　も<NO>じゃ　ないでしょ"

	para "そんな　まね<WO>するなんてね<⋯>"
	line "がっかりだわ"
	done

BlackthornGymClairText_YouKeptMeWaiting:
	text "イブキ『あなた<NO>じつりょく"
	line "すなお<NI>みとめるわ"

	para "こ<NO><TM>　も<TTE>いきなさい"
	done

BlackthornGymText_ReceivedTM24: ; unreferenced
	text "<PLAYER><WA>イブキから"
	line "<TM>２４<WO>もらっ<TA!>"
	done

BlackthornGymClairText_DescribeTM24:
	text "なか<NI>はい<TTE>いるのは"
	line "りゅうのいぶき"

	para "<⋯>　べつ<NI>シャレじゃ　ないわよ"
	line "いらないなら　むりして"
	cont "も<TTE>いかなくても　いいのよ"
	done

BlackthornGymClairText_League:
	text "すべて<NO>バッジ<GA>そろったようね"

	para "むかう<WA>セキエイこうげん"
	line "#リーグね"

	para "ばしょ<WA>し<TTE>る？"
	line "そうね　ここからだと"
	cont "まず<WA>ワカバタウン<NI>いくことね"

	para "そこから　なみのりで"
	line "ずっと　ひがし<NI>いくと　いいわ"
	cont "ただし　きびしい　みちのりよ"

	para "#リーグでも"
	line "まけたら　ゆるさないからね！"

	para "そうでないと　まけた"
	line "<WATASHI><GA>みじめ<NI>なるでしょ！"
	done

CooltrainermPaulSeenText:
	text "はじめて　たたかう　ドラゴンつかいの"
	line "つよさ　おもいしる<GA>いい！"
	done

CooltrainermPaulBeatenText:
	text "ざんねん　だなあ"
	done

CooltrainermPaulAfterBattleText:
	text "ドラゴンつかい<NO>ワタルさんに"
	line "あったこと<GA>ある<TTE><⋯>？"
	cont "まさか　そんな　はず　ないよ"
	done

CooltrainermMikeSeenText:
	text "ぼく<GA>まける　ようそ　なんて"
	line "１パーセントも　ないね！"
	done

CooltrainermMikeBeatenText:
	text "おかしいなあ"
	done

CooltrainermMikeAfterBattleText:
	text "じぶん<NO>みじゅくさ<WO>おもいしった"
	line "それ<WO>おしえてくれた"
	cont "きみ<NI>かんしゃ　するぜ！"
	done

CooltrainerfLolaSeenText:
	text "ドラゴン<WA>せいなる　いきもの"
	line "せいめいりょく　あふれた　#"
	cont "ほんきで　こないと　たおせないわよ！"
	done

CooltrainerfLolaBeatenText:
	text "なかなか　やるじゃない"
	done

CooltrainerfLolaAfterBattleText:
	text "そうね　ドラゴン<GA>にがて　なのは"
	line "ドラゴンタイプ<NO>わざ　なの"
	done

BlackthornGymGuideText:
	text "おーす！"
	line "みらい<NO>チャンピオン！"

	para "ようやく　ここまで　きたな"
	line "もう　ひといきだ！"
	cont "おれも　きょうりょく　するぜ！"

	para "イブキ<GA>つかう　#は"
	line "でんせつ<NO>いきもの"
	cont "せいなる　ドラゴン　#！"

	para "ちょっとや　そっとじゃ"
	line "ダメージ<WO>あたえられない！"

	para "<⋯>　だがな"
	line "こおりタイプ<NO>わざには"
	cont "よわい<TTE>　はなし　だぜ！"
	done

BlackthornGymGuideWinText:
	text "イブキ<NI>かつなんて"
	line "たいした　もんだぜ！"

	para "あとは#リーグ<NI>ちょうせん！"
	line "めざせ　チャンピオン！　だな"
	done

BlackthornGym1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, BLACKTHORN_CITY, 1
	warp_event  5, 17, BLACKTHORN_CITY, 1
	warp_event  1,  7, BLACKTHORN_GYM_2F, 1
	warp_event  7,  9, BLACKTHORN_GYM_2F, 2
	warp_event  2,  6, BLACKTHORN_GYM_2F, 3
	warp_event  7,  7, BLACKTHORN_GYM_2F, 4
	warp_event  7,  6, BLACKTHORN_GYM_2F, 5

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, BlackthornGymStatue
	bg_event  6, 15, BGEVENT_READ, BlackthornGymStatue

	def_object_events
	object_event  5,  3, SPRITE_CLAIR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BlackthornGymClairScript, -1
	object_event  6,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainermMike, -1
	object_event  1, 14, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainermPaul, -1
	object_event  9,  2, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerCooltrainerfLola, -1
	object_event  7, 15, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BlackthornGymGuideScript, -1
