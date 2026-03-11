	object_const_def
	const EARLSPOKEMONACADEMY_EARL
	const EARLSPOKEMONACADEMY_YOUNGSTER1
	const EARLSPOKEMONACADEMY_GAMEBOY_KID1
	const EARLSPOKEMONACADEMY_GAMEBOY_KID2
	const EARLSPOKEMONACADEMY_YOUNGSTER2
	const EARLSPOKEMONACADEMY_POKEDEX

EarlsPokemonAcademy_MapScripts:
	def_scene_scripts

	def_callbacks

AcademyEarl:
	applymovement EARLSPOKEMONACADEMY_EARL, AcademyEarlSpinMovement
	faceplayer
	opentext
	writetext AcademyEarlIntroText
	yesorno
	iffalse .Part1
	writetext AcademyEarlTeachHowToWinText
	yesorno
	iffalse .Done
.Part1:
	writetext AcademyEarlTeachMoreText
	yesorno
	iffalse .Done
	writetext AcademyEarlTeachHowToRaiseWellText
	waitbutton
	closetext
	end

.Done:
	writetext AcademyEarlNoMoreToTeachText
	waitbutton
	closetext
	end

EarlsPokemonAcademyYoungster1Script:
	jumptextfaceplayer EarlsPokemonAcademyYoungster1Text

EarlsPokemonAcademyGameboyKid1Script:
	faceplayer
	opentext
	writetext EarlsPokemonAcademyGameboyKid1Text
	waitbutton
	closetext
	turnobject EARLSPOKEMONACADEMY_GAMEBOY_KID1, DOWN
	end

EarlsPokemonAcademyGameboyKid2Script:
	faceplayer
	opentext
	writetext EarlsPokemonAcademyGameboyKid2Text
	waitbutton
	closetext
	turnobject EARLSPOKEMONACADEMY_GAMEBOY_KID2, DOWN
	end

EarlsPokemonAcademyYoungster2Script:
	jumptextfaceplayer EarlsPokemonAcademyYoungster2Text

AcademyBlackboard:
	opentext
	writetext AcademyBlackboardText
.Loop:
	loadmenu .BlackboardMenuHeader
	_2dmenu
	closewindow
	ifequal 1, .Poison
	ifequal 2, .Paralysis
	ifequal 3, .Sleep
	ifequal 4, .Burn
	ifequal 5, .Freeze
	closetext
	end

.Poison:
	writetext AcademyPoisonText
	waitbutton
	sjump .Loop

.Paralysis:
	writetext AcademyParalysisText
	waitbutton
	sjump .Loop

.Sleep:
	writetext AcademySleepText
	waitbutton
	sjump .Loop

.Burn:
	writetext AcademyBurnText
	waitbutton
	sjump .Loop

.Freeze:
	writetext AcademyFreezeText
	waitbutton
	sjump .Loop

.BlackboardMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 11, 8
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR ; flags
	dn 3, 2 ; rows, columns
	db 6 ; spacing
	dba .Text
	dbw BANK(@), NULL

.Text:
	db "どく@"
	db "まひ@"
	db "ねむり@"
	db "やけど@"
	db "こおり@"
	db "やめる@"

AcademyNotebook:
	opentext
	writetext AcademyNotebookText
	yesorno
	iffalse .Done
	writetext AcademyNotebookText1
	yesorno
	iffalse .Done
	writetext AcademyNotebookText2
	yesorno
	iffalse .Done
	writetext AcademyNotebookText3
	waitbutton
.Done:
	closetext
	end

AcademyStickerMachine: ; unreferenced
	jumptext AcademyStickerMachineText

AcademyBookshelf:
	jumpstd DifficultBookshelfScript

AcademyEarlSpinMovement:
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	step_end

AcademyEarlIntroText:
	text "ジョバンニ　でーす！"
	line "#<WA>すばらしー　ですね！"

	para "ワタシ　つよく　なるため"
	line "いろいろ　おしえまーす"

	para "な<NI>しりたい？"
	line "どうすれば　つよくなるか"
	cont "しりたい　アルか？"
	done

AcademyEarlTeachHowToWinText:
	text "それではー　ワタシが"
	line "おしえて　あげましょー！"

	para "しょうぶ<NO>とき"
	line "#　リストの"
	cont "いちばん　うえ<NO>ポケモンが"
	cont "さいしょ<NI>とびだしまーす！"

	para "リスト<NO>じゅんばん　かえると"
	line "しょうぶ<GA>ゆうり<NI>なるかもねー！"

	para "ほかにも　ききたい　アルか？"
	done

AcademyEarlTeachMoreText:
	text "ではー　#の"
	line "じょーずな　そだてかた"
	cont "しりたい　アルか？"
	done

AcademyEarlTeachHowToRaiseWellText:
	text "それではー　ワタシが"
	line "おしえて　あげましょー！"

	para "しょうぶ<NO>とき"
	line "いちど　でも　かおをだした　#"
	cont "けいけんち<GA>もらえまーす！"

	para "よわい　#を"
	line "リスト<NO>うえ<NI>して"
	cont "しょうぶのとき　すぐ<NI>こうたい！"

	para "これで　よわい　#も"
	line "そだつ　アルねー！"
	done

