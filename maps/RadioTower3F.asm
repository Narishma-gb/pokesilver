	object_const_def
	const RADIOTOWER3F_SUPER_NERD
	const RADIOTOWER3F_GYM_GUIDE
	const RADIOTOWER3F_COOLTRAINER_F
	const RADIOTOWER3F_ROCKET1
	const RADIOTOWER3F_ROCKET2
	const RADIOTOWER3F_ROCKET3
	const RADIOTOWER3F_SCIENTIST

RadioTower3F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, RadioTower3FCardKeyShutterCallback

RadioTower3FCardKeyShutterCallback:
	checkevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	iftrue .Change
	endcallback

.Change:
	changeblock 14, 2, $2a ; open shutter
	changeblock 14, 4, $01 ; floor
	endcallback

RadioTower3FSuperNerdScript:
	jumptextfaceplayer RadioTower3FSuperNerdText

RadioTower3FGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .NoRockets
	writetext RadioTower3FGymGuideText_Rockets
	waitbutton
	closetext
	end

.NoRockets:
	writetext RadioTower3FGymGuideText
	waitbutton
	closetext
	end

RadioTower3FCooltrainerFScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_SUNNY_DAY_FROM_RADIO_TOWER
	iftrue .GotSunnyDay
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .NoRockets
	checkevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	iftrue .UsedCardKey
	writetext RadioTower3FCooltrainerFPleaseSaveDirectorText
	waitbutton
	closetext
	end

.UsedCardKey:
	writetext RadioTower3FCooltrainerFIsDirectorSafeText
	waitbutton
	closetext
	end

.NoRockets:
	writetext RadioTower3FCooltrainerFYoureMyHeroText
	promptbutton
	verbosegiveitem TM_SUNNY_DAY
	iffalse .NoRoom
	writetext RadioTower3FCooltrainerFItsSunnyDayText
	waitbutton
	closetext
	setevent EVENT_GOT_SUNNY_DAY_FROM_RADIO_TOWER
	end

.GotSunnyDay:
	writetext RadioTower3FCooltrainerFYouWereMarvelousText
	waitbutton
.NoRoom:
	closetext
	end

TrainerGruntM7:
	trainer GRUNTM, GRUNTM_7, EVENT_BEAT_ROCKET_GRUNTM_7, GruntM7SeenText, GruntM7BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM7AfterBattleText
	waitbutton
	closetext
	end

TrainerGruntM8:
	trainer GRUNTM, GRUNTM_8, EVENT_BEAT_ROCKET_GRUNTM_8, GruntM8SeenText, GruntM8BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM8AfterBattleText
	waitbutton
	closetext
	end

TrainerGruntM9:
	trainer GRUNTM, GRUNTM_9, EVENT_BEAT_ROCKET_GRUNTM_9, GruntM9SeenText, GruntM9BeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GruntM9AfterBattleText
	waitbutton
	closetext
	end

TrainerScientistMarc:
	trainer SCIENTIST, MARC, EVENT_BEAT_SCIENTIST_MARC, ScientistMarcSeenText, ScientistMarcBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext ScientistMarcAfterBattleText
	waitbutton
	closetext
	end

CardKeySlotScript::
	opentext
	writetext RadioTower3FCardKeySlotText
	waitbutton
	checkevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	iftrue .UsedCardKey
	checkitem CARD_KEY
	iftrue .HaveCardKey
.UsedCardKey:
	closetext
	end

.HaveCardKey:
	writetext InsertedTheCardKeyText
	waitbutton
	setevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	playsound SFX_ENTER_DOOR
	changeblock 14, 2, $2a ; open shutter
	changeblock 14, 4, $01 ; floor
	refreshmap
	closetext
	waitsfx
	end

RadioTower3FPersonnelSign:
	jumptext RadioTower3FPersonnelSignText

RadioTower3FPokemonMusicSign:
	jumptext RadioTower3FPokemonMusicSignText

RadioTower3FSuperNerdText:
	text "いままで<NI>みつかった　#の"
	line "なきごえ<WA>ぜんぶ　そろえているよ！"
	cont "２００しゅるい　くらい　あるね！"
	done

RadioTower3FGymGuideText_Rockets:
	text "#<TTE>の<WA><TRAINER>にと<TTE>"
	line "だいじな　パートナーだろ"

	para "なの<NI>あんな　めいれい　するなんて"
	line "#<GA>かわいそう　すぎるよ！"
	done

