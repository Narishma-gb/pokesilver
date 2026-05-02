	object_const_def
	const AZALEATOWN_AZALEA_ROCKET1
	const AZALEATOWN_GRAMPS
	const AZALEATOWN_TEACHER
	const AZALEATOWN_YOUNGSTER
	const AZALEATOWN_SLOWPOKE1
	const AZALEATOWN_SLOWPOKE2
	const AZALEATOWN_SLOWPOKE3
	const AZALEATOWN_SLOWPOKE4
	const AZALEATOWN_FRUIT_TREE
	const AZALEATOWN_RIVAL
	const AZALEATOWN_AZALEA_ROCKET3

AzaleaTown_MapScripts:
	def_scene_scripts
	scene_script AzaleaTownNoop1Scene, SCENE_AZALEATOWN_NOOP
	scene_script AzaleaTownNoop2Scene, SCENE_AZALEATOWN_RIVAL_BATTLE

	def_callbacks
	callback MAPCALLBACK_NEWMAP, AzaleaTownFlypointCallback

AzaleaTownNoop1Scene:
	end

AzaleaTownNoop2Scene:
	end

AzaleaTownFlypointCallback:
	setflag ENGINE_FLYPOINT_AZALEA
	endcallback

AzaleaTownRivalBattleScene1:
	moveobject AZALEATOWN_RIVAL, 11, 11
	turnobject PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	appear AZALEATOWN_RIVAL
	applymovement AZALEATOWN_RIVAL, AzaleaTownRivalBattleApproachMovement1
	turnobject PLAYER, DOWN
	sjump AzaleaTownRivalBattleScript

AzaleaTownRivalBattleScene2:
	turnobject PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	appear AZALEATOWN_RIVAL
	applymovement AZALEATOWN_RIVAL, AzaleaTownRivalBattleApproachMovement2
	turnobject PLAYER, UP
AzaleaTownRivalBattleScript:
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext AzaleaTownRivalBeforeText
	waitbutton
	closetext
	setevent EVENT_RIVAL_AZALEA_TOWN
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	winlosstext AzaleaTownRivalWinText, AzaleaTownRivalLossText
	setlasttalked AZALEATOWN_RIVAL
	loadtrainer RIVAL1, RIVAL1_2_TOTODILE
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .AfterBattle

.Totodile:
	winlosstext AzaleaTownRivalWinText, AzaleaTownRivalLossText
	setlasttalked AZALEATOWN_RIVAL
	loadtrainer RIVAL1, RIVAL1_2_CHIKORITA
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .AfterBattle

.Chikorita:
	winlosstext AzaleaTownRivalWinText, AzaleaTownRivalLossText
	setlasttalked AZALEATOWN_RIVAL
	loadtrainer RIVAL1, RIVAL1_2_CYNDAQUIL
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .AfterBattle

.AfterBattle:
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext AzaleaTownRivalAfterText
	waitbutton
	closetext
	turnobject PLAYER, LEFT
	applymovement AZALEATOWN_RIVAL, AzaleaTownRivalBattleExitMovement
	playsound SFX_EXIT_BUILDING
	disappear AZALEATOWN_RIVAL
	setscene SCENE_AZALEATOWN_NOOP
	waitsfx
	playmapmusic
	end

AzaleaTownRocket1Script:
	jumptextfaceplayer AzaleaTownRocket1Text

AzaleaTownRocket2Script:
	jumptextfaceplayer AzaleaTownRocket2Text

AzaleaTownGrampsScript:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_SLOWPOKE_WELL
	iftrue .ClearedWell
	writetext AzaleaTownGrampsTextBefore
	waitbutton
	closetext
	end

.ClearedWell:
	writetext AzaleaTownGrampsTextAfter
	waitbutton
	closetext
	end

AzaleaTownTeacherScript:
	jumptextfaceplayer AzaleaTownTeacherText

AzaleaTownYoungsterScript:
	jumptextfaceplayer AzaleaTownYoungsterText

AzaleaTownSlowpokeScript:
	opentext
	writetext AzaleaTownSlowpokeText1
	pause 60
	writetext AzaleaTownSlowpokeText2
	cry SLOWPOKE
	waitbutton
	closetext
	end

UnusedWoosterScript: ; unreferenced
	faceplayer
	opentext
	writetext WoosterText
	cry QUAGSIRE
	waitbutton
	closetext
	end

