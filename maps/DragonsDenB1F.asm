	object_const_def
	const DRAGONSDENB1F_POKE_BALL1
	const DRAGONSDENB1F_CLAIR
	const DRAGONSDENB1F_RIVAL

DragonsDenB1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, DragonsDenB1FCheckRivalCallback

DragonsDenB1FCheckRivalCallback:
	checkevent EVENT_BEAT_RIVAL_IN_MT_MOON
	iftrue .CheckDay
	disappear DRAGONSDENB1F_RIVAL
	endcallback

.CheckDay:
	readvar VAR_WEEKDAY
	ifequal TUESDAY, .AppearRival
	ifequal THURSDAY, .AppearRival
	disappear DRAGONSDENB1F_RIVAL
	endcallback

.AppearRival:
	appear DRAGONSDENB1F_RIVAL
	endcallback

DragonsDenB1FDragonFangScript:
	giveitem DRAGON_FANG
	iffalse .BagFullDragonFang
	disappear DRAGONSDENB1F_POKE_BALL1
	opentext
	getitemname STRING_BUFFER_3, DRAGON_FANG
	writetext Text_FoundDragonFang
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	readvar VAR_FACING
	ifequal RIGHT, .next
	sjump .next2
.next
	moveobject DRAGONSDENB1F_CLAIR, 34, 21
.next2
	appear DRAGONSDENB1F_CLAIR
	applymovement DRAGONSDENB1F_CLAIR, MovementDragonsDen_ClairWalksToYou
	turnobject PLAYER, DOWN
	opentext
	writetext ClairText_GiveDragonbreathDragonDen
	promptbutton
	waitsfx
	writetext DragonShrinePlayerReceivedRisingBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_RISINGBADGE
	specialphonecall SPECIALCALL_MASTERBALL
	writetext DragonShrineRisingBadgeExplanationText
	promptbutton
	verbosegiveitem TM_DRAGONBREATH, 1
	iffalse .ClairLastText
	setevent EVENT_GOT_TM24_DRAGONBREATH
	writetext ClairText_DescribeDragonbreathDragonDen
	promptbutton
	sjump .ClairLastText
.ClairLastText
	writetext ClairText_CollectedAllBadges
	waitbutton
	closetext
	applymovement DRAGONSDENB1F_CLAIR, MovementDragonsDen_ClairWalksAway
	disappear DRAGONSDENB1F_CLAIR
	end

.BagFullDragonFang:
	opentext
	getitemname STRING_BUFFER_3, DRAGON_FANG
	writetext Text_FoundDragonFang
	promptbutton
	writetext Text_NoRoomForDragonFang
	waitbutton
	closetext
	end

Text_FoundDragonFang:
	text "<PLAYER>は"
	line "@"
	text_ram wStringBuffer3
	text "<WO>みつけ<TA!>"
	done

Text_NoRoomForDragonFang:
	text "しかし　<PLAYER>は"
	line "これ　いじょう　どうぐ<WO>もてない！"
	done

DragonsDenB1FRivalScript:
	playmusic MUSIC_RIVAL_ENCOUNTER
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .RivalTalkAgain
	writetext RivalText_Training1
	waitbutton
	closetext
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	special RestartMapMusic
	end

.RivalTalkAgain:
	writetext RivalText_Training2
	waitbutton
	closetext
	special RestartMapMusic
	end

DragonShrineSignpost:
	jumptext DragonShrineSignpostText

DragonsDenB1FHiddenRevive:
	hiddenitem REVIVE, EVENT_DRAGONS_DEN_B1F_HIDDEN_REVIVE

DragonsDenB1FHiddenMaxPotion:
	hiddenitem MAX_POTION, EVENT_DRAGONS_DEN_B1F_HIDDEN_MAX_POTION

DragonsDenB1FHiddenMaxElixer:
	hiddenitem MAX_ELIXER, EVENT_DRAGONS_DEN_B1F_HIDDEN_MAX_ELIXER

