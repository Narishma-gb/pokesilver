	object_const_def
	const SLOWPOKEWELLB1F_ROCKET1
	const SLOWPOKEWELLB1F_ROCKET2
	const SLOWPOKEWELLB1F_ROCKET3
	const SLOWPOKEWELLB1F_ROCKET_GIRL
	const SLOWPOKEWELLB1F_SLOWPOKE1
	const SLOWPOKEWELLB1F_SLOWPOKE2
	const SLOWPOKEWELLB1F_KURT
	const SLOWPOKEWELLB1F_BOULDER
	const SLOWPOKEWELLB1F_POKE_BALL

SlowpokeWellB1F_MapScripts:
	def_scene_scripts

	def_callbacks

SlowpokeWellB1FKurtScript:
	jumptextfaceplayer SlowpokeWellB1FKurtText

TrainerGruntM29:
	trainer GRUNTM, GRUNTM_29, EVENT_BEAT_ROCKET_GRUNTM_29, GruntM29SeenText, GruntM29BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM29AfterBattleText
	waitbutton
	closetext
	end

TrainerGruntM1:
	trainer GRUNTM, GRUNTM_1, EVENT_BEAT_ROCKET_GRUNTM_1, GruntM1SeenText, GruntM1BeatenText, 0, .Script

.Script:
	opentext
	writetext TrainerGruntM1WhenTalkText
	waitbutton
	closetext
	special FadeOutToBlack
	special ReloadSpritesNoPalettes
	disappear SLOWPOKEWELLB1F_ROCKET1
	disappear SLOWPOKEWELLB1F_ROCKET2
	disappear SLOWPOKEWELLB1F_ROCKET3
	disappear SLOWPOKEWELLB1F_ROCKET_GIRL
	pause 15
	special FadeInFromBlack
	disappear SLOWPOKEWELLB1F_KURT
	moveobject SLOWPOKEWELLB1F_KURT, 11, 6
	appear SLOWPOKEWELLB1F_KURT
	applymovement SLOWPOKEWELLB1F_KURT, KurtSlowpokeWellVictoryMovementData
	turnobject PLAYER, RIGHT
	opentext
	writetext KurtLeaveSlowpokeWellText
	waitbutton
	closetext
	setevent EVENT_CLEARED_SLOWPOKE_WELL
	variablesprite SPRITE_AZALEA_ROCKET, SPRITE_RIVAL
	setmapscene AZALEA_TOWN, SCENE_AZALEATOWN_RIVAL_BATTLE
	clearevent EVENT_ILEX_FOREST_APPRENTICE
	clearevent EVENT_ILEX_FOREST_FARFETCHD_1
	setevent EVENT_CHARCOAL_KILN_FARFETCH_D
	setevent EVENT_CHARCOAL_KILN_APPRENTICE
	setevent EVENT_SLOWPOKE_WELL_SLOWPOKES
	setevent EVENT_SLOWPOKE_WELL_KURT
	clearevent EVENT_AZALEA_TOWN_SLOWPOKES
	clearevent EVENT_KURTS_HOUSE_SLOWPOKE
	clearevent EVENT_KURTS_HOUSE_KURT_1
	special FadeOutToWhite
	special HealParty
	pause 15
	warp KURTS_HOUSE, 3, 3
	end

TrainerGruntM2:
	trainer GRUNTM, GRUNTM_2, EVENT_BEAT_ROCKET_GRUNTM_2, GruntM2SeenText, GruntM2BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM2AfterBattleText
	waitbutton
	closetext
	end

TrainerGruntF1:
	trainer GRUNTF, GRUNTF_1, EVENT_BEAT_ROCKET_GRUNTF_1, GruntF1SeenText, GruntF1BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntF1AfterBattleText
	waitbutton
	closetext
	end

SlowpokeWellB1FSlowpokeWithMailScript:
	faceplayer
	opentext
	cry SLOWPOKE
	writetext SlowpokeWellB1FSlowpokeWithMailText
	yesorno
	iftrue .ReadMail
	closetext
	end

.ReadMail:
	writetext SlowpokeWellB1FSlowpokeMailText
	waitbutton
	closetext
	end

SlowpokeWellB1FTaillessSlowpokeScript:
	faceplayer
	opentext
	writetext SlowpokeWellB1FTaillessSlowpokeText
	cry SLOWPOKE
	waitbutton
	closetext
	end

SlowpokeWellB1FBoulder:
	jumpstd StrengthBoulderScript

SlowpokeWellB1FSuperPotion:
	itemball SUPER_POTION

KurtSlowpokeWellVictoryMovementData:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step UP
	step_sleep 8
	step_sleep 8
	step_sleep 8
	step LEFT
	step UP
	step UP
	step_sleep 8
	step_sleep 8
	step_sleep 8
	turn_head LEFT
	step_end

SlowpokeWellB1FKurtText:
	text "ガンテツ『おう　<PLAYER>か"

	para "うえで　みは<TTE>た　やつは"
	line "おおごえで　しかりとばしたら"
	cont "にげよったがな<⋯>"

	para "わし　いどから　おちてしもて"
	line "こし<WO>う<TTE>　うごけんのじゃ"

	para "くそう<⋯>　げんきなら"
	line "わし<NO>#が"
	cont "ちょちょいと　こらしめたのに<⋯>"

	para "まあええ　<PLAYER>！　"
	line "わし<NO>かわりに"
	cont "<TRAINER>だましい<WO>みせるのじゃ！"
	done

