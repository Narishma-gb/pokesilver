	object_const_def
	const CELADONCAFE_SUPER_NERD
	const CELADONCAFE_FISHER1
	const CELADONCAFE_FISHER2
	const CELADONCAFE_FISHER3
	const CELADONCAFE_TEACHER

CeladonCafe_MapScripts:
	def_scene_scripts

	def_callbacks

CeladonCafeChef:
	faceplayer
	opentext
	writetext ChefText_Eatathon
	waitbutton
	closetext
	end

CeladonCafeFisher1:
	opentext
	writetext Fisher1Text_Snarfle
	waitbutton
	closetext
	faceplayer
	opentext
	writetext Fisher1Text_Concentration
	waitbutton
	closetext
	turnobject CELADONCAFE_FISHER1, LEFT
	end

CeladonCafeFisher2:
	opentext
	writetext Fisher2Text_GulpChew
	waitbutton
	closetext
	faceplayer
	opentext
	writetext Fisher2Text_Quantity
	waitbutton
	closetext
	turnobject CELADONCAFE_FISHER2, RIGHT
	end

CeladonCafeFisher3:
	opentext
	writetext Fisher3Text_MunchMunch
	waitbutton
	closetext
	faceplayer
	opentext
	writetext Fisher3Text_GoldenrodIsBest
	waitbutton
	closetext
	turnobject CELADONCAFE_FISHER3, RIGHT
	end

CeladonCafeTeacher:
	checkitem COIN_CASE
	iftrue .HasCoinCase
	opentext
	writetext TeacherText_CrunchCrunch
	waitbutton
	closetext
	faceplayer
	opentext
	writetext TeacherText_NoCoinCase
	waitbutton
	closetext
	turnobject CELADONCAFE_TEACHER, LEFT
	end

.HasCoinCase:
	opentext
	writetext TeacherText_KeepEating
	waitbutton
	closetext
	turnobject CELADONCAFE_TEACHER, RIGHT
	opentext
	writetext TeacherText_MoreChef
	waitbutton
	closetext
	turnobject CELADONCAFE_TEACHER, LEFT
	end

EatathonContestPoster:
	jumptext EatathonContestPosterText

CeladonCafeTrashcan:
	checkevent EVENT_FOUND_LEFTOVERS_IN_CELADON_CAFE
	iftrue .TrashEmpty
	giveitem LEFTOVERS
	iffalse .PackFull
	opentext
	getitemname STRING_BUFFER_3, LEFTOVERS
	writetext FoundLeftoversText
	playsound SFX_ITEM
	waitsfx
	itemnotify
	closetext
	setevent EVENT_FOUND_LEFTOVERS_IN_CELADON_CAFE
	end

.PackFull:
	opentext
	getitemname STRING_BUFFER_3, LEFTOVERS
	writetext FoundLeftoversText
	promptbutton
	writetext NoRoomForLeftoversText
	waitbutton
	closetext
	end

.TrashEmpty:
	jumpstd TrashCanScript

ChefText_Eatathon:
	text "らっしゃい！"

	para "おおぐい　コンテストの"
	line "さいちゅう　なんだ！"
	cont "わるいね！"
	done

Fisher1Text_Snarfle:
	text "もぐもぐ<⋯>！"
	done

Fisher1Text_Concentration:
	text "はなし　かけないで　くれ！"
	line "き<GA>ちっちゃうよ！"
	done

Fisher2Text_GulpChew:
	text "むしゃむしゃ<⋯>！"
	done

Fisher2Text_Quantity:
	text "ゴハン<WA>あじ　よりも　りょう！"
	line "まんぷく<NI>なれば　まんぞく！"
	done

Fisher3Text_MunchMunch:
	text "がつがつ<⋯>！"
	done

Fisher3Text_GoldenrodIsBest:
	text "ここも　おいしいけど"
	line "やっぱ　たべものは"
	cont "コガネ<GA>いちばん　だな！"
	done

TeacherText_CrunchCrunch:
	text "ばりばり<⋯>！"
	done

TeacherText_NoCoinCase:
	text "こ<NO>おみせ<NI>コインケースを"
	line "くれる　ひと<WA>いないわよ"
	cont "ジョウトで　さがして　みてよ"
	done

TeacherText_KeepEating:
	text "ばりばり<⋯>！"

	para "まだまだ　たべられるわ！"
	done

TeacherText_MoreChef:
	text "おかわり！　マスター！"
	done

EatathonContestPosterText:
	text "おおぐい　コンテスト！"
	line "じかん　むせいげん！"
	cont "おわり<NO>ない　バトル！"
	cont "１ばんのひと<WA>タダになります！"
	done

FoundLeftoversText:
	text "<PLAYER>は"
	line "@"
	text_ram wStringBuffer3
	text "<WO>みつけ<TA!>"
	done

NoRoomForLeftoversText:
	text "しかし　<PLAYER>は"
	line "これ　いじょう　どうぐ<WO>もてない！"
	done

CeladonCafe_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  7, CELADON_CITY, 9
	warp_event  7,  7, CELADON_CITY, 9

	def_coord_events

	def_bg_events
	bg_event  5,  0, BGEVENT_READ, EatathonContestPoster
	bg_event  7,  1, BGEVENT_READ, CeladonCafeTrashcan

	def_object_events
	object_event  9,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CeladonCafeChef, -1
	object_event  4,  6, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonCafeFisher1, -1
	object_event  1,  7, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonCafeFisher2, -1
	object_event  1,  2, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonCafeFisher3, -1
	object_event  4,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CeladonCafeTeacher, -1
