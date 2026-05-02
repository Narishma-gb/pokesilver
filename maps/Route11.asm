	object_const_def
	const ROUTE11_YOUNGSTER1
	const ROUTE11_YOUNGSTER2
	const ROUTE11_YOUNGSTER3
	const ROUTE11_YOUNGSTER4
	const ROUTE11_FRUIT_TREE

Route11_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerYoungsterOwen:
	trainer YOUNGSTER, OWEN, EVENT_BEAT_YOUNGSTER_OWEN, YoungsterOwenSeenText, YoungsterOwenBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext YoungsterOwenAfterBattleText
	waitbutton
	closetext
	end

TrainerYoungsterJason:
	trainer YOUNGSTER, JASON, EVENT_BEAT_YOUNGSTER_JASON, YoungsterJasonSeenText, YoungsterJasonBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext YoungsterJasonAfterBattleText
	waitbutton
	closetext
	end

TrainerPsychicHerman:
	trainer PSYCHIC_T, HERMAN, EVENT_BEAT_PSYCHIC_HERMAN, PsychicHermanSeenText, PsychicHermanBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PsychicHermanAfterBattleText
	waitbutton
	closetext
	end

TrainerPsychicFidel:
	trainer PSYCHIC_T, FIDEL, EVENT_BEAT_PSYCHIC_FIDEL, PsychicFidelSeenText, PsychicFidelBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PsychicFidelAfterBattleText
	waitbutton
	closetext
	end

Route11Sign:
	jumptext Route11SignText

Route11FruitTree:
	fruittree FRUITTREE_ROUTE_11

Route11HiddenRevive:
	hiddenitem REVIVE, EVENT_ROUTE_11_HIDDEN_REVIVE

YoungsterOwenSeenText:
	text "#<NI>ずる<WA>なし　だよ！"
	line "せいせい　どうどう　やろう！"
	done

YoungsterOwenBeatenText:
	text "ありゃ？"
	line "こんな　はずじゃ<⋯>"
	done

YoungsterOwenAfterBattleText:
	text "せいせい　どうどう　たたかっ<TA!>"
	line "だから　ぼく　こうかい　しないよ！"
	done

YoungsterJasonSeenText:
	text "たんパンで　くさむら　あるくと"
	line "はっぱ<GA>ちくちく　くすぐったい！"
	done

YoungsterJasonBeatenText:
	text "うひゃーっ"
	line "まけたーっ！"
	done

YoungsterJasonAfterBattleText:
	text "くさむらで　もっと　#"
	line "つかまえようっと！"
	done

PsychicHermanSeenText:
	text "<⋯>　<⋯>　<⋯>"
	done

PsychicHermanBeatenText:
	text "<⋯>　<⋯>　<⋯>"
	done

PsychicHermanAfterBattleText:
	text "<⋯>　<⋯>　<⋯>"

	para "め<WO>とじてる　あいだに"
	line "まけちゃった<⋯>"
	done

PsychicFidelSeenText:
	text "ボクに<WA>みえる<⋯>"
	line "キミ<NO>すべてが<⋯>"
	done

PsychicFidelBeatenText:
	text "キミ<NO>つよさは"
	line "よち　できなかった<⋯>"
	done

PsychicFidelAfterBattleText:
	text "しんじる　ちから<⋯>"

	para "#たち<WO>しんじてるから"
	line "キミ<WA>つよいんだね<⋯>"
	done

Route11SignText:
	text "<KOKO_WA>１１<ROUTE>"
	done

Route11_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events
	bg_event  3,  7, BGEVENT_READ, Route11Sign
	bg_event 32,  5, BGEVENT_ITEM, Route11HiddenRevive

	def_object_events
	object_event 22, 14, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerYoungsterOwen, -1
	object_event 15,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerYoungsterJason, -1
	object_event 29,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerPsychicHerman, -1
	object_event  7,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPsychicFidel, -1
	object_event 32,  2, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route11FruitTree, -1
