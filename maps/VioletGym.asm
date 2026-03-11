	object_const_def
	const VIOLETGYM_FALKNER
	const VIOLETGYM_YOUNGSTER1
	const VIOLETGYM_YOUNGSTER2
	const VIOLETGYM_GYM_GUIDE

VioletGym_MapScripts:
	def_scene_scripts

	def_callbacks

VioletGymFalknerScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_FALKNER
	iftrue .FightDone
	writetext FalknerIntroText
	waitbutton
	closetext
	winlosstext FalknerWinLossText, 0
	loadtrainer FALKNER, FALKNER1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_FALKNER
	opentext
	writetext ReceivedZephyrBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_ZEPHYRBADGE
	readvar VAR_BADGES
	scall VioletGymActivateRockets
.FightDone:
	checkevent EVENT_GOT_TM31_MUD_SLAP
	iftrue .SpeechAfterTM
	setevent EVENT_BEAT_BIRD_KEEPER_ROD
	setevent EVENT_BEAT_BIRD_KEEPER_ABE
	setmapscene ELMS_LAB, SCENE_ELMSLAB_NOOP
	specialphonecall SPECIALCALL_ASSISTANT
	writetext FalknerZephyrBadgeText
	promptbutton
	verbosegiveitem TM_MUD_SLAP
	iffalse .NoRoomForMudSlap
	setevent EVENT_GOT_TM31_MUD_SLAP
	writetext FalknerTMMudSlapText
	waitbutton
	closetext
	end

.SpeechAfterTM:
	writetext FalknerFightDoneText
	waitbutton
.NoRoomForMudSlap:
	closetext
	end

VioletGymActivateRockets:
	ifequal 7, .RadioTowerRockets
	ifequal 6, .GoldenrodRockets
	end

.GoldenrodRockets:
	jumpstd GoldenrodRocketsScript

.RadioTowerRockets:
	jumpstd RadioTowerRocketsScript

TrainerBirdKeeperRod:
	trainer BIRD_KEEPER, ROD, EVENT_BEAT_BIRD_KEEPER_ROD, BirdKeeperRodSeenText, BirdKeeperRodBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BirdKeeperRodAfterBattleText
	waitbutton
	closetext
	end

TrainerBirdKeeperAbe:
	trainer BIRD_KEEPER, ABE, EVENT_BEAT_BIRD_KEEPER_ABE, BirdKeeperAbeSeenText, BirdKeeperAbeBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BirdKeeperAbeAfterBattleText
	waitbutton
	closetext
	end

VioletGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_FALKNER
	iftrue .VioletGymGuideWinScript
	writetext VioletGymGuideText
	waitbutton
	closetext
	end

.VioletGymGuideWinScript:
	writetext VioletGymGuideWinText
	waitbutton
	closetext
	end

VioletGymStatue:
	checkflag ENGINE_ZEPHYRBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, FALKNER, FALKNER1
	jumpstd GymStatue2Script

FalknerIntroText:
	text "おれ<GA>キキョウ　#ジム"
	line "リーダー<NO>ハヤト！"

	para "せけん　じゃ"
	line "ひこうタイプ<NO>#なんか"
	cont "でんげきで　いちころ<⋯>"

	para "そう　とり#<WO>ばかにする"
	line "おれ<WA>それ<GA>ゆるせない！"

	para "おおぞら<WO>かれい<NI>まう"
	line "とり#<NO>ほんとう<NO>すごさ"
	cont "おもいしらせて　やるよ！"
	done

FalknerWinLossText:
	text "<⋯>ちくしょう"
	line "とうさん<GA>たいせつ<NI>していた"
	cont "#が<⋯>"

	para "わかった"
	line "これ<WO>も<TTE>いけよ！"

	para "#　リーグ　こうにん"
	line "ウイングバッジ　だ！"
	done

ReceivedZephyrBadgeText:
	text "<PLAYER><WA>ハヤトから"
	line "ウイングバッジ<WO>もらっ<TA!>"
	done

FalknerZephyrBadgeText:
	text "ウイングバッジ<WO>も<TTE>いると"
	line "きみ<NO>#の"
	cont "<KOUGEKI>　りょく<GA>アップする！"

	para "あと　フラッシュ　という"
	line "わざ<WO>おぼえている　#は"
	cont "たたか<TTE>いない　ときでも"
	cont "フラッシュ<GA>つかえる！"

	para "それから　こいつも　も<TTE>いけよ"
	done

FalknerTMMudSlapText:
	text "<TM><WO>つかえば"
	line "いっしゅんで　#に"
	cont "わざ<WO>おしえること<GA>できる！"

	para "ただし　つかいすて　だから"
	line "よく　かんがえて　つかわないとな"

	para "ちなみ<NI><TM>３１<NO>なかには"
	line "どろかけ　<GA>はい<TTE>いる"

	para "あいて<NO>めいちゅうりつ<WO>さげつつ"
	line "ダメージ<WO>あたえる"

	para "つまり　<KOUGEKI>と　まもりが"
	line "どうじ<NI>できる　わざ　さ"
	done

FalknerFightDoneText:
	text "このさき　いろんな　まちに"
	line "#ジム<GA>あるから"
	cont "そこで　うでだめし<WO>するといい"

	para "おれ<WA>さいきょうの"
	line "とりつかい<NI>なるため"
	cont "#と　おのれ<WO>きたえるよ！"
	done

BirdKeeperRodSeenText:
	text "あいことば<WA>どこんじょうっ！！"

	para "ここ<NI>あつまった　にんげんは"
	line "とり#で　さいきょう<WO>めざし"
	cont "あさばん　とっくん　してる！"

	para "かか<TTE>　こーいっ！"
	done

BirdKeeperRodBeatenText:
	text "がーん！！"
	done

BirdKeeperRodAfterBattleText:
	text "ハヤトさんの"
	line "じつりょく<WA>ほんも<NO>だ！"

	para "おれ<NI>かった　ぐらいで"
	line "ちょうし<NI>のるなよ！"
	done

BirdKeeperAbeSeenText:
	text "ハヤトさん<NI>ちょうせん　できるか"
	line "たしかめて　やるぜ！"
	done

BirdKeeperAbeBeatenText:
	text "ほんとかよー！？"
	done

BirdKeeperAbeAfterBattleText:
	text "<TRAINER><NI>なったばかりの"
	line "やつ<NI>まけると<WA>なさけない<⋯>"
	done

VioletGymGuideText:
	text "おーっす！"
	line "おれ<WA><TRAINER>じゃないが"
	cont "アドバイス<WA>できるぜ！"

	para "しんじろよ！"
	line "しんじれば"
	cont "チャンピオンだ<TTE>　ゆめ　じゃない！"

	para "そうか　きいてくれるか！"
	line "いいか！"

	para "くさタイプ<WA>ひこうタイプに"
	line "ものすごく　あいしょう<GA>わるい"
	cont "ようちゅうい　だぜ！"
	done

VioletGymGuideWinText:
	text "ナイス　ファイト！"
	line "そ<NO>ちょうしで　いっきに"
	cont "　"
	line "#　チャンピオンだぜ！"
	done

VioletGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 15, VIOLET_CITY, 2
	warp_event  5, 15, VIOLET_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_READ, VioletGymStatue
	bg_event  6, 13, BGEVENT_READ, VioletGymStatue

	def_object_events
	object_event  5,  1, SPRITE_FALKNER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, VioletGymFalknerScript, -1
	object_event  7,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperRod, -1
	object_event  2, 10, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperAbe, -1
	object_event  7, 13, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VioletGymGuideScript, -1
