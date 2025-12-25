; RestartClock_GetWraparoundTime.WrapAroundTimes indexes
	const_def 1
	const RESTART_CLOCK_DAY
	const RESTART_CLOCK_HOUR
	const RESTART_CLOCK_MIN
DEF NUM_RESTART_CLOCK_DIVISIONS EQU const_value - 1

RestartClock_GetWraparoundTime:
	push hl
	dec a
	ld e, a
	ld d, 0
	ld hl, .WrapAroundTimes
rept 4
	add hl, de
endr
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld b, [hl]
	inc hl
	ld c, [hl]
	pop hl
	ret

.WrapAroundTimes:
; entries correspond to RESTART_CLOCK_* constants
MACRO wraparound_time
	dw \1 ; value pointer
	db \2 ; maximum value
	db \3 ; up/down arrow x coord (pairs with wRestartClockUpArrowYCoord)
ENDM
	wraparound_time wRestartClockDay,   7,  3
	wraparound_time wRestartClockHour, 24,  9
	wraparound_time wRestartClockMin,  60, 15

RestartClock:
; If we're here, we had an RTC overflow.
	ld hl, .ClockTimeMayBeWrongText
	call PrintText
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	call LoadStandardMenuHeader
	call ClearTilemap
	ld hl, .ClockSetWithControlPadText
	call PrintText
	call .SetClock
	call ExitMenu
	pop bc
	ld hl, wOptions
	ld [hl], b
	ld c, a
	ret

.ClockTimeMayBeWrongText:
	text "とけいの　じかんが　オーバー"
	line "しているかもしれません"

	para "じかんを　あわせてください"
	prompt

.ClockSetWithControlPadText:
	text "じゅうじキーで　せんたく"
	line "エーで　けってい　ビーで　キャンセル"
	done

.SetClock:
	ld a, RESTART_CLOCK_DAY
	ld [wRestartClockCurDivision], a
	ld [wRestartClockPrevDivision], a
	ld a, 8
	ld [wRestartClockUpArrowYCoord], a
	call UpdateTime
	call GetWeekday
	ld [wRestartClockDay], a
	ldh a, [hHours]
	ld [wRestartClockHour], a
	ldh a, [hMinutes]
	ld [wRestartClockMin], a

.loop
	call .joy_loop
	jr nc, .loop
	and a
	ret nz
	call .PrintTime
	ld hl, .ClockIsThisOKText
	call PrintText
	call YesNoBox
	jr c, .cancel
	ld a, [wRestartClockDay]
	ld [wStringBuffer2], a
	ld a, [wRestartClockHour]
	ld [wStringBuffer2 + 1], a
	ld a, [wRestartClockMin]
	ld [wStringBuffer2 + 2], a
	xor a
	ld [wStringBuffer2 + 3], a
	call InitTime
	call .PrintTime
	ld hl, .ClockHasResetText
	call PrintText
	call WaitPressAorB_BlinkCursor
	xor a ; FALSE
	ret

.cancel
	ld a, TRUE
	ret

.ClockIsThisOKText:
	text "これで　いいですか？"
	done

.ClockHasResetText:
	text "じかんを　さいせってい　しました！"
	done

.joy_loop
	call JoyTextDelay_ForcehJoyDown
	ld c, a
	push af
	call .PrintTime
	pop af
	bit B_PAD_A, a
	jr nz, .press_A
	bit B_PAD_B, a
	jr nz, .press_B
	bit B_PAD_UP, a
	jr nz, .pressed_up
	bit B_PAD_DOWN, a
	jr nz, .pressed_down
	bit B_PAD_LEFT, a
	jr nz, .pressed_left
	bit B_PAD_RIGHT, a
	jr nz, .pressed_right
	jr .joy_loop

.press_A
	ld a, FALSE
	scf
	ret

.press_B
	ld a, TRUE
	scf
	ret

.pressed_up
	ld a, [wRestartClockCurDivision]
	call RestartClock_GetWraparoundTime
	ld a, [de]
	inc a
	ld [de], a
	cp b
	jr c, .done_scroll
	ld a, 0
	ld [de], a
	jr .done_scroll

.pressed_down
	ld a, [wRestartClockCurDivision]
	call RestartClock_GetWraparoundTime
	ld a, [de]
	dec a
	ld [de], a
	cp -1
	jr nz, .done_scroll
	ld a, b
	dec a
	ld [de], a
	jr .done_scroll

.pressed_left
	ld hl, wRestartClockCurDivision
	dec [hl]
	jr nz, .done_scroll
	ld [hl], RESTART_CLOCK_MIN
	jr .done_scroll

.pressed_right
	ld hl, wRestartClockCurDivision
	inc [hl]
	ld a, [hl]
	cp NUM_RESTART_CLOCK_DIVISIONS + 1
	jr c, .done_scroll
	ld [hl], RESTART_CLOCK_DAY

.done_scroll
	xor a ; FALSE
	ret

.PrintTime:
	hlcoord 0, 5
	ld b, 5
	ld c, 18
	call Textbox
	ld c, 1
	call .GetCoords
	ld d, h
	ld e, l
	ld a, [wRestartClockDay]
	ld b, a
	farcall PrintDayOfWeek
	ld c, 7
	call .GetCoords
	ld d, h
	ld e, l
	ld a, [wRestartClockHour]
	ld c, a
	farcall PrintHour
	ld c, 14
	call .GetCoords
	ld de, wRestartClockMin
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNum
	ld c, 16
	call .GetCoords
	ld de, MinuteString
	call PlaceString
	ld a, [wRestartClockPrevDivision]
	call RestartClock_GetWraparoundTime
	ld a, [wRestartClockUpArrowYCoord]
	sub 2
	ld b, a
	call Coord2Tile
	ld [hl], '　'
	ld bc, 4 * SCREEN_WIDTH
	add hl, bc
	ld [hl], '　'
	ld a, [wRestartClockCurDivision]
	call RestartClock_GetWraparoundTime
	ld a, [wRestartClockUpArrowYCoord]
	sub 2
	ld b, a
	call Coord2Tile
	ld [hl], '▲'
	ld bc, 4 * SCREEN_WIDTH
	add hl, bc
	ld [hl], '▼'
	ld a, [wRestartClockCurDivision]
	ld [wRestartClockPrevDivision], a
	ret

.GetCoords:
	ld a, [wRestartClockUpArrowYCoord]
	ld b, a
	call Coord2Tile
	ret

HourString: ; unreferenced
	db "じ@"

MinuteString:
	db "ふん@"
