TypeNames:
; entries correspond to types (see constants/type_constants.asm)
	table_width 2
	dw Normal
	dw Fighting
	dw Flying
	dw Poison
	dw Ground
	dw Rock
	dw Bird
	dw Bug
	dw Ghost
	dw Steel
	assert_table_length UNUSED_TYPES
	dw Normal
	dw Normal
	dw Normal
	dw Normal
	dw Normal
	dw Normal
	dw Normal
	dw Normal
	dw Normal
	dw CurseType
	assert_table_length UNUSED_TYPES_END
	dw Fire
	dw Water
	dw Grass
	dw Electric
	dw Psychic
	dw Ice
	dw Dragon
	dw Dark
	assert_table_length TYPES_END

Normal:    db "ノーマル@"
Fighting:  db "かくとう@"
Flying:    db "ひこう@"
Poison:    db "どく　@"
CurseType: db "？？？@"
Fire:      db "ほのお@"
Water:     db "みず　@"
Grass:     db "くさ　@"
Electric:  db "でんき@"
Psychic:   db "エスパー@"
Ice:       db "こおり@"
Ground:    db "じめん@"
Rock:      db "いわ@"
Bird:      db "とり@"
Bug:       db "むし@"
Ghost:     db "ゴースト@"
Steel:     db "はがね@"
Dragon:    db "ドラゴン@"
Dark:      db "あく@"
