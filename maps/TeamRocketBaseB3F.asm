	object_const_def
	const TEAMROCKETBASEB3F_LANCE
	const TEAMROCKETBASEB3F_ROCKET1
	const TEAMROCKETBASEB3F_MOLTRES
	const TEAMROCKETBASEB3F_ROCKET_GIRL
	const TEAMROCKETBASEB3F_ROCKET2
	const TEAMROCKETBASEB3F_SCIENTIST1
	const TEAMROCKETBASEB3F_SCIENTIST2
	const TEAMROCKETBASEB3F_ROCKET3
	const TEAMROCKETBASEB3F_RIVAL
	const TEAMROCKETBASEB3F_POKE_BALL1
	const TEAMROCKETBASEB3F_POKE_BALL2
	const TEAMROCKETBASEB3F_POKE_BALL3
	const TEAMROCKETBASEB3F_POKE_BALL4

TeamRocketBaseB3F_MapScripts:
	def_scene_scripts
	scene_script TeamRocketBaseB3FLanceGetsPasswordScene, SCENE_TEAMROCKETBASEB3F_LANCE_GETS_PASSWORD
	scene_script TeamRocketBaseB3FNoop1Scene,             SCENE_TEAMROCKETBASEB3F_RIVAL_ENCOUNTER
	scene_script TeamRocketBaseB3FNoop2Scene,             SCENE_TEAMROCKETBASEB3F_ROCKET_BOSS
	scene_script TeamRocketBaseB3FNoop3Scene,             SCENE_TEAMROCKETBASEB3F_NOOP

	def_callbacks
	callback MAPCALLBACK_TILES, TeamRocketBaseB3FCheckGiovanniDoorCallback

TeamRocketBaseB3FLanceGetsPasswordScene:
	sdefer LanceGetPasswordScript
	end

TeamRocketBaseB3FNoop1Scene:
	end

TeamRocketBaseB3FNoop2Scene:
	end

TeamRocketBaseB3FNoop3Scene:
	end

TeamRocketBaseB3FCheckGiovanniDoorCallback:
	checkevent EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE
	iftrue .OpenSesame
	endcallback

.OpenSesame:
	changeblock 10, 8, $07 ; floor
	endcallback

LanceGetPasswordScript:
	turnobject PLAYER, LEFT
	pause 5
	turnobject TEAMROCKETBASEB3F_MOLTRES, RIGHT
	pause 20
	applymovement TEAMROCKETBASEB3F_LANCE, RocketBaseLanceApproachesPlayerMovement
	opentext
	writetext LanceGetPasswordText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB3F_LANCE, RocketBaseLanceLeavesMovement
	disappear TEAMROCKETBASEB3F_LANCE
	setscene SCENE_TEAMROCKETBASEB3F_RIVAL_ENCOUNTER
	end

RocketBaseRival:
	turnobject PLAYER, LEFT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	appear TEAMROCKETBASEB3F_RIVAL
	applymovement TEAMROCKETBASEB3F_RIVAL, RocketBaseRivalEnterMovement
	turnobject PLAYER, LEFT
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext RocketBaseRivalText
	waitbutton
	closetext
	playsound SFX_TACKLE
	applymovement PLAYER, RocketBaseRivalShovesPlayerMovement
	applymovement TEAMROCKETBASEB3F_RIVAL, RocketBaseRivalLeavesMovement
	disappear TEAMROCKETBASEB3F_RIVAL
	setscene SCENE_TEAMROCKETBASEB3F_ROCKET_BOSS
	special RestartMapMusic
	end

TeamRocketBaseB3FRocketScript:
	jumptextfaceplayer TeamRocketBaseB3FRocketText

RocketBaseBossLeft:
	applymovement PLAYER, RocketBasePlayerApproachesBossLeftMovement
	sjump RocketBaseBoss

RocketBaseBossRight:
	applymovement PLAYER, RocketBasePlayerApproachesBossRightMovement
