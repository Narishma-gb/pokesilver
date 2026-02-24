	object_const_def
	const ELMSLAB_ELM
	const ELMSLAB_ELMS_AIDE
	const ELMSLAB_POKE_BALL1
	const ELMSLAB_POKE_BALL2
	const ELMSLAB_POKE_BALL3
	const ELMSLAB_OFFICER

ElmsLab_MapScripts:
	def_scene_scripts
	scene_script ElmsLabMeetElmScene, SCENE_ELMSLAB_MEET_ELM
	scene_script ElmsLabNoop1Scene,   SCENE_ELMSLAB_CANT_LEAVE
	scene_script ElmsLabNoop2Scene,   SCENE_ELMSLAB_NOOP
	scene_script ElmsLabNoop3Scene,   SCENE_ELMSLAB_MEET_OFFICER
	scene_script ElmsLabNoop4Scene,   SCENE_ELMSLAB_UNUSED
	scene_script ElmsLabNoop5Scene,   SCENE_ELMSLAB_AIDE_GIVES_POTION
	scene_const SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS

	def_callbacks

ElmsLabMeetElmScene:
	sdefer ElmsLabWalkUpToElmScript
	end

ElmsLabNoop1Scene:
	end

ElmsLabNoop2Scene:
	end

ElmsLabNoop3Scene:
	end

ElmsLabNoop4Scene:
	end

ElmsLabNoop5Scene:
	end

ElmsLabWalkUpToElmScript:
	applymovement PLAYER, ElmsLab_WalkUpToElmMovement
	turnobject ELMSLAB_ELM, LEFT
	opentext
	writetext ElmText_Intro
	waitbutton
	closetext
	setscene SCENE_ELMSLAB_CANT_LEAVE
	end

ProfElmScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_SS_TICKET_FROM_ELM
	iftrue ElmCheckMasterBall
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue ElmGiveTicketScript
ElmCheckMasterBall:
	checkevent EVENT_GOT_MASTER_BALL_FROM_ELM
	iftrue ElmCheckEverstone
	checkflag ENGINE_RISINGBADGE
	iftrue ElmGiveMasterBallScript
ElmCheckEverstone:
	checkevent EVENT_GOT_EVERSTONE_FROM_ELM
	iftrue ElmScript_CallYou
	checkevent EVENT_SHOWED_TOGEPI_TO_ELM
	iftrue ElmGiveEverstoneScript
	checkevent EVENT_TOLD_ELM_ABOUT_TOGEPI_OVER_THE_PHONE
	iffalse ElmCheckTogepiEgg
	setval TOGEPI
	special FindPartyMonThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	setval TOGETIC
	special FindPartyMonThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	writetext ElmThoughtEggHatchedText
	waitbutton
	closetext
	end

ElmEggHatchedScript:
	setval TOGEPI
	special FindPartyMonThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	setval TOGETIC
	special FindPartyMonThatSpeciesYourTrainerID
	iftrue ShowElmTogepiScript
	sjump ElmCheckGotEggAgain

ElmCheckTogepiEgg:
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iffalse ElmCheckGotEggAgain
	checkevent EVENT_TOGEPI_HATCHED
	iftrue ElmEggHatchedScript
ElmCheckGotEggAgain:
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE ; why are we checking it again?
	iftrue ElmWaitingEggHatchScript
	checkflag ENGINE_ZEPHYRBADGE
	iftrue ElmAideHasEggScript
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue ElmStudyingEggScript
	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	iftrue ElmAfterTheftScript
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue ElmDescribesMrPokemonScript
	writetext ElmText_LetYourMonBattleIt
	waitbutton
	closetext
	end

LabTryToLeaveScript:
	turnobject ELMSLAB_ELM, DOWN
	opentext
	writetext LabWhereGoingText
	waitbutton
	closetext
	applymovement PLAYER, ElmsLab_CantLeaveMovement
	end

CyndaquilPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtElmPokeBallScript
	turnobject ELMSLAB_ELM, DOWN
	reanchormap
	pokepic CYNDAQUIL
	cry CYNDAQUIL
	waitbutton
	closepokepic
	opentext
	writetext TakeCyndaquilText
	yesorno
	iffalse DidntChooseStarterScript
	disappear ELMSLAB_POKE_BALL1
	setevent EVENT_GOT_CYNDAQUIL_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	getmonname STRING_BUFFER_3, CYNDAQUIL
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke CYNDAQUIL, 5, BERRY
	closetext
	readvar VAR_FACING
	ifequal RIGHT, ElmDirectionsScript
	applymovement PLAYER, AfterCyndaquilMovement
	sjump ElmDirectionsScript

TotodilePokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtElmPokeBallScript
	turnobject ELMSLAB_ELM, DOWN
	reanchormap
	pokepic TOTODILE
	cry TOTODILE
	waitbutton
	closepokepic
	opentext
	writetext TakeTotodileText
	yesorno
	iffalse DidntChooseStarterScript
	disappear ELMSLAB_POKE_BALL2
	setevent EVENT_GOT_TOTODILE_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	getmonname STRING_BUFFER_3, TOTODILE
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke TOTODILE, 5, BERRY
	closetext
	applymovement PLAYER, AfterTotodileMovement
	sjump ElmDirectionsScript

ChikoritaPokeBallScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue LookAtElmPokeBallScript
	turnobject ELMSLAB_ELM, DOWN
	reanchormap
	pokepic CHIKORITA
	cry CHIKORITA
	waitbutton
	closepokepic
	opentext
	writetext TakeChikoritaText
	yesorno
	iffalse DidntChooseStarterScript
	disappear ELMSLAB_POKE_BALL3
	setevent EVENT_GOT_CHIKORITA_FROM_ELM
	writetext ChoseStarterText
	promptbutton
	waitsfx
	getmonname STRING_BUFFER_3, CHIKORITA
	writetext ReceivedStarterText
	playsound SFX_CAUGHT_MON
	waitsfx
	promptbutton
	givepoke CHIKORITA, 5, BERRY
	closetext
	applymovement PLAYER, AfterChikoritaMovement
	sjump ElmDirectionsScript

DidntChooseStarterScript:
	writetext DidntChooseStarterText
	waitbutton
	closetext
	end

ElmDirectionsScript:
	turnobject PLAYER, UP
	opentext
	writetext ElmDirectionsText1
	waitbutton
	closetext
	turnobject ELMSLAB_ELM, LEFT
	opentext
	writetext ElmDirectionsText2
	waitbutton
	closetext
	turnobject ELMSLAB_ELM, DOWN
	opentext
	writetext ElmDirectionsText3
	promptbutton
	waitsfx
	addcellnum PHONE_ELM
	writetext GotElmsNumberText
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	waitbutton
	closetext
	setevent EVENT_GOT_A_POKEMON_FROM_ELM
	setevent EVENT_RIVAL_CHERRYGROVE_CITY
	setscene SCENE_ELMSLAB_AIDE_GIVES_POTION
	setmapscene NEW_BARK_TOWN, SCENE_NEWBARKTOWN_NOOP
	end

ElmDescribesMrPokemonScript:
	writetext ElmDescribesMrPokemonText
	waitbutton
	closetext
	end

LookAtElmPokeBallScript:
	opentext
	writetext ElmPokeBallText
	waitbutton
	closetext
	end

ElmsLabHealingMachine:
	opentext
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .CanHeal
	writetext ElmsLabHealingMachineText1
	waitbutton
	closetext
	end

.CanHeal:
	writetext ElmsLabHealingMachineText2
	yesorno
	iftrue ElmsLabHealingMachine_HealParty
	closetext
	end

ElmsLabHealingMachine_HealParty:
	special HealParty
	playmusic MUSIC_NONE
	setval HEALMACHINE_ELMS_LAB
	special HealMachineAnim
	pause 30
	special RestartMapMusic
	closetext
	end

ElmAfterTheftDoneScript:
	waitbutton
	closetext
	end

