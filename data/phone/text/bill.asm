BillPhoneMornGreetingText:
	text "おはよう！"

	para "こちら　#あずかりシステム"
	line "かんりサービス！"
	done

BillPhoneDayGreetingText:
	text "こんちは！"

	para "こちら　#あずかりシステム"
	line "かんりサービス！"
	done

BillPhoneNiteGreetingText:
	text "おつかれ！"

	para "こちら　#あずかりシステム"
	line "かんりサービス！"
	done

BillPhoneGenericText:
	text "なまえ<WA>なんて　ゆーんや？"

	para "そうか　<PLAYER>くんか"
	line "ちょっと　まった<TTE>なー！"

	para "<⋯>　<⋯>　<⋯>　<⋯>　<⋯>"
	line "　<⋯>　<⋯>　<⋯>　<⋯>"
	done

BillPhoneNotFullText:
	text "はいはい　おまたせー！"

	para "<PLAYER>くん<GA>つこてる　ボックス"
	line "まだ　@"
	text_ram wStringBuffer3
	text "ひき　あいてるで"

	para "どんどん　あずけた<TTE>な！"
	done

BillPhoneNearlyFullText:
	text "はいはい　おまたせー！"

	para "<PLAYER>くん<GA>つこてる　ボックス"
	line "いま　@"
	text_ram wStringBuffer3
	text "ひきしか　あいてへんで"

	para "そろそろ　せいり　したほうが"
	line "ええんとちゃう？"
	done

BillPhoneFullText:
	text "はいはい　おまたせー！"

	para "<PLAYER>くん<GA>つこてる　ボックス"
	line "ぜんぜん　あいてへんわ！"

	para "せいり　しとかな"
	line "もう　#　あずかれへんで！"
	done

BillPhoneNewlyFullText:
	text "もしもし　<PLAYER>くん？"

	para "わいや　マサキや！"
	line "いつも　ごりよう　ありがとな"

	para "いま　おくられた　#で"
	line "ボックス　いっぱい<NI>なったんや！"

	para "<PC>　せいり　せえへんと"
	line "もう　あずかれへんで！"

	para "ほな　バイバイ！"
	done
