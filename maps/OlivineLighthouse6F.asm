	object_const_def
	const OLIVINELIGHTHOUSE6F_JASMINE
	const OLIVINELIGHTHOUSE6F_MONSTER
	const OLIVINELIGHTHOUSE6F_POKE_BALL

OlivineLighthouse6F_MapScripts:
	def_scene_scripts

	def_callbacks

OlivineLighthouseJasmine:
	faceplayer
	opentext
	checkitem SECRETPOTION
	iftrue .BroughtSecretpotion
	checkevent EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS
	iftrue .ExplainedSickness
	writetext JasmineCianwoodPharmacyText
	promptbutton
	setevent EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS
.ExplainedSickness:
	writetext JasmineGetSomeMedicineText
	waitbutton
	closetext
	end

.BroughtSecretpotion:
	writetext JasmineCureAmphyText
	yesorno
	iffalse .Refused
	writetext PlayerHandedSecretpotionText
	promptbutton
	takeitem SECRETPOTION
	writetext JasmineDontBeOffendedText
	waitbutton
	closetext
	turnobject OLIVINELIGHTHOUSE6F_JASMINE, RIGHT
	pause 15
	turnobject OLIVINELIGHTHOUSE6F_MONSTER, LEFT
	opentext
	playmusic MUSIC_HEAL
	writetext JasmineAmphyHowAreYouFeelingText
	pause 60
	promptbutton
	closetext
	special RestartMapMusic
	cry AMPHAROS
	special FadeOutToWhite
	pause 10
	special FadeInFromWhite
	opentext
	writetext AmphyPaluPaluluText
	waitbutton
	closetext
	turnobject OLIVINELIGHTHOUSE6F_MONSTER, RIGHT
	pause 10
	turnobject OLIVINELIGHTHOUSE6F_MONSTER, LEFT
	pause 10
	turnobject OLIVINELIGHTHOUSE6F_MONSTER, RIGHT
	pause 10
	turnobject OLIVINELIGHTHOUSE6F_MONSTER, LEFT
	pause 10
	faceplayer
	opentext
	writetext JasmineThankYouText
	waitbutton
	closetext
	setevent EVENT_JASMINE_RETURNED_TO_GYM
	clearevent EVENT_OLIVINE_GYM_JASMINE
	readvar VAR_FACING
	ifequal DOWN, .FacingDown
	ifequal RIGHT, .FacingRight
	applymovement OLIVINELIGHTHOUSE6F_JASMINE, OlivineLighthouseJasmineLeavesUpMovement
	disappear OLIVINELIGHTHOUSE6F_JASMINE
	end

.FacingDown:
	applymovement OLIVINELIGHTHOUSE6F_JASMINE, OlivineLighthouseJasmineLeavesDownMovement
	disappear OLIVINELIGHTHOUSE6F_JASMINE
	end

.FacingRight:
	applymovement OLIVINELIGHTHOUSE6F_JASMINE, OlivineLighthouseJasmineLeavesRightMovement
	disappear OLIVINELIGHTHOUSE6F_JASMINE
	end

.Refused:
	writetext JasmineISeeText
	waitbutton
	closetext
	turnobject OLIVINELIGHTHOUSE6F_JASMINE, RIGHT
	pause 15
	turnobject OLIVINELIGHTHOUSE6F_MONSTER, LEFT
	opentext
	writetext JasmineAmphyHangOnText
	waitbutton
	closetext
	end

.Unused: ; unreferenced
	end

OlivineLighthouseAmphy:
	faceplayer
	opentext
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue .HealthyNow
	writetext AmphyPalPalooText
	setval AMPHAROS
	special PlaySlowCry
	promptbutton
	writetext AmphyBreathingLaboredText
	waitbutton
	closetext
	end

.HealthyNow:
	writetext AmphyPaluPaluluText
	cry AMPHAROS
	waitbutton
	closetext
	special FadeOutToWhite
	special FadeInFromWhite
	special FadeOutToWhite
	special FadeInFromWhite
	end

OlivineLighthouse6FSuperPotion:
	itemball SUPER_POTION

