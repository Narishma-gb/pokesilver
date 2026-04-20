	object_const_def
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_CAPTAIN
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_GENTLEMAN
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN1
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN2
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_POKEFAN_M1
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN3
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN4
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_SUPER_NERD1
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_POKEFAN_M2
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_POKEFAN_F
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_SUPER_NERD2

FastShipCabins_SE_SSE_CaptainsCabin_MapScripts:
	def_scene_scripts

	def_callbacks

FastShipCabins_SE_SSE_CaptainsCabinNoopScene: ; unreferenced
	end

SSAquaCaptain:
	faceplayer
	opentext
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue .LaterTrip
	writetext SSAquaCaptainExhaustingText
	waitbutton
	closetext
	end

.LaterTrip:
	writetext SSAquaCaptainHowDoYouLikeText
	waitbutton
	closetext
	end

SSAquaGranddaughterBefore:
	turnobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN2, RIGHT
	opentext
	writetext SSAquaGranddaughterCaptainPlayWithMeText
	waitbutton
	closetext
	faceplayer
	opentext
	writetext SSAquaGranddaughterHasToFindGrandpaText
	waitbutton
	closetext
	special FadeOutToBlack
	special ReloadSpritesNoPalettes
	disappear FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN2
	applymovement PLAYER, SSAquaCaptainsCabinWarpsToGrandpasCabinMovement
	moveobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN1, 3, 19
	appear FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN1
	turnobject PLAYER, UP
	turnobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN1, UP
	special FadeInFromBlack
	turnobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_GENTLEMAN, DOWN
	showemote EMOTE_SHOCK, FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_GENTLEMAN, 15
	applymovement FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN1, SSAquaGranddaughterEntersCabinMovement
	turnobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_GENTLEMAN, RIGHT
	opentext
	writetext SSAquaGranddaughterWasPlayingMText
	waitbutton
	closetext
	turnobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN2, DOWN
	applymovement FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_GENTLEMAN, SSAquaGrandpaApproachesPlayerMovement
	opentext
	writetext SSAquaEntertainedGranddaughterText
	promptbutton
	setevent EVENT_VERMILION_PORT_SAILOR_AT_GANGWAY
	setmapscene FAST_SHIP_1F, SCENE_FASTSHIP1F_NOOP
	sjump SSAquaMetalCoatAndDocking

SSAquaGrandpa:
	faceplayer
	opentext
	checkevent EVENT_GOT_METAL_COAT_FROM_GRANDPA_ON_SS_AQUA
	iftrue SSAquaGotMetalCoat
	checkevent EVENT_FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN_TWIN_2
	iftrue SSAquaFoundGranddaughter
	writetext SSAquaCantFindGranddaughterText
	waitbutton
	closetext
	setmapscene FAST_SHIP_1F, SCENE_FASTSHIP1F_NOOP
	end

SSAquaMetalCoatAndDocking:
	writetext SSAquaGrandpaHaveThisText
	promptbutton
	verbosegiveitem METAL_COAT
	iffalse .NoRoom
	setevent EVENT_GOT_METAL_COAT_FROM_GRANDPA_ON_SS_AQUA
.NoRoom:
	closetext
	waitsfx
	playsound SFX_ELEVATOR_END
	pause 30
	opentext
	writetext SSAquaHasArrivedVermilionText
	waitbutton
	setevent EVENT_FAST_SHIP_HAS_ARRIVED
	setevent EVENT_FAST_SHIP_FOUND_GIRL
	closetext
	end

SSAquaFoundGranddaughter:
	writetext SSAquaGrandpaHaveThisText
	promptbutton
	verbosegiveitem METAL_COAT
	iffalse .NoRoom
	setevent EVENT_GOT_METAL_COAT_FROM_GRANDPA_ON_SS_AQUA
.NoRoom:
	closetext
	end

SSAquaGotMetalCoat:
	writetext SSAquaGrandpaTravellingText
	waitbutton
	closetext
	end

SSAquaGranddaughterAfter:
	faceplayer
	opentext
	writetext SSAquaGranddaughterHadFunText
	waitbutton
	closetext
	end

TrainerPokefanmColin:
	trainer POKEFANM, COLIN, EVENT_BEAT_POKEFANM_COLIN, PokefanmColinSeenText, PokefanmColinBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokefanmColinAfterBattleText
	waitbutton
	closetext
	end