ElmAfterTheftScript:
	writetext ElmAfterTheftText1
	checkitem MYSTERY_EGG
	iffalse ElmAfterTheftDoneScript
	promptbutton
	writetext ElmAfterTheftText2
	waitbutton
	takeitem MYSTERY_EGG
	scall ElmJumpBackScript1
	writetext ElmAfterTheftText3
	waitbutton
	scall ElmJumpBackScript2
	writetext ElmAfterTheftText4
	promptbutton
	writetext ElmAfterTheftText5
	promptbutton
	setevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	setmapscene ROUTE_29, SCENE_ROUTE29_CATCH_TUTORIAL
	clearevent EVENT_ROUTE_30_YOUNGSTER_JOEY
	setevent EVENT_ROUTE_30_BATTLE
	writetext ElmAfterTheftText6
	waitbutton
	closetext
	setscene SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS
	end

ElmStudyingEggScript:
	writetext ElmStudyingEggText
	waitbutton
	closetext
	end

ElmAideHasEggScript:
	writetext ElmAideHasEggText
	waitbutton
	closetext
	end

ElmWaitingEggHatchScript:
	writetext ElmWaitingEggHatchText
	waitbutton
	closetext
	end

ShowElmTogepiScript:
	writetext ShowElmTogepiText1
	waitbutton
	closetext
	showemote EMOTE_SHOCK, ELMSLAB_ELM, 15
	setevent EVENT_SHOWED_TOGEPI_TO_ELM
	opentext
	writetext ShowElmTogepiText2
	promptbutton
	writetext ShowElmTogepiText3
	promptbutton
ElmGiveEverstoneScript:
	writetext ElmGiveEverstoneText1
	promptbutton
	verbosegiveitem EVERSTONE
	iffalse ElmScript_NoRoomForEverstone
	writetext ElmGiveEverstoneText2
	waitbutton
	closetext
	setevent EVENT_GOT_EVERSTONE_FROM_ELM
	end

ElmScript_CallYou:
	writetext ElmText_CallYou
	waitbutton
ElmScript_NoRoomForEverstone:
	closetext
	end

ElmGiveMasterBallScript:
	writetext ElmGiveMasterBallText1
	promptbutton
	verbosegiveitem MASTER_BALL
	iffalse .notdone
	setevent EVENT_GOT_MASTER_BALL_FROM_ELM
	writetext ElmGiveMasterBallText2
	waitbutton
.notdone
	closetext
	end

ElmGiveTicketScript:
	writetext ElmGiveTicketText1
	promptbutton
	verbosegiveitem S_S_TICKET
	setevent EVENT_GOT_SS_TICKET_FROM_ELM
	writetext ElmGiveTicketText2
	waitbutton
	closetext
	end

ElmJumpBackScript1:
	closetext
	readvar VAR_FACING
	ifequal DOWN, ElmJumpDownScript
	ifequal UP, ElmJumpUpScript
	ifequal LEFT, ElmJumpLeftScript
	ifequal RIGHT, ElmJumpRightScript
	end

ElmJumpBackScript2:
	closetext
	readvar VAR_FACING
	ifequal DOWN, ElmJumpUpScript
	ifequal UP, ElmJumpDownScript
	ifequal LEFT, ElmJumpRightScript
	ifequal RIGHT, ElmJumpLeftScript
	end

ElmJumpUpScript:
	applymovement ELMSLAB_ELM, ElmJumpUpMovement
	opentext
	end

ElmJumpDownScript:
	applymovement ELMSLAB_ELM, ElmJumpDownMovement
	opentext
	end

ElmJumpLeftScript:
	applymovement ELMSLAB_ELM, ElmJumpLeftMovement
	opentext
	end

ElmJumpRightScript:
	applymovement ELMSLAB_ELM, ElmJumpRightMovement
	opentext
	end

AideScript_WalkPotion1:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight1
	turnobject PLAYER, DOWN
	scall AideScript_GivePotion
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft1
	end

AideScript_WalkPotion2:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight2
	turnobject PLAYER, DOWN
	scall AideScript_GivePotion
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft2
	end

AideScript_GivePotion:
	opentext
	writetext AideText_GiveYouPotion
	promptbutton
	verbosegiveitem POTION
	writetext AideText_AlwaysBusy
	waitbutton
	closetext
	setscene SCENE_ELMSLAB_NOOP
	end

AideScript_WalkBalls1:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight1
	turnobject PLAYER, DOWN
	scall AideScript_GiveYouBalls
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft1
	end

