	object_const_def
	const NATIONALPARK_LASS1
	const NATIONALPARK_POKEFAN_F1
	const NATIONALPARK_TEACHER1
	const NATIONALPARK_YOUNGSTER1
	const NATIONALPARK_YOUNGSTER2
	const NATIONALPARK_TEACHER2
	const NATIONALPARK_PERSIAN
	const NATIONALPARK_YOUNGSTER3
	const NATIONALPARK_POKEFAN_F2
	const NATIONALPARK_POKEFAN_M
	const NATIONALPARK_LASS2
	const NATIONALPARK_POKE_BALL1
	const NATIONALPARK_GAMEBOY_KID
	const NATIONALPARK_POKE_BALL2

NationalPark_MapScripts:
	def_scene_scripts

	def_callbacks

NationalParkLassScript:
	jumptextfaceplayer NationalParkLassText

NationalParkPokefanFScript:
	jumptextfaceplayer NationalParkPokefanFText

NationalParkTeacher1Script:
	faceplayer
	opentext
	checkevent EVENT_GOT_QUICK_CLAW
	iftrue .GotQuickClaw
	writetext NationalParkTeacher1Text
	promptbutton
	verbosegiveitem QUICK_CLAW
	iffalse .NoRoom
	setevent EVENT_GOT_QUICK_CLAW
.GotQuickClaw:
	writetext NationalParkTeacher1Text_GotQuickClaw
	waitbutton
.NoRoom:
	closetext
	end

NationalParkYoungster1Script:
	jumptextfaceplayer NationalParkYoungster1Text

NationalParkYoungster2Script:
	jumptextfaceplayer NationalParkYoungster2Text

NationalParkTeacher2Script:
	jumptextfaceplayer NationalParkTeacher2Text

NationalParkPersian:
	faceplayer
	opentext
	writetext NationalParkPersianText
	cry PERSIAN
	waitbutton
	closetext
	end

NationalParkGameboyKidScript:
	faceplayer
	opentext
	writetext NationalParkGameboyKidText
	waitbutton
	closetext
	turnobject NATIONALPARK_GAMEBOY_KID, DOWN
	end

TrainerSchoolboyJack1:
	trainer SCHOOLBOY, JACK1, EVENT_BEAT_SCHOOLBOY_JACK, SchoolboyJack1SeenText, SchoolboyJack1BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	checkevent EVENT_JACK_READY_FOR_REMATCH
	iftrue .Rematch
	checkcellnum PHONE_SCHOOLBOY_JACK
	iftrue .NumberAccepted
	checkevent EVENT_JACK_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext SchoolboyJackTradeMonText
	promptbutton
	setevent EVENT_JACK_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .RequestNumber

.AskAgain:
	scall .AskNumber2
.RequestNumber:
	askforphonenumber PHONE_SCHOOLBOY_JACK
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, SCHOOLBOY, JACK1
	scall .RegisteredNumber
	sjump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext SchoolboyJack1BeatenText, 0
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_OLIVINE
	iftrue .LoadFight1
	loadtrainer SCHOOLBOY, JACK1
	startbattle
	reloadmapafterbattle
	clearevent EVENT_JACK_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer SCHOOLBOY, JACK2
	startbattle
	reloadmapafterbattle
	clearevent EVENT_JACK_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer SCHOOLBOY, JACK3
	startbattle
	reloadmapafterbattle
	clearevent EVENT_JACK_READY_FOR_REMATCH
	end

.AskNumber1:
	jumpstd AskNumber1MScript
	end

.AskNumber2:
	jumpstd AskNumber2MScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberMScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedMScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedMScript
	end

.PhoneFull:
	jumpstd PhoneFullMScript
	end

.RematchStd:
	jumpstd RematchMScript
	end

TrainerPokefanmWilliam:
	trainer POKEFANM, WILLIAM, EVENT_BEAT_POKEFANM_WILLIAM, PokefanmWilliamSeenText, PokefanmWilliamBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokefanmWilliamAfterBattleText
	waitbutton
	closetext
	end

TrainerPokefanfBeverly1:
	trainer POKEFANF, BEVERLY1, EVENT_BEAT_POKEFANF_BEVERLY, PokefanfBeverly1SeenText, PokefanfBeverly1BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	checkevent EVENT_BEVERLY_READY_FOR_REMATCH
	iftrue .Rematch
	checkcellnum PHONE_POKEFAN_BEVERLY
	iftrue .NumberAccepted
	checkevent EVENT_BEVERLY_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext PokefanBeverlyCuteMonText
	promptbutton
	setevent EVENT_BEVERLY_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .RequestNumber

