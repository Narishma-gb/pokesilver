	object_const_def
	const ROUTE35NATIONALPARKGATE_OFFICER1
	const ROUTE35NATIONALPARKGATE_YOUNGSTER
	const ROUTE35NATIONALPARKGATE_OFFICER2

Route35NationalParkGate_MapScripts:
	def_scene_scripts
	scene_script Route35NationalParkGateNoop1Scene,             SCENE_ROUTE35NATIONALPARKGATE_NOOP
	scene_script Route35NationalParkGateNoop2Scene,             SCENE_ROUTE35NATIONALPARKGATE_UNUSED
	scene_script Route35NationalParkGateLeaveContestEarlyScene, SCENE_ROUTE35NATIONALPARKGATE_LEAVE_CONTEST_EARLY

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route35NationalParkGateCheckIfContestRunningCallback
	callback MAPCALLBACK_OBJECTS, Route35NationalParkGateCheckIfContestAvailableCallback

Route35NationalParkGateNoop1Scene:
	end

Route35NationalParkGateNoop2Scene:
	end

Route35NationalParkGateLeaveContestEarlyScene:
	sdefer Route35NationalParkGateLeavingContestEarlyScript
	end

Route35NationalParkGateCheckIfContestRunningCallback:
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue Route35NationalParkBugContestIsRunningScript
	endcallback

Route35NationalParkBugContestIsRunningScript:
	setscene SCENE_ROUTE35NATIONALPARKGATE_LEAVE_CONTEST_EARLY
	endcallback

Route35NationalParkGateCheckIfContestAvailableCallback:
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .SetContestOfficer
	ifequal THURSDAY, .SetContestOfficer
	ifequal SATURDAY, .SetContestOfficer
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue Route35NationalParkBugContestIsRunningScript
	disappear ROUTE35NATIONALPARKGATE_OFFICER1
	appear ROUTE35NATIONALPARKGATE_YOUNGSTER
	appear ROUTE35NATIONALPARKGATE_OFFICER2
	endcallback

.SetContestOfficer:
	appear ROUTE35NATIONALPARKGATE_OFFICER1
	disappear ROUTE35NATIONALPARKGATE_YOUNGSTER
	disappear ROUTE35NATIONALPARKGATE_OFFICER2
	endcallback

Route35NationalParkGateLeavingContestEarlyScript:
	applymovement PLAYER, Route35NationalParkGatePlayerApproachOfficer1Movement
	turnobject ROUTE35NATIONALPARKGATE_OFFICER1, RIGHT
	opentext
	readvar VAR_CONTESTMINUTES
	addval 1
	getnum STRING_BUFFER_3
	writetext Route35NationalParkGateOfficer1WantToFinishText
	yesorno
	iffalse .GoBackToContest
	writetext Route35NationalParkGateOfficer1WaitAtNorthGateText
	waitbutton
	closetext
	jumpstd BugContestResultsWarpScript

.GoBackToContest:
	writetext Route35NationalParkGateOfficer1OkGoFinishText
	waitbutton
	closetext
	scall Route35NationalParkGate_EnterContest
	playsound SFX_ENTER_DOOR
	special FadeOutToWhite
	waitsfx
	warp NATIONAL_PARK_BUG_CONTEST, 10, 47
	end

Route35OfficerScriptContest:
	readvar VAR_WEEKDAY
	ifequal SUNDAY, Route35NationalParkGate_NoContestToday
	ifequal MONDAY, Route35NationalParkGate_NoContestToday
	ifequal WEDNESDAY, Route35NationalParkGate_NoContestToday
	ifequal FRIDAY, Route35NationalParkGate_NoContestToday
	faceplayer
	opentext
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route35NationalParkGate_ContestIsOver
	scall Route35NationalParkGate_GetDayOfWeek
	writetext Route35NationalParkGateOfficer1AskToParticipateText
	yesorno
	iffalse Route35NationalParkGate_DeclinedToParticipate
	readvar VAR_PARTYCOUNT
	ifgreater 1, Route35NationalParkGate_LeaveTheRestBehind
	special ContestDropOffMons
	clearevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
Route35NationalParkGate_OkayToProceed:
	setflag ENGINE_BUG_CONTEST_TIMER
	special PlayMapMusic
	writetext Route35NationalParkGateOfficer1GiveParkBallsText
	promptbutton
	writetext Route35NationalParkGatePlayerReceivedParkBallsText
	playsound SFX_ITEM
	waitsfx
	writetext Route35NationalParkGateOfficer1ExplainsRulesText
	waitbutton
	closetext
	special GiveParkBalls
	scall Route35NationalParkGate_EnterContest
	playsound SFX_ENTER_DOOR
	special FadeOutToWhite
	waitsfx
	special SelectRandomBugContestContestants
	warp NATIONAL_PARK_BUG_CONTEST, 10, 47
	end

