Function671b:
	ld a, [wUnusedScriptByte]
	and a
	ret z
	cp -1
	jr z, .asm_6736
	ldh a, [hLastTalked]
	and $3
	ld e, a
	ld d, $0
	ld hl, Data6771
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	ld e, l
	ld d, h
	jr Function673e

.asm_6736
	ld de, Data676d
	jr Function673e

Function673b:
	ld de, Data6769
Function673e:
	ldh a, [hCGB]
	and a
	ret z
	ld hl, wBGPals1 palette PAL_BG_TEXT
	call .asm_6751
	ldh a, [rBGP]
	call DmgToCgbBGPals
	call DelayFrame
	ret

.asm_6751:
	ld a, [de]
	ld c, a
	inc de
	ld a, [de]
	ld b, a
	inc de
rept 3
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
endr
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a
	ret

Data6769:
	RGB 31, 31, 31
	RGB 00, 00, 00

Data676d:
	RGB 23, 21, 13
	RGB 00, 00, 00

Data6771:
	RGB 31, 31, 31
	RGB 00, 00, 00
	RGB 31, 31, 31
	RGB 00, 00, 00
	RGB 31, 31, 31
	RGB 00, 00, 00
	RGB 31, 31, 31
	RGB 00, 00, 00

Function6781:
	ld a, c
	cp $01
	jr z, .asm_678d
	cp $ff
	jr z, .asm_6791
	xor a
	jr .asm_6795

.asm_678d
	ld a, $01
	jr .asm_6795

.asm_6791
	ld a, $ff
	jr .asm_6795

.asm_6795
	ld [wUnusedScriptByte], a
	ret
