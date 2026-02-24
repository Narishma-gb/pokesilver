	object_const_def
	const GOLDENRODFLOWERSHOP_TEACHER
	const GOLDENRODFLOWERSHOP_FLORIA

GoldenrodFlowerShop_MapScripts:
	def_scene_scripts

	def_callbacks

FlowerShopTeacherScript:
	checkevent EVENT_GOT_SQUIRTBOTTLE
	iftrue .Lalala
	checkflag ENGINE_PLAINBADGE
	iffalse .Lalala
	faceplayer
	opentext
	writetext GoldenrodFlowerShopTeacherBetterThanWhitneyText
	promptbutton
	verbosegiveitem SQUIRTBOTTLE
	setevent EVENT_GOT_SQUIRTBOTTLE
	closetext

.Lalala:
	turnobject GOLDENRODFLOWERSHOP_TEACHER, LEFT
	opentext
	writetext GoldenrodFlowerShopTeacherLalalaHavePlentyOfWaterText
	waitbutton
	closetext
	end

FlowerShopFloriaScript:
	faceplayer
	opentext
	checkflag ENGINE_PLAINBADGE
	iffalse .NoPlainBadge
	writetext GoldenrodFlowerShopFloriaJumpsInSurpriseText
	waitbutton
	closetext
	end

.NoPlainBadge:
	writetext GoldenrodFlowerShopFloriaMustBeAMonText
	waitbutton
	closetext
	end

FlowerShopShelf1: ; unreferenced
	jumpstd PictureBookshelfScript

FlowerShopShelf2: ; unreferenced
	jumpstd MagazineBookshelfScript

FlowerShopRadio: ; unreferenced
	jumpstd Radio2Script

GoldenrodFlowerShopTeacherBetterThanWhitneyText:
	text "あら？　あなた"
	line "アカネちゃんより　つよいんだ"

	para "うごく　き　<TTE>　し<TTE>る？"

	para "ゼニガメじょうろで　みず<WO>かけると"
	line "おそいかか<TTE>　くるんだけど"
	cont "そんな<NI>バッジ　も<TTE>るなら"
	cont "だいじょうぶ　そうね！"
	done

GoldenrodFlowerShopTeacherLalalaHavePlentyOfWaterText:
	text "ラララ　ララララ"
	line "たーっぷり　おみず<WO>あげるわよ"
	done

GoldenrodFlowerShopFloriaMustBeAMonText:
	text "３６<ROUTE>の"
	line "うごく　き<NI>みず<WO>かけてあげたら"
	cont "おどろいて　とびあがったの"

	para "きっと　#だと　おもうけど"
	line "ジムリーダー<NO>アカネちゃん　くらい"
	cont "つよくないと　かてないわよ<⋯>"
	done

GoldenrodFlowerShopFloriaJumpsInSurpriseText:
	text "うごく　き　<TTE>　し<TTE>る？"

	para "おみず<WO>かけてあげたら"
	line "おどろいて　とびあがるのよ！"
	done

GoldenrodFlowerShop_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 6
	warp_event  3,  7, GOLDENROD_CITY, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  4, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FlowerShopTeacherScript, -1
	object_event  5,  6, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, FlowerShopFloriaScript, -1
