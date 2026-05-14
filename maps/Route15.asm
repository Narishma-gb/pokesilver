	object_const_def
	const ROUTE15_YOUNGSTER1
	const ROUTE15_YOUNGSTER2
	const ROUTE15_YOUNGSTER3
	const ROUTE15_YOUNGSTER4
	const ROUTE15_TEACHER1
	const ROUTE15_TEACHER2
	const ROUTE15_POKE_BALL

Route15_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerTeacherColette:
	trainer TEACHER, COLETTE, EVENT_BEAT_TEACHER_COLETTE, TeacherColetteSeenText, TeacherColetteBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext TeacherColetteAfterBattleText
	waitbutton
	closetext
	end

TrainerTeacherHillary:
	trainer TEACHER, HILLARY, EVENT_BEAT_TEACHER_HILLARY, TeacherHillarySeenText, TeacherHillaryBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext TeacherHillaryAfterBattleText
	waitbutton
	closetext
	end

TrainerSchoolboyKipp:
	trainer SCHOOLBOY, KIPP, EVENT_BEAT_SCHOOLBOY_KIP, SchoolboyKippSeenText, SchoolboyKippBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SchoolboyKippAfterBattleText
	waitbutton
	closetext
	end

TrainerSchoolboyTommy:
	trainer SCHOOLBOY, TOMMY, EVENT_BEAT_SCHOOLBOY_TOMMY, SchoolboyTommySeenText, SchoolboyTommyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SchoolboyTommyAfterBattleText
	waitbutton
	closetext
	end

TrainerSchoolboyJohnny:
	trainer SCHOOLBOY, JOHNNY, EVENT_BEAT_SCHOOLBOY_JOHNNY, SchoolboyJohnnySeenText, SchoolboyJohnnyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SchoolboyJohnnyAfterBattleText
	waitbutton
	closetext
	end

TrainerSchoolboyBilly:
	trainer SCHOOLBOY, BILLY, EVENT_BEAT_SCHOOLBOY_BILLY, SchoolboyBillySeenText, SchoolboyBillyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SchoolboyBillyAfterBattleText
	waitbutton
	closetext
	end

Route15Sign:
	jumptext Route15SignText

Route15PPUp:
	itemball PP_UP

TeacherColetteSeenText:
	text "わすれもの<WA>ないかしら？"
	done

TeacherColetteBeatenText:
	text "きゃーっ！"
	done

TeacherColetteAfterBattleText:
	text "せんせいも　こどものころ"
	line "よく　わすれも<NO>しちゃったわ"
	done

TeacherHillarySeenText:
	text "おてんき<NO>いい　ひは"
	line "きょうしつで　べんきょう　するより"
	cont "こうていで　うんどう　したいわね！"
	done

TeacherHillaryBeatenText:
	text "まけちゃった<⋯>"
	done

TeacherHillaryAfterBattleText:
	text "べんきょう<WA>だいじ　だけど"
	line "うんどうも　たいせつ　なのよ！"
	done

SchoolboyKippSeenText:
	text "ちょっと　ま<TTE>"
	line "おかあさん<NI>でんわ　するから"
	done

SchoolboyKippBeatenText:
	text "ごめんね　おかあさん！"
	line "ボク　まけちゃっ<TA!>"
	done

SchoolboyKippAfterBattleText:
	text "すごく　しんぱいするからね"
	line "よく　おかあさん<NI>でんわ　するよ"
	done

SchoolboyTommySeenText:
	text "たいせん　しようよ！"
	line "ぼく　まけないよ！"
	done

SchoolboyTommyBeatenText:
	text "じゅく<NO>しゅくだい"
	line "わすれてたー！"
	done

SchoolboyTommyAfterBattleText:
	text "ハウ　ドゥー　ユー　ドゥー！"
	line "きのう　ならった　ばっかり！"
	done

SchoolboyJohnnySeenText:
	text "シオン　タウン<NO>ラジオとうに"
	line "しゃかいか　けんがく<NI>いくんだ！"
	done

SchoolboyJohnnyBeatenText:
	text "すごく　つよいなあ！"
	done

SchoolboyJohnnyAfterBattleText:
	text "あるく<NO>つかれちゃった<⋯>"
	line "やすみたいよ"
	done

SchoolboyBillySeenText:
	text "ボク<NO>とくい　かもくは"
	line "たいいく　だよ！"
	done

SchoolboyBillyBeatenText:
	text "やべーっ！"
	line "まけたーっ！"
	done

SchoolboyBillyAfterBattleText:
	text "じゅぎょう<NI>#<GA>あったら"
	line "ボク<GA>いちばん　なのに！"
	done

Route15SignText:
	text "<KOKO_WA>１５<ROUTE>"
	line "セキチクシティ　<⋯>　シオンタウン"
	done

Route15_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  4, ROUTE_15_FUCHSIA_GATE, 3
	warp_event  2,  5, ROUTE_15_FUCHSIA_GATE, 4

	def_coord_events

	def_bg_events
	bg_event 19,  9, BGEVENT_READ, Route15Sign

	def_object_events
	object_event 11, 10, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerSchoolboyKipp, -1
	object_event 11, 11, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerSchoolboyTommy, -1
	object_event 33, 10, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSchoolboyJohnny, -1
	object_event 27, 10, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSchoolboyBilly, -1
	object_event 30, 12, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerTeacherColette, -1
	object_event 16, 10, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerTeacherHillary, -1
	object_event 12,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route15PPUp, EVENT_ROUTE_15_PP_UP
