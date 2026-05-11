	object_const_def
	const ROUTE31_FISHER
	const ROUTE31_YOUNGSTER
	const ROUTE31_BUG_CATCHER
	const ROUTE31_COOLTRAINER_M
	const ROUTE31_FRUIT_TREE
	const ROUTE31_POKE_BALL1
	const ROUTE31_POKE_BALL2

Route31_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, Route31CheckMomCallCallback

Route31CheckMomCallCallback:
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iffalse .DoMomCall
	endcallback

.DoMomCall:
	specialphonecall SPECIALCALL_WORRIED
	endcallback

TrainerBugCatcherWade1:
	trainer BUG_CATCHER, WADE1, EVENT_BEAT_BUG_CATCHER_WADE, BugCatcherWade1SeenText, BugCatcherWade1BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	checkevent EVENT_WADE_READY_FOR_REMATCH
	iftrue .WadeRematch
	checkcellnum PHONE_BUG_CATCHER_WADE
	iftrue .AcceptedNumberSTD
	checkevent EVENT_WADE_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext BugCatcherWade1AfterText
	waitbutton
	setevent EVENT_WADE_ASKED_FOR_PHONE_NUMBER
	scall .AskPhoneNumberSTD
	sjump .Continue

.AskAgain:
	scall .AskAgainSTD
.Continue:
	askforphonenumber PHONE_BUG_CATCHER_WADE
	ifequal PHONE_CONTACTS_FULL, .PhoneFullSTD
	ifequal PHONE_CONTACT_REFUSED, .DeclinedNumberSTD
	gettrainername STRING_BUFFER_3, BUG_CATCHER, WADE1
	scall .RegisterNumberSTD
	sjump .AcceptedNumberSTD

.WadeRematch:
	scall .RematchSTD
	winlosstext BugCatcherWade1BeatenText, 0
	checkflag ENGINE_FLYPOINT_MAHOGANY
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_GOLDENROD
	iftrue .LoadFight1
	loadtrainer BUG_CATCHER, WADE1
	startbattle
	reloadmapafterbattle
	clearevent EVENT_WADE_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer BUG_CATCHER, WADE2
	startbattle
	reloadmapafterbattle
	clearevent EVENT_WADE_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer BUG_CATCHER, WADE3
	startbattle
	reloadmapafterbattle
	clearevent EVENT_WADE_READY_FOR_REMATCH
	end

.AskPhoneNumberSTD:
	jumpstd AskNumber1MScript
	end

.AskAgainSTD:
	jumpstd AskNumber2MScript
	end

.RegisterNumberSTD:
	jumpstd RegisteredNumberMScript
	end

.AcceptedNumberSTD:
	jumpstd NumberAcceptedMScript
	end

.DeclinedNumberSTD:
	jumpstd NumberDeclinedMScript
	end

.PhoneFullSTD:
	jumpstd PhoneFullMScript
	end

.RematchSTD:
	jumpstd RematchMScript
	end


Route31MailRecipientScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM50_NIGHTMARE
	iftrue .DescribeNightmare
	checkevent EVENT_GOT_KENYA
	iftrue .TryGiveKenya
	writetext Text_Route31SleepyMan
	waitbutton
	closetext
	end

.TryGiveKenya:
	writetext Text_Route31SleepyManGotMail
	promptbutton
	checkpokemail ReceivedSpearowMailText
	ifequal POKEMAIL_WRONG_MAIL, .WrongMail
	ifequal POKEMAIL_REFUSED, .Refused
	ifequal POKEMAIL_NO_MAIL, .NoMail
	ifequal POKEMAIL_LAST_MON, .LastMon
	; POKEMAIL_CORRECT
	writetext Text_Route31HandOverMailMon
	promptbutton
	writetext Text_Route31ReadingMail
	promptbutton
	setevent EVENT_GAVE_KENYA
	verbosegiveitem TM_NIGHTMARE
	iffalse .NoRoomForItems
	setevent EVENT_GOT_TM50_NIGHTMARE
.DescribeNightmare:
	writetext Text_Route31DescribeNightmare
	waitbutton
.NoRoomForItems:
	closetext
	end

.WrongMail:
	writetext Text_Route31WrongMail
	waitbutton
	closetext
	end

.NoMail:
	writetext Text_Route31MissingMail
	waitbutton
	closetext
	end

.Refused:
	writetext Text_Route31DeclinedToHandOverMail
	waitbutton
	closetext
	end

.LastMon:
	writetext Text_Route31CantTakeLastMon
	waitbutton
	closetext
	end

ReceivedSpearowMailText:
	db   "くらやみ<NO>ほらあな　からは"
	next "べつ<NO>みち<NI>つづいているよ@"

Route31YoungsterScript:
	jumptextfaceplayer Route31YoungsterText

Route31Sign:
	jumptext Route31SignText