RocketBaseBoss:
	pause 30
	showemote EMOTE_SHOCK, TEAMROCKETBASEB3F_ROCKET1, 15
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject TEAMROCKETBASEB3F_ROCKET1, DOWN
	opentext
	writetext ExecutiveM4BeforeText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB3F_ROCKET1, RocketBaseBossApproachesPlayerMovement
	winlosstext ExecutiveM4BeatenText, 0
	setlasttalked TEAMROCKETBASEB3F_ROCKET1
	loadtrainer EXECUTIVEM, EXECUTIVEM_4
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_ROCKET_EXECUTIVEM_4
	opentext
	writetext ExecutiveM4AfterText
	waitbutton
	closetext
	applymovement TEAMROCKETBASEB3F_ROCKET1, RocketBaseBossHitsTableMovement
	playsound SFX_TACKLE
	applymovement TEAMROCKETBASEB3F_ROCKET1, RocketBaseBossLeavesMovement
	disappear TEAMROCKETBASEB3F_ROCKET1
	setscene SCENE_TEAMROCKETBASEB3F_NOOP
	end

RocketBaseMurkrow:
	opentext
	writetext RocketBaseMurkrowText
	waitbutton
	closetext
	setevent EVENT_LEARNED_HAIL_GIOVANNI
	end

SlowpokeTailGrunt:
	trainer GRUNTF, GRUNTF_5, EVENT_BEAT_ROCKET_GRUNTF_5, GruntF5SeenText, GruntF5BeatenText, 0, GruntF5Script

GruntF5Script:
	endifjustbattled
	opentext
	writetext GruntF5AfterBattleText
	waitbutton
	closetext
	setevent EVENT_LEARNED_SLOWPOKETAIL
	end

RaticateTailGrunt:
	trainer GRUNTM, GRUNTM_28, EVENT_BEAT_ROCKET_GRUNTM_28, GruntM28SeenText, GruntM28BeatenText, 0, GruntM28Script

GruntM28Script:
	endifjustbattled
	opentext
	writetext GruntM28AfterBattleText
	waitbutton
	closetext
	setevent EVENT_LEARNED_RATICATE_TAIL
	end

TrainerScientistRoss:
	trainer SCIENTIST, ROSS, EVENT_BEAT_SCIENTIST_ROSS, ScientistRossSeenText, ScientistRossBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext ScientistRossAfterBattleText
	waitbutton
	closetext
	end

TrainerScientistMitch:
	trainer SCIENTIST, MITCH, EVENT_BEAT_SCIENTIST_MITCH, ScientistMitchSeenText, ScientistMitchBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext ScientistMitchAfterBattleText
	waitbutton
	closetext
	end

TeamRocketBaseB3FLockedDoor:
	conditional_event EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE, .Script

.Script:
	opentext
	checkevent EVENT_LEARNED_SLOWPOKETAIL
	iffalse .NeedsPassword
	checkevent EVENT_LEARNED_RATICATE_TAIL
	iffalse .NeedsPassword
	sjump .OpenSesame

.NeedsPassword:
	writetext TeamRocketBaseB3FLockedDoorNeedsPasswordText
	waitbutton
	closetext
	end

.OpenSesame:
	writetext TeamRocketBaseB3FLockedDoorOpenSesameText
	waitbutton
	playsound SFX_ENTER_DOOR
	changeblock 10, 8, $07 ; floor
	refreshmap
	closetext
	setevent EVENT_OPENED_DOOR_TO_GIOVANNIS_OFFICE
	waitsfx
	end

TeamRocketBaseB3FOathScript:
	jumpstd TeamRocketOathScript

TeamRocketBaseB3FFullHeal:
	itemball FULL_HEAL

TeamRocketBaseB3FDireHit:
	itemball DIRE_HIT

TeamRocketBaseB3FProtein:
	itemball PROTEIN

TeamRocketBaseB3FIceHeal:
	itemball ICE_HEAL

RocketBaseLanceApproachesPlayerMovement:
	step RIGHT
	step_end

RocketBaseLanceLeavesMovement:
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

RocketBasePlayerApproachesBossLeftMovement:
	step UP
	step UP
	step UP
	step LEFT
	step LEFT
	turn_head UP
	step_end

RocketBasePlayerApproachesBossRightMovement:
	step UP
	step UP
	step LEFT
	step UP
	step LEFT
	step LEFT
	turn_head UP
	step_end

RocketBaseBossApproachesPlayerMovement:
	step DOWN
	step_end

RocketBaseBossHitsTableMovement:
	big_step RIGHT
	big_step RIGHT
	step_end

RocketBaseBossLeavesMovement:
	fix_facing
	fast_jump_step LEFT
	remove_fixed_facing
	step_sleep 8
	step_sleep 8
	slow_step RIGHT
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step RIGHT
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step LEFT
	big_step LEFT
	step_end

RocketBaseRivalEnterMovement:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

