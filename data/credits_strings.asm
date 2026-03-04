CreditsStringsPointers:
; entries correspond to constants/credits_constants.asm
	table_width 2
	dw Credits_SatoshiTajiri
	dw Credits_JunichiMasuda
	dw Credits_TetsuyaWatanabe
	dw Credits_ShigekiMorimoto
	dw Credits_SousukeTamada
	dw Credits_TakenoriOota
	dw Credits_KenSugimori
	dw Credits_MotofumiFujiwara
	dw Credits_AtsukoNishida
	dw Credits_MuneoSaito
	dw Credits_SatoshiOota
	dw Credits_RenaYoshikawa
	dw Credits_JunOkutani
	dw Credits_HironobuYoshida
	dw Credits_AsukaIwashita
	dw Credits_GoIchinose
	dw Credits_MorikazuAoki
	dw Credits_KohjiNishino
	dw Credits_KenjiMatsushima
	dw Credits_ToshinobuMatsumiya
	dw Credits_SatoruIwata
	dw Credits_NobuhiroSeya
	dw Credits_KazuhitoSekine
	dw Credits_TetsujiOota
	dw Credits_NclSuperMarioClub
	dw Credits_Sarugakucho
	dw Credits_AkitoMori
	dw Credits_TakahiroHarada
	dw Credits_TohruHashimoto
	dw Credits_NoboruMatsumoto
	dw Credits_TakehiroIzushi
	dw Credits_TakashiKawaguchi
	dw Credits_TsunekazuIshihara
	dw Credits_HiroshiYamauchi
	dw Credits_KenjiSaiki
	dw Credits_AtsushiTada
	dw Credits_NaokoKawakami
	dw Credits_HiroyukiZinnai
	dw Credits_KunimiKawamura
	dw Credits_End
	dw Credits_Staff
	dw Credits_Director
	dw Credits_SubDirector
	dw Credits_Programmers
	dw Credits_GraphicsDirector
	dw Credits_MonsterDesign
	dw Credits_GraphicsDesign
	dw Credits_Music
	dw Credits_SoundEffects
	dw Credits_GameDesign
	dw Credits_GameScenario
	dw Credits_ToolProgramming
	dw Credits_ParametricDesign
	dw Credits_ScriptDesign
	dw Credits_MapDataDesign
	dw Credits_MapDesign
	dw Credits_ProductTesting
	dw Credits_SpecialThanks
	dw Credits_Producers
	dw Credits_ExecutiveProducer
	dw Credits_Copyright
	assert_table_length NUM_CREDITS_STRINGS

Credits_SatoshiTajiri::       db "たじり　さとし@"
Credits_JunichiMasuda::       db "ますだ　じゅんいち@"
Credits_TetsuyaWatanabe::     db "わたなべ　てつや@"
Credits_ShigekiMorimoto::     db "もりもと　しげき@"
Credits_SousukeTamada::       db "たまだ　そうすけ@"
Credits_TakenoriOota::        db "おおた　たけのり@"
Credits_KenSugimori::         db "すぎもり　けん@"
Credits_MotofumiFujiwara::    db "ふじわら　もとふみ@"
Credits_AtsukoNishida::       db "にしだ　あつこ@"
Credits_MuneoSaito::          db "さいとう　むねお@"
Credits_SatoshiOota::         db "おおた　さとし@"
Credits_RenaYoshikawa::       db "よしかわ　れな@"
Credits_JunOkutani::          db "おくたに　じゅん@"
Credits_HironobuYoshida::     db "よしだ　ひろのぶ@"
Credits_AsukaIwashita::       db "いわした　あすか@"
Credits_GoIchinose::          db "いちのせ　ごう@"
Credits_MorikazuAoki::        db "あおき　もりかず@"
Credits_KohjiNishino::        db "にしの　こうじ@"
Credits_KenjiMatsushima::     db "まつしま　けんじ@"
Credits_ToshinobuMatsumiya::  db "まつみや　としのぶ@"
Credits_SatoruIwata::         db "いわた　さとる@"
Credits_NobuhiroSeya::        db "せや　のぶひろ@"
Credits_KazuhitoSekine::      db "せきね　かずひと@"
Credits_TetsujiOota::         db "おおた　てつじ@"
Credits_NclSuperMarioClub::   db "スーパーマリオクラブ@"
Credits_Sarugakucho::         db "さるがくちょう@"
Credits_AkitoMori::           db "もり　あきと@"
Credits_TakahiroHarada::      db "はらだ　たかひろ@"
Credits_TohruHashimoto::      db "はしもと　とおる@"
Credits_NoboruMatsumoto::     db "まつもと　のぼる@"
Credits_TakehiroIzushi::      db "いずし　たけひろ@"
Credits_TakashiKawaguchi::    db "かわぐち　たかし@"
Credits_TsunekazuIshihara::   db "いしはら　つねかず@"
Credits_HiroshiYamauchi::     db "やまうち　ひろし@"
Credits_KenjiSaiki::          db "さいき　けんじ@"
Credits_AtsushiTada::         db "ただ　あつし@"
Credits_NaokoKawakami::       db "かわかみ　なおこ@"
Credits_HiroyukiZinnai::      db "じんない　ひろゆき@"
Credits_KunimiKawamura::      db "かわむら　くにみ@"
Credits_End::                 db "おしまい@"
Credits_Staff::               db "ポケットモンスター"
                            IF DEF(_GOLD)
                            next "　　　　　　きんバージョン"
                            ELIF DEF(_SILVER)
                            next "　　　　　　ぎんバージョン"
                            ENDC
                            next "　　　　スタッフ@"
Credits_Director::            db "ディレクター@"
Credits_SubDirector::         db "サブディレクター@"
Credits_Programmers::         db "プログラム@"
Credits_GraphicsDirector::    db "グラフィック　ディレクター@"
Credits_MonsterDesign::       db "#　デザイン@"
Credits_GraphicsDesign::      db "グラフィック　デザイン@"
Credits_Music::               db "おんがく@"
Credits_SoundEffects::        db "サウンド　エフェクト@"
Credits_GameDesign::          db "ゲームデザイン@"
Credits_GameScenario::        db "シナリオ@"
Credits_ToolProgramming::     db "ツール　プログラム@"
Credits_ParametricDesign::    db "パラメーター　せってい@"
Credits_ScriptDesign::        db "スクリプト　せってい@"
Credits_MapDataDesign::       db "マップデータ　せってい@"
Credits_MapDesign::           db "マップ　デザイン@"
Credits_ProductTesting::      db "デバッグプレイ@"
Credits_SpecialThanks::       db "スペシャルサンクス@"
Credits_Producers::           db "プロデューサー@"
Credits_ExecutiveProducer::   db "エグゼクティブ　プロデューサー@"

Credits_Copyright::
	;    (C) 1  9  9  5 - 1  9  9  9        N  i  n  t  e  n  d  o
	db   $60, $61, $62, $63, $61, $62, $64, $65, $66, $67, $68, $69, $6a
	;    (C) 1  9  9  5 - 1  9  9  9        C  r  e  a  t  u  r  e  s     i  n  c .
	next $60, $61, $62, $63, $61, $62, $64, $6b, $6c, $6d, $6e, $6f, $70, $71, $72
	;    (C) 1  9  9  5 - 1  9  9  9        G  A  M  E  F  R  E  A  K     i  n  c .
	next $60, $61, $62, $63, $61, $62, $64, $73, $74, $75, $76, $77, $78, $79, $71, $72
	db "@"