AideScript_WalkBalls2:
	applymovement ELMSLAB_ELMS_AIDE, AideWalksRight2
	turnobject PLAYER, DOWN
	scall AideScript_GiveYouBalls
	applymovement ELMSLAB_ELMS_AIDE, AideWalksLeft2
	end

AideScript_GiveYouBalls:
	opentext
	writetext AideText_GiveYouBalls
	promptbutton
	getitemname STRING_BUFFER_4, POKE_BALL
	scall AideScript_ReceiveTheBalls
	giveitem POKE_BALL, 5
	writetext AideText_ExplainBalls
	promptbutton
	itemnotify
	closetext
	setscene SCENE_ELMSLAB_NOOP
	end

AideScript_ReceiveTheBalls:
	jumpstd ReceiveItemScript
	end

ElmsAideScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_TOGEPI_EGG_FROM_ELMS_AIDE
	iftrue AideScript_AfterTheft
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue AideScript_ExplainBalls
	checkevent EVENT_GOT_MYSTERY_EGG_FROM_MR_POKEMON
	iftrue AideScript_TheftTestimony
	writetext AideText_AlwaysBusy
	waitbutton
	closetext
	end

AideScript_TheftTestimony:
	writetext AideText_TheftTestimony
	waitbutton
	closetext
	end

AideScript_ExplainBalls:
	writetext AideText_ExplainBalls
	waitbutton
	closetext
	end

AideScript_AfterTheft:
	writetext AideText_AfterTheft
	waitbutton
	closetext
	end

MeetCopScript2:
	applymovement PLAYER, MeetCopScript2_StepLeft

MeetCopScript:
	applymovement PLAYER, MeetCopScript_WalkUp
CopScript:
	turnobject ELMSLAB_OFFICER, LEFT
	opentext
	writetext ElmsLabOfficerText1
	promptbutton
	special NameRival
	writetext ElmsLabOfficerText2
	waitbutton
	closetext
	applymovement ELMSLAB_OFFICER, OfficerLeavesMovement
	disappear ELMSLAB_OFFICER
	setscene SCENE_ELMSLAB_NOOP
	end

ElmsLabWindow:
	opentext
	checkflag ENGINE_FLYPOINT_VIOLET
	iftrue .Normal
	checkevent EVENT_ELM_CALLED_ABOUT_STOLEN_POKEMON
	iftrue .BreakIn
	sjump .Normal

.BreakIn:
	writetext ElmsLabWindowText2
	waitbutton
	closetext
	end

.Normal:
	writetext ElmsLabWindowText1
	waitbutton
	closetext
	end

ElmsLabTravelTip1:
	jumptext ElmsLabTravelTip1Text

ElmsLabTravelTip2:
	jumptext ElmsLabTravelTip2Text

ElmsLabTravelTip3:
	jumptext ElmsLabTravelTip3Text

ElmsLabTravelTip4:
	jumptext ElmsLabTravelTip4Text

ElmsLabTrashcan:
	jumptext ElmsLabTrashcanText

ElmsLabTrashcan2: ; unreferenced
	jumpstd TrashCanScript

ElmsLabBookshelf:
	jumpstd DifficultBookshelfScript

ElmsLab_WalkUpToElmMovement:
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	turn_head RIGHT
	step_end

ElmsLab_CantLeaveMovement:
	step UP
	step_end

MeetCopScript2_StepLeft:
	step LEFT
	step_end

MeetCopScript_WalkUp:
	step UP
	step UP
	turn_head RIGHT
	step_end

OfficerLeavesMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

AideWalksRight1:
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

AideWalksRight2:
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

AideWalksLeft1:
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

AideWalksLeft2:
	step LEFT
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

ElmJumpUpMovement:
	fix_facing
	big_step UP
	remove_fixed_facing
	step_end

ElmJumpDownMovement:
	fix_facing
	big_step DOWN
	remove_fixed_facing
	step_end

ElmJumpLeftMovement:
	fix_facing
	big_step LEFT
	remove_fixed_facing
	step_end

ElmJumpRightMovement:
	fix_facing
	big_step RIGHT
	remove_fixed_facing
	step_end

AfterCyndaquilMovement:
	step LEFT
	step UP
	step_end

AfterTotodileMovement:
	step LEFT
	step LEFT
	step UP
	step_end

AfterChikoritaMovement:
	step LEFT
	step LEFT
	step LEFT
	step UP
	step_end

