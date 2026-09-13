PlayRadioShow:
; If we're already in the radio program proper, we don't need to be here.
	ld a, [wCurRadioLine]
	cp POKE_FLUTE_RADIO
	jr nc, .ok
; If Team Rocket is not occupying the radio tower, we don't need to be here.
	ld a, [wStatusFlags2]
	bit STATUSFLAGS2_ROCKETS_IN_RADIO_TOWER_F, a
	jr z, .ok
; If we're in Kanto, we don't need to be here.
	call IsInJohto
	and a
	jr nz, .ok
; Team Rocket broadcasts on all stations.
	ld a, ROCKET_RADIO
	ld [wCurRadioLine], a
.ok
; Jump to the currently loaded station.  The index to which we need to jump is in wCurRadioLine.
	jumptable RadioJumptable, wCurRadioLine

RadioJumptable:
; entries correspond to constants/radio_constants.asm
	table_width 2
	dw OaksPKMNTalk1     ; $00
	dw PokedexShow1      ; $01
	dw BenMonMusic1      ; $02
	dw LuckyNumberShow1  ; $03
	dw PeoplePlaces1     ; $04
	dw FernMonMusic1     ; $05
	dw RocketRadio1      ; $06
	dw PokeFluteRadio    ; $07
	dw UnownRadio        ; $08
	dw EvolutionRadio    ; $09
	assert_table_length NUM_RADIO_CHANNELS
; OaksPKMNTalk
	dw OaksPKMNTalk2     ; $0a
	dw OaksPKMNTalk3     ; $0b
	dw OaksPKMNTalk4     ; $0c
	dw OaksPKMNTalk5     ; $0d
	dw OaksPKMNTalk6     ; $0e
	dw OaksPKMNTalk7     ; $0f
	dw OaksPKMNTalk8     ; $10
	dw OaksPKMNTalk9     ; $11
	dw PokedexShow2      ; $12
	dw PokedexShow3      ; $13
	dw PokedexShow4      ; $14
	dw PokedexShow5      ; $15
; Ben Music
	dw BenMonMusic2      ; $16
	dw BenMonMusic3      ; $17
	dw BenFernMusic4     ; $18
	dw BenFernMusic5     ; $19
	dw BenFernMusic6     ; $1a
	dw BenFernMusic7     ; $1b
	dw FernMonMusic2     ; $1c
; Lucky Number Show
	dw LuckyNumberShow2  ; $1d
	dw LuckyNumberShow3  ; $1e
	dw LuckyNumberShow4  ; $1f
	dw LuckyNumberShow5  ; $20
	dw LuckyNumberShow6  ; $21
	dw LuckyNumberShow7  ; $22
	dw LuckyNumberShow8  ; $23
	dw LuckyNumberShow9  ; $24
	dw LuckyNumberShow10 ; $25
	dw LuckyNumberShow11 ; $26
	dw LuckyNumberShow12 ; $27
	dw LuckyNumberShow13 ; $28
	dw LuckyNumberShow14 ; $29
	dw LuckyNumberShow15 ; $2a
; People & Places
	dw PeoplePlaces2     ; $2b
	dw PeoplePlaces3     ; $2c
	dw PeoplePlaces4     ; $2d
	dw PeoplePlaces5     ; $2e
	dw PeoplePlaces6     ; $2f
	dw PeoplePlaces7     ; $30
; Rocket Radio
	dw RocketRadio2      ; $31
	dw RocketRadio3      ; $32
	dw RocketRadio4      ; $33
	dw RocketRadio5      ; $34
	dw RocketRadio6      ; $35
	dw RocketRadio7      ; $36
	dw RocketRadio8      ; $37
	dw RocketRadio9      ; $38
	dw RocketRadio10     ; $39
; More Pokemon Channel stuff
	dw OaksPKMNTalk10    ; $3a
	dw OaksPKMNTalk11    ; $3b
	dw OaksPKMNTalk12    ; $3c
	dw OaksPKMNTalk13    ; $3d
	dw OaksPKMNTalk14    ; $3e
	dw RadioScroll       ; $3f
	assert_table_length NUM_RADIO_SEGMENTS

PrintRadioLine:
	ld [wNextRadioLine], a
	ld hl, wRadioText
	call ReplacePeriodsWithSpaces
	ld a, [wNumRadioLinesPrinted]
	cp 2
	jr nc, .print
	inc hl
	ld [hl], TX_START
	inc a
	ld [wNumRadioLinesPrinted], a
	cp 2
	jr nz, .print
	bccoord 1, 16
	call PrintTextboxTextAt
	jr .skip
.print
	call PrintTextboxText
.skip
	ld a, RADIO_SCROLL
	ld [wCurRadioLine], a
	ld a, 100
	ld [wRadioTextDelay], a
	ret

ReplacePeriodsWithSpaces:
	push hl
	ld b, SCREEN_WIDTH * 2
.loop
	ld a, [hl]
	cp '。'
	jr nz, .next
	ld [hl], '　'
