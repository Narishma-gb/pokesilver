	object_const_def
	const SAFFRONGYM_SABRINA
	const SAFFRONGYM_GRANNY1
	const SAFFRONGYM_YOUNGSTER1
	const SAFFRONGYM_GRANNY2
	const SAFFRONGYM_YOUNGSTER2
	const SAFFRONGYM_GYM_GUIDE

SaffronGym_MapScripts:
	def_scene_scripts

	def_callbacks

SaffronGymSabrinaScript:
	faceplayer
	opentext
	checkflag ENGINE_MARSHBADGE
	iftrue .FightDone
	writetext SabrinaIntroText
	waitbutton
	closetext
	winlosstext SabrinaWinLossText, 0
	loadtrainer SABRINA, SABRINA1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_SABRINA
	setevent EVENT_BEAT_MEDIUM_REBECCA
	setevent EVENT_BEAT_MEDIUM_DORIS
	setevent EVENT_BEAT_PSYCHIC_FRANKLIN
	setevent EVENT_BEAT_PSYCHIC_JARED
	opentext
	writetext ReceivedMarshBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_MARSHBADGE
	writetext SabrinaMarshBadgeText
	waitbutton
	closetext
	end

.FightDone:
	writetext SabrinaFightDoneText
	waitbutton
	closetext
	end

TrainerMediumRebecca:
	trainer MEDIUM, REBECCA, EVENT_BEAT_MEDIUM_REBECCA, MediumRebeccaSeenText, MediumRebeccaBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext MediumRebeccaAfterBattleText
	waitbutton
	closetext
	end

TrainerPsychicFranklin:
	trainer PSYCHIC_T, FRANKLIN, EVENT_BEAT_PSYCHIC_FRANKLIN, PsychicFranklinSeenText, PsychicFranklinBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PsychicFranklinAfterBattleText
	waitbutton
	closetext
	end

TrainerMediumDoris:
	trainer MEDIUM, DORIS, EVENT_BEAT_MEDIUM_DORIS, MediumDorisSeenText, MediumDorisBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext MediumDorisAfterBattleText
	waitbutton
	closetext
	end

TrainerPsychicJared:
	trainer PSYCHIC_T, JARED, EVENT_BEAT_PSYCHIC_JARED, PsychicJaredSeenText, PsychicJaredBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PsychicJaredAfterBattleText
	waitbutton
	closetext
	end

SaffronGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_SABRINA
	iftrue .SaffronGymGuideWinScript
	writetext SaffronGymGuideText
	waitbutton
	closetext
	end

.SaffronGymGuideWinScript:
	writetext SaffronGymGuideWinText
	waitbutton
	closetext
	end

SaffronGymStatue:
	checkflag ENGINE_MARSHBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, SABRINA, SABRINA1
	jumpstd GymStatue2Script

SabrinaIntroText:
	text "ナツメ『<⋯>　やっぱり　きたわね！"

	para "あなた<GA>くる　よかんは"
	line "３ねんまえ　から　あったのよ"

	para "あなた<NO>もくてきは"
	line "ズバリ　<WATASHI><NO>もつ　バッジ！"

	para "<WATASHI>　たたかいは"
	line "すきじゃ　ないけど<⋯>"
	cont "バッジ<WO>ふさわしい　あいてに"
	cont "わたすこと<GA>リーダー<NO>つとめ"

	para "あなた<GA>のぞむ<NO>なら"
	line "<WATASHI><NO>エスパー　のうりょく"
	cont "みせて　あげるわ！"
	done

SabrinaWinLossText:
	text "ナツメ『こ<NO>つよさ<⋯>！"
	line "よそく　いじょう　だわ<⋯>！"
	cont "かんぜんな　みらい　よちは"
	cont "できないのかも<⋯>"

	para "わかったわ　<WATASHI>の"
	line "ゴールドバッジを"
	cont "あなた<NI>さしあげ　ましょう"
	done

ReceivedMarshBadgeText:
	text "<PLAYER>は"
	line "ゴールドバッジ<WO>もらっ<TA!>"
	done

SabrinaMarshBadgeText:
	text "ナツメ『そ<NO>ゴールドバッジは"
	line "あなた<NO>せんざいてき　ちからを"
	cont "ひきだして　くれる　もの<⋯>"

	para "あなた<NO>つよさを"
	line "せいかく<NI>よち　できなかったけど"
	cont "これだけ<WA>はっきり　わかる<⋯>"

	para "あなた<NO>みらい<WA>あかるい"
	line "すばらしい　チャンピオン　として"
	cont "みんな<NI>かんげい　されるわ！"
	done

SabrinaFightDoneText:
	text "ナツメ『<⋯>あなたの"
	line "#へ<NO>あいじょうが"
	cont "<WATASHI><NO>ちょうのうりょくに"
	cont "まさった　ようね<⋯>"

	para "そ<NO>あいじょう<NO>ちからも"
	line "ちょうのうりょく<NO>ひとつ"
	cont "<WATASHI>　そう　おもうの<⋯>"
	done

