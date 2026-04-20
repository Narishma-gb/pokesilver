	object_const_def
	const SAFFRONMAGNETTRAINSTATION_OFFICER
	const SAFFRONMAGNETTRAINSTATION_GYM_GUIDE
	const SAFFRONMAGNETTRAINSTATION_TEACHER
	const SAFFRONMAGNETTRAINSTATION_LASS

SaffronMagnetTrainStation_MapScripts:
	def_scene_scripts
	scene_script SaffronMagnetTrainStationNoopScene, SCENE_SAFFRONMAGNETTRAINSTATION_ARRIVE_FROM_GOLDENROD

	def_callbacks

SaffronMagnetTrainStationNoopScene:
	end

SaffronMagnetTrainStationOfficerScript:
	faceplayer
	opentext
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .MagnetTrainToGoldenrod
	writetext SaffronMagnetTrainStationOfficerTrainIsntOperatingText
	waitbutton
	closetext
	end

.MagnetTrainToGoldenrod:
	writetext SaffronMagnetTrainStationOfficerAreYouComingOnBoardText
	yesorno
	iffalse .DecidedNotToRide
	checkitem PASS
	iffalse .PassNotInBag
	writetext SaffronMagnetTrainStationOfficerRightThisWayText
	waitbutton
	closetext
	applymovement SAFFRONMAGNETTRAINSTATION_OFFICER, SaffronMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, SaffronMagnetTrainStationPlayerApproachAndEnterTrainMovement
	setval TRUE
	special MagnetTrain
	warpcheck
	newloadmap MAPSETUP_TRAIN
	end

.PassNotInBag:
	writetext SaffronMagnetTrainStationOfficerYouDontHaveAPassText
	waitbutton
	closetext
	end

.DecidedNotToRide:
	writetext SaffronMagnetTrainStationOfficerHopeToSeeYouAgainText
	waitbutton
	closetext
	end

Script_ArriveFromGoldenrod:
	applymovement SAFFRONMAGNETTRAINSTATION_OFFICER, SaffronMagnetTrainStationOfficerApproachTrainDoorMovement
	applymovement PLAYER, SaffronMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement
	applymovement SAFFRONMAGNETTRAINSTATION_OFFICER, SaffronMagnetTrainStationOfficerReturnToBoardingGateMovement
	opentext
	writetext SaffronMagnetTrainStationOfficerArrivedInSaffronText
	waitbutton
	closetext
	end

SaffronMagnetTrainStationGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext SaffronMagnetTrainStationGymGuideText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext SaffronMagnetTrainStationGymGuideText_ReturnedMachinePart
	waitbutton
	closetext
	end

SaffronMagnetTrainStationTeacherScript:
	jumptextfaceplayer SaffronMagnetTrainStationTeacherText

SaffronMagnetTrainStationLassScript:
	jumptextfaceplayer SaffronMagnetTrainStationLassText

SaffronMagnetTrainStationOfficerApproachTrainDoorMovement:
	step UP
	step UP
	step RIGHT
	turn_head LEFT
	step_end

SaffronMagnetTrainStationOfficerReturnToBoardingGateMovement:
	step LEFT
	step DOWN
	step DOWN
	step_end

SaffronMagnetTrainStationPlayerApproachAndEnterTrainMovement:
	step UP
	step UP
	step UP
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step_end

SaffronMagnetTrainStationPlayerLeaveTrainAndEnterStationMovement:
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	turn_head UP
	step_end

SaffronMagnetTrainStationOfficerTrainIsntOperatingText:
	text "もうしわけ　ありません"
	line "リニア　モーターカーは"
	cont "げんざい　うんこうして　いません"
	done

SaffronMagnetTrainStationOfficerAreYouComingOnBoardText:
	text "コガネ　いき"
	line "まもなく　しゅっぱつ　です"
	cont "おのり<NI>なられますか？"
	done

SaffronMagnetTrainStationOfficerRightThisWayText:
	text "じょうしゃけん<WO>かくにん　します！"

	para "はい！"
	line "こちら<NI>どうぞ！"
	done

SaffronMagnetTrainStationOfficerYouDontHaveAPassText:
	text "あっと　おきゃくさん"
	line "じょうしゃけん<WO>おもちでないですね"
	done

SaffronMagnetTrainStationOfficerHopeToSeeYouAgainText:
	text "また<NO>ごりようを"
	line "よろしく　おねがい　しまーす！"
	done

SaffronMagnetTrainStationOfficerArrivedInSaffronText:
	text "おつかれさま　でした"
	line "ヤマブキ　とうちゃくです"

	para "また<NO>ごりようを"
	line "よろしく　おねがい　しまーす！"
	done

SaffronMagnetTrainStationGymGuideText:
	text "リニア　モーターカーは"
	line "でんきと　じしゃく<NO>ちからで"
	cont "はしる　ゆめ<NO>ちょうとっきゅう！"

	para "でも　でんき<GA>なければ<⋯>"
	done

SaffronMagnetTrainStationGymGuideText_ReturnedMachinePart:
	text "ふうー<⋯>"

	para "カントーと　ジョウトを"
	line "なんおうふく　したのかな？"
	done

SaffronMagnetTrainStationTeacherText:
	text "リニアのえき<GA>できる　まえ"
	line "こ<NO>ばしょに<WA>モノマネむすめ<TTE>"
	cont "おんなのこ<NO>いえ<GA>あったのよ"
	done

SaffronMagnetTrainStationLassText:
	text "おにいちゃん　ていきけん　も<TTE>る？"
	line "あたし　も<TTE>るよー！"

	para "ヤマブキ<NO>ひと<WA>みんな"
	line "ていきけんで"
	cont "リニア<NI>のるんだもーん！"
	done

SaffronMagnetTrainStation_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  8, 17, SAFFRON_CITY, 6
	warp_event  9, 17, SAFFRON_CITY, 6
	warp_event  6,  5, GOLDENROD_MAGNET_TRAIN_STATION, 4
	warp_event 11,  5, GOLDENROD_MAGNET_TRAIN_STATION, 3

	def_coord_events
	coord_event 11,  6, SCENE_SAFFRONMAGNETTRAINSTATION_ARRIVE_FROM_GOLDENROD, Script_ArriveFromGoldenrod

	def_bg_events

	def_object_events
	object_event  9,  9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SaffronMagnetTrainStationOfficerScript, -1
	object_event 10, 14, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SaffronMagnetTrainStationGymGuideScript, -1
	object_event  6, 11, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SaffronMagnetTrainStationTeacherScript, EVENT_SAFFRON_TRAIN_STATION_POPULATION
	object_event  6, 10, SPRITE_LASS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, SaffronMagnetTrainStationLassScript, EVENT_SAFFRON_TRAIN_STATION_POPULATION
