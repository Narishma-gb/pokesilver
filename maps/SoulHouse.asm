	object_const_def
	const SOULHOUSE_MRFUJI
	const SOULHOUSE_TEACHER
	const SOULHOUSE_LASS
	const SOULHOUSE_GRANNY

SoulHouse_MapScripts:
	def_scene_scripts

	def_callbacks

MrFuji:
	jumptextfaceplayer MrFujiText

SoulHouseTeacherScript:
	jumptextfaceplayer SoulHouseTeacherText

SoulHouseLassScript:
	jumptextfaceplayer SoulHouseLassText

SoulHouseGrannyScript:
	jumptextfaceplayer SoulHouseGrannyText

MrFujiText:
	text "フジ『やあ　よく　きたね"

	para "ふむふむ<⋯>　きみ<WA>#を"
	line "だいじ<NI>そだてている　ようじゃね"

	para "<KOKO_WA>#<WO>あいする　ひとが"
	line "あつまる　ばしょ"

	para "どうか　きみも　いの<TTE>　くれんか"
	line "#たち<WA>よろこぶじゃろう"
	done

SoulHouseTeacherText:
	text "#<NO>おはかは"
	line "これだけじゃ　ないみたいよ"

	para "フジろうじんしか　はいれない"
	line "へや<NI>たくさん　あるらしいわ"
	done

SoulHouseLassText:
	text "おかあさんと　いっしょに"
	line "おはかまいり<NI>きたの<⋯>"
	done

SoulHouseGrannyText:
	text "いっしょ<NI>くらしてた"
	line "#は"
	cont "まご　みたいな　もんじゃ<⋯>"
	done

SoulHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  7, LAVENDER_TOWN, 6
	warp_event  5,  7, LAVENDER_TOWN, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, MrFuji, -1
	object_event  7,  3, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SoulHouseTeacherScript, -1
	object_event  2,  5, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SoulHouseLassScript, -1
	object_event  1,  3, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SoulHouseGrannyScript, -1