MediumRebeccaSeenText:
	text "おぬし<GA>たおしてきた"
	line "も<NO>たち<NO>ちからが"
	cont "<WATASHI><NO>からだ<NI>ながれこむ！"
	done

MediumRebeccaBeatenText:
	text "つよい　つよすぎる！"
	done

MediumRebeccaAfterBattleText:
	text "おぬし<NO>ちから<NO>みなもとは"
	line "なんなのじゃー！"
	done

PsychicFranklinSeenText:
	text "ちょうのうりょくは"
	line "こころ<NO>ちから！"
	done

PsychicFranklinBeatenText:
	text "こころ<NO>つよさで"
	line "まけたーっ！"
	done

PsychicFranklinAfterBattleText:
	text "わざ　だけでなく"
	line "こころも　きたえられている！"
	done

MediumDorisSeenText:
	text "ふふふ<⋯>"
	line "みえる　みえるぞ<⋯>！"

	para "おぬし<NO>こころのなか"
	line "はっきりと　みえるのじゃ！"
	done

MediumDorisBeatenText:
	text "てのうち　わか<TTE>も"
	line "まけ<WA>まけーっ！"
	done

MediumDorisAfterBattleText:
	text "しまっ<TA!>"
	line "おぬし<NI>まけること"
	cont "よち　していたのに"
	cont "わすれていたっ！"
	done

PsychicJaredSeenText:
	text "となり<NO>かくとう　どうじょうは"
	line "かつて<WA>こ<NO>まちの"
	cont "ジム　だったのだ！"
	done

PsychicJaredBeatenText:
	text "かなわぬ<⋯>"
	done

PsychicJaredAfterBattleText:
	text "どうじょう<NO>しはん"
	line "カラテ　だいおうも"

	para "ナツメさん<NI>こてんぱんに"
	line "やられたのさ！"
	done

SaffronGymGuideText:
	text "おーす！"
	line "みらい<NO>チャンピオン！"

	para "あんた　ほど<NO><TRAINER>なら"
	line "エスパー　タイプ<NO>こうりゃくほうは"
	cont "もちろん　し<TTE>るよな！"

	para "きたい　してるぜ！"
	line "グッド　ラック！"
	done

SaffronGymGuideWinText:
	text "すばらしい　たたかい　だったぜ！"
	done

SaffronGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  8, 17, SAFFRON_CITY, 2
	warp_event  9, 17, SAFFRON_CITY, 2
	warp_event 11, 15, SAFFRON_GYM, 18
	warp_event 19, 15, SAFFRON_GYM, 19
	warp_event 19, 11, SAFFRON_GYM, 20
	warp_event  1, 11, SAFFRON_GYM, 21
	warp_event  5,  3, SAFFRON_GYM, 22
	warp_event 11,  5, SAFFRON_GYM, 23
	warp_event  1, 15, SAFFRON_GYM, 24
	warp_event 19,  3, SAFFRON_GYM, 25
	warp_event 15, 17, SAFFRON_GYM, 26
	warp_event  5, 17, SAFFRON_GYM, 27
	warp_event  5,  9, SAFFRON_GYM, 28
	warp_event  9,  3, SAFFRON_GYM, 29
	warp_event 15,  9, SAFFRON_GYM, 30
	warp_event 15,  5, SAFFRON_GYM, 31
	warp_event  1,  5, SAFFRON_GYM, 32
	warp_event 19, 17, SAFFRON_GYM, 3
	warp_event 19,  9, SAFFRON_GYM, 4
	warp_event  1,  9, SAFFRON_GYM, 5
	warp_event  5,  5, SAFFRON_GYM, 6
	warp_event 11,  3, SAFFRON_GYM, 7
	warp_event  1, 17, SAFFRON_GYM, 8
	warp_event 19,  5, SAFFRON_GYM, 9
	warp_event 15, 15, SAFFRON_GYM, 10
	warp_event  5, 15, SAFFRON_GYM, 11
	warp_event  5, 11, SAFFRON_GYM, 12
	warp_event  9,  5, SAFFRON_GYM, 13
	warp_event 15, 11, SAFFRON_GYM, 14
	warp_event 15,  3, SAFFRON_GYM, 15
	warp_event  1,  3, SAFFRON_GYM, 16
	warp_event 11,  9, SAFFRON_GYM, 17

	def_coord_events

	def_bg_events
	bg_event  8, 15, BGEVENT_READ, SaffronGymStatue

	def_object_events
	object_event  9,  8, SPRITE_SABRINA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, SaffronGymSabrinaScript, -1
	object_event 17, 16, SPRITE_GRANNY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerMediumRebecca, -1
	object_event  3, 16, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPsychicFranklin, -1
	object_event  3,  4, SPRITE_GRANNY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerMediumDoris, -1
	object_event 17,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerPsychicJared, -1
	object_event  9, 14, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SaffronGymGuideScript, -1