ElmText_Intro:
	text "ウツギ『やあ　<PLAYER>くん"
	line "ま<TTE>いたよ！"

	para "きょう　きみ<WO>よんだのは"
	line "おねがい<GA>あるからなんだ！"

	para "ぼく<NO>しりあいにね"
	line "#じいさん　とい<TTE>"

	para "へんなモノ<WO>みつけてきては"
	line "だいはっけん！　<TTE>　おおさわぎする"
	cont "おじいさん<GA>いるんだよ"

	para "で　さっきね"
	line "「こんどこそ<WA>ほんも<NO>ですぞ！」"
	cont "<TTE>　メール<GA>きたんだ"

	para "き<NI>なるんだけど"
	line "ぼくも　じょしゅも　#の"
	cont "けんきゅうで　いそがしくてね"
	cont "かわり<NI>い<TTE>きてほしいんだ"

	para "もちろん　パートナーとなる"
	line "#<WO>あげるよ"

	para "さいきん　みつけたばかりの"
	line "めずらしい　#　だよ"
	cont "さあ　えらんでよ！"
	done

ElmText_LetYourMonBattleIt:
	text "#<WO>も<TTE>いれば"
	line "やせい<NO>#<GA>でてきても"
	cont "たたかわせれば　いいんだよ！"
	done

LabWhereGoingText:
	text "ウツギ『ちょっと　ちょっと"
	line "どこ<NI>いくんだよ！"
	done

TakeCyndaquilText:
	text "ウツギ『ほのお<NO>#"
	line "ヒノアラシ<NI>するのかい！？"
	done

TakeTotodileText:
	text "ウツギ『みず<NO>#"
	line "ワニノコ<GA>いいんだね！？"
	done

TakeChikoritaText:
	text "ウツギ『くさ<NO>#"
	line "チコリータ<GA>き<NI>いったんだね！？"
	done

DidntChooseStarterText:
	text "ウツギ『じっくり　かんがえて"
	line "きめると　いいよ"
	cont "だいじな　パートナー　だからね"
	done

ChoseStarterText:
	text "ウツギ『ぼくも　こいつは"
	line "さいこう<NO>#だと　おもうよ！"
	done

ReceivedStarterText:
	text "<PLAYER><WA>ウツギはかせ　から"
	line "@"
	text_ram wStringBuffer3
	text "<WO>もらっ<TA!>"
	done

ElmDirectionsText1:
	text "#じいさん<GA>いるのは"
	line "こ<NO>まち<NO>となり"
	cont "ヨシノシティ<NO>さき　だよ"

	para "そこまで<WA>ほとんど"
	line "いっぽんみち　だからね"
	done

ElmDirectionsText2:
	text "#<GA>きずついたら"
	line "そこ<NO>マシンで"
	cont "#<WO>かいふく　させてあげてね"
	done

ElmDirectionsText3:
	text "おっと　ぼく<NO>でんわばんごう"
	line "おしえて　おくから"
	cont "なにか　あったら　れんらく　してよ！"
	done

GotElmsNumberText:
	text "<PLAYER><WA>ウツギはかせの"
	line "でんわばんごう<WO>とうろく　し<TA!>"
	done

ElmDescribesMrPokemonText:
	text "#じいさん　はね"
	line "いろんな　ところ<NI>い<TTE>は"
	cont "めずらしいモノ<WO>みつけるんだ"

	para "めずらしいだけで"
	line "やく<NI>たたないんだけどね<⋯>"

	para "それじゃ"
	line "<PLAYER>くん　よろしくね！"
	done

ElmPokeBallText:
	text "ウツギはかせ<GA>みつけた"
	line "#<GA>はい<TTE>る！"
	done

ElmsLabHealingMachineText1:
	text "なん<NO>マシン　だろう？"
	done

ElmsLabHealingMachineText2:
	text "#<NO>かいふく<WO>させますか？"
	done

ElmAfterTheftText1:
	text "ウツギ『<PLAYER>くん<⋯>"
	line "たいへんな　め<NI>あったよ"

	para "あっ　そうそう"
	line "#じいさんの"
	cont "だいはっけん　<TTE>　なんだったの？"
	done

