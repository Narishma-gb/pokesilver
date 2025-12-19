GiveParkBalls:
	xor a
	ld [wContestMon], a
	ld a, BUG_CONTEST_BALLS
	ld [wParkBallsRemaining], a
	farcall StartBugContestTimer
	ret

BugCatchingContestBattleScript::
	loadvar VAR_BATTLETYPE, BATTLETYPE_CONTEST
	randomwildmon
	startbattle
	reloadmapafterbattle
	readmem wParkBallsRemaining
	iffalse BugCatchingContestOutOfBallsScript
	end

BugCatchingContestOverScript::
	playsound SFX_ELEVATOR_END
	opentext
	writetext BugCatchingContestTimeUpText
	waitbutton
	sjump BugCatchingContestReturnToGateScript

BugCatchingContestOutOfBallsScript:
	playsound SFX_ELEVATOR_END
	opentext
	writetext BugCatchingContestIsOverText
	waitbutton

BugCatchingContestReturnToGateScript:
	closetext
	jumpstd BugContestResultsWarpScript

BugCatchingContestTimeUpText:
	text "アナウンス『ピンポーン！"

	para "じかんが　きました！"
	done

BugCatchingContestIsOverText:
	text "アナウンス『むしとりたいかい"
	line "おわり　でーす！"
	done
