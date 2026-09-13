SweetScentFromMenu:
	ld hl, .SweetScent
	call QueueScript
	ld a, $1
	ld [wFieldMoveSucceeded], a
	ret

.SweetScent:
	refreshmap
	special UpdateTimePals
	callasm GetPartyNickname
	writetext UseSweetScentText
	waitbutton
	callasm SweetScentEncounter
	iffalse SweetScentNothing
IF DEF(_10_06) || DEF(_REV0)
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .BugCatchingContest
ENDC
	randomwildmon
	startbattle
	reloadmapafterbattle
	end

IF DEF(_10_06) || DEF(_REV0)
.BugCatchingContest:
	farsjump BugCatchingContestBattleScript
ENDC

SweetScentNothing:
	writetext SweetScentNothingText
	waitbutton
	closetext
	end

SweetScentEncounter:
	farcall CanEncounterWildMon
	jr nc, .no_battle
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	jr nz, .in_bug_contest
	farcall GetMapEncounterRate
	ld a, b
	and a
	jr z, .no_battle
	farcall ChooseWildEncounter
	jr nz, .no_battle
	jr .start_battle

.in_bug_contest
	farcall ChooseWildEncounter_BugContest

.start_battle
	ld a, $1
	ld [wScriptVar], a
	ret

.no_battle
	xor a
	ld [wScriptVar], a
	ret

UseSweetScentText:
	text_ram wStringBuffer3
	text "は"
	line "あまいかおりを　つかった！"
	done

SweetScentNothingText:
	text "<⋯>ここには"
	line "なにも　いないようだ<⋯>"
	done