.AskAgain:
	scall .AskNumber2
.RequestNumber:
	askforphonenumber PHONE_POKEFAN_BEVERLY
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, POKEFANF, BEVERLY1
	scall .RegisteredNumber
	sjump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext PokefanfBeverly1BeatenText, 0
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_MAHOGANY
	iftrue .LoadFight1
	loadtrainer POKEFANF, BEVERLY1
	startbattle
	reloadmapafterbattle
	clearevent EVENT_BEVERLY_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer POKEFANF, BEVERLY2
	startbattle
	reloadmapafterbattle
	clearevent EVENT_BEVERLY_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer POKEFANF, BEVERLY3
	startbattle
	reloadmapafterbattle
	clearevent EVENT_BEVERLY_READY_FOR_REMATCH
	end

.AskNumber1:
	jumpstd AskNumber1FScript
	end

.AskNumber2:
	jumpstd AskNumber2FScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberFScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedFScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedFScript
	end

.PhoneFull:
	jumpstd PhoneFullFScript
	end

.RematchStd:
	jumpstd RematchFScript
	end

TrainerLassKrise:
	trainer LASS, KRISE, EVENT_BEAT_LASS_KRISE, LassKriseSeenText, LassKriseBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext LassKriseAfterBattleText
	waitbutton
	closetext
	end

NationalParkRelaxationSquareSign:
	jumptext NationalParkRelaxationSquareText

NationalParkBattleNoticeSign:
	jumptext NationalParkBattleNoticeText

NationalParkTrainerTipsSign:
	jumptext NationalParkTrainerTipsText

NationalParkParlyzHeal:
	itemball PARLYZ_HEAL

NationalParkTMDig:
	itemball TM_DIG

NationalParkHiddenFullHeal:
	hiddenitem FULL_HEAL, EVENT_NATIONAL_PARK_HIDDEN_FULL_HEAL

NationalParkLassText:
	text "みて　みて！"
	line "<WATASHI><NO>バッグ！"

	para "だいすきな　#<NO>ずかんを"
	line "プリントして　は<TTE>るの！"
	done

NationalParkPokefanFText:
	text "こ<NO>ちいさな　かみはね"
	line "むすめ<NI>もらった　メールなの"
	cont "うれしいわ"
	done

NationalParkTeacher1Text:
	text "はい　ちゅうもーく！"

	para "<⋯>あら　いけない"
	line "きょうし　してる　クセ<GA>でちゃった"

	para "あなた　#　<TRAINER>ね"

	para "いっしょうけんめい　がんば<TTE>る"
	line "みたいだから　これ<WO>あげるわ！"
	done

NationalParkTeacher1Text_GotQuickClaw:
	text "そ<NO>せんせいのツメ　は"
	line "#<NI>もたせると"
	cont "たま<NI>せんせい　<KOUGEKI>　を"
	cont "するよう<NI>なるのよ！"
	done

NationalParkYoungster1Text:
	text "プリントした　#　ずかんで"
	line "ともだちと　あそんでるんだ！"
	done

NationalParkYoungster2Text:
	text "かてば　あいて<NO>ずかんシールを"
	line "もらえるのさ！"
	done

NationalParkTeacher2Text:
	text "いつも　こうえん<WO>さんぽ　してるの"
	line "くさ<NO>なかに<WA>はいらないけどね"

	para "だ<TTE>　#　<TRAINER>が"
	line "しょうぶ<WO>しかけて　くる　からよ！"
	done

NationalParkPersianText:
	text "ペルシアン『フ　フシャーッ！"
	done

NationalParkGameboyKidText:
	text "#ずかんを"
	line "プリンタで　プリント　してるんだ！"

	para "メールや　<PC><NO>ボックスも"
	line "プリントできるんだよ！"
	done

SchoolboyJack1SeenText:
	text "#<WA>おく<GA>ふかい"
	line "まだまだ　しらないこと<GA>いっぱい"

	para "でもね　ぼく<NO>ちしきは"
	line "きみ　より　たくさん　あるよ！"
	done

SchoolboyJack1BeatenText:
	text "むむむ？"
	done

