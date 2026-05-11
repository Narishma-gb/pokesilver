	object_const_def
	const ROUTE41_OLIVINE_RIVAL1
	const ROUTE41_OLIVINE_RIVAL2
	const ROUTE41_OLIVINE_RIVAL3
	const ROUTE41_OLIVINE_RIVAL4
	const ROUTE41_OLIVINE_RIVAL5
	const ROUTE41_SWIMMER_GIRL1
	const ROUTE41_SWIMMER_GIRL2
	const ROUTE41_SWIMMER_GIRL3
	const ROUTE41_SWIMMER_GIRL4
	const ROUTE41_SWIMMER_GIRL5

Route41_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerSwimmerfKaylee:
	trainer SWIMMERF, KAYLEE, EVENT_BEAT_SWIMMERF_KAYLEE, SwimmerfKayleeSeenText, SwimmerfKayleeBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmerfKayleeAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmerfSusie:
	trainer SWIMMERF, SUSIE, EVENT_BEAT_SWIMMERF_SUSIE, SwimmerfSusieSeenText, SwimmerfSusieBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmerfSusieAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmerfDenise:
	trainer SWIMMERF, DENISE, EVENT_BEAT_SWIMMERF_DENISE, SwimmerfDeniseSeenText, SwimmerfDeniseBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmerfDeniseAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmerfKara:
	trainer SWIMMERF, KARA, EVENT_BEAT_SWIMMERF_KARA, SwimmerfKaraSeenText, SwimmerfKaraBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmerfKaraAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmerfWendy:
	trainer SWIMMERF, WENDY, EVENT_BEAT_SWIMMERF_WENDY, SwimmerfWendySeenText, SwimmerfWendyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmerfWendyAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmermCharlie:
	trainer SWIMMERM, CHARLIE, EVENT_BEAT_SWIMMERM_CHARLIE, SwimmermCharlieSeenText, SwimmermCharlieBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmermCharlieAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmermGeorge:
	trainer SWIMMERM, GEORGE, EVENT_BEAT_SWIMMERM_GEORGE, SwimmermGeorgeSeenText, SwimmermGeorgeBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmermGeorgeAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmermBerke:
	trainer SWIMMERM, BERKE, EVENT_BEAT_SWIMMERM_BERKE, SwimmermBerkeSeenText, SwimmermBerkeBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmermBerkeAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmermKirk:
	trainer SWIMMERM, KIRK, EVENT_BEAT_SWIMMERM_KIRK, SwimmermKirkSeenText, SwimmermKirkBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmermKirkAfterBattleText
	waitbutton
	closetext
	end

TrainerSwimmermMathew:
	trainer SWIMMERM, MATHEW, EVENT_BEAT_SWIMMERM_MATHEW, SwimmermMathewSeenText, SwimmermMathewBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SwimmermMathewAfterBattleText
	waitbutton
	closetext
	end

Route41Rock: ; unreferenced
	jumpstd SmashRockScript

Route41HiddenMaxEther:
	hiddenitem MAX_ETHER, EVENT_ROUTE_41_HIDDEN_MAX_ETHER

SwimmermCharlieSeenText:
	text "ここいら<NO>うみ<WA>あたたかい"
	line "からだも　ほぐれて　いい　かんじだ"
	cont "ちょっと　あいて　してやろう！"
	done

SwimmermCharlieBeatenText:
	text "ふ　ふやけた<⋯>"
	done

SwimmermCharlieAfterBattleText:
	text "こうや<TTE>　うかんでると"
	line "ここち　いい　よな"
	done

SwimmermGeorgeSeenText:
	text "ちょっと　つかれてきた"
	line "ぼく<GA>かったら"
	cont "きみ<NO>#<WO>かしてくれない？"
	done

SwimmermGeorgeBeatenText:
	text "はあ　はあ"
	done

SwimmermGeorgeAfterBattleText:
	text "タンバ　まで　とおいなあ"
	line "アサギ<NI>もどるのも　つらそうだし"
	cont "どうしようかな？"
	done

SwimmermBerkeSeenText:
	text "うずで　かこまれた　しま"
	line "ひみつ<GA>あると　おもわんか？"
	done

SwimmermBerkeBeatenText:
	text "きみ<NO>つよさ"
	line "きっと　ひみつ<GA>あるー！"
	done

SwimmermBerkeAfterBattleText:
	text "あらし<NO>よる<NO>はなしだ"

	para "うずまきじま　から"
	line "おおきな　#が"
	cont "ぎんいろのはね<WO>ちらしながら"
	cont "とんでいった<NO>みたことあるよ"
	done

