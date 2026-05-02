	object_const_def
	const LAKEOFRAGE_LANCE
	const LAKEOFRAGE_GRAMPS
	const LAKEOFRAGE_SUPER_NERD1
	const LAKEOFRAGE_COOLTRAINER_F1
	const LAKEOFRAGE_FISHER1
	const LAKEOFRAGE_FISHER2
	const LAKEOFRAGE_COOLTRAINER_M
	const LAKEOFRAGE_COOLTRAINER_F2
	const LAKEOFRAGE_GYARADOS
	const LAKEOFRAGE_WESLEY
	const LAKEOFRAGE_POKE_BALL1
	const LAKEOFRAGE_POKE_BALL2

LakeOfRage_MapScripts:
	def_scene_scripts
	scene_script LakeOfRageNoop1Scene ; unusable
	scene_script LakeOfRageNoop2Scene ; unusable

	def_callbacks
	callback MAPCALLBACK_NEWMAP, LakeOfRageFlypointCallback
	callback MAPCALLBACK_OBJECTS, LakeOfRageWesleyCallback

LakeOfRageNoop1Scene:
	end

LakeOfRageNoop2Scene:
	end

LakeOfRageFlypointCallback:
	setflag ENGINE_FLYPOINT_LAKE_OF_RAGE
	endcallback

LakeOfRageWesleyCallback:
	readvar VAR_WEEKDAY
	ifequal WEDNESDAY, .WesleyAppears
	disappear LAKEOFRAGE_WESLEY
	endcallback

.WesleyAppears:
	appear LAKEOFRAGE_WESLEY
	endcallback

LakeOfRageLanceScript:
	checkevent EVENT_REFUSED_TO_HELP_LANCE_AT_LAKE_OF_RAGE
	iftrue .AskAgainForHelp
	opentext
	writetext LakeOfRageLanceForcedToEvolveText
	promptbutton
	faceplayer
	writetext LakeOfRageLanceIntroText
	yesorno
	iffalse .RefusedToHelp
.AgreedToHelp:
	writetext LakeOfRageLanceRadioSignalText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	applymovement LAKEOFRAGE_LANCE, LakeOfRageLanceTeleportIntoSkyMovement
	disappear LAKEOFRAGE_LANCE
	clearevent EVENT_MAHOGANY_MART_LANCE_AND_DRAGONITE
	setevent EVENT_DECIDED_TO_HELP_LANCE
	setmapscene MAHOGANY_MART_1F, SCENE_MAHOGANYMART1F_LANCE_UNCOVERS_STAIRS
	end

.RefusedToHelp:
	writetext LakeOfRageLanceRefusedText
	waitbutton
	closetext
	setevent EVENT_REFUSED_TO_HELP_LANCE_AT_LAKE_OF_RAGE
	end

.AskAgainForHelp:
	faceplayer
	opentext
	writetext LakeOfRageLanceAskHelpText
	yesorno
	iffalse .RefusedToHelp
	sjump .AgreedToHelp

RedGyarados:
	opentext
	writetext LakeOfRageGyaradosCryText
	pause 15
	cry GYARADOS
	closetext
	loadwildmon GYARADOS, 30
	loadvar VAR_BATTLETYPE, BATTLETYPE_FORCESHINY
	startbattle
	ifequal LOSE, .NotBeaten
	disappear LAKEOFRAGE_GYARADOS
.NotBeaten:
	reloadmapafterbattle
	opentext
	giveitem RED_SCALE
	waitsfx
	writetext LakeOfRageGotRedScaleText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	setscene 0 ; Lake of Rage does not have a scene variable
	appear LAKEOFRAGE_LANCE
	end

LakeOfRageGrampsScript:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .ClearedRocketHideout
	writetext LakeOfRageGrampsText
	waitbutton
	closetext
	end

.ClearedRocketHideout:
	writetext LakeOfRageGrampsText_ClearedRocketHideout
	waitbutton
	closetext
	end

LakeOfRageSuperNerdScript:
	jumptextfaceplayer LakeOfRageSuperNerdText

LakeOfRageCooltrainerFScript:
	jumptextfaceplayer LakeOfRageCooltrainerFText

LakeOfRageSign:
	jumptext LakeOfRageSignText

MagikarpHouseSignScript:
	opentext
	writetext FishingGurusHouseSignText
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .MagikarpLengthRecord
	waitbutton
	closetext
	end

.MagikarpLengthRecord:
	promptbutton
	special MagikarpHouseSign
	closetext
	end

TrainerFisherAndre:
	trainer FISHER, ANDRE, EVENT_BEAT_FISHER_ANDRE, FisherAndreSeenText, FisherAndreBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FisherAndreAfterBattleText
	waitbutton
	closetext
	end

TrainerFisherRaymond:
	trainer FISHER, RAYMOND, EVENT_BEAT_FISHER_RAYMOND, FisherRaymondSeenText, FisherRaymondBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FisherRaymondAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainermAaron:
	trainer COOLTRAINERM, AARON, EVENT_BEAT_COOLTRAINERM_AARON, CooltrainermAaronSeenText, CooltrainermAaronBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainermAaronAfterBattleText
	waitbutton
	closetext
	end

