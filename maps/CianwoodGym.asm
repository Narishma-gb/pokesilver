	object_const_def
	const CIANWOODGYM_CHUCK
	const CIANWOODGYM_BLACK_BELT1
	const CIANWOODGYM_BLACK_BELT2
	const CIANWOODGYM_BLACK_BELT3
	const CIANWOODGYM_BLACK_BELT4
	const CIANWOODGYM_BOULDER1
	const CIANWOODGYM_BOULDER2
	const CIANWOODGYM_BOULDER3
	const CIANWOODGYM_BOULDER4

CianwoodGym_MapScripts:
	def_scene_scripts

	def_callbacks

CianwoodGymChuckScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_CHUCK
	iftrue .FightDone
	writetext ChuckIntroText1
	waitbutton
	closetext
	turnobject CIANWOODGYM_CHUCK, RIGHT
	opentext
	writetext ChuckIntroText2
	closetext
	applymovement CIANWOODGYM_BOULDER1, CianwoodGymMovement_ChuckChucksBoulder
	playsound SFX_STRENGTH
	earthquake 80
	disappear CIANWOODGYM_BOULDER1
	pause 30
	faceplayer
	opentext
	writetext ChuckIntroText3
	waitbutton
	closetext
	winlosstext ChuckLossText, 0
	loadtrainer CHUCK, CHUCK1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_CHUCK
	opentext
	writetext GetStormBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_STORMBADGE
	readvar VAR_BADGES
	scall CianwoodGymActivateRockets
.FightDone:
	checkevent EVENT_GOT_TM01_DYNAMICPUNCH
	iftrue .AlreadyGotTM
	setevent EVENT_BEAT_BLACKBELT_YOSHI
	setevent EVENT_BEAT_BLACKBELT_LAO
	setevent EVENT_BEAT_BLACKBELT_NOB
	setevent EVENT_BEAT_BLACKBELT_LUNG
	writetext ChuckExplainBadgeText
	promptbutton
	verbosegiveitem TM_DYNAMICPUNCH
	iffalse .BagFull
	setevent EVENT_GOT_TM01_DYNAMICPUNCH
	writetext ChuckExplainTMText
	waitbutton
	closetext
	end

.AlreadyGotTM:
	writetext ChuckAfterText
	waitbutton
.BagFull:
	closetext
	end

CianwoodGymActivateRockets:
	ifequal 7, .RadioTowerRockets
	ifequal 6, .GoldenrodRockets
	end

.GoldenrodRockets:
	jumpstd GoldenrodRocketsScript

.RadioTowerRockets:
	jumpstd RadioTowerRocketsScript

TrainerBlackbeltYoshi:
	trainer BLACKBELT_T, YOSHI, EVENT_BEAT_BLACKBELT_YOSHI, BlackbeltYoshiSeenText, BlackbeltYoshiBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BlackbeltYoshiAfterText
	waitbutton
	closetext
	end

TrainerBlackbeltLao:
	trainer BLACKBELT_T, LAO, EVENT_BEAT_BLACKBELT_LAO, BlackbeltLaoSeenText, BlackbeltLaoBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BlackbeltLaoAfterText
	waitbutton
	closetext
	end

TrainerBlackbeltNob:
	trainer BLACKBELT_T, NOB, EVENT_BEAT_BLACKBELT_NOB, BlackbeltNobSeenText, BlackbeltNobBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BlackbeltNobAfterText
	waitbutton
	closetext
	end

TrainerBlackbeltLung:
	trainer BLACKBELT_T, LUNG, EVENT_BEAT_BLACKBELT_LUNG, BlackbeltLungSeenText, BlackbeltLungBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BlackbeltLungAfterText
	waitbutton
	closetext
	end

CianwoodGymBoulder:
	jumpstd StrengthBoulderScript

CianwoodGymStatue:
	checkflag ENGINE_STORMBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, CHUCK, CHUCK1
	jumpstd GymStatue2Script

CianwoodGymMovement_ChuckChucksBoulder:
	set_sliding
	big_step LEFT
	big_step UP
	fast_jump_step RIGHT
	remove_sliding
	step_end

