	object_const_def
	const TEAMROCKETBASEB2F_ROCKET1
	const TEAMROCKETBASEB2F_ROCKET_GIRL
	const TEAMROCKETBASEB2F_LANCE
	const TEAMROCKETBASEB2F_DRAGON
	const TEAMROCKETBASEB2F_ELECTRODE1
	const TEAMROCKETBASEB2F_ELECTRODE2
	const TEAMROCKETBASEB2F_ELECTRODE3
	const TEAMROCKETBASEB2F_ELECTRODE4
	const TEAMROCKETBASEB2F_ELECTRODE5
	const TEAMROCKETBASEB2F_ELECTRODE6
	const TEAMROCKETBASEB2F_ROCKET2
	const TEAMROCKETBASEB2F_ROCKET3
	const TEAMROCKETBASEB2F_ROCKET4
	const TEAMROCKETBASEB2F_POKE_BALL

TeamRocketBaseB2F_MapScripts:
	def_scene_scripts
	scene_script TeamRocketBaseB2FNoop1Scene, SCENE_TEAMROCKETBASEB2F_LANCE_HEALS
	scene_script TeamRocketBaseB2FNoop2Scene, SCENE_TEAMROCKETBASEB2F_ROCKET_BOSS
	scene_script TeamRocketBaseB2FNoop3Scene, SCENE_TEAMROCKETBASEB2F_ELECTRODES
	scene_script TeamRocketBaseB2FNoop4Scene, SCENE_TEAMROCKETBASEB2F_NOOP

	def_callbacks
	callback MAPCALLBACK_TILES, TeamRocketBaseB2FTransmitterDoorCallback

TeamRocketBaseB2FNoop1Scene:
	end

TeamRocketBaseB2FNoop2Scene:
	end

TeamRocketBaseB2FNoop3Scene:
	end

TeamRocketBaseB2FNoop4Scene:
	end

TeamRocketBaseB2FTransmitterDoorCallback:
	checkevent EVENT_OPENED_DOOR_TO_ROCKET_HIDEOUT_TRANSMITTER
	iftrue .OpenDoor
	endcallback

.OpenDoor:
	changeblock 14, 12, $07 ; floor
	endcallback

RocketBaseBossFLeft:
	moveobject TEAMROCKETBASEB2F_LANCE, 9, 13
	sjump RocketBaseBossFScript

RocketBaseBossFRight:
	moveobject TEAMROCKETBASEB2F_ROCKET_GIRL, 21, 16
	moveobject TEAMROCKETBASEB2F_ROCKET1, 21, 16
	moveobject TEAMROCKETBASEB2F_DRAGON, 10, 13
	moveobject TEAMROCKETBASEB2F_LANCE, 10, 13
