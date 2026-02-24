	object_const_def
	const BILLSFAMILYSHOUSE_BILL
	const BILLSFAMILYSHOUSE_POKEFAN_F
	const BILLSFAMILYSHOUSE_TWIN

BillsFamilysHouse_MapScripts:
	def_scene_scripts

	def_callbacks

BillScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_EEVEE
	iftrue .GotEevee
	writetext BillTakeThisEeveeText
	yesorno
	iffalse .Refused
	writetext BillImCountingOnYouText
	promptbutton
	waitsfx
	readvar VAR_PARTYCOUNT
	ifequal PARTY_LENGTH, .NoRoom
	writetext ReceivedEeveeText
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke EEVEE, 20
	setevent EVENT_GOT_EEVEE
	writetext BillEeveeMayEvolveText
	waitbutton
	closetext
	end

.NoRoom:
	writetext BillPartyFullText
	waitbutton
	closetext
	end

.Refused:
	writetext BillNoEeveeText
	waitbutton
	closetext
	end

.GotEevee:
	writetext BillPopWontWorkText
	waitbutton
	closetext
	end

BillsMomScript:
	faceplayer
	opentext
	checkevent EVENT_MET_BILL
	iffalse .HaventMetBill
	writetext BillsMomText_BeforeEcruteak
	waitbutton
	closetext
	end

.HaventMetBill:
	writetext BillsMomText_AfterEcruteak
	waitbutton
	closetext
	end

BillsYoungerSisterScript:
	faceplayer
	opentext
	checkcellnum PHONE_BILL
	iftrue .GotBillsNumber
	writetext BillsYoungerSisterUsefulNumberText
	askforphonenumber PHONE_BILL
	ifequal PHONE_CONTACTS_FULL, .NoRoom
	ifequal PHONE_CONTACT_REFUSED, .Refused
	waitsfx
	addcellnum PHONE_BILL
	writetext RecordedBillsNumberText
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	promptbutton
.GotBillsNumber:
	writetext BillsYoungerSisterStorageSystemText
	waitbutton
	closetext
	end

.Refused:
	writetext BillsYoungerSisterRefusedNumberText
	waitbutton
	closetext
	end

.NoRoom:
	writetext BillsYoungerSisterPhoneFullText
	promptbutton
	sjump .Refused

BillsHouseBookshelf1:
	jumpstd PictureBookshelfScript

BillsHouseBookshelf2:
	jumpstd MagazineBookshelfScript

BillsHouseRadio:
	jumpstd Radio2Script

BillTakeThisEeveeText:
	text "マサキ『おお　<PLAYER>　やん"
	line "そや　たのみごと　あるねん"
	cont "イーブイ　ひきと<TTE>ーな"

	para "こいつ　タイムカプセルの"
	line "ちょうせい　してたら"
	cont "とつぜん　おくられてきたんや"

	para "だれか　めんどうみたらな　あかんけど"
	line "わい　そとにでる<NO>すきちゃうし"
	cont "<PLAYER><GA>あそんだ<TTE>えな"
	done

BillImCountingOnYouText:
	text "マサキ『さすがやな　"
	line "よっ<⋯>　いろおとこ！"
	cont "にくいねーッ"
	cont "だいとうりょう！"

	para "ほな　たのんだで"
	line "かわいがったりや！"
	done

ReceivedEeveeText:
	text "<PLAYER>は"
	line "イーブイ<WO>もらっ<TA!>"
	done

BillEeveeMayEvolveText:
	text "マサキ『イーブイに<WA>あたらしい"
	line "しんか<NO>かのうせい　ある<TTE>"
	cont "ウツギはかせ　はっぴょう　してたで"
	done

BillPartyFullText:
	text "<TTE>　あかんがな"
	line "それいじょう　#　もてへんやん"
	done

BillNoEeveeText:
	text "そーかいな<⋯>"
	done

BillPopWontWorkText:
	text "マサキ『わいな　むかし"
	line "てんそうマシン<NO>じっけん　しててん"
	cont "あれ<NO>つづきでも　はじめよかな"
	done

BillsMomText_BeforeEcruteak:
	text "あら　あなた　#あつめてるの"
	line "<WATASHI><NO>むすこも"
	cont "#<NI>くわしいのよ"

	para "マサキ<TTE>　いうんだけど"
	line "いま　エンジュ<NO>#センターに"
	cont "よばれて　いったわ"
	done

BillsMomText_AfterEcruteak:
	text "なんにせよ　むすこ<NO>かおを"
	line "みられるの<WA>ははとして　しあわせね"
	done

BillsYoungerSisterUsefulNumberText:
	text "あなた　#<TRAINER>？"

	para "だったら　あたし<GA>すてきな"
	line "でんわばんごう　おしえてあげようか？"
	done

RecordedBillsNumberText:
	text "<PLAYER><WA>マサキの"
	line "でんわばんごう<WO>とうろく　し<TA!>"
	done

BillsYoungerSisterRefusedNumberText:
	text "<PC>で　#<WO>あずかる"
	line "システム<WO>つくったの"
	cont "あたし<NO>おにいちゃん　なの"

	para "あなた<NI>マサキにいちゃんの"
	line "でんわばんごうを"
	cont "おしえてあげようと　おもったのにぃ"
	done

BillsYoungerSisterPhoneFullText:
	text "あっ！"
	line "それいじょう　とうろく　できないね"
	done

BillsYoungerSisterStorageSystemText:
	text "<PC>で　#を"
	line "あずかる　システム　つくったの"
	cont "マサキにいちゃん　なのよ"
	done

BillsFamilysHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 4
	warp_event  3,  7, GOLDENROD_CITY, 4

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, BillsHouseBookshelf2
	bg_event  1,  1, BGEVENT_READ, BillsHouseBookshelf1
	bg_event  7,  1, BGEVENT_READ, BillsHouseRadio

	def_object_events
	object_event  2,  3, SPRITE_BILL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BillScript, EVENT_MET_BILL
	object_event  5,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BillsMomScript, -1
	object_event  5,  4, SPRITE_TWIN, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BillsYoungerSisterScript, -1
