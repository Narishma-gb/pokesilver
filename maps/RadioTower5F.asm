	object_const_def
	const RADIOTOWER5F_DIRECTOR
	const RADIOTOWER5F_ROCKET
	const RADIOTOWER5F_ROCKET_GIRL
	const RADIOTOWER5F_ROCKER

RadioTower5F_MapScripts:
	def_scene_scripts
	scene_script RadioTower5FNoop1Scene, SCENE_RADIOTOWER5F_FAKE_DIRECTOR
	scene_script RadioTower5FNoop2Scene, SCENE_RADIOTOWER5F_ROCKET_BOSS
	scene_script RadioTower5FNoop3Scene, SCENE_RADIOTOWER5F_NOOP

	def_callbacks

RadioTower5FNoop1Scene:
	end

RadioTower5FNoop2Scene:
	end

RadioTower5FNoop3Scene:
	end

FakeDirectorScript:
	turnobject RADIOTOWER5F_DIRECTOR, UP
	showemote EMOTE_SHOCK, RADIOTOWER5F_DIRECTOR, 15
	opentext
	writetext FakeDirectorTextBefore1
	waitbutton
	closetext
	applymovement RADIOTOWER5F_DIRECTOR, FakeDirectorMovement
	playmusic MUSIC_ROCKET_ENCOUNTER
	opentext
	writetext FakeDirectorTextBefore2
	waitbutton
	closetext
	winlosstext FakeDirectorWinText, 0
	setlasttalked RADIOTOWER5F_DIRECTOR
	loadtrainer EXECUTIVEM, EXECUTIVEM_3
	startbattle
	reloadmapafterbattle
	opentext
	writetext FakeDirectorTextAfter
	promptbutton
	verbosegiveitem BASEMENT_KEY
	closetext
	setscene SCENE_RADIOTOWER5F_ROCKET_BOSS
	setevent EVENT_BEAT_ROCKET_EXECUTIVEM_3
	end

Director:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .TrueDirector
	writetext FakeDirectorTextAfter
	waitbutton
	closetext
	end

.TrueDirector:
	writetext RadioTower5FDirectorText
	waitbutton
	closetext
	end

TrainerExecutivef1:
	trainer EXECUTIVEF, EXECUTIVEF_1, EVENT_BEAT_ROCKET_EXECUTIVEF_1, Executivef1SeenText, Executivef1BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext Executivef1AfterBattleText
	waitbutton
	closetext
	end

RadioTower5FRocketBossScript:
	applymovement PLAYER, RadioTower5FPlayerTwoStepsLeftMovement
	playmusic MUSIC_ROCKET_ENCOUNTER
	turnobject RADIOTOWER5F_ROCKET, RIGHT
	opentext
	writetext RadioTower5FRocketBossBeforeText
	waitbutton
	closetext
	winlosstext RadioTower5FRocketBossWinText, 0
	setlasttalked RADIOTOWER5F_ROCKET
	loadtrainer EXECUTIVEM, EXECUTIVEM_1
	startbattle
	reloadmapafterbattle
	opentext
	writetext RadioTower5FRocketBossAfterText
	waitbutton
	closetext
	special FadeOutToBlack
	special ReloadSpritesNoPalettes
	disappear RADIOTOWER5F_ROCKET
	disappear RADIOTOWER5F_ROCKET_GIRL
	pause 15
	special FadeInFromBlack
	setevent EVENT_BEAT_ROCKET_EXECUTIVEM_1
	setevent EVENT_CLEARED_RADIO_TOWER
	clearflag ENGINE_ROCKETS_IN_RADIO_TOWER
	setevent EVENT_GOLDENROD_CITY_ROCKET_SCOUT
	setevent EVENT_GOLDENROD_CITY_ROCKET_TAKEOVER
	setevent EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	clearevent EVENT_MAHOGANY_MART_OWNERS
	clearflag ENGINE_ROCKETS_IN_MAHOGANY
	clearevent EVENT_GOLDENROD_CITY_CIVILIANS
	clearevent EVENT_RADIO_TOWER_CIVILIANS_AFTER
	setevent EVENT_BLACKTHORN_CITY_SUPER_NERD_BLOCKS_GYM
	clearevent EVENT_BLACKTHORN_CITY_SUPER_NERD_DOES_NOT_BLOCK_GYM
	special PlayMapMusic
	disappear RADIOTOWER5F_DIRECTOR
	moveobject RADIOTOWER5F_DIRECTOR, 12, 0
	appear RADIOTOWER5F_DIRECTOR
	applymovement RADIOTOWER5F_DIRECTOR, RadioTower5FDirectorWalksIn
	turnobject PLAYER, RIGHT
	opentext
	writetext RadioTower5FDirectorThankYouText
	promptbutton
	checkver
	iftrue .SilverWing
	verbosegiveitem RAINBOW_WING
	writetext RadioTower5FDirectorDescribeRainbowWingText
	waitbutton
	closetext
	setscene SCENE_RADIOTOWER5F_NOOP
	setevent EVENT_GOT_RAINBOW_WING
	setevent EVENT_TEAM_ROCKET_DISBANDED
	sjump .GotWing

