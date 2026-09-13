CheckForLuckyNumberWinners:
	xor a
	ld [wScriptVar], a
	ld [wTempByteValue], a
	ld a, [wPartyCount]
	and a
	ret z
	ld d, a
	ld hl, wPartyMon1ID
IF DEF(_09_30)
.PartyLoop:
	call .CompareLuckyNumberToMonID
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	dec d
	jr nz, .PartyLoop
ELIF DEF(_10_06) || DEF(_REV0)
	ld bc, wPartySpecies
.PartyLoop:
	ld a, [bc]
	inc bc
	cp EGG
	call nz, .CompareLuckyNumberToMonID
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	dec d
	jr nz, .PartyLoop
ENDC
	ld a, BANK(sBox)
	call OpenSRAM
	ld a, [sBoxCount]
	and a
	jr z, .SkipOpenBox
	ld d, a
	ld hl, sBoxMon1ID
IF DEF(_09_30)
.OpenBoxLoop:
	call .CompareLuckyNumberToMonID
	jr nc, .SkipOpenBoxMon
	ld a, TRUE
	ld [wTempByteValue], a

.SkipOpenBoxMon:
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	dec d
	jr nz, .OpenBoxLoop

ELIF DEF(_10_06) || DEF(_REV0)
	ld bc, sBoxSpecies
.OpenBoxLoop:
	ld a, [bc]
	inc bc
	cp EGG
	IF DEF(_10_06)
		call z, .SkipOpenBoxMon
	ELIF DEF(_REV0)
		jr z, .SkipOpenBoxMon
	ENDC
	call .CompareLuckyNumberToMonID
	jr nc, .SkipOpenBoxMon
	ld a, TRUE
	ld [wTempByteValue], a

.SkipOpenBoxMon:
	push bc
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	dec d
	jr nz, .OpenBoxLoop
ENDC

.SkipOpenBox:
	call CloseSRAM
	ld c, $0
.BoxesLoop:
IF DEF(_10_06) || DEF(_REV0)
	ld a, [wCurBox]
	and $f
	cp c
	jr z, .SkipBox
ENDC
	ld hl, .BoxBankAddresses
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	call OpenSRAM
	ld a, [hli]
	ld h, [hl]
	ld l, a ; hl now contains the address of the loaded box in SRAM
	ld a, [hl]
	and a
	jr z, .SkipBox ; no mons in this box
	push bc
IF DEF(_10_06) || DEF(_REV0)
	ld b, h
	ld c, l
	inc bc
ENDC
	ld de, sBoxMon1ID - sBox
	add hl, de
	ld d, a
.BoxNLoop:
IF DEF(_10_06) || DEF(_REV0)
	ld a, [bc]
	inc bc
	cp EGG
	jr z, .SkipBoxMon
ENDC

	call .CompareLuckyNumberToMonID ; sets wScriptVar and wCurPartySpecies appropriately
	jr nc, .SkipBoxMon
	ld a, TRUE
	ld [wTempByteValue], a

.SkipBoxMon:
IF DEF(_09_30)
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc

ELIF DEF(_10_06) || DEF(_REV0)
	push bc
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	pop bc
ENDC
	dec d
	jr nz, .BoxNLoop
	pop bc

.SkipBox:
	inc c
	ld a, c
	cp NUM_BOXES
	jr c, .BoxesLoop

	call CloseSRAM
	ld a, [wScriptVar]
	and a
	ret z ; found nothing

	ld a, [wTempByteValue]
	and a
	push af
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, .LuckyNumberMatchPartyText
	pop af
	jr z, .print
	ld hl, .LuckyNumberMatchPCText

.print
	jp PrintText

.CompareLuckyNumberToMonID:
IF DEF(_10_06) || DEF(_REV0)
	push bc
ENDC
	push de
	push hl
	ld d, h
	ld e, l
	ld hl, wMonIDDigitsBuffer
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	ld hl, wLuckyNumberDigitsBuffer
	ld de, wLuckyIDNumber
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	ld b, 5
	ld c, 0
	ld hl, wLuckyNumberDigitsBuffer + 4
	ld de, wMonIDDigitsBuffer + 4
.loop
	ld a, [de]
	cp [hl]
	jr nz, .done
	dec de
	dec hl
	inc c
	dec b
	jr nz, .loop

.done
	pop hl
	push hl
	ld de, MON_SPECIES - MON_OT_ID
	add hl, de
	ld a, [hl]
	pop hl
	pop de
	push af
	ld a, c
	ld b, 1
	cp 5
	jr z, .okay
	ld b, 2
	cp 3
	jr nc, .okay
	ld b, 3
	cp 2
	jr nz, .nomatch

.okay
	inc b
	ld a, [wScriptVar]
	and a
	jr z, .bettermatch
	cp b
	jr c, .nomatch

.bettermatch
	dec b
	ld a, b
	ld [wScriptVar], a
	pop bc
	ld a, b
	ld [wCurPartySpecies], a
IF DEF(_10_06) || DEF(_REV0)
	pop bc
ENDC
	scf
	ret

.nomatch
	pop bc
IF DEF(_10_06) || DEF(_REV0)
	pop bc
ENDC
	and a
	ret

.BoxBankAddresses:
	table_width 3
for n, 1, NUM_BOXES + 1
	dba sBox{d:n}
endr
	assert_table_length NUM_BOXES

.LuckyNumberMatchPartyText:
	text "おめでとうございます！　あなたが"
	line "つれている　@"
	text_ram wStringBuffer1
	text "ちゃんの"

	para "アイディナンバー<GA>みごとに"
	line "いっちしました"
	prompt

.LuckyNumberMatchPCText:
	text "おめでとうございます！　<PC>に"
	line "あずけている　@"
	text_ram wStringBuffer1
	text "ちゃんの"

	para "アイディナンバー<GA>みごとに"
	line "いっちしました"
	prompt

PrintTodaysLuckyNumber:
	ld hl, wStringBuffer3
	ld de, wLuckyIDNumber
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	ld a, '@'
	ld [wStringBuffer3 + 5], a
	ret