ChuckIntroText1:
	text "おっしゃ！"
	line "ここまで　きたかーっ！"
	cont "いっとく<GA>わし<WA>つよいぞ！"

	para "きたえた　#は"
	line "いわ<WO>くだき"
	cont "ホネをも　こなみじん　にする！"

	para "ちょっと　みておれ"
	done

ChuckIntroText2:
	text "シジマ『ううー"
	line "<⋯>　<⋯>　<⋯>"

	para "どりゃああ！！"
	done

ChuckIntroText3:
	text "どうだ！　おじけづいたろ！"

	para "な<NI>#と<WA>かんけい　ない？"
	line "それも　そうだ！"
	cont "で<WA>しょうぶと　いくかあ！"
	done

ChuckLossText:
	text "おりょ？"
	line "わし<GA>まけるとは<⋯>"

	para "こりゃ　まいっ<TA!>"
	line "よーしっ！　こ<NO>ショックバッジは"
	cont "おまえ<NI>ふさわしい！"
	done

GetStormBadgeText:
	text "<PLAYER><WA>シジマから"
	line "ショックバッジ<WO>もらっ<TA!>"
	done

ChuckExplainBadgeText:
	text "ショックバッジ<GA>あれば"
	line "ひとから　もらった　#でも"
	cont "レベル７０までなら　いうことをきく"

	para "#<NO>わざで　そらをとべる！"

	para "うむっ　ついでだ"
	line "こいつも　も<TTE>け！"
	done

ChuckExplainTMText:
	text "<TM>０１<NO>なかみは"
	line "ばくれつパンチ！！"

	para "あたるかどうか　いちか　ばちか　だが"
	line "あたれば　ぜったいに"
	cont "こんらん　させるほどの"
	cont "いちげき<WO>おみまい　するぞ！"
	done

ChuckAfterText:
	text "わはは！"
	line "わし　たのしかったよ！"

	para "でも　まけ<WA>まけ　だからなあ"
	line "あしたから　２４じかん　とっくんだ！"
	done

BlackbeltYoshiSeenText:
	text "わしと　#は"
	line "あつい　ゆうじょうで　むすばれとる！"
	cont "だれにも　やぶること<WA>できんぞ！"
	done

BlackbeltYoshiBeatenText:
	text "ほんと　かー！？"
	done

BlackbeltYoshiAfterText:
	text "おまえと　#も　なかなか"
	line "つよい　むすびつき<NO>ようだな！"
	done

BlackbeltLaoSeenText:
	text "おれたち　かくとうかに"
	line "こわいも<NO>なんて　ないぞ！"
	done

BlackbeltLaoBeatenText:
	text "ががーん！"
	done

BlackbeltLaoAfterText:
	text "かくとう　#は"
	line "ちょうのうりょく<GA>こわいんだよな"
	done

BlackbeltNobSeenText:
	text "はだか　いっかん！"
	line "ことば<WA>いらない"
	cont "こぶしで　かたろう！"
	done

BlackbeltNobBeatenText:
	text "<⋯>　<⋯>　<⋯>"
	done

BlackbeltNobAfterText:
	text "まけたら　はなすこと<WA>ない！"
	done

BlackbeltLungSeenText:
	text "うなる　こぶしで　おまえ<NO>"
	line "#<WO>こなごな<NI>してやろう！"
	done

BlackbeltLungBeatenText:
	text "こ　こなごな　だ<⋯>"
	done

BlackbeltLungAfterText:
	text "じまん<NO>#<GA>まけるなんて"
	line "プライド　こなごな　だな<⋯>"
	done

CianwoodGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, CIANWOOD_CITY, 2
	warp_event  5, 17, CIANWOOD_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, CianwoodGymStatue
	bg_event  6, 15, BGEVENT_READ, CianwoodGymStatue

	def_object_events
	object_event  4,  1, SPRITE_CHUCK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CianwoodGymChuckScript, -1
	object_event  2, 12, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBlackbeltYoshi, -1
	object_event  7, 12, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBlackbeltLao, -1
	object_event  3,  9, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerBlackbeltNob, -1
	object_event  5,  5, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 1, TrainerBlackbeltLung, -1
	object_event  5,  1, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodGymBoulder, -1
	object_event  3,  7, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodGymBoulder, -1
	object_event  4,  7, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodGymBoulder, -1
	object_event  5,  7, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodGymBoulder, -1
