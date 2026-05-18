MACRO npctrade
; dialog set, requested mon, offered mon, nickname, dvs, item, OT ID, OT name, gender requested
	db \1, \2, \3
	dname \4, NAME_LENGTH - 2
	db \5, \6, \7
	dw \8
	dname \9, NAME_LENGTH - 3
	db \<10>
ENDM

NPCTrades:
; entries correspond to NPCTRADE_* constants
	table_width NPCTRADE_STRUCT_LENGTH
	npctrade TRADE_DIALOGSET_COLLECTOR, DROWZEE,    MACHOP,     "きんにく", $37, $66, GOLD_BERRY,   37460, "ナオキ", TRADE_GENDER_EITHER
	npctrade TRADE_DIALOGSET_COLLECTOR, BELLSPROUT, ONIX,       "ブルブル", $96, $66, BITTER_BERRY, 48926, "コンタ", TRADE_GENDER_EITHER
	npctrade TRADE_DIALOGSET_HAPPY,     KRABBY,     VOLTORB,    "ビリー",   $98, $88, PRZCUREBERRY, 29189,  "ゲン", TRADE_GENDER_EITHER
	npctrade TRADE_DIALOGSET_NEWBIE,    DRAGONAIR,  RHYDON,     "ドンドコ",  $77, $66, BITTER_BERRY, 00283, "ミサコ", TRADE_GENDER_FEMALE
	npctrade TRADE_DIALOGSET_HAPPY,     GLOOM,      RAPIDASH,   "カケアシ", $96, $66, BURNT_BERRY,  15616, "デンジ", TRADE_GENDER_EITHER
	npctrade TRADE_DIALOGSET_NEWBIE,    CHANSEY,    AERODACTYL, "プッチー",  $96, $66, GOLD_BERRY,   26491, "キヨミ", TRADE_GENDER_EITHER
	assert_table_length NUM_NPC_TRADES