RocketBaseBossFScript:
	appear TEAMROCKETBASEB2F_ROCKET_GIRL
	appear TEAMROCKETBASEB2F_ROCKET1
	opentext
	writetext RocketBaseExecutiveFHoldItText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, PLAYER, 15
	applymovement PLAYER, RocketBasePlayerApproachesBossFMovement
	playmusic MUSIC_ROCKET_ENCOUNTER
	applymovement TEAMROCKETBASEB2F_ROCKET_GIRL, RocketBaseBossFApproachesPlayerMovement
	turnobject PLAYER, UP
	applymovement TEAMROCKETBASEB2F_ROCKET1, RocketBaseGruntApproachesPlayerMovement
	opentext
	writetext RocketBaseBossFThrashText
	waitbutton
	closetext
	cry DRAGONITE
	turnobject TEAMROCKETBASEB2F_ROCKET_GIRL, LEFT
	turnobject PLAYER, LEFT
	appear TEAMROCKETBASEB2F_DRAGON
	applymovement TEAMROCKETBASEB2F_DRAGON, RocketBaseDragoniteAttacksMovement
	applymovement TEAMROCKETBASEB2F_ROCKET_GIRL, RocketBaseBossFHitMovement
	applymovement TEAMROCKETBASEB2F_ROCKET1, RocketBaseGruntProtectsBossFMovement
	appear TEAMROCKETBASEB2F_LANCE
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceApproachesBossFMovement
	opentext
	writetext RocketBaseLanceShareFunText
	waitbutton
	closetext
	turnobject PLAYER, RIGHT
	applymovement TEAMROCKETBASEB2F_ROCKET_GIRL, RocketBaseBossFFacesPlayerMovement
	opentext
	writetext RocketBaseBossDontMeddleText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB2F_ROCKET1, RocketBaseGruntBattlesLanceMovement
	applymovement TEAMROCKETBASEB2F_ROCKET_GIRL, RocketBaseBossFBattlesPlayerMovement
	winlosstext RocketBaseBossWinText, 0
	setlasttalked TEAMROCKETBASEB2F_ROCKET_GIRL
	loadtrainer EXECUTIVEF, EXECUTIVEF_2
	startbattle
	disappear TEAMROCKETBASEB2F_DRAGON
	setevent EVENT_TEAM_ROCKET_BASE_B2F_EXECUTIVE
	setevent EVENT_TEAM_ROCKET_BASE_B2F_GRUNT_WITH_EXECUTIVE
	setevent EVENT_TEAM_ROCKET_BASE_B2F_LANCE
	reloadmapafterbattle
	setevent EVENT_BEAT_ROCKET_EXECUTIVEF_2
	opentext
	writetext RocketBaseBossRetreatText
	waitbutton
	closetext
	special FadeOutToBlack
	special ReloadSpritesNoPalettes
	disappear TEAMROCKETBASEB2F_ROCKET1
	disappear TEAMROCKETBASEB2F_ROCKET_GIRL
	disappear TEAMROCKETBASEB2F_ROCKET2
	disappear TEAMROCKETBASEB2F_ROCKET3
	disappear TEAMROCKETBASEB2F_ROCKET4
	pause 15
	special FadeInFromBlack
	setscene SCENE_TEAMROCKETBASEB2F_ELECTRODES
	clearevent EVENT_TEAM_ROCKET_BASE_B2F_LANCE
	turnobject TEAMROCKETBASEB2F_LANCE, DOWN
	opentext
	writetext RocketBaseLancePostBattleText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceChecksPlayerMovement
	turnobject PLAYER, UP
	opentext
	writetext RocketBaseLancePowerOffText
	waitbutton
	closetext
	follow TEAMROCKETBASEB2F_LANCE, PLAYER
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceApproachesMachineMovement
	stopfollow
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLancePacesMovement
	opentext
	writetext RockerBaseLanceElectrodeFaintText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceApproachesElectrodesMovement
	disappear TEAMROCKETBASEB2F_LANCE

RocketBaseCantLeaveScript:
	applymovement PLAYER, RocketBasePlayerCantLeaveElectrodesMovement
	end

RocketBaseLancesSideScript:
	opentext
	writetext RocketBaseLancesSideText
	waitbutton
	closetext
	applymovement PLAYER, RocketBasePlayerCantGoRightMovement
	end

LanceHealsScript1:
	turnobject PLAYER, UP
	sjump LanceHealsCommon

LanceHealsScript2:
	turnobject PLAYER, RIGHT
	turnobject TEAMROCKETBASEB2F_LANCE, LEFT
LanceHealsCommon:
	opentext
	writetext LanceHealsText1
	waitbutton
	closetext
	special FadeOutToWhite
	playsound SFX_FULL_HEAL
	special HealParty
	special FadeInFromWhite
	opentext
	writetext LanceHealsText2
	waitbutton
	closetext
	setscene SCENE_TEAMROCKETBASEB2F_ROCKET_BOSS
	setevent EVENT_LANCE_HEALED_YOU_IN_TEAM_ROCKET_BASE
	readvar VAR_FACING
	ifequal RIGHT, .FacingRight
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceLeavesAfterHealMovement
	disappear TEAMROCKETBASEB2F_LANCE
	end

.FacingRight:
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceLeavesAfterHealRightMovement
	disappear TEAMROCKETBASEB2F_LANCE
	end

TrainerGruntM17:
	trainer GRUNTM, GRUNTM_17, EVENT_BEAT_ROCKET_GRUNTM_17, GruntM17SeenText, GruntM17BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM17AfterBattleText
	waitbutton
	closetext
	end

TrainerGruntM18:
	trainer GRUNTM, GRUNTM_18, EVENT_BEAT_ROCKET_GRUNTM_18, GruntM18SeenText, GruntM18BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM18AfterBattleText
	waitbutton
	closetext
	end

TrainerGruntM19:
	trainer GRUNTM, GRUNTM_19, EVENT_BEAT_ROCKET_GRUNTM_19, GruntM19SeenText, GruntM19BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM19AfterBattleText
	waitbutton
	closetext
	end

