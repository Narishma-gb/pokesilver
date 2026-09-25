OlderHaircutBrother:
	ld hl, HappinessData_OlderHaircutBrother
	jr HaircutOrGrooming

YoungerHaircutBrother:
	ld hl, HappinessData_YoungerHaircutBrother
	; fallthrough

HaircutOrGrooming:
	push hl
	farcall SelectMonFromParty
	pop hl
	jr c, .nope
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	push hl
	call GetCurNickname
	ld hl, wStringBuffer1
	ld de, wStringBuffer3
	ld bc, NAME_LENGTH
	call CopyBytes
	pop hl
	call Random
.loop
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	inc hl
	jr .loop

.ok
	inc hl
	ld a, [hli]
	ld [wScriptVar], a
	ld c, [hl]
	call ChangeHappiness
	ret

.nope
	xor a
	ld [wScriptVar], a
	ret

.egg
	ld a, 1
	ld [wScriptVar], a
	ret

INCLUDE "data/events/happiness_probabilities.asm"
