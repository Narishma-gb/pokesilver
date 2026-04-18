	object_const_def
	const OLIVINECAFE_SAILOR
	const OLIVINECAFE_FISHING_GURU

OlivineCafe_MapScripts:
	def_scene_scripts

	def_callbacks

OlivineCafeStrengthSailorScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_HM04_STRENGTH
	iftrue .GotStrength
	writetext OlivineCafeStrengthSailorText
	promptbutton
	verbosegiveitem HM_STRENGTH
	setevent EVENT_GOT_HM04_STRENGTH
.GotStrength:
	writetext OlivineCafeStrengthSailorText_GotStrength
	waitbutton
	closetext
	end

OlivineCafeFishingGuruScript:
	jumptextfaceplayer OlivineCafeFishingGuruText

OlivineCafeStrengthSailorText:
	text "なんだあ？　ずいぶんと"
	line "ひよわそうな　#だな"

	para "そんなんじゃあ"
	line "おっきな　いわも　おせないだろう"

	para "こいつ<WO>つか<TTE>"
	line "かいりき<NO>わざ　おしえてやれ！"

	para "ただし　たたか<TTE>ないときに"
	line "つかうなら　コガネ<NO>ジムバッジが"
	cont "ひつよう　だからな！"
	done

OlivineCafeStrengthSailorText_GotStrength:
	text "うみ<NO>うえで　たよれるのは"
	line "おのれ<NO>にくたい　のみ！"
	cont "ちからづよさ<GA>じまん　なんだ！"
	done

OlivineCafeFishingGuruText:
	text "うみ<WO>わたる　つもりか"
	line "なら　はなし<WO>きけ！"

	para "いいか　ここから　タンバまで"
	line "ところどころ　うず<WO>まいている"

	para "とくべつな　わざ<WO>おしえないと"
	line "うず<NO>うえ<WA>すすめんぞ！"
	done

OlivineCafe_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, OLIVINE_CITY, 7
	warp_event  3,  7, OLIVINE_CITY, 7

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  3, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCafeStrengthSailorScript, -1
	object_event  1,  5, SPRITE_FISHING_GURU, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivineCafeFishingGuruScript, -1
