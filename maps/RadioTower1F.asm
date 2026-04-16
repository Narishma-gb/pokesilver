	object_const_def
	const RADIOTOWER1F_RECEPTIONIST
	const RADIOTOWER1F_LASS
	const RADIOTOWER1F_YOUNGSTER
	const RADIOTOWER1F_ROCKET
	const RADIOTOWER1F_LUCKYNUMBERMAN
	const RADIOTOWER1F_CARD_WOMAN

RadioTower1F_MapScripts:
	def_scene_scripts

	def_callbacks

RadioTower1FReceptionistScript:
	faceplayer
	opentext
	checkflag ENGINE_ROCKETS_IN_RADIO_TOWER
	iftrue .Rockets
	writetext RadioTower1FReceptionistWelcomeText
	waitbutton
	closetext
	end

.Rockets:
	writetext RadioTower1FReceptionistNoToursText
	waitbutton
	closetext
	end

RadioTower1FLuckyNumberManScript:
	faceplayer
	opentext
	writetext RadioTower1FLuckyNumberManAskToPlayText
	promptbutton
	special CheckLuckyNumberShowFlag
	iffalse .skip
	special ResetLuckyNumberShowFlag
.skip
	special PrintTodaysLuckyNumber
	checkflag ENGINE_LUCKY_NUMBER_SHOW
	iftrue .GameOver
	writetext RadioTower1FLuckyNumberManThisWeeksIdIsText
	promptbutton
	closetext
	applymovement RADIOTOWER1F_LUCKYNUMBERMAN, RadioTower1FLuckyNumberManGoToPCMovement
	opentext
	writetext RadioTower1FLuckyNumberManCheckIfMatchText
	promptbutton
	waitsfx
	writetext RadioTower1FLuckyNumberManDotDotDotText
	playsound SFX_DEX_FANFARE_20_49
	waitsfx
	promptbutton
	special CheckForLuckyNumberWinners
	closetext
	applymovement RADIOTOWER1F_LUCKYNUMBERMAN, RadioTower1FLuckyNumberManReturnToPlayerMovement
	opentext
	ifequal 1, .FirstPlace
	ifequal 2, .SecondPlace
	ifequal 3, .ThirdPlace
	sjump .NoPrize

.GameOver:
	writetext RadioTower1FLuckyNumberManComeAgainText
	waitbutton
	closetext
	end

.FirstPlace:
	writetext RadioTower1FLuckyNumberManPerfectMatchText
	playsound SFX_1ST_PLACE
	waitsfx
	promptbutton
	giveitem MASTER_BALL
	iffalse .BagFull
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	sjump .GameOver

.SecondPlace:
	writetext RadioTower1FLuckyNumberManOkayMatchText
	playsound SFX_2ND_PLACE
	waitsfx
	promptbutton
	giveitem EXP_SHARE
	iffalse .BagFull
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	sjump .GameOver

.ThirdPlace:
	writetext RadioTower1FLuckyNumberManWeakMatchText
	playsound SFX_3RD_PLACE
	waitsfx
	promptbutton
	giveitem PP_UP
	iffalse .BagFull
	itemnotify
	setflag ENGINE_LUCKY_NUMBER_SHOW
	sjump .GameOver

.NoPrize:
	writetext RadioTower1FLuckyNumberManNoneOfYourIDNumbersMatchText
	waitbutton
	closetext
	end

.BagFull:
	writetext RadioTower1FLuckyNumberManNoRoomForYourPrizeText
	waitbutton
	closetext
	end

RadioTower1FRadioCardWomanScript:
	faceplayer
	opentext
	checkflag ENGINE_RADIO_CARD
	iftrue .GotCard
	writetext RadioTower1FRadioCardWomanOfferQuizText
	yesorno
	iffalse .NoQuiz
	writetext RadioTower1FRadioCardWomanQuestion1Text
	yesorno
	iffalse .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion2Text
	yesorno
	iffalse .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion3Text
	yesorno
	iftrue .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion4Text
	yesorno
	iffalse .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanQuestion5Text
	yesorno
	iftrue .WrongAnswer
	playsound SFX_ELEVATOR_END
	waitsfx
	writetext RadioTower1FRadioCardWomanYouWinText
	promptbutton
	getstring STRING_BUFFER_4, .RadioCardText
	scall .ReceiveItem
	writetext RadioTower1FPokegearIsARadioText
	promptbutton
	setflag ENGINE_RADIO_CARD
