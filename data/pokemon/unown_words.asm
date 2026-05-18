UnownWords:
; entries correspond to UNOWN_* form constants
	table_width 2
	dw UnownWordA ; unused
	dw UnownWordA
	dw UnownWordB
	dw UnownWordC
	dw UnownWordD
	dw UnownWordE
	dw UnownWordF
	dw UnownWordG
	dw UnownWordH
	dw UnownWordI
	dw UnownWordJ
	dw UnownWordK
	dw UnownWordL
	dw UnownWordM
	dw UnownWordN
	dw UnownWordO
	dw UnownWordP
	dw UnownWordQ
	dw UnownWordR
	dw UnownWordS
	dw UnownWordT
	dw UnownWordU
	dw UnownWordV
	dw UnownWordW
	dw UnownWordX
	dw UnownWordY
	dw UnownWordZ
	assert_table_length NUM_UNOWN + 1

pushc dex_unown

	list_start
UnownWordA: li "ANGRY"
UnownWordB: li "BEAR"
UnownWordC: li "CHASE"
UnownWordD: li "DIRECT"
UnownWordE: li "ENGAGE"
UnownWordF: li "FIND"
UnownWordG: li "GIVE"
UnownWordH: li "HELP"
UnownWordI: li "INCREASE"
UnownWordJ: li "JOIN"
UnownWordK: li "KEEP"
UnownWordL: li "LAUGH"
UnownWordM: li "MAKE"
UnownWordN: li "NUZZLE"
UnownWordO: li "OBSERVE"
UnownWordP: li "PERFORM"
UnownWordQ: li "QUICKEN"
UnownWordR: li "REASSURE"
UnownWordS: li "SEARCH"
UnownWordT: li "TELL"
UnownWordU: li "UNDO"
UnownWordV: li "VANISH"
UnownWordW: li "WANT"
UnownWordX: li "XXXXX"
UnownWordY: li "YIELD"
UnownWordZ: li "ZOOM"
	assert_list_length NUM_UNOWN

popc