TrainerTwinsMegandpeg1:
	trainer TWINS, MEGANDPEG1, EVENT_BEAT_TWINS_MEG_AND_PEG, TwinsMegandpeg1SeenText, TwinsMegandpeg1BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext TwinsMegandpeg1AfterBattleText
	waitbutton
	closetext
	end

TrainerTwinsMegandpeg2:
	trainer TWINS, MEGANDPEG2, EVENT_BEAT_TWINS_MEG_AND_PEG, TwinsMegandpeg2SeenText, TwinsMegandpeg2BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext TwinsMegandpeg2AfterBattleText
	waitbutton
	closetext
	end

TrainerPsychicRodney:
	trainer PSYCHIC_T, RODNEY, EVENT_BEAT_PSYCHIC_RODNEY, PsychicRodneySeenText, PsychicRodneyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PsychicRodneyAfterBattleText
	waitbutton
	closetext
	end

TrainerPokefanmJeremy:
	trainer POKEFANM, JEREMY, EVENT_BEAT_POKEFANM_JEREMY, PokefanmJeremySeenText, PokefanmJeremyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokefanmJeremyAfterBattleText
	waitbutton
	closetext
	end

TrainerPokefanfGeorgia:
	trainer POKEFANF, GEORGIA, EVENT_BEAT_POKEFANF_GEORGIA, PokefanfGeorgiaSeenText, PokefanfGeorgiaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokefanfGeorgiaAfterBattleText
	waitbutton
	closetext
	end

TrainerSupernerdShawn:
	trainer SUPER_NERD, SHAWN, EVENT_BEAT_SUPER_NERD_SHAWN, SupernerdShawnSeenText, SupernerdShawnBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SupernerdShawnAfterBattleText
	waitbutton
	closetext
	end

FastShipCaptainsCabinTrashcan:
	jumpstd TrashCanScript

SSAquaCaptainsCabinWarpsToGrandpasCabinMovement:
	big_step RIGHT
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	step_end

SSAquaGranddaughterEntersCabinMovement:
	step UP
	step UP
	turn_head LEFT
	step_end

SSAquaGrandpaApproachesPlayerMovement:
	step DOWN
	step_end

SSAquaCaptainExhaustingText:
	text "いやー　たすかったよ！"

	para "あ<NO>おんなのこの"
	line "あそびあいて<WO>するの<NI>つかれて"
	cont "こま<TTE>いた　ところなんだ"
	done

SSAquaCaptainHowDoYouLikeText:
	text "わ<GA>アクアごうの"
	line "のりごこち<WA>どうだい！？"
	cont "うみのうえ<WO>すべるように"

	para "はし<TTE>いくだろう！"
	done

SSAquaCantFindGranddaughterText:
	text "やあ　ぼうや<⋯>"
	line "まご<GA>みつからないんだよ<⋯>"

	para "ふね<NO>どこか<NI>いるなら"
	line "そんな<NI>しんぱいじゃ　ないが"
	cont "げんき<NO>いい　おんなのこ　だから"
	cont "だれか<NI>めいわく<WO>かけているかも"
	cont "そう　おもうと　しんぱいだ<⋯>"
	done

SSAquaEntertainedGranddaughterText:
	text "ええと　<PLAYER>くん　だったかね"
	line "まごと　あそんで　くれた　そうだね"
	cont "ありがとう！"
	cont "<WATASHI>からも　おれい<WO>いわせてくれ"
	done

SSAquaGrandpaHaveThisText:
	text "そうだ！　もしよかったら"
	line "これ<WO>もら<TTE>　くれないか！"
	done

SSAquaGrandpaTravellingText:
	text "<WATASHI>たち<WA>せかいじゅうを"
	line "たびして　まわ<TTE>いるんだよ"
	done

SSAquaGranddaughterCaptainPlayWithMeText:
	text "せんちょうさん"
	line "あたしと　あそんでー！"

	para "つまんなーい！"
	line "もっと　あそびたいよー！"
	done

SSAquaGranddaughterHasToFindGrandpaText:
	text "おにいちゃん"
	line "あたしと　あそんでくれる？"
	cont "<⋯>えっ！"
	cont "おじいちゃん<GA>しんぱい　してる？"
	cont "じゃあ　あたし　かえる！"
	cont "おじいちゃんとこ　かえる！"
	done

SSAquaGranddaughterWasPlayingMText:
	text "おじいちゃん　ただいまー！"
	line "せんちょうさんとー"
	cont "おにいちゃんとー"
	cont "あそんでたのー！"
	done

SSAquaGranddaughterHadFunText:
	text "みんなと　あそべて"
	line "すっごく　たのしかっ<TA!>"
	done

