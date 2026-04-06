	object_const_def
	const OLIVINELIGHTHOUSE3F_SAILOR
	const OLIVINELIGHTHOUSE3F_GENTLEMAN
	const OLIVINELIGHTHOUSE3F_YOUNGSTER
	const OLIVINELIGHTHOUSE3F_POKE_BALL

OlivineLighthouse3F_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerBirdKeeperTheo:
	trainer BIRD_KEEPER, THEO, EVENT_BEAT_BIRD_KEEPER_THEO, BirdKeeperTheoSeenText, BirdKeeperTheoBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BirdKeeperTheoAfterBattleText
	waitbutton
	closetext
	end

TrainerGentlemanPreston:
	trainer GENTLEMAN, PRESTON, EVENT_BEAT_GENTLEMAN_PRESTON, GentlemanPrestonSeenText, GentlemanPrestonBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext GentlemanPrestonAfterBattleText
	waitbutton
	closetext
	end

TrainerSailorTerrell:
	trainer SAILOR, TERRELL, EVENT_BEAT_SAILOR_TERRELL, SailorTerrellSeenText, SailorTerrellBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SailorTerrellAfterBattleText
	waitbutton
	closetext
	end

OlivineLighthouse3FEther:
	itemball ETHER

BirdKeeperTheoSeenText:
	text "きみ<WA>なんなんだ？"
	line "おみまいか？　ひやかしか？"
	cont "ひやかしなら　かえ<TTE>もらうよ！"
	done

BirdKeeperTheoBeatenText:
	text "ほんき　だね"
	line "おみまい　するんだね"
	done

BirdKeeperTheoAfterBattleText:
	text "どうや<TTE>　うえ<NI>のぼるんだ？"
	line "おみまい<NI>いきたいのに"
	cont "いけなくて　こま<TTE>るんだよ"
	done

SailorTerrellSeenText:
	text "うみのおとこ<WA>つよさと　やさしさ"
	line "そ<NO>２つ<WO>かねそなえている"
	cont "きみ<WA>どうなんだ？"
	done

SailorTerrellBeatenText:
	text "きみ<NO>たたかいかた"
	line "つよさと　やさしさ<GA>かんじられる"
	done

SailorTerrellAfterBattleText:
	text "アサギ<NI>もどるたび"
	line "#ジム<NI>よ<TTE>たのだが<⋯>"

	para "ジムリーダー<NO>つかう　#の"
	line "タイプ<GA>いつのまにか　かわ<TTE>たよ"
	done

GentlemanPrestonSeenText:
	text "<WATASHI><WA>せかい<WO>たびして"
	line "#<WO>きたえている"
	cont "ちょっと　しょうぶ　してもらいますぞ"
	done

GentlemanPrestonBeatenText:
	text "はあ<⋯>"
	line "まだまだ　しゅぎょう<GA>たりないな"
	done

GentlemanPrestonAfterBattleText:
	text "ミカンさん<WA>もともと"
	line "イワークなど　いわタイプの"
	cont "#<WO>つかう"
	cont "#<TRAINER>　だったのだ"
	done

OlivineLighthouse3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 13,  3, OLIVINE_LIGHTHOUSE_4F, 1
	warp_event  5,  3, OLIVINE_LIGHTHOUSE_2F, 2
	warp_event  9,  5, OLIVINE_LIGHTHOUSE_4F, 4
	warp_event 16, 11, OLIVINE_LIGHTHOUSE_2F, 5
	warp_event 17, 11, OLIVINE_LIGHTHOUSE_2F, 6
	warp_event 16,  9, OLIVINE_LIGHTHOUSE_4F, 5
	warp_event 17,  9, OLIVINE_LIGHTHOUSE_4F, 6
	warp_event  8,  3, OLIVINE_LIGHTHOUSE_4F, 7
	warp_event  9,  3, OLIVINE_LIGHTHOUSE_4F, 8

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  2, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerSailorTerrell, -1
	object_event 13,  5, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerGentlemanPreston, -1
	object_event  3,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperTheo, -1
	object_event  8,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, OlivineLighthouse3FEther, EVENT_OLIVINE_LIGHTHOUSE_3F_ETHER