.next
	inc hl
	dec b
	jr nz, .loop
	pop hl
	ret

RadioScroll:
	ld hl, wRadioTextDelay
	ld a, [hl]
	and a
	jr z, .proceed
	dec [hl]
	ret
.proceed
	ld a, [wNextRadioLine]
	ld [wCurRadioLine], a
	ld a, [wNumRadioLinesPrinted]
	cp 1
	call nz, CopyBottomLineToTopLine
	jp ClearBottomLine

OaksPKMNTalk1:
	ld a, 5
	ld [wOaksPKMNTalkSegmentCounter], a
	call StartRadioStation
	ld hl, OPT_IntroText1
	ld a, OAKS_POKEMON_TALK_2
	jp NextRadioLine

OaksPKMNTalk2:
	ld hl, OPT_IntroText2
	ld a, OAKS_POKEMON_TALK_3
	jp NextRadioLine

OaksPKMNTalk3:
	ld hl, OPT_IntroText3
	ld a, OAKS_POKEMON_TALK_4
	jp NextRadioLine

OaksPKMNTalk4:
; Choose a random route, and a random Pokemon from that route.
.sample
	call Random
	and %11111
	cp (OaksPKMNTalkRoutes.End - OaksPKMNTalkRoutes) / 2
	jr nc, .sample
	ld hl, OaksPKMNTalkRoutes
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	; bc now contains the chosen map's group and number indices.
	push bc

	; Search the JohtoGrassWildMons array for the chosen map.
	ld hl, JohtoGrassWildMons
.loop
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	cp -1
	jr z, .overflow
	inc hl
	cp b
	jr nz, .next
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	cp c
	jr z, .done
.next
	dec hl
	ld de, GRASS_WILDDATA_LENGTH
	add hl, de
	jr .loop

.done
	; Point hl to the list of morning Pokémon., skipping percentages
rept 4
	inc hl
endr
	; Generate a number, either 0, 1, or 2, to choose a time of day.
.loop2
	call Random
	maskbits NUM_DAYTIMES
	cp DARKNESS_F
	jr z, .loop2

	ld bc, 2 * NUM_GRASSMON
	call AddNTimes
.loop3
	; Choose one of the middle three Pokemon.
	call Random
	maskbits NUM_GRASSMON
	cp 2
	jr c, .loop3
	cp 5
	jr nc, .loop3
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	inc hl ; skip level
	ld a, BANK(JohtoGrassWildMons)
	call GetFarByte
	ld [wNamedObjectIndex], a
	ld [wCurPartySpecies], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, NAME_LENGTH
	call CopyBytes

	; Now that we've chosen our wild Pokemon,
	; let's recover the map index info and get its name.
	pop bc
	call GetWorldMapLocation
	ld e, a
	callfar GetLandmarkName
	ld hl, OPT_OakText1
	call CopyRadioTextToRAM
	ld a, OAKS_POKEMON_TALK_5
	jp PrintRadioLine

.overflow
	pop bc
	ld a, OAKS_POKEMON_TALK
	jp PrintRadioLine

INCLUDE "data/radio/oaks_pkmn_talk_routes.asm"

OaksPKMNTalk5:
	ld hl, OPT_OakText2
	ld a, OAKS_POKEMON_TALK_6
	jp NextRadioLine

OaksPKMNTalk6:
	ld hl, OPT_OakText3
	ld a, OAKS_POKEMON_TALK_7
	jp NextRadioLine

OPT_IntroText1:
	text_start
	line "クルミ『オーキドはかせの"
	done

OPT_IntroText2:
	text_start
	line "#こうざ！"
	done

OPT_IntroText3:
	text_start
	line "おあいて<WA>わたし　クルミでーす！"
	done

OPT_OakText1:
	text_start
	line "オーキド『@"
	text_ram wMonOrItemNameBuffer
	text "は"
	done

OPT_OakText2:
	text_start
	line "@"
	text_ram wStringBuffer1
	text "に"
	done

OPT_OakText3:
	text_start
	line "せいそくして　おるようじゃ"
	done

OaksPKMNTalk7:
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, OPT_MaryText1
	ld a, OAKS_POKEMON_TALK_8
	jp NextRadioLine

OPT_MaryText1:
	text_start
	line "クルミ『@"
	text_ram wStringBuffer1
	text "って　"
	done

OaksPKMNTalk8:
	; 0-15 are all valid indexes into .Adverbs,
	; so no need for a retry loop
	call Random
	maskbits NUM_OAKS_POKEMON_TALK_ADVERBS
	assert_power_of_2 NUM_OAKS_POKEMON_TALK_ADVERBS
	ld e, a
	ld d, 0
	ld hl, .Adverbs
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, OAKS_POKEMON_TALK_9
	jp NextRadioLine

