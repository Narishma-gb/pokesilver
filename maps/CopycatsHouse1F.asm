	object_const_def
	const COPYCATSHOUSE1F_POKEFAN_M
	const COPYCATSHOUSE1F_POKEFAN_F
	const COPYCATSHOUSE1F_CLEFAIRY

CopycatsHouse1F_MapScripts:
	def_scene_scripts

	def_callbacks

CopycatsHouse1FPokefanMScript:
	jumptextfaceplayer CopycatsHouse1FPokefanMText

CopycatsHouse1FPokefanFScript:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext CopycatsHouse1FPokefanFText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext CopycatsHouse1FPokefanFText_ReturnedMachinePart
	waitbutton
	closetext
	end

CopycatsHouse1FBlisseyScript:
	opentext
	writetext CopycatsHouse1FBlisseyText
	cry BLISSEY
	waitbutton
	closetext
	end

CopycatsHouse1FPokefanMText:
	text "<⋯>　こまった　こと<NI>むすめは"
	line "ひと<NO>まね<GA>すきでな！"

	para "しょっちゅう　ひと<WO>からかう　ので"
	line "きんじょ　じゃ"
	cont "モノマネ　むすめと　よばれとる！"
	done

CopycatsHouse1FPokefanFText:
	text "たく<NO>むすめは"
	line "ほんと　わがまま<NI>そだ<TTE><⋯>"
	cont "おともだちも　あまり　おりませんの"
	done

CopycatsHouse1FPokefanFText_ReturnedMachinePart:
	text "３ねんまえ　おとこのこ<NI>もらった"
	line "ピッピにんぎょう<WO>なくしてから"

	para "ますます　ものまねに"
	line "みがき<GA>かか<TTE>　しま<TTE><⋯>"
	done

CopycatsHouse1FBlisseyText:
	text "ハピナス『はっぴーっ！"
	done

CopycatsHouse1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, SAFFRON_CITY, 8
	warp_event  3,  7, SAFFRON_CITY, 8
	warp_event  2,  0, COPYCATS_HOUSE_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CopycatsHouse1FPokefanMScript, -1
	object_event  5,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CopycatsHouse1FPokefanFScript, -1
	object_event  6,  6, SPRITE_CLEFAIRY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CopycatsHouse1FBlisseyScript, -1
