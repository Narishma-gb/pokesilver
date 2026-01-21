;BattleText:: ; used only for BANK(BattleText)

;BattleText_PlayerPickedUpPayDayMoney:
;	text "<PLAYER> picked up"
;	line "¥@"
;	text_decimal wPayDayMoney, 3, 6
;	text "!"
;	prompt

;WildPokemonAppearedText:
;	text "Wild @"
;	text_ram wEnemyMonNickname
;	text_start
;	line "appeared!"
;	prompt

;HookedPokemonAttackedText:
;	text "The hooked"
;	line "@"
;	text_ram wEnemyMonNickname
;	text_start
;	cont "attacked!"
;	prompt

;PokemonFellFromTreeText:
;	text_ram wEnemyMonNickname
;	text " fell"
;	line "out of the tree!"
;	prompt

;WantsToBattleText::
;	text "<ENEMY>"
;	line "wants to battle!"
;	prompt

;BattleText_WildFled:
;	text "Wild @"
;	text_ram wEnemyMonNickname
;	text_start
;	line "fled!"
;	prompt

;BattleText_EnemyFled:
;	text "Enemy @"
;	text_ram wEnemyMonNickname
;	text_start
;	line "fled!"
;	prompt

;HurtByPoisonText:
;	text "<USER>"
;	line "is hurt by poison!"
;	prompt

;HurtByBurnText:
;	text "<USER>'s"
;	line "hurt by its burn!"
;	prompt

;LeechSeedSapsText:
;	text "LEECH SEED saps"
;	line "<USER>!"
;	prompt

;HasANightmareText:
;	text "<USER>"
;	line "has a NIGHTMARE!"
;	prompt

;HurtByCurseText:
;	text "<USER>'s"
;	line "hurt by the CURSE!"
;	prompt

;SandstormHitsText:
;	text "The SANDSTORM hits"
;	line "<USER>!"
;	prompt

;PerishCountText:
;	text "<USER>'s"
;	line "PERISH count is @"
;	text_decimal wTextDecimalByte, 1, 1
;	text "!"
;	prompt

;BattleText_TargetRecoveredWithItem:
;	text "<TARGET>"
;	line "recovered with"
;	cont "@"
;	text_ram wStringBuffer1
;	text "."
;	prompt

;BattleText_UserRecoveredPPUsing:
;	text "<USER>"
;	line "recovered PP using"
;	cont "@"
;	text_ram wStringBuffer1
;	text "."
;	prompt

;BattleText_TargetWasHitByFutureSight:
;	text "<TARGET>"
;	line "was hit by FUTURE"
;	cont "SIGHT!"
;	prompt

;BattleText_SafeguardFaded:
;	text "<USER>'s"
;	line "SAFEGUARD faded!"
;	prompt

;BattleText_MonsLightScreenFell:
;	text_ram wStringBuffer1
;	text " #MON's"
;	line "LIGHT SCREEN fell!"
;	prompt

;BattleText_MonsReflectFaded:
;	text_ram wStringBuffer1
;	text " #MON's"
;	line "REFLECT faded!"
;	prompt

;BattleText_RainContinuesToFall:
;	text "Rain continues to"
;	line "fall."
;	prompt

;BattleText_TheSunlightIsStrong:
;	text "The sunlight is"
;	line "strong."
;	prompt

;BattleText_TheSandstormRages:
;	text "The SANDSTORM"
;	line "rages."
;	prompt

;BattleText_TheRainStopped:
;	text "The rain stopped."
;	prompt

;BattleText_TheSunlightFaded:
;	text "The sunlight"
;	line "faded."
;	prompt

;BattleText_TheSandstormSubsided:
;	text "The SANDSTORM"
;	line "subsided."
;	prompt

;BattleText_EnemyMonFainted:
;	text "Enemy @"
;	text_ram wEnemyMonNickname
;	text_start
;	line "fainted!"
;	prompt

;GotMoneyForWinningText:
;	text "<PLAYER> got ¥@"
;	text_decimal wBattleReward, 3, 6
;	text_start
;	line "for winning!"
;	prompt

;BattleText_EnemyWasDefeated:
;	text "<ENEMY>"
;	line "was defeated!"
;	prompt

