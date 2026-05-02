	object_const_def
	const OAKSLAB_OAK
	const OAKSLAB_SCIENTIST1
	const OAKSLAB_SCIENTIST2
	const OAKSLAB_SCIENTIST3

OaksLab_MapScripts:
	def_scene_scripts

	def_callbacks

OaksLabNoopScene: ; unreferenced
	end

Oak:
	faceplayer
	opentext
	checkevent EVENT_OPENED_MT_SILVER
	iftrue .CheckPokedex
	checkevent EVENT_TALKED_TO_OAK_IN_KANTO
	iftrue .CheckBadges
	writetext OakWelcomeKantoText
	promptbutton
	setevent EVENT_TALKED_TO_OAK_IN_KANTO
.CheckBadges:
	readvar VAR_BADGES
	ifequal NUM_BADGES, .OpenMtSilver
	ifequal NUM_JOHTO_BADGES, .Complain
	sjump .AhGood

.CheckPokedex:
	writetext OakLabDexCheckText
	waitbutton
	special ProfOaksPCBoot
	writetext OakLabGoodbyeText
	waitbutton
	closetext
	end

.OpenMtSilver:
	writetext OakOpenMtSilverText
	promptbutton
	setevent EVENT_OPENED_MT_SILVER
	sjump .CheckPokedex

.Complain:
	writetext OakNoKantoBadgesText
	promptbutton
	sjump .CheckPokedex

.AhGood:
	writetext OakYesKantoBadgesText
	promptbutton
	sjump .CheckPokedex

OaksAssistant1Script:
	jumptextfaceplayer OaksAssistant1Text

OaksAssistant2Script:
	jumptextfaceplayer OaksAssistant2Text

OaksAssistant3Script:
	jumptextfaceplayer OaksAssistant3Text

OaksLabBookshelf:
	jumpstd DifficultBookshelfScript

OaksLabPoster1:
	jumptext OaksLabPoster1Text

OaksLabPoster2:
	jumptext OaksLabPoster2Text

OaksLabTrashcan:
	jumptext OaksLabTrashcanText

OaksLabPC:
	jumptext OaksLabPCText

OakWelcomeKantoText:
	text "オーキド『おお　<PLAYER>くん！"
	line "わざわざ　よく　きたね！"

	para "どうじゃ？"
	line "カントー<NO><TRAINER>たちも"
	cont "てごわい　だろう！"
	done

OakLabDexCheckText:
	text "どれどれ　#ずかんは"
	line "どんな　かんじかな？"

	para "ふむふむ<⋯>"
	done

OakLabGoodbyeText:
	text "ちかくまで　きたら"
	line "また　かお<WO>みせて　くれ"
	done

OakOpenMtSilverText:
	text "オーキド『おお！　すばらしい！"
	line "カントー　バッジも　あつめたのか！"
	cont "わし<NO>みこんだ　とおりじゃ！"

	para "そうじゃ！　<PLAYER>くんが"
	line "シロガネやま<NI>はいれるよう"
	cont "てはい　しておこう！"

	para "シロガネやま<WA>やせい　#が"
	line "たくさんいる　おおきな　やまじゃ！"

	para "ふつう<NO><TRAINER><WA>キケンだから"
	line "はいれない　よう<NI>しているが"
	cont "<PLAYER>くんなら　だいじょうぶ！"

	para "セキエイこうげん<NI>い<TTE>みなさい"
	line "そこから　シロガネやまへ　いけるよ"
	done

OakNoKantoBadgesText:
	text "オーキド『おや？"
	line "カントーのバッジを"
	cont "あつめていない　みたいじゃな"

	para "カントー<NO>ジム　リーダーたちも"
	line "ジョウト<NI>まけず　おとらず"
	cont "きょうてき　ぞろい！"
	cont "ちょうせん　してみて<WA>どうかな？"
	done

OakYesKantoBadgesText:
	text "オーキド『カントー　バッジを"
	line "あつめている　みたいじゃな！"

	para "たいへん　だろうが"
	line "けいけん<WA><PLAYER>くんの"
	cont "ちからと　なる！"

	para "すべて　あつめ　おえたら"
	line "また　あそび<NI>きなさい"
	cont "わしから　プレゼント<WO>あげよう！"

	para "<PLAYER>くん"
	line "がんばるんじゃ！"
	done

OaksAssistant1Text:
	text "はかせ<NO>#こうざ"
	line "カントーで<WA>ほうそう　してません"
	cont "ききたいの<NI>ざんねんです"
	done

OaksAssistant2Text:
	text "<PLAYER>くんが"
	line "ずかん<WO>つく<TTE>　くれてるので"
	cont "はかせ<NO>けんきゅうが"
	cont "はかど<TTE>ますよ！"
	done

OaksAssistant3Text:
	text "<⋯>ここだけ<NO>はなし　ですよ！"

	para "オーキドはかせ<NO>#こうざは"
	line "なまほうそう　じゃ　ないのです！"
	done

OaksLabPoster1Text:
	text "スタート　ボタン<WO>プシュ！"
	line "おすと　メニュー<GA>ひらくなり"
	done

OaksLabPoster2Text:
	text "セーブするに<WA>#　レポート"
	line "こまめ<NI>かくと　いいなり"
	done

OaksLabTrashcanText:
	text "なか<WA>からっぽ<⋯>"
	done

OaksLabPCText:
	text "<PC><WO>みると"
	line "なんと　でんしメール<GA>きてい<TA!>"

	para "<⋯>　<⋯>　<⋯>"

	para "オーキドはかせ<NO>けんきゅうは"
	line "すすんで　いますか？"

	para "<WATASHI><NO>ほうは<⋯>"
	line "がんば<TTE>いる　さいちゅう　です！"

	para "ところで　<PLAYER>くんが"
	line "がんば<TTE>いると　うわさ<NI>きいて"
	cont "とても　うれしいです！"

	para "<⋯>　ワカバタウン　ウツギ　より"
	line "<⋯>　<⋯>　<⋯>"
	done

OaksLab_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 11, PALLET_TOWN, 3
	warp_event  5, 11, PALLET_TOWN, 3

	def_coord_events

	def_bg_events
	bg_event  6,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  7,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  8,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  9,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  0,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  1,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  2,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  3,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  6,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  7,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  8,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  9,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  4,  0, BGEVENT_READ, OaksLabPoster1
	bg_event  5,  0, BGEVENT_READ, OaksLabPoster2
	bg_event  9,  3, BGEVENT_READ, OaksLabTrashcan
	bg_event  0,  1, BGEVENT_READ, OaksLabPC

	def_object_events
	object_event  4,  2, SPRITE_OAK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Oak, -1
	object_event  1,  8, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OaksAssistant1Script, -1
	object_event  8,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OaksAssistant2Script, -1
	object_event  1,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OaksAssistant3Script, -1
