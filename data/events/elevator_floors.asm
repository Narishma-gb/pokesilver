ElevatorFloorNames:
; entries correspond to FLOOR_* constants
	table_width 2
	dw .B4F
	dw .B3F
	dw .B2F
	dw .B1F
	dw ._1F
	dw ._2F
	dw ._3F
	dw ._4F
	dw ._5F
	dw ._6F
	dw ._7F
	dw ._8F
	dw ._9F
	dw ._10F
	dw ._11F
	dw .ROOF
	assert_table_length NUM_FLOORS

.B4F:  db "ちか４かい@"
.B3F:  db "ちか３かい@"
.B2F:  db "ちか２かい@"
.B1F:  db "ちか１かい@"
._1F:  db "１かい@"
._2F:  db "２かい@"
._3F:  db "３かい@"
._4F:  db "４かい@"
._5F:  db "５かい@"
._6F:  db "６かい@"
._7F:  db "７かい@"
._8F:  db "８かい@"
._9F:  db "９かい@"
._10F: db "１０かい@"
._11F: db "１１かい@"
.ROOF: db "おくじょう@"
