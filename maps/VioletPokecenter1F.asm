	object_const_def
	const VIOLETPOKECENTER1F_NURSE
	const VIOLETPOKECENTER1F_SUPER_NERD
	const VIOLETPOKECENTER1F_GENTLEMAN
	const VIOLETPOKECENTER1F_YOUNGSTER
	const VIOLETPOKECENTER1F_ELMS_AIDE

VioletPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

VioletPokecenterNurse:
	jumpstd PokecenterNurseScript

VioletPokecenter1F_ElmsAideScript:
	faceplayer
	opentext
	checkevent EVENT_REFUSED_TO_TAKE_EGG_FROM_ELMS_AIDE
	iftrue .SecondTimeAsking
	writetext VioletPokecenterElmsAideFavorText
.AskTakeEgg:
	yesorno
	iffalse .RefusedEgg
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .PartyFull
	giveegg TOGEPI, EGG_LEVEL
	getstring STRING_BUFFER_4, .eggname
	scall .AideGivesEgg
	setevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	clearevent EVENT_ELMS_AIDE_IN_LAB
	clearevent EVENT_TOGEPI_HATCHED
	setmapscene ROUTE_32, SCENE_ROUTE32_OFFER_SLOWPOKETAIL
	writetext VioletPokecenterElmsAideGiveEggText
	waitbutton
	closetext
	readvar VAR_FACING
	ifequal UP, .AideWalksAroundPlayer
	turnobject PLAYER, DOWN
	applymovement VIOLETPOKECENTER1F_ELMS_AIDE, MovementData_AideWalksStraightOutOfPokecenter
	playsound SFX_EXIT_BUILDING
	disappear VIOLETPOKECENTER1F_ELMS_AIDE
	waitsfx
	end

.AideWalksAroundPlayer:
	applymovement VIOLETPOKECENTER1F_ELMS_AIDE, MovementData_AideWalksLeftToExitPokecenter
	turnobject PLAYER, DOWN
	applymovement VIOLETPOKECENTER1F_ELMS_AIDE, MovementData_AideFinishesLeavingPokecenter
	playsound SFX_EXIT_BUILDING
	disappear VIOLETPOKECENTER1F_ELMS_AIDE
	waitsfx
	end

.eggname
	db "タマゴ@"

.AideGivesEgg:
	jumpstd ReceiveTogepiEggScript
	end

.PartyFull:
	writetext VioletCityElmsAideFullPartyText
	waitbutton
	closetext
	end

.RefusedEgg:
	writetext VioletPokecenterElmsAideRefuseText
	waitbutton
	closetext
	setevent EVENT_REFUSED_TO_TAKE_EGG_FROM_ELMS_AIDE
	end

.SecondTimeAsking:
	writetext VioletPokecenterElmsAideAskEggText
	sjump .AskTakeEgg

VioletPokecenter1FSuperNerdScript:
	jumptextfaceplayer VioletPokecenter1FSuperNerdText

VioletPokecenter1FGentlemanScript:
	jumptextfaceplayer VioletPokecenter1FGentlemanText

VioletPokecenter1FYoungsterScript:
	jumptextfaceplayer VioletPokecenter1FYoungsterText

MovementData_AideWalksStraightOutOfPokecenter:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

MovementData_AideWalksLeftToExitPokecenter:
	step LEFT
	step DOWN
	step_end

MovementData_AideFinishesLeavingPokecenter:
	step DOWN
	step DOWN
	step DOWN
	step_end

VioletPokecenterElmsAideFavorText:
	text "<PLAYER>くん　おひさしぶりです"
	line "ウツギはかせ<NI>たのまれて"
	cont "きみ<WO>さがしてたんですよ"

	para "じつはですね<⋯>"

	para "#<NO>タマゴを"
	line "も<TTE>い<TTE>　ほしいんですよ！"
	done

VioletPokecenterElmsAideGiveEggText:
	text "ウツギはかせ<GA>しらべたところ"
	line "#<WA>タマゴ<NO>なかで"
	cont "あるていど　そだたないと"
	cont "うまれてこない　そうです！"

	para "しかも　いつも　げんきな"
	line "#<NO>そば<NI>いないと"
	cont "いけない　らしいんですよ"

	para "そういうこと<WO>おねがい　できるのは"
	line "<PLAYER>くん　だけですから"
	cont "よろしく　たのみます！"

	para "うまれたら　ウツギはかせに"
	line "れんらく　してあげて　くださいね"
	done

VioletCityElmsAideFullPartyText:
	text "#<GA>いっぱいで"
	line "それいじょう　つれあるけませんね"
	cont "で<WA>ここで　またせて　いただきます"
	done

VioletPokecenterElmsAideRefuseText:
	text "そ　そんな<⋯>"
	line "ウツギはかせ<NO>おねがい　なんですよ"
	done

VioletPokecenterElmsAideAskEggText:
	text "<PLAYER>くん"
	line "タマゴ<WO>も<TTE>い<TTE>　くれますか？"
	done

VioletPokecenter1FSuperNerdText:
	text "つかまえた　#を"
	line "<PC><NI>あずける　システム"
	cont "マサキ<TTE>　やつ<GA>つくったんだ<TTE>"
	done

VioletPokecenter1FGentlemanText:
	text "３ねんほど　まえ<NO>はなし　だよ"

	para "<ROCKET>　という　やつらが"
	line "#<WO>つか<TTE>"
	cont "わるいことばかり　してたのだよ"

	para "だがね　あく<WA>ほろびる！"
	line "ある　しょうねん<NO>かつやくで"
	cont "かいさん　させられたのだよ！"
	done

VioletPokecenter1FYoungsterText:
	text "#<WA>あたま<GA>いいからね"
	line "そんけい　できる　<TRAINER>の"
	cont "いうことじゃないと　きかないよ"

	para "ジムバッジ<WO>も<TTE>いないと"
	line "めいれい　きかず<NI>すきか<TTE>するよ"
	done

VioletPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, VIOLET_CITY, 5
	warp_event  4,  7, VIOLET_CITY, 5
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletPokecenterNurse, -1
	object_event  7,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VioletPokecenter1FSuperNerdScript, -1
	object_event  1,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletPokecenter1FGentlemanScript, -1
	object_event  8,  1, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VioletPokecenter1FYoungsterScript, -1
	object_event  4,  3, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, VioletPokecenter1F_ElmsAideScript, EVENT_ELMS_AIDE_IN_VIOLET_POKEMON_CENTER