KurtLeaveSlowpokeWellText:
	text "ガンテツ『<PLAYER>　ようやったな"
	line "<ROCKET><NO>やつら"
	cont "にげていきおったわい"

	para "こし<NO>ぐあいも　よくなったし　"
	line "わしらも　かえるとしようぞ"
	done

GruntM29SeenText:
	text "ちくしょう　うえで　みは<TTE>いたのに"
	line "なんだ　あ<NO>じいさん"

	para "いきなり　おおごえ　だすから"
	line "おどろいて　いど<NI>おちてしまった"

	para "ええい　うさばらしに"
	line "おまえ<WO>いじめると　するか！"
	done

GruntM29BeatenText:
	text "あー　もー"
	line "ぜんぜん　だめだめだ！"
	done

GruntM29AfterBattleText:
	text "そうだよ　おれたちが"
	line "ヤドン<NO>シッポ<WO>き<TTE>は"
	cont "う<TTE>いたんだよ"

	para "それも　これも　かねもうけ<NO>ためさ"
	line "そう　かね<NO>ためなら"
	cont "なんだ<TTE>するの<GA><ROCKET>！"
	done

GruntM1SeenText:
	text "なんだ？"

	para "おれたち<NO>しごと　じゃま　するなら"
	line "ようしゃ<WA>しないぞ！"
	done

GruntM1BeatenText:
	text "くっ　こぞう"
	line "なかなか　やるな"
	cont "だ<GA>つぎから<WA>そう<WA>いかないぜ"
	done

TrainerGruntM1WhenTalkText:
	text "たしか<NI>われら　<ROCKET>は"
	line "３ねんまえ<NI>かいさんした"

	para "だがな　こうして　ちか<NI>もぐり"
	line "かつどう<WO>つづけていたのだ"

	para "これから　なに<GA>おきるか"
	line "たのしみ<NI>してる<GA>いいぜ！"
	done

GruntM2SeenText:
	text "シッポ<WO>とるの<WO>やめろ<TTE>？"

	para "ひと<NI>いわれて　やめてたら"
	line "<ROCKET><NO>な<GA>すたるぜ！"
	done

GruntM2BeatenText:
	text "つ　つよすぎる<⋯>"
	done

GruntM2AfterBattleText:
	text "かねもうけ　と<WA>いえ"
	line "ヤドンのシッポ<WO>うるなんて<⋯>"

	para "したっぱ<WA>つらいぜ<⋯>"
	done

GruntF1SeenText:
	text "シッポ<WO>とるの<WO>やめろ<TTE>？"

	para "じゃあ　<WATASHI>たち"
	line "ぜんいん<WO>たおして　ごらん！"
	done

GruntF1BeatenText:
	text "まあ　こにくたらしい"
	done

GruntF1AfterBattleText:
	text "ヤドンのシッポ　なんて"
	line "すぐ<NI>はえてくる　じゃない"
	cont "それ<WO>う<TTE>　なに<GA>わるいのよ！"
	done

SlowpokeWellB1FSlowpokeWithMailText:
	text "ヤドンだ<⋯>"
	line "シッポ<WO>きられている<⋯>"

	para "おや　メール<WO>も<TTE>いる"
	line "よんでみる？"
	done

SlowpokeWellB1FSlowpokeMailText:
	text "<PLAYER>は"
	line "メール<WO>よんでみ<TA!>"

	para "おじいさんと　ヤドンと　なかよく"
	line "おるすばんしてね　　　おとうさんより"
	done

SlowpokeWellB1FTaillessSlowpokeText:
	text "ヤドンだ<⋯>"
	line "シッポ<WO>きられている<⋯>"
	done

SlowpokeWellB1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 17, 15, AZALEA_TOWN, 6
	warp_event  7, 11, SLOWPOKE_WELL_B2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event 14,  8, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 1, TrainerGruntM29, EVENT_SLOWPOKE_WELL_ROCKETS
	object_event  5,  2, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 1, TrainerGruntM1, EVENT_SLOWPOKE_WELL_ROCKETS
	object_event  5,  6, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerGruntM2, EVENT_SLOWPOKE_WELL_ROCKETS
	object_event 13,  2, SPRITE_ROCKET_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerGruntF1, EVENT_SLOWPOKE_WELL_ROCKETS
	object_event  7,  4, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, SlowpokeWellB1FSlowpokeWithMailScript, EVENT_SLOWPOKE_WELL_SLOWPOKES
	object_event  6,  2, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, SlowpokeWellB1FTaillessSlowpokeScript, EVENT_SLOWPOKE_WELL_SLOWPOKES
	object_event 16, 14, SPRITE_KURT, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SlowpokeWellB1FKurtScript, EVENT_SLOWPOKE_WELL_KURT
	object_event  3,  2, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SlowpokeWellB1FBoulder, -1
	object_event 10,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SlowpokeWellB1FSuperPotion, EVENT_SLOWPOKE_WELL_B1F_SUPER_POTION
