	object_const_def
	const DANCETHEATER_KIMONO_GIRL1
	const DANCETHEATER_KIMONO_GIRL2
	const DANCETHEATER_KIMONO_GIRL3
	const DANCETHEATER_KIMONO_GIRL4
	const DANCETHEATER_KIMONO_GIRL5
	const DANCETHEATER_GENTLEMAN
	const DANCETHEATER_RHYDON
	const DANCETHEATER_COOLTRAINER_M
	const DANCETHEATER_GRANNY

DanceTheater_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerKimonoGirlNaoko:
	trainer KIMONO_GIRL, NAOKO, EVENT_BEAT_KIMONO_GIRL_NAOKO, KimonoGirlNaokoSeenText, KimonoGirlNaokoBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext KimonoGirlNaokoAfterBattleText
	waitbutton
	closetext
	end

TrainerKimonoGirlSayo:
	trainer KIMONO_GIRL, SAYO, EVENT_BEAT_KIMONO_GIRL_SAYO, KimonoGirlSayoSeenText, KimonoGirlSayoBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext KimonoGirlSayoAfterBattleText
	waitbutton
	closetext
	end

TrainerKimonoGirlZuki:
	trainer KIMONO_GIRL, ZUKI, EVENT_BEAT_KIMONO_GIRL_ZUKI, KimonoGirlZukiSeenText, KimonoGirlZukiBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext KimonoGirlZukiAfterBattleText
	waitbutton
	closetext
	end

TrainerKimonoGirlKuni:
	trainer KIMONO_GIRL, KUNI, EVENT_BEAT_KIMONO_GIRL_KUNI, KimonoGirlKuniSeenText, KimonoGirlKuniBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext KimonoGirlKuniAfterBattleText
	waitbutton
	closetext
	end

TrainerKimonoGirlMiki:
	trainer KIMONO_GIRL, MIKI, EVENT_BEAT_KIMONO_GIRL_MIKI, KimonoGirlMikiSeenText, KimonoGirlMikiBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext KimonoGirlMikiAfterBattleText
	waitbutton
	closetext
	end

DanceTheaterSurfGuy:
	faceplayer
	opentext
	writetext SurfGuyNeverLeftAScratchText
	promptbutton
	checkevent EVENT_GOT_HM03_SURF
	iftrue SurfGuyAlreadyGaveSurf
	checkevent EVENT_BEAT_KIMONO_GIRL_NAOKO
	iffalse .KimonoGirlsUndefeated
	checkevent EVENT_BEAT_KIMONO_GIRL_SAYO
	iffalse .KimonoGirlsUndefeated
	checkevent EVENT_BEAT_KIMONO_GIRL_ZUKI
	iffalse .KimonoGirlsUndefeated
	checkevent EVENT_BEAT_KIMONO_GIRL_KUNI
	iffalse .KimonoGirlsUndefeated
	checkevent EVENT_BEAT_KIMONO_GIRL_MIKI
	iffalse .KimonoGirlsUndefeated
	sjump .GetSurf

.KimonoGirlsUndefeated:
	writetext SurfGuyLadGiftText
	waitbutton
	closetext
	end

.GetSurf:
	writetext SurfGuyLikeADanceText
	promptbutton
	verbosegiveitem HM_SURF
	setevent EVENT_GOT_HM03_SURF
	writetext SurfGuySurfExplanationText
	waitbutton
	closetext
	end

SurfGuyAlreadyGaveSurf:
	writetext SurfGuyElegantKimonoGirlsText
	waitbutton
	closetext
	end

DanceTheaterRhydon:
	opentext
	writetext RhydonText
	cry RHYDON
	waitbutton
	closetext
	end

DanceTheaterCooltrainerMScript:
	jumptextfaceplayer DanceTheaterCooltrainerMText

DanceTheaterGrannyScript:
	jumptextfaceplayer DanceTheaterGrannyText

DanceTheaterFancyPanel:
	jumptext DanceTheaterFancyPanelText

KimonoGirlNaokoSeenText:
	text "すてきな　#　つれたはりますね"
	line "うでまえ　みさせて　くださいますか？"
	done

KimonoGirlNaokoBeatenText:
	text "おつよい　どすなあ！"
	done

KimonoGirlNaokoAfterBattleText:
	text "あいて　してもろて　たのしかったどす"
	line "また　おたのもうします"
	done

KimonoGirlSayoSeenText:
	text "いつも　だいじな　#と"
	line "いっしょ<NI>おど<TTE>るんよ"
	cont "もちろん　#も　そだててるんよ"
	done

KimonoGirlSayoBeatenText:
	text "おしいわあ"
	line "もうちょっとで　かてそうやったのに"
	done

