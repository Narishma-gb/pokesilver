	object_const_def
	const BLUESHOUSE_DAISY

BluesHouse_MapScripts:
	def_scene_scripts

	def_callbacks

DaisyScript:
	faceplayer
	opentext
	readvar VAR_HOUR
	ifequal 15, .ThreePM
	writetext DaisyHelloText
	waitbutton
	closetext
	end

.ThreePM:
	checkflag ENGINE_DAISYS_GROOMING
	iftrue .AlreadyGroomedMon
	writetext DaisyOfferGroomingText
	yesorno
	iffalse .Refused
	writetext DaisyWhichMonText
	waitbutton
	special DaisysGrooming
	ifequal $0, .Refused
	ifequal $1, .CantGroomEgg
	setflag ENGINE_DAISYS_GROOMING
	writetext DaisyAlrightText
	waitbutton
	closetext
	special FadeOutToWhite
	playmusic MUSIC_HEAL
	pause 60
	special FadeInFromWhite
	special RestartMapMusic
	opentext
	writetext GroomedMonLooksContentText
	special PlayCurMonCry
	promptbutton
	writetext DaisyAllDoneText
	waitbutton
	closetext
	end

.AlreadyGroomedMon:
	writetext DaisyAlreadyGroomedText
	waitbutton
	closetext
	end

.Refused:
	writetext DaisyRefusedText
	waitbutton
	closetext
	end

.CantGroomEgg:
	writetext DaisyCantGroomEggText
	waitbutton
	closetext
	end

DaisyHelloText:
	text "ナナミ『<WATASHI><NO>おとうと"
	line "トキワ　シティ<NO>ジムリーダーなの"

	para "しょっちゅう　ジム<WO>るすにして"
	line "みんな<WO>こまらせてる　みたい"
	done

DaisyOfferGroomingText:
	text "ナナミ『いらっしゃい"
	line "ちょうど　よかったわ！"
	cont "これから　おちゃ<NO>じかんなの"

	para "あら？　あなた<NO>#"
	line "すこし　よごれちゃ<TTE>る　みたい！"
	cont "<WATASHI><GA>けづくろい　しましょうか？"
	done

DaisyWhichMonText:
	text "ナナミ『ど<NO>#<NI>する？"
	done

DaisyAlrightText:
	text "ナナミ『じゃあ"
	line "けづくろい　してあげるわね！"
	done

GroomedMonLooksContentText:
	text "@"
	text_ram wStringBuffer3
	text "は"
	line "とても　きもちよさそう！"
	done

DaisyAllDoneText:
	text "ナナミ『はい！"
	line "と<TTE>も　きれい<NI>なったわ！"

	para "うふふ"
	line "かわいい　#ね！"
	done

DaisyAlreadyGroomedText:
	text "ナナミ『こ<NO>じかんは"
	line "まいにち　おちゃ<WO>しているの"
	cont "また　きてね！"
	done

DaisyRefusedText:
	text "ナナミ『けづくろい　しないの？"
	line "じゃあ　おちゃ<NI>しましょう"
	done

DaisyCantGroomEggText:
	text "ナナミ『うふふ！"
	line "タマゴ<WA>けづくろい　できないわ"
	done

BluesHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, PALLET_TOWN, 2
	warp_event  3,  7, PALLET_TOWN, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_DAISY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DaisyScript, -1
