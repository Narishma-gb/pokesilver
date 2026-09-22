SECTION "Bank 00 Overdump", ROM0[$3d70]

; partial overdump of TryRestartMapMusic
	dw $3c14 ; PlayMusic
	call DelayFrame
	xor a
	ld [wDontPlayMapMusicOnReload], a
	ret

Overdump_RestartMapMusic:
	push hl
	push de
	push bc
	push af
	ld de, MUSIC_NONE
	call $3c14 ; PlayMusic
	call DelayFrame
	ld a, [wMapMusic]
	ld e, a
	ld d, 0
	call $3c14 ; PlayMusic
	pop af
	pop bc
	pop de
	pop hl
	ret

Overdump_SpecialMapMusic:
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .surf

	and a
	ret

.bike ; unreferenced
	ld de, MUSIC_BICYCLE
	scf
	ret

.surf
	ld de, MUSIC_SURF
	scf
	ret

Overdump_GetMapMusic_MaybeSpecial:
	call Overdump_SpecialMapMusic
	ret c
	call $2d9b ; GetMapMusic
	ret

Overdump_PlaceBCDNumberSprite:
	ld a, 4 * TILE_WIDTH
	ld [wShadowOAMSprite38YCoord], a
	ld [wShadowOAMSprite39YCoord], a
	ld a, 10 * TILE_WIDTH
	ld [wShadowOAMSprite38XCoord], a
	ld a, 11 * TILE_WIDTH
	ld [wShadowOAMSprite39XCoord], a
	xor a
	ld [wShadowOAMSprite38Attributes], a
	ld [wShadowOAMSprite39Attributes], a
	ld a, [wUnusedBCDNumber]
	cp 100
	jr nc, .max
	add 1
	daa
	ld b, a
	swap a
	and $f
	add '０'
	ld [wShadowOAMSprite38TileID], a
	ld a, b
	and $f
	add '０'
	ld [wShadowOAMSprite39TileID], a
	ret

.max
	ld a, '９'
	ld [wShadowOAMSprite38TileID], a
	ld [wShadowOAMSprite39TileID], a
	ret

Overdump_CheckSFX:
	ld a, [wChannel5Flags1]
	bit SOUND_CHANNEL_ON, a
	jr nz, .playing
	ld a, [wChannel6Flags1]
	bit SOUND_CHANNEL_ON, a
	jr nz, .playing
	ld a, [wChannel7Flags1]
	bit SOUND_CHANNEL_ON, a
	jr nz, .playing
	ld a, [wChannel8Flags1]
	bit SOUND_CHANNEL_ON, a
	jr nz, .playing
	and a
	ret
.playing
	scf
	ret

Overdump_TerminateExpBarSound:
	xor a
	ld [wChannel5Flags1], a
	ld [wPitchSweep], a
	ldh [rAUD1SWEEP], a
	ldh [rAUD1LEN], a
	ldh [rAUD1ENV], a
	ldh [rAUD1LOW], a
	ldh [rAUD1HIGH], a
	ret

IF DEF(_SILVER)
; another partial overdump of CheckSFX
Overdump2_CheckSFX_partial:
	db $47
	jr nz, .playing
	ld a, [wChannel6Flags1]
	bit SOUND_CHANNEL_ON, a
	jr nz, .playing
	ld a, [wChannel7Flags1]
	bit SOUND_CHANNEL_ON, a
	jr nz, .playing
	ld a, [wChannel8Flags1]
	bit SOUND_CHANNEL_ON, a
	jr nz, .playing
	and a
	ret
.playing
	scf
	ret

Overdump2_TerminateExpBarSound:
	xor a
	ld [wChannel5Flags1], a
	ld [wPitchSweep], a
	ldh [rAUD1SWEEP], a
	ldh [rAUD1LEN], a
	ldh [rAUD1ENV], a
	ldh [rAUD1LOW], a
	ldh [rAUD1HIGH], a
	ret
ENDC