DarkCaveSign:
	jumptext DarkCaveSignText

Route31CooltrainerMScript:
	jumptextfaceplayer Route31CooltrainerMText

Route31FruitTree:
	fruittree FRUITTREE_ROUTE_31

Route31Antidote:
	itemball ANTIDOTE

Route31PokeBall:
	itemball POKE_BALL

Route31CooltrainerMText:
	text "くらやみ<NO>ほらあな<⋯>"
	line "#<GA>あたりを"
	cont "あかるくする　わざ<WO>つかえたらなあ"
	cont "なか<WO>しらべて　やるのに"
	done

BugCatcherWade1SeenText:
	text "いっぱい　#　つかまえた"
	line "ちょっと　しょうぶ　してくれよ！"
	done

BugCatcherWade1BeatenText:
	text "なんだかなー"
	done

BugCatcherWade1AfterText:
	text "６ぴき　も<TTE>るときに"
	line "#　つかまえると"
	cont "<PC>　つうしんで　じどうてきに"
	cont "ボックス<NI>おくられるんだ！"
	done

Text_Route31SleepyMan:
	text "うーん　ムニャムニャ<⋯>"

	para "#さがしで　あるき　すぎた"
	line "あし<WA>いたいし　ねむたいし<⋯>"

	para "ぼく<GA>やせいの#　だったら"
	line "つかまりやすい　じょうたいだ<⋯>"
	cont "ぐー<⋯>　スヤスヤ<⋯>"
	done

Text_Route31SleepyManGotMail:
	text "ぐー<⋯>　ムニャムニャ<⋯>"

	para "え？　なに？"
	line "ぼく<NI>メール<WO>も<TTE>きたの？"
	done

Text_Route31HandOverMailMon:
	text "<PLAYER><WA>メール<WO>もった"
	line "#<WO><WATASHI><TA!>"
	done

Text_Route31ReadingMail:
	text "な<NI>なに<⋯>"

	para "「くらやみ<NO>ほらあな　からは"
	line "べつ<NO>みち<NI>つづいているよ」"
	cont "だ<TTE>"

	para "わざわざ　ありがとう！"

	para "ともだちも　しんせつ　だけど"
	line "キミも　しんせつ　だな！"

	para "ひと<NO>しんせつ<NI>ふれて"
	line "ボクも　なにか　したくなったよ！"

	para "そうだ！"
	line "これ<WO>あげるよ！"
	done

Text_Route31DescribeNightmare:
	text "<TM>５０<WA>あくむ"

	para "ねむ<TTE>いる　あいて<NO>たいりょく"
	line "じわじわ　へらす　おそろしい　わざ"

	para "うー　ぶるぶる<⋯>"
	line "こわい　ゆめ<WA>みたく　ないよ<⋯>"
	done

Text_Route31WrongMail:
	text "これ　ボクあて<NO>メールじゃ　ないよ"
	done

Text_Route31MissingMail:
	text "そ<NO>#<GA>どうかしたの？"
	line "メール　も<TTE>ないよ"
	done

Text_Route31DeclinedToHandOverMail:
	text "なに？　なんでもないの？"
	done

Text_Route31CantTakeLastMon:
	text "ボク<GA>そ<NO>#<WO>うけとると"
	line "キミ<WA>たたかえなく　なっちゃうね！"
	done

Route31YoungsterText:
	text "くらやみ<NO>ほらあなで"
	line "いい　#　つかまえ<TA!>"

	para "こいつ<WO>きたえて"
	line "キキョウ<NO>ジムリーダー"
	cont "ハヤト<NI>しょうぶ<WO>いどむぜ！"
	done

Route31SignText:
	text "<KOKO_WA>３１<ROUTE>"
	line "キキョウシティ　<⋯>　ヨシノシティ"
	done

DarkCaveSignText:
	text "<KOKO_WA>くらやみ<NO>ほらあな"
	done

Route31_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  6, ROUTE_31_VIOLET_GATE, 3
	warp_event  4,  7, ROUTE_31_VIOLET_GATE, 4
	warp_event 34,  5, DARK_CAVE_VIOLET_ENTRANCE, 1

	def_coord_events

	def_bg_events
	bg_event  7,  5, BGEVENT_READ, Route31Sign
	bg_event 31,  5, BGEVENT_READ, DarkCaveSign

	def_object_events
	object_event 17,  7, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route31MailRecipientScript, -1
	object_event  9,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route31YoungsterScript, -1
	object_event 18, 15, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerBugCatcherWade1, -1
	object_event 33,  8, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route31CooltrainerMScript, -1
	object_event 16,  7, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route31FruitTree, -1
	object_event 29,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route31Antidote, EVENT_ROUTE_31_ANTIDOTE
	object_event 21, 13, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route31PokeBall, EVENT_ROUTE_31_POKE_BALL
