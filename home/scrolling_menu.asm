ScrollingMenu::
	call CopyMenuData
	ldh a, [hROMBank]
	push af

	ld a, BANK(_ScrollingMenu) ; aka BANK(_InitScrollingMenu)
	rst Bankswitch

	call _InitScrollingMenu
	call .UpdatePalettes
	call _ScrollingMenu

	pop af
	rst Bankswitch

	ld a, [wMenuJoypad]
	ret

.UpdatePalettes:
	ld hl, wStateFlags
	bit SPRITE_UPDATES_DISABLED_F, [hl]
	jp nz, UpdateTimePals
	jp SetDefaultBGPAndOBP

InitScrollingMenu::
	ld a, [wMenuBorderTopCoord]
	dec a
	ld b, a
	ld a, [wMenuBorderBottomCoord]
	sub b
	ld d, a
	ld a, [wMenuBorderLeftCoord]
	dec a
	ld c, a
	ld a, [wMenuBorderRightCoord]
	sub c
	ld e, a
	push de
	call Coord2Tile
	pop bc
	jp Textbox
