	object_const_def
	const ROUTE19_SWIMMER_GIRL
	const ROUTE19_SWIMMER_GUY1
	const ROUTE19_SWIMMER_GUY2
	const ROUTE19_SWIMMER_GUY3
	const ROUTE19_FISHER1
	const ROUTE19_FISHER2

Route19_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, Route19ClearRocksCallback

Route19ClearRocksCallback:
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iftrue .Done
	changeblock  6,  6, $7a ; rock
	changeblock  8,  6, $7a ; rock
	changeblock 10,  6, $7a ; rock
	changeblock 12,  8, $7a ; rock
	changeblock  4,  8, $7a ; rock
	changeblock 10, 10, $7a ; rock
.Done:
	endcallback

TrainerSwimmerfDawn:
	trainer SWIMMERF, DAWN, EVENT_BEAT_SWIMMERF_DAWN, SwimmerfDawnSeenText, SwimmerfDawnBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmerfDawnAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmermHarold:
	trainer SWIMMERM, HAROLD, EVENT_BEAT_SWIMMERM_HAROLD, SwimmermHaroldSeenText, SwimmermHaroldBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmermHaroldAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmermJerome:
	trainer SWIMMERM, JEROME, EVENT_BEAT_SWIMMERM_JEROME, SwimmermJeromeSeenText, SwimmermJeromeBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmermJeromeAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmermTucker:
	trainer SWIMMERM, TUCKER, EVENT_BEAT_SWIMMERM_TUCKER, SwimmermTuckerSeenText, SwimmermTuckerBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmermTuckerAfterBattleText
	waitbutton
	closetext
	end

Route19Fisher1Script:
	faceplayer
	opentext
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iftrue .RocksCleared
	writetext Route19Fisher1Text
	waitbutton
	closetext
	end

.RocksCleared:
	writetext Route19Fisher1Text_RocksCleared
	waitbutton
	closetext
	end

Route19Fisher2Script:
	faceplayer
	opentext
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iftrue .RocksCleared
	writetext Route19Fisher2Text
	waitbutton
	closetext
	end

.RocksCleared:
	writetext Route19Fisher2Text_RocksCleared
	waitbutton
	closetext
	end

Route19Sign:
	jumptext Route19SignText

CarefulSwimmingSign:
	jumptext CarefulSwimmingSignText

SwimmermHaroldSeenText:
	text "くらく　な<TTE>　から"
	line "うみで　およいだこと　ある？"
	done

SwimmermHaroldBeatenText:
	text "ざっぷーんっ！"
	done

SwimmermHaroldAfterBattleText:
	text "よる<NI>なると　うみ<GA>まっくろで"
	line "すいこまれそうな　きぶん<NI>なるよ"
	done

SwimmermTuckerSeenText:
	text "ぜえぜえ<⋯>"
	line "セキチク　シティまで<⋯>"
	cont "ぜえぜえ<⋯>　もう　すこし<⋯>"
	done

SwimmermTuckerBeatenText:
	text "お　おぼれるー！"
	done

SwimmermTuckerAfterBattleText:
	text "かのじょ<NI>セキチクまで"
	line "およごう<TTE>　いったんだよ<⋯>"
	cont "ぜえぜえ<⋯>"
	done

SwimmerfDawnSeenText:
	text "<WATASHI>　だらしのない　ひと"
	line "キライよ！"
	done

SwimmerfDawnBeatenText:
	text "およぎなら　かてるのに<⋯>"
	done

SwimmerfDawnAfterBattleText:
	text "セキチクと　ふたごじまの"
	line "おうふく　ぐらいで<⋯>"
	cont "がんばりなさいよ！　おとこでしょ！"
	done

SwimmermJeromeSeenText:
	text "およぎ<⋯>？"
	line "とくいじゃ　ないよ"
	cont "あさせで　みずあび　してるんだ"
	done

SwimmermJeromeBeatenText:
	text "かてると　おもったのに<⋯>！"
	done

SwimmermJeromeAfterBattleText:
	text "およぎ<GA>にがて　でも"
	line "うみ<WA>だいすき　なのさ！"
	done

Route19Fisher1Text:
	text "<KOKO_WA>こうじちゅうで　すすめないよ"
	line "グレンタウンに<WA>マサラタウンの"
	cont "ほうから　まわりみち　してくれ"
	done

Route19Fisher1Text_RocksCleared:
	text "あせ<WO>いっぱい　かいたから"
	line "ひとおよぎでも　するか！"
	done

Route19Fisher2Text:
	text "こ<NO>いわ<WO>どかすのに"
	line "どれくらい　かかるかなぁ<⋯>"
	done

Route19Fisher2Text_RocksCleared:
	text "やっと　こうじ<GA>おわったよ！"

	para "これで　つり<NI>いける<TTE>　もんだ！"
	done

Route19SignText:
	text "<KOKO_WA>１９ばん　すいどう"
	line "セキチクシティ　<⋯>　ふたごじま"
	done

CarefulSwimmingSignText:
	text "およいで　ふたごじまへ　いく　ひとは"
	line "じゅうぶん　ちゅういして　ください！"

	para "<⋯>　セキチク　けいさつ　より"
	done

Route19_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  3, ROUTE_19_FUCHSIA_GATE, 3

	def_coord_events

	def_bg_events
	bg_event 11, 13, BGEVENT_READ, Route19Sign
	bg_event 11,  1, BGEVENT_READ, CarefulSwimmingSign

	def_object_events
	object_event  9, 23, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 0, TrainerSwimmerfDawn, -1
	object_event 13, 28, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermHarold, -1
	object_event 11, 17, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermJerome, -1
	object_event  8, 23, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 0, TrainerSwimmermTucker, -1
	object_event  9,  5, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 1, Route19Fisher1Script, -1
	object_event 11,  5, SPRITE_FISHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 1, Route19Fisher2Script, -1