SwimmermKirkSeenText:
	text "こ<NO>うみ<WA>なみ<GA>はげしくて"
	line "およいでても　つかれちゃうよ"
	done

SwimmermKirkBeatenText:
	text "ば　ばてた"
	done

SwimmermKirkAfterBattleText:
	text "しお<NO>ながれ<NI>じゃま　されて"
	line "あ<NO>しま<NI>たどりつけないんだ"
	done

SwimmermMathewSeenText:
	text "きみも　うずまきじま<NO>ひみつを"
	line "さぐり<NI>きたのか？"
	done

SwimmermMathewBeatenText:
	text "うう　てごわい"
	done

SwimmermMathewAfterBattleText:
	text "うずまきじま<NO>ひみつ<⋯>"
	line "とりあえず　なか<WA>まっくらだ！"
	done

SwimmerfKayleeSeenText:
	text "ともだちと　いっしょに"
	line "うずまきじま<WO>たんけん　するの！"
	done

SwimmerfKayleeBeatenText:
	text "ふーん　そうなんだ"
	done

SwimmerfKayleeAfterBattleText:
	text "うずまきじま<NO>ちか　には"
	line "おっきな　#<GA>いるらしいけど"
	cont "どんな　#　かしら？"
	done

SwimmerfSusieSeenText:
	text "あら？　#<NI>の<TTE>"
	line "なんだか　ゆう<GA>ですわね"
	done

SwimmerfSusieBeatenText:
	text "がっかり　ですわ"
	done

SwimmerfSusieAfterBattleText:
	text "ラプラス<NI>のった　しょうねん"
	line "そんな　うた　なかったかしら？"
	done

SwimmerfDeniseSeenText:
	text "いい　てんき　なのよね<⋯>"
	line "うっとり　しちゃう"
	done

SwimmerfDeniseBeatenText:
	text "やーん"
	done

SwimmerfDeniseAfterBattleText:
	text "ひやけ<WA>おはだ<NO>てんてき"

	para "だから<TTE>　クリーム<WA>ぬ<TTE>ないわ"
	line "うみ<GA>よごれちゃうもの"
	done

SwimmerfKaraSeenText:
	text "およぎながら　やすむときは"
	line "たちおよぎ　<WO>すればいいのよ"
	cont "つかれも　とれて　げんきいっぱい！"
	done

SwimmerfKaraBeatenText:
	text "もう！　あなた<NO>ほうが"
	line "げんき　いっぱいね！"
	done

SwimmerfKaraAfterBattleText:
	text "そういえば　しま<NO>おく　から"
	line "なにか<NO>なきごえ<GA>きこえてきたわ"
	done

SwimmerfWendySeenText:
	text "よる<NI>なるとね"
	line "ヒトデマン<GA>すいめん　ちかくに"
	cont "あつま<TTE>　くるのよ"
	done

SwimmerfWendyBeatenText:
	text "<⋯>　あらあら"
	done

SwimmerfWendyAfterBattleText:
	text "あつまった　ヒトデマン"
	line "いっせい<NI>ひかりだすの！"
	cont "こわいくらい<NI>きれい　だったわ！"
	done

Route41_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 12, 17, WHIRL_ISLAND_NW, 1
	warp_event 36, 19, WHIRL_ISLAND_NE, 1
	warp_event 12, 37, WHIRL_ISLAND_SW, 1
	warp_event 36, 45, WHIRL_ISLAND_SE, 1

	def_coord_events

	def_bg_events
	bg_event  9, 35, BGEVENT_ITEM, Route41HiddenMaxEther

	def_object_events
	object_event 32,  6, SPRITE_OLIVINE_RIVAL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermCharlie, -1
	object_event 46,  8, SPRITE_OLIVINE_RIVAL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermGeorge, -1
	object_event 20, 26, SPRITE_OLIVINE_RIVAL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermBerke, -1
	object_event 32, 30, SPRITE_OLIVINE_RIVAL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermKirk, -1
	object_event 19, 46, SPRITE_OLIVINE_RIVAL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermMathew, -1
	object_event 17,  4, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfKaylee, -1
	object_event 23, 19, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfSusie, -1
	object_event 27, 34, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfDenise, -1
	object_event 44, 28, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 4, TrainerSwimmerfKara, -1
	object_event  9, 50, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerSwimmerfWendy, -1