ElmAfterTheftText2:
	text "<PLAYER><WA>ウツギはかせに"
	line "ふしぎなタマゴ<WO><WATASHI><TA!>"
	done

ElmAfterTheftText3:
	text "ウツギ『これは<⋯>"
	done

ElmAfterTheftText4:
	text "<⋯>　ひょっとして"
	line "#<NO>タマゴ！？"

	para "もし　そうなら　ほんとうに"
	line "だい　だい　だいはっけん　だよ！"
	done

ElmAfterTheftText5:
	text "ウツギ『え？　オーキドはかせから"
	line "#ずかん<WO>もらっ<TA!>？"

	para "<PLAYER>くん　ほ　ほんとうかい？"
	line "そ　そりゃ　すごいこと　だよ！"

	para "なんた<TTE>　オーキドはかせは"
	line "<TRAINER><NO>さいのう<WO>みぬく"
	cont "ちから<NO>もちぬし　だからね"

	para "そうか　<PLAYER>くん　きみには"
	line "チャンピオン<NI>なれるだけの"
	cont "そしつ<GA>あるのかも　しれないね"

	para "#も　なついてるようだし"
	line "このまま　かくち<NO>#ジムに"
	cont "ちょうせん　するの<WA>どうかな？"

	para "ここからだと　キキョウシティの"
	line "#ジム<GA>いちばん　ちかいよ"
	done

ElmAfterTheftText6:
	text "<⋯>　<PLAYER>くん"
	line "チャンピオン<WO>めざすのは"
	cont "ながい　たび<NI>なるとおもう"

	para "しゅっぱつ<NO>まえに"
	line "おかあさん<NI>はなしておくんだよ"
	done

ElmStudyingEggText:
	text "ウツギ『がんばるんだよ！"
	line "ボクも　タマゴについて　わかりしだい"
	cont "れんらく　するからね！"
	done

ElmAideHasEggText:
	text "ウツギ『あれ　<PLAYER>くん"
	line "ぼく<NO>じょしゅと　あわなかった？"

	para "きみ<NI>タマゴ<WO>とどけるため"
	line "キキョウ<NO>#センターに"
	cont "い<TTE>る　はず　なのに<⋯>"

	para "いきちがい　かなあ？"
	line "わるいけど　い<TTE>　あげてよ"
	done

ElmWaitingEggHatchText:
	text "ウツギ『どうだい"
	line "タマゴ<NI>へんかはあったかい？"
	done

ElmThoughtEggHatchedText:
	text "あれ　<PLAYER>くん"
	line "タマゴ　かえったんでしょ"
	cont "#　どうしてるの？"
	done

ShowElmTogepiText1:
	text "ウツギ『<PLAYER>くん"
	line "げんき　そうだね"
	done

ShowElmTogepiText2:
	text "えっ？"
	line "そ<NO>#は<⋯>！"
	done

ShowElmTogepiText3:
	text "タマゴ<GA>かえったんだね！"

	para "そうすると　#は"
	line "タマゴから　うまれるのか<⋯>"

	para "いやいや　すべて<NO>#が"
	line "そうと　きまった　わけじゃないぞ"

	para "うーん　まだまだ"
	line "しらべること　いっぱい　なんだね"
	done

ElmGiveEverstoneText1:
	text "<PLAYER>くん　ありがとう！"
	line "きみ<NO>おかげで"
	cont "#<NO>なぞ<GA>わかりそうだよ"

	para "これ<WA>ぼく<NO>かんしゃ<NO>きもち"
	line "えんりょせず<NI>も<TTE>い<TTE>よ！"
	done

ElmGiveEverstoneText2:
	text "それ<WA>かわらずのいし！"

	para "#<WA>しゅるい<NI>よ<TTE>は"
	line "あるていど　そだつと"
	cont "しんかして　すがた<WO>かえる"

	para "そのとき　かわらずのいしを"
	line "もたせていると　しんか　しないんだ"

	para "いま<NO>すがたのまま　そだてたい"
	line "#がいたら　つか<TTE>みてよ"
	done

ElmText_CallYou:
	text "ウツギ『じゃあ　<PLAYER>くん"
	line "なにか　わかったら　れんらくするね"
	done

