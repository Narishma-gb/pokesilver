	object_const_def
	const PLAYERSHOUSE1F_MOM1
	const PLAYERSHOUSE1F_MOM2
	const PLAYERSHOUSE1F_MOM3
	const PLAYERSHOUSE1F_MOM4

PlayersHouse1F_MapScripts:
	def_scene_scripts
	scene_script PlayersHouse1FMeetMomScene, SCENE_PLAYERSHOUSE1F_MEET_MOM
	scene_script PlayersHouse1FNoopScene,    SCENE_PLAYERSHOUSE1F_NOOP

	def_callbacks

PlayersHouse1FMeetMomScene:
	sdefer MeetMomScript
	end

PlayersHouse1FNoopScene:
	end

MeetMomScript:
	applymovement PLAYER, PlayersHouseDownstairsMovement
	playmusic MUSIC_MOM
	turnobject PLAYERSHOUSE1F_MOM1, UP
	showemote EMOTE_SHOCK, PLAYERSHOUSE1F_MOM1, 15
	applymovement PLAYERSHOUSE1F_MOM1, MomWalksToPlayerMovement
	opentext
	writetext ElmsLookingForYouText
	promptbutton
	getstring STRING_BUFFER_4, PokegearName
	scall PlayersHouse1FReceiveItemStd
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	addcellnum PHONE_MOM
	setscene SCENE_PLAYERSHOUSE1F_NOOP
	setevent EVENT_PLAYERS_HOUSE_MOM_1
	clearevent EVENT_PLAYERS_HOUSE_MOM_2
	writetext MomGivesPokegearText
	promptbutton
	special SetDayOfWeek
.SetDayOfWeek:
	writetext DoYouKnowHowToUsePhoneText
	yesorno
	iffalse .ExplainPhone
	sjump .KnowPhone

.KnowPhone:
	writetext KnowTheInstructionsText
	promptbutton
	sjump .FinishPhone

.ExplainPhone:
	writetext DontKnowTheInstructionsText
	promptbutton
	sjump .FinishPhone

.FinishPhone:
	writetext InstructionsNextText
	waitbutton
	closetext
	applymovement PLAYERSHOUSE1F_MOM1, MomWalksBackMovement
	special RestartMapMusic
	end

PokegearName:
	db "#ギア@"

PlayersHouse1FReceiveItemStd:
	jumpstd ReceiveItemScript
	end

MomScript:
	faceplayer
	opentext
	checkevent EVENT_FIRST_TIME_BANKING_WITH_MOM
	iftrue .FirstTimeBanking
	checkevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	iftrue .BankOfMom
	checkevent EVENT_GAVE_MYSTERY_EGG_TO_ELM
	iftrue .GaveMysteryEgg
	checkevent EVENT_GOT_A_POKEMON_FROM_ELM
	iftrue .GotAPokemon
	writetext HurryUpElmIsWaitingText
	waitbutton
	closetext
	end

.GotAPokemon:
	writetext SoWhatWasProfElmsErrandText
	waitbutton
	closetext
	end

.FirstTimeBanking:
	writetext ImBehindYouText
	waitbutton
	closetext
	end

.GaveMysteryEgg:
	setevent EVENT_FIRST_TIME_BANKING_WITH_MOM
.BankOfMom:
	setevent EVENT_TALKED_TO_MOM_AFTER_MYSTERY_EGG_QUEST
	special BankOfMom
	waitbutton
	closetext
	end

PlayersHouse1FTVScript:
	jumptext PlayersHouse1FTVText

PlayersHouse1FStoveScript:
	jumptext PlayersHouse1FStoveText

PlayersHouse1FSinkScript:
	jumptext PlayersHouse1FSinkText

PlayersHouse1FFridgeScript:
	jumptext PlayersHouse1FFridgeText

PlayersHouseDownstairsMovement:
	step DOWN
	step_end

MomWalksToPlayerMovement:
	slow_step RIGHT
	slow_step RIGHT
	slow_step UP
	step_end