RocketElectrode1:
	cry ELECTRODE
	loadwildmon ELECTRODE, 23
	startbattle
	iftrue TeamRocketBaseB2FReloadMap
	disappear TEAMROCKETBASEB2F_ELECTRODE1
	disappear TEAMROCKETBASEB2F_ELECTRODE4
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	iffalse TeamRocketBaseB2FReloadMap
	reloadmapafterbattle
	special PlayMapMusic
	applymovement PLAYER, RocketBasePlayerLeavesElectrodesMovement1
	sjump RocketBaseElectrodeScript

RocketElectrode2:
	cry ELECTRODE
	loadwildmon ELECTRODE, 23
	startbattle
	iftrue TeamRocketBaseB2FReloadMap
	disappear TEAMROCKETBASEB2F_ELECTRODE2
	disappear TEAMROCKETBASEB2F_ELECTRODE5
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	iffalse TeamRocketBaseB2FReloadMap
	reloadmapafterbattle
	special PlayMapMusic
	applymovement PLAYER, RocketBasePlayerLeavesElectrodesMovement2
	sjump RocketBaseElectrodeScript

RocketElectrode3:
	cry ELECTRODE
	loadwildmon ELECTRODE, 23
	startbattle
	iftrue TeamRocketBaseB2FReloadMap
	disappear TEAMROCKETBASEB2F_ELECTRODE3
	disappear TEAMROCKETBASEB2F_ELECTRODE6
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	iffalse TeamRocketBaseB2FReloadMap
	checkevent EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	iffalse TeamRocketBaseB2FReloadMap
	reloadmapafterbattle
	special PlayMapMusic
	applymovement PLAYER, RocketBasePlayerLeavesElectrodesMovement3
	sjump RocketBaseElectrodeScript

TeamRocketBaseB2FReloadMap:
	reloadmapafterbattle
	end

RocketBaseElectrodeScript:
	moveobject TEAMROCKETBASEB2F_LANCE, 18, 6
	appear TEAMROCKETBASEB2F_LANCE
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceLeavesElectrodesMovement
	turnobject PLAYER, RIGHT
	opentext
	writetext RocketBaseLanceElectrodeDoneText
	promptbutton
	verbosegiveitem HM_WHIRLPOOL
	setevent EVENT_GOT_HM06_WHIRLPOOL
	writetext RocketBaseLanceWhirlpoolText
	waitbutton
	closetext
	turnobject TEAMROCKETBASEB2F_LANCE, DOWN
	opentext
	writetext RocketBaseLanceMonMasterText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement TEAMROCKETBASEB2F_LANCE, RocketBaseLanceLeavesBaseMovement
	disappear TEAMROCKETBASEB2F_LANCE
	setevent EVENT_CLEARED_ROCKET_HIDEOUT
	clearflag ENGINE_ROCKET_SIGNAL_ON_CH20
	setevent EVENT_ROUTE_43_GATE_ROCKETS
	setevent EVENT_MAHOGANY_TOWN_POKEFAN_M_BLOCKS_GYM
	setscene SCENE_TEAMROCKETBASEB2F_NOOP
	clearevent EVENT_LAKE_OF_RAGE_CIVILIANS
	setevent EVENT_TURNED_OFF_SECURITY_CAMERAS
	setevent EVENT_SECURITY_CAMERA_1
	setevent EVENT_SECURITY_CAMERA_2
	setevent EVENT_SECURITY_CAMERA_3
	setevent EVENT_SECURITY_CAMERA_4
	setevent EVENT_SECURITY_CAMERA_5
	end

TeamRocketBaseB2FLockedDoor:
	conditional_event EVENT_OPENED_DOOR_TO_ROCKET_HIDEOUT_TRANSMITTER, .Script

.Script:
	opentext
	checkevent EVENT_LEARNED_HAIL_GIOVANNI
	iftrue .KnowsPassword
	writetext RocketBaseDoorNoPasswordText
	waitbutton
	closetext
	end

.KnowsPassword:
	writetext RocketBaseDoorKnowPasswordText
	waitbutton
	playsound SFX_ENTER_DOOR
	changeblock 14, 12, $07 ; floor
	refreshmap
	closetext
	setevent EVENT_OPENED_DOOR_TO_ROCKET_HIDEOUT_TRANSMITTER
	waitsfx
	end

TeamRocketBaseB2FTransmitterScript:
	opentext
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .Deactivated
	writetext RocketBaseB2FTransmitterText
	waitbutton
	closetext
	end

