	object_const_def
	const PLAYERSNEIGHBORSHOUSE_COOLTRAINER_F

PlayersNeighborsHouse_MapScripts:
	def_scene_scripts

	def_callbacks

PlayersNeighborsDaughterScript:
	jumptextfaceplayer PlayersNeighborsDaughterText

PlayersNeighborsHouseBookshelfScript:
	jumpstd MagazineBookshelfScript

PlayersNeighborsHouseRadioScript:
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .NormalRadio
	checkevent EVENT_LISTENED_TO_INITIAL_RADIO
	iftrue .AbbreviatedRadio
	playmusic MUSIC_POKEMON_TALK
	opentext
	writetext PlayerNeighborRadioText1
	pause 45
	writetext PlayerNeighborRadioText2
	pause 45
	writetext PlayerNeighborRadioText3
	pause 45
	musicfadeout MUSIC_NEW_BARK_TOWN, 16
	writetext PlayerNeighborRadioText4
	pause 45
	closetext
	setevent EVENT_LISTENED_TO_INITIAL_RADIO
	end
.NormalRadio:
	jumpstd Radio1Script
.AbbreviatedRadio:
	opentext
	writetext PlayerNeighborRadioText4
	pause 45
	closetext
	end

PlayersNeighborsDaughterText:
	text "ピカチュウ<WA>すで<NI>しんかした"
	line "#である！"

	para "あ<NO>ウツギはかせ<NO>はっぴょうには"
	line "<WATASHI>も　びっくり　しちゃっ<TA!>"

	para "さす<GA>#しんかの"
	line "けんきゅうで　ゆうめいな　はかせ"

	para "はあ<⋯>　<WATASHI>も　あんな"
	line "すごい　けんきゅうしゃ<NI>なりたいわ"
	done

PlayerNeighborRadioText1:
	text "オーキドはかせ<NO>#こうざ"
	line "みんな　きいて　くださいね！"
	done

PlayerNeighborRadioText2:
	text "こちら<WA>#チャンネル"
	done

PlayerNeighborRadioText3:
	text "おあいては"
	line "ディージェイ　クルミ　でし<TA!>"
	done

PlayerNeighborRadioText4:
	text "ポケ　モン"
	line "#チャンネル　<⋯>"
	done

PlayersNeighborsHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, NEW_BARK_TOWN, 3
	warp_event  3,  7, NEW_BARK_TOWN, 3

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, PlayersNeighborsHouseBookshelfScript
	bg_event  1,  1, BGEVENT_READ, PlayersNeighborsHouseBookshelfScript
	bg_event  7,  1, BGEVENT_READ, PlayersNeighborsHouseRadioScript

	def_object_events
	object_event  2,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, PlayersNeighborsDaughterScript, -1
