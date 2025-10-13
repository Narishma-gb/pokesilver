NameMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 10, TEXTBOX_Y - 1
	dw .Names
	db 1 ; default option

.Names:
	db STATICMENU_CURSOR | STATICMENU_PLACE_TITLE | STATICMENU_DISABLE_B ; flags
	db 5 ; items
	db "じぶんできめる@"

PlayerNameArray:
IF DEF(_GOLD)
	db "ゴールド@"
	db "ヒロキ@"
	db "テツオ@"
	db "タカシ@"
ELIF DEF(_SILVER)
	db "シルバー@"
	db "カモン@"
	db "トオル@"
	db "マサオ@"
ENDC
	db 2 ; title indent
	db "なまえこうほ@" ; title