.Adverbs:
	table_width 2
	dw .OPT_SweetAdorablyText
	dw .OPT_WigglySlicklyText
	dw .OPT_AptlyNamedText
	dw .OPT_UndeniablyKindOfText
	dw .OPT_UnbearablyText
	dw .OPT_WowImpressivelyText
	dw .OPT_AlmostPoisonouslyText
	dw .OPT_SensuallyText
	dw .OPT_MischievouslyText
	dw .OPT_TopicallyText
	dw .OPT_AddictivelyText
	dw .OPT_LooksInWaterText
	dw .OPT_EvolutionMustBeText
	dw .OPT_ProvocativelyText
	dw .OPT_FlippedOutText
	dw .OPT_HeartMeltinglyText
	assert_table_length NUM_OAKS_POKEMON_TALK_ADVERBS

.OPT_SweetAdorablyText:
	text_start
	line "めにいれても　いたくないほど"
	done

.OPT_WigglySlicklyText:
	text_start
	line "ニョロニョロしてて"
	done

.OPT_AptlyNamedText:
	text_start
	line "なまえのとおり"
	done

.OPT_UndeniablyKindOfText:
	text_start
	line "ほんと　いわれてみれば"
	done

.OPT_UnbearablyText:
	text_start
	line "もう　たえられないくらい"
	done

.OPT_WowImpressivelyText:
	text_start
	line "これ<GA>なかなかどーして"
	done

.OPT_AlmostPoisonouslyText:
	text_start
	line "どくどくしくって"
	done

.OPT_SensuallyText:
	text_start
	line "エッチぽくって"
	done

.OPT_MischievouslyText:
	text_start
	line "オニのように"
	done

.OPT_TopicallyText:
	text_start
	line "きんじょでも　ひょうばんなくらい"
	done

.OPT_AddictivelyText:
	text_start
	line "やみつきに　なるくらい"
	done

.OPT_LooksInWaterText:
	text_start
	line "かわ<NO>ほとりで"
	done

.OPT_EvolutionMustBeText:
	text_start
	line "しんかしたりなんかすると"
	done

.OPT_ProvocativelyText:
	text_start
	line "いろんな　いみで"
	done

.OPT_FlippedOutText:
	text_start
	line "ひっくりかえすと"
	done

.OPT_HeartMeltinglyText:
	text_start
	line "まもって　あげたくなるくらい"
	done

OaksPKMNTalk9:
	; 0-15 are all valid indexes into .Adjectives,
	; so no need for a retry loop
	call Random
	maskbits NUM_OAKS_POKEMON_TALK_ADJECTIVES
	assert_power_of_2 NUM_OAKS_POKEMON_TALK_ADJECTIVES
	ld e, a
	ld d, 0
	ld hl, .Adjectives
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wOaksPKMNTalkSegmentCounter]
	dec a
	ld [wOaksPKMNTalkSegmentCounter], a
	ld a, OAKS_POKEMON_TALK_4
	jr nz, .ok
	ld a, 5
	ld [wOaksPKMNTalkSegmentCounter], a
	ld a, OAKS_POKEMON_TALK_10
.ok
	jp NextRadioLine

.Adjectives:
	table_width 2
	dw .OPT_CuteText
	dw .OPT_WeirdText
	dw .OPT_PleasantText
	dw .OPT_BoldSortOfText
	dw .OPT_FrighteningText
	dw .OPT_SuaveDebonairText
	dw .OPT_PowerfulText
	dw .OPT_ExcitingText
	dw .OPT_NowText
	dw .OPT_InspiringText
	dw .OPT_FriendlyText
	dw .OPT_HotHotHotText
	dw .OPT_StimulatingText
	dw .OPT_GuardedText
	dw .OPT_LovelyText
	dw .OPT_SpeedyText
	assert_table_length NUM_OAKS_POKEMON_TALK_ADJECTIVES

.OPT_CuteText:
	text_start
	line "かわいいよね"
	done

.OPT_WeirdText:
	text_start
	line "へんなのー"
	done

.OPT_PleasantText:
	text_start
	line "きもちいいね"
	done

.OPT_BoldSortOfText:
	text_start
	line "ちょっと　ダイタンってかんじ"
	done

.OPT_FrighteningText:
	text_start
	line "こわくなーい？"
	done

.OPT_SuaveDebonairText:
	text_start
	line "すいすいしてるよね！"
	done

.OPT_PowerfulText:
	text_start
	line "つよいよねー"
	done

.OPT_ExcitingText:
	text_start
	line "はくりょく　あるよね"
	done

.OPT_NowText:
	text_start
	line "ナウいよねー"
	done

.OPT_InspiringText:
	text_start
	line "あこがれちゃうー！"
	done

.OPT_FriendlyText:
	text_start
	line "なかまにして　みたいかも"
	done

.OPT_HotHotHotText:
	text_start
	line "あつく　なっちゃう！"
	done

.OPT_StimulatingText:
	text_start
	line "しびれるー！"
	done

.OPT_GuardedText:
	text_start
IF DEF(_09_30) || DEF(_10_06)
	line "バグってるかもね"