.GotCard:
	writetext RadioTower1FRadioCardWomanTuneInText
	waitbutton
	closetext
	end

.RadioCardText:
	db "ラジオカード@"

.ReceiveItem:
	jumpstd ReceiveItemScript
	end

.WrongAnswer:
	playsound SFX_WRONG
	writetext RadioTower1FRadioCardWomanWrongAnswerText
	waitbutton
	closetext
	end

.NoQuiz:
	writetext RadioTower1FRadioCardWomanNotTakingQuizText
	waitbutton
	closetext
	end

RadioTower1FLassScript:
	jumptextfaceplayer RadioTower1FLassText

RadioTower1FYoungsterScript:
	jumptextfaceplayer RadioTower1FYoungsterText

TrainerGruntM3:
	trainer GRUNTM, GRUNTM_3, EVENT_BEAT_ROCKET_GRUNTM_3, GruntM3SeenText, GruntM3BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM3AfterBattleText
	waitbutton
	closetext
	end

RadioTower1FDirectory:
	jumptext RadioTower1FDirectoryText

RadioTower1FLuckyChannelSign:
	jumptext RadioTower1FLuckyChannelSignText

RadioTower1FLuckyNumberManGoToPCMovement:
	step RIGHT
	turn_head UP
	step_end

RadioTower1FLuckyNumberManReturnToPlayerMovement:
	step LEFT
	turn_head UP
	step_end

RadioTower1FReceptionistWelcomeText:
	text "ようこそ！"
	done

RadioTower1FReceptionistNoToursText:
	text "<⋯>　ようこそ"
	line "もうしわけ　ありませんが"
	cont "いま<WA>けんがく　できないんです"
	done

RadioTower1FLuckyNumberManAskToPlayText:
	text "はい　こちら　ひきかえじょです"

	para "あなた<NO>#の"
	line "アイディナンバーで"
	cont "うんがよければ　しょうひんゲット！"
	done

RadioTower1FLuckyNumberManThisWeeksIdIsText:
	text "こんかい<NO>アイディナンバーは"
	line "@"
	text_ram wStringBuffer3
	text "　です"
	done

RadioTower1FLuckyNumberManCheckIfMatchText:
	text "それで<WA>さっそく　チェック"
	line "してみましょう"
	done

RadioTower1FLuckyNumberManDotDotDotText:
	text "<⋯>　<⋯>　<⋯>　<⋯>　<⋯>"
	line "　<⋯>　<⋯>　<⋯>　<⋯>　<⋯>"
	done

RadioTower1FLuckyNumberManComeAgainText:
	text "つぎ<NO>はっぴょうを"
	line "おたのしみ<NI>おまちください"
	done

RadioTower1FLuckyNumberManPerfectMatchText:
	text "な　なんと　５ケタあ<TTE>ます！"
	line "１とう！　１とうです！"

	para "１とう　しょうひんは"
	line "マスターボール　です！"
	done

RadioTower1FLuckyNumberManOkayMatchText:
	text "なんと　しも３ケタあ<TTE>ます！"
	line "２とう　です！"

	para "２とう　しょうひんは"
	line "がくしゅうそうち　です！"
	done

RadioTower1FLuckyNumberManWeakMatchText:
	text "しも２ケタ　あ<TTE>まし<TA!>"
	line "３とう　<GA>あたりまし<TA!>"

	para "３とう　しょうひんは"
	line "ポイントアップ　です！"
	done

RadioTower1FLuckyNumberManNoneOfYourIDNumbersMatchText:
	text "ざんねんながら"
	line "すべて　はずれでした"
	done

RadioTower1FLuckyNumberManNoRoomForYourPrizeText:
	text "にもつ<GA>いっぱい<NO>ようですね"
	line "にもつ<WO>へらして　はやめに"
	cont "おこしください"
	done

RadioTower1FRadioCardWomanOfferQuizText:
	text "ただいま　キャンペーンちゅう！"

	para "クイズ<NI>５もん　つづけて"
	line "せいかい　すると"
	cont "ラジオカード<WO>プレゼント！"

	para "ポケギア<NI>させば"
	line "いつでも　どこでも　ラジオがきけます"
	cont "クイズ<NI>ちょうせん　しますか？"
	done

RadioTower1FRadioCardWomanQuestion1Text:
	text "で<WA>だい１もん！"

	para "#ギアで　タウンマップを"
	line "みられるよう<NI>できる？"
	done