TrainerCooltrainerfLois:
	trainer COOLTRAINERF, LOIS, EVENT_BEAT_COOLTRAINERF_LOIS, CooltrainerfLoisSeenText, CooltrainerfLoisBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext CooltrainerfLoisAfterBattleText
	waitbutton
	closetext
	end

WesleyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_BLACKBELT_FROM_WESLEY
	iftrue WesleyWednesdayScript
	readvar VAR_WEEKDAY
	ifnotequal WEDNESDAY, WesleyNotWednesdayScript
	checkevent EVENT_MET_WESLEY_OF_WEDNESDAY
	iftrue .MetWesley
	writetext MeetWesleyText
	promptbutton
	setevent EVENT_MET_WESLEY_OF_WEDNESDAY
.MetWesley:
	writetext WesleyGivesGiftText
	promptbutton
	verbosegiveitem BLACKBELT_I
	iffalse WesleyDoneScript
	setevent EVENT_GOT_BLACKBELT_FROM_WESLEY
	writetext WesleyGaveGiftText
	waitbutton
	closetext
	end

WesleyWednesdayScript:
	writetext WesleyWednesdayText
	waitbutton
WesleyDoneScript:
	closetext
	end

WesleyNotWednesdayScript:
	writetext WesleyNotWednesdayText
	waitbutton
	closetext
	end

LakeOfRageMaxEther:
	itemball MAX_ETHER

LakeOfRageTMDetect:
	itemball TM_DETECT

LakeOfRageHiddenFullRestore:
	hiddenitem FULL_RESTORE, EVENT_LAKE_OF_RAGE_HIDDEN_FULL_RESTORE

LakeOfRageHiddenRareCandy:
	hiddenitem RARE_CANDY, EVENT_LAKE_OF_RAGE_HIDDEN_RARE_CANDY

LakeOfRageHiddenMaxPotion:
	hiddenitem MAX_POTION, EVENT_LAKE_OF_RAGE_HIDDEN_MAX_POTION

LakeOfRageLanceTeleportIntoSkyMovement:
	teleport_from
	step_end

LakeOfRageLanceForcedToEvolveText:
	text "こ<NO>みずうみ"
	line "ギャラドス　ばかりだな<⋯>"

	para "やはり　コイキングは"
	line "だれか<NO>しわざで　むりやり"
	cont "しんか　させられてるのか<⋯>"
	done

LakeOfRageLanceIntroText:
	text "きみも　うわさ<WO>ききつけて"
	line "や<TTE>きたのかい？"

	para "そう　<PLAYER>　というのか"
	line "おれ<WA>ワタル"
	cont "きみと　おなじ　<TRAINER>さ"

	para "ここ<NO>うわさ<WO>ききつけ"
	line "しんそう<WO>しらべていたんだが<⋯>"

	para "<PLAYER>くん！"
	line "さっき<NO>たたかい<WO>みれば"
	cont "きみ<GA>そうとうな　じつりょくの"
	cont "<TRAINER>だと　わかる"

	para "よかったら　おれと　いっしょに"
	line "しらべて　くれないか？"
	done

LakeOfRageLanceRadioSignalText:
	text "ワタル『そうか　たすかるよ！"

	para "みずうみ<NO>コイキングは"
	line "チョウジから　ながされている"
	cont "なぞ<NO>でんぱで　むりやり"
	cont "しんか　させられている　ようなんだ"

	para "<PLAYER>くん！"
	line "さき<NI>い<TTE>　ま<TTE>るよ！"
	done

LakeOfRageLanceRefusedText:
	text "そうか<⋯>"
	line "き<GA>かわったら　きてくれよ"
	done

LakeOfRageLanceAskHelpText:
	text "ワタル『ん？"
	line "てつだ<TTE>　くれるのかい？"
	done

LakeOfRageGyaradosCryText:
	text "ギャラドス『ギャシャーッ！！"
	done

LakeOfRageGotRedScaleText:
	text "<PLAYER>は"
	line "あかいウロコ<WO>てにいれ<TA!>"
	done

LakeOfRageGrampsText:
	text "ギャラドス<GA>おいかり　じゃ！"
	line "なんか　よくないこと<GA>おきるんじゃ"
	done

LakeOfRageGrampsText_ClearedRocketHideout:
	text "ほっほ！"
	line "いい　コイキング<GA>つれるんじゃよ"
	done

LakeOfRageSuperNerdText:
	text "<KOKO_WA>むかし　ギャラドスが"
	line "あばれまわ<TTE>　できたんだ<TTE>"

	para "こんかい<NO>たいりょうはっせいと"
	line "なにか　かんけい　あるのかな？"
	done

LakeOfRageCooltrainerFText:
	text "<WATASHI>　みまちがい　かしら"
	line "みずうみ<NO>まんなかに"
	cont "あかい　ギャラドス<GA>いたの<⋯>"

	para "でも　ギャラドス<TTE>"
	line "ふつう　あおいろ　でしょ？"
	done