OlivineLighthouseJasmineLeavesUpMovement:
	slow_step UP
	slow_step UP
	slow_step RIGHT
	slow_step UP
	slow_step UP
	step_sleep 8
	step_sleep 8
	step_end

OlivineLighthouseJasmineLeavesDownMovement:
	slow_step DOWN
	slow_step RIGHT
	slow_step RIGHT
	slow_step RIGHT
	slow_step UP
	slow_step RIGHT
	slow_step RIGHT
	slow_step RIGHT
	step_end

OlivineLighthouseJasmineLeavesRightMovement:
	slow_step UP
	slow_step UP
	slow_step RIGHT
	slow_step UP
	slow_step UP
	slow_step UP
	step_sleep 8
	step_end

JasmineCianwoodPharmacyText:
	text "ミカン『<⋯>　こ<NO>#　いつも"
	line "うみ<WO>てらして　くれてたの"

	para "<⋯>　でも　"
	line "いきなり　ぐったり　して"
	cont "いきも　たえだえ<⋯>"

	para "<⋯>　うみのむこう　タンバには"
	line "すごい　くすりやさんが"
	cont "いるそうですけど<⋯>"

	para "<WATASHI>　アカリちゃん<NO>そばを"
	line "はなれる　わけに<WA>いかないし<⋯>"
	done

JasmineGetSomeMedicineText:
	text "<⋯>　あ　あのう　おねがいです"
	line "<WATASHI><NO>かわり<NI>くすりを"
	cont "もら<TTE>きて　いただけませんか？"
	done

JasmineCureAmphyText:
	text "ミカン『<⋯>　そ<NO>くすりで"
	line "アカリちゃん　なおせる<NO>ですか？"
	done

PlayerHandedSecretpotionText:
	text "<PLAYER><WA>ミカンに"
	line "ひでんのくすり<WO><WATASHI>た"
	done

JasmineDontBeOffendedText:
	text "ミカン『<⋯>　あ　あの"
	line "き<WO>わるく　しないでくださいね"

	para "<⋯>　アカリちゃん"
	line "<WATASHI>いがい<NO>ひと　から"
	cont "もの<WO>うけとらないから"
	done

JasmineAmphyHowAreYouFeelingText:
	text "ミカン『<⋯>　<⋯>　<⋯>"

	para "アカリちゃん　ぐあい<WA>どう？"
	done

JasmineThankYouText:
	text "ミカン『<⋯>　ああ　よかった"
	line "ほんと<NI>よかったです"

	para "ありがとう　ございます"
	line "あなた<NO>おかげ　です"

	para "<⋯>　で<WA><WATASHI>"
	line "ジム<NI>もどります"
	done

JasmineISeeText:
	text "ミカン『<⋯>　そう　ですか"
	done

JasmineAmphyHangOnText:
	text "<⋯>　アカリちゃん　がんば<TTE>！"
	done

AmphyPalPalooText:
	text "アカリちゃん『<⋯>　<⋯>　<⋯>"
	line "<⋯>　ぱ<⋯>　ぱるう"
	done

AmphyBreathingLaboredText:
	text "いき<WO>するのも　くるしそう"
	done

AmphyPaluPaluluText:
	text "アカリちゃん『パルッ！　パルルッ！"
	done

OlivineLighthouse6F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 15, OLIVINE_LIGHTHOUSE_5F, 1
	warp_event 16,  5, OLIVINE_LIGHTHOUSE_5F, 6
	warp_event 17,  5, OLIVINE_LIGHTHOUSE_5F, 7

	def_coord_events

	def_bg_events

	def_object_events
	object_event  8,  8, SPRITE_JASMINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OlivineLighthouseJasmine, EVENT_OLIVINE_LIGHTHOUSE_JASMINE
	object_event  9,  8, SPRITE_MONSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, OlivineLighthouseAmphy, -1
	object_event  3,  4, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, OlivineLighthouse6FSuperPotion, EVENT_OLIVINE_LIGHTHOUSE_6F_SUPER_POTION