.Deactivated:
	writetext RocketBaseB2FDeactivateTransmitterText
	waitbutton
	closetext
	end

TeamRocketBaseB2FTMThief:
	itemball TM_THIEF

TeamRocketBaseB2FHiddenFullHeal:
	hiddenitem FULL_HEAL, EVENT_TEAM_ROCKET_BASE_B2F_HIDDEN_FULL_HEAL

RocketBaseLanceLeavesAfterHealMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBaseLanceLeavesAfterHealRightMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBasePlayerApproachesBossFMovement:
	step DOWN
	step DOWN
	step DOWN
	turn_head RIGHT
	step_end

RocketBaseBossFApproachesPlayerMovement:
	big_step LEFT
	big_step LEFT
	big_step UP
	big_step UP
	big_step UP
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	turn_head DOWN
	step_end

RocketBaseGruntApproachesPlayerMovement:
	big_step LEFT
	big_step LEFT
	big_step UP
	big_step UP
	big_step LEFT
	big_step LEFT
	step_end

RocketBaseDragoniteAttacksMovement:
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	step_end

RocketBaseBossFHitMovement:
	fix_facing
	set_sliding
	jump_step RIGHT
	remove_sliding
	remove_fixed_facing
	step_end

RocketBaseBossFFacesPlayerMovement:
	slow_step DOWN
	turn_head LEFT
	step_end

RocketBaseLanceApproachesBossFMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBaseBossFBattlesPlayerMovement:
	big_step LEFT
	step_end

RocketBaseGruntBattlesLanceMovement:
	big_step LEFT
	step_end

RocketBaseGruntProtectsBossFMovement:
	big_step LEFT
	big_step UP
	turn_head LEFT
	step_end

RocketBaseLanceChecksPlayerMovement:
	step RIGHT
	step RIGHT
	turn_head DOWN
	step_end

RocketBaseLanceApproachesMachineMovement:
	step UP
	step UP
	step UP
	step_end

RocketBaseLancePacesMovement:
	step_sleep 8
	step LEFT
	step LEFT
	turn_head UP
	step_sleep 8
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_sleep 8
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

RocketBaseLanceApproachesElectrodesMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step UP
	step UP
	step UP
	step UP
	step UP
	step_end

RocketBasePlayerCantLeaveElectrodesMovement:
	step UP
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head UP
	step_end

RocketBasePlayerCantGoRightMovement:
	step LEFT
	step_end

RocketBaseLanceLeavesElectrodesMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step_end

RocketBaseLanceLeavesBaseMovement:
	step DOWN
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

RocketBasePlayerLeavesElectrodesMovement1:
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBasePlayerLeavesElectrodesMovement2:
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBasePlayerLeavesElectrodesMovement3:
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBaseExecutiveFHoldItText:
	text "そこまでよ！"
	done

RocketBaseBossFThrashText:
	text "ぼうや<NI>なめられてちゃ"
	line "<ROCKET>の"
	cont "プライド<GA>きずつくのよ"

	para "いくら　あなた<GA>つよくても"
	line "わたくしたち　ふたり　どうじに"
	cont "あいて<WA>できないでしょ？"

	para "わるいけど"
	line "かくご　してもらうわよ"
	done

RocketBaseLanceShareFunText:
	text "そんなこと　いわずに"
	line "どっちか　あそんでくれないか？"
	done

RocketBaseBossDontMeddleText:
	text "なかま<GA>いたのね"
	line "き<NI>いらないわね"

	para "サカキさま<NO>るす<WO>あずかる"
	line "わたくし<GA>おしえて　あげるわ"

	para "<ROCKET><NI>はむかうと"
	line "どうなるか　<TTE>　ことを！"
	done

RocketBaseBossWinText:
	text "あら　つよいのね"

	para "ざんねんね"
	line "あなたなら　<ROCKET><NI>くれば"
	cont "かんぶ<NI>だ<TTE>　なれるかもよ"
	done

RocketBaseBossRetreatText:
	text "<⋯>　こ<NO>アジトも　おわりね"

	para "まあ　いいわ"
	line "でんぱ<NO>じっけんも"
	cont "うまく　いったようだし"
	cont "こんな　アジト　どうな<TTE>もいいわ"

	para "わたくしたちの"
	line "ねらい<WA>もっと　おおきいの"

	para "<ROCKET><NO>おそろしさ"
	line "いずれ　わからせて　あげるわよ"

	para "そのとき<WO>たのしみにね<⋯>"
	line "フフフ"
	done