ELIF DEF(_REV0)
	line "だいじに　したいね！"
ENDC
	done

.OPT_LovelyText:
	text_start
IF DEF(_09_30) || DEF(_10_06)
	line "ぶんれつするところ<GA>みてみたいね"
ELIF DEF(_REV0)
	line "メロメロって　かんじー！"
ENDC
	done

.OPT_SpeedyText:
	text_start
IF DEF(_09_30) || DEF(_10_06)
	line "パンチ<GA>はやいよね"
ELIF DEF(_REV0)
	line "うごき<GA>すばやいよねー"
ENDC
	done

OaksPKMNTalk10:
	farcall RadioMusicRestartPokemonChannel
	ld hl, OPT_RestartText
	call PrintText
	call WaitBGMap
	ld hl, OPT_PokemonChannelText
	call PrintText
	ld a, OAKS_POKEMON_TALK_11
	ld [wCurRadioLine], a
	ld a, 100
	ld [wRadioTextDelay], a
	ret

OPT_PokemonChannelText:
	text "#"
	done

OPT_RestartText:
	text_end

OaksPKMNTalk11:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	hlcoord 6, 14
	ld de, .pokemon_string
	ld a, OAKS_POKEMON_TALK_12
	jp PlaceRadioString

.pokemon_string
	db "#@"

OaksPKMNTalk12:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	hlcoord 1, 16
	ld de, .pokemon_channel_string
	ld a, OAKS_POKEMON_TALK_13
	jp PlaceRadioString

.pokemon_channel_string
	db "#　チャンネル@"

OaksPKMNTalk13:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	hlcoord 12, 16
	ld de, .terminator
	ld a, OAKS_POKEMON_TALK_14
	jp PlaceRadioString

.terminator
	db "@"

OaksPKMNTalk14:
	ld hl, wRadioTextDelay
	dec [hl]
	ret nz
	ld de, MUSIC_POKEMON_TALK
	callfar RadioMusicRestartDE
	ld hl, .terminator
	call PrintText
	ld a, OAKS_POKEMON_TALK_4
	ld [wNextRadioLine], a
	xor a
	ld [wNumRadioLinesPrinted], a
	ld a, RADIO_SCROLL
	ld [wCurRadioLine], a
	ld a, 10
	ld [wRadioTextDelay], a
	ret

.terminator
	db "@"

PlaceRadioString:
	ld [wCurRadioLine], a
	ld a, 100
	ld [wRadioTextDelay], a
	jp PlaceString

CopyBottomLineToTopLine:
	hlcoord 0, 15
	decoord 0, 13
	ld bc, SCREEN_WIDTH * 2
	jp CopyBytes

ClearBottomLine:
	hlcoord 1, 15
	ld bc, SCREEN_WIDTH - 2
	ld a, '　'
	call ByteFill
	hlcoord 1, 16
	ld bc, SCREEN_WIDTH - 2
	ld a, '　'
	jp ByteFill

PokedexShow1:
	call StartRadioStation
.loop
	call Random
	cp NUM_POKEMON
	jr nc, .loop
	ld c, a
	push bc
	ld a, c
	call CheckCaughtMon
	pop bc
	jr z, .loop
	inc c
	ld a, c
	ld [wCurPartySpecies], a
	ld [wNamedObjectIndex], a
	call GetPokemonName
	ld hl, PokedexShowText
	ld a, POKEDEX_SHOW_2
	jp NextRadioLine

PokedexShow2:
	ld a, [wCurPartySpecies]
	cp KINGLER + 1
	ld hl, PokedexDataPointerTable1
	jr c, .gotTable
	sub KINGLER
	ld hl, PokedexDataPointerTable2
.gotTable
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, BANK("Pokedex Entries")
	call GetFarWord
	push hl
	ld de, wPokedexShowPointerBank
	ld bc, SCREEN_WIDTH - 1
	ld a, BANK("Pokedex Entries")
	call FarCopyBytes
	ld hl, wPokedexShowPointerAddr
	ld [hl], TX_START
	inc hl
	ld [hl], '<LINE>'
	inc hl
.loop
	ld a, [hli]
	cp '@'
	jr nz, .loop
	dec hl
	ld [hl], '#'
	inc hl
	ld [hl], '<DONE>'
	ld hl, wPokedexShowPointerAddr
	call CopyRadioTextToRAM
	pop hl
.loop2
	ld a, BANK("Pokedex Entries")
	call GetFarByte
	inc hl
	cp '@'
	jr nz, .loop2
	ld de, wPokedexShowPointerAddr
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	ld a, POKEDEX_SHOW_3
	jp PrintRadioLine

PokedexShow3:
	ld hl, wPokedexShowPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	inc hl
	inc hl
	push hl
	ld de, wPokedexShowPointerBank
	ld bc, SCREEN_WIDTH - 1
	ld a, BANK("Pokedex Entries")
	call FarCopyBytes
	ld hl, wPokedexShowPointerAddr
	ld [hl], TX_START
	inc hl
	ld [hl], '<LINE>'
	inc hl