FisherAndreSeenText:
	text "さっき　つりあげた"
	line "じまん<NO>#で　しょうぶや！"
	done

FisherAndreBeatenText:
	text "つり<WA>１にんまえ　でも"
	line "#<WA>はんにんまえ　か<⋯>"
	done

FisherAndreAfterBattleText:
	text "つり<NO>うでまえなら　まけへんで！"
	line "なんた<TTE>　１にちじゅう"
	cont "#<WO>つっとるからな！"
	done

FisherRaymondSeenText:
	text "どんな<NI>がんば<TTE>も"
	line "おなじ　#しか　つれねーぞ！"
	done

FisherRaymondBeatenText:
	text "<⋯>　つりいと　こんがらがった"
	done

FisherRaymondAfterBattleText:
	text "なんで　いい　#"
	line "つれねーんだよ　もう！"
	done

CooltrainermAaronSeenText:
	text "<TRAINER><WO>みかけたら"
	line "かならず　ちょうせん　する！"
	cont "それ<WA><TRAINER><NO>しゅくめい！"
	done

CooltrainermAaronBeatenText:
	text "ふう<⋯>"
	line "いい　たたかい　だった"
	done

CooltrainermAaronAfterBattleText:
	text "#と　<TRAINER>は"
	line "たたか<TTE>　たたかい　ぬいて"
	cont "じぶん<WO>きたえるんだ！"
	done

CooltrainerfLoisSeenText:
	text "あかい　ギャラドス<WA>どうしたの？"

	para "えっ　もう　いないの？"
	line "そんな　せっかく　きたのに<⋯>"

	para "いいわ　あなた　しょうぶしましょ！"
	done

CooltrainerfLoisBeatenText:
	text "みごとね"
	done

CooltrainerfLoisAfterBattleText:
	text "そういえば　あたし"
	line "ピンク<NO>バタフリー　みたことある！"
	done

MeetWesleyText:
	text "ミズオ『やあ　はじめまして！"

	para "ぼく<WA>すいようび<NO>ミズオ！"
	done

WesleyGivesGiftText:
	text "せっかく　であったんだ"
	line "これ　うけと<TTE>　くれよ！"
	done

WesleyGaveGiftText:
	text "ミズオ『そ<NO>くろおびは"
	line "かくとうタイプ<NO>わざの"
	cont "いりょく<WO>たかめる　どうぐさ！"
	done

WesleyWednesdayText:
	text "ミズオ『ぼく<WO>みつけられたなら"
	line "ほか<NO>ねえさん　たちとは"
	cont "もう　あったんじゃ　ないかい？"

	para "それとも　ラッキー　だったのかな？"
	done

WesleyNotWednesdayText:
	text "ミズオ『きょう<WA>すいようびじゃ"
	line "ないみたいだな！"
	cont "おしいなー"
	done

LakeOfRageSignText:
	text "<KOKO_WA>いかり<NO>みずうみ"
	line "べつめい　ギャラドスこ"
	done

FishingGurusHouseSignText:
	text "つり　めいじん　<NO>いえ"
	done

LakeOfRage_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  3, LAKE_OF_RAGE_HIDDEN_POWER_HOUSE, 1
	warp_event 27, 31, LAKE_OF_RAGE_MAGIKARP_HOUSE, 1

	def_coord_events

	def_bg_events
	bg_event 21, 27, BGEVENT_READ, LakeOfRageSign
	bg_event 25, 31, BGEVENT_READ, MagikarpHouseSignScript
	bg_event 11, 28, BGEVENT_ITEM, LakeOfRageHiddenFullRestore
	bg_event  4,  4, BGEVENT_ITEM, LakeOfRageHiddenRareCandy
	bg_event 35,  5, BGEVENT_ITEM, LakeOfRageHiddenMaxPotion

	def_object_events
	object_event 21, 28, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LakeOfRageLanceScript, EVENT_LAKE_OF_RAGE_LANCE
	object_event 20, 26, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LakeOfRageGrampsScript, -1
	object_event 36, 13, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LakeOfRageSuperNerdScript, -1
	object_event 25, 29, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LakeOfRageCooltrainerFScript, -1
	object_event 30, 23, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerFisherAndre, EVENT_LAKE_OF_RAGE_CIVILIANS
	object_event 24, 26, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerFisherRaymond, EVENT_LAKE_OF_RAGE_CIVILIANS
	object_event  4, 15, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerCooltrainermAaron, EVENT_LAKE_OF_RAGE_CIVILIANS
	object_event 36,  7, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 0, TrainerCooltrainerfLois, EVENT_LAKE_OF_RAGE_CIVILIANS
	object_event 18, 22, SPRITE_GYARADOS, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RedGyarados, EVENT_LAKE_OF_RAGE_RED_GYARADOS
	object_event  4,  4, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, WesleyScript, EVENT_LAKE_OF_RAGE_WESLEY_OF_WEDNESDAY
	object_event  7, 10, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, LakeOfRageMaxEther, EVENT_LAKE_OF_RAGE_MAX_ETHER
	object_event 35,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, LakeOfRageTMDetect, EVENT_LAKE_OF_RAGE_TM_DETECT