;TiedAgainstText:
;	text "Tied against"
;	line "<ENEMY>!"
;	prompt

;SentSomeToMomText:
;	text "<PLAYER> got ¥@"
;	text_decimal wBattleReward, 3, 6
;	text_start
;	line "for winning!"
;	cont "Sent some to MOM!"
;	prompt

;SentHalfToMomText:
;	text "Sent half to MOM!"
;	prompt

;SentAllToMomText:
;	text "Sent all to MOM!"
;	prompt

;UnusedRivalLossText: ; unreferenced
;	text "<RIVAL>: Huh? I"
;	line "should've chosen"
;	cont "your #MON!"
;	prompt

;BattleText_MonFainted:
;	text_ram wBattleMonNickname
;	text_start
;	line "fainted!"
;	prompt

;BattleText_UseNextMon:
;	text "Use next #MON?"
;	done

;UnusedRivalWinText: ; unreferenced
;	text "<RIVAL>: Yes!"
;	line "I guess I chose a"
;	cont "good #MON!"
;	prompt

;LostAgainstText:
;	text "Lost against"
;	line "<ENEMY>!"
;	prompt

;BattleText_EnemyIsAboutToUseWillPlayerChangeMon:
;	text "<ENEMY>"
;	line "is about to use"
;	cont "@"
;	text_ram wEnemyMonNickname
;	text "."

;	para "Will <PLAYER>"
;	line "change #MON?"
;	done

;BattleText_EnemySentOut:
;	text "<ENEMY>"
;	line "sent out"
;	cont "@"
;	text_ram wEnemyMonNickname
;	text "!"
;	done

;BattleText_TheresNoWillToBattle:
;	text "There's no will to"
;	line "battle!"
;	prompt

;BattleText_AnEGGCantBattle:
;	text "An EGG can't"
;	line "battle!"
;	prompt

;BattleText_CantEscape2:
;	text "Can't escape!"
;	prompt

;BattleText_TheresNoEscapeFromTrainerBattle:
;	text "No! There's no"
;	line "running from a"
;	cont "trainer battle!"
;	prompt

;BattleText_GotAwaySafely:
;	text "Got away safely!"
;	prompt

;BattleText_UserFledUsingAStringBuffer1:
;	text "<USER>"
;	line "fled using a"
;	cont "@"
;	text_ram wStringBuffer1
;	text "!"
;	prompt

;BattleText_CantEscape:
;	text "Can't escape!"
;	prompt

;BattleText_UserHurtBySpikes:
;	text "<USER>'s"
;	line "hurt by SPIKES!"
;	prompt

;RecoveredUsingText:
;	text "<TARGET>"
;	line "recovered using a"
;	cont "@"
;	text_ram wStringBuffer1
;	text "!"
;	prompt

;BattleText_UsersStringBuffer1Activated:
;	text "<USER>'s"
;	line "@"
;	text_ram wStringBuffer1
;	text_start
;	cont "activated!"
;	prompt

;BattleText_ItemsCantBeUsedHere:
;	text "Items can't be"
;	line "used here."
;	prompt

;BattleText_MonIsAlreadyOut:
;	text_ram wBattleMonNickname
;	text_start
;	line "is already out."
;	prompt

;BattleText_MonCantBeRecalled:
;	text_ram wBattleMonNickname
;	text_start
;	line "can't be recalled!"
;	prompt

;BattleText_TheresNoPPLeftForThisMove:
;	text "There's no PP left"
;	line "for this move!"
;	prompt

;BattleText_TheMoveIsDisabled:
;	text "The move is"
;	line "DISABLED!"
;	prompt

;BattleText_MonHasNoMovesLeft:
;	text_ram wBattleMonNickname
;	text_start
;	line "has no moves left!"
;	done

;BattleText_TargetsEncoreEnded:
;	text "<TARGET>'s"
;	line "ENCORE ended!"
;	prompt

;BattleText_StringBuffer1GrewToLevel:
;	text_ram wStringBuffer1
;	text " grew to"
;	line "level @"
;	text_decimal wCurPartyLevel, 1, 3
;	text "!@"
;	sound_dex_fanfare_50_79
;	text_end