.loop
	ld a, [hli]
	cp '<NEXT>'
	jr nz, .loop
	dec hl
	ld [hl], '<DONE>'
	ld hl, wPokedexShowPointerAddr
	call CopyRadioTextToRAM
	pop hl
	ld de, wPokedexShowPointerAddr
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	ld a, POKEDEX_SHOW_4
	jp PrintRadioLine

PokedexShow4:
	ld hl, wPokedexShowPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop
	ld a, BANK("Pokedex Entries")
	call GetFarByte
	inc hl
	cp '<NEXT>'
	jr nz, .loop
	push hl
	ld de, wPokedexShowPointerBank
	ld bc, SCREEN_WIDTH - 1
	ld a, BANK("Pokedex Entries")
	call FarCopyBytes
	ld hl, wPokedexShowPointerAddr
	ld [hl], TX_START
	inc hl
	ld [hl], '<LINE>'
	inc hl
.loop2
	ld a, [hli]
	cp '<NEXT>'
	jr nz, .loop2
	dec hl
	ld [hl], '<DONE>'
	ld hl, wPokedexShowPointerAddr
	call CopyRadioTextToRAM
	pop hl
	ld de, wPokedexShowPointerAddr
	ld a, l
	ld [de], a
	inc de
	ld a, h
	ld [de], a
	ld a, POKEDEX_SHOW_5
	jp PrintRadioLine

PokedexShow5:
	ld hl, wPokedexShowPointerAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop
	ld a, BANK("Pokedex Entries")
	call GetFarByte
	inc hl
	cp '<NEXT>'
	jr nz, .loop
	ld de, wPokedexShowPointerBank
	ld bc, SCREEN_WIDTH - 1
	ld a, BANK("Pokedex Entries")
	call FarCopyBytes
	ld hl, wPokedexShowPointerAddr
	ld [hl], TX_START
	inc hl
	ld [hl], '<LINE>'
	inc hl
.loop2
	ld a, [hli]
	cp '<DEXEND>'
	jr nz, .loop2
	dec hl
	ld [hl], '<DONE>'
	ld hl, wPokedexShowPointerAddr
	ld a, POKEDEX_SHOW
	jp NextRadioLine

PokedexShowText:
	text_start
	line "@"
	text_ram wStringBuffer1
	text_end

BenMonMusic1:
	call StartPokemonMusicChannel
	ld hl, BenIntroText1
	ld a, POKEMON_MUSIC_2
	jp NextRadioLine

BenMonMusic2:
	ld hl, BenIntroText2
	ld a, POKEMON_MUSIC_3
	jp NextRadioLine

BenMonMusic3:
	ld hl, BenIntroText3
	ld a, POKEMON_MUSIC_4
	jp NextRadioLine

FernMonMusic1:
	call StartPokemonMusicChannel
	ld hl, FernIntroText1
	ld a, LETS_ALL_SING_2
	jp NextRadioLine

FernMonMusic2:
	ld hl, FernIntroText2
	ld a, POKEMON_MUSIC_4
	jp NextRadioLine

BenFernMusic4:
	ld hl, BenFernText1
	ld a, POKEMON_MUSIC_5
	jp NextRadioLine

BenFernMusic5:
	call GetWeekday
	and 1
	ld hl, BenFernText2A
	jr z, .SunTueThurSun
	ld hl, BenFernText2B
.SunTueThurSun:
	ld a, POKEMON_MUSIC_6
	jp NextRadioLine

BenFernMusic6:
	call GetWeekday
	and 1
	ld hl, BenFernText3A
	jr z, .SunTueThurSun
	ld hl, BenFernText3B
.SunTueThurSun:
	ld a, POKEMON_MUSIC_7
	jp NextRadioLine

BenFernMusic7:
	ret

StartPokemonMusicChannel:
	call RadioTerminator
	call PrintText
	ld de, MUSIC_POKEMON_MARCH
	call GetWeekday
	and 1
	jr z, .SunTueThurSun
	ld de, MUSIC_POKEMON_LULLABY
.SunTueThurSun:
	callfar RadioMusicRestartDE
	ret

BenIntroText1:
	text_start
	line "セージ『#　ミュージック"
	done

BenIntroText2:
	text_start
	line "チャンネル！"
	done

BenIntroText3:
	text_start
	line "ディージェイ<WA>セージで　ごじゃる"
	done

FernIntroText1:
	text_start
	line "コージ『#　うた<NO>ひろば！"
	done

FernIntroText2:
	text_start
	line "ディージェイ<WA>コージ　なのだー"
	done

BenFernText1:
	text_start
	line "きょう<WA>@"
	text_today
	text "　ということで"
	done

BenFernText2A:
	text_start
	line "#たちも　げんきに　なる"
	done

BenFernText2B:
	text_start
	line "#たちも　すやすや　ねむる"
	done

