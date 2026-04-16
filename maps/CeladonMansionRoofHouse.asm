	object_const_def
	const CELADONMANSIONROOFHOUSE_PHARMACIST

CeladonMansionRoofHouse_MapScripts:
	def_scene_scripts

	def_callbacks

CeladonMansionRoofHousePharmacistScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM03_CURSE
	iftrue .GotCurse
	writetext CeladonMansionRoofHousePharmacistIntroText
	promptbutton
	checktime NITE
	iftrue .Night
	writetext CeladonMansionRoofHousePharmacistNotNightText
	waitbutton
	closetext
	end

.Night:
	writetext CeladonMansionRoofHousePharmacistStoryText
	promptbutton
	verbosegiveitem TM_CURSE
	iffalse .NoRoom
	setevent EVENT_GOT_TM03_CURSE
.GotCurse:
	writetext CeladonMansionRoofHousePharmacistCurseText
	waitbutton
.NoRoom:
	closetext
	end

CeladonMansionRoofHousePharmacistIntroText:
	text "<WATASHI><GA>と<TTE>おきの"
	line "こわーい　はなし<WO>きかせよう<⋯>"
	done

CeladonMansionRoofHousePharmacistNotNightText:
	text "<⋯>　おっと！"
	line "あかるいとき<NI>はなしても"
	cont "ぜんぜん　おもしろく　ないね！"

	para "たいよう<GA>しずんだら　きてよ！"
	done

CeladonMansionRoofHousePharmacistStoryText:
	text "ある　おとこのこ<GA>しんぴんの"
	line "じてんしゃ<WO>か<TTE>もらった<⋯>"

	para "おとこのこ<WA>うれしくて　さっそく"
	line "じてんしゃで　あそびにいった<⋯>"

	para "きがついたら　ひ<GA>しずんでいた"
	line "あたり<WA>まっくら　やみのなか<⋯>"
	cont "うれしくて　きづかなかったのだ<⋯>"

	para "とつぜん　じてんしゃ<NO>スピードが"
	line "がくん　と　おそくなっ<TA!>"
	cont "ペダル<GA>おもくなっ<TA!>"
	cont "こぐの<WO>やめると　じてんしゃは"
	cont "ずるずると　うしろへ　さが<TTE>いく！"

	para "のろい<NO>じてんしゃ<GA>おとこのこを"
	line "じごくへ　つれていくかのように<⋯>"

	para "<⋯>　<⋯>　<⋯>"

	para "<⋯>　<⋯>　<⋯>"

	para "ぎゃーーーーーっ！！"

	para "そこ<WA>サイクリング　ロードの"
	line "のぼりざか　だっ<TA!>"

	para "<⋯>　<⋯>　<⋯>"
	line "おあと<GA>よろしい　ようで<⋯>"

	para "はなし<WO>きいてくれた　きみには"
	line "はい　これ　<TM>０３！"
	done

CeladonMansionRoofHousePharmacistCurseText:
	text "<TM>０３<WA>のろい！"
	line "あいて<NO>たいりょくを"
	cont "じわじわ　けず<TTE>いく"
	cont "おそろしい　わざ　だよ！"
	done

CeladonMansionRoofHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CELADON_MANSION_ROOF, 3
	warp_event  3,  7, CELADON_MANSION_ROOF, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  2, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonMansionRoofHousePharmacistScript, -1
