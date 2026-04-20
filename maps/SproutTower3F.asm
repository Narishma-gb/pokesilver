	object_const_def
	const SPROUTTOWER3F_SAGE1
	const SPROUTTOWER3F_SAGE2
	const SPROUTTOWER3F_SAGE3
	const SPROUTTOWER3F_SAGE4
	const SPROUTTOWER3F_POKE_BALL1
	const SPROUTTOWER3F_POKE_BALL2
	const SPROUTTOWER3F_RIVAL

SproutTower3F_MapScripts:
	def_scene_scripts
	scene_script SproutTower3FNoop1Scene, SCENE_SPROUTTOWER3F_RIVAL_ENCOUNTER
	scene_script SproutTower3FNoop2Scene, SCENE_SPROUTTOWER3F_NOOP

	def_callbacks

SproutTower3FNoop1Scene:
	end

SproutTower3FNoop2Scene:
	end

SproutTower3FRivalScene:
	turnobject PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	playsound SFX_TACKLE
	playsound SFX_ELEVATOR
	earthquake 79
	pause 15
	playsound SFX_TACKLE
	playsound SFX_ELEVATOR
	earthquake 79
	applymovement PLAYER, SproutTower3FPlayerApproachesRivalMovement
	applymovement SPROUTTOWER3F_RIVAL, SproutTower3FRivalApproachesElderMovement
	opentext
	writetext SproutTowerElderLecturesRivalText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, SPROUTTOWER3F_RIVAL, 15
	turnobject SPROUTTOWER3F_RIVAL, DOWN
	pause 15
	applymovement SPROUTTOWER3F_RIVAL, SproutTower3FRivalLeavesElderMovement
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext SproutTowerRivalOnlyCareAboutStrongText
	waitbutton
	closetext
	turnobject SPROUTTOWER3F_RIVAL, UP
	opentext
	writetext SproutTowerRivalUsedEscapeRopeText
	pause 15
	closetext
	playsound SFX_WARP_TO
	special FadeOutToBlack
	special ReloadSpritesNoPalettes
	disappear SPROUTTOWER3F_RIVAL
	waitsfx
	special FadeInFromBlack
	setscene SCENE_SPROUTTOWER3F_NOOP
	special RestartMapMusic
	end

SageLiScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_HM05_FLASH
	iftrue .GotFlash
	writetext SageLiSeenText
	waitbutton
	closetext
	winlosstext SageLiBeatenText, 0
	loadtrainer SAGE, LI
	startbattle
	reloadmapafterbattle
	opentext
	writetext SageLiTakeThisFlashText
	promptbutton
	verbosegiveitem HM_FLASH
	setevent EVENT_GOT_HM05_FLASH
	setevent EVENT_BEAT_SAGE_LI
	writetext SageLiFlashExplanationText
	waitbutton
	closetext
	end

.GotFlash:
	writetext SageLiAfterBattleText
	waitbutton
	closetext
	end

TrainerSageJin:
	trainer SAGE, JIN, EVENT_BEAT_SAGE_JIN, SageJinSeenText, SageJinBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SageJinAfterBattleText
	waitbutton
	closetext
	end

TrainerSageTroy:
	trainer SAGE, TROY, EVENT_BEAT_SAGE_TROY, SageTroySeenText, SageTroyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SageTroyAfterBattleText
	waitbutton
	closetext
	end

TrainerSageNeal:
	trainer SAGE, NEAL, EVENT_BEAT_SAGE_NEAL, SageNealSeenText, SageNealBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext SageNealAfterBattleText
	waitbutton
	closetext
	end

SproutTower3FPainting:
	jumptext SproutTower3FPaintingText

SproutTower3FStatue:
	jumptext SproutTower3FStatueText

SproutTower3FPotion:
	itemball POTION

SproutTower3FEscapeRope:
	itemball ESCAPE_ROPE

SproutTower3FPlayerApproachesRivalMovement:
	step UP
	step UP
	step UP
	step UP
	step_end

SproutTower3FRivalApproachesElderMovement:
	step UP
	step_end

SproutTower3FRivalLeavesElderMovement:
	step RIGHT
	step DOWN
	step_end

SproutTowerElderLecturesRivalText:
	text "ちょうろう『そなた<NO>じつりょく"
	line "まさ<NI>ほんもの"

	para "やくそく　どおり"
	line "こ<NO>ひでんマシン<WO>わたそう"

	para "だ<GA>もうちっと"
	line "#<WO>いたわるべき　ですぞ"

	para "そなた<NO>たたかいかた　きびしすぎる"
	line "#<WA>たたかいの"
	cont "どうぐ　で<WA>ない<⋯>"
	done