RocketBaseRivalLeavesMovement:
	step LEFT
	step LEFT
	step UP
	step UP
	step UP
	step UP
	step UP
	step_end

RocketBaseRivalShovesPlayerMovement:
	fix_facing
	big_step RIGHT
	remove_fixed_facing
	step_end

LanceGetPasswordText:
	text "ワタル『ボス<NO>へや<NI>はいるには"
	line "とびら<NO>パスワードが"
	cont "２つ　ひつよう　らしいな"

	para "そ<NO>パスワードは"
	line "いちぶ<NO><ROCKET>いん　だけに"
	cont "しらされてるらしい"

	para "そこ<NO><ROCKET>いんが"
	line "ていねい<NI>おしえてくれたよ"

	para "<PLAYER>くん！　がんば<TTE>"
	line "ききだすと　しよう！"
	done

TeamRocketBaseB3FRocketText:
	text "ううう<⋯>"
	line "マント<NO>おとこ　つよすぎるぜ<⋯>"
	done

RocketBaseRivalText:
	text "<⋯>　<⋯>　<⋯>"

	para "<ROCKET><WO>つぶすのは"
	line "オレだ　<TTE>　いっただろ"

	para "<⋯>　それよりも"
	line "あ<NO>マント<NO>ドラゴンつかい"
	cont "あいつ<WA>いったい　なにも<NO>だ？"

	para "オレ<NO>#が"
	line "まったく　は<GA>たたなかった<⋯>"

	para "まけたの<WA>どうでも　いい"
	line "もっと　もっと"
	cont "つよい　#　て<NI>いれれば"
	cont "あいつ<NI>だ<TTE>　かてる"

	para "それよりも　き<NI>いらないのは"
	line "あ<NO>セリフ<⋯>"

	para "きみ<WA>#への"
	line "あいと　しんらい<GA>たりない　だと"

	para "あんな　あまいこと　いう　やつに"
	line "まけたかと　おもうと　はらがたつ！"

	para "<⋯>　フン！　おまえの"
	line "あいて　なんか　してられるかよ！"
	done

ExecutiveM4BeforeText:
	text "なんだ　おまえは？"
	line "<KOKO_WA>おれら<NO>ボス"
	cont "サカキさま<NO>へや"

	para "サカキさま<WA>３ねんまえ"
	line "かいさんせんげん<WO>したまま"
	cont "いまも　しゅぎょうちゅう<⋯>"

	para "だ<GA>いつ<NO>ひか"
	line "おもどり<NI>なられるの<WO>しんじて"
	cont "こうして　るす<WO>まも<TTE>るのだ"

	para "どんな　やつ<NI>だ<TTE>"
	line "ここ<WO>あらされて　たまるか！"
	done

ExecutiveM4BeatenText:
	text "ぐうう<⋯>"
	line "まったく　は<GA>たたない"

	para "サカキさま"
	line "おゆるし　ください<⋯>"
	done

ExecutiveM4AfterText:
	text "いかん"
	line "まけて　おちこんでる　ばあいじゃない"
	cont "なかま<NI>しらせなくては<⋯>"
	done

RocketBaseMurkrowText:
	text "ヤミカラス『パスワード　ハ<⋯>"

	para "サカキさま　ばんざい"
	done

GruntF5SeenText:
	text "パスワード<WO>し<TTE>いるのか<TTE>？"
	line "そうね　し<TTE>るかもよ"

	para "でもね　よわい　やつには"
	line "おしえてなんか　あげないわよ！"
	done

GruntF5BeatenText:
	text "わかったわよ"
	line "おしえれば　いいんでしょ"
	done

GruntF5AfterBattleText:
	text "ボス<NO>とびら<NO>パスワードは<⋯>"

	para "ヤドンのシッポ"

	para "ただし　２つ　そろわないと"
	line "ぜーんぜん　いみ　ないけどね"
	done

GruntM28SeenText:
	text "ひゃひゃひゃ！"

	para "おれさま<WO>たおそう　<TTE>のか？"
	line "いい　どきょう　だな"

	para "きにいっ<TA!>"
	line "おれ<NI>かったら"
	cont "ボス<NO>とびら<NO>パスワード"
	cont "おしえてやるぜ！"
	done

GruntM28BeatenText:
	text "ひゃひゃひゃ！"
	line "やるじゃねーか！"
	done

GruntM28AfterBattleText:
	text "ひゃひゃひゃ！"

	para "ボス<NO>とびら<NO>パスワード"
	line "おしえてやるよ"
	cont "たしか　ラッタのシッポ　だぜ"
	done

