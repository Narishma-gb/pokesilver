	object_const_def
	const COPYCATSHOUSE2F_COPYCAT
	const COPYCATSHOUSE2F_DODRIO
	const COPYCATSHOUSE2F_FAIRYDOLL ; lost item
	const COPYCATSHOUSE2F_MONSTERDOLL
	const COPYCATSHOUSE2F_BIRDDOLL

CopycatsHouse2F_MapScripts:
	def_scene_scripts

	def_callbacks

Copycat:
	faceplayer
	checkevent EVENT_GOT_PASS_FROM_COPYCAT
	iftrue .GotPass
	checkevent EVENT_RETURNED_LOST_ITEM_TO_COPYCAT
	iftrue .TryGivePassAgain
	checkitem LOST_ITEM
	iftrue .ReturnLostItem
	applymovement COPYCATSHOUSE2F_COPYCAT, CopycatSpinAroundMovementData
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_CHRIS
	special LoadUsedSpritesGFX
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .TalkAboutLostItem
	opentext
	writetext CopycatText_Male_1
	waitbutton
	closetext
	applymovement COPYCATSHOUSE2F_COPYCAT, CopycatSpinAroundMovementData
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	special LoadUsedSpritesGFX
	opentext
	writetext CopycatText_QuickMimicking
	waitbutton
	closetext
	end

.TalkAboutLostItem:
	opentext
	writetext CopycatText_Male_2
	waitbutton
	closetext
	applymovement COPYCATSHOUSE2F_COPYCAT, CopycatSpinAroundMovementData
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	special LoadUsedSpritesGFX
	opentext
	writetext CopycatText_Worried
	waitbutton
	closetext
	setevent EVENT_MET_COPYCAT_FOUND_OUT_ABOUT_LOST_ITEM
	end

.ReturnLostItem:
	opentext
	writetext CopycatText_GiveDoll
	promptbutton
	takeitem LOST_ITEM
	setevent EVENT_RETURNED_LOST_ITEM_TO_COPYCAT
	clearevent EVENT_COPYCATS_HOUSE_2F_DOLL
	sjump .GivePass

.TryGivePassAgain:
	opentext
.GivePass:
	writetext CopycatText_GivePass
	promptbutton
	verbosegiveitem PASS
	iffalse .Cancel
	setevent EVENT_GOT_PASS_FROM_COPYCAT
	writetext CopycatText_ExplainPass
	waitbutton
	closetext
	end

.GotPass:
	applymovement COPYCATSHOUSE2F_COPYCAT, CopycatSpinAroundMovementData
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_CHRIS
	special LoadUsedSpritesGFX
	opentext
	writetext CopycatText_Male_3
	waitbutton
	closetext
	applymovement COPYCATSHOUSE2F_COPYCAT, CopycatSpinAroundMovementData
	faceplayer
	variablesprite SPRITE_COPYCAT, SPRITE_LASS
	special LoadUsedSpritesGFX
	opentext
	writetext CopycatText_ItsAScream
	waitbutton
.Cancel:
	closetext
	end

CopycatsDodrio:
	opentext
	writetext CopycatsDodrioText1
	cry DODRIO
	promptbutton
	writetext CopycatsDodrioText2
	waitbutton
	closetext
	end

CopycatsHouse2FDoll:
	jumptext CopycatsHouse2FDollText

CopycatsHouse2FBookshelf:
	jumpstd PictureBookshelfScript

CopycatSpinAroundMovementData:
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	step_end

CopycatText_Male_1:
	text "<PLAYER>『やあ！　こんにちは！"
	line "きみ　#　すきかい？"

	para "<PLAYER>『ぼく　じゃなく<TTE>"
	line "きみ<NI>きいてるんだ　けど"

	para "<PLAYER>『<⋯>　えー　なんだよ！"
	line "ヘンな　やつ　だなあ！"
	done

CopycatText_QuickMimicking:
	text "モノマネむすめ『<⋯>　なに？"
	line "ひと<NO>マネ　すんな<TTE>？"

	para "だ<TTE>　あたし"
	line "ものまね　しゅみ　なんだ　もん！"
	done

CopycatText_Male_2:
	text "<PLAYER>『やあ！　こんにちは！"
	line "ピッピにんぎょう<WO>なくして"
	cont "こま<TTE>る　みたいだね！"

	para "<PLAYER>『みつけて　くれたら"
	line "ていきけん<WO>もらえるの？"

	para "<PLAYER>『じゃあ　ぼくが"
	line "さがして　あげよう！"

	para "クチバ　シティ<NI>いったとき"
	line "おとしたかも　しれないんだね！"
	done

CopycatText_Worried:
	text "モノマネむすめ『<⋯>　なに？"
	line "か<TTE><NI>きめるな<TTE>？"

	para "だ<TTE>　こま<TTE>るんだもん<⋯>"
	line "だれか<NI>ひろわれたのかな<⋯>？"
	done

CopycatText_GiveDoll:
	text "モノマネむすめ『わあー！"
	line "<WATASHI><NO>ピッピにんぎょう！"
	cont "ほら　みぎあし<NO>つけね<NO>キズ！"
	cont "これ<GA>しょうこ　なの！"
	done

CopycatText_GivePass:
	text "やくそくどおり　はい　これ！"
	line "リニア<NO>ていきけんよ！"
	done

CopycatText_ExplainPass:
	text "モノマネむすめ『リニア<NI>のるとき"
	line "つかう　ていきけん　なの！"

	para "まえ<NI>すんでいた　いえが"
	line "リニアのえき<NI>なるとき"
	cont "てつどうがいしゃ<NO>ひとが"
	cont "くれた　も<NO>なのよ"
	done

CopycatText_Male_3:
	text "<PLAYER>『やあ！　さっきは"
	line "リニア<NO>ていきけん　ありがと！"

	para "<PLAYER>『<⋯>　なーに？"

	para "<PLAYER>『ぼく<NO>まね　して"
	line "そんな<NI>たのしい　かい？"
	done

CopycatText_ItsAScream:
	text "モノマネむすめ『うん<⋯>！"
	line "と<TTE>も　たのしいー！"
	done

CopycatsDodrioText1:
	text "ドードリオ『ギー　ギーッ！"
	done

CopycatsDodrioText2:
	text "<⋯>　カガミ　ヨ　カガミ！"
	line "セカイデ　イチバン　キレイナ"
	cont "オンナノコハ　ダーレ？"
	done

CopycatsHouse2FDollText:
	text "これ<WA>めずらしい　#！？"
	line "<⋯>　あれ？　ぬいぐるみ　だった"
	done

CopycatsHouse2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  0, COPYCATS_HOUSE_1F, 3

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, CopycatsHouse2FBookshelf
	bg_event  1,  1, BGEVENT_READ, CopycatsHouse2FBookshelf

	def_object_events
	object_event  4,  3, SPRITE_COPYCAT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Copycat, -1
	object_event  6,  4, SPRITE_MOLTRES, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CopycatsDodrio, -1
	object_event  6,  1, SPRITE_FAIRY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CopycatsHouse2FDoll, EVENT_COPYCATS_HOUSE_2F_DOLL
	object_event  2,  1, SPRITE_MONSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CopycatsHouse2FDoll, -1
	object_event  7,  1, SPRITE_BIRD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CopycatsHouse2FDoll, -1
