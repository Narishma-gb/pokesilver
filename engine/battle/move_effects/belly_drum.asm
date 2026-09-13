BattleCommand_BellyDrum::
; BUG: Belly Drum sharply boosts Attack even with under 50% HP (see docs/bugs_and_glitches.md)
	call BattleCommand_AttackUp2
	ld a, [wAttackMissed]
	and a
	jr nz, .failed
IF DEF(_09_30) || DEF(_10_06)
	callfar GetHalfHP
ELIF DEF(_REV0)
	callfar GetHalfMaxHP
ENDC
	callfar CheckUserHasEnoughHP
	jr nc, .failed

	push bc
	call AnimateCurrentMove
	pop bc
	callfar SubtractHPFromUser
	call UpdateUserInParty

rept MAX_STAT_LEVEL - BASE_STAT_LEVEL - 1
	call BattleCommand_AttackUp2
endr

	ld hl, BellyDrumText
	jp StdBattleTextbox

.failed
	call AnimateFailedMove
	jp PrintButItFailed