;BattleText_WildMonIsEating:
;	text "Wild @"
;	text_ram wEnemyMonNickname
;	text_start
;	line "is eating!"
;	prompt

;BattleText_WildMonIsAngry:
;	text "Wild @"
;	text_ram wEnemyMonNickname
;	text_start
;	line "is angry!"
;	prompt

FastAsleepText:
	text "<USER>は"
	line "ぐうぐう　ねむ<TTE>いる"
	prompt

WokeUpText:
	text "<USER><WA>めをさまし<TA!>"
	prompt

FrozenSolidText:
	text "<USER>は"
	line "こお<TTE>　しま<TTE>　うごかない！"
	prompt

FlinchedText:
	text "<USER><WA>ひるんだ！"
	prompt

MustRechargeText:
	text "<KOUGEKI><NO>はんどうで"
	line "<USER><WA>うごけない！"
	prompt

DisabledNoMoreText:
	text "<USER>の"
	line "かなしばり<GA>とけ<TA!>"
	prompt

IsConfusedText:
	text "<USER>は"
	line "こんらんしている！"
	prompt

HurtItselfText:
	text "わけも　わからず"
	line "じぶん<WO><KOUGEKI>し<TA!>"
	prompt

ConfusedNoMoreText:
	text "<USER>の"
	line "こんらん<GA>とけ<TA!>"
	prompt

BecameConfusedText:
	text "<TARGET>は"
	line "こんらんし<TA!>"
	prompt

BattleText_ItemHealedConfusion:
	text "<TARGET><WA>@"
	text_ram wStringBuffer1
	text "で"
	line "こんらん<WO>なおし<TA!>"
	prompt

AlreadyConfusedText:
	text "<TARGET>は"
	line "すで<NI>こんらん　している"
	prompt

BattleText_UsersHurtByStringBuffer1:
	text "<USER><WA>@"
	text_ram wStringBuffer1
	text "の"
	line "ダメージ<WO>うけている"
	prompt

BattleText_UserWasReleasedFromStringBuffer1:
	text "<USER>は"
	line "@"
	text_ram wStringBuffer1
	text "から　かいほうされ<TA!>"
	prompt

UsedBindText:
	text "<TARGET><WA><USER>に"
	line "しめつけられ<TA!>"
	prompt

WasTrappedText:
	text "<TARGET><WA>うず<NO>なかに"
	line "とじこめられ<TA!>"
	prompt

WrappedByText:
	text "<TARGET><WA><USER>に"
	line "まきつかれ<TA!>"
	prompt

ClampedByText:
	text "<TARGET><WA><USER>の"
	line "から<NI>はさまれ<TA!>"
	prompt

StoringEnergyText:
	text "<USER><WA>がまんしている"
	prompt

UnleashedEnergyText:
	text "<USER>の"
	line "がまん<GA>とかれ<TA!>"
	prompt

HungOnText:
	text "<TARGET>は"
	line "@"
	text_ram wStringBuffer1
	text "で　もちこたえ<TA!>"
	prompt

EnduredText:
	text "<TARGET><WA>"
	line "<KOUGEKI><WO>こらえ<TA!>"
	prompt

InLoveWithText:
	text "<USER>は"
	line "<TARGET><NI>メロメロだ！"
	prompt

InfatuationText:
	text "<USER><WA>メロメロで"
	line "わざ<GA>だせなかっ<TA!>"
	prompt

DisabledMoveText:
	text "<USER><WA>かなしばりで"
	line "@"
	text_ram wStringBuffer1
	text "がだせない！"
	prompt

LoafingAroundText:
	text_ram wBattleMonNickname
	text "<WA>なまけている"
	prompt

BeganToNapText:
	text_ram wBattleMonNickname
	text "<WA>ひるねをはじめ<TA!>"
	prompt

WontObeyText:
	text_ram wBattleMonNickname
	text "<WA>いうこと<WO>きかない"
	prompt

TurnedAwayText:
	text_ram wBattleMonNickname
	text "<WA>そっぽ<WO>むいた"
	prompt

IgnoredOrdersText:
	text_ram wBattleMonNickname
	text "<WA>しらんぷりをした"
	prompt

IgnoredSleepingText:
	text_ram wBattleMonNickname
	text "<WA>ねむったまま"
	line "めいれい<WO>むしした"
	prompt