BenFernText3A:
	text_start
	line "#マーチ！"
	done

BenFernText3B:
	text_start
	line "#こもりうた！"
	done

LuckyNumberShow1:
	call StartRadioStation
	callfar CheckLuckyNumberShowFlag
	jr nc, .dontreset
	callfar ResetLuckyNumberShowFlag
.dontreset
	ld hl, LC_Text1
	ld a, LUCKY_NUMBER_SHOW_2
	jp NextRadioLine

LuckyNumberShow2:
	ld hl, LC_Text2
	ld a, LUCKY_NUMBER_SHOW_3
	jp NextRadioLine

LuckyNumberShow3:
	ld hl, LC_Text3
	ld a, LUCKY_NUMBER_SHOW_4
	jp NextRadioLine

LuckyNumberShow4:
	ld hl, LC_Text4
	ld a, LUCKY_NUMBER_SHOW_5
	jp NextRadioLine

LuckyNumberShow5:
	ld hl, LC_Text5
	ld a, LUCKY_NUMBER_SHOW_6
	jp NextRadioLine

LuckyNumberShow6:
	ld hl, LC_Text6
	ld a, LUCKY_NUMBER_SHOW_7
	jp NextRadioLine

LuckyNumberShow7:
	ld hl, LC_Text7
	ld a, LUCKY_NUMBER_SHOW_8
	jp NextRadioLine

LuckyNumberShow8:
	ld hl, wStringBuffer1
	ld de, wLuckyIDNumber
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	ld a, '@'
	ld [wStringBuffer1 + 5], a
	ld hl, LC_Text8
	ld a, LUCKY_NUMBER_SHOW_9
	jp NextRadioLine

LuckyNumberShow9:
	ld hl, LC_Text9
	ld a, LUCKY_NUMBER_SHOW_10
	jp NextRadioLine

LuckyNumberShow10:
	ld hl, LC_Text7
	ld a, LUCKY_NUMBER_SHOW_11
	jp NextRadioLine

LuckyNumberShow11:
	ld hl, LC_Text8
	ld a, LUCKY_NUMBER_SHOW_12
	jp NextRadioLine

LuckyNumberShow12:
	ld hl, LC_Text10
	ld a, LUCKY_NUMBER_SHOW_13
	jp NextRadioLine

LuckyNumberShow13:
	ld hl, LC_Text11
	call Random
	and a
	ld a, LUCKY_CHANNEL
	jr nz, .okay
	ld a, LUCKY_NUMBER_SHOW_14
.okay
	jp NextRadioLine

LuckyNumberShow14:
	ld hl, LC_DragText1
	ld a, LUCKY_NUMBER_SHOW_15
	jp NextRadioLine

LuckyNumberShow15:
	ld hl, LC_DragText2
	ld a, LUCKY_CHANNEL
	jp NextRadioLine

LC_Text1:
	text_start
	line "ツゲ『ヤー！　ラジオ<WO>きいてる"
	done

LC_Text2:
	text_start
	line "みんな　さいきん　ちょうし　どうよ？"
	done

LC_Text3:
	text_start
	line "グッドな　きみも　ダメダメな　きみも"
	done

LC_Text4:
	text_start
	line "こんしゅう<NO>ラッキーナンバー"
	done

LC_Text5:
	text_start
	line "いってみようよ！"
	done

LC_Text6:
	text_start
	line "じゃあ　はっぴょう　するよ"
	done

LC_Text7:
	text_start
	line "こんしゅう<NO>ラッキーナンバーは"
	done

LC_Text8:
	text_start
	line "@"
	text_pause
	text_dots 3
	text_ram wStringBuffer1
	text "！"
	done

LC_Text9:
	text_start
	line "もいちど　いくよ"
	done

LC_Text10:
	text_start
	line "こ<NO>すうじに　ぴんと　きたら"
	done

LC_Text11:
	text_start
	line "いますぐ　ラジオとうに　カモン！"
	done

LC_DragText1:
	text_start
	line "@"
	text_dots 3
	text "おなじこと　ばかり　いってると"
	done

LC_DragText2:
	text_start
	line "つかれちゃうなー　もう"
	done

PeoplePlaces1:
	call StartRadioStation
	ld hl, PnP_Text1
	ld a, PLACES_AND_PEOPLE_2
	jp NextRadioLine

PeoplePlaces2:
	ld hl, PnP_Text2
	ld a, PLACES_AND_PEOPLE_3
	jp NextRadioLine

PeoplePlaces3:
	ld hl, PnP_Text3
	call Random
	cp 49 percent - 1
	ld a, PLACES_AND_PEOPLE_4 ; People
	jr c, .ok
	ld a, PLACES_AND_PEOPLE_6 ; Places
.ok
	jp NextRadioLine

PnP_Text1:
	text_start
	line "あのまち　このひと！"
	done

PnP_Text2:
	text_start
	line "このばんぐみ<WA>わたし　リリスが"
	done