.SilverWing:
	verbosegiveitem SILVER_WING
	writetext RadioTower5FDirectorDescribeSilverWingText
	waitbutton
	closetext
	setscene SCENE_RADIOTOWER5F_NOOP
	setevent EVENT_GOT_SILVER_WING
.GotWing:
	applymovement RADIOTOWER5F_DIRECTOR, RadioTower5FDirectorWalksOut
	playsound SFX_EXIT_BUILDING
	disappear RADIOTOWER5F_DIRECTOR
	end

Ben:
	jumptextfaceplayer BenText

RadioTower5FDirectorsOfficeSign:
	jumptext RadioTower5FDirectorsOfficeSignText

RadioTower5FStudio1Sign:
	jumptext RadioTower5FStudio1SignText

RadioTower5FBookshelf:
	jumpstd MagazineBookshelfScript

FakeDirectorMovement:
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step_end

RadioTower5FDirectorWalksIn:
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step LEFT
	step_end

RadioTower5FDirectorWalksOut:
	step RIGHT
	step UP
	step UP
	step UP
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step_end

RadioTower5FPlayerTwoStepsLeftMovement:
	step LEFT
	step LEFT
	step_end

FakeDirectorTextBefore1:
	text "き　きみは！"
	line "たすけ<NI>きてくれたのか<⋯>"
	done

FakeDirectorTextBefore2:
	text "なんて　いわれるとでも　おもったか！"
	line "おれさま<WA>にせものだ！"

	para "ほんもの<NO>ふり<WO>して"
	line "のっとる　じゅんび<WO>していたのだ"

	para "はーは<WA>きょくちょうの"
	line "いばしょ<WO>しりたいか！"

	para "いいぜ　おしえてやろう"
	line "ただし　おれさま<NI>かてたらな！"
	done

FakeDirectorWinText:
	text "わ　わかった<⋯>"
	line "きょくちょう<NO>いばしょ　おしえる"
	done

FakeDirectorTextAfter:
	text "ほんもの<NO>きょくちょうは<⋯>"

	para "ちかそうこ<NI>とじこめている！"

	para "ちかそうこ　わかるか？"
	line "ちかつうろ<NO>おく<NO>さら<NI>おく"
	cont "そこまで　たどりつけるかな<⋯>"
	done

Executivef1SeenText:
	text "あら　ぼうや？"
	line "チョウジ<NO>アジトで　あったわね"

	para "あのとき<WA>まけたけど"
	line "こんど<WA>そう<WA>いかないわよ"
	done

Executivef1BeatenText:
	text "<⋯>！"

	para "ぜんりょくで　たたかったのに<⋯>"
	line "まさか　まけるだ　なんて<⋯>"
	done

Executivef1AfterBattleText:
	text "<PLAYER><TTE>　いったわね"

	para "あなたのような　ぼうや　には"
	line "わたくしたち<NO>すばらしさ"
	cont "りかい　できないようね"

	para "ざんねんだわ"
	line "あなた<NO>つよさ　きにい<TTE>たのに"
	done

RadioTower5FRocketBossBeforeText:
	text "おやおや　ここまで　きましたか"

	para "なかなか　ゆうしゅうな"
	line "<TRAINER><NO>ようですね"

	para "われわれ<WA>ラジオきょくを"
	line "のっとり　ぜんこくに"
	cont "ふっかつ　せんげん<WO>するのです"

	para "そうすれば　どこかで"
	line "しゅぎょうちゅう<NO>サカキさまも"
	cont "もどられる<NI>ちがいない"

	para "あ<NO>むかし<NO>えいこうを"
	line "とりもどすのです<⋯>"
	cont "そ<NO>じゃま<WA>させませんよ！"
	done