RadioTower1FRadioCardWomanQuestion2Text:
	text "せいかい　です"
	line "じゃあ　だい２もん！"

	para "#<NO>ニドリーナは"
	line "♀しか　いない？"
	done

RadioTower1FRadioCardWomanQuestion3Text:
	text "せいかい　です"
	line "つづいて　だい３もん！"

	para "ボールしょくにん<NO>ガンテツさん"
	line "ざいりょう<NI>つかうの<WA>ボンゴレ？"
	done

RadioTower1FRadioCardWomanQuestion4Text:
	text "またまた　せいかい"
	line "で<WA>だい４もん！"

	para "#　コイキングに"
	line "<TM><WA>つかえない？"
	done

RadioTower1FRadioCardWomanQuestion5Text:
	text "すごーい！"
	line "いよいよ　さいご<NO>もんだいよ"

	para "にんき　ばんぐみ"
	line "オーキドはかせ<NO>#こうざ"
	cont "おあいて<WA>ミルクちゃん？"
	done

RadioTower1FRadioCardWomanYouWinText:
	text "ぜんもん　せいかい"
	line "おめでとう　ございます！"
	cont "しょうひん<NO>ラジオカードです！"
	done

RadioTower1FPokegearIsARadioText:
	text "<PLAYER><NO>#ギアで"
	line "ラジオ<GA>きけるよう<NI>なっ<TA!>"
	done

RadioTower1FRadioCardWomanTuneInText:
	text "<WATASHI>たち<NO>ばんぐみ"
	line "いつでも　きいて　たのしんでね！"
	done

RadioTower1FRadioCardWomanWrongAnswerText:
	text "あらあら　まちがっちゃいましたね"
	line "ざんねん"
	cont "また<NO>ちょうせん<WO>どうぞ！"
	done

RadioTower1FRadioCardWomanNotTakingQuizText:
	text "そうですか"
	line "き<GA>むいたら　いらしてくださいね"
	done

RadioTower1FLassText:
	text "ディージェイといったら　セージよね！"
	line "あ<NO>あまいこえ　といったら<⋯>"

	para "もう　メロメロ"
	done

RadioTower1FYoungsterText:
	text "ぼく<WA>#こうざの"
	line "クルミちゃん<GA>すき　だな！"

	para "<⋯>　こえ　しか　しらない　けど"
	done

GruntM3SeenText:
	text "つい<NI>ラジオとう<WO>のっとっ<TA!>"
	line "<ROCKET><NO>おそろしさを"
	cont "ぜんこく<NI>しらせてやるのだ！"

	para "まず<WA>おまえ<NI>おれたちの"
	line "おそろしさ<WO>おもいしらせてやる！"
	done

GruntM3BeatenText:
	text "こ　こいつ<WA>つよい<⋯>"
	line "ようちゅうい　だな"
	done

GruntM3AfterBattleText:
	text "おまえ　つよすぎる"

	para "このままで<WA>けいかく<GA>だいなしだ"
	line "なかま<NI>しらせないと<⋯>"
	done

RadioTower1FDirectoryText:
	text "１かい　<⋯>　うけつけ"
	line "２かい　<⋯>　えいぎょうぶ"
	cont "３かい　<⋯>　そうむぶ"
	cont "４かい　<⋯>　せいさくしつ"
	cont "５かい　<⋯>　きょくちょうしつ"
	done

RadioTower1FLuckyChannelSignText:
	text "ラッキー　チャンネル！"
	line "あなた<NO>#　なんばん？"

	para "#こうかん　して"
	line "いろんな　ばんごう　あつめよう！"
	done

RadioTower1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 12
	warp_event  3,  7, GOLDENROD_CITY, 12
	warp_event 15,  0, RADIO_TOWER_2F, 2

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_READ, RadioTower1FDirectory
	bg_event 13,  0, BGEVENT_READ, RadioTower1FLuckyChannelSign

	def_object_events
	object_event  5,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower1FReceptionistScript, -1
	object_event 16,  4, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower1FLassScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 15,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RadioTower1FYoungsterScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 14,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM3, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  8,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RadioTower1FLuckyNumberManScript, EVENT_GOLDENROD_CITY_CIVILIANS
	object_event 12,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTower1FRadioCardWomanScript, EVENT_GOLDENROD_CITY_CIVILIANS
