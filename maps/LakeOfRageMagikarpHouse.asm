	object_const_def
	const LAKEOFRAGEMAGIKARPHOUSE_FISHING_GURU

LakeOfRageMagikarpHouse_MapScripts:
	def_scene_scripts

	def_callbacks

MagikarpLengthRaterScript:
	faceplayer
	opentext
	checkevent EVENT_LAKE_OF_RAGE_ELIXIR_ON_STANDBY
	iftrue .GetReward
	checkevent EVENT_LAKE_OF_RAGE_ASKED_FOR_MAGIKARP
	iftrue .AskedForMagikarp
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .ClearedRocketHideout
	checkevent EVENT_LAKE_OF_RAGE_EXPLAINED_WEIRD_MAGIKARP
	iftrue .ExplainedHistory
	writetext MagikarpLengthRaterText_LakeOfRageHistory
	waitbutton
	closetext
	setevent EVENT_LAKE_OF_RAGE_EXPLAINED_WEIRD_MAGIKARP
	end

.ExplainedHistory:
	writetext MagikarpLengthRaterText_MenInBlack
	waitbutton
	closetext
	end

.ClearedRocketHideout:
	writetext MagikarpLengthRaterText_WorldsLargestMagikarp
	waitbutton
	closetext
	setevent EVENT_LAKE_OF_RAGE_ASKED_FOR_MAGIKARP
	end

.AskedForMagikarp:
	setval MAGIKARP
	special FindPartyMonThatSpecies
	iffalse .ClearedRocketHideout
	writetext MagikarpLengthRaterText_YouHaveAMagikarp
	waitbutton
	special CheckMagikarpLength
	ifequal MAGIKARPLENGTH_NOT_MAGIKARP, .NotMagikarp
	ifequal MAGIKARPLENGTH_REFUSED, .Refused
	ifequal MAGIKARPLENGTH_TOO_SHORT, .TooShort
	; MAGIKARPLENGTH_BEAT_RECORD
	sjump .GetReward

.GetReward:
	writetext MagikarpLengthRaterText_Memento
	promptbutton
	verbosegiveitem ETHER
	iffalse .NoRoom
	writetext MagikarpLengthRaterText_Bonus
	waitbutton
	closetext
	clearevent EVENT_LAKE_OF_RAGE_ELIXIR_ON_STANDBY
	end

.NoRoom:
	closetext
	setevent EVENT_LAKE_OF_RAGE_ELIXIR_ON_STANDBY
	end

.TooShort:
	writetext MagikarpLengthRaterText_TooShort
	waitbutton
	closetext
	end

.NotMagikarp:
	writetext MagikarpLengthRaterText_NotMagikarp
	waitbutton
	closetext
	end

.Refused:
	writetext MagikarpLengthRaterText_Refused
	waitbutton
	closetext
	end

LakeOfRageMagikarpHouseUnusedRecordSign: ; unreferenced
	jumptext LakeOfRageMagikarpHouseUnusedRecordText

MagikarpHouseBookshelf:
	jumpstd DifficultBookshelfScript

MagikarpLengthRaterText_LakeOfRageHistory:
	text "こ<NO>いかりのみずうみ　は"
	line "ギャラドス<GA>あばれたあと<NO>あなに"
	cont "あまみず<GA>たま<TTE>　できた<TTE>よ"

	para "じいさん<NO>じいさん<NO>そのまた"
	line "じいさん<NO>はなし　だけどな"

	para "まえ<WA>いき<NO>いい"
	line "コイキング<GA>つれる"
	cont "みずうみ　だったのに<⋯>"

	para "いったいぜんたい　どうしたんだ？"
	done

MagikarpLengthRaterText_MenInBlack:
	text "みずうみ<GA>おかしくなったのは"
	line "くろい　ふく<NO>おとこたちが"
	cont "ウロウロ　しはじめて　からだな"
	done

MagikarpLengthRaterText_WorldsLargestMagikarp:
	text "いやあ　いかりのみずうみ"
	line "むかしのよう<NI>いき<NO>いい"
	cont "コイキング<GA>つれるよう<NI>なった"

	para "これで　せかいいち"
	line "おおきな　コイキング<WO>みるという"
	cont "ゆめ<GA>はたせそうだ"

	para "キミ<WA>つりざお　も<TTE>る？"
	line "よかったら　てつだ<TTE>くれたまえ"
	done

MagikarpLengthRaterText_YouHaveAMagikarp:
	text "おっ　コイキング<WO>も<TTE>いるのか"
	line "で<WA>じまん<NO>コイキング"
	cont "みせて　もらうよ！"
	done

MagikarpLengthRaterText_Memento:
	text "こいつ<WA>みごと！"

	para "きみ<NO>うでまえ<NI>だつぼう　だな"
	line "きねん<NI>これ<WO>も<TTE>いきなさい"
	done

MagikarpLengthRaterText_Bonus:
	text "まっ　だいじなの<WA>きろくだから"
	line "それ<WA>おまけ　みたいなもんだよ"
	done

MagikarpLengthRaterText_TooShort:
	text "こいつ<WA>みごと！"

	para "といいたい<GA>まえ<NI>つったほうが"
	line "おおも<NO>だったな"
	done

MagikarpLengthRaterText_NotMagikarp:
	text "なぬっ！"
	line "そりゃ　コイキング　じゃないよ"
	done

MagikarpLengthRaterText_Refused:
	text "そうか<⋯>"
	line "みせるほど<NO>やつ<WA>つれなかったか"
	cont "まっ　つぎ<WA>すごい<NO>みせてよ"
	done

LakeOfRageMagikarpHouseUnusedRecordText:
	text "いま<NO>きろく<⋯>"
	line "@"
	text_ram wStringBuffer3
	text "　@"
	text_ram wStringBuffer4
	text_start
	done

LakeOfRageMagikarpHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, LAKE_OF_RAGE, 2
	warp_event  3,  7, LAKE_OF_RAGE, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, MagikarpHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, MagikarpHouseBookshelf

	def_object_events
	object_event  2,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MagikarpLengthRaterScript, -1
