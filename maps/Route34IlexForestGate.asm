	object_const_def
	const ROUTE34ILEXFORESTGATE_TEACHER
	const ROUTE34ILEXFORESTGATE_BUTTERFREE
	const ROUTE34ILEXFORESTGATE_LASS

Route34IlexForestGate_MapScripts:
	def_scene_scripts

	def_callbacks

Route34IlexForestGateTeacherScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM12_SWEET_SCENT
	iftrue .GotSweetScent
	writetext Route34IlexForestGateTeacherText
	promptbutton
	verbosegiveitem TM_SWEET_SCENT
	iffalse .NoRoom
	setevent EVENT_GOT_TM12_SWEET_SCENT
.GotSweetScent:
	writetext Route34IlexForestGateTeacher_GotSweetScent
	waitbutton
.NoRoom:
	closetext
	end

Route34IlexForestGateButterfreeScript:
	opentext
	writetext Route34IlexForestGateButterfreeText
	cry BUTTERFREE
	waitbutton
	closetext
	end

Route34IlexForestGateLassScript:
	jumptextfaceplayer Route34IlexForestGateLassText

Route34IlexForestGateTeacherText:
	text "あん　あなた"
	line "#ずかん　つく<TTE>るの？"

	para "#<GA>でてこないと　たいへんね"
	line "よかったら　こ<NO><TM>"
	cont "つか<TTE>みたら　どうかしらん？"
	done

Route34IlexForestGateTeacher_GotSweetScent:
	text "なかみ<WA>あまいかおり"

	para "#<GA>でてきそうな"
	line "ばしょで　つかうと<⋯>"

	para "あまいかおり<NI>さそわれて"
	line "#<GA>あらわれるんだからあ"
	done

Route34IlexForestGateButterfreeText:
	text "バタフリー『フイイイッ！"
	done

Route34IlexForestGateLassText:
	text "あなた　もりのかみさまの"
	line "ほこら<NI>おまいりした？"

	para "もりのかみさま<WA>じかん<WO>こえて"
	line "もり<WO>みまも<TTE>　くれてるのよ"
	cont "きっと　くさ#　なのね"
	done

Route34IlexForestGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  0, ROUTE_34, 1
	warp_event  5,  0, ROUTE_34, 2
	warp_event  4,  7, ILEX_FOREST, 1
	warp_event  5,  7, ILEX_FOREST, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route34IlexForestGateTeacherScript, -1
	object_event  9,  4, SPRITE_BUTTERFREE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Route34IlexForestGateButterfreeScript, -1
	object_event  3,  4, SPRITE_LASS, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route34IlexForestGateLassScript, -1
