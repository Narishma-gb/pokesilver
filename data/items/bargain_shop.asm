BargainShopData:
	db 5
	dbw NUGGET,     4500
IF DEF(_09_30) || DEF(_10_06)
	dbw PEARL,      1200
	dbw BIG_PEARL,  7000
	dbw STARDUST,   1600
	dbw STAR_PIECE, 9300
ELIF DEF(_REV0)
	dbw PEARL,       650
	dbw BIG_PEARL,  3500
	dbw STARDUST,    900
	dbw STAR_PIECE, 4600
ENDC
	db -1