MovementDragonsDen_ClairWalksToYou:
	step UP
	step UP
	step UP
	step UP
	step_end

MovementDragonsDen_ClairWalksAway:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

ClairText_GiveDragonbreathDragonDen:
	text "イブキ『わかったわ！"
	line "あなた<NO>じつりょく　みとめます"
	cont "このバッジ<WO>も<TTE>　いきなさい"
	done

DragonShrinePlayerReceivedRisingBadgeText:
	text "<PLAYER><WA>イブキから"
	line "ライジングバッジ<WO>もらっ<TA!>"
	done

DragonShrineRisingBadgeExplanationText:
	text "ライジングバッジ<WO>も<TTE>いれば"
	line "どんな　たきも"
	cont "のぼれるよう<NI>なるわ"

	para "あと　すべて<NO>#が"
	line "あなた<WO><TRAINER>として　みとめ"
	cont "どんな　めいれいにも　したがうわ！"

	para "それと　こ<NO><TM>も"
	line "も<TTE>いくと　いいわ"
	done

Text_ReceivedTM24: ; unreferenced
	text "<PLAYER><WA>イブキから"
	line "<TM>２４<WO>もらっ<TA!>"
	done

ClairText_DescribeDragonbreathDragonDen:
	text "なか<NI>はい<TTE>いるのは"
	line "りゅうのいぶき"

	para "<⋯>　べつ<NI>シャレじゃ　ないわよ"
	line "いらないなら　むりして"
	cont "も<TTE>いかなくても　いいのよ"
	done

ClairText_CollectedAllBadges:
	text "すべて<NO>バッジ<GA>そろったようね"

	para "むかう<WA>セキエイこうげん"
	line "#リーグね"

	para "ばしょ<WA>し<TTE>る？"
	line "そうね　ここからだと"
	cont "まず<WA>ワカバタウン<NI>いくことね"

	para "そこから　なみのりで"
	line "ずっと　ひがし<NI>いくと　いいわ"
	cont "ただし　きびしい　みちのりよ"

	para "#リーグでも"
	line "まけたら　ゆるさないからね！"

	para "そうでないと　まけた"
	line "<WATASHI><GA>みじめ<NI>なるでしょ！"
	done

DragonShrineSignpostText:
	text "りゅう<NO>ほこら"

	para "りゅうのあな<NI>いたと　いう"
	line "ドラゴン#<WO>まつる"
	done

RivalText_Training1:
	text "<⋯>　<⋯>　<⋯>"
	line "なんだ　<PLAYER>か<⋯>"

	para "<⋯>　わるい<GA>おまえの"
	line "あいて　するつもり<WA>ねーよ"

	para "いま<NO>こいつらじゃ　"
	line "おまえ<NI>かてない"
	cont "そんな　むちゃ<WA>させられないさ"

	para "そうでなきゃ"
	line "さいきょう<NO><TRAINER>には"
	cont "なれないからな<⋯>"
	done

RivalText_Training2:
	text "<⋯>　<⋯>　<⋯>"

	para "ふう<⋯>"
	line "ひと<NO>じゃま　してんじゃねーよ"
	done

DragonsDenB1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 20,  3, DRAGONS_DEN_1F, 3

	def_coord_events

	def_bg_events
	bg_event 18, 24, BGEVENT_READ, DragonShrineSignpost
	bg_event 31,  4, BGEVENT_ITEM, DragonsDenB1FHiddenRevive
	bg_event 21, 17, BGEVENT_ITEM, DragonsDenB1FHiddenMaxPotion
	bg_event 31, 15, BGEVENT_ITEM, DragonsDenB1FHiddenMaxElixer

	def_object_events
	object_event 35, 16, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DragonsDenB1FDragonFangScript, EVENT_DRAGONS_DEN_B1F_DRAGON_FANG
	object_event 35, 22, SPRITE_CLAIR, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_DRAGONS_DEN_CLAIR
	object_event 20, 23, SPRITE_RIVAL, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DragonsDenB1FRivalScript, EVENT_RIVAL_DRAGONS_DEN