NoPPLeftText:
	text "しかし　わざ<NO>ポイントが"
	line "なかっ<TA!>"
	prompt

HasNoPPLeftText:
	text "<USER><WA>ポイントぎれで"
	line "@"
	text_ram wStringBuffer2
	text "<GA>だせない！"
	prompt

WentToSleepText:
	text "<USER>は"
	line "ねむりはじめ<TA!>"
	done

RestedText:
	text "<USER>は"
	line "けんこうにな<TTE>　ねむりはじめ<TA!>"
	done

RegainedHealthText:
	text "<USER><WA>たいりょくを"
	line "かいふくし<TA!>"
	prompt

HoweverMissedText:
	text "しかし　@"
AttackMissedText:
	text "<USER>の"
	line "<KOUGEKI><WA>はずれ<TA!>"
	prompt

CrashedText:
	text "いきおい　あま<TTE>"
	line "<USER>は"
	cont "じめん<NI>ぶつかっ<TA!>"
	prompt

UnaffectedText:
	text "<TARGET>には"
	line "ぜんぜんきいてない！"
	prompt

DoesntAffectText:
	text "<TARGET>には"
	line "こうか<GA>ない　みたいだ<⋯>"
	prompt

CriticalHitText:
	text "きゅうしょ<NI>あたっ<TA!>"
	prompt

OneHitKOText:
	text "いちげき　ひっさつ！"
	prompt

SuperEffectiveText:
	text "こうか<WA>ばつぐんだ！"
	prompt

NotVeryEffectiveText:
	text "こうか<WA>いまひとつ<NO>ようだ"
	prompt

TookDownWithItText:
	text "<TARGET><WA><USER>を"
	line "みちづれ<NI>し<TA!>"
	prompt

RageBuildingText:
	text "<USER><NO>いかりの"
	line "ボルテージ<GA>あが<TTE>いく！"
	prompt

GotAnEncoreText:
	text "<TARGET>は"
	line "アンコール<WO>うけ<TA!>"
	prompt

SharedPainText:
	text "おたがい<NO>たいりょくを"
	line "わかちあっ<TA!>"
	prompt

TookAimText:
	text "<USER><WA><TARGET>に"
	line "ねらい<WO>さだめ<TA!>"
	prompt

SketchedText:
	text "<USER>は"
	line "@"
	text_ram wStringBuffer1
	text "<WO>スケッチし<TA!>"
	prompt

DestinyBondEffectText:
	text "<USER><WA>あいてを"
	line "みちづれ<NI>しようとしている"
	prompt

SpiteEffectText:
	text "<TARGET>の"
	line "@"
	text_ram wStringBuffer1
	text "<WO>@"
	text_decimal wTextDecimalByte, 1, 1
	text "けずっ<TA!>"
	prompt

BellChimedText:
	text "すずのね<GA>ひびきわたっ<TA!>"
	line ""
	prompt

FellAsleepText:
	text "<TARGET>は"
	line "ねむ<TTE>しまっ<TA!>"
	prompt

AlreadyAsleepText:
	text "<TARGET><WA>すでに"
	line "ねむ<TTE>いる"
	prompt

WasPoisonedText:
	text "<TARGET><WA>どくをあび<TA!>"
	prompt

BadlyPoisonedText:
	text "<TARGET>は"
	line "もうどくをあび<TA!>"
	prompt

AlreadyPoisonedText:
	text "<TARGET><WA>すでに"
	line "どく<WO>あびている"
	prompt

SuckedHealthText:
	text "<TARGET>から"
	line "たいりょく<WO>すいとっ<TA!>"
	prompt

DreamEatenText:
	text "<TARGET>の"
	line "ゆめ<WO>くっ<TA!>"
	prompt

WasBurnedText:
	text "<TARGET>は"
	line "やけどをおっ<TA!>"
	prompt

DefrostedOpponentText:
	text "<TARGET>の"
	line "こおり<GA>とけ<TA!>"
	prompt

WasFrozenText:
	text "<TARGET>は"
	line "こおりづけになっ<TA!>"
	prompt