MomWalksBackMovement:
	slow_step DOWN
	slow_step LEFT
	slow_step LEFT
	step_end

ElmsLookingForYouText:
	text "あら　<PLAYER>！"
	line "おとなり<NO>ウツギはかせが"
	cont "さがしていたわよ"

	para "なんでも　あなたに"
	line "たのみたいこと<GA>あるんだ<TTE>"

	para "そうだ！　わすれるとこだったわ"
	line "しゅうり<NI>だしてた"
	cont "#ギア　もど<TTE>きてたわよ"

	para "はい！"
	done

MomGivesPokegearText:
	text "#ギア"
	line "りゃくして　ポケギア"

	para "いちにんまえ<NO><TRAINER>に"
	line "なるなら　も<TTE>ないとね"

	para "あら？　ようび<GA>はい<TTE>ないわよ"
	line "つかうまえ<NI>きょうは"
	cont "なんようびか　いれておかないと"
	done

DoYouKnowHowToUsePhoneText:
	text "そうそう"
	line "でんわ<NO>つかいかた　おぼえてる？"
	done

KnowTheInstructionsText:
	text "#ギア<NO>スイッチ<WO>いれて"
	line "アイコン<WO>えらぶだけ　なんでしょ？"
	done

DontKnowTheInstructionsText:
	text "じゃあ　せつめいしょ<WO>よむね"

	para "#ギア<NO>スイッチ<WO>いれて"
	line "でんわアイコン<WO>えらぶのよ"
	done

InstructionsNextText:
	text "でんわばんごうは"
	line "じどうで　とうろく　されているから"
	cont "かけたい　あいて<WO>えらぶだけね"

	para "こんな　かんたんに"
	line "でんわ　できるなんて　すごいわね"
	done

HurryUpElmIsWaitingText:
	text "ウツギはかせ<GA>よんでたわよ"
	line "はやく　いかなきゃ！"
	done

SoWhatWasProfElmsErrandText:
	text "ウツギはかせの"
	line "ようじ<TTE>　なんだったの？"

	para "<⋯>　<⋯>　<⋯>　"

	para "そう　たいへん　そうね"
	line "でも　ひと<NI>おねがい　される<TTE>"
	cont "だいじなこと　なのよ！"
	done

ImBehindYouText:
	text "<PLAYER>！　がんばるのよ！"
	line "おかあさん　おうえん　してるから！"
	done

PlayersHouse1FStoveText:
	text "おかあさん<NO>とくい　りょうり"
	line "グレンふう　かざんハンバーグ！"
	done

PlayersHouse1FSinkText:
	text "ぴかぴか<NO>ながしだい！"
	line "おかあさん<WA>きれいずき"
	done

PlayersHouse1FFridgeText:
	text "れいぞうこ<NO>なか　には<⋯>"

	para "おいしいみず　<GA>いっぱい"
	line "そして　あまーい　ミックスオレ！"
	done

PlayersHouse1FTVText:
	text "テレビで　えいが<WO>や<TTE>る！"
	line "おとこのこ<GA>ふたり　たびしてる"
	cont "きしゃのまどから　ほし<GA>みえる<⋯>"

	para "<⋯>　ぼくも　もう　いかなきゃ！"
	done

PlayersHouse1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  7, NEW_BARK_TOWN, 2
	warp_event  7,  7, NEW_BARK_TOWN, 2
	warp_event  9,  0, PLAYERS_HOUSE_2F, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, PlayersHouse1FStoveScript
	bg_event  1,  1, BGEVENT_READ, PlayersHouse1FSinkScript
	bg_event  2,  1, BGEVENT_READ, PlayersHouse1FFridgeScript
	bg_event  4,  1, BGEVENT_READ, PlayersHouse1FTVScript

	def_object_events
	object_event  7,  3, SPRITE_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_1
	object_event  2,  2, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, MORN, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  7,  3, SPRITE_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, DAY, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
	object_event  0,  2, SPRITE_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, NITE, 0, OBJECTTYPE_SCRIPT, 0, MomScript, EVENT_PLAYERS_HOUSE_MOM_2