RocketBaseLancePostBattleText:
	text "ワタル『ふう　これで"
	line "アジト<NO>なか<NO><ROCKET>いん"
	cont "すべて　たおしただろ"

	para "とちゅうで　たたかった"
	line "しょうねん<GA>き<NI>なるが<⋯>"
	done

RocketBaseLancePowerOffText:
	text "わるかったね　<PLAYER>くん"
	line "きみ<GA>がんば<TTE>いるの<WO>みて"
	cont "ちょっと　でばん<WO>ま<TTE>みたのさ"

	para "さて　あとは"
	line "おかしな　でんぱ<WO>とめるだけか<⋯>"
	done

RockerBaseLanceElectrodeFaintText:
	text "これ<GA>そうち<⋯>"
	line "スイッチ<WA>みあたらないな"

	para "しかたない"
	line "マルマイン<WO>きぜつ　させよう"

	para "そうすれば　おかしな"
	line "でんぱも　でなくなるだろう"

	para "#<GA>わるいわけ　じゃないから"
	line "ちょっと　き<NI>なるけどね"

	para "<PLAYER>くん"
	line "はんぶん　ずつと　いこう"
	done

RocketBaseLancesSideText:
	text "ワタル『こっち<WA>まかせてくれよ"
	done

RocketBaseLanceElectrodeDoneText:
	text "ワタル『ようやく"
	line "おかしな　でんぱも　とまった"

	para "これで　みずうみも"
	line "もと<NO>すがた<NI>もどっただろう"
	cont "きみ<NO>おかげさ"

	para "#<NI>かわ<TTE>"
	line "れい<WO>いうよ！"

	para "そうだ！"
	line "これ<WO>も<TTE>いきなよ！"

	para "さっき　みつけたんだが"
	line "おれに<WA>ひつよう　ないからさ"
	done

RocketBaseReceivedHM06Text: ; unreferenced
	text "<PLAYER><WA>ワタルから"
	line "ひでんマシン０６<WO>もらっ<TA!>"
	done

RocketBaseLanceWhirlpoolText:
	text "そいつ<WA>うずしお！"

	para "#<NI>おしえれば"
	line "あれた　みず<NO>うえも　すすめる！"

	para "ただし　チョウジの"
	line "ジムバッジ<WO>も<TTE>いないと"
	cont "つかえないから　き<WO>つけなよ"
	done

RocketBaseLanceMonMasterText:
	text "<PLAYER>くん！"

	para "#マスターへの"
	line "みち<WA>ながく　けわしい　という<⋯>"
	cont "それでも　めざすのか？"

	para "<⋯>　<⋯>　<⋯>　<⋯>"
	line "そうか"
	cont "そうだよな"

	para "あきらめる　くらい　なら"
	line "さいしょ　から　ゆめ　みないよな"

	para "じゃあ　また　あおう！"
	done

LanceHealsText1:
	text "ワタル『だいじょうぶかい？"

	para "きみ<NO>#"
	line "だいぶ　きずついてるな"
	cont "おれ<NO>くすり<WO>わけてやるよ"
	done

LanceHealsText2:
	text "ワタル『さあ　<PLAYER>くん"
	line "#のため　がんばろう！"
	done

GruntM17SeenText:
	text "とびら<GA>ひらかない？"

	para "そりゃ　そうだ"
	line "<ROCKET>　だけ<GA>し<TTE>いる"
	cont "パスワード<GA>ひつよう　だからな"
	done

GruntM17BeatenText:
	text "ま　まけた？"
	done

GruntM17AfterBattleText:
	text "おれ　したっぱ　なんでね"
	line "パスワード<WA>おしえてもら<TTE>ねえよ"
	cont "ざんねん　だったな"
	done

GruntM18SeenText:
	text "うう　こどもか<⋯>"
	line "なんとなく　イヤな　かんじだが"
	cont "じゃまもの<WA>たおさねば！"
	done

GruntM18BeatenText:
	text "うう　やっぱり　まけた"
	done

GruntM18AfterBattleText:
	text "うう　このまえ<NO>にんむで"
	line "#　ぬすんでる　ときも"
	cont "めつき<GA>するどくて"
	cont "あかくて　ながい　かみ<NO>こどもに"
	cont "コテンパン<NI>されたしよお<⋯>"
	done

GruntM19SeenText:
	text "ウロチョロと　めざわり　なんだよ！"
	done