WontRiseAnymoreText:
	text "<USER>の"
	line "@"
	text_ram wStringBuffer2
	text "<WA>もうあがらない！"
	prompt

WontDropAnymoreText:
	text "<TARGET>の"
	line "@"
	text_ram wStringBuffer2
	text "<WA>もうさがらない！"
	prompt

FledFromBattleText::
	text "<USER><WA>せんとうから"
	line "りだつし<TA!>"
	prompt

FledInFearText:
	text "<TARGET><WA>おじけづいて"
	line "にげだし<TA!>"
	prompt

BlownAwayText:
	text "<TARGET>は"
	line "ふきとばされ<TA!>"
	prompt

PlayerHitTimesText:
	text_decimal wPlayerDamageTaken, 1, 1
	text "かい　あたっ<TA!>"
	prompt

EnemyHitTimesText:
	text_decimal wEnemyDamageTaken, 1, 1
	text "かい　あたっ<TA!>"
	prompt

MistText:
	text "<USER>は"
	line "しろいきり<NI>つつまれ<TA!>"
	prompt

ProtectedByMistText:
	text "<TARGET><WA>しろいきりに"
	line "まもられている"
	prompt

GettingPumpedText:
	text_pause
	text "<USER>は"
	line "はりき<TTE>いる！"
	prompt

RecoilText:
	text "<USER><WA><KOUGEKI>の"
	line "はんどう<WO>うけ<TA!>"
	prompt

MadeSubstituteText:
	text "<USER>の"
	line "ぶんしん<GA>あらわれた"
	prompt

HasSubstituteText:
	text "しかし　<USER>の"
	line "みがわり<WA>すで<NI>でてい<TA!>"
	prompt

TooWeakSubText:
	text "しかし　ぶんしん<WO>だすには"
	line "たいりょく<GA>たりなかっ<TA!>"
	prompt

SubTookDamageText:
	text "<TARGET><NI>かわ<TTE>"
	line "ぶんしん<GA><KOUGEKI><WO>うけ<TA!>"
	prompt

SubFadedText:
	text "<TARGET><NO>ぶんしんは"
	line "きえてしまった<⋯>"
	prompt

MimicLearnedMoveText:
	text "<USER>は"
	line "@"
	text_ram wStringBuffer1
	text "<WO>おぼえ<TA!>"
	prompt

WasSeededText:
	text "<TARGET>に"
	line "たね<WO>うえつけ<TA!>"
	prompt

EvadedText:
	text "<TARGET>は"
	line "<KOUGEKI><WO>かわし<TA!>"
	prompt

WasDisabledText:
	text "<TARGET>の"
	line "@"
	text_ram wStringBuffer1
	text "<WO>ふうじこめ<TA!>"
	prompt

CoinsScatteredText:
	text "こばん<GA>あたり<NI>ちらばっ<TA!>"
	prompt

TransformedTypeText:
	text "<USER>は"
	line "@"
	text_ram wStringBuffer1
	text "タイプ<NI>なっ<TA!>"
	prompt

EliminatedStatsText:
	text "すべて<NO>ステータスが"
	line "もと<NI>もどっ<TA!>"
	prompt

TransformedText:
	text "<USER>は"
	line "@"
	text_ram wStringBuffer1
	text "<NI>へんしんし<TA!>"
	prompt

LightScreenEffectText:
	text "<USER><WA>ひかりのかべで"
	line "とくしゅ<KOUGEKI>に　つよくなっ<TA!>"
	prompt

ReflectEffectText:
	text "<USER><WA>リフレクターで"
	line "だげき<KOUGEKI>に　つよくなっ<TA!>"
	prompt

NothingHappenedText:
	text "しかし　なにもおこらない"
	prompt

ButItFailedText:
	text "しかし　@"
ItFailedText:
	text "うまく　きまらなかっ<TA!>"
	prompt

ButDidntAffectText:
	text "しかし　@"
DidntAffectText:
	text "<TARGET>には"
	line "きかなかっ<TA!>"
	prompt

HPIsFullText:
	text "しかし　<USER>の"
	line "たいりょく<WA>まんたんだ！"
	prompt

DraggedOutText:
	text "<USER><GA>せんとうに"
	line "ひきずりだされ<TA!>"
	prompt