SproutTowerRivalOnlyCareAboutStrongText:
	text "<⋯>　<⋯>　<⋯>"

	para "<⋯>　フン！"
	line "ちょうろう　<TTE>　いうわりには"
	cont "ぜんぜん　てごたえ　なかった"

	para "<⋯>　とうぜん　だな"
	line "#<NI>やさしくとか"
	cont "あまいこと　い<TTE>る　やつには"
	cont "オレ<WA>まけない"

	para "オレ<GA>だいじ<NI>するのは"
	line "つよくて　かてる　#　だけ"

	para "それいがい<NO>#なんか"
	line "どうでも　いいのさ"
	done

SproutTowerRivalUsedEscapeRopeText:
	text "<RIVAL>は"
	line "あなぬけのヒモ<WO>つかっ<TA!>"
	done

SageLiSeenText:
	text "よくぞ　ここまで　まいられ<TA!>"

	para "こ<NO>マダツボミのとうは"
	line "#と　ひとが"
	cont "あかるい　みらい<WO>きずけるか"
	cont "しゅぎょうで　たしかめる　ばしょ"

	para "そして　さいご<NO>しれんは"
	line "こ<NO><WATASHI>"

	para "で<WA>そなたと　#<NO>きずな"
	line "たしかめさせて　もらいますぞ！"
	done

SageLiBeatenText:
	text "ううむ"
	line "おみごと"
	done

SageLiTakeThisFlashText:
	text "そなたと"
	line "#なら　こ<NO>ひでんも"
	cont "つかいこなせるだろう"

	para "フラッシュ<NO>ひでんマシン"
	line "も<TTE>　いきなさい！"
	done

SageLiFlashExplanationText:
	text "フラッシュ<WO>おぼえさせると"
	line "どんな<NI>くらい　ところも"
	cont "あかるく　できますぞ！"

	para "ただし　たたか<TTE>いないとき"
	line "つかうに<WA>キキョウ<NO>ジムで"
	cont "もらえる　バッジ<GA>ひつようですぞ"
	done

SageLiAfterBattleText:
	text "そなた<NO>たびが"
	line "みのりおおい　もので　ありますように"
	done

SageJinSeenText:
	text "#<NO>みち<WO>きわめるべく"
	line "しゅぎょう　しておる！"
	done

SageJinBeatenText:
	text "ぼうず<GA>ぼうず<NI>まけよった<⋯>"
	done

SageJinAfterBattleText:
	text "#<GA>つよくなるたび"
	line "<TRAINER>も　つよくなる"

	para "いや　<TRAINER><GA>つよくなれば"
	line "#も　つよくなる"
	done

SageTroySeenText:
	text "あなた<GA>#を"
	line "どれだけ　しんらい　しているか"
	cont "<WATASHI><GA>ためしましょう！"
	done

SageTroyBeatenText:
	text "うむ！"
	line "しんらい　しているな！"
	done

SageTroyAfterBattleText:
	text "ちょうろうさま<NO>ところまで"
	line "もうすこし　ですぞ！"
	done

SageNealSeenText:
	text "ちょうろうさま<GA>くださる"
	line "ひでんマシンは"
	cont "どんな　やみも　あかるく　てらす"
	done

SageNealBeatenText:
	text "あかるいのは"
	line "<WATASHI><NO>あたまー！"
	done

SageNealAfterBattleText:
	text "あなた<NO>すすむ　みちが"
	line "かがやき<NI>みちて　いますように"
	done

SproutTower3FPaintingText:
	text "ちからづよい　タッチで"
	line "マダツボミ<GA>えがかれている<⋯>"
	done

SproutTower3FStatueText:
	text "#<GA>まつられている<⋯>"
	line "どこか　こうごうしい　かんじ"
	done

SproutTower3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 10, 14, SPROUT_TOWER_2F, 4

	def_coord_events
	coord_event 11,  9, SCENE_SPROUTTOWER3F_RIVAL_ENCOUNTER, SproutTower3FRivalScene

	def_bg_events
	bg_event  8,  1, BGEVENT_READ, SproutTower3FStatue
	bg_event 11,  1, BGEVENT_READ, SproutTower3FStatue
	bg_event  9,  0, BGEVENT_READ, SproutTower3FPainting
	bg_event 10,  0, BGEVENT_READ, SproutTower3FPainting
	bg_event  5, 15, BGEVENT_READ, SproutTower3FStatue
	bg_event 14, 15, BGEVENT_READ, SproutTower3FStatue

	def_object_events
	object_event  8, 13, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSageJin, -1
	object_event  8,  8, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerSageTroy, -1
	object_event 10,  2, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SageLiScript, -1
	object_event 11, 11, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSageNeal, -1
	object_event  6, 14, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SproutTower3FPotion, EVENT_SPROUT_TOWER_3F_POTION
	object_event 14,  1, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, SproutTower3FEscapeRope, EVENT_SPROUT_TOWER_3F_ESCAPE_ROPE
	object_event 10,  4, SPRITE_RIVAL, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_SPROUT_TOWER
