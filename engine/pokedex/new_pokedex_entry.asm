NewPokedexEntry:
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	call LowVolume
	call ClearBGPalettes
	call ClearTilemap
	call UpdateSprites
	call ClearSprites
	farcall _NewPokedexEntry
	call WaitPressAorB_BlinkCursor
	call MaxVolume
	call RotateThreePalettesRight
	call .ReturnFromDexRegistration
	pop af
	ldh [hMapAnims], a
	ret

.ReturnFromDexRegistration:
	call ClearTilemap
	call LoadFontsExtra
	call LoadStandardFont
	farcall Pokedex_PlaceFrontpicTopLeftCorner
	call WaitBGMap2
	farcall GetEnemyMonDVs
	ld a, [hli]
	ld [wTempMonDVs], a
	ld a, [hl]
	ld [wTempMonDVs + 1], a
	ld b, SCGB_TRAINER_OR_MON_FRONTPIC_PALS
	call GetSGBLayout
	call SetDefaultBGPAndOBP
	ret
