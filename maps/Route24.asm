	object_const_def
	const ROUTE24_ROCKET

Route24_MapScripts:
	def_scene_scripts

	def_callbacks

Route24RocketScript:
	faceplayer
	playmusic MUSIC_ROCKET_ENCOUNTER
	opentext
	writetext Route24RocketSeenText
	waitbutton
	closetext
	winlosstext Route24RocketBeatenText, -1
	loadtrainer GRUNTM, GRUNTM_31
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	playmusic MUSIC_ROCKET_ENCOUNTER
	opentext
	writetext Route24RocketAfterBattleText
	promptbutton
	special FadeOutMusic
	writetext Route24RocketDisappearsText
	waitbutton
	closetext
	special FadeOutToBlack
	special ReloadSpritesNoPalettes
	disappear ROUTE24_ROCKET
	pause 25
	special FadeInFromBlack
	playmapmusic
	end

Route24RocketSeenText:
	text "ヘーイ　キッド！"
	line "<WATASHI>　<ROCKET>　メンバーね！"

	para "いこく<NO>カントリーから　カミング"
	line "ナンバーワン　<TRAINER>よ！"

	para "<WATASHI>　ひとりで　シンキング"
	line "ストップ　ザ　エネルギーで"
	cont "ピープル　おどろき　もものき！"
	cont "パニック<NI>なるね！"

	para "マイ　オペレーション"
	line "ユー<NI>おしえる　できませーん！"

	para "しかーし！"
	line "<WATASHI><NI>ウイン　できたなら"
	cont "<WATASHI>　おとこらしく　シークレット"
	cont "ユー<NI>おしえまーす！"

	para "ヘイ！　キッド！"
	line "レッツ　バトル　ビギンよ！"
	done

Route24RocketBeatenText:
	text "オー　ノー！"
	line "キャント　ビリーブ！"

	para "ユー<WA>ブルーベリー　ストロベリー！"
	line "<⋯>ソーリー　ミステイク！"
	cont "ユー<WA>ベリー　ストロング！"
	cont "は<GA>たちませーん！"
	done

Route24RocketAfterBattleText:
	text "わかりました<⋯>"
	line "マイ　シークレット　おしえまーす"

	para "マシンのぶひん　ぬすんで　かくした"
	line "イン　ザ　ジム　オブ　ハナダ！"

	para "みずのなか　ルック　フォー　すれば"
	line "ユー<WA>きっと　みつけるでしょう"
	cont "ジャスト　センター　あたり　でーす！"

	para "しかーし！"
	line "ドント　フォーゲット！"

	para "<ROCKET>　ユー<WO>かならず"
	line "たおしてごらんにいれまーす！"
	cont "ジョウト<NO>マイ　フレンド"
	cont "みんな　ここ<NI>や<TTE>きまーす！"
	done

Route24RocketDisappearsText:
	text "<⋯>　<⋯>　<⋯>"
	line "<⋯>　<⋯>　<⋯>"
	cont "フォワット？"
	cont "<ROCKET>　ブロークン？"
	cont "きえて　なくなった　ですかー？"

	para "オー！　ノー！"
	line "<WATASHI>　これから"
	cont "どーすれば　いい　ですかー！？"
	done

Route24_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event  8,  7, SPRITE_ROCKET, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route24RocketScript, EVENT_ROUTE_24_ROCKET
