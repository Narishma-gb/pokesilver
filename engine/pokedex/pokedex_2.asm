AnimateDexSearchSlowpoke:
	ld hl, .FrameIDs
	ld b, 25
.loop
	ld a, [hli]

	; Wrap around
	cp $fe
	jr nz, .ok
	ld hl, .FrameIDs
	ld a, [hli]
.ok

	ld [wDexSearchSlowpokeFrame], a
	ld a, [hli]
	ld c, a
	push bc
	push hl
	call DoDexSearchSlowpokeFrame
	pop hl
	pop bc
	call DelayFrames
	dec b
	jr nz, .loop
	xor a
	ld [wDexSearchSlowpokeFrame], a
	call DoDexSearchSlowpokeFrame
	ld c, 32
	call DelayFrames
	ret

.FrameIDs:
	; frame ID, duration
	db 0, 7
	db 1, 7
	db 2, 7
	db 3, 7
	db 4, 7
	db -2

DoDexSearchSlowpokeFrame:
	ld a, [wDexSearchSlowpokeFrame]
	ld hl, .SlowpokeSpriteData
	ld de, wShadowOAMSprite00
.loop
	ld a, [hli]
	cp -1
	ret z
	ld [de], a ; y
	inc de
	ld a, [hli]
	ld [de], a ; x
	inc de
	ld a, [wDexSearchSlowpokeFrame]
	ld b, a
	add a
	add b
	add [hl]
	inc hl
	ld [de], a ; tile id
	inc de
	ld a, [hli]
	ld [de], a ; attributes
	inc de
	jr .loop

.SlowpokeSpriteData:
	dbsprite  9, 11, 0, 0, $00, 0
	dbsprite 10, 11, 0, 0, $01, 0
	dbsprite 11, 11, 0, 0, $02, 0
	dbsprite  9, 12, 0, 0, $10, 0
	dbsprite 10, 12, 0, 0, $11, 0
	dbsprite 11, 12, 0, 0, $12, 0
	dbsprite  9, 13, 0, 0, $20, 0
	dbsprite 10, 13, 0, 0, $21, 0
	dbsprite 11, 13, 0, 0, $22, 0
	db -1

DisplayDexEntry:
	call GetPokemonName
	hlcoord 9, 2
	call PlaceString ; mon species
	ld hl, PokedexDataPointerTable1
	ld a, [wTempSpecies]
	cp KINGLER + 1
	jr c, .gotTable
	sub KINGLER
	ld hl, PokedexDataPointerTable2
.gotTable
	dec a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 9, 4
	call PlaceString ; dex species
	ld h, b
	ld l, c
	push de
	ld de, PokeText
	call PlaceString
; Print dex number
	hlcoord 2, 8
	ld a, $5c ; No
	ld [hli], a
	ld a, $5d ; .
	ld [hli], a
	ld de, wTempSpecies
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
; Check to see if we caught it.  Get out of here if we haven't.
	ld a, [wTempSpecies]
	dec a
	call CheckCaughtMon
	pop de
	ret z
; Print the height (stored in tenths of meters internally).
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	inc de
	ld a, [de]
	and a
	jr z, .skip_height

	hlcoord 13, 6
	lb bc, 1, 3
	call PrintNum
	hlcoord 14, 6
	ld a, [de]
	cp 10
	jr nc, .skipZero
	ld [hl], '０' ; if the height is less than 1m, print a 0 before the decimal point
.skipZero
	inc hl
	ld a, [hli] ; insert the decimal point
	ld [hld], a
	ld [hl], '．'

.skip_height
; Print the weight stored in tenths of kg internally, 2-byte)
	inc de
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	or b
	push de
	jr z, .skip_weight

	ld hl, hDexWeight
	ld a, [hl] ; back-up [hDexWeight] and [hDexWeight + 1]
	push af
	ld a, [de]
	ld [hli], a ; store weight in big-endian order
	ld a, [hl]
	push af
	dec de
	ld a, [de]
	ld [hl], a

	ld de, hDexWeight
	hlcoord 12, 8
	lb bc, 2, 4
	call PrintNum
	hlcoord 14, 8
	ldh a, [hDexWeight + 1]
	sub 10
	ldh a, [hDexWeight]
	sbc 0
	jr nc, .skipZero2
	ld [hl], '０' ; if the weight is less than 1kg, print a 0 before the decimal point
.skipZero2
	inc hl
	ld a, [hli] ; insert the decimal point
	ld [hld], a
	ld [hl], '．'

	pop af
	ldh [hDexWeight + 1], a ; restore previous values at [hDexWeight] and [hDexWeight + 1]
	pop af
	ldh [hDexWeight], a

.skip_weight
	pop de
	inc de
	hlcoord 1, 11
	call PlaceString ; print pokedex text entry
	ret

PokeText:
	db "#@"
