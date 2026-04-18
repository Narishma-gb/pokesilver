	object_const_def
	const BILLSHOUSE_GRAMPS

BillsHouse_MapScripts:
	def_scene_scripts

	def_callbacks

BillsGrandpa:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .JustShowedSomething
	checkevent EVENT_GOT_THUNDERSTONE_FROM_BILLS_GRANDPA
	iftrue .GotThunderstone
	checkevent EVENT_MET_BILLS_GRANDPA
	iftrue .MetGrandpa
	writetext BillsGrandpaIntroText
	promptbutton
	setevent EVENT_MET_BILLS_GRANDPA
.MetGrandpa:
	checkevent EVENT_SHOWED_PICHU_TO_BILLS_GRANDPA
	iftrue .ShowedPichu
	checkevent EVENT_SHOWED_GROWLITHE_VULPIX_TO_BILLS_GRANDPA
	iftrue .ShowedGrowlitheVulpix
	checkevent EVENT_SHOWED_STARYU_TO_BILLS_GRANDPA
	iftrue .ShowedStaryu
	checkevent EVENT_SHOWED_ODDISH_TO_BILLS_GRANDPA
	iftrue .ShowedOddish
	checkevent EVENT_SHOWED_LICKITUNG_TO_BILLS_GRANDPA
	iftrue .ShowedLickitung
	writetext BillsGrandpaLickitungText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse .SaidNo
	scall .ExcitedToSee
	special BillsGrandfather
	iffalse .SaidNo
	ifnotequal LICKITUNG, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_LICKITUNG_TO_BILLS_GRANDPA
	sjump .ShowedLickitung

.GotEverstone:
	writetext BillsGrandpaOddishText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse .SaidNo
	scall .ExcitedToSee
	special BillsGrandfather
	iffalse .SaidNo
	ifnotequal ODDISH, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_ODDISH_TO_BILLS_GRANDPA
	sjump .ShowedOddish

.GotLeafStone:
	writetext BillsGrandpaStaryuText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse .SaidNo
	scall .ExcitedToSee
	special BillsGrandfather
	iffalse .SaidNo
	ifnotequal STARYU, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_STARYU_TO_BILLS_GRANDPA
	sjump .ShowedStaryu

.GotWaterStone:
	checkver
	iftrue .AskVulpix
	writetext BillsGrandpaGrowlitheText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse .SaidNo
	scall .ExcitedToSee
	special BillsGrandfather
	iffalse .SaidNo
	ifnotequal GROWLITHE, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_GROWLITHE_VULPIX_TO_BILLS_GRANDPA
	sjump .ShowedGrowlitheVulpix

.AskVulpix:
	writetext BillsGrandpaVulpixText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse .SaidNo
	scall .ExcitedToSee
	special BillsGrandfather
	iffalse .SaidNo
	ifnotequal VULPIX, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_GROWLITHE_VULPIX_TO_BILLS_GRANDPA
	sjump .ShowedGrowlitheVulpix

.GotFireStone:
	writetext BillsGrandpaPichuText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse .SaidNo
	scall .ExcitedToSee
	special BillsGrandfather
	iffalse .SaidNo
	ifnotequal PICHU, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_PICHU_TO_BILLS_GRANDPA
	sjump .ShowedPichu

.ShowedLickitung:
	checkevent EVENT_GOT_EVERSTONE_FROM_BILLS_GRANDPA
	iftrue .GotEverstone
	scall .ReceiveItem
	verbosegiveitem EVERSTONE
	iffalse .BagFull
	setevent EVENT_GOT_EVERSTONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	closetext
	end

.ShowedOddish:
	checkevent EVENT_GOT_LEAF_STONE_FROM_BILLS_GRANDPA
	iftrue .GotLeafStone
	scall .ReceiveItem
	verbosegiveitem LEAF_STONE
	iffalse .BagFull
	setevent EVENT_GOT_LEAF_STONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	closetext
	end

.ShowedStaryu:
	checkevent EVENT_GOT_WATER_STONE_FROM_BILLS_GRANDPA
	iftrue .GotWaterStone
	scall .ReceiveItem
	verbosegiveitem WATER_STONE
	iffalse .BagFull
	setevent EVENT_GOT_WATER_STONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	closetext
	end

.ShowedGrowlitheVulpix:
	checkevent EVENT_GOT_FIRE_STONE_FROM_BILLS_GRANDPA
	iftrue .GotFireStone
	scall .ReceiveItem
	verbosegiveitem FIRE_STONE
	iffalse .BagFull
	setevent EVENT_GOT_FIRE_STONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	closetext
	end

