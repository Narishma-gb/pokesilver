	object_const_def
	const POWERPLANT_OFFICER1
	const POWERPLANT_GYM_GUIDE1
	const POWERPLANT_GYM_GUIDE2
	const POWERPLANT_OFFICER2
	const POWERPLANT_GYM_GUIDE3
	const POWERPLANT_MANAGER

PowerPlant_MapScripts:
	def_scene_scripts
	scene_script PowerPlantNoop1Scene, SCENE_POWERPLANT_NOOP
	scene_script PowerPlantNoop2Scene, SCENE_POWERPLANT_GUARD_GETS_PHONE_CALL

	def_callbacks

PowerPlantNoop1Scene:
	end

PowerPlantNoop2Scene:
	end

PowerPlantGuardPhoneScript:
	playsound SFX_CALL
	showemote EMOTE_SHOCK, POWERPLANT_OFFICER1, 15
	waitsfx
	pause 30
	applymovement POWERPLANT_OFFICER1, PowerPlantOfficer1ApproachGymGuide2Movement
	turnobject POWERPLANT_GYM_GUIDE1, DOWN
	turnobject POWERPLANT_GYM_GUIDE2, DOWN
	opentext
	writetext PowerPlantOfficer1CeruleanShadyCharacterText
	waitbutton
	closetext
	turnobject POWERPLANT_OFFICER1, LEFT
	turnobject PLAYER, RIGHT
	opentext
	writetext PowerPlantOfficer1CouldIAskForYourCooperationText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement POWERPLANT_OFFICER1, PowerPlantOfficer1ReturnToPostMovement
	setscene SCENE_POWERPLANT_NOOP
	end

PowerPlantOfficerScript:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	checkevent EVENT_MET_MANAGER_AT_POWER_PLANT
	iftrue .MetManager
	writetext PowerPlantOfficer1AThiefBrokeInText
	waitbutton
	closetext
	end

.MetManager:
	writetext PowerPlantOfficer1CouldIAskForYourCooperationText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext PowerPlantOfficer1HaveToBeefUpSecurityText
	waitbutton
	closetext
	end

PowerPlantGymGuide1Script:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext PowerPlantGymGuide1SomeoneStoleAPartText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext PowerPlantGymGuide1GeneratorUpAndRunningText
	waitbutton
	closetext
	end

PowerPlantGymGuide2Script:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext PowerPlantGymGuide2PowerPlantUpAndRunningText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext PowerPlantGymGuide2GeneratorIsRunningAgainText
	waitbutton
	closetext
	end

PowerPlantOfficer2Script:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext PowerPlantOfficer2ManagerHasBeenSadAndFuriousText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext PowerPlantOfficer2ManagerHasBeenCheerfulText
	waitbutton
	closetext
	end

PowerPlantGymGuide4Script:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext PowerPlantGymGuide4MagnetTrainConsumesElectricityText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext PowerPlantGymGuide4WeCanGetMagnetTrainRunningText
	waitbutton
	closetext
	end

PowerPlantManager:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	checkitem MACHINE_PART
	iftrue .FoundMachinePart
	checkevent EVENT_MET_MANAGER_AT_POWER_PLANT
	iftrue .MetManager
	writetext PowerPlantManagerWhoWouldRuinMyGeneratorText
	waitbutton
	closetext
	setevent EVENT_MET_MANAGER_AT_POWER_PLANT
	clearevent EVENT_CERULEAN_GYM_ROCKET
	clearevent EVENT_FOUND_MACHINE_PART_IN_CERULEAN_GYM
	setmapscene CERULEAN_GYM, SCENE_CERULEANGYM_GRUNT_RUNS_OUT
	setscene SCENE_POWERPLANT_GUARD_GETS_PHONE_CALL
	end

.MetManager:
	writetext PowerPlantManagerIWontForgiveCulpritText
	waitbutton
	closetext
	end

.FoundMachinePart:
	writetext PowerPlantManagerThatsThePartText
	promptbutton
	takeitem MACHINE_PART
	setevent EVENT_RETURNED_MACHINE_PART
	clearevent EVENT_SAFFRON_TRAIN_STATION_POPULATION
	setevent EVENT_ROUTE_5_6_POKEFAN_M_BLOCKS_UNDERGROUND_PATH
	setevent EVENT_ROUTE_24_ROCKET
	setevent EVENT_RESTORED_POWER_TO_KANTO
	clearevent EVENT_GOLDENROD_TRAIN_STATION_GENTLEMAN
.ReturnedMachinePart:
	checkevent EVENT_GOT_TM07_ZAP_CANNON
	iftrue .GotZapCannon
	writetext PowerPlantManagerTakeThisTMText
	promptbutton
	verbosegiveitem TM_ZAP_CANNON
	iffalse .NoRoom
	setevent EVENT_GOT_TM07_ZAP_CANNON
	writetext PowerPlantManagerTM07IsZapCannonText
	waitbutton
.NoRoom:
	closetext
	end

.GotZapCannon:
	writetext PowerPlantManagerMyBelovedGeneratorText
	waitbutton
	closetext
	end

PowerPlantBookshelf:
	jumpstd DifficultBookshelfScript

PowerPlantOfficer1ApproachGymGuide2Movement:
	step RIGHT
	step RIGHT
	step UP
	step UP
	step_end

