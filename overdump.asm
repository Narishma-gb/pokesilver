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


IF DEF(_GOLD)
	def bank_01_overdump equ $7efb
ELIF DEF(_SILVER)
	def bank_01_overdump equ $7ec0
ENDC

SECTION "Bank 01 Overdump", ROMX[bank_01_overdump], BANK[1]

; partial overdump of ReturnShuckie
	db HIGH(wScriptVar)
	ret

Overdump_OlderHaircutBrother:
	ld hl, Overdump_HappinessData_OlderHaircutBrother
	jr Overdump_HaircutOrGrooming

Overdump_YoungerHaircutBrother:
	ld hl, Overdump_HappinessData_YoungerHaircutBrother
	; fallthrough

Overdump_HaircutOrGrooming:
	push hl
	farcall SelectMonFromParty
	pop hl
	jr c, .nope
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	push hl
	call $39bb ; GetCurNickname
	ld hl, wStringBuffer1
	ld de, wStringBuffer3
	ld bc, NAME_LENGTH
	call $3104 ; CopyBytes
	pop hl
	call $308c ; Random
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
IF DEF(_GOLD)
	call $7cdc ; ChangeHappiness
ELIF DEF(_SILVER)
	call $7ca1 ; ChangeHappiness
ENDC
	ret

.nope
	xor a
	ld [wScriptVar], a
	ret

.egg
	ld a, 1
	ld [wScriptVar], a
	ret

Overdump_HappinessData_OlderHaircutBrother:
	db 30 percent,     2, HAPPINESS_OLDERCUT1
	db 50 percent + 1, 3, HAPPINESS_OLDERCUT2
	db -1,             4, HAPPINESS_OLDERCUT3

Overdump_HappinessData_YoungerHaircutBrother:
	db 60 percent + 1, 2, HAPPINESS_YOUNGCUT1
	db 30 percent,     3, HAPPINESS_YOUNGCUT2
	db -1,             4, HAPPINESS_YOUNGCUT3

IF DEF(_SILVER)
; another partial overdump of OlderHaircutBrother
	jr Overdump2_HaircutOrGrooming

Overdump2_YoungerHaircutBrother:
	ld hl, Overdump2_HappinessData_YoungerHaircutBrother
	; fallthrough

Overdump2_HaircutOrGrooming:
	push hl
	farcall SelectMonFromParty
	pop hl
	jr c, .nope
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	push hl
	call $39bb ; GetCurNickname
	ld hl, wStringBuffer1
	ld de, wStringBuffer3
	ld bc, NAME_LENGTH
	call $3104 ; CopyBytes
	pop hl
	call $308c ; Random
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
	call $7cfa ; ChangeHappiness
	ret

.nope
	xor a
	ld [wScriptVar], a
	ret

.egg
	ld a, 1
	ld [wScriptVar], a
	ret

Overdump2_HappinessData_OlderHaircutBrother:
	db 30 percent,     2, HAPPINESS_OLDERCUT1
	db 50 percent + 1, 3, HAPPINESS_OLDERCUT2
	db -1,             4, HAPPINESS_OLDERCUT3

Overdump2_HappinessData_YoungerHaircutBrother:
	db 60 percent + 1, 2, HAPPINESS_YOUNGCUT1
	db 30 percent,     3, HAPPINESS_YOUNGCUT2
	db -1,             4, HAPPINESS_YOUNGCUT3
ENDC


SECTION "Bank 02 Overdump", ROMX[$7b5d], BANK[2]

; partial overdump of SlotMachinePals
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 00, 00, 00
	RGB 00, 00, 00
