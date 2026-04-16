	object_const_def
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST1
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST2
	const RUINSOFALPHRESEARCHCENTER_SCIENTIST3

RuinsOfAlphResearchCenter_MapScripts:
	def_scene_scripts
	scene_script RuinsOfAlphResearchCenterNoopScene,        SCENE_RUINSOFALPHRESEARCHCENTER_NOOP
	scene_script RuinsOfAlphResearchCenterGetUnownDexScene, SCENE_RUINSOFALPHRESEARCHCENTER_GET_UNOWN_DEX

	def_callbacks
	callback MAPCALLBACK_OBJECTS, RuinsOfAlphResearchCenterScientistCallback

RuinsOfAlphResearchCenterNoopScene:
	end

RuinsOfAlphResearchCenterGetUnownDexScene:
	sdefer RuinsOfAlphResearchCenterGetUnownDexScript
	end

RuinsOfAlphResearchCenterScientistCallback:
	checkscene
	ifequal SCENE_RUINSOFALPHRESEARCHCENTER_GET_UNOWN_DEX, .ShowScientist
	endcallback

.ShowScientist:
	moveobject RUINSOFALPHRESEARCHCENTER_SCIENTIST3, 3, 7
	appear RUINSOFALPHRESEARCHCENTER_SCIENTIST3
	endcallback

RuinsOfAlphResearchCenterGetUnownDexScript:
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsOfAlphResearchCenterApproachesComputerMovement
	playsound SFX_BOOT_PC
	pause 60
	playsound SFX_SWITCH_POKEMON
	pause 30
	playsound SFX_TALLY
	pause 30
	playsound SFX_TRANSACTION
	pause 30
	turnobject RUINSOFALPHRESEARCHCENTER_SCIENTIST3, DOWN
	opentext
	writetext RuinsOfAlphResearchCenterModifiedDexText
	waitbutton
	closetext
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsOfAlphResearchCenterApproachesPlayerMovement
	opentext
	writetext RuinsOfAlphResearchCenterDexUpgradedText
	playsound SFX_ITEM
	waitsfx
	setflag ENGINE_UNOWN_DEX
	writetext RuinsOfAlphResearchCenterScientist3Text
	waitbutton
	closetext
	applymovement RUINSOFALPHRESEARCHCENTER_SCIENTIST3, RuinsOfAlphResearchCenterLeavesPlayerMovement
	setscene SCENE_RUINSOFALPHRESEARCHCENTER_NOOP
	special RestartMapMusic
	end

RuinsOfAlphResearchCenterScientist3Script:
	faceplayer
	opentext
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .PrinterAvailable
	writetext RuinsOfAlphResearchCenterScientist3Text
	waitbutton
	closetext
	end

.PrinterAvailable:
	writetext RuinsOfAlphResearchCenterScientist3_PrinterAvailable
	waitbutton
	closetext
	end

RuinsOfAlphResearchCenterScientist1Script:
	faceplayer
	opentext
	checkflag ENGINE_UNOWN_DEX
	iftrue .GotUnownDex
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftrue .UnownAppeared
	writetext RuinsOfAlphResearchCenterScientist1Text
	waitbutton
	closetext
	end

.UnownAppeared:
	writetext RuinsOfAlphResearchCenterScientist1Text_UnownAppeared
	waitbutton
	closetext
	end

.GotUnownDex:
	writetext RuinsOfAlphResearchCenterScientist1Text_GotUnownDex
	waitbutton
	closetext
	end

RuinsOfAlphResearchCenterScientist2Script:
	faceplayer
	opentext
	checkevent EVENT_MADE_UNOWN_APPEAR_IN_RUINS
	iftrue .UnownAppeared
	writetext RuinsOfAlphResearchCenterScientist2Text
	waitbutton
	closetext
	end

.UnownAppeared:
	writetext RuinsOfAlphResearchCenterScientist2Text_UnownAppeared
	waitbutton
	closetext
	end

RuinsOfAlphResearchCenterComputer:
	opentext
	checkevent EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	iftrue .SkipChecking
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .GotAllUnown
.SkipChecking:
	writetext RuinsOfAlphResearchCenterComputerText
	waitbutton
	closetext
	end

.GotAllUnown:
	writetext RuinsOfAlphResearchCenterComputerText_GotAllUnown
	waitbutton
	closetext
	end

RuinsOfAlphResearchCenterPrinter:
	opentext
	checkevent EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
	iftrue .SkipChecking
	readvar VAR_UNOWNCOUNT
	ifequal NUM_UNOWN, .PrinterAvailable
.SkipChecking:
	writetext RuinsOfAlphResearchCenterPrinterText_DoesntWork
	waitbutton
	closetext
	end

.PrinterAvailable:
	writetext RuinsOfAlphResearchCenterUnownPrinterText
	waitbutton
	special UnownPrinter
	closetext
	end

RuinsOfAlphResearchCenterPhoto: ; unreferenced
	jumptext RuinsOfAlphResearchCenterProfSilktreePhotoText

