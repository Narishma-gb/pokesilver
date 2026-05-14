	object_const_def
	const ROUTE8_BIKER1
	const ROUTE8_BIKER2
	const ROUTE8_BIKER3
	const ROUTE8_SUPER_NERD1
	const ROUTE8_SUPER_NERD2
	const ROUTE8_FRUIT_TREE

Route8_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerBikerDwayne:
	trainer BIKER, DWAYNE, EVENT_BEAT_BIKER_DWAYNE, BikerDwayneSeenText, BikerDwayneBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BikerDwayneAfterBattleText
	waitbutton
	closetext
	end

TrainerBikerHarris:
	trainer BIKER, HARRIS, EVENT_BEAT_BIKER_HARRIS, BikerHarrisSeenText, BikerHarrisBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BikerHarrisAfterBattleText
	waitbutton
	closetext
	end

TrainerBikerZeke:
	trainer BIKER, ZEKE, EVENT_BEAT_BIKER_ZEKE, BikerZekeSeenText, BikerZekeBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BikerZekeAfterBattleText
	waitbutton
	closetext
	end

TrainerSupernerdSam:
	trainer SUPER_NERD, SAM, EVENT_BEAT_SUPER_NERD_SAM, SupernerdSamSeenText, SupernerdSamBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SupernerdSamAfterBattleText
	waitbutton
	closetext
	end

TrainerSupernerdTom:
	trainer SUPER_NERD, TOM, EVENT_BEAT_SUPER_NERD_TOM, SupernerdTomSeenText, SupernerdTomBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SupernerdTomAfterBattleText
	waitbutton
	closetext
	end

Route8LockedDoor:
	jumptext Route8LockedDoorText

Route8UndergroundPathSign:
	jumptext Route8UndergroundPathSignText

Route8FruitTree:
	fruittree FRUITTREE_ROUTE_8

BikerDwayneSeenText:
	text "オレら　<TRAINER>　グループ"
	line "「カントー　#　れんごう」！"
	cont "おまえ　なんか　こうだ！"
	done

BikerDwayneBeatenText:
	text "ご　ごめんなさーい！"
	done

BikerDwayneAfterBattleText:
	text "「カントー　#　れんごう」は"
	line "えいえん<NI>ふめつだっ！"
	done

BikerHarrisSeenText:
	text "オレたち<NO>なわばり"
	line "ちかつうろ<WO>へいさ　しやがっ<TA!>"
	cont "むかつくーっ！"
	done

BikerHarrisBeatenText:
	text "ゆ　ゆるして　くださーい！"
	done

BikerHarrisAfterBattleText:
	text "ジョウト<NO>ヤツに"
	line "まけて　しまった<⋯>！"
	done

BikerZekeSeenText:
	text "「カントー　#　れんごう」"
	line "ヨロシクっ！"
	done

BikerZekeBeatenText:
	text "す　すみませーん！"
	done

BikerZekeAfterBattleText:
	text "これから<WA>あまり"
	line "ひと<NI>めいわくを"
	cont "かけない　よう<NI>します<⋯>ハイ"
	done

SupernerdSamSeenText:
	text "リニア<NO>メカニズム　<TTE>"
	line "どう　な<TTE>るのかなー？"
	done

SupernerdSamBeatenText:
	text "リニア<WO>ひとめ　だけでも"
	line "みたかった　<⋯>　<⋯>"
	done

SupernerdSamAfterBattleText:
	text "じしゃく<NO>ちから<TTE>"
	line "すげー！"
	done

SupernerdTomSeenText:
	text "ボクたち<NO>くらしに"
	line "でんき<WA>ひつよう"

	para "はつでんしょ<GA>がんば<TTE>"
	line "でんき<WO>つく<TTE>います"
	done

SupernerdTomBeatenText:
	text "でんき<WA>たいせつに<⋯>！"
	done

SupernerdTomAfterBattleText:
	text "シオン　タウン<NO>きた<NI>ある"
	line "はつでんしょで"
	cont "リニアで　つかう　でんきを"
	cont "つく<TTE>るんだ<TTE>"
	done

Route8LockedDoorText:
	text "カギ<GA>かか<TTE>いる！"
	line "<⋯>あけられない！"
	done

Route8UndergroundPathSignText:
	text "<⋯>　チラシ<GA>はがされてる"
	line "よめない　<⋯>！"
	done

Route8_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  4, ROUTE_8_SAFFRON_GATE, 3
	warp_event  4,  5, ROUTE_8_SAFFRON_GATE, 4

	def_coord_events

	def_bg_events
	bg_event 11,  7, BGEVENT_READ, Route8UndergroundPathSign
	bg_event 10,  5, BGEVENT_READ, Route8LockedDoor

	def_object_events
	object_event 10,  8, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 5, TrainerBikerDwayne, -1
	object_event 10,  9, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 5, TrainerBikerHarris, -1
	object_event 10, 10, SPRITE_BIKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 5, TrainerBikerZeke, -1
	object_event 20,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 4, TrainerSupernerdSam, -1
	object_event 27,  9, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerSupernerdTom, -1
	object_event 33,  5, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route8FruitTree, -1