PnP_Text3:
	text_start
	line "おおくり　いたしまーす！"
	done

PeoplePlaces4: ; People
	call Random
	maskbits NUM_TRAINER_CLASSES
	inc a
	cp NUM_TRAINER_CLASSES + 1
	jr nc, PeoplePlaces4
	push af
	ld hl, PnP_HiddenPeople
	ld a, [wStatusFlags]
	bit STATUSFLAGS_HALL_OF_FAME_F, a
	jr z, .ok
	ld hl, PnP_HiddenPeople_BeatE4
	ld a, [wKantoBadges]
	cp %11111111 ; all badges
	jr nz, .ok
	ld hl, PnP_HiddenPeople_BeatKanto
.ok
	pop af
	ld c, a
	ld de, 1
	push bc
	call IsInArray
	pop bc
	jr c, PeoplePlaces4
	push bc
	callfar GetTrainerClassName
	ld de, wStringBuffer1
	call CopyName1
	pop bc
	ld b, 1
	callfar GetTrainerName
	ld hl, PnP_Text4
	ld a, PLACES_AND_PEOPLE_5
	jp NextRadioLine

INCLUDE "data/radio/pnp_hidden_people.asm"

PnP_Text4:
	text_start
	line "@"
	text_ram wStringBuffer2
	text "<NO>@"
	text_ram wStringBuffer1
	text "って"
	done

PeoplePlaces5:
	; 0-15 are all valid indexes into .Adjectives,
	; so no need for a retry loop
	call Random
	maskbits NUM_PNP_PEOPLE_ADJECTIVES
	assert_power_of_2 NUM_PNP_PEOPLE_ADJECTIVES
	ld e, a
	ld d, 0
	ld hl, .Adjectives
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call Random
	cp 4 percent
	ld a, PLACES_AND_PEOPLE
	jr c, .ok
	call Random
	cp 49 percent - 1
	ld a, PLACES_AND_PEOPLE_4 ; People
	jr c, .ok
	ld a, PLACES_AND_PEOPLE_6 ; Places
.ok
	jp NextRadioLine

.Adjectives:
	table_width 2
	dw PnP_CuteText
	dw PnP_LazyText
	dw PnP_HappyText
	dw PnP_NoisyText
	dw PnP_PrecociousText
	dw PnP_BoldText
	dw PnP_PickyText
	dw PnP_SortOfOKText
	dw PnP_SoSoText
	dw PnP_GreatText
	dw PnP_MyTypeText
	dw PnP_CoolText
	dw PnP_InspiringText
	dw PnP_WeirdText
	dw PnP_RightForMeText
	dw PnP_OddText
	assert_table_length NUM_PNP_PEOPLE_ADJECTIVES

PnP_CuteText:
	text_start
	line "かわいいね"
	done

PnP_LazyText:
	text_start
	line "なまけものかも"
	done

PnP_HappyText:
	text_start
	line "いつも　ごきげん"
	done

PnP_NoisyText:
	text_start
	line "とっても　にぎやか"
	done

PnP_PrecociousText:
	text_start
	line "ちょっと　おませさん"
	done

PnP_BoldText:
	text_start
	line "ちょっと　ダイタン"
	done

PnP_PickyText:
	text_start
	line "くちうるさいのよねー！"
	done

PnP_SortOfOKText:
	text_start
	line "それなりに⋯ね"
	done

PnP_SoSoText:
	text_start
	line "わたしてきに<WA>まあまあかしら？"
	done

PnP_GreatText:
	text_start
	line "ほんと<WA>すごいのかも"
	done

PnP_MyTypeText:
	text_start
IF DEF(_09_30) || DEF(_10_06)
	line "わたしてきに<WA>すきかも！"
ELIF DEF(_REV0)
	line "わたしてきに<WA>タイプかも！"
ENDC
	done

PnP_CoolText:
	text_start
	line "イカしてると　おもわない？"
	done

PnP_InspiringText:
	text_start
	line "わたし　あこがれちゃう！"
	done

PnP_WeirdText:
	text_start
	line "かんがえてみると　ふしぎー"
	done

PnP_RightForMeText:
	text_start
	line "わたしのこと　どうおもってるのかな？"
	done

PnP_OddText:
	text_start
	line "やっぱり　へん！"
	done

PeoplePlaces6: ; Places
	call Random
	cp (PnP_Places.End - PnP_Places) / 2
	jr nc, PeoplePlaces6
	ld hl, PnP_Places
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	call GetWorldMapLocation
	ld e, a
	callfar GetLandmarkName
	ld hl, PnP_Text5
	ld a, PLACES_AND_PEOPLE_7
	jp NextRadioLine

INCLUDE "data/radio/pnp_places.asm"

PnP_Text5:
	text_start
	line "@"
	text_ram wStringBuffer1
	text "って"
	done

