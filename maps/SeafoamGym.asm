	object_const_def
	const SEAFOAMGYM_BLAINE
	const SEAFOAMGYM_GYM_GUIDE

SeafoamGym_MapScripts:
	def_scene_scripts
	scene_script SeafoamGymNoopScene ; unusable

	def_callbacks

SeafoamGymNoopScene:
	end

SeafoamGymBlaineScript:
	faceplayer
	opentext
	checkflag ENGINE_VOLCANOBADGE
	iftrue .FightDone
	writetext BlaineIntroText
	waitbutton
	closetext
	winlosstext BlaineWinLossText, 0
	loadtrainer BLAINE, BLAINE1
	startbattle
	iftrue .ReturnAfterBattle
	appear SEAFOAMGYM_GYM_GUIDE
.ReturnAfterBattle:
	reloadmapafterbattle
	setevent EVENT_BEAT_BLAINE
	opentext
	writetext ReceivedVolcanoBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_VOLCANOBADGE
	writetext BlaineAfterBattleText
	waitbutton
	closetext
	end

.FightDone:
	writetext BlaineFightDoneText
	waitbutton
	closetext
	end

SeafoamGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_SEAFOAM_GYM_GUIDE_ONCE
	iftrue .TalkedToSeafoamGymGuideScript
	writetext SeafoamGymGuideWinText
	waitbutton
	closetext
	setevent EVENT_TALKED_TO_SEAFOAM_GYM_GUIDE_ONCE
	end

.TalkedToSeafoamGymGuideScript:
	writetext SeafoamGymGuideWinText2
	waitbutton
	closetext
	end

BlaineIntroText:
	text "カツラ『うおおーいっ！"

	para "グレン<NI>あった　わし<NO>ジムが"
	line "きえて　なくなっ<TA!>"

	para "ほのお　#<WO>あやつる"
	line "わし<NO>ジムが"
	cont "かざん<NI>やかれて　しまっ<TA!>"

	para "うおおーいっ！"

	para "だ<GA>わし<WA>こ<NO>どうくつで"
	line "リーダー<NO>つとめ<WO>はたしている！"

	para "みごと　わし<NI>かてれば"
	line "バッジ<WO>わたそう！"

	para "うおおーす！"
	line "やけどなおし<NO>ようい<WA>いいか！"
	done

BlaineWinLossText:
	text "カツラ『み　<⋯>　みごと！"
	line "わし<WA>もえつきた<⋯>！"

	para "クリムゾンバッジ<WO>うけと<TTE>くれ！"
	done

ReceivedVolcanoBadgeText:
	text "<PLAYER><WA>カツラから"
	line "クリムゾンバッジ<WO>もらっ<TA!>"
	done

BlaineAfterBattleText:
	text "カツラ『こんかい<WA>わし<NO>まけだが"
	line "グレン　ジム<WO>つくり　なおして"
	cont "つぎこそ<WA>かつ！"
	cont "いつか　また　たたかおう！"
	done

BlaineFightDoneText:
	text "カツラ『わし<NO>ほのお　#を"
	line "パワーアップ　させるぞ！"
	done

SeafoamGymGuideWinText:
	text "おーす！"

	para "<⋯>　あれ？"
	line "おわっちゃった　みたいだなあ"

	para "スマン　スマン！"
	line "グレン<NI>ジム<GA>なく<TTE>さあ"
	cont "さがしたよ　オレっち！"

	para "まあ　オレ<NO>アドバイス　なくても"
	line "あんた　つよそう　だからねえー"
	cont "かてる<TTE>　しんじてたよ！"
	done

SeafoamGymGuideWinText2:
	text "ジムリーダー<GA>いれば"
	line "そこ<GA>#ジム！"
	cont "たても<NO>なんか　かんけい　ないさ"
	done

SeafoamGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5,  5, ROUTE_20, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_BLAINE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, SeafoamGymBlaineScript, -1
	object_event  6,  5, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SeafoamGymGuideScript, EVENT_SEAFOAM_GYM_GYM_GUIDE
