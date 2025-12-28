ProfOaksPC:
	ld hl, OakPCText1
	call MenuTextbox
	call YesNoBox
	jr c, .shutdown
	call ProfOaksPCBoot ; player chose "yes"?
.shutdown
	ld hl, OakPCText4
	call PrintText
	call JoyWaitAorB
	call ExitMenu
	ret

ProfOaksPCBoot:
	ld hl, OakPCText2
	call PrintText
	call Rate
	call PlaySFX ; sfx loaded by previous Rate function call
	call JoyWaitAorB
	call WaitSFX
	ret

ProfOaksPCRating:
	call Rate
	push de
	ld de, MUSIC_NONE
	call PlayMusic
	pop de
	call PlaySFX
	call JoyWaitAorB
	call WaitSFX
	ret

Rate:
; calculate Seen/Owned
	ld hl, wPokedexSeen
	ld b, wEndPokedexSeen - wPokedexSeen
	call CountSetBits
	ld [wTempPokedexSeenCount], a
	ld hl, wPokedexCaught
	ld b, wEndPokedexCaught - wPokedexCaught
	call CountSetBits
	ld [wTempPokedexCaughtCount], a

; print appropriate rating
	call .UpdateRatingBuffers
	ld hl, OakPCText3
	call PrintText
	call JoyWaitAorB
	ld a, [wTempPokedexCaughtCount]
	ld hl, OakRatings
	call FindOakRating
	push de
	call PrintText
	pop de
	ret

.UpdateRatingBuffers:
	ld hl, wStringBuffer3
	ld de, wTempPokedexSeenCount
	call .UpdateRatingBuffer
	ld hl, wStringBuffer4
	ld de, wTempPokedexCaughtCount
	call .UpdateRatingBuffer
	ret

.UpdateRatingBuffer:
	push hl
	ld a, '@'
	ld bc, STRING_BUFFER_LENGTH
	call ByteFill
	pop hl
	lb bc, PRINTNUM_LEFTALIGN | 1, 3
	call PrintNum
	ret

FindOakRating:
; return sound effect in de
; return text pointer in hl
	nop
	ld c, a
.loop
	ld a, [hli]
	cp c
	jr nc, .match
rept 4
	inc hl
endr
	jr .loop

.match
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

INCLUDE "data/events/pokedex_ratings.asm"

OakPCText1:
	text "げんざいの　#ずかんを"
	line "ひょうか　して　もらいますか？"
	done

OakPCText2:
	text "#ずかんの"
	line "げんざいの　かんせいど<⋯>"
	prompt

OakPCText3:
	text "みつけた　#　　@"
	text_ram wStringBuffer3
	text_start
	line "つかまえた　#　@"
	text_ram wStringBuffer4
	text "！"

	para "オーキドはかせの　ひょうか<⋯>"
	line "<⋯>　<⋯>　<⋯>"
	done

OakRating01:
	text "あちこちの　くさむらに　はいって"
	line "#を　つかまえるのじゃ！"
	done

OakRating02:
	text "うむ！　モンスターボールの"
	line "つかいかたは　わかっとるようじゃな！"
	done

OakRating03:
	text "どうやら　なれてきた　ようじゃな"
	line "じゃが　さきは　まだまだ　ながいぞ！"
	done

OakRating04:
	text "#ずかんに　しては　まだ"
	line "ボリュームが　たりん！　いろいろな"
	cont "しゅるいの　#を　とるのじゃ！"
	done

OakRating05:
	text "ふむ　がんばっておるな"
	line "それなりに　#ずかん"
	cont "らしく　なってきておるよ！"
	done

OakRating06:
	text "そだてて　しんかするもの"
	line "いしの　えいきょうで　しんかするもの"
	cont "いろんな　#が　いるぞ！"
	done

OakRating07:
	text "つりざおは　てに　いれたか？"
	line "あちこちで　つりを　すれば"
	cont "もっと　たくさん　あつまるぞ！"
	done

OakRating08:
	text "エクセレントじゃ！"
	line "きみは　ものを　あつめるのが"
	cont "すき　なんじゃろ？"
	done

OakRating09:
	text "きまった　じかんたいにしか"
	line "うごかない　#も　いるらしいぞ"
	done

OakRating10:
	text "ページも　ふえてきた　ようじゃな！"
	line "その　ちょうしで　がんばってくれい！"
	done

OakRating11:
	text "ほうっ！　かんしん　じゃな！"
	line "つかまえる　だけでなく"
	cont "しんかも　させておるな！"
	done

OakRating12:
	text "ガンテツさんには　あったか？"
	line "ボールを　つくってもらうと"
	cont "あつめるのも　はかどると　おもうぞ！"
	done

OakRating13:
	text "おっ！　きがつけば　ぜんかい"
	line "ちょうさ　したときよりも"
	cont "たくさんの　#が　みつかったな"
	done

OakRating14:
	text "ともだちと　こうかん　しているかな？"
	line "ひとりでは　たいへん　だからな"
	done

OakRating15:
	text "なんと！　２００しゅるいを　こえた！"
	line "これは　できばえの　いい　ずかんに"
	cont "なりそうじゃ！　きたい　しとるよ！"
	done

OakRating16:
	text "こんなに　みつかるとは<⋯>"
	line "こんかいの　#けんきゅうは"
	cont "きみの　おかげじゃ！"
	done

OakRating17:
	text "すばらしい！　いうことなしじゃ！"
	line "きみ　#はかせに　なれるぞ！"
	done

OakRating18:
	text "ここまで　ずかんが　できたら"
	line "もはや　プロフェッショナル　じゃ！"
	done

OakRating19:
	text "おおっ　ゆめにまで　みた"
	line "パーフェクトな　ずかんの"
	cont "かんせいじゃ！　<⋯>　おめでとう！"
	done

OakPCText4:
	text "<⋯>　オーキドの　<PC>との"
	line "せつぞくを　おわった！"
	done