AideText_AfterTheft:
	text "<⋯>　はあ"
	line "<⋯>　とられた　#"
	cont "いまごろ　どうしてるだろう<⋯>"

	para "わるい　ひと<NI>そだてられると"
	line "わるい#になる　といいますから"
	done

ElmGiveMasterBallText1:
	text "ウツギ『やあ　<PLAYER>くん！"
	line "きみ<NO>おかげで"
	cont "けんきゅうも　はかど<TTE>いるよ"

	para "これ<WA>ぼく<NO>きもち"
	line "ぜひ　つか<TTE>よ！"
	done

ElmGiveMasterBallText2:
	text "そ<NO>マスターボールは！！"

	para "どんな　#でも"
	line "ぜったい<NI>つかまえられる"
	cont "きゅうきょく<NO>モンスターボール"

	para "#<NO>けんきゅうを"
	line "みとめられた　ひとに"
	cont "おくられるも<NO>らしいけど<⋯>"

	para "ぼくより　きみ<NO>ほうが"
	line "うまく　つかえると　おもうからね"
	cont "<PLAYER>くん<NI>あげるよ！"
	done

ElmGiveTicketText1:
	text "ウツギ『やあ　<PLAYER>くん"
	line "ま<TTE>いたよ！"

	para "きょう　きみ<WO>よんだのは"
	line "あげたいもの<GA>あるからなんだ！"

	para "ほら！"
	line "ふねのチケット"

	para "これで　カントー<NO>#も"
	line "つかまえられるよう<NI>なるね！"
	done

ElmGiveTicketText2:
	text "こうそくせん<NI>のるなら"
	line "アサギシティ　だよ！"

	para "<⋯><TTE>　<PLAYER>くんの"
	line "ほう<GA>くわしいよね"

	para "#と　いっしょに"
	line "いろんなところ　まわったんだもんね"

	para "じゃあ　カントー<NI>いったら"
	line "オーキドはかせ<NI>よろしく！"
	done

ElmsLabMonEggText: ; unreferenced
	text "はかせ<GA>けんきゅう　している"
	line "#<NO>タマゴだ！"
	done

AideText_GiveYouPotion:
	text "<PLAYER>くん！"
	line "おつかい<WO>してくれる　きみに"
	cont "これ<WO>お<WATASHI>　します！"
	done

AideText_AlwaysBusy:
	text "ふたりしか　いませんから"
	line "ちょっとのことで　てんてこまい<⋯>"

	para "あー　いそがしいです"
	done

AideText_TheftTestimony:
	text "そとで　おおきな　おとがして<⋯>"

	para "はかせと　みにいった　すきに"
	line "#<WO>とられたようです<⋯>"

	para "ひと<NO>もの<WO>とる　だなんて"
	line "しんじられない　ですよ！"

	para "<⋯>　はあ"
	line "<⋯>　とられた　#"
	cont "いまごろ　どうしてるだろう<⋯>"

	para "わるい　ひと<NI>そだてられると"
	line "わるい#になる　といいますから"
	done

AideText_GiveYouBalls:
	text "<PLAYER>くん！"

	para "#ずかん<WO>つくる　きみに"
	line "これ<WO>お<WATASHI>　します！"
	done

AideText_ExplainBalls:
	text "#ずかん<WO>つくるには"
	line "#<WO>つかまえないと！"

	para "モンスターボールを"
	line "やせい<NO>#<NI>なげると"
	cont "つかまえること<GA>できるのです！"
	done

ElmsLabOfficerText1:
	text "こ<NO>けんきゅうしょ"
	line "#<GA>ぬすまれたそうで<⋯>"

	para "いま　ウツギはかせ　から"
	line "はなし<WO>きいていた　ところです"
	cont "なんでも　あかくて　ながい"
	cont "かみのけ<NO>しょうねん　だそうで"

	para "えっ！"
	line "そんな　<TRAINER>と　たたかった？"

	para "なまえ　とか"
	line "い<TTE>ませんでしたか？"
	done

ElmsLabOfficerText2:
	text "わかりまし<TA!>"
	line "<RIVAL>と　いうのですね！"

	para "ごきょうりょく"
	line "ありがとう　ございまし<TA!>"
	done

ElmsLabWindowText1:
	text "まど<GA>あいている"
	line "かぜ<GA>きもち　いい！"
	done