AcademyEarlNoMoreToTeachText:
	text "おー　あなた　ゆうとうせい！"
	line "おしえる　こと　ないアルねー"

	para "つかまえた　#と"
	line "なかよく　して　くださいですねー！"
	done

EarlsPokemonAcademyYoungster1Text:
	text "せんせい<NO>おはなし"
	line "ノートにかいて　おぼえるんだ！"

	para "こくばん<NI>かいてあることも"
	line "ノート<NI>うつさなくちゃ<⋯>"
	done

EarlsPokemonAcademyGameboyKid1Text:
	text "となりのこに"
	line "ぼく<NO>すきな#　おくったよ！"
	done

EarlsPokemonAcademyGameboyKid2Text:
	text "あれ？　おくられてきた　#"
	line "なにか　も<TTE>る！？"
	done

EarlsPokemonAcademyYoungster2Text:
	text "<⋯>#<NI>きのみ<WO>もたせると"
	line "じぶんで　たいりょく<WO>かいふくする"

	para "#<GA>もてる　どうぐは"
	line "ほかにも　たくさん<⋯>"

	para "ノート<WO>ちゃんと　とるのは"
	line "たいへんだなあ<⋯>"
	done

AcademyBlackboardText:
	text "こくばんに"
	line "#<GA>たたか<TTE>る　とき"
	cont "おこる　たいちょうの"
	cont "へんか<NI>ついて　かかれてる"
	done

AcademyBlackboardText2: ; unreferenced
	text "ど<NO>こうもく<WO>みますか？"
	done

AcademyPoisonText:
	text "どく<WO>うけると"
	line "たいりょく<GA>へ<TTE>いきます"

	para "せんとうのあとも　どく<WA>のこるので"
	line "あるくたび<NI>たいりょく<GA>へります"
	cont "どくけしで　なおしましょう"
	done

AcademyParalysisText:
	text "まひすると　すばやさ<GA>さがり"
	line "ときどき　わざ<GA>だせなくなります"

	para "たたかい　おわ<TTE>も"
	line "まひした　ままです"
	cont "まひなおしで　なおしましょう"
	done

AcademySleepText:
	text "ねむ<TTE>　しまうと"
	line "そ<NO>あいだ　<KOUGEKI>　できません"

	para "せんとう<GA>おわ<TTE>も"
	line "ねむった　ままです"
	cont "ねむけざましで　おこしてあげましょう"
	done

AcademyBurnText:
	text "やけど<WA>たいりょく<GA>へ<TTE>いき"
	line "<KOUGEKI>りょく<GA>さがります"

	para "せんとう<GA>おわ<TTE>も"
	line "やけど<NO>ままです"
	cont "やけどなおしで　なおしましょう"
	done

AcademyFreezeText:
	text "こお<TTE>　しまうと"
	line "なにも　できなくなります"

	para "たたかい　おわ<TTE>も"
	line "こおりついた　ままです"
	cont "こおりなおしで　とかしましょう"
	done

AcademyNotebookText:
	text "このこ<NO>ノートだ　<⋯>"

	para "#は"
	line "モンスターボールで　つかまえて"
	cont "どうじ<NI>６ぴき　もち　あるける"

	para "つづきも　よむ？"
	done

AcademyNotebookText1:
	text "モンスターボール<WO>なげる　ときは"
	line "#<NO>わざで"
	cont "どく　とか　やけど　とか　にすると"
	cont "つかまえ　やすい！"

	para "つづきも　よむ？"
	done

AcademyNotebookText2:
	text "ほかにも　#<NO>わざで"
	line "こんらん　するときがある"

	para "こんらん　すると"
	line "たま<NI>まちがえて"
	cont "じぶん<WO><KOUGEKI>　してしまう"

	para "いちどでも　せんとうから　はなれると"
	line "もと<NI>もどる<⋯>"

	para "つづきも　よむ？"
	done

AcademyNotebookText3:
	text "そうして　つかまえた　#を"
	line "そだてて　たたかわせる　ひとを"
	cont "#<TRAINER>と　いう"

	para "<TRAINER><NO>もくひょうは"
	line "かくち<NO>#ジム<NI>いる"
	cont "つよい　<TRAINER><NI>かつこと！"

	para "つづきは<⋯>"
	line "まっしろ　だ！"

	para "しょうねん『てへへ<⋯>"
	line "あと<WA>なにも　かいてないんだ<⋯>"
	done

AcademyStickerMachineText:
	text "いろんな　データを"
	line "シールにできる　すごい　マシン！"
	done

EarlsPokemonAcademy_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3, 15, VIOLET_CITY, 3
	warp_event  4, 15, VIOLET_CITY, 3

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, AcademyBookshelf
	bg_event  1,  1, BGEVENT_READ, AcademyBookshelf
	bg_event  3,  0, BGEVENT_READ, AcademyBlackboard
	bg_event  4,  0, BGEVENT_READ, AcademyBlackboard

	def_object_events
	object_event  4,  2, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, AcademyEarl, EVENT_EARLS_ACADEMY_EARL
	object_event  2,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyYoungster1Script, -1
	object_event  3, 11, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyGameboyKid1Script, -1
	object_event  4, 11, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyGameboyKid2Script, -1
	object_event  4,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EarlsPokemonAcademyYoungster2Script, -1
	object_event  2,  4, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, AcademyNotebook, -1