KimonoGirlSayoAfterBattleText:
	text "おどりも　#も"
	line "リズム<GA>だいじ　なんやわ"
	done

KimonoGirlZukiSeenText:
	text "うち<NO>はなかんざし　きれいやろ？"
	line "え　#で　しょうぶ　しはるの？"
	done

KimonoGirlZukiBeatenText:
	text "もう　たたかえる　#"
	line "おらんよう<NI>なったわ"
	done

KimonoGirlZukiAfterBattleText:
	text "はなかんざしね　まいつき"
	line "きまった　はな<WO>さしてるんよ"
	done

KimonoGirlKuniSeenText:
	text "あら　かわいい　<TRAINER>やこと"
	line "うちと　しょうぶ　しはります？"
	done

KimonoGirlKuniBeatenText:
	text "あら　かんにん　やわ"
	line "みかけによらず　つよいんやね"
	done

KimonoGirlKuniAfterBattleText:
	text "ぎょうさん　おけいこ　して"
	line "いちにんまえ<NI>なった　つもりやけど"
	cont "まだまだ　やったわ"
	done

KimonoGirlMikiSeenText:
	text "どう　うちら<NO>おどり？"
	line "#も　じょうず　なんよ"
	done

KimonoGirlMikiBeatenText:
	text "うーん"
	line "あなたも　#　じょうず　やね"
	done

KimonoGirlMikiAfterBattleText:
	text "うちら<NO>おどり　みて"
	line "よろこんでくれる　ひと<GA>いて"
	cont "#も　そば<NI>おるから"
	cont "どんなことでも　がんばれるんどす"
	done

SurfGuyNeverLeftAScratchText:
	text "まいこはん　おどり　だけでなく"
	line "#も　たっしゃだ！"

	para "いつも　ちょうせん　してるが"
	line "まったく　は<GA>たたなくてね<⋯>"
	done

SurfGuyLadGiftText:
	text "ぼん！"
	line "まいこはん　ぜんいん<NI>かてたら"
	cont "わし<GA>いいもの<WO>あげよう！"
	done

SurfGuyLikeADanceText:
	text "それ<NI>くらべ"
	line "きみ<NO>#<NO>たたかいかた"
	cont "まさ<NI>おどるようだっ<TA!>"

	para "ええも<NO>みせて　もらったよ！"

	para "これ<WA>ほん<NO>きもちだ"
	line "きにせず　と<TTE>おきなさい！"
	done

SurfGuySurfExplanationText:
	text "それ<WA>なみのり　とい<TTE>"
	line "みず<NO>うえを"
	cont "すいすい　すすめる　わざ　なんだよ！"
	done

SurfGuyElegantKimonoGirlsText:
	text "わし<NO>#も　あんなふうに"
	line "あでやか<NI>な<TTE>ほしいんだよ"
	done

RhydonText:
	text "サイドン『ぐごー　ぐごご！"
	done

DanceTheaterCooltrainerMText:
	text "あ<NO>おじさん"
	line "いつも　サイドンと　いっしょ！"

	para "なみのり　つかえる　#に"
	line "おどりも　おぼえて　ほしいんだと！"

	para "シンクロナイズド　スイミングでも"
	line "やらせる　つもり　なのかな"
	done

DanceTheaterGrannyText:
	text "まいこはん　きれい　やの<⋯>"

	para "しかし　ひとまえ<NI>でるには"
	line "きびしい　しきたりや　しゅぎょうを"
	cont "こなさないと　いかん！"

	para "まあ　すきなら　なんでも　できるがな"
	done

DanceTheaterFancyPanelText:
	text "たかそうな　ついたて"
	line "きせつ<NO>はな<GA>かかれてる！"
	done

DanceTheater_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5, 13, ECRUTEAK_CITY, 8
	warp_event  6, 13, ECRUTEAK_CITY, 8

	def_coord_events

	def_bg_events
	bg_event  5,  6, BGEVENT_UP, DanceTheaterFancyPanel
	bg_event  6,  6, BGEVENT_UP, DanceTheaterFancyPanel

	def_object_events
	object_event  0,  2, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 0, TrainerKimonoGirlNaoko, -1
	object_event  2,  1, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 0, TrainerKimonoGirlSayo, -1
	object_event  6,  2, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 0, TrainerKimonoGirlZuki, -1
	object_event  9,  1, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 0, TrainerKimonoGirlKuni, -1
	object_event 11,  2, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 0, TrainerKimonoGirlMiki, -1
	object_event  7, 10, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DanceTheaterSurfGuy, -1
	object_event  6,  8, SPRITE_RHYDON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, DanceTheaterRhydon, -1
	object_event 10, 10, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, DanceTheaterCooltrainerMScript, -1
	object_event  3,  6, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DanceTheaterGrannyScript, -1