RadioTower5FRocketBossWinText:
	text "<⋯>　ぐう"
	line "サカキさま　おゆるしください<⋯>"
	done

RadioTower5FRocketBossAfterText:
	text "<⋯>　ああ　なんという　ことだ"

	para "すべて<NO>ゆめが"
	line "いま　おわりましたよ"
	cont "　"
	line "やはり　<WATASHI>で<WA>むり　でしたか"

	para "わかりました"
	line "サカキさま<GA>そうしたように"
	cont "<WATASHI>たち　<ROCKET>は"
	cont "ここで　かいさん　しましょう"

	para "さらばです"
	done

RadioTower5FDirectorThankYouText:
	text "きょくちょう『おお　<PLAYER>くん"
	line "ほんと　ありがとう　れいをいうよ"

	para "きみ<NO>ゆうきある　こうどうが"
	line "ぜんこくの#<WO>すくったんだ"

	para "これ<WA>わずかばかりだけど"
	line "<WATASHI><NO>きもちだよ"
	done

RadioTower5FDirectorDescribeRainbowWingText:
	text "コガネにも　とう<GA>あったが"
	line "ふるくて　たおれそう　だったから"
	cont "ラジオとう<NI>したんだよ"

	para "そ<NO>こうじ<NO>とき"
	line "とう<NO>いちばん　うえで"
	cont "みつかったの<GA>そのハネ　なんだ"

	para "むかし<WA>コガネでも"
	line "おおきな　#が"
	cont "とんでいた　というからね"

	para "ひょっとしたら　エンジュにある"
	line "スズのとう<NI>あらわれる　という"
	cont "#<GA>おとしたモノ　かもね"

	para "で<WA><WATASHI>は"
	line "きょくちょうしつ<NI>もどるよ"
	done

RadioTower5FDirectorDescribeSilverWingText:
	text "コガネにも　とう<GA>あったが"
	line "ふるくて　たおれそう　だったから"
	cont "ラジオとう<NI>したんだよ"

	para "そ<NO>こうじ<NO>とき"
	line "とう<NO>いちばん　うえで"
	cont "みつかったの<GA>そのハネ　なんだ"

	para "むかし<WA>コガネでも"
	line "おおきな　#が"
	cont "とんでいた　というからね"

	para "ひょっとしたら　タンバ<NO>ちかく"
	line "うずまきじま<NI>あらわれる　という"
	cont "#<GA>おとしたモノ　かもね"

	para "で<WA><WATASHI>は"
	line "きょくちょうしつ<NI>もどるよ"
	done

RadioTower5FDirectorText:
	text "きょくちょう『<PLAYER>くん"
	line "<WATASHI><WA>#<GA>すきで　すきで"
	cont "そ<NO>きもち<WO>つたえたくて"
	cont "ラジオほうそう<WO>はじめたんだ！"

	para "みんな<GA>ばんぐみを"
	line "たのしんでくれると　うれしいね"
	done

BenText:
	text "セージ『おんがく　きいてる？"
	done

RadioTower5FDirectorsOfficeSignText:
	text "５かい　<⋯>　きょくちょうしつ"
	done

RadioTower5FStudio1SignText:
	text "５かい　<⋯>　だい１スタジオ"
	done

RadioTower5F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  0, RADIO_TOWER_4F, 1
	warp_event 12,  0, RADIO_TOWER_4F, 3

	def_coord_events
	coord_event  0,  3, SCENE_RADIOTOWER5F_FAKE_DIRECTOR, FakeDirectorScript
	coord_event 16,  5, SCENE_RADIOTOWER5F_ROCKET_BOSS, RadioTower5FRocketBossScript

	def_bg_events
	bg_event  3,  0, BGEVENT_READ, RadioTower5FDirectorsOfficeSign
	bg_event 11,  0, BGEVENT_READ, RadioTower5FStudio1Sign
	bg_event 15,  0, BGEVENT_READ, RadioTower5FStudio1Sign
	bg_event 16,  1, BGEVENT_READ, RadioTower5FBookshelf
	bg_event 17,  1, BGEVENT_READ, RadioTower5FBookshelf

	def_object_events
	object_event  3,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Director, -1
	object_event 13,  5, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 17,  2, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerExecutivef1, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 13,  5, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Ben, EVENT_RADIO_TOWER_CIVILIANS_AFTER
