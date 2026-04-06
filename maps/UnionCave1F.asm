	object_const_def
	const UNIONCAVE1F_POKEFAN_M1
	const UNIONCAVE1F_SUPER_NERD
	const UNIONCAVE1F_POKEFAN_M2
	const UNIONCAVE1F_FISHER1
	const UNIONCAVE1F_FISHER2
	const UNIONCAVE1F_POKE_BALL1
	const UNIONCAVE1F_POKE_BALL2
	const UNIONCAVE1F_POKE_BALL3
	const UNIONCAVE1F_POKE_BALL4

UnionCave1F_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerPokemaniacLarry:
	trainer POKEMANIAC, LARRY, EVENT_BEAT_POKEMANIAC_LARRY, PokemaniacLarrySeenText, PokemaniacLarryBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokemaniacLarryAfterBattleText
	waitbutton
	closetext
	end

TrainerHikerRussell:
	trainer HIKER, RUSSELL, EVENT_BEAT_HIKER_RUSSELL, HikerRussellSeenText, HikerRussellBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext HikerRussellAfterBattleText
	waitbutton
	closetext
	end

TrainerHikerDaniel:
	trainer HIKER, DANIEL, EVENT_BEAT_HIKER_DANIEL, HikerDanielSeenText, HikerDanielBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext HikerDanielAfterBattleText
	waitbutton
	closetext
	end

TrainerFirebreatherBill:
	trainer FIREBREATHER, BILL, EVENT_BEAT_FIREBREATHER_BILL, FirebreatherBillSeenText, FirebreatherBillBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FirebreatherBillAfterBattleText
	waitbutton
	closetext
	end

TrainerFirebreatherRay:
	trainer FIREBREATHER, RAY, EVENT_BEAT_FIREBREATHER_RAY, FirebreatherRaySeenText, FirebreatherRayBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FirebreatherRayAfterBattleText
	waitbutton
	closetext
	end

UnionCave1FGreatBall:
	itemball GREAT_BALL

UnionCave1FPotion:
	itemball POTION

UnionCave1FXAttack:
	itemball X_ATTACK

UnionCave1FAwakening:
	itemball AWAKENING

UnionCave1FUnusedSign: ; unreferenced
	jumptext UnionCave1FUnusedSignText

HikerRussellSeenText:
	text "ヒワダタウン<NI>むかうのか？"
	line "ここ<WO>ぬけられるか"
	cont "わし<NO>#で　ためしてやろう！"
	done

HikerRussellBeatenText:
	text "ありゃりゃ<⋯>"
	done

HikerRussellAfterBattleText:
	text "おーしっ！　きめたっ！"

	para "わし<NO>#<GA>つよくなるまで"
	line "ここから　でないっ！"
	done

PokemaniacLarrySeenText:
	text "#　さがして　にしひがし"
	line "きみも　#　さがしにきたの？"

	para "じゃあ　ぼく<NO>コレクションの"
	line "きょうそうあいて　だな！"
	done

PokemaniacLarryBeatenText:
	text "ああ　ぼく<NO>#ちゃん<⋯>"
	done

PokemaniacLarryAfterBattleText:
	text "きんようび<NI>なるたびに"
	line "どうくつ<NO>おくから"
	cont "#<NO>なきごえ<GA>きこえるんだ"
	done

HikerDanielSeenText:
	text "おっと　びっくり　どっきり"
	line "こんなところ<NI>ひと<GA>いるなんて！"
	done

HikerDanielBeatenText:
	text "おっと　びっくり　どっきり"
	line "こんな<NI>つよいひと<GA>いるなんて！"
	done

HikerDanielAfterBattleText:
	text "だまされたのか　うっかり"
	line "ヤドンのシッポ　か<TTE>しまったよ"
	cont "なーんか　ヤドン　かわいそうだ"
	done

FirebreatherBillSeenText:
	text "ズバット<NO>ちょうおんぱで"
	line "こんらん　させられてばかり"
	cont "なんだか　あたま<NI>きたぞ！"
	done

FirebreatherBillBeatenText:
	text "も　え　つ　き　た"
	done

FirebreatherBillAfterBattleText:
	text "しゅうまつ<NI>なると"
	line "どうくつ<NO>おくから"
	cont "ふしぎな　なきごえ<GA>きこえるぞ"
	done

FirebreatherRaySeenText:
	text "あかるければ　どうくつ　こわくない"
	line "つよければ　#　こわくない"
	done

FirebreatherRayBeatenText:
	text "ふらーっしゅ！！"
	done

FirebreatherRayAfterBattleText:
	text "おれ<NO>#が"
	line "ほのおで　てらしてるから"
	cont "こ<NO>どうくつ<WA>あかるいんだぞ！"
	done

UnionCave1FUnusedSignText:
	text "つながり<NO>どうくつ"
	done

UnionCave1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5, 19, UNION_CAVE_B1F, 3
	warp_event  3, 33, UNION_CAVE_B1F, 4
	warp_event 17, 31, ROUTE_33, 1
	warp_event 17,  3, ROUTE_32, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  4, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 1, TrainerHikerDaniel, -1
	object_event  4, 21, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerPokemaniacLarry, -1
	object_event 15,  8, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerHikerRussell, -1
	object_event 16, 31, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerFirebreatherRay, -1
	object_event 15, 15, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerFirebreatherBill, -1
	object_event 17, 21, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, UnionCave1FGreatBall, EVENT_UNION_CAVE_1F_GREAT_BALL
	object_event  4,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, UnionCave1FPotion, EVENT_UNION_CAVE_1F_POTION
	object_event  4, 17, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, UnionCave1FXAttack, EVENT_UNION_CAVE_1F_X_ATTACK
	object_event 12, 33, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, UnionCave1FAwakening, EVENT_UNION_CAVE_1F_AWAKENING
