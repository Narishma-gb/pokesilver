	object_const_def
	const ROUTE18_YOUNGSTER1
	const ROUTE18_YOUNGSTER2

Route18_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerBirdKeeperBoris:
	trainer BIRD_KEEPER, BORIS, EVENT_BEAT_BIRD_KEEPER_BORIS, BirdKeeperBorisSeenText, BirdKeeperBorisBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BirdKeeperBorisAfterBattleText
	waitbutton
	closetext
	end

TrainerBirdKeeperBob:
	trainer BIRD_KEEPER, BOB, EVENT_BEAT_BIRD_KEEPER_BOB, BirdKeeperBobSeenText, BirdKeeperBobBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BirdKeeperBobAfterBattleText
	waitbutton
	closetext
	end

Route18Sign:
	jumptext Route18SignText

BirdKeeperBorisSeenText:
	text "#　さがし<NO>コツは"
	line "くさむら　みつけたら"
	cont "まず　はい<TTE>みる　ことだね！"
	done

BirdKeeperBorisBeatenText:
	text "ひー！"
	done

BirdKeeperBorisAfterBattleText:
	text "きみ　ぐらい　つよければ"
	line "たいせん　するのも　たのしいでしょ"
	done

BirdKeeperBobSeenText:
	text "サイクリング　ロードが"
	line "タマムシへ<NO>ちかみち　だよね！"
	done

BirdKeeperBobBeatenText:
	text "<⋯>　<⋯>ふう！"
	done

BirdKeeperBobAfterBattleText:
	text "じてんしゃ　も<TTE>ないから"
	line "ちかみち　つかえないんだけどね"
	done

Route18SignText:
	text "<KOKO_WA>１８<ROUTE>"
	line "タマムシシティ　<⋯>　セキチクシティ"
	done

Route18_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  6, ROUTE_17_ROUTE_18_GATE, 3
	warp_event  2,  7, ROUTE_17_ROUTE_18_GATE, 4

	def_coord_events

	def_bg_events
	bg_event  9,  5, BGEVENT_READ, Route18Sign

	def_object_events
	object_event  9, 12, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperBoris, -1
	object_event 13,  6, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperBob, -1
