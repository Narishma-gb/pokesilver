	object_const_def
	const BURNEDTOWER1F_FIREBREATHER_DICK
	const BURNEDTOWER1F_FIREBREATHER_NED
	const BURNEDTOWER1F_ROCK1
	const BURNEDTOWER1F_ROCK2
	const BURNEDTOWER1F_RIVAL
	const BURNEDTOWER1F_FIREBREATHER_DICK_ASHES
	const BURNEDTOWER1F_POKE_BALL1
	const BURNEDTOWER1F_POKE_BALL2

BurnedTower1F_MapScripts:
	def_scene_scripts
	scene_script BurnedTower1FRivalBattleScene, SCENE_BURNEDTOWER1F_RIVAL_BATTLE
	scene_script BurnedTower1FNoop1Scene,       SCENE_BURNEDTOWER1F_FIREBREATHER_DICK
	scene_script BurnedTower1FNoop2Scene,       SCENE_BURNEDTOWER1F_NOOP

	def_callbacks

BurnedTower1FRivalBattleScene:
	sdefer BurnedTower1FRivalBattleScript
	end

BurnedTower1FNoop1Scene:
	end

BurnedTower1FNoop2Scene:
	end

BurnedTower1FRivalBattleScript:
	turnobject PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	turnobject BURNEDTOWER1F_RIVAL, RIGHT
	pause 10
	turnobject BURNEDTOWER1F_RIVAL, LEFT
	pause 15
	turnobject BURNEDTOWER1F_RIVAL, DOWN
	pause 15
	applymovement BURNEDTOWER1F_RIVAL, BurnedTowerMovement_RivalWalksToPlayer
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext BurnedTowerRival_BeforeText
	waitbutton
	closetext
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .chikorita
	winlosstext BurnedTowerRival_WinText, BurnedTowerRival_LossText
	setlasttalked BURNEDTOWER1F_RIVAL
	loadtrainer RIVAL1, RIVAL1_3_TOTODILE
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.totodile
	winlosstext BurnedTowerRival_WinText, BurnedTowerRival_LossText
	setlasttalked BURNEDTOWER1F_RIVAL
	loadtrainer RIVAL1, RIVAL1_3_CHIKORITA
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.chikorita
	winlosstext BurnedTowerRival_WinText, BurnedTowerRival_LossText
	setlasttalked BURNEDTOWER1F_RIVAL
	loadtrainer RIVAL1, RIVAL1_3_CYNDAQUIL
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .returnfrombattle

.returnfrombattle
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext BurnedTowerRival_AfterText1
	waitbutton
	closetext
	turnobject PLAYER, UP
	turnobject PLAYER, RIGHT
	applymovement BURNEDTOWER1F_RIVAL, BurnedTowerMovement_RivalLeaves
	playsound SFX_EXIT_BUILDING
	disappear BURNEDTOWER1F_RIVAL
	setscene SCENE_BURNEDTOWER1F_FIREBREATHER_DICK
	waitsfx
	playmapmusic
	end

FirebreatherDickFight:
	playmusic MUSIC_HIKER_ENCOUNTER
	showemote EMOTE_SHOCK, BURNEDTOWER1F_FIREBREATHER_DICK, 30
	applymovement BURNEDTOWER1F_FIREBREATHER_DICK, FirebreatherDickMovement
	turnobject PLAYER, DOWN
	opentext
	writetext FirebreatherDickBeforeText
	waitbutton
	closetext
	winlosstext FirebreatherDickBeatenText, -1
	setlasttalked BURNEDTOWER1F_FIREBREATHER_DICK
	loadtrainer FIREBREATHER, DICK
	startbattle
	iftrue .next
	disappear BURNEDTOWER1F_FIREBREATHER_DICK
	appear BURNEDTOWER1F_FIREBREATHER_DICK_ASHES
	reloadmapafterbattle
	setevent EVENT_BEAT_FIREBREATHER_DICK
	setscene SCENE_BURNEDTOWER1F_NOOP
	clearevent EVENT_BURNED_TOWER_FIREBREATHER_DICK_NORMAL
	setevent EVENT_BURNED_TOWER_FIREBREATHER_DICK_ASHES
	end
.next
	reloadmapafterbattle
	end

FirebreatherDickPostBattle:
	faceplayer
	opentext
	writetext FirebreatherDickAfterText
	waitbutton
	closetext
	end

TrainerFirebreatherNed:
	trainer FIREBREATHER, NED, EVENT_BEAT_FIREBREATHER_NED, FirebreatherNedSeenText, FirebreatherNedBeatenText, 0, .Script

.Script
	endifjustbattled
	opentext
	writetext FirebreatherNedAfterText
	waitbutton
	closetext
	end

BurnedTower1FRock:
	jumpstd SmashRockScript

BurnedTower1FHiddenEther:
	hiddenitem ETHER, EVENT_BURNED_TOWER_1F_HIDDEN_ETHER

BurnedTower1FBurnHeal:
	itemball BURN_HEAL, 1

BurnedTower1FXSpeed:
	itemball X_SPEED, 1