Route35NationalParkGate_EnterContest:
	readvar VAR_FACING
	ifequal LEFT, Route35NationalParkGate_FacingLeft
	applymovement PLAYER, Route35NationalParkGatePlayerGoAroundOfficerAndEnterParkMovement
	end

Route35NationalParkGate_FacingLeft:
	applymovement PLAYER, Route35NationalParkGatePlayerEnterParkMovement
	end

Route35NationalParkGate_LeaveTheRestBehind:
	readvar VAR_PARTYCOUNT
	ifless PARTY_LENGTH, Route35NationalParkGate_LessThanFullParty
	readvar VAR_BOXSPACE
	ifequal 0, Route35NationalParkGate_NoRoomInBox

Route35NationalParkGate_LessThanFullParty:
	special CheckFirstMonIsEgg
	ifequal TRUE, Route35NationalParkGate_FirstMonIsEgg
	writetext Route35NationalParkGateOfficer1AskToUseFirstMonText
	yesorno
	iffalse Route35NationalParkGate_DeclinedToLeaveMonsBehind
	special ContestDropOffMons
	iftrue Route35NationalParkGate_FirstMonIsFainted
	setevent EVENT_LEFT_MONS_WITH_CONTEST_OFFICER
	writetext Route35NationalParkGateOfficer1WellHoldYourMonText
	promptbutton
	writetext Route35NationalParkGatePlayersMonLeftWithHelperText
	playsound SFX_GOT_SAFARI_BALLS
	waitsfx
	promptbutton
	sjump Route35NationalParkGate_OkayToProceed

Route35NationalParkGate_DeclinedToParticipate:
	writetext Route35NationalParkGateOfficer1TakePartInFutureText
	waitbutton
	closetext
	end

Route35NationalParkGate_DeclinedToLeaveMonsBehind:
	writetext Route35NationalParkGateOfficer1ChooseMonAndComeBackText
	waitbutton
	closetext
	end

Route35NationalParkGate_FirstMonIsFainted:
	writetext Route35NationalParkGateOfficer1FirstMonCantBattleText
	waitbutton
	closetext
	end

Route35NationalParkGate_NoRoomInBox:
	writetext Route35NationalParkGateOfficer1MakeRoomText
	waitbutton
	closetext
	end

Route35NationalParkGate_FirstMonIsEgg:
	writetext Route35NationalParkGateOfficer1EggAsFirstMonText
	waitbutton
	closetext
	end

Route35NationalParkGate_ContestIsOver:
	writetext Route35NationalParkGateOfficer1ContestIsOverText
	waitbutton
	closetext
	end

Route35NationalParkGate_NoContestToday:
	jumptextfaceplayer Route35NationalParkGateOfficer1WeHoldContestsText

Route35NationalParkGateOfficerScript:
	faceplayer
	opentext
	checkflag ENGINE_DAILY_BUG_CONTEST
	iftrue Route35NationalParkGate_ContestIsOver
	writetext Route35NationalParkGateOfficer1WeHoldContestsText
	waitbutton
	closetext
	end

Route35NationalParkGateYoungsterScript:
	jumptextfaceplayer Route35NationalParkGateYoungsterText

BugCatchingContestExplanationSign:
	jumptext BugCatchingContestExplanationText

Route35NationalParkGate_GetDayOfWeek:
	jumpstd DayToTextScript
	end

Route35NationalParkGatePlayerApproachOfficer1Movement:
	step DOWN
	turn_head LEFT
	step_end

Route35NationalParkGatePlayerGoAroundOfficerAndEnterParkMovement:
	step RIGHT
	step UP
	step UP
	step_end

Route35NationalParkGatePlayerEnterParkMovement:
	step UP
	step_end

Route35NationalParkGateOfficer1AskToParticipateText:
	text "きょう<WA>@"
	text_ram wStringBuffer3
	text "ようび"
	line "むしとりたいかい<GA>ひらかれます！"

	para "ルール<WA>かんたん！"

	para "てもち<NO>#　１ぴきで"
	line "つよそうな　むし#を"
	cont "つかまえられるか　くらべるだけです"

	para "さんか　しますか？"
	done

Route35NationalParkGateOfficer1GiveParkBallsText:
	text "たいかいで　つかう"
	line "せんよう<NO>ボール<WO>どうぞ！"
	done

Route35NationalParkGatePlayerReceivedParkBallsText:
	text "<PLAYER>は"
	line "パークボール<WO>２０こ　もらっ<TA!>"
	done

