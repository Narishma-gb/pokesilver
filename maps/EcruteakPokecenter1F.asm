	object_const_def
	const ECRUTEAKPOKECENTER1F_NURSE
	const ECRUTEAKPOKECENTER1F_POKEFAN_M
	const ECRUTEAKPOKECENTER1F_COOLTRAINER_F
	const ECRUTEAKPOKECENTER1F_GYM_GUIDE
	const ECRUTEAKPOKECENTER1F_BILL

EcruteakPokecenter1F_MapScripts:
	def_scene_scripts
	scene_script EcruteakPokecenter1FMeetBillScene, SCENE_ECRUTEAKPOKECENTER1F_MEET_BILL
	scene_script EcruteakPokecenter1FNoopScene,     SCENE_ECRUTEAKPOKECENTER1F_NOOP

	def_callbacks

EcruteakPokecenter1FMeetBillScene:
	sdefer EcruteakPokcenter1FBillActivatesTimeCapsuleScript
	end

EcruteakPokecenter1FNoopScene:
	end

EcruteakPokcenter1FBillActivatesTimeCapsuleScript:
	pause 30
	playsound SFX_EXIT_BUILDING
	appear ECRUTEAKPOKECENTER1F_BILL
	waitsfx
	applymovement ECRUTEAKPOKECENTER1F_BILL, EcruteakPokecenter1FBillMovement1
	applymovement PLAYER, EcruteakPokecenter1FPlayerMovement1
	turnobject ECRUTEAKPOKECENTER1F_NURSE, UP
	pause 10
	turnobject ECRUTEAKPOKECENTER1F_NURSE, DOWN
	pause 30
	turnobject ECRUTEAKPOKECENTER1F_NURSE, UP
	pause 10
	turnobject ECRUTEAKPOKECENTER1F_NURSE, DOWN
	pause 20
	turnobject ECRUTEAKPOKECENTER1F_BILL, DOWN
	pause 10
	opentext
	writetext EcruteakPokecenter1F_BillText1
	promptbutton
	sjump .PointlessJump

.PointlessJump:
	writetext EcruteakPokecenter1F_BillText2
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement ECRUTEAKPOKECENTER1F_BILL, EcruteakPokecenter1FBillMovement2
	playsound SFX_EXIT_BUILDING
	disappear ECRUTEAKPOKECENTER1F_BILL
	clearevent EVENT_MET_BILL
	setflag ENGINE_TIME_CAPSULE
	setscene SCENE_ECRUTEAKPOKECENTER1F_NOOP
	waitsfx
	end

EcruteakPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

EcruteakPokecenter1FPokefanMScript:
	jumptextfaceplayer EcruteakPokecenter1FPokefanMText

EcruteakPokecenter1FCooltrainerFScript:
	jumptextfaceplayer EcruteakPokecenter1FCooltrainerFText

EcruteakPokecenter1FGymGuideScript:
	jumptextfaceplayer EcruteakPokecenter1FGymGuideText

EcruteakPokecenter1FBillMovement1:
	step UP
	step UP
	step UP
	step UP
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

EcruteakPokecenter1FBillMovement2:
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

EcruteakPokecenter1FPlayerMovement1:
	step UP
	step UP
	step UP
	step_end

EcruteakPokecenter1F_BillText1:
	text "わい　マサキ"
	line "きみは<⋯>？"

	para "ふうん　<PLAYER>　ゆーんか"
	line "ええとこ　きたなあ"
	done

EcruteakPokecenter1F_BillText2:
	text "いまな　タイムカプセルの"
	line "ちょうせい<GA>おわったとこ　やねん"

	para "きみも　し<TTE>のとおり"
	line "#<TTE>　こうかん　できるやろ"

	para "それで　むかし<NO>ひととも"
	line "こうかん　できるよう"
	cont "タイムカプセル<GA>つくられたんや"

	para "<⋯>　でもな"
	line "むかし<NO>ひと<GA>しらんもんは"
	cont "おくること<GA>できひんねん"
	cont "<PC><GA>パンクしよる　からな"

	para "そやから　こっちで　むかし<NI>"
	line "なかったもん<WA>はずさな　あかん"

	para "はっきり　ゆーたら"
	line "あたらしい　#"
	cont "あたらしい　わざは"
	cont "タイムカプセルでは"
	cont "つうしんこうかん　できひんねん"

	para "まっ　そのへん　ちょうせい　すんだし"
	line "あした<NI>なったら"
	cont "ぜんこく<NO>#センターで"
	cont "タイムカプセル　つかえる　はずやで"

	para "ほな　わい　コガネ<NI>かえるわ"
	line "たまに<WA>おやこうこう　せんとな"

	para "ほな　バイバイ！"
	done

EcruteakPokecenter1FPokefanMText:
	text "まいこはん　おどりも"
	line "#つかう　すがたも　きれいやな"
	done

EcruteakPokecenter1FCooltrainerFText:
	text "ジムリーダー<NO>マツバさま"
	line "すてきだわあ"
	cont "あ<NO>クールなところ<GA>いいの"

	para "それ<NI>#も"
	line "と<TTE>も　つよいんだから"
	done

EcruteakPokecenter1FGymGuideText:
	text "いかりのみずうみ<⋯>"
	line "ギャラドス<NO>たいりょうはっせい<⋯>"
	cont "なにか　じけん<NO>におい<GA>するな"
	done

EcruteakPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 6
	warp_event  4,  7, ECRUTEAK_CITY, 6
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPokecenter1FNurseScript, -1
	object_event  7,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPokecenter1FPokefanMScript, -1
	object_event  1,  4, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPokecenter1FCooltrainerFScript, -1
	object_event  7,  1, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, EcruteakPokecenter1FGymGuideScript, -1
	object_event  0,  7, SPRITE_BILL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ECRUTEAK_POKE_CENTER_BILL
