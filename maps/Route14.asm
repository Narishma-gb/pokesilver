	object_const_def
	const ROUTE14_POKEFAN_M1
	const ROUTE14_YOUNGSTER
	const ROUTE14_POKEFAN_M2
	const ROUTE14_KIM

Route14_MapScripts:
	def_scene_scripts

	def_callbacks

Kim:
	faceplayer
	opentext
	trade NPC_TRADE_KIM
	waitbutton
	closetext
	end

TrainerPokefanmCarter:
	trainer POKEFANM, CARTER, EVENT_BEAT_POKEFANM_CARTER, PokefanmCarterSeenText, PokefanmCarterBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokefanmCarterAfterBattleText
	waitbutton
	closetext
	end

TrainerBirdKeeperRoy:
	trainer BIRD_KEEPER, ROY, EVENT_BEAT_BIRD_KEEPER_ROY, BirdKeeperRoySeenText, BirdKeeperRoyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BirdKeeperRoyAfterBattleText
	waitbutton
	closetext
	end

TrainerPokefanmTrevor:
	trainer POKEFANM, TREVOR, EVENT_BEAT_POKEFANM_TREVOR, PokefanmTrevorSeenText, PokefanmTrevorBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokefanmTrevorAfterBattleText
	waitbutton
	closetext
	end

PokefanmCarterSeenText:
	text "くろうして　てにいれた"
	line "じまん<NO>#と　しょうぶだ！"
	done

PokefanmCarterBeatenText:
	text "うわあ<⋯>！"
	done

PokefanmCarterAfterBattleText:
	text "ゼニガメ　ヒトカゲ　フシギダネ"
	line "こ<NO>くみあわせ<TTE>　けっこう"
	cont "バランス　いいと　おもうんだ！"
	done

BirdKeeperRoySeenText:
	text "だいすきな　とり#と"
	line "おおぞら　とぶの<GA>ボクのゆめ！"
	done

BirdKeeperRoyBeatenText:
	text "ばたばたー！"
	line "はばたいても　ボク<WA>とべない！"
	done

BirdKeeperRoyAfterBattleText:
	text "きみ<NO>#"
	line "ひでんワザ<NO>そらをとぶ　<TTE>"
	cont "もちろん　おぼえてるんでしょ"
	cont "うらやましいーなあ<⋯>"
	done

PokefanmTrevorSeenText:
	text "ジム　<TRAINER>　ぜんいんと"
	line "たたかったのかい？"
	done

PokefanmTrevorBeatenText:
	text "うひゃー！"
	line "つよい！！"
	done

PokefanmTrevorAfterBattleText:
	text "カントーバッジ<WO>も<TTE>ると"
	line "たいせんで　ゆうり<NI>なるよ！"
	done

Route14_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event 12, 14, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerPokefanmCarter, -1
	object_event 11, 27, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperRoy, -1
	object_event  5,  9, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerPokefanmTrevor, -1
	object_event  7,  5, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 4, Kim, -1
