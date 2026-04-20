	object_const_def
	const TINTOWER1F_SAGE

TinTower1F_MapScripts:
	def_scene_scripts

	def_callbacks

TinTowerSageScript:
	jumptextfaceplayer TinTowerSageText

TinTowerSageText:
	text "<WATASHI><WA>ここ<NI>まいおりるという"
	line "でんせつ<NO>#の"
	cont "ひみつ<WO>さぐ<TTE>いるのです"

	para "にしがわ<NO>とう<GA>やけてから"
	line "ここにいた　#は"
	cont "ずっと　そら<WO>とんでいるそうです"

	para "そこで　かんがえました"
	line "とんでいる　#と"
	cont "おなじ　モノ<WO>も<TTE>いれば"
	cont "さそわれて　や<TTE>くる　はず！"

	para "そ<NO>おなじ　モノと<WA>おそらく<⋯>"

	para "にじいろのはね！"

	para "だ<GA>そんなもの"
	line "どこ<NI>あるんでしょう？"
	done

TinTower1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 15, ECRUTEAK_CITY, 12
	warp_event 10, 15, ECRUTEAK_CITY, 12
	warp_event 10,  2, TIN_TOWER_2F, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event 10,  2, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TinTowerSageScript, EVENT_TEAM_ROCKET_DISBANDED