BurnedTowerMovement_RivalWalksToPlayer:
	step DOWN
	step DOWN
	step_end

BurnedTowerMovement_RivalLeaves:
	step RIGHT
	step DOWN
	step_end

FirebreatherDickMovement:
	step UP
	step_end

BurnedTowerRival_BeforeText:
	text "<⋯>　<⋯>　<⋯>"

	para "<⋯>　なんだ　おまえ　か"

	para "ちょっと<WA>つよくなりたくて"
	line "ここ<NI>ねむると　いわれる"
	cont "でんせつ<NO>#　さがしにきた"
	cont "そんな　かんじ　だな"

	para "だ<GA>それ<WA>むりさ"

	para "でんせつ<NO>#は"
	line "オレ<GA>つかまえる<⋯>"

	para "なんた<TTE>　オレ<WA>さいきょうの"
	line "<TRAINER><NI>なるからな"
	cont "でんせつ<NO>#<GA>にあうのさ"

	para "<⋯>　それよりも　おまえ"
	line "よわいくせ<NI>あちこち"
	cont "うろついて　めざわり　だぜ"
	done

BurnedTowerRival_WinText:
	text "<⋯>　フン！"

	para "これだから　よわい　やつと"
	line "たたかう<NO>イヤ　なんだ"
	cont "つい　あそびすぎてしまう"
	done

BurnedTowerRival_AfterText1:
	text "<⋯>　まあ　いいさ"

	para "おまえ　なんかに"
	line "でんせつ<NO>#"
	cont "つかまえられる　わけ　ないさ"
	done

BurnedTowerRival_LossText:
	text "<⋯>　フン！"

	para "これだから　よわい　やつと"
	line "たたかう<NO>イヤ　なんだ"
	cont "じかん<NO>むだでしか　ないぜ"
	done

FirebreatherDickBeforeText:
	text "こっそり　れんしゅう　してるのを"
	line "みられたら　はずかしいじゃねーか！"
	done

FirebreatherDickBeatenText:
	text "もえつきた<⋯>"
	line "まっしろ<NI>なっちまったよ<⋯>"
	done

FirebreatherDickAfterText:
	text "れんしゅう<NI>むちゅうで"
	line "あなから　おっこちまったよ　わはは"
	done

FirebreatherNedSeenText:
	text "おれ<NO>たましい<GA>もえている"
	line "そ<NO>あつさ　おしえてやる"
	done

FirebreatherNedBeatenText:
	text "まだ　おんど<GA>ひくかったか"
	done

FirebreatherNedAfterText:
	text "むかし　ものすごい　はやさで"
	line "あちこち<NO>みち<WO>はしりまわ<TTE>た"
	cont "#<GA>いたらしい"

	para "かぜのよう<NI>はやい　らしいからな"
	line "ぐうぜん　くさむらで　であ<TTE>も"
	cont "すぐ<NI>にげてしまう　だろうな"
	done

BurnedTower1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 15, ECRUTEAK_CITY, 13
	warp_event 10, 15, ECRUTEAK_CITY, 13
	warp_event  5,  4, BURNED_TOWER_B1F, 1
	warp_event  5,  5, BURNED_TOWER_B1F, 1
	warp_event  5,  6, BURNED_TOWER_B1F, 1
	warp_event  4,  6, BURNED_TOWER_B1F, 1
	warp_event 15,  4, BURNED_TOWER_B1F, 2
	warp_event 15,  5, BURNED_TOWER_B1F, 2
	warp_event 10,  7, BURNED_TOWER_B1F, 3
	warp_event  5, 14, BURNED_TOWER_B1F, 4
	warp_event  4, 14, BURNED_TOWER_B1F, 4
	warp_event 14, 14, BURNED_TOWER_B1F, 5
	warp_event 15, 14, BURNED_TOWER_B1F, 5
	warp_event  7, 15, BURNED_TOWER_B1F, 6

	def_coord_events
	coord_event 8,  1, SCENE_BURNEDTOWER1F_FIREBREATHER_DICK, FirebreatherDickFight

	def_bg_events
	bg_event  8,  7, BGEVENT_ITEM, BurnedTower1FHiddenEther

	def_object_events
	object_event 8, 3, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, FirebreatherDickPostBattle, EVENT_BURNED_TOWER_FIREBREATHER_DICK_NORMAL
	object_event 16, 8, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerFirebreatherNed, -1
	object_event 4, 3, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BurnedTower1FRock, -1
	object_event 16, 13, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BurnedTower1FRock, -1
	object_event 9, 12, SPRITE_RIVAL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, ObjectEvent, EVENT_RIVAL_BURNED_TOWER
	object_event 8, 2, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_EMOTE, OBJECTTYPE_SCRIPT, 0, FirebreatherDickPostBattle, EVENT_BURNED_TOWER_FIREBREATHER_DICK_ASHES
	object_event 15, 2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, BurnedTower1FBurnHeal, EVENT_BURNED_TOWER_1F_X_SPEED
	object_event 7, 5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, BurnedTower1FXSpeed, EVENT_BURNED_TOWER_1F_BURN_HEAL
