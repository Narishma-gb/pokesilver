PokedexTypeSearchStrings:
; entries correspond with PokedexTypeSearchConversionTable (see data/types/search_types.asm)
	table_width POKEDEX_TYPE_STRING_LENGTH
	db "なし@@@"
	db "ノーマル@"
	db "ほのお　@"
	db "みず　　@"
	db "くさ　　@"
	db "でんき　@"
	db "こおり　@"
	db "かくとう@"
	db "どく　　@"
	db "じめん　@"
	db "ひこう　@"
	db "エスパー@"
	db "むし　　@"
	db "いわ　　@"
	db "ゴースト@"
	db "ドラゴン@"
	db "あく　　@"
	db "はがね　@"
	assert_table_length NUM_TYPES + 1