PeoplePlaces7:
	; 0-15 are all valid indexes into .Adjectives,
	; so no need for a retry loop
	call Random
	maskbits NUM_PNP_PLACES_ADJECTIVES
	assert_power_of_2 NUM_PNP_PLACES_ADJECTIVES
	ld e, a
	ld d, 0
	ld hl, .Adjectives
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call CopyRadioTextToRAM
	call Random
	cp 4 percent
	ld a, PLACES_AND_PEOPLE
	jr c, .ok
	call Random
	cp 49 percent - 1
	ld a, PLACES_AND_PEOPLE_4 ; People
	jr c, .ok
	ld a, PLACES_AND_PEOPLE_6 ; Places
.ok
	jp PrintRadioLine

.Adjectives:
	table_width 2
	dw PnP_CuteText
	dw PnP_LazyText
	dw PnP_HappyText
	dw PnP_NoisyText
	dw PnP_PrecociousText
	dw PnP_BoldText
	dw PnP_PickyText
	dw PnP_SortOfOKText
	dw PnP_SoSoText
	dw PnP_GreatText
	dw PnP_MyTypeText
	dw PnP_CoolText
	dw PnP_InspiringText
	dw PnP_WeirdText
	dw PnP_RightForMeText
	dw PnP_OddText
	assert_table_length NUM_PNP_PLACES_ADJECTIVES

RocketRadio1:
	call StartRadioStation
	ld hl, RocketRadioText1
	ld a, ROCKET_RADIO_2
	jp NextRadioLine

RocketRadio2:
	ld hl, RocketRadioText2
	ld a, ROCKET_RADIO_3
	jp NextRadioLine

RocketRadio3:
	ld hl, RocketRadioText3
	ld a, ROCKET_RADIO_4
	jp NextRadioLine

RocketRadio4:
	ld hl, RocketRadioText4
	ld a, ROCKET_RADIO_5
	jp NextRadioLine

RocketRadio5:
	ld hl, RocketRadioText5
	ld a, ROCKET_RADIO_6
	jp NextRadioLine

RocketRadio6:
	ld hl, RocketRadioText6
	ld a, ROCKET_RADIO_7
	jp NextRadioLine

RocketRadio7:
	ld hl, RocketRadioText7
	ld a, ROCKET_RADIO_8
	jp NextRadioLine

RocketRadio8:
	ld hl, RocketRadioText8
	ld a, ROCKET_RADIO_9
	jp NextRadioLine

RocketRadio9:
	ld hl, RocketRadioText9
	ld a, ROCKET_RADIO_10
	jp NextRadioLine

RocketRadio10:
	ld hl, RocketRadioText10
	ld a, ROCKET_RADIO
	jp NextRadioLine

RocketRadioText1:
	text_start
	line "<⋯>@"
	text_pause
	text "あー@"
	text_pause
	text "<⋯>@"
	text_pause
	text "われわれは"
	done

RocketRadioText2:
	text_start
	line "なく　こ　も　だまる　<ROCKET>！"
	done

RocketRadioText3:
	text_start
	line "そしき<NO>たてなおし<WO>すすめた"
	done

RocketRadioText4:
	text_start
	line "３ねんかん<NO>どりょく<GA>みのり"
	done

RocketRadioText5:
	text_start
	line "いま　ここに　<ROCKET>の"
	done

RocketRadioText6:
	text_start
	line "ふっかつ<WO>せんげん　する！"
	done

RocketRadioText7:
	text_start
	line "サカキさーん！　@"
	text_pause
	text "<⋯>　@"
	text_pause
	text "きこえますー？"
	done

RocketRadioText8:
	text_start
	line "<⋯>　@"
	text_pause
	text "ついに　やりましたよー！"
	done

RocketRadioText9:
	text_start
	line "ボス<WA>どこに　いるんだろう@"
	text_pause
	text "<⋯>？"
	done

RocketRadioText10:
	text_start
	line "ラジオ<WO>きいてるかなあ@"
	text_pause
	text "<⋯>　@"
	text_pause
	text "<⋯>"
	done

PokeFluteRadio:
	call StartRadioStation
	ld a, 1
	ld [wNumRadioLinesPrinted], a
	ret

UnownRadio:
	call StartRadioStation
	ld a, 1
	ld [wNumRadioLinesPrinted], a
	ret

EvolutionRadio:
	call StartRadioStation
	ld a, 1
	ld [wNumRadioLinesPrinted], a
	ret

CopyRadioTextToRAM:
	ld de, wRadioText
	ld bc, 2 * SCREEN_WIDTH
	jp CopyBytes

StartRadioStation:
	ld a, [wNumRadioLinesPrinted]
	and a
	ret nz
	call RadioTerminator
	call PrintText
	ld hl, RadioChannelSongs
	ld a, [wCurRadioLine]
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	callfar RadioMusicRestartDE
	ret

INCLUDE "data/radio/channel_music.asm"

NextRadioLine:
	push af
	call CopyRadioTextToRAM
	pop af
	jp PrintRadioLine