PokefanmColinSeenText:
	text "おじさんと　しょうぶ　しよう！"
	done

PokefanmColinBeatenText:
	text "つよいなあ！"
	done

PokefanmColinAfterBattleText:
	text "きみ<WA>ひとりたび　かい？"
	line "おかあさん　しんぱい　してない？"
	done

TwinsMegandpeg1SeenText:
	text "ちびっこ　だと　おも<TTE>るですか？"
	line "そんなこと　ないんだからあ"
	done

TwinsMegandpeg1BeatenText:
	text "あら　まけちゃっ<TA!>"
	done

TwinsMegandpeg1AfterBattleText:
	text "ちびっこ　<TTE>　よびかた"
	line "こどもにたいして　しつれい　だもん！"
	done

TwinsMegandpeg2SeenText:
	text "あたしたち　ちびっこ　じゃないですう"
	line "そんな<NO>レディ<NI>しつれい　ですう"
	done

TwinsMegandpeg2BeatenText:
	text "あら　まけちゃっ<TA!>"
	done

TwinsMegandpeg2AfterBattleText:
	text "ぜったい　こども<NO>ほうが"
	line "かしこいとき<GA>あるんだもん！"
	done

PsychicRodneySeenText:
	text "むむ！　ボク<NO>ずのうが"
	line "でんぱ<WO>キャッチし<TA!>"
	done

PsychicRodneyBeatenText:
	text "<⋯>なにか　きこえる！"
	done

PsychicRodneyAfterBattleText:
	text "そうか　こうそくせん<NO>なかは"
	line "ジョウト<NO>ラジオ<GA>きけるんだ！"
	done

PokefanmJeremySeenText:
	text "どう？　わがはい<NO>#"
	line "と<TTE>も　キレイ　だろう？"
	done

PokefanmJeremyBeatenText:
	text "ああ<⋯>！"
	line "せっかく　キレイ<NI>したのに！"
	done

PokefanmJeremyAfterBattleText:
	text "#　びようしつで"
	line "また　キレイ<NI>してもらおう！"
	done

PokefanfGeorgiaSeenText:
	text "ひゃっかてんで　おかいもの！"
	line "それからね<⋯>"
	done

PokefanfGeorgiaBeatenText:
	text "なんだったかしら<⋯>？"
	done

PokefanfGeorgiaAfterBattleText:
	text "そうそう　そだてやさん<NI>あずけた"
	line "#　ひきとり<NI>いかなくちゃ！"
	done

SupernerdShawnSeenText:
	text "キミ　モンスターボールを"
	line "なんしゅるい　も<TTE>る？"
	done

SupernerdShawnBeatenText:
	text "いや　ちょっと"
	line "キミ　やめてっ！"
	done

SupernerdShawnAfterBattleText:
	text "ボール<WA>じょうきょうによ<TTE>"
	line "つかいわけた　ほう<GA>いいですよ"
	done

SSAquaHasArrivedVermilionText:
	text "こうそくせん　アクアごうは"
	line "クチバこう<NI>とうちゃくしまし<TA!>"
	done

FastShipCabins_SE_SSE_CaptainsCabin_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, FAST_SHIP_1F, 8
	warp_event  3,  7, FAST_SHIP_1F, 8
	warp_event  2, 19, FAST_SHIP_1F, 9
	warp_event  3, 19, FAST_SHIP_1F, 9
	warp_event  2, 33, FAST_SHIP_1F, 10
	warp_event  3, 33, FAST_SHIP_1F, 10

	def_coord_events

	def_bg_events
	bg_event  4, 25, BGEVENT_READ, FastShipCaptainsCabinTrashcan

	def_object_events
	object_event  3, 25, SPRITE_CAPTAIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SSAquaCaptain, -1
	object_event  2, 17, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SSAquaGrandpa, EVENT_FAST_SHIP_CABINS_SE_SSE_GENTLEMAN
	object_event  3, 17, SPRITE_TWIN, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SSAquaGranddaughterAfter, EVENT_FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN_TWIN_1
	object_event  2, 25, SPRITE_TWIN, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SSAquaGranddaughterBefore, EVENT_FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN_TWIN_2
	object_event  5,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 5, TrainerPokefanmColin, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  2,  4, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsMegandpeg1, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  3,  4, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsMegandpeg2, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  5,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 5, TrainerPsychicRodney, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerPokefanmJeremy, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event  5,  5, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerPokefanfGeorgia, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event  1, 15, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerSupernerdShawn, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
