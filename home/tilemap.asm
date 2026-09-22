ClearBGPalettes::
	call ClearPalettes
WaitBGMap::
; Tell VBlank to update BG Map
	ld a, 1 ; BG Map 0 tiles
	ldh [hBGMapMode], a
; Wait for it to do its magic
	ld c, 4
	call DelayFrames
	ret

WaitBGMap2::
	ldh a, [hCGB]
	and a
	jr z, .bg0

	ld a, 2
	ldh [hBGMapMode], a
	ld c, 4
	call DelayFrames

.bg0
	ld a, 1
	ldh [hBGMapMode], a
	ld c, 4
	call DelayFrames
	ret

IsCGB::
	ldh a, [hCGB]
	and a
	ret

ApplyTilemap::
	ldh a, [hCGB]
	and a
	jr z, .dmg

	ld a, [wSpriteUpdatesEnabled]
	cp FALSE
	jr z, .dmg

	ld a, 1
	ldh [hBGMapMode], a
	jr CopyTilemapAtOnce

.dmg
; WaitBGMap
	ld a, 1
	ldh [hBGMapMode], a
	ld c, 4
	call DelayFrames
	ret

CGBOnly_CopyTilemapAtOnce::
	ldh a, [hCGB]
	and a
	jr z, WaitBGMap

CopyTilemapAtOnce::
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a

	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a

.wait
	ldh a, [rLY]
	cp $60
	jr c, .wait

	di
	ld a, BANK(vBGMap2)
	ldh [rVBK], a
	decoord 0, 0, wAttrmap
	call .CopyBGMap
	ld a, BANK(vBGMap0)
	ldh [rVBK], a
	decoord 0, 0
	call .CopyBGMap
	ei

	pop af
	ldh [hMapAnims], a
	pop af
	ldh [hBGMapMode], a
	ret

.CopyBGMap:
	ldh a, [hBGMapAddress + 1]
	ld h, a
	ld l, 0
	ld a, SCREEN_HEIGHT

.row
	push af
	ld c, SCREEN_WIDTH
	ld b, STAT_BUSY

; wait until PPU v/hblank mode
.loop
	ldh a, [rSTAT]
	and b
	jr nz, .loop

	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .loop

	ld bc, TILEMAP_WIDTH - SCREEN_WIDTH
	add hl, bc
	pop af
	dec a
	jr nz, .row
	ret

SetDefaultBGPAndOBP::
; Inits the Palettes
; depending on the system the monochromes palettes or color palettes
	ldh a, [hCGB]
	and a
	jr nz, .SetDefaultBGPAndOBPForGameBoyColor
	ld a, %11100100
	ldh [rBGP], a
	ld a, %11010000
	ldh [rOBP0], a
	ldh [rOBP1], a
	ret

.SetDefaultBGPAndOBPForGameBoyColor:
	push de
	ld a, %11100100
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	call DmgToCgbObjPals
	pop de
	ret

ClearPalettes::
; Make all palettes white

; CGB: make all the palette colors white
	ldh a, [hCGB]
	and a
	jr nz, .cgb

; DMG: just change palettes to 0 (white)
	xor a
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
	ret

.cgb
; Fill wBGPals2 and wOBPals2 with $ffff (white)
	ld hl, wBGPals2
	ld bc, 16 palettes
	ld a, $ff
	call ByteFill
; Request palette update
	ld a, TRUE
	ldh [hCGBPalUpdate], a
	ret

GetMemSGBLayout::
	ld b, SCGB_DEFAULT
GetSGBLayout::
; load sgb packets unless dmg

	ldh a, [hCGB]
	and a
	jr nz, .sgb

	ldh a, [hSGB]
	and a
	ret z

.sgb
	predef_jump LoadSGBLayout

SetHPPal::
; Set palette for hp bar pixel length e at hl.
	ld a, e
	cp (HP_BAR_LENGTH_PX * 50 / 100) ; 24
	ld d, HP_GREEN
	jr nc, .set
	cp (HP_BAR_LENGTH_PX * 21 / 100) ; 10
	assert HP_GREEN + 1 == HP_YELLOW
	inc d
	jr nc, .set
	assert HP_YELLOW + 1 == HP_RED
	inc d
.set
	ld [hl], d
	ret
