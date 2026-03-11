	object_const_def
	const ROUTE35GOLDENRODGATE_RANDY
	const ROUTE35GOLDENRODGATE_POKEFAN_F

Route35GoldenrodGate_MapScripts:
	def_scene_scripts

	def_callbacks

RandyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_HP_UP_FROM_RANDY
	iftrue .gothpup
	checkevent EVENT_GAVE_KENYA
	iftrue .questcomplete
	checkevent EVENT_GOT_KENYA
	iftrue .alreadyhavekenya
	writetext Route35GoldenrodGateRandyAskTakeThisMonToMyFriendText
	yesorno
	iffalse .refused
	writetext Route35GoldenrodGateRandyThanksText
	promptbutton
	waitsfx
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .partyfull
	writetext Route35GoldenrodGatePlayerReceivedAMonWithMailText
	playsound SFX_KEY_ITEM
	waitsfx
	givepoke SPEAROW, 10, NO_ITEM, GiftSpearowName, GiftSpearowOTName
	givepokemail GiftSpearowMail
	setevent EVENT_GOT_KENYA
.alreadyhavekenya
	writetext Route35GoldenrodGateRandyWeirdTreeBlockingRoadText
	waitbutton
	closetext
	end

.partyfull
	writetext Route35GoldenrodGateRandyCantCarryAnotherMonText
	waitbutton
	closetext
	end

.refused
	writetext Route35GoldenrodGateRandyOhNeverMindThenText
	waitbutton
	closetext
	end

.questcomplete
	writetext Route35GoldenrodGateRandySomethingForYourTroubleText
	promptbutton
	verbosegiveitem HP_UP
	iffalse .bagfull
	setevent EVENT_GOT_HP_UP_FROM_RANDY
.gothpup
	writetext Route35GoldenrodGateRandyMyPalWasSnoozingRightText
	waitbutton
.bagfull
	closetext
	end

GiftSpearowMail:
	db FLOWER_MAIL
	db   "くらやみ<NO>ほらあな　からは"
	next "べつ<NO>みち<NI>つづいているよ@"

GiftSpearowName:
	db "ひきゃく@"

GiftSpearowOTName:
	db "ユウジ@"

Route35GoldenrodGatePokefanFScript:
	faceplayer
	opentext
	checkevent EVENT_FOUGHT_SUDOWOODO
	iftrue .FoughtSudowoodo
	writetext Route35GoldenrodGatePokefanFText
	waitbutton
	closetext
	end

.FoughtSudowoodo
	writetext Route35GoldenrodGatePokefanFText_FoughtSudowoodo
	waitbutton
	closetext
	end

Route35GoldenrodGateRandyAskTakeThisMonToMyFriendText:
	text "ねー　キミ　キミ！"

	para "このメール<WO>もたせた　#を"
	line "３１<ROUTE><NI>いる"
	cont "ともだち<NI>とどけて　ほしいんだ"
	cont "おねがい　できるかな？"
	done

Route35GoldenrodGateRandyThanksText:
	text "ありがとう！"

	para "ともだち<WA>ふとった　おとこで"
	line "いつも　いねむり　してるから"
	cont "すぐ<NI>わかると　おもうよ！"
	done

Route35GoldenrodGatePlayerReceivedAMonWithMailText:
	text "<PLAYER><WA>メール<WO>もった"
	line "#<WO>あずかっ<TA!>"
	done

Route35GoldenrodGateRandyWeirdTreeBlockingRoadText:
	text "メール<WO>よんでも　いいけど"
	line "なくさないでよ！"
	cont "３１<ROUTE>　まで　たのむね！"

	para "<⋯>おっと　そういえば"
	line "ヘンテコな　き　が"
	cont "みち<WO>ふさいでる　らしいけど"
	cont "もう　とおれるよう<NI>なったのかな？"
	done

Route35GoldenrodGateRandyCantCarryAnotherMonText:
	text "それ　いじょう"
	line "#<WO>もてない　みたいだね<⋯>"
	done

Route35GoldenrodGateRandyOhNeverMindThenText:
	text "そうか<⋯>"
	line "しかたない　かな<⋯>"
	done

Route35GoldenrodGateRandySomethingForYourTroubleText:
	text "ありがとう！"
	line "ちゃんと　とどけて　くれたんだね！"
	cont "おれい<WO>あげるよ！"
	done

Route35GoldenrodGateRandyMyPalWasSnoozingRightText:
	text "ボク<NO>ともだち<WA>ねてたでしょ？"
	line "ねてばかり<NO>ヤツ　なんだよ！"
	done

Route35GoldenrodGatePokefanFText:
	text "はなしかけると　グネグネ　うごく"
	line "き<GA>みち<WO>ふさいでるんです<TTE>"

	para "ゼニガメじょうろで　みず<WO>かけたら"
	line "あばれだした<TTE>　はなしも　きいたわ"
	done

Route35GoldenrodGatePokefanFText_FoughtSudowoodo:
	text "<WATASHI>　ラジオから　ながれる"
	line "#<NO>こもりうた　すきなのよ"
	done

Route35GoldenrodGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  0, ROUTE_35, 1
	warp_event  5,  0, ROUTE_35, 2
	warp_event  4,  7, GOLDENROD_CITY, 13
	warp_event  5,  7, GOLDENROD_CITY, 13

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RandyScript, -1
	object_event  6,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route35GoldenrodGatePokefanFScript, -1
