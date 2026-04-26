	object_const_def
	const LAVRADIOTOWER1F_RECEPTIONIST
	const LAVRADIOTOWER1F_OFFICER
	const LAVRADIOTOWER1F_SUPER_NERD1
	const LAVRADIOTOWER1F_GENTLEMAN
	const LAVRADIOTOWER1F_SUPER_NERD2

LavRadioTower1F_MapScripts:
	def_scene_scripts

	def_callbacks

LavRadioTower1FReceptionistScript:
	jumptextfaceplayer LavRadioTower1FReceptionistText

LavRadioTower1FOfficerScript:
	jumptextfaceplayer LavRadioTower1FOfficerText

LavRadioTower1FSuperNerd1Script:
	jumptextfaceplayer LavRadioTower1FSuperNerd1Text

LavRadioTower1FGentlemanScript:
	faceplayer
	opentext
	checkflag ENGINE_EXPN_CARD
	iftrue .GotExpnCard
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext LavRadioTower1FGentlemanText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext LavRadioTower1FGentlemanText_ReturnedMachinePart
	promptbutton
	getstring STRING_BUFFER_4, .expncardname
	scall .receiveitem
	setflag ENGINE_EXPN_CARD
.GotExpnCard:
	writetext LavRadioTower1FGentlemanText_GotExpnCard
	waitbutton
	closetext
	end

.receiveitem:
	jumpstd ReceiveItemScript
	end

.expncardname
	db "かくちょうカード@"

LavRadioTower1FSuperNerd2Script:
	faceplayer
	opentext
	checkflag ENGINE_EXPN_CARD
	iftrue .GotExpnCard
	writetext LavRadioTower1FSuperNerd2Text
	waitbutton
	closetext
	end

.GotExpnCard:
	writetext LavRadioTower1FSuperNerd2Text_GotExpnCard
	waitbutton
	closetext
	end

LavRadioTower1FDirectory:
	jumptext LavRadioTower1FDirectoryText

LavRadioTower1FPokeFluteSign:
	jumptext LavRadioTower1FPokeFluteSignText

LavRadioTower1FReferenceLibrary: ; unreferenced
	jumptext LavRadioTower1FReferenceLibraryText

LavRadioTower1FReceptionistText:
	text "ようこそ！"

	para "１かい　フロアは"
	line "けんがく　じゆう　です！"
	done

LavRadioTower1FOfficerText:
	text "けんがく<WA>１かい　フロア　だけです"

	para "ジョウト<NO>ラジオとうが"
	line "あくにん<NI>せんりょう　されたので"
	cont "けいび<WO>きょうか　したのです！"
	done

LavRadioTower1FSuperNerd1Text:
	text "たくさん<NO>ひとが"
	line "ラジオとうで　はたらいてるんだ<TTE>！"

	para "おもしろい　ばんぐみ<WO>つくるために"
	line "みんな　がんば<TTE>るんだね！"
	done

LavRadioTower1FGentlemanText:
	text "ああ　エライこっちゃー！"

	para "はつでんしょ<GA>うごかないと"
	line "ラジオほうそうも　できなくなる！"

	para "せっかく　ラジオ<WO>はじめたのに"
	line "ほうそう　できなく　なったら"
	cont "ワシゃあ　はめつ　じゃあー！"
	done

LavRadioTower1FGentlemanText_ReturnedMachinePart:
	text "おお！"
	line "キミ<GA>はつでんしょ　じけんを"
	cont "かいけつした　<PLAYER>くんか！"

	para "キミ<NO>おかげで　ワシゃあ"
	line "クビ<NI>ならず<NI>すんだわい！"
	cont "ほんと<NI>たすかったよっ！"

	para "ワシ<NO>きもちだ！"
	line "これ<WO>うけと<TTE>　くれたまえ！"
	done

LavRadioTower1FGentlemanText_GotExpnCard:
	text "それ<GA>あれば"
	line "あたらしい　ラジオばんぐみを"
	cont "きくこと<GA>できるよう<NI>なるぞ！"
	cont "がっはっはっはっはっはっ！"
	done

LavRadioTower1FSuperNerd2Text:
	text "はあーい！"
	line "ボク<WA>おんがく　ばんぐみの"
	cont "スーパー　ディレクター！"

	para "<⋯>おや　キミ<NO>ポケギアじゃ"
	line "ざんねんだけど　ボク<NO>ばんぐみを"
	cont "じゅしん　できないね！"

	para "グレードアップした　ラジオカードを"
	line "つければ　きけるよう<NI>なるよ！"
	done

LavRadioTower1FSuperNerd2Text_GotExpnCard:
	text "はあーい！"
	line "ボク<WA>おんがく　ばんぐみの"
	cont "スーパー　ディレクター！"

	para "うつくしい　メロディを"
	line "ながしてるのよ！"
	cont "ヨロシクねっ！"
	done

LavRadioTower1FDirectoryText:
	text "１かい　<⋯>　うけつけ"
	line "２かい　<⋯>　えいぎょうぶ"
	cont "３かい　<⋯>　そうむぶ"
	cont "４かい　<⋯>　せいさくしつ"
	cont "５かい　<⋯>　きょくちょうしつ"
	done

LavRadioTower1FPokeFluteSignText:
	text "きよらかな　ふえ<NO>ねいろで"
	line "#も　うきうき！"
	cont "チャンネル　２０！"
	done

LavRadioTower1FReferenceLibraryText:
	text "#<NO>シーディーと"
	line "ビデオ<GA>たくさん　ならんでる！"
	cont "ばんぐみ<NO>しりょう　かな？"
	done

LavRadioTower1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, LAVENDER_TOWN, 7
	warp_event  3,  7, LAVENDER_TOWN, 7

	def_coord_events

	def_bg_events
	bg_event 11,  0, BGEVENT_READ, LavRadioTower1FDirectory
	bg_event  5,  0, BGEVENT_READ, LavRadioTower1FPokeFluteSign

	def_object_events
	object_event  6,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FReceptionistScript, -1
	object_event 15,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FOfficerScript, -1
	object_event  1,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FSuperNerd1Script, -1
	object_event  9,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FGentlemanScript, -1
	object_event 14,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FSuperNerd2Script, -1