GruntM19BeatenText:
	text "ぐがぎぎ<⋯>"
	done

GruntM19AfterBattleText:
	text "そこ<NO>とびら<NO>パスワードを"
	line "し<TTE>いるの<WA>ボス　だけさ"

	para "ボス<NO>いばしょ？"
	line "さあね　じぶんで　さがしなよ"
	done

RocketBaseDoorNoPasswordText:
	text "とびら<GA>しま<TTE>いる<⋯>"

	para "あけるには"
	line "パスワード<GA>１つ　ひつようだ"
	done

RocketBaseDoorKnowPasswordText:
	text "とびら<GA>しま<TTE>いる<⋯>"

	para "<PLAYER>は"
	line "パスワード<WO>にゅうりょくした"

	para "とびら<GA>ひらい<TA!>"
	done

RocketBaseB2FTransmitterText:
	text "かいでんぱ　はっせい　そうち"
	line "がんがん　どうさ　している"
	done

RocketBaseB2FDeactivateTransmitterText:
	text "かいでんぱ　はっせい　そうち"
	line "どうやら　とまったようだ"
	done

TeamRocketBaseB2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3, 14, TEAM_ROCKET_BASE_B1F, 2
	warp_event  3,  2, TEAM_ROCKET_BASE_B3F, 1
	warp_event 27,  2, TEAM_ROCKET_BASE_B3F, 2
	warp_event  3,  6, TEAM_ROCKET_BASE_B3F, 3
	warp_event 27, 14, TEAM_ROCKET_BASE_B3F, 4

	def_coord_events
	coord_event  5, 14, SCENE_TEAMROCKETBASEB2F_LANCE_HEALS, LanceHealsScript1
	coord_event  4, 13, SCENE_TEAMROCKETBASEB2F_LANCE_HEALS, LanceHealsScript2
	coord_event 14, 11, SCENE_TEAMROCKETBASEB2F_ROCKET_BOSS, RocketBaseBossFLeft
	coord_event 15, 11, SCENE_TEAMROCKETBASEB2F_ROCKET_BOSS, RocketBaseBossFRight
	coord_event 14, 12, SCENE_TEAMROCKETBASEB2F_ELECTRODES, RocketBaseCantLeaveScript
	coord_event 15, 12, SCENE_TEAMROCKETBASEB2F_ELECTRODES, RocketBaseCantLeaveScript
	coord_event 12,  3, SCENE_TEAMROCKETBASEB2F_ELECTRODES, RocketBaseLancesSideScript
	coord_event 12, 10, SCENE_TEAMROCKETBASEB2F_ELECTRODES, RocketBaseLancesSideScript
	coord_event 12, 11, SCENE_TEAMROCKETBASEB2F_ELECTRODES, RocketBaseLancesSideScript

	def_bg_events
	bg_event 14, 12, BGEVENT_IFNOTSET, TeamRocketBaseB2FLockedDoor
	bg_event 15, 12, BGEVENT_IFNOTSET, TeamRocketBaseB2FLockedDoor
	bg_event 17,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 16,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 15,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 14,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 13,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  9, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  8, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  7, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  6, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  5, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 12,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 13,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 14,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 15,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 16,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 17,  4, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 17,  5, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 17,  6, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 17,  7, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 17,  8, BGEVENT_READ, TeamRocketBaseB2FTransmitterScript
	bg_event 26,  7, BGEVENT_ITEM, TeamRocketBaseB2FHiddenFullHeal

	def_object_events
	object_event 20, 16, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_GRUNT_WITH_EXECUTIVE
	object_event 20, 16, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_EXECUTIVE
	object_event  5, 13, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_LANCE
	object_event  9, 13, SPRITE_DRAGON, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_DRAGONITE
	object_event  7,  5, SPRITE_VOLTORB, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketElectrode1, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	object_event  7,  7, SPRITE_VOLTORB, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketElectrode2, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	object_event  7,  9, SPRITE_VOLTORB, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RocketElectrode3, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	object_event 22,  5, SPRITE_VOLTORB, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_1
	object_event 22,  7, SPRITE_VOLTORB, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_2
	object_event 22,  9, SPRITE_VOLTORB, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B2F_ELECTRODE_3
	object_event 25, 13, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM17, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  2,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM18, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 21, 14, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 4, TrainerGruntM19, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  3, 10, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB2FTMThief, EVENT_TEAM_ROCKET_BASE_B2F_TM_THIEF