ScientistRossSeenText:
	text "むかし<WA>シルフで"
	line "いま<WA><ROCKET>で"
	cont "こうして　じっけん<WO>している"

	para "じゃま　する　こども<WA>おしおきだね"
	done

ScientistRossBeatenText:
	text "いけない<⋯>"
	line "さくせん　ミス　だな"
	done

ScientistRossAfterBattleText:
	text "#<WO>くるわせる　でんぱ<⋯>"

	para "じっけん<WA>せいこう"
	line "<WATASHI>も　しゅっせ　まちがいなし"
	cont "まけたくらい　どうでも　いいか"
	done

ScientistMitchSeenText:
	text "じっけんで　#<GA>くるしんでも"
	line "<WATASHI>に<WA>かんけい　ない"
	done

ScientistMitchBeatenText:
	text "かんがえるの<WA>とくい　だが"
	line "たたかうの<WA>にがて　だ"
	done

ScientistMitchAfterBattleText:
	text "おかしな　でんぱ<WO>パワーアップして"
	line "ぜんこく<NI>ながせば<⋯>"

	para "そうぞう　しただけで　わくわくする"
	done

TeamRocketBaseB3FLockedDoorNeedsPasswordText:
	text "とびら<GA>しま<TTE>いる<⋯>"

	para "あけるに<WA>"
	line "パスワード<GA>２つ　ひつようだ"
	done

TeamRocketBaseB3FLockedDoorOpenSesameText:
	text "とびら<GA>しま<TTE>いる<⋯>"

	para "<PLAYER><WA>２つの"
	line "パスワード<WO>にゅうりょくした"

	para "とびら<GA>ひらい<TA!>"
	done

TeamRocketBaseB3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  2, TEAM_ROCKET_BASE_B2F, 2
	warp_event 27,  2, TEAM_ROCKET_BASE_B2F, 3
	warp_event  3,  6, TEAM_ROCKET_BASE_B2F, 4
	warp_event 27, 14, TEAM_ROCKET_BASE_B2F, 5

	def_coord_events
	coord_event 10,  8, SCENE_TEAMROCKETBASEB3F_ROCKET_BOSS, RocketBaseBossLeft
	coord_event 11,  8, SCENE_TEAMROCKETBASEB3F_ROCKET_BOSS, RocketBaseBossRight
	coord_event  8, 10, SCENE_TEAMROCKETBASEB3F_RIVAL_ENCOUNTER, RocketBaseRival

	def_bg_events
	bg_event 10,  9, BGEVENT_IFNOTSET, TeamRocketBaseB3FLockedDoor
	bg_event 11,  9, BGEVENT_IFNOTSET, TeamRocketBaseB3FLockedDoor
	bg_event 10,  1, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event 11,  1, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event 12,  1, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event 13,  1, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event  4, 13, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event  5, 13, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event  6, 13, BGEVENT_READ, TeamRocketBaseB3FOathScript
	bg_event  7, 13, BGEVENT_READ, TeamRocketBaseB3FOathScript

	def_object_events
	object_event 25, 14, SPRITE_LANCE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LanceGetPasswordScript, EVENT_TEAM_ROCKET_BASE_B3F_LANCE_PASSWORDS
	object_event  8,  3, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEAM_ROCKET_BASE_B3F_EXECUTIVE
	object_event  7,  2, SPRITE_MOLTRES, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RocketBaseMurkrow, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 21,  7, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 0, SlowpokeTailGrunt, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  5, 15, SPRITE_ROCKET, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, RaticateTailGrunt, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 25, 12, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerScientistRoss, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 14, 15, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerScientistMitch, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event 24, 14, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TeamRocketBaseB3FRocketScript, EVENT_TEAM_ROCKET_BASE_POPULATION
	object_event  4,  5, SPRITE_RIVAL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_TEAM_ROCKET_BASE
	object_event  1, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB3FFullHeal, EVENT_TEAM_ROCKET_BASE_B3F_FULL_HEAL
	object_event  3, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB3FDireHit, EVENT_TEAM_ROCKET_BASE_B3F_DIRE_HIT
	object_event 28,  9, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB3FProtein, EVENT_TEAM_ROCKET_BASE_B3F_PROTEIN
	object_event 17,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TeamRocketBaseB3FIceHeal, EVENT_TEAM_ROCKET_BASE_B3F_ICE_HEAL