PowerPlantOfficer1ReturnToPostMovement:
	step DOWN
	step DOWN
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

PowerPlantOfficer1AThiefBrokeInText:
	text "はつでんしょに"
	line "ドロボー<GA>はいるなんて"
	cont "ぜんだいみもん　だよ<⋯>"
	done

PowerPlantOfficer1CeruleanShadyCharacterText:
	text "ハナダ　シティから"
	line "れんらく<GA>ありまし<TA!>"

	para "あやしい　おとこ<GA>まちなかを"
	line "ウロウロ　している　とのことです！"
	done

PowerPlantOfficer1CouldIAskForYourCooperationText:
	text "よかったら　きみも"
	line "きょうりょく　してくれないか？"
	done

PowerPlantOfficer1HaveToBeefUpSecurityText:
	text "これから<WA>けいびを"
	line "きょうか　しないと！"
	done

PowerPlantGymGuide1SomeoneStoleAPartText:
	text "はつでんき<NO>ぶひんが"
	line "なにものか<NI>ぬすまれ<TA!>"

	para "ぶひん<GA>ないと　しんがたの"
	line "はつでんき<WO>うごかせないんだよ！"
	done

PowerPlantGymGuide1GeneratorUpAndRunningText:
	text "まいにち　たくさん<NO>でんきを"
	line "つくれるよう<NI>なったよ！"
	done

PowerPlantGymGuide2PowerPlantUpAndRunningText:
	text "<KOKO_WA>かつて　むじんの"
	line "はつでんしょ　だったんだ"

	para "でも　リニア　モーターカーの"
	line "でんりょく<WO>つくるために"
	cont "さいけん　されたのさ"
	done

PowerPlantGymGuide2GeneratorIsRunningAgainText:
	text "ぶじ<NI>はつでんきが"
	line "うごくよう<NI>なったよ！"
	done

PowerPlantOfficer2ManagerHasBeenSadAndFuriousText:
	text "このさき<WA>はつでんしつ"
	line "しょちょう<GA>いるけど"
	cont "きかい<WO>こわされて"
	cont "おこったり　かなしんだり<⋯>"
	done

PowerPlantOfficer2ManagerHasBeenCheerfulText:
	text "きかい<GA>なお<TTE>"
	line "しょちょうも　ゴキゲンだ！"
	done

PowerPlantGymGuide4MagnetTrainConsumesElectricityText:
	text "リニア<WA>たくさん　でんきを"
	line "つかう　のりも<NO>だからね"

	para "しんがた　はつでんき<GA>うごかないと"
	line "リニア<WA>とまった　まま　だよ"
	done

PowerPlantGymGuide4WeCanGetMagnetTrainRunningText:
	text "これで　やっと"
	line "リニア<WO>うごかすこと<GA>できる！"
	done

PowerPlantManagerWhoWouldRuinMyGeneratorText:
	text "しょちょう『ゆ　ゆ　ゆるせーん！"

	para "<WATASHI><GA>ながい　じかん　かけた"
	line "はつでんき<WO>こわすなんて！"

	para "とっつかまえたら"
	line "ひっさつ<NO>でんじほうで"
	cont "おしおきだー！！"
	done

PowerPlantManagerIWontForgiveCulpritText:
	text "しょちょう『<WATASHI><WA>ゆるさんぞ！"
	line "はんにん<GA>ないて　あやま<TTE>もな！"
	cont "ぐふっ　ぐふっ　ぐふふっ<⋯>！"
	done

PowerPlantManagerThatsThePartText:
	text "しょちょう『お　お　お　おおっ！！"

	para "それ<WA><WATASHI><NO>かわいい"
	line "はつでんき<NO>ぶひんじゃ　ないか！"
	cont "キミ<GA>みつけて　くれたのか！"
	done

PowerPlantManagerTakeThisTMText:
	text "キミ！！"
	line "ありがとう！"
	cont "かんしゃ<NO>しるしに"
	cont "こ<NO><TM><WO>あげよう！"
	done

PowerPlantManagerTM07IsZapCannonText:
	text "しょちょう『<TM>０７　は"
	line "<WATASHI><NO>ひっさつ　でんじほう！"
	cont "きょうりょくな　わざ　だよ！"

	para "ちょっと　あたりにくい　けど<⋯>"
	line "いりょく<WA>おおきい　のだ！"
	done

PowerPlantManagerMyBelovedGeneratorText:
	text "しょちょう『<WATASHI><NO>はつでんき！"
	line "どんどん　でんき<WO>つくるのだ！"
	done

PowerPlant_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2, 17, ROUTE_10_NORTH, 2
	warp_event  3, 17, ROUTE_10_NORTH, 2

	def_coord_events
	coord_event  5, 12, SCENE_POWERPLANT_GUARD_GETS_PHONE_CALL, PowerPlantGuardPhoneScript

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, PowerPlantBookshelf
	bg_event  1,  1, BGEVENT_READ, PowerPlantBookshelf

	def_object_events
	object_event  4, 14, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PowerPlantOfficerScript, -1
	object_event  2,  9, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PowerPlantGymGuide1Script, -1
	object_event  6, 11, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PowerPlantGymGuide2Script, -1
	object_event  9,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PowerPlantOfficer2Script, -1
	object_event  7,  2, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PowerPlantGymGuide4Script, -1
	object_event 14, 10, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, PowerPlantManager, -1