SchoolboyJackTradeMonText:
	text "おぼえること　いっぱい　あるよ"

	para "たとえば<⋯>"
	line "<TM><WA>{d:NUM_TMS}しゅるい　とか"
	cont "ひとと　こうかん　した"
	cont "#<WA>そだち<GA>はやいとか"
	done

PokefanfBeverly1SeenText:
	text "あたし<NO>#　かわいいわよ"
	line "ちょっと　じまん　させてもらうわ"
	done

PokefanfBeverly1BeatenText:
	text "しょうぶ　じゃ　かなわないわね"
	line "みせっこなら　じまん　できたのに"
	done

PokefanBeverlyCuteMonText:
	text "おともだち　マリル　も<TTE>るの"
	line "マリル　かわいいわよね！"
	cont "いいわね　マリル　あたしも　ほしいわ"
	done

PokefanmWilliamSeenText:
	text "ひたすら<NI>#<WO>かわいがる！"
	line "きらわれても　かわいがる！"
	cont "それ<GA>だいすきクラブ<NO>きまり！"
	done

PokefanmWilliamBeatenText:
	text "ポ　#ちゃん！"
	done

PokefanmWilliamAfterBattleText:
	text "しょうぶに<WA>まけた　けど"
	line "わし<NO>#<NO>ほうが"
	cont "ラブリーだから　わし<NO>かち！"
	done

LassKriseSeenText:
	text "なあに？"
	line "ひとのかお　じろじろ　みて"

	para "えっ　しょうぶ　なの"
	done

LassKriseBeatenText:
	text "<⋯>　うーん"
	done

LassKriseAfterBattleText:
	text "じっと　みてるから"
	line "き<GA>あるのかと　おもっちゃっ<TA!>"

	para "だ<TTE>　あたし　かわいいもん！"
	done

NationalParkRelaxationSquareText:
	text "いこい<NO>ひろば"
	line "しぜん　こうえん"
	done

NationalParkBattleNoticeText:
	text "チラシ<GA>は<TTE>　ある！"

	para "#　しょうぶは"
	line "くさむら　だけで　おねがいします"

	para "<⋯>しぜん　こうえん"
	line "かんり　じむしょ　より<⋯>"
	done

NationalParkTrainerTipsText:
	text "おとくな　けいじばん！"

	para "メールのがめんで"
	line "スタートボタン<WO>プッシュ！"
	cont "メール<WO>プリントできます！"
	done

NationalPark_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 33, 18, ROUTE_36_NATIONAL_PARK_GATE, 1
	warp_event 33, 19, ROUTE_36_NATIONAL_PARK_GATE, 2
	warp_event 10, 47, ROUTE_35_NATIONAL_PARK_GATE, 1
	warp_event 11, 47, ROUTE_35_NATIONAL_PARK_GATE, 2

	def_coord_events

	def_bg_events
	bg_event 14, 44, BGEVENT_READ, NationalParkRelaxationSquareSign
	bg_event 27, 31, BGEVENT_READ, NationalParkBattleNoticeSign
	bg_event  6, 47, BGEVENT_ITEM, NationalParkHiddenFullHeal
	bg_event 12,  4, BGEVENT_READ, NationalParkTrainerTipsSign

	def_object_events
	object_event 15, 24, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, NationalParkLassScript, -1
	object_event 14,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NationalParkPokefanFScript, -1
	object_event 27, 40, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, NationalParkTeacher1Script, -1
	object_event 11, 41, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NationalParkYoungster1Script, -1
	object_event 10, 41, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, NationalParkYoungster2Script, -1
	object_event 17, 41, SPRITE_TEACHER, SPRITEMOVEDATA_WANDER, 1, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NationalParkTeacher2Script, -1
	object_event 26, 40, SPRITE_GROWLITHE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NationalParkPersian, -1
	object_event 27, 23, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSchoolboyJack1, -1
	object_event 18, 29, SPRITE_POKEFAN_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerPokefanfBeverly1, -1
	object_event 16,  9, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerPokefanmWilliam, -1
	object_event  8, 14, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerLassKrise, -1
	object_event 35, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, NationalParkParlyzHeal, EVENT_NATIONAL_PARK_PARLYZ_HEAL
	object_event 26,  6, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, NationalParkGameboyKidScript, -1
	object_event  1, 43, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, NationalParkTMDig, EVENT_NATIONAL_PARK_TM_DIG