RuinsOfAlphResearchCenterBookshelf:
	jumptext RuinsOfAlphResearchCenterAcademicBooksText

RuinsOfAlphResearchCenterApproachesComputerMovement:
	step UP
	step UP
	step LEFT
	turn_head UP
	step_end

RuinsOfAlphResearchCenterApproachesPlayerMovement:
	step DOWN
	step_end

RuinsOfAlphResearchCenterLeavesPlayerMovement:
	step UP
	step_end

RuinsOfAlphResearchCenterModifiedDexText:
	text "よし！"

	para "#ずかん<NO>かいぞうが"
	line "おわったぞ！"

	para "オプション<NI>アンノーンずかんを"
	line "ついかさせて　もらったよ"

	para "つかまえた　じゅんばんで"
	line "きろくするよう<NI>したんだよ"
	done

RuinsOfAlphResearchCenterDexUpgradedText:
	text "<PLAYER>の"
	line "#ずかん<GA>パワーアップし<TA!>"
	done

RuinsOfAlphResearchCenterScientist3Text:
	text "つかまえた　アンノーンが"
	line "ぜんぶ　きろくされる　からね"

	para "なんしゅるい　いるのか"
	line "キミも　たしかめてくれ！"
	done

RuinsOfAlphResearchCenterScientist3_PrinterAvailable:
	text "アンノーン<WO>ぜんしゅるい"
	line "つかまえたのか！"
	cont "それ<WA>すごい！！"

	para "こ<NO>けんきゅうしつ<NI>ある"
	line "プリンタで　アンノーン<NO>すがたを"
	cont "プリントできるよう<NI>してみたんだ"

	para "ぜひ　つか<TTE>みてくれ！"
	done

RuinsOfAlphResearchCenterScientist1Text:
	text "およそ　１５００ねん　まえに"
	line "いせき<WA>つくられたのですが"
	cont "だれ<GA>なんのため<NI>つくったのか"
	cont "まだ　わか<TTE>　いません<⋯>"
	done

RuinsOfAlphResearchCenterScientist1Text_GotUnownDex:
	text "いせき<NO>#"
	line "ぜんぶで　なんしゅるい　いるんだ？"
	done

RuinsOfAlphResearchCenterScientist1Text_UnownAppeared:
	text "いせき<NI>#が"
	line "しゅつげん　したんですか！？"

	para "これ<WA>だいじけん！"
	line "さっそく　ちょうさ　しないと！"
	done

RuinsOfAlphResearchCenterScientist2Text:
	text "カベ<NI>かかれた　もようが"
	line "いせき<NO>ナゾ<WO>とく　カギ！"

	para "<⋯>だと　おもうんだけどなあ"
	done

RuinsOfAlphResearchCenterScientist2Text_UnownAppeared:
	text "キミ<GA>であった　#は"
	line "いせき<NO>カベ<NO>もように"
	cont "にている　みたいだね"

	para "<⋯>ふむ"

	para "だとすると　たくさん<NO>しゅるいが"
	line "いせき<NI>いるんだろうか<⋯>"
	done

RuinsOfAlphResearchCenterComputerText:
	text "アルフ<NO>いせき　ちょうさ"
	line "<⋯>ことしで　１０ねんめ"
	done

RuinsOfAlphResearchCenterComputerText_GotAllUnown:
	text "ナゾの#"
	line "なまえ<⋯>アンノーン"
	cont "ぜんぶで　{d:NUM_UNOWN}しゅるい　はっけん"
	done

RuinsOfAlphResearchCenterPrinterText_DoesntWork:
	text "いま<WA>つかえない　みたい<⋯>"
	done

RuinsOfAlphResearchCenterUnownPrinterText:
	text "アンノーン<NO>すがたを"
	line "プリントすること<GA>できます！"
	done

RuinsOfAlphResearchCenterProfSilktreePhotoText:
	text "アルフのいせき　けんきゅうしょ"
	line "しょだい　しょちょう"
	cont "ネムノキはかせ<NO>しゃしんだ！"
	done

RuinsOfAlphResearchCenterAcademicBooksText:
	text "むずかしい　ほん<GA>いっぱい"
	line "『こだいのいせき』<⋯>"
	cont "『こだいぶんめいのナゾ』<⋯>"
	done

RuinsOfAlphResearchCenter_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, RUINS_OF_ALPH_OUTSIDE, 6
	warp_event  3,  7, RUINS_OF_ALPH_OUTSIDE, 6

	def_coord_events

	def_bg_events
	bg_event  6,  5, BGEVENT_READ, RuinsOfAlphResearchCenterBookshelf
	bg_event  3,  4, BGEVENT_READ, RuinsOfAlphResearchCenterComputer
	bg_event  7,  1, BGEVENT_READ, RuinsOfAlphResearchCenterPrinter

	def_object_events
	object_event  4,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist1Script, -1
	object_event  5,  2, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 2, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist2Script, -1
	object_event  2,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RuinsOfAlphResearchCenterScientist3Script, EVENT_RUINS_OF_ALPH_RESEARCH_CENTER_SCIENTIST