ElmsLabWindowText2:
	text "ここから　はい<TTE>　きたんだ！"
	done

ElmsLabTravelTip1Text:
	text "<PLAYER><WA>ほん<WO>とりだした"

	para "たんけん<NO>こころえ　その１"

	para "スタート　ボタン<WO>ぷしゅ！"
	line "メニュー<GA>ひらくなり！"
	done

ElmsLabTravelTip2Text:
	text "<PLAYER><WA>ほん<WO>とりだした"

	para "たんけん<NO>こころえ　その２"

	para "#　レポートで"
	line "きろく　できるなり！"
	done

ElmsLabTravelTip3Text:
	text "<PLAYER><WA>ほん<WO>とりだした"

	para "たんけん<NO>こころえ　その３"

	para "リュック<WO>ひろげて"
	line "セレクト　ボタン<WO>ぷしゅ！"
	cont "どうぐ<NO>いれかえ<GA>できるなり！"
	done

ElmsLabTravelTip4Text:
	text "<PLAYER><WA>ほん<WO>とりだした"

	para "たんけん<NO>こころえ　その４"

	para "#<NO>つかえるわざ<WO>みて"
	line "エー　ボタン<WO>ぷしゅ！"
	cont "わざ<NO>いれかえ<GA>できるなり！"
	done

ElmsLabTrashcanText:
	text "ウツギはかせ<GA>たべた"
	line "おかし<NO>ふくろ<GA>すててある<⋯>"
	done

ElmsLab_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 11, NEW_BARK_TOWN, 1
	warp_event  5, 11, NEW_BARK_TOWN, 1

	def_coord_events
	coord_event  4,  6, SCENE_ELMSLAB_CANT_LEAVE, LabTryToLeaveScript
	coord_event  5,  6, SCENE_ELMSLAB_CANT_LEAVE, LabTryToLeaveScript
	coord_event  4,  5, SCENE_ELMSLAB_MEET_OFFICER, MeetCopScript
	coord_event  5,  5, SCENE_ELMSLAB_MEET_OFFICER, MeetCopScript2
	coord_event  4,  8, SCENE_ELMSLAB_AIDE_GIVES_POTION, AideScript_WalkPotion1
	coord_event  5,  8, SCENE_ELMSLAB_AIDE_GIVES_POTION, AideScript_WalkPotion2
	coord_event  4,  8, SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS, AideScript_WalkBalls1
	coord_event  5,  8, SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS, AideScript_WalkBalls2

	def_bg_events
	bg_event  2,  1, BGEVENT_READ, ElmsLabHealingMachine
	bg_event  6,  1, BGEVENT_READ, ElmsLabBookshelf
	bg_event  7,  1, BGEVENT_READ, ElmsLabBookshelf
	bg_event  8,  1, BGEVENT_READ, ElmsLabBookshelf
	bg_event  9,  1, BGEVENT_READ, ElmsLabBookshelf
	bg_event  0,  7, BGEVENT_READ, ElmsLabTravelTip1
	bg_event  1,  7, BGEVENT_READ, ElmsLabTravelTip2
	bg_event  2,  7, BGEVENT_READ, ElmsLabTravelTip3
	bg_event  3,  7, BGEVENT_READ, ElmsLabTravelTip4
	bg_event  6,  7, BGEVENT_READ, ElmsLabBookshelf
	bg_event  7,  7, BGEVENT_READ, ElmsLabBookshelf
	bg_event  8,  7, BGEVENT_READ, ElmsLabBookshelf
	bg_event  9,  7, BGEVENT_READ, ElmsLabBookshelf
	bg_event  9,  3, BGEVENT_READ, ElmsLabTrashcan
	bg_event  5,  0, BGEVENT_READ, ElmsLabWindow

	def_object_events
	object_event  5,  2, SPRITE_ELM, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ProfElmScript, -1
	object_event  2,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ElmsAideScript, EVENT_ELMS_AIDE_IN_LAB
	object_event  6,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CyndaquilPokeBallScript, EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	object_event  7,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TotodilePokeBallScript, EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	object_event  8,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ChikoritaPokeBallScript, EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	object_event  5,  3, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CopScript, EVENT_COP_IN_ELMS_LAB