ParalyzedText:
	text "<TARGET><WA>まひして"
	line "わざ<GA>でにくくなっ<TA!>"
	prompt

FullyParalyzedText:
	text "<USER>は"
	line "からだ<GA>しびれて　うごけない"
	prompt

AlreadyParalyzedText:
	text "<TARGET><WA>すでに"
	line "まひしている"
	prompt

ProtectedByText:
	text "<TARGET><WA>"
	line "@"
	text_ram wStringBuffer1
	text "で　まもられてる！"
	prompt

MirrorMoveFailedText:
	text "しかし　オウムがえしは"
	next "しっぱいにおわっ<TA!>"
	prompt

StoleText:
	text "<USER><WA><TARGET>から"
	line "@"
	text_ram wStringBuffer1
	text "<WO>うばいとっ<TA!>"
	prompt

CantEscapeNowText:
	text "<TARGET>は"
	line "もう　にげられない！"
	prompt

StartedNightmareText:
	text "<TARGET>は"
	line "あくむ<WO>みはじめ<TA!>"
	prompt

WasDefrostedText:
	text "<USER>の"
	line "こおり<GA>とけ<TA!>"
	prompt

PutACurseText:
	text "<USER>は"
	line "じぶん<NO>たいりょく<WO>けず<TTE>"

	para "<TARGET>に"
	line "のろい<WO>かけ<TA!>"
	prompt

ProtectedItselfText:
	text "<USER>は"
	line "まもり<NO>たいせい<NI>はいっ<TA!>"
	prompt

ProtectingItselfText:
	text "しかし"
	line "<TARGET><WA>まも<TTE>いる！"
	done

SpikesText:
	text "<TARGET><NO>あしもとに"
	line "まきびし<GA>ちらばっ<TA!>"
	prompt

IdentifiedText:
	text "<USER><WA><TARGET>の"
	line "しょうたい<WO>みやぶっ<TA!>"
	prompt

StartPerishText:
	text "おたがいの#は"
	line "３ターンご<NI>ほろびてしまう！"
	prompt

SandstormBrewedText:
	text "すなあらし<GA>ふきはじめ<TA!>"
	prompt

BracedItselfText:
	text "<USER><WA>こらえる"
	line "たいせい<NI>はいっ<TA!>"
	prompt

FellInLoveText:
	text "<TARGET>は"
	line "メロメロ<NI>なっ<TA!>"
	prompt

CoveredByVeilText:
	text "<USER>は"
	line "しんぴのベール<NI>つつまれ<TA!>"
	prompt

SafeguardProtectText:
	text "<TARGET>は"
	line "しんぴのベール<NI>まもられている！"
	prompt

MagnitudeText:
	text "マグニチュード@"
	text_decimal wTextDecimalByte, 1, 1
	text "！！"
	prompt

ReleasedByText:
	text "<USER><WA><TARGET>の"
	line "<KOUGEKI>から　かいほうされ<TA!>"
	prompt

ShedLeechSeedText:
	text "<USER>は"
	line "やどりぎのタネを　ふきとばし<TA!>"
	prompt

BlewSpikesText:
	text "<USER><WA>まきびしを"
	line "ふきとばし<TA!>"
	prompt

DownpourText:
	text "おおあめ<NI>なっ<TA!>"
	prompt

SunGotBrightText:
	text "ひざし<GA>つよくなっ<TA!>"
	prompt

BellyDrumText:
	text "<USER><WA>たいりょくを"
	line "けず<TTE>　パワーぜんかい<NI>なっ<TA!>"
	prompt

CopiedStatsText:
	text "<USER><WA><TARGET>の"
	line "ほじょこうか<WO>コピーし<TA!>"
	prompt

ForesawAttackText:
	text "<USER><WA>みらいに"
	line "<KOUGEKI><WO>よちし<TA!>"
	prompt

BeatUpAttackText:
	text_ram wStringBuffer1
	text "<NO><KOUGEKI>！"
	done

PresentFailedText:
	text "<TARGET><WA>プレゼントを"
	line "うけとれ　なかっ<TA!>"
	prompt

IgnoredOrders2Text:
	text "<USER>は"
	line "めいれい<WO>むしし<TA!>"
	prompt