Route35NationalParkGateOfficer1ExplainsRulesText:
	text "いちばん　つよそうな　#を"
	line "つかまえたひと<GA>ゆうしょうです！"

	para "せいげん　じかん<WA>２０ぷん！"

	para "また　パークボール<GA>なくなると"
	line "しゅうりょう　です！"

	para "さいご<NI>つかまえた　#は"
	line "さんかしゃ<NO>もの<NI>なります！"

	para "がんば<TTE>　つよそうな"
	line "#<WO>つかまえて　ください！"
	done

Route35NationalParkGateOfficer1AskToUseFirstMonText:
	text "あれ？"
	line "#<GA>１ぴきじゃ　ないですね！"

	para "せんとう<NI>いる　#<⋯>"
	line "@"
	text_ram wStringBuffer3
	text "で"
	cont "さんか　すること<NI>なります"
	cont "よろしい　ですか？"
	done

Route35NationalParkGateOfficer1WellHoldYourMonText:
	text "それで<WA>のこり<NO>#は"
	line "こちらで　あずかりますね！"
	done

Route35NationalParkGatePlayersMonLeftWithHelperText:
	text "<PLAYER><WA>かかりいんに"
	line "#<WO>あずけ<TA!>"
	done

Route35NationalParkGateOfficer1ChooseMonAndComeBackText:
	text "たいかいで　たたかわせる"
	line "#<WO>きめてから"
	cont "もういちど　おねがいします"
	done

Route35NationalParkGateOfficer1TakePartInFutureText:
	text "そうですか"
	line "つぎ<WA>さんか　してくださいね！"
	done

Route35NationalParkGateOfficer1FirstMonCantBattleText:
	text "あれ？"
	line "せんとう<NO>#が"
	cont "たたかえない　みたい　ですね"

	para "#<WO>いれかえてから"
	line "きてくださいね"
	done

Route35NationalParkGateOfficer1MakeRoomText:
	text "あれ？"
	line "てもちも　<PC><NO>ボックスも"
	cont "いっぱい　みたい　ですね"

	para "それで<WA>むし#を"
	line "つかまえても　もてませんよ"

	para "てもちと　<PC><NO>ボックスを"
	line "せいりして　きてくださいね"
	done

Route35NationalParkGateOfficer1EggAsFirstMonText:
	text "あれ？"
	line "せんとう<NO>#が"
	cont "タマゴ　みたい　ですね"

	para "#<WO>いれかえてから"
	line "きてくださいね"
	done

Route35NationalParkGateOfficer1WantToFinishText:
	text "のこり　じかんは"
	line "あと　@"
	text_ram wStringBuffer3
	text "ふん　です"
	cont "もう　おわり<NI>しますか？"
	done

Route35NationalParkGateOfficer1WaitAtNorthGateText:
	text "そうですか"
	line "で<WA>うえのゲートで"
	cont "けっかはっぴょうを"
	cont "おまちください"
	done

Route35NationalParkGateOfficer1OkGoFinishText:
	text "そうですか"
	line "で<WA>のこり<NO>じかん"
	cont "がんば<TTE>　きてくださいませ！"
	done

Route35NationalParkGateOfficer1ContestIsOverText:
	text "きょう<NO>コンテストは"
	line "おわったよ"
	cont "また　こんど　さんかしてね！"
	done

Route35NationalParkGateOfficer1WeHoldContestsText:
	text "こうえん　ではね　ときどき　"
	line "たいかい<GA>おこなわれるんだ"
	cont "よかったら　きみも　さんか　しない？"
	done

Route35NationalParkGateYoungsterText:
	text "むしとり　たいかい"
	line "こんど<WA>いつ　かなあ？"
	done

BugCatchingContestExplanationText:
	text "むしとり　たいかいが"
	line "ひらかれるのは<⋯>"
	cont "かようび　もくようび　どようび"

	para "さんかしょう<GA>もらえる　だけでなく"
	line "つかまえた　むし#を"
	cont "じぶんのもの<NI>すること<GA>できます"
	done

Route35NationalParkGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  0, NATIONAL_PARK, 3
	warp_event  4,  0, NATIONAL_PARK, 4
	warp_event  3,  7, ROUTE_35, 3
	warp_event  4,  7, ROUTE_35, 3

	def_coord_events

	def_bg_events
	bg_event  5,  0, BGEVENT_READ, BugCatchingContestExplanationSign

	def_object_events
	object_event  2,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route35OfficerScriptContest, EVENT_ROUTE_35_NATIONAL_PARK_GATE_OFFICER_CONTEST_DAY
	object_event  6,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route35NationalParkGateYoungsterScript, EVENT_ROUTE_35_NATIONAL_PARK_GATE_YOUNGSTER
	object_event  0,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route35NationalParkGateOfficerScript, EVENT_ROUTE_35_NATIONAL_PARK_GATE_OFFICER_NOT_CONTEST_DAY