.ShowedPichu:
	scall .ReceiveItem
	verbosegiveitem THUNDERSTONE
	iffalse .BagFull
	setevent EVENT_GOT_THUNDERSTONE_FROM_BILLS_GRANDPA
	closetext
	end

.ExcitedToSee:
	writetext BillsGrandpaExcitedToSeeText
	promptbutton
	end

.SaidNo:
	writetext BillsGrandpaYouDontHaveItTextText
	waitbutton
	closetext
	end

.CorrectPokemon:
	writetext BillsGrandpaShownPokemonText
	promptbutton
	end

.ReceiveItem:
	writetext BillsGrandpaTokenOfAppreciationText
	promptbutton
	end

.JustShowedSomething:
	writetext BillsGrandpaComeAgainText
	waitbutton
	closetext
	end

.GotThunderstone:
	writetext BillsGrandpaShownAllThePokemonText
	waitbutton
	closetext
	end

.WrongPokemon:
	writetext BillsGrandpaWrongPokemonText
	waitbutton
	closetext
	end

.BagFull:
	closetext
	end

BillsGrandpaIntroText:
	text "おや？　あんた"
	line "マサキ<NO>こと<WO>しっとるのかね？"
	cont "マサキ<WA>わし<NO>まごじゃ！"

	para "ジョウトで　<PC><⋯>　なんとかの"
	line "しごと<WO>しているのでな"
	cont "わし<GA>るすばん　しているのじゃ！"
	done

BillsGrandpaAskToSeeMonText:
	text "そ<NO>#<WO>も<TTE>いたら"
	line "ぜひ　みせて　ほしいのじゃが<⋯>"
	done

BillsGrandpaExcitedToSeeText:
	text "おお　みせて　くれるか！"
	line "ありがたいのう！"
	done

BillsGrandpaYouDontHaveItTextText:
	text "も<TTE>いないのかい？"
	line "ざんねん　じゃのう<⋯>"
	done

BillsGrandpaShownPokemonText:
	text "おお　それ<GA>@"
	text_ram wStringBuffer3
	text "か！"
	line "かわいい　#　じゃのう！"

	para "いいもの<WO>みせて　もらった"
	done

BillsGrandpaTokenOfAppreciationText:
	text "ありがとう！"

	para "おれい<NI>これ<WO>あげよう！"
	done

BillsGrandpaComeAgainText:
	text "また　あそび<NI>おいで"
	done

BillsGrandpaShownAllThePokemonText:
	text "かわいい　#を"
	line "たくさん　みせて　もらったね"
	cont "ありがとう！"

	para "すごく　たのしかったよ！"
	line "いやあ　ながいき<WA>するもんじゃ！"
	done

BillsGrandpaWrongPokemonText:
	text "うーむ<⋯>"

	para "はなし<NI>きいた　#は"
	line "それで<WA>ないみたい　じゃのう<⋯>"
	done

BillsGrandpaLickitungText:
	text "まご<NO>マサキ<GA>い<TTE>いたが"
	line "ながーい　したで　ぺろり！　と"
	cont "なめる　#<GA>いるそうじゃの"
	done

BillsGrandpaOddishText:
	text "そうそう　まご<NI>きいたんじゃが"
	line "まるくて　みどりいろで"
	cont "あたま<NI>はっぱ<GA>はえている"
	cont "#<GA>いるそうじゃの"
	done

BillsGrandpaStaryuText:
	text "からだ<NI>あかい　たまのある"
	line "うみ<NO>#<GA>いるじゃろ？"
	cont "ほし<NO>かたちをした　やつじゃ"

	para "よるになると　あらわれる　そうじゃが"
	line "わしゃあ　みて　みたいのー！"
	done

BillsGrandpaGrowlitheText:
	text "おや<NO><TRAINER><NI>ちゅうじつで"
	line "ほえること<GA>とくいな　#が"
	cont "いると　マサキ<NI>きいたぞ"
	done

BillsGrandpaVulpixText:
	text "６ぽん<NO>しっぽ<WO>もった"
	line "キュートな　#<GA>いるそうじゃ"

	para "わしも　いちど　その#を"
	line "だきしめてみたい　ものじゃー"
	done

BillsGrandpaPichuText:
	text "だいにんき<NO>#が"
	line "いるじゃろう！"

	para "ほれ！　きいろい　からだで"
	line "あかい　ほっぺた<NO>#じゃ！"

	para "それ<GA>しんかする　まえのすがた"
	line "いちど　みてみたい　ものじゃー！"
	done

BillsHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_25, 1
	warp_event  3,  7, ROUTE_25, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 2, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, BillsGrandpa, -1