AzaleaTownSign:
	jumptext AzaleaTownSignText

KurtsHouseSign:
	jumptext KurtsHouseSignText

AzaleaGymSign:
	jumptext AzaleaGymSignText

SlowpokeWellSign:
	jumptext SlowpokeWellSignText

CharcoalKilnSign:
	jumptext CharcoalKilnSignText

AzaleaTownIlextForestSign:
	jumptext AzaleaTownIlexForestSignText

AzaleaTownPokecenterSign:
	jumpstd PokecenterSignScript

AzaleaTownMartSign:
	jumpstd MartSignScript

WhiteApricornTree:
	fruittree FRUITTREE_AZALEA_TOWN

AzaleaTownHiddenFullHeal:
	hiddenitem FULL_HEAL, EVENT_AZALEA_TOWN_HIDDEN_FULL_HEAL

AzaleaTownRivalBattleApproachMovement1:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head UP
	step_end

AzaleaTownRivalBattleApproachMovement2:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head DOWN
	step_end

AzaleaTownRivalBattleExitMovement:
	step LEFT
	step LEFT
	step LEFT
	step_end

AzaleaTownRivalBeforeText:
	text "<⋯>　ききたいこと<GA>ある"

	para "<⋯>　<ROCKET>が"
	line "ふっかつ　してる<TTE>　ほんとか？"

	para "な<NI>おまえ<GA>たおした　だ<TTE>？"
	line "ウソ　いうなよな"

	para "<⋯>　ほんとかよ？"
	line "じゃあ　そ<NO>じつりょく"
	cont "オレ<NI>みせてみろ"
	done

AzaleaTownRivalWinText:
	text "<⋯>　フン！"
	line "つかえない　#　だぜ"

	para "<⋯>　いいか　おまえ<GA>かてたのは"
	line "オレ<NO>#<GA>よわかったからさ"
	done

AzaleaTownRivalAfterText:
	text "<⋯>　オレ<WA>よわい　やつが"
	line "だいっきらい　なんだよ"

	para "#　だろうが"
	line "<TRAINER>　だろうが<⋯>"

	para "そういう　よわい　やつら"
	line "ぜんぶ　つぶすため"
	cont "オレ<WA>つよくなる<⋯>"

	para "<ROCKET>も　おなじ"

	para "ひとり　ひとり<WA>よわいくせに"
	line "あつま<TTE>　えらそう<NI>する　やつら"
	cont "ぜったい<NI>ゆるせない"

	para "<⋯>　おまえ<WA>じゃま　するなよ"
	line "よわい　やつ<GA>うろちょろ　してると"
	cont "めざわり　だからな"
	done

AzaleaTownRivalLossText:
	text "<⋯>　フン！"
	line "やっぱり　さっき<NO>ウソなんだろ"
	done

AzaleaTownRocket1Text:
	text "なか<WA>あぶないからな"
	line "こうして　だれも　はいらないよう"
	cont "みは<TTE>いるのだよ"

	para "くー　おれ<TTE>　いいひと？"
	done

AzaleaTownRocket2Text:
	text "きみ　ヤドンのシッポ<TTE>　し<TTE>る？"
	line "ウワサだけど　おいしい　らしいね"

	para "こんな　いいこと　おしえる　なんて"
	line "くー　おれ<TTE>　いいひと？"
	done

AzaleaTownGrampsTextBefore:
	text "まちから　ヤドン<GA>きえた<⋯>"

	para "どこぞで<WA>ヤドンのシッポが"
	line "うられているという　はなし　だし<⋯>"
	done

AzaleaTownGrampsTextAfter:
	text "ヤドン<GA>もど<TTE>きたよ"
	line "まあ　のんびりや<NO>ヤドンのことだし"
	cont "どこかで　のんびり　してただけかもな"
	done

AzaleaTownTeacherText:
	text "あなたも　ガンテツさんに"
	line "ボール<WO>つく<TTE>もらい<NI>きたの？"
	cont "おおいのよね　そういう　ひと"
	done

AzaleaTownYoungsterText:
	text "ヒワダ<NO>まち<WO>ぬけると"
	line "ウバメ<NO>もり"

	para "でも　ほそい　き<GA>じゃまして"
	line "さき<NI>すすめない"

	para "スミしょくにん<NO>#なら"
	line "き<WO>きる　わざ<WO>おぼえてるけどね"
	done

