	object_const_def
	const CELADONMANSION3F_COOLTRAINER_M
	const CELADONMANSION3F_GYM_GUIDE
	const CELADONMANSION3F_SUPER_NERD
	const CELADONMANSION3F_FISHER

CeladonMansion3F_MapScripts:
	def_scene_scripts

	def_callbacks

GameFreakGameDesignerScript:
	faceplayer
	opentext
	writetext GameFreakGameDesignerText
	readvar VAR_DEXCAUGHT
	ifgreater NUM_POKEMON - 2 - 1, .CompletedPokedex ; ignore Mew and Celebi
	waitbutton
	closetext
	end

.CompletedPokedex:
	promptbutton
	writetext GameFreakGameDesignerCompletedPokedexText
	playsound SFX_DEX_FANFARE_230_PLUS
	waitsfx
	writetext GameFreakGameDesignerPauseForDiplomaText
	promptbutton
	special Diploma
	writetext GameFreakGameDesignerAfterDiplomaText
	waitbutton
	closetext
	setevent EVENT_ENABLE_DIPLOMA_PRINTING
	end

GameFreakGraphicArtistScript:
	faceplayer
	opentext
	checkevent EVENT_ENABLE_DIPLOMA_PRINTING
	iftrue .CanPrintDiploma
	writetext GameFreakGraphicArtistText
	waitbutton
	closetext
	end

.CanPrintDiploma:
	writetext GameFreakGraphicArtistPrintDiplomaText
	yesorno
	iffalse .Refused
	special PrintDiploma
	closetext
	end

.Refused:
	writetext GameFreakGraphicArtistRefusedText
	waitbutton
	closetext
	end

.CancelPrinting: ; unreferenced
	writetext GameFreakGraphicArtistErrorText
	waitbutton
	closetext
	end

GameFreakProgrammerScript:
	jumptextfaceplayer GameFreakProgrammerText

GameFreakCharacterDesignerScript:
	jumptextfaceplayer GameFreakCharacterDesignerText

CeladonMansion3FDevRoomSign:
	jumptext CeladonMansion3FDevRoomSignText

CeladonMansion3FDrawing:
	jumptext CeladonMansion3FDrawingText

CeladonMansion3FGameProgram:
	jumptext CeladonMansion3FGameProgramText

CeladonMansion3FReferenceMaterial:
	jumptext CeladonMansion3FReferenceMaterialText

GameFreakGameDesignerText:
	text "そーですかー！"

	para "ぼく<WA>ゲーム　デザイナー"

	para "#ずかん　ぜんぶ　あつめるの"
	line "たいへん　だけど　がんば<TTE>！"
	done

GameFreakGameDesignerCompletedPokedexText:
	text "わあ　すごい！"
	line "とうとう　#ずかん"
	cont "ぜんぶ<NO>ページ<WO>かきこんだね！"

	para "おめでとう！"
	done

GameFreakGameDesignerPauseForDiplomaText:
	text "<⋯>　<⋯>"
	done

GameFreakGameDesignerAfterDiplomaText:
	text "グラフィッカーが"
	line "ひょうしょうじょうを"
	cont "プリントして　くれるよ！"
	cont "みんな<NI>みせて　あげて！"
	done

GameFreakGraphicArtistText:
	text "おれ　グラフィッカー！"
	line "おまえ<WO>かいた<NO>おれさ！"
	done

GameFreakGraphicArtistPrintDiplomaText:
	text "おれ　グラフィッカー！"

	para "おっ　ずかん　かんせい　したんだ！"
	line "きねん<NI>ひょうしょうじょうを"
	cont "プリント　して　あげようか？"
	done

GameFreakGraphicArtistRefusedText:
	text "プリント　したく　なったら"
	line "こえ<WO>かけてね！"
	done

GameFreakGraphicArtistErrorText:
	text "なんとなく　ちょうし<GA>わるいね"
	line "プリント<WA>ちゅうし　するよ！"
	done

GameFreakProgrammerText:
	text "おれさま？"
	line "プログラマーだ！　スロット　やれよ！"
	done

GameFreakCharacterDesignerText:
	text "ふたごちゃん　かわいい　でしょ！"

	para "ミカンちゃんも　くー！"

	para "たまらんー！"
	done

CeladonMansion3FDevRoomSignText:
	text "ゲームフリーク　かいはつ　しつ"
	done

CeladonMansion3FDrawingText:
	text "きれいな　え　<GA>かいてある"
	line "<⋯>みりょくてきな　おんなのこだ！"
	done

CeladonMansion3FGameProgramText:
	text "ゲーム<NO>プログラムだ！"
	line "これ　かえたら　バグる　かも！"
	done

CeladonMansion3FReferenceMaterialText:
	text "いろんな　しりょう<GA>いっぱい"
	line "<⋯>ピッピにんぎょう　だ！"
	done

CeladonMansion3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  0, CELADON_MANSION_ROOF, 1
	warp_event  1,  0, CELADON_MANSION_2F, 2
	warp_event  6,  0, CELADON_MANSION_2F, 3
	warp_event  7,  0, CELADON_MANSION_ROOF, 2

	def_coord_events

	def_bg_events
	bg_event  5,  8, BGEVENT_UP, CeladonMansion3FDevRoomSign
	bg_event  4,  3, BGEVENT_UP, CeladonMansion3FDrawing
	bg_event  1,  6, BGEVENT_UP, CeladonMansion3FGameProgram
	bg_event  1,  3, BGEVENT_UP, CeladonMansion3FReferenceMaterial

	def_object_events
	object_event  3,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GameFreakGameDesignerScript, -1
	object_event  3,  4, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GameFreakGraphicArtistScript, -1
	object_event  0,  7, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GameFreakProgrammerScript, -1
	object_event  0,  4, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GameFreakCharacterDesignerScript, -1