RadioTower3FGymGuideText:
	text "うち<WA>２４じかん　えいぎょう！"

	para "いつでも　たのしい　ばんぐみを"
	line "きいて　もらえるように"
	cont "ぼくも　２４じかん　がんばるぞ！"
	done

RadioTower3FCooltrainerFPleaseSaveDirectorText:
	text "こいつら<NO>ボスが"
	line "とびら<NO>むこう<NI>たてこもったの"

	para "なかから　カギ<WO>かけられたけど"
	line "きょくちょう　なら　あけられるわ！"

	para "きょくちょう<WA>５かいよ！"
	line "おねがい　たすけて　あげて！"
	done

RadioTower3FCooltrainerFIsDirectorSafeText:
	text "きょくちょう<WA>だいじょうぶ　なの？"
	done

RadioTower3FCooltrainerFYoureMyHeroText:
	text "ありがとね　ちいさな　えいゆうさん！"
	line "これ<WA><WATASHI>から<NO>おれいよ！"
	done

RadioTower3FCooltrainerFItsSunnyDayText:
	text "なかみ<WA>にほんばれ"
	line "いちど　つかうと　しばらく"
	cont "ほのおタイプ<NO>いりょく<GA>あがるわ"
	done

RadioTower3FCooltrainerFYouWereMarvelousText:
	text "だいかつやく　だったわね！"
	done

GruntM7SeenText:
	text "<⋯>　おれ<NO>にんむ"

	para "<ROCKET><NO>じゃまする　やつを"
	line "さいきふのう<NI>すること！"
	done

GruntM7BeatenText:
	text "！！！"
	done

GruntM7AfterBattleText:
	text "<⋯>　にんむ　しっぱい"
	line "<⋯>　きゅうりょう　へらされちまう"
	done

GruntM8SeenText:
	text "#<NI>わるいこと"
	line "めいれい　するの<WA>きぶん　いいぜ！"
	done

GruntM8BeatenText:
	text "<⋯>　なにい！"
	done

GruntM8AfterBattleText:
	text "まけると　きぶんわるい　じゃねーか！"
	line "ちくしょう！"
	cont "やくたたず<NO>#め！"
	done

GruntM9SeenText:
	text "シャッター<GA>あいた？　どうしてだ？"
	line "おまえと　なんか　かんけいあるのか？"
	done

GruntM9BeatenText:
	text "やられたあ"
	done

GruntM9AfterBattleText:
	text "なにい！"
	line "ちかつうろ<WO>とっぱ　し<TA!>？"
	cont "なんて　やつ！"
	done

ScientistMarcSeenText:
	text "みなれぬ　こども<GA>うろちょろと<⋯>"
	line "なんなんだ　きみは！？"
	done

ScientistMarcBeatenText:
	text "ちっ"
	line "みくびったか"
	done

ScientistMarcAfterBattleText:
	text "くくく<⋯>　ここから　なら"
	line "おもうぞんぶん　でんぱ<WO>ながせる"
	done

RadioTower3FCardKeySlotText:
	text "カードキー<NO>さしこみぐちだ！"
	done

InsertedTheCardKeyText:
	text "<PLAYER>は"
	line "カードキー<WO>さしこんだ！"
	done

RadioTower3FPersonnelSignText:
	text "３かい　<⋯>　そうむぶ"
	done

RadioTower3FPokemonMusicSignText:
	text "#　ミュージック"
	line "おあいて<WA>セージで　ごじゃる"
	done

RadioTower3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  0, RADIO_TOWER_2F, 1
	warp_event  7,  0, RADIO_TOWER_4F, 2
	warp_event 17,  0, RADIO_TOWER_4F, 4

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_READ, RadioTower3FPersonnelSign
	bg_event  9,  0, BGEVENT_READ, RadioTower3FPokemonMusicSign
	bg_event 14,  2, BGEVENT_UP, CardKeySlotScript

	def_object_events
	object_event  7,  4, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RadioTower3FSuperNerdScript, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	object_event  3,  4, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower3FGymGuideScript, -1
	object_event 11,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTower3FCooltrainerFScript, -1
	object_event  5,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerGruntM7, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  6,  2, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM8, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 16,  6, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM9, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  9,  6, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 5, TrainerScientistMarc, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