AzaleaTownSlowpokeText1:
	text "ヤドン『<⋯>　<⋯>　<⋯>"

	para "<⋯>　<⋯>　<⋯>"
	done

AzaleaTownSlowpokeText2:
	text "<⋯>　<⋯>　やあん？"
	done

WoosterText:
	text "ミズウオ『<⋯>　グギョ"
	done

AzaleaTownSignText:
	text "<KOKO_WA>ヒワダ　タウン"
	line "#と　ひとが"
	cont "とも<NI>なかよく　くらす　まち"
	done

KurtsHouseSignText:
	text "<KOKO_WA>ガンテツ　のいえ"
	done

AzaleaGymSignText:
	text "ヒワダ　タウン　#ジム"
	line "リーダー　ツクシ"
	cont "あるく　むしポケ　だいひゃっか"
	done

SlowpokeWellSignText:
	text "ヤドンのいど"
	line "べつめい　あめふらし<NO>いど"

	para "こ<NO>ちほうでは"
	line "ヤドン<GA>あくび<WO>するたびに"
	cont "あめ<GA>ふると　しんじられています"

	para "じっさい　４００ねんまえの"
	line "ひでりのとき　みんな<WO>すくったのは"
	cont "ヤドン<GA>あくび<WO>したからだと"
	cont "とうじ<NO>きろく<NI>のこされています"
	done

CharcoalKilnSignText:
	text "<KOKO_WA>スミしょくにん<NO>こや"
	done

AzaleaTownIlexForestSignText:
	text "ゲート<WO>ぬけると　ウバメのもり"
	done

AzaleaTown_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 15,  9, AZALEA_POKECENTER_1F, 1
	warp_event 21, 13, CHARCOAL_KILN, 1
	warp_event 21,  5, AZALEA_MART, 2
	warp_event  9,  5, KURTS_HOUSE, 1
	warp_event 10, 15, AZALEA_GYM, 1
	warp_event 31,  7, SLOWPOKE_WELL_B1F, 1
	warp_event  2, 10, ILEX_FOREST_AZALEA_GATE, 3
	warp_event  2, 11, ILEX_FOREST_AZALEA_GATE, 4

	def_coord_events
	coord_event  5, 10, SCENE_AZALEATOWN_RIVAL_BATTLE, AzaleaTownRivalBattleScene1
	coord_event  5, 11, SCENE_AZALEATOWN_RIVAL_BATTLE, AzaleaTownRivalBattleScene2

	def_bg_events
	bg_event 19,  9, BGEVENT_READ, AzaleaTownSign
	bg_event 10,  9, BGEVENT_READ, KurtsHouseSign
	bg_event 14, 15, BGEVENT_READ, AzaleaGymSign
	bg_event 29,  7, BGEVENT_READ, SlowpokeWellSign
	bg_event 19, 13, BGEVENT_READ, CharcoalKilnSign
	bg_event 16,  9, BGEVENT_READ, AzaleaTownPokecenterSign
	bg_event 22,  5, BGEVENT_READ, AzaleaTownMartSign
	bg_event  3,  9, BGEVENT_READ, AzaleaTownIlextForestSign
	bg_event 31,  6, BGEVENT_ITEM, AzaleaTownHiddenFullHeal

	def_object_events
	object_event 31,  9, SPRITE_AZALEA_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownRocket1Script, EVENT_AZALEA_TOWN_SLOWPOKETAIL_ROCKET
	object_event 21,  9, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownGrampsScript, -1
	object_event 15, 13, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 2, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, AzaleaTownTeacherScript, -1
	object_event  7,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, AzaleaTownYoungsterScript, -1
	object_event  8, 17, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	object_event 18,  9, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	object_event 29,  9, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	object_event 15, 15, SPRITE_SLOWPOKE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownSlowpokeScript, EVENT_AZALEA_TOWN_SLOWPOKES
	object_event  8,  2, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, WhiteApricornTree, -1
	object_event 11, 10, SPRITE_AZALEA_ROCKET, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_AZALEA_TOWN
	object_event 10, 16, SPRITE_AZALEA_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AzaleaTownRocket2Script, EVENT_SLOWPOKE_WELL_ROCKETS
