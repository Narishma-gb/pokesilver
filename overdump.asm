IF DEF(_09_30)

SECTION "Bank 00 Overdump", ROM0

; partial overdump of RestartMapMusic
	pop de
	pop hl
	ret

Overdump_SpecialMapMusic:
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .surf
	cp PLAYER_SURF_PIKA
	jr z, .surf

	ld a, [wStatusFlags2]
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, a
	jr nz, .contest

.no
	and a
	ret

.bike
	ld de, MUSIC_BICYCLE
	scf
	ret

.surf
	ld de, MUSIC_SURF
	scf
	ret

.contest
	ld a, [wMapGroup]
	cp GROUP_ROUTE_35_NATIONAL_PARK_GATE
	jr nz, .no
	ld a, [wMapNumber]
	cp MAP_ROUTE_35_NATIONAL_PARK_GATE
	jr z, .ranking
	cp MAP_ROUTE_36_NATIONAL_PARK_GATE
	jr nz, .no

.ranking
	ld de, MUSIC_BUG_CATCHING_CONTEST_RANKING
	scf
	ret

Overdump_GetMapMusic_MaybeSpecial:
	call Overdump_SpecialMapMusic
	ret c
	call $2df6 ; GetMapMusic
	ret

Overdump_PlaceBCDNumberSprite:
; Places a BCD number at the upper center of the screen.
	ld a, 4 * TILE_WIDTH
	ld [wShadowOAMSprite38YCoord], a
	ld [wShadowOAMSprite39YCoord], a
	ld a, 10 * TILE_WIDTH
	ld [wShadowOAMSprite38XCoord], a
	ld a, 11 * TILE_WIDTH
	ld [wShadowOAMSprite39XCoord], a
	xor a
	ld [wShadowOAMSprite38Attributes], a
	ld [wShadowOAMSprite39Attributes], a
	ld a, [wUnusedBCDNumber]
	cp 100
	jr nc, .max
	add 1
	daa
	ld b, a
	swap a
	and $f
	add '０'
	ld [wShadowOAMSprite38TileID], a
	ld a, b
	and $f
	add '０'
	ld [wShadowOAMSprite39TileID], a
	ret

.max
	ld a, '９'
	ld [wShadowOAMSprite38TileID], a
	ld [wShadowOAMSprite39TileID], a
	ret

Overdump_CheckSFX:
	ld a, [wChannel5Flags1]
	bit SOUND_CHANNEL_ON, a
	jr nz, .playing
	ld a, [wChannel6Flags1]
	bit SOUND_CHANNEL_ON, a
	jr nz, .playing
	ld a, [wChannel7Flags1]
	bit SOUND_CHANNEL_ON, a
	jr nz, .playing
	ld a, [wChannel8Flags1]
	bit SOUND_CHANNEL_ON, a
	jr nz, .playing
	and a
	ret
.playing
	scf
	ret

Overdump_TerminateExpBarSound:
	xor a
	ld [wChannel5Flags1], a
	ld [wPitchSweep], a
	ldh [rAUD1SWEEP], a
	ldh [rAUD1LEN], a
	ldh [rAUD1ENV], a
	ldh [rAUD1LOW], a
	ldh [rAUD1HIGH], a
	ret


SECTION "Bank 01 Overdump", ROMX, BANK[1]

; partial overdump of YoungerHaircutBrother
	db $03

Overdump_DaisysGrooming:
	ld hl, Overdump_HappinessData_DaisysGrooming
	; fallthrough

Overdump_HaircutOrGrooming:
	push hl
	farcall SelectMonFromParty
	pop hl
	jr c, .nope
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	push hl
	call $3ac7 ; GetCurNickname
	call Overdump_CopyPokemonName_Buffer1_Buffer3
	pop hl
	call $3102 ; Random
.loop:
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	inc hl
	jr .loop

.ok
	inc hl
	ldi a, [hl]
	ld [wScriptVar], a
	ld c, [hl]
	call $7d41 ; ChangeHappiness
	ret

.nope
	xor a
	ld [wScriptVar], a
	ret

.egg
	ld a, 1
	ld [wScriptVar], a
	ret

Overdump_HappinessData_OlderHaircutBrother:
	db 30 percent,     2, HAPPINESS_OLDERCUT1
	db 50 percent + 1, 3, HAPPINESS_OLDERCUT2
	db -1,             4, HAPPINESS_OLDERCUT3

Overdump_HappinessData_YoungerHaircutBrother:
	db 60 percent + 1, 2, HAPPINESS_YOUNGCUT1
	db 30 percent,     3, HAPPINESS_YOUNGCUT2
	db -1,             4, HAPPINESS_YOUNGCUT3

Overdump_HappinessData_DaisysGrooming:
	db -1,             2, HAPPINESS_GROOMING

Overdump_CopyPokemonName_Buffer1_Buffer3:
	ld hl, wStringBuffer1
	ld de, wStringBuffer3
	ld bc, SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS
	jp $317a ; CopyBytes

; partial duplicate overdump of CopyPokemonName_Buffer1_Buffer3
	db $0
	jp $317a ; CopyBytes


SECTION "Bank 03 Overdump", ROMX, BANK[3]

; partial overdump of KnowsMove.KnowsMoveText
	db "ています"
	prompt


SECTION "Bank 04 Overdump", ROMX, BANK[4]

; partial overdump of BugCatchingContestantEventFlagTable
	dw EVENT_BUG_CATCHING_CONTESTANT_10A

Overdump_ContestDropOffMons:
	ld hl, wPartyMon1HP
	ld a, [hli]
	or [hl]
	jr z, .fainted

	ld hl, wPartyCount
	ld a, 1
	ld [hli], a
	inc hl

	ld a, [hl]
	ld [wBugContestSecondPartySpecies], a

	ld [hl], -1
	xor a
	ld [wScriptVar], a
	ret

.fainted
	ld a, $1
	ld [wScriptVar], a
	ret

Overdump_ContestReturnMons:
	ld hl, wPartySpecies + 1
	ld a, [wBugContestSecondPartySpecies]
	ld [hl], a

	ld b, 1
.loop
	ld a, [hli]
	cp -1
	jr z, .done
	inc b
	jr .loop

.done
	ld a, b
	ld [wPartyCount], a
	ret


SECTION "Bank 09 Overdump", ROMX, BANK[9]

; partial overdump of Solarbeam
	checkobedience
	doturn
	skipsuncharge
	charge
	usedmovetext
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	checkhit
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	checkfaint
	buildopponentrage
	kingsrock
	endmove

Overdump_Thunder:
	checkobedience
	usedmovetext
	doturn
	critical
	damagestats
	damagecalc
	thunderaccuracy
	checkhit
	effectchance
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	checkfaint
	buildopponentrage
	paralyzetarget
	endmove

Overdump_Teleport:
	checkobedience
	usedmovetext
	doturn
	teleport
	endmove

Overdump_BeatUp:
	checkobedience
	usedmovetext
	movedelay
	doturn
	startloop
	lowersub
	checkhit
	critical
	beatup
	damagecalc
	damagevariation
	clearmissdamage
	moveanimnosub
	failuretext
	applydamage
	criticaltext
	cleartext
	supereffectivetext
	checkfaint
	buildopponentrage
	endloop
	beatupfailtext
	raisesub
	kingsrock
	endmove

Overdump_DefenseCurl:
	checkobedience
	usedmovetext
	doturn
	defenseup
	curl
	lowersub
	statupanim
	raisesub
	statupmessage
	statupfailtext
	endmove


SECTION "Bank 0b Overdump", ROMX, BANK[11]

; this section contains data from at least 2 previous builds

; partial duplicate overdump of ConvertBerriesToBerryJuice
	ret

	ld a, BERRY_JUICE
	ld [hl], a
	pop hl
	pop af
	ret

Overdump_ConvertBerriesToBerryJuice_partial:
.partyMonLoop
	push af
	push hl
	ld a, [hl]
	cp SHUCKLE
	jr nz, .loopMon
	ld bc, MON_ITEM
	add hl, bc
	ld a, [hl]
	cp BERRY
	jr z, .convertToJuice

.loopMon
	pop hl
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop af
	dec a
	jr nz, .partyMonLoop
	ret

.convertToJuice
	ld a, BERRY_JUICE
	ld [hl], a
	pop hl
	pop af
	ret


SECTION "Bank 0d Overdump", ROMX, BANK[13]

; partial overdump of SkipToBattleCommand
	dw wBattleScriptBufferAddress
	ret

Overdump_GetMoveAttr:
	push bc
	ld bc, MOVE_LENGTH
	call $3203 ; AddNTimes
	call Overdump_GetMoveByte
	pop bc
	ret

Overdump_GetMoveData:
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call $3203 ; AddNTimes
	ld a, BANK(Moves)
	jp FarCopyBytes

Overdump_GetMoveByte:
	ld a, BANK(Moves)
	jp $3188 ; GetFarByte

Overdump_DisappearUser:
	ld a, BANK(_DisappearUser)
	ld hl, $7e06 ; _DisappearUser
	rst FarCall
	ret

Overdump_AppearUserLowerSub:
	ld a, BANK(_AppearUserLowerSub)
	ld hl, $7e23 ; _AppearUserLowerSub
	rst FarCall
	ret

Overdump_AppearUserRaiseSub:
	ld a, BANK(_AppearUserRaiseSub)
	ld hl, $7e1b ; _AppearUserRaiseSub
	rst FarCall
	ret


SECTION "Bank 0f Overdump", ROMX, BANK[15]

; partial overdump of BattleCommandPointers
	db HIGH(BattleCommand_HappinessPower)
	dw BattleCommand_Present
	dw BattleCommand_DamageCalc
	dw BattleCommand_FrustrationPower
	dw BattleCommand_Safeguard
	dw BattleCommand_CheckSafeguard
	dw BattleCommand_GetMagnitude
	dw BattleCommand_BatonPass
	dw BattleCommand_Pursuit
	dw BattleCommand_ClearHazards
	dw BattleCommand_HealMorn
	dw BattleCommand_HealDay
	dw BattleCommand_HealNite
	dw BattleCommand_HiddenPower
	dw BattleCommand_StartRain
	dw BattleCommand_StartSun
	dw BattleCommand_AttackUp
	dw BattleCommand_DefenseUp
	dw BattleCommand_SpeedUp
	dw BattleCommand_SpecialAttackUp
	dw BattleCommand_SpecialDefenseUp
	dw BattleCommand_AccuracyUp
	dw BattleCommand_EvasionUp
	dw BattleCommand_AttackUp2
	dw BattleCommand_DefenseUp2
	dw BattleCommand_SpeedUp2
	dw BattleCommand_SpecialAttackUp2
	dw BattleCommand_SpecialDefenseUp2
	dw BattleCommand_AccuracyUp2
	dw BattleCommand_EvasionUp2
	dw BattleCommand_AttackDown
	dw BattleCommand_DefenseDown
	dw BattleCommand_SpeedDown
	dw BattleCommand_SpecialAttackDown
	dw BattleCommand_SpecialDefenseDown
	dw BattleCommand_AccuracyDown
	dw BattleCommand_EvasionDown
	dw BattleCommand_AttackDown2
	dw BattleCommand_DefenseDown2
	dw BattleCommand_SpeedDown2
	dw BattleCommand_SpecialAttackDown2
	dw BattleCommand_SpecialDefenseDown2
	dw BattleCommand_AccuracyDown2
	dw BattleCommand_EvasionDown2
	dw BattleCommand_StatUpMessage
	dw BattleCommand_StatDownMessage
	dw BattleCommand_StatUpFailText
	dw BattleCommand_StatDownFailText
	dw BattleCommand_EffectChance
	dw BattleCommand_StatDownAnim
	dw BattleCommand_StatUpAnim
	dw BattleCommand_SwitchTurn
	dw BattleCommand_FakeOut
	dw BattleCommand_BellyDrum
	dw BattleCommand_PsychUp
	dw BattleCommand_Rage
	dw BattleCommand_DoubleFlyingDamage
	dw BattleCommand_DoubleUndergroundDamage
	dw BattleCommand_MirrorCoat
	dw BattleCommand_CheckFutureSight
	dw BattleCommand_FutureSight
	dw BattleCommand_DoubleMinimizeDamage
	dw BattleCommand_SkipSunCharge
	dw BattleCommand_ThunderAccuracy
	dw BattleCommand_Teleport
	dw BattleCommand_BeatUp
	dw BattleCommand_RageDamage
	dw BattleCommand_ResetTypeMatchup
	dw BattleCommand_AllStatsUp
	dw BattleCommand_BideFailText
	dw BattleCommand_RaiseSubNoAnim
	dw BattleCommand_LowerSubNoAnim
	dw BattleCommand_BeatUpFailText
	dw BattleCommand_ClearMissDamage
	dw BattleCommand_MoveDelay
	dw BattleCommand_MoveAnim
	dw BattleCommand_TriStatusChance
	dw BattleCommand_SuperEffectiveLoopText
	dw BattleCommand_StartLoop
	dw BattleCommand_Curl


SECTION "Bank 25 Overdump", ROMX, BANK[37]

Overdump_CmdQueue_StoneTable_partial:
	dw $37b4 ; HandleStoneQueue
	jr c, .fall_down_hole

.next
	ld hl, OBJECT_LENGTH
	add hl, de
	ld d, h
	ld e, l

	pop af
	dec a
	jr nz, @ - 50
	ret

.fall_down_hole
	pop af
	ret

Overdump_TalkToTrainerScript:
	faceplayer
	trainerflagaction CHECK_FLAG
	iftrue Overdump_AlreadyBeatenTrainerScript
	loadtemptrainer
	encountermusic
	sjump Overdump_StartBattleWithMapTrainerScript

Overdump_SeenByTrainerScript:
	loadtemptrainer
	encountermusic
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	callasm TrainerWalkToPlayer
	applymovementlasttalked wMovementBuffer
	writeobjectxy LAST_TALKED
	faceobject PLAYER, LAST_TALKED
	sjump Overdump_StartBattleWithMapTrainerScript

Overdump_StartBattleWithMapTrainerScript:
	opentext
	trainertext TRAINERTEXT_SEEN
	waitbutton
	closetext
	loadtemptrainer
	startbattle
	reloadmapafterbattle
	trainerflagaction SET_FLAG
	loadmem wRunningTrainerBattleScript, -1

Overdump_AlreadyBeatenTrainerScript:
	scripttalkafter


SECTION "Bank 2d Overdump", ROMX, BANK[45]

; partial overdump of CianwoodLugiaSpeechHouse_MapEvents
	db -1


SECTION "Bank 2f Overdump", ROMX, BANK[47]

MACRO object_event_overdump
	db \3, \2 + 4, \1 + 4, \4
	dn \6, \5
	db \7, \8
	dn \9, \<10>
	db \<11>
	dw \<12>, \<13>
ENDM

; partial overdump of OaksLab_MapEvents
	db 0
	dw $7c02, -1
	object_event_overdump  8,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, $7c05, -1
	object_event_overdump  1,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, $7c08, -1


SECTION "Bank 3e Overdump", ROMX, BANK[62]

Overdump_DoBadgeTypeBoosts_partial:
	db -1
	jr z, .done

	srl b
	rr c
	jr nc, .NextBadge

	ld a, [wCurType]
	cp [hl]
	jr z, .ApplyBoost

.NextBadge:
	inc hl
	jr @ - 18

.ApplyBoost:
	ld a, [wCurDamage]
	ld h, a
	ld d, a
	ld a, [wCurDamage + 1]
	ld l, a
	ld e, a

	srl d
	rr e
	srl d
	rr e
	srl d
	rr e

	ld a, e
	or d
	jr nz, .done_min
	ld e, 1

.done_min
	add hl, de
	jr nc, .Update

	ld hl, $ffff

.Update:
	ld a, h
	ld [wCurDamage], a
	ld a, l
	ld [wCurDamage + 1], a

.done
	pop bc
	pop de
	ret

Overdump_BadgeTypeBoosts:
	db FLYING
	db BUG
	db NORMAL
	db GHOST
	db STEEL
	db FIGHTING
	db ICE
	db DRAGON
	db ROCK
	db WATER
	db ELECTRIC
	db GRASS
	db POISON
	db PSYCHIC_TYPE
	db FIRE
	db GROUND
	db -1


SECTION "Bank 3f Overdump", ROMX, BANK[63]

MACRO? predef_overdump
	lda_predef \1
	call $2ea9 ; Predef
ENDM

; partial overdump of TilesetUndergroundAnim
	db HIGH(Overdump_DoneTileAnimation)

Overdump_DoneTileAnimation:
	xor a
	ldh [hTileAnimFrame], a
	jp $15e2 ; Function15ef

Overdump_WaitTileAnimation:
	ret

Overdump_StandingTileFrame8:
	ld a, [wTileAnimationTimer]
	inc a
	and %111
	ld [wTileAnimationTimer], a
	ret

Overdump_ScrollTileRightLeft:
	ld a, [wTileAnimationTimer]
	inc a
	and %111
	ld [wTileAnimationTimer], a
	and %100
	jr nz, Overdump_ScrollTileLeft
	jr Overdump_ScrollTileRight

Overdump_ScrollTileUpDown:
	ld a, [wTileAnimationTimer]
	inc a
	and %111
	ld [wTileAnimationTimer], a
	and %100
	jr nz, Overdump_ScrollTileDown
	jr Overdump_ScrollTileUp

Overdump_ScrollTileLeft:
	ld h, d
	ld l, e
	ld c, TILE_SIZE / 4
.loop
rept 4
	ld a, [hl]
	rlca
	ld [hli], a
endr
	dec c
	jr nz, .loop
	ret

Overdump_ScrollTileRight:
	ld h, d
	ld l, e
	ld c, TILE_SIZE / 4
.loop
rept 4
	ld a, [hl]
	rrca
	ld [hli], a
endr
	dec c
	jr nz, .loop
	ret

Overdump_ScrollTileUp:
	ld h, d
	ld l, e
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld bc, TILE_SIZE - 2
	add hl, bc
	ld a, TILE_SIZE / 4
.loop
	ld c, [hl]
	ld [hl], e
	dec hl
	ld b, [hl]
	ld [hl], d
	dec hl
	ld e, [hl]
	ld [hl], c
	dec hl
	ld d, [hl]
	ld [hl], b
	dec hl
	dec a
	jr nz, .loop
	ret

Overdump_ScrollTileDown:
	ld h, d
	ld l, e
	ld de, TILE_SIZE - 2
	push hl
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	pop hl
	ld a, TILE_SIZE / 4
.loop
	ld b, [hl]
	ld [hl], d
	inc hl
	ld c, [hl]
	ld [hl], e
	inc hl
	ld d, [hl]
	ld [hl], b
	inc hl
	ld e, [hl]
	ld [hl], c
	inc hl
	dec a
	jr nz, .loop
	ret

Overdump_AnimateWaterTile:
	ld hl, sp+0
	ld b, h
	ld c, l

	ld a, [wTileAnimationTimer]
	and %110

	add a
	add a
	add a
	add LOW(.WaterTileFrames)
	ld l, a
	ld a, 0
	adc HIGH(.WaterTileFrames)
	ld h, a

	ld sp, hl
	ld l, e
	ld h, d
	jp Overdump_WriteTile

.WaterTileFrames:
	INCBIN "gfx/tilesets/water/water.2bpp"

Overdump_AnimateFlowerTile:
	ld hl, sp+0
	ld b, h
	ld c, l

	ld a, [wTileAnimationTimer]
	and %10

	ld e, a
	ldh a, [hCGB]
	and 1
	add e

	swap a
	ld e, a
	ld d, 0
	ld hl, .FlowerTileFrames
	add hl, de

	ld sp, hl
	ld hl, vTiles2 tile $03
	jp Overdump_WriteTile

.FlowerTileFrames:
	INCBIN "gfx/tilesets/flower/dmg_1.2bpp"
	INCBIN "gfx/tilesets/flower/cgb_1.2bpp"
	INCBIN "gfx/tilesets/flower/dmg_2.2bpp"
	INCBIN "gfx/tilesets/flower/cgb_2.2bpp"

Overdump_AnimateLavaBubbleTile1:
	ld hl, sp+0
	ld b, h
	ld c, l

	ld a, [wTileAnimationTimer]
	and %110

	srl a
	inc a
	inc a
	and %011

	swap a
	ld e, a
	ld d, 0
	ld hl, Overdump_LavaBubbleTileFrames
	add hl, de

	ld sp, hl
	ld hl, vTiles2 tile $5b
	jp Overdump_WriteTile

Overdump_AnimateLavaBubbleTile2:

	ld hl, sp+0
	ld b, h
	ld c, l

	ld a, [wTileAnimationTimer]
	and %110

	add a
	add a
	add a
	ld e, a
	ld d, 0
	ld hl, Overdump_LavaBubbleTileFrames
	add hl, de

	ld sp, hl
	ld hl, vTiles2 tile $38
	jp Overdump_WriteTile

Overdump_LavaBubbleTileFrames:
	INCBIN "gfx/tilesets/lava/1.2bpp"
	INCBIN "gfx/tilesets/lava/2.2bpp"
	INCBIN "gfx/tilesets/lava/3.2bpp"
	INCBIN "gfx/tilesets/lava/4.2bpp"

Overdump_AnimateTowerPillarTile:
	ld hl, sp+0
	ld b, h
	ld c, l

	ld a, [wTileAnimationTimer]
	and %111

	ld hl, .TowerPillarTileFrameOffsets
	add l
	ld l, a
	ld a, 0
	adc h
	ld h, a
	ld a, [hl]

	ld l, e
	ld h, d
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

	add [hl]
	inc hl
	ld h, [hl]
	ld l, a
	ld a, 0
	adc h
	ld h, a

	ld sp, hl
	ld l, e
	ld h, d
	jr Overdump_WriteTile

.TowerPillarTileFrameOffsets:
	db 0 tiles
	db 1 tiles
	db 2 tiles
	db 3 tiles
	db 4 tiles
	db 3 tiles
	db 2 tiles
	db 1 tiles

Overdump_StandingTileFrame:
	ld hl, wTileAnimationTimer
	inc [hl]
	ret

Overdump_AnimateWhirlpoolTile:
	ld hl, sp+0
	ld b, h
	ld c, l

	ld l, e
	ld h, d
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

	ld a, [wTileAnimationTimer]
	and %11

	swap a
	add [hl]
	inc hl
	ld h, [hl]
	ld l, a
	ld a, 0
	adc h
	ld h, a

	ld sp, hl
	ld l, e
	ld h, d
	jr Overdump_WriteTile

Overdump_WriteTileFromAnimBuffer:
	ld hl, sp+0
	ld b, h
	ld c, l

	ld hl, wTileAnimBuffer
	ld sp, hl
	ld h, d
	ld l, e
	jr Overdump_WriteTile

Overdump_ReadTileToAnimBuffer:
	ld hl, sp+0
	ld b, h
	ld c, l

	ld h, d
	ld l, e
	ld sp, hl
	ld hl, wTileAnimBuffer
	; fallthrough

Overdump_WriteTile:
	pop de
	ld [hl], e
	inc hl
	ld [hl], d
rept (TILE_SIZE - 2) / 2
	pop de
	inc hl
	ld [hl], e
	inc hl
	ld [hl], d
endr

	ld h, b
	ld l, c
	ld sp, hl
	ret

Overdump_AnimateWaterPalette:
	ldh a, [hCGB]
	and a
	ret z

	ldh a, [rBGP]
	cp %11100100
	ret nz

	ld a, [wTileAnimationTimer]
	ld l, a
	and 1
	ret nz

	ld a, BGPI_AUTOINC palette PAL_BG_WATER color 0
	ldh [rBGPI], a

	ld a, l
	and %110
	jr z, .color0
	cp %100
	jr z, .color2

; color1
	ld hl, wBGPals1 palette PAL_BG_WATER color 1
	ld a, [hli]
	ldh [rBGPD], a
	ld a, [hli]
	ldh [rBGPD], a
	ret

.color0
	ld hl, wBGPals1 palette PAL_BG_WATER color 0
	ld a, [hli]
	ldh [rBGPD], a
	ld a, [hli]
	ldh [rBGPD], a
	ret

.color2
	ld hl, wBGPals1 palette PAL_BG_WATER color 2
	ld a, [hli]
	ldh [rBGPD], a
	ld a, [hli]
	ldh [rBGPD], a
	ret

Overdump_FlickeringCaveEntrancePalette:
	ldh a, [hCGB]
	and a
	ret z

	ldh a, [rBGP]
	cp %11100100
	ret nz

	ld a, [wTimeOfDayPalset]
	cp DARKNESS_PALSET
	ret nz

	ld a, BGPI_AUTOINC palette PAL_BG_YELLOW color 0
	ldh [rBGPI], a

	ldh a, [hVBlankCounter]
	and %10
	jr nz, .color1

; color0
	ld hl, wBGPals1 palette PAL_BG_YELLOW color 0
	jr .okay

.color1
	ld hl, wBGPals1 palette PAL_BG_YELLOW color 1

.okay
	ld a, [hli]
	ldh [rBGPD], a
	ld a, [hli]
	ldh [rBGPD], a
	ret

Overdump_TowerPillarTilePointer1:  dw vTiles2 tile $2d, Overdump_TowerPillarTile1
Overdump_TowerPillarTilePointer2:  dw vTiles2 tile $2f, Overdump_TowerPillarTile2
Overdump_TowerPillarTilePointer3:  dw vTiles2 tile $3d, Overdump_TowerPillarTile3
Overdump_TowerPillarTilePointer4:  dw vTiles2 tile $3f, Overdump_TowerPillarTile4
Overdump_TowerPillarTilePointer5:  dw vTiles2 tile $3c, Overdump_TowerPillarTile5
Overdump_TowerPillarTilePointer6:  dw vTiles2 tile $2c, Overdump_TowerPillarTile6
Overdump_TowerPillarTilePointer7:  dw vTiles2 tile $4d, Overdump_TowerPillarTile7
Overdump_TowerPillarTilePointer8:  dw vTiles2 tile $4f, Overdump_TowerPillarTile8
Overdump_TowerPillarTilePointer9:  dw vTiles2 tile $5d, Overdump_TowerPillarTile9
Overdump_TowerPillarTilePointer10: dw vTiles2 tile $5f, Overdump_TowerPillarTile10

Overdump_TowerPillarTile1:  INCBIN "gfx/tilesets/tower-pillar/1.2bpp"
Overdump_TowerPillarTile2:  INCBIN "gfx/tilesets/tower-pillar/2.2bpp"
Overdump_TowerPillarTile3:  INCBIN "gfx/tilesets/tower-pillar/3.2bpp"
Overdump_TowerPillarTile4:  INCBIN "gfx/tilesets/tower-pillar/4.2bpp"
Overdump_TowerPillarTile5:  INCBIN "gfx/tilesets/tower-pillar/5.2bpp"
Overdump_TowerPillarTile6:  INCBIN "gfx/tilesets/tower-pillar/6.2bpp"
Overdump_TowerPillarTile7:  INCBIN "gfx/tilesets/tower-pillar/7.2bpp"
Overdump_TowerPillarTile8:  INCBIN "gfx/tilesets/tower-pillar/8.2bpp"
Overdump_TowerPillarTile9:  INCBIN "gfx/tilesets/tower-pillar/9.2bpp"
Overdump_TowerPillarTile10: INCBIN "gfx/tilesets/tower-pillar/10.2bpp"

Overdump_WhirlpoolFrames1: dw vTiles2 tile $32, Overdump_WhirlpoolTiles1
Overdump_WhirlpoolFrames2: dw vTiles2 tile $33, Overdump_WhirlpoolTiles2
Overdump_WhirlpoolFrames3: dw vTiles2 tile $42, Overdump_WhirlpoolTiles3
Overdump_WhirlpoolFrames4: dw vTiles2 tile $43, Overdump_WhirlpoolTiles4

Overdump_WhirlpoolTiles1: INCBIN "gfx/tilesets/whirlpool/1.2bpp"
Overdump_WhirlpoolTiles2: INCBIN "gfx/tilesets/whirlpool/2.2bpp"
Overdump_WhirlpoolTiles3: INCBIN "gfx/tilesets/whirlpool/3.2bpp"
Overdump_WhirlpoolTiles4: INCBIN "gfx/tilesets/whirlpool/4.2bpp"

Overdump_Debug_UpdateToolgear:

pushc toolgear

	ld a, [wUnusedReanchorBGMapFlags]
	bit 0, a
	ret z
	hlbgcoord 0, 1, wDebugToolgearBuffer
	ld bc, SCREEN_WIDTH
	ld a, '　'
	call $31ac ; ByteFill
	ld hl, wd55c
	bit 0, [hl]
	jr z, .Clock

	ld hl, wXCoord
	debgcoord 4, 1, wDebugToolgearBuffer
	ld c, 1
	call .PrintCoord

	ld hl, wYCoord
	debgcoord 8, 1, wDebugToolgearBuffer
	ld c, 1
	call .PrintCoord
	ret

.Clock
	ld hl, wCurDay
	debgcoord 0, 1, wDebugToolgearBuffer
	call .PrintNum
	ld a, '：'
	ldbgcoord_a 4, 1, wDebugToolgearBuffer

	ld hl, hHours
	debgcoord 5, 1, wDebugToolgearBuffer
	call .PrintNum
	ld a, '：'
	ldbgcoord_a 7, 1, wDebugToolgearBuffer

	ld hl, hMinutes
	debgcoord 8, 1, wDebugToolgearBuffer
	call .PrintNum

	ld hl, hSeconds
	debgcoord 11, 1, wDebugToolgearBuffer
	call .PrintNum

	call $35bf ; GetWeekday
	add '日'
	ldbgcoord_a 14, 1, wDebugToolgearBuffer

	ld a, '⚡'
	ldbgcoord_a 16, 1, wDebugToolgearBuffer
	inc a ; '☎'
	ldbgcoord_a 17, 1, wDebugToolgearBuffer

	ldh a, [hSeconds]
	and 1
	ret z
	ret

.PrintCoord:
	ld a, [hli]
	ld b, a
	swap a
	call .PrintDigit
	ld a, b
	call .PrintDigit
	dec c
	jr nz, .PrintCoord
	ret

.PrintNum:
	ld a, [hli]
	ld b, 0
.mod
	inc b
	sub 10
	jr nc, .mod
	dec b
	add 10
	push af
	ld a, b
	call .PrintDigit
	pop af
	call .PrintDigit
	ret

.PrintDigit:
	and %1111
	add '０'
	ld [de], a
	inc de
	ret

popc

Overdump_NPCTrade::
	ld a, e
	ld [wJumptableIndex], a
	call Overdump_Trade_GetDialog
	ld b, CHECK_FLAG
	call Overdump_TradeFlagAction
	ld a, TRADE_DIALOG_AFTER
	jr nz, .done

	ld a, TRADE_DIALOG_INTRO
	call Overdump_PrintTradeText

	call $1c01 ; YesNoBox
	ld a, TRADE_DIALOG_CANCEL
	jr c, .done

	ld b, PARTYMENUACTION_GIVE_MON
	farcall SelectTradeOrDayCareMon
	ld a, TRADE_DIALOG_CANCEL
	jr c, .done

	ld e, NPCTRADE_GIVEMON
	call Overdump_GetTradeAttr
	ld a, [wCurPartySpecies]
	cp [hl]
	ld a, TRADE_DIALOG_WRONG
	jr nz, .done

	call Overdump_CheckTradeGender
	ld a, TRADE_DIALOG_WRONG
	jr c, .done

	ld b, SET_FLAG
	call Overdump_TradeFlagAction

	ld hl, Overdump_NPCTradeCableText
	call PrintText

	call Overdump_DoNPCTrade
	call .TradeAnimation
	call Overdump_GetTradeMonNames

	ld hl, Overdump_TradedForText
	call PrintText

	call $3eea ; RestartMapMusic

	ld a, TRADE_DIALOG_COMPLETE

.done
	call Overdump_PrintTradeText
	ret

.TradeAnimation:
	call $2ff3 ; DisableSpriteUpdates
	ld a, [wJumptableIndex]
	push af
	ld a, [wTradeDialog]
	push af
	predef_overdump TradeAnimation
	pop af
	ld [wTradeDialog], a
	pop af
	ld [wJumptableIndex], a
	call $2cb3 ; ReturnToMapWithSpeechTextbox
	ret

Overdump_CheckTradeGender:
	xor a
	ld [wMonType], a

	ld e, NPCTRADE_GENDER
	call Overdump_GetTradeAttr
	ld a, [hl]
	and a
	jr z, .matching
	cp TRADE_GENDER_MALE
	jr z, .check_male

	ld a, BANK(GetGender)
	ld hl, $52eb ; GetGender
	rst FarCall
	jr nz, .not_matching
	jr .matching

.check_male
	ld a, BANK(GetGender)
	ld hl, $52eb ; GetGender
	rst FarCall
	jr z, .not_matching

.matching
	and a
	ret

.not_matching
	scf
	ret

Overdump_TradeFlagAction:
	ld hl, wTradeFlags
	ld a, [wJumptableIndex]
	ld c, a
	predef_overdump SmallFarFlagAction
	ld a, c
	and a
	ret

Overdump_Trade_GetDialog:
	ld e, NPCTRADE_DIALOG
	call Overdump_GetTradeAttr
	ld a, [hl]
	ld [wTradeDialog], a
	ret

Overdump_DoNPCTrade:
	ld e, NPCTRADE_GIVEMON
	call Overdump_GetTradeAttr
	ld a, [hl]
	ld [wPlayerTrademonSpecies], a

	ld e, NPCTRADE_GETMON
	call Overdump_GetTradeAttr
	ld a, [hl]
	ld [wOTTrademonSpecies], a

	ld a, [wPlayerTrademonSpecies]
	ld de, wPlayerTrademonSpeciesName
	call Overdump_GetTradeMonName
	call Overdump_CopyTradeName

	ld a, [wOTTrademonSpecies]
	ld de, wOTTrademonSpeciesName
	call Overdump_GetTradeMonName
	call Overdump_CopyTradeName

	ld hl, wPartyMonOTs
	ld bc, NAME_LENGTH
	call Overdump_Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonOTName
	call Overdump_CopyTradeName

	ld hl, wPlayerName
	ld de, wPlayerTrademonSenderName
	call Overdump_CopyTradeName

	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call Overdump_Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonID
	call Overdump_Trade_CopyTwoBytes

	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call Overdump_Trade_GetAttributeOfCurrentPartymon
	ld de, wPlayerTrademonDVs
	call Overdump_Trade_CopyTwoBytes

	ld hl, wPartyMon1Level
	ld bc, PARTYMON_STRUCT_LENGTH
	call Overdump_Trade_GetAttributeOfCurrentPartymon
	ld a, [hl]
	ld [wCurPartyLevel], a
	ld a, [wOTTrademonSpecies]
	ld [wCurPartySpecies], a
	xor a
	ld [wMonType], a
	ld [wPokemonWithdrawDepositParameter], a
	ld hl, $62cf ; RemoveMonFromPartyOrBox
	ld a, BANK(RemoveMonFromPartyOrBox)
	rst FarCall
	predef_overdump TryAddMonToParty

	ld e, NPCTRADE_NICKNAME
	call Overdump_GetTradeAttr
	ld de, wOTTrademonNickname
	call Overdump_Trade_CopyFourCharString

	ld hl, wPartyMonNicknames
	ld bc, NAME_LENGTH
	call Overdump_Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonNickname
	call Overdump_CopyTradeName

	ld e, NPCTRADE_OT_NAME
	call Overdump_GetTradeAttr
	push hl
	ld de, wOTTrademonOTName
	call Overdump_Trade_CopyThreeCharString
	pop hl
	ld de, wOTTrademonSenderName
	call Overdump_Trade_CopyThreeCharString

	ld hl, wPartyMonOTs
	ld bc, NAME_LENGTH
	call Overdump_Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonOTName
	call Overdump_CopyTradeName

	ld e, NPCTRADE_DVS
	call Overdump_GetTradeAttr
	ld de, wOTTrademonDVs
	call Overdump_Trade_CopyTwoBytes

	ld hl, wPartyMon1DVs
	ld bc, PARTYMON_STRUCT_LENGTH
	call Overdump_Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonDVs
	call Overdump_Trade_CopyTwoBytes

	ld e, NPCTRADE_OT_ID
	call Overdump_GetTradeAttr
	ld de, wOTTrademonID + 1
	call Overdump_Trade_CopyTwoBytesReverseEndian

	ld hl, wPartyMon1ID
	ld bc, PARTYMON_STRUCT_LENGTH
	call Overdump_Trade_GetAttributeOfLastPartymon
	ld hl, wOTTrademonID
	call Overdump_Trade_CopyTwoBytes

	ld e, NPCTRADE_ITEM
	call Overdump_GetTradeAttr
	push hl
	ld hl, wPartyMon1Item
	ld bc, PARTYMON_STRUCT_LENGTH
	call Overdump_Trade_GetAttributeOfLastPartymon
	pop hl
	ld a, [hl]
	ld [de], a

	push af
	push bc
	push de
	push hl
	ld a, [wCurPartyMon]
	push af
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	ld a, BANK(ComputeNPCTrademonStats)
	ld hl, $63ca ; ComputeNPCTrademonStats
	rst FarCall
	pop af
	ld [wCurPartyMon], a
	pop hl
	pop de
	pop bc
	pop af
	ret

Overdump_GetTradeAttr:
	ld d, 0
	push de
	ld a, [wJumptableIndex]
	and $f
	swap a
	ld e, a
	ld d, 0
	ld hl, Overdump_NPCTrades
	add hl, de
	pop de
	add hl, de
	ret

Overdump_Trade_GetAttributeOfCurrentPartymon:
	ld a, [wCurPartyMon]
	call $3203 ; AddNTimes
	ret

Overdump_Trade_GetAttributeOfLastPartymon:
	ld a, [wPartyCount]
	dec a
	call $3203 ; AddNTimes
	ld e, l
	ld d, h
	ret

Overdump_GetTradeMonName:
	push de
	ld [wNamedObjectIndex], a
	call $3669 ; GetBasePokemonName
	ld hl, wStringBuffer1
	pop de
	ret

Overdump_CopyTradeName:
	ld bc, NAME_LENGTH
	call $317a ; CopyBytes
	ret

Overdump_Trade_CopyFourCharString:
	ld bc, 4
	call $317a ; CopyBytes
	ld a, '@'
	ld [de], a
	ret

Overdump_Trade_CopyThreeCharString:
	ld bc, 3
	call $317a ; CopyBytes
	ld a, '@'
	ld [de], a
	ret

Overdump_Trade_CopyTwoBytes:
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ret

Overdump_Trade_CopyTwoBytesReverseEndian:
	ld a, [hli]
	ld [de], a
	dec de
	ld a, [hl]
	ld [de], a
	ret

Overdump_GetTradeMonNames:
	ld e, NPCTRADE_GETMON
	call Overdump_GetTradeAttr
	ld a, [hl]
	call Overdump_GetTradeMonName

	ld de, wStringBuffer2
	call Overdump_CopyTradeName

	ld e, NPCTRADE_GIVEMON
	call Overdump_GetTradeAttr
	ld a, [hl]
	call Overdump_GetTradeMonName

	ld de, wMonOrItemNameBuffer
	call Overdump_CopyTradeName

	ld hl, wStringBuffer1
.loop
	ld a, [hli]
	cp '@'
	jr nz, .loop

	dec hl
	push hl
	ld e, NPCTRADE_GENDER
	call Overdump_GetTradeAttr
	ld a, [hl]
	pop hl
	and a
	ret z
	cp TRADE_GENDER_MALE
	ld a, '♂'
	jr z, .done
	ld a, '♀'
.done
	ld [hli], a
	ld [hl], '@'
	ret

MACRO npctrade
	db \1, \2, \3
	dname \4, NAME_LENGTH - 2
	db \5, \6, \7
	dw \8
	dname \9, NAME_LENGTH - 3
	db \<10>
ENDM

Overdump_NPCTrades:
	npctrade TRADE_DIALOGSET_COLLECTOR, DROWZEE,    MACHOP,     "きんにく", $37, $66, GOLD_BERRY,   37460, "ナオキ", TRADE_GENDER_EITHER
	npctrade TRADE_DIALOGSET_COLLECTOR, BELLSPROUT, ONIX,       "ブルブル", $96, $66, BITTER_BERRY, 48926, "コンタ", TRADE_GENDER_EITHER
	npctrade TRADE_DIALOGSET_HAPPY,     KRABBY,     VOLTORB,    "ビリー",   $98, $88, PRZCUREBERRY, 29189,  "ゲン", TRADE_GENDER_EITHER
	npctrade TRADE_DIALOGSET_NEWBIE,    DRAGONAIR,  RHYDON,     "ドンドコ",  $77, $66, BITTER_BERRY, 00283, "ミサコ", TRADE_GENDER_FEMALE
	npctrade TRADE_DIALOGSET_HAPPY,     KADABRA,    RAPIDASH,   "カケアシ", $96, $66, BURNT_BERRY,  15616, "デンジ", TRADE_GENDER_EITHER
	npctrade TRADE_DIALOGSET_NEWBIE,    CHANSEY,    AERODACTYL, "プッチー",  $96, $66, GOLD_BERRY,   26491, "キヨミ", TRADE_GENDER_EITHER

Overdump_PrintTradeText:
	push af
	call Overdump_GetTradeMonNames
	pop af
	ld e, a
	ld d, 0
	ld hl, Overdump_TradeTexts
rept 6
	add hl, de
endr
	ld a, [wTradeDialog]
	ld e, a
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	ret

Overdump_TradeTexts:
	dw Overdump_NPCTradeIntroText1
	dw Overdump_NPCTradeIntroText2
	dw Overdump_NPCTradeIntroText3

	dw Overdump_NPCTradeCancelText1
	dw Overdump_NPCTradeCancelText2
	dw Overdump_NPCTradeCancelText3

	dw Overdump_NPCTradeWrongText1
	dw Overdump_NPCTradeWrongText2
	dw Overdump_NPCTradeWrongText3

	dw Overdump_NPCTradeCompleteText1
	dw Overdump_NPCTradeCompleteText2
	dw Overdump_NPCTradeCompleteText3

	dw Overdump_NPCTradeAfterText1
	dw Overdump_NPCTradeAfterText2
	dw Overdump_NPCTradeAfterText3

Overdump_NPCTradeCableText:
	text "じゃあ"
	line "ケーブルを　つないで<⋯>と"
	prompt

Overdump_TradedForText:
	text "<PLAYER>は　@"
	text_ram wMonOrItemNameBuffer
	text "と"
	line "@"
	text_ram wStringBuffer2
	text "を　こうかんした！@"
	text_asm
	ld de, MUSIC_NONE
	call $3d5d ; PlayMusic
	call DelayFrame
	ld hl, .done
	ret

.done
	sound_dex_fanfare_80_109
	text_pause
	text_end

Overdump_NPCTradeIntroText1:
	text "ボク　#　あつめてるんだ！"
	line "キミは　@"
	text_ram wStringBuffer1
	text "を　もってる？"

	para "ボクの　@"
	text_ram wStringBuffer2
	text "と"
	line "こうかん　しようよ？"
	done

Overdump_NPCTradeCancelText1:
	text "とりかえて　くれないの？"
	line "ちぇっ　がっかりだなあ<⋯>"
	done

Overdump_NPCTradeWrongText1:
	text "あれ<⋯>？"
	line "@"
	text_ram wStringBuffer1
	text "じゃ　ないよ"
	cont "ちぇっ　ざんねんだなあ<⋯>"
	done

Overdump_NPCTradeCompleteText1:
	text "やったあ！"
	line "@"
	text_ram wStringBuffer1
	text "<GA>てにはいった！"
	cont "サンキュー！"
	done

Overdump_NPCTradeAfterText1:
	text "やあっ！"
	line "ボクと　とりかえた　@"
	text_ram wStringBuffer2
	text_start
	cont "げんき？"
	done

Overdump_NPCTradeIntroText2:
	text "なあ　きみ<⋯>"
	line "さがしてる　#<GA>いるんだ"

	para "もし　@"
	text_ram wStringBuffer1
	text "を　もってたら"
	line "わしの　@"
	text_ram wStringBuffer2
	text "と"
	cont "こうかん　してくれないか？"
	done

Overdump_NPCTradeCancelText2:
	text "キミも　もってないのか<⋯>"
	line "ざんねんだなあ<⋯>"
	done

Overdump_NPCTradeWrongText2:
	text_ram wStringBuffer1
	text "を　もってないのか？"
	line "じゃあ　しょうがないね<⋯>"
	done

Overdump_NPCTradeCompleteText2:
	text "おお！"
	line "ありがとう！"

	para "やっと　@"
	text_ram wStringBuffer1
	text "が"
	line "てに　はいったよ！"
	done

Overdump_NPCTradeAfterText2:
	text "おお！"

	para "キミから　もらった@"
	text_ram wMonOrItemNameBuffer
	text "は"
	line "すごく　げんきだよ！"
	done

Overdump_NPCTradeIntroText3:
	text_ram wMonOrItemNameBuffer
	text "って　かわいいわよね！"
	line "でも　わたし　もってないの<⋯>"
	cont "あなた　@"
	text_ram wStringBuffer1
	text "　もってる？"

	para "わたしの　@"
	text_ram wStringBuffer2
	text "と"
	line "こうかん　しましょうよ！"
	done

Overdump_NPCTradeCancelText3:
	text "こうかんして　くれないの？"
	line "えーっ<⋯>　がっかり<⋯>"
	done

Overdump_NPCTradeWrongText3:
	text_ram wStringBuffer1
	text "じゃ　ないわよ　それ"
	line "つかまえたら　とりかえてね！"
	done

Overdump_NPCTradeCompleteText3:
	text "わあ！　ありがとうっ！"
	line "@"
	text_ram wMonOrItemNameBuffer
	text "　ほしかったのっ！"
	done

Overdump_NPCTradeAfterText3:
	text "こうかんした　@"
	text_ram wStringBuffer2
	text "　げんき？"
	line "@"
	text_ram wMonOrItemNameBuffer
	text "は　すっごく　かわいいわ！"
	done

rsreset
DEF MOMITEM_TRIGGER rb 3 ; 0
DEF MOMITEM_COST    rb 3 ; 3
DEF MOMITEM_KIND    rb   ; 6
DEF MOMITEM_ITEM    rb   ; 7
DEF MOMITEM_SIZE EQU _RS ; 8

	const_def 1
	const MOM_ITEM
	const MOM_DOLL

Overdump_MomTriesToBuySomething::
	ld a, [wMapReentryScriptQueueFlag]
	and a
	ret nz
	call $2e38 ; GetMapPhoneService
	and a
	ret nz
	xor a
	ld [wWhichMomItemSet], a
	call Overdump_CheckBalance_MomItem2
	ret nc
	call Overdump_Mom_GiveItemOrDoll
	ret nc
	ld b, BANK(.Script)
	ld de, .Script
	ld a, BANK(LoadMemScript)
	ld hl, $7aca ; LoadMemScript
	rst FarCall
	scf
	ret

.Script:
	callasm .ASMFunction
	farsjump Script_ReceivePhoneCall

.ASMFunction:
	call Overdump_MomBuysItem_DeductFunds
	call Overdump_Mom_GetScriptPointer
	ld a, [wWhichMomItemSet]
	and a
	jr nz, .ok
	ld hl, wWhichMomItem
	inc [hl]
.ok
	ld a, PHONE_MOM
	ld [wCurCaller], a
	ld bc, wCallerContact
	ld hl, PHONE_CONTACT_TRAINER_CLASS
	add hl, bc
	ld [hl], TRAINER_NONE
	inc hl
	ld [hl], PHONE_MOM
	ld hl, PHONE_CONTACT_SCRIPT2_BANK
	add hl, bc
	ld a, BANK(Overdump_Mom_GetScriptPointer)
	ld [hli], a
	ld a, e
	ld [hli], a
	ld a, d
	ld [hl], a
	ret

Overdump_CheckBalance_MomItem2:
	ld a, [wWhichMomItem]
	cp (Overdump_MomItems_2.End - Overdump_MomItems_2) / MOMITEM_SIZE
	jr nc, .nope
	call Overdump_GetItemFromMom
	assert MOMITEM_TRIGGER == 0
	ld a, [hli]
	ldh [hMoneyTemp], a
	ld a, [hli]
	ldh [hMoneyTemp + 1], a
	ld a, [hli]
	ldh [hMoneyTemp + 2], a
	ld de, wMomsMoney
	ld bc, hMoneyTemp
	farcall CompareMoney
	jr nc, .have_enough_money

.nope
	jr .check_have_2300

.have_enough_money
	scf
	ret

.check_have_2300
	ld hl, hMoneyTemp
	ld [hl], HIGH(MOM_MONEY >> 8)
	inc hl
	ld [hl], HIGH(MOM_MONEY) ; mid
	inc hl
	ld [hl], LOW(MOM_MONEY)
.loop
	ld de, wMomItemTriggerBalance
	ld bc, wMomsMoney
	farcall CompareMoney
	jr z, .exact
	jr nc, .less_than
	call .AddMoney
	jr .loop

.less_than
	xor a
	ret

.exact
	call .AddMoney
	ld a, (Overdump_MomItems_1.End - Overdump_MomItems_1) / MOMITEM_SIZE
	call $3127 ; RandomRange
	inc a
	ld [wWhichMomItemSet], a
	scf
	ret

.AddMoney:
	ld de, wMomItemTriggerBalance
	ld bc, hMoneyTemp
	farcall AddMoney
	ret

Overdump_MomBuysItem_DeductFunds:
	call Overdump_GetItemFromMom
	ld de, MOMITEM_COST
	add hl, de
	ld a, [hli]
	ldh [hMoneyTemp], a
	ld a, [hli]
	ldh [hMoneyTemp + 1], a
	ld a, [hli]
	ldh [hMoneyTemp + 2], a
	ld de, wMomsMoney
	ld bc, hMoneyTemp
	farcall TakeMoney
	ret

Overdump_Mom_GiveItemOrDoll:
	call Overdump_GetItemFromMom
	ld de, MOMITEM_KIND
	add hl, de
	ld a, [hli]
	cp MOM_ITEM
	jr z, .not_doll
	assert MOMITEM_KIND + 1 == MOMITEM_ITEM
	ld a, [hl]
	ld c, a
	ld b, 1
	ld a, BANK(DecorationFlagAction_c)
	ld hl, $7428 ; DecorationFlagAction_c
	rst FarCall
	scf
	ret

.not_doll
	ld a, [hl]
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantityChange], a
	ld hl, wNumPCItems
	call $30dc ; ReceiveItem
	ret

Overdump_Mom_GetScriptPointer:
	call Overdump_GetItemFromMom
	ld de, MOMITEM_KIND
	add hl, de
	ld a, [hli]
	ld de, .ItemScript
	cp MOM_ITEM
	ret z
	ld de, .DollScript
	ret

.ItemScript:
	writetext Overdump_MomHiHowAreYouText
	writetext Overdump_MomFoundAnItemText
	writetext Overdump_MomBoughtWithYourMoneyText
	writetext Overdump_MomItsInPCText
	end

.DollScript:
	writetext Overdump_MomHiHowAreYouText
	writetext Overdump_MomFoundADollText
	writetext Overdump_MomBoughtWithYourMoneyText
	writetext Overdump_MomItsInYourRoomText
	end

Overdump_GetItemFromMom:
	ld a, [wWhichMomItemSet]
	and a
	jr z, .zero
	dec a
	ld de, Overdump_MomItems_1
	jr .GetFromList1

.zero
	ld a, [wWhichMomItem]
	cp (Overdump_MomItems_2.End - Overdump_MomItems_2) / MOMITEM_SIZE
	jr c, .ok
	xor a

.ok
	ld de, Overdump_MomItems_2

.GetFromList1:
	ld l, a
	ld h, 0
	assert MOMITEM_SIZE == 8
rept 3
	add hl, hl
endr
	add hl, de
	ret

MACRO momitem
	bigdt \1, \2
	db \3, \4
ENDM

Overdump_MomItems_1:
	momitem      0,   600, MOM_ITEM, SUPER_POTION
	momitem      0,    90, MOM_ITEM, ANTIDOTE
	momitem      0,   180, MOM_ITEM, POKE_BALL
	momitem      0,   450, MOM_ITEM, ESCAPE_ROPE
	momitem      0,   500, MOM_ITEM, GREAT_BALL
.End

Overdump_MomItems_2:
	momitem    900,   600, MOM_ITEM, SUPER_POTION
	momitem   4000,   270, MOM_ITEM, REPEL
	momitem   7000,   600, MOM_ITEM, SUPER_POTION
	momitem  10000,  1800, MOM_DOLL, DECO_CHARMANDER_DOLL
	momitem  15000,  3000, MOM_ITEM, MOON_STONE
	momitem  19000,   600, MOM_ITEM, SUPER_POTION
	momitem  30000,  4800, MOM_DOLL, DECO_CLEFAIRY_DOLL
	momitem  40000,   900, MOM_ITEM, HYPER_POTION
	momitem  50000,  8000, MOM_DOLL, DECO_PIKACHU_DOLL
	momitem 100000, 22800, MOM_DOLL, DECO_BIG_SNORLAX_DOLL
.End

	bigdt 0

Overdump_MomHiHowAreYouText:
	text "もしもし"
	line "<PLAYER>　げんき？"
	prompt

Overdump_MomFoundAnItemText:
	text "きょう　おかいものに　いったら"
	line "よさそうな　どうぐが　うってたから"
	prompt

Overdump_MomBoughtWithYourMoneyText:
	text "<PLAYER>の　おかねで"
	line "かっちゃった！　ごめんね！"
	prompt

Overdump_MomItsInPCText:
	text "でも　<PC>に　いれておいたから"
	line "つかってね！　きっと　やくにたつわ！"
	done

Overdump_MomFoundADollText:
	text "きょう　おかいものに　いったら"

	para "すっごく　かわいい"
	line "ぬいぐるみが　うってたから<⋯>"
	prompt

Overdump_MomItsInYourRoomText:
	text "でも　へやにおいたから　みてね！"
	line "きっと　きにいると　おもうわ！"
	done

Overdump_StagePartyDataForMysteryGift:
	ld a, BANK(sPokemonData)
	call $3141 ; OpenSRAM
	ld de, wMysteryGiftStaging
	ld bc, sPokemonData + wPartyMons - wPokemonData
	ld hl, sPokemonData + wPartySpecies - wPokemonData
.loop
	ld a, [hli]
	cp -1
	jr z, .party_end
	cp EGG
	jr z, .next
	push hl

	ld hl, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [de], a
	inc de

	ld hl, MON_SPECIES
	add hl, bc
	ld a, [hl]
	ld [de], a
	inc de

	ld hl, MON_MOVES
	add hl, bc
	push bc
	ld bc, NUM_MOVES
	call $317a ; CopyBytes
	pop bc
	pop hl
.next
	push hl
	ld hl, PARTYMON_STRUCT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	jr .loop
.party_end
	ld a, -1
	ld [de], a
	ld a, wMysteryGiftTrainerEnd - wMysteryGiftTrainer
	ld [wUnusedMysteryGiftStagedDataLength], a
	jp $3151 ; CloseSRAM

Overdump_InitMysteryGiftLayout:
	call $344f ; ClearBGPalettes
	call DisableLCD
	ld hl, Overdump_MysteryGiftGFX
	ld de, vTiles2 tile $00
	ld a, BANK(Overdump_MysteryGiftGFX)
	ld bc, $20 tiles
	call FarCopyBytes
	farcall LoadMysteryGiftBackgroundGFX
	farcall LoadMysteryGiftGFX2
	ld hl, vTiles2 tile $3d
	ld a, $ff
	ld bc, 1 tiles
	call $31ac ; ByteFill
	hlcoord 0, 0
	ld a, $3d
	ld bc, SCREEN_AREA
	call $31ac ; ByteFill
	hlcoord 3, 7
	lb bc, 9, 15
	call ClearBox
	hlcoord 0, 0
	ld a, $1e
	ld [hli], a
	inc a
	ld [hl], a
	hlcoord 0, 1
	ld a, $33
	ld [hli], a
	inc a
	ld [hl], a
	hlcoord 3, 1
	ld a, 0
	call .Load15GFX
	hlcoord 3, 2
	ld a, $f
	call .Load15GFX
	hlcoord 8, 0
	ld a, $20
	call .Load4GFX
	hlcoord 9, 3
	ld a, $24
	call .Load3GFX
	hlcoord 9, 4
	ld [hl], $27
	hlcoord 1, 2
	ld a, $2e
	call .Load15Column
	hlcoord 18, 5
	ld a, $2a
	call .Load11Column
	hlcoord 2, 5
	ld a, $28
	call .Load16Row
	hlcoord 2, 16
	ld a, $2c
	call .Load16Row
	hlcoord 2, 5
	ld a, $35
	call .Load4GFX
	hlcoord 18, 5
	ld [hl], $29
	hlcoord 18, 16
	ld [hl], $2b
	hlcoord 1, 16
	ld [hl], $2d
	hlcoord 2, 6
	ld a, $39
	call .Load16Row
	hlcoord 2, 15
	ld a, $3b
	call .Load16Row
	hlcoord 2, 6
	ld a, $3c
	call .Load9Column
	hlcoord 17, 6
	ld a, $3a
	call .Load9Column
	hlcoord 2, 6
	ld [hl], $2f
	hlcoord 17, 6
	ld [hl], $30
	hlcoord 2, 15
	ld [hl], $32
	hlcoord 17, 15
	ld [hl], $31
	call EnableLCD
	call $3452 ; WaitBGMap
	ld b, SCGB_MYSTERY_GIFT
	call $3589 ; GetSGBLayout
	jp $354c ; SetDefaultBGPAndOBP

.Load3GFX:
	ld b, 3
	jr .gfx_loop

.Load4GFX:
	ld b, 4
	jr .gfx_loop

.Load15GFX:
	ld b, 15

.gfx_loop
	ld [hli], a
	inc a
	dec b
	jr nz, .gfx_loop
	ret

.Load9Column:
	ld b, 9
	jr .col_loop

.Load11Column:
	ld b, 11
	jr .col_loop

.Load15Column:
	ld b, 15

.col_loop
	ld [hl], a
	ld de, SCREEN_WIDTH
	add hl, de
	dec b
	jr nz, .col_loop
	ret

.Load16Row:
	ld b, 16
.row_loop
	ld [hli], a
	dec b
	jr nz, .row_loop
	ret

Overdump_MysteryGiftGFX:
INCBIN "gfx/mystery_gift/mystery_gift.2bpp"

	const_def $6a
	const DEBUGTEST_TICKS_1 ; $6a
	const DEBUGTEST_TICKS_2 ; $6b
	const DEBUGTEST_WHITE   ; $6c
	const DEBUGTEST_LIGHT   ; $6d
	const DEBUGTEST_DARK    ; $6e
	const DEBUGTEST_BLACK   ; $6f
	const DEBUGTEST_0       ; $70
	const DEBUGTEST_1       ; $71
	const DEBUGTEST_2       ; $72
	const DEBUGTEST_3       ; $73
	const DEBUGTEST_4       ; $74
	const DEBUGTEST_5       ; $75
	const DEBUGTEST_6       ; $76
	const DEBUGTEST_7       ; $77
	const DEBUGTEST_8       ; $78
	const DEBUGTEST_9       ; $79
	const DEBUGTEST_A       ; $7a
	const DEBUGTEST_B       ; $7b
	const DEBUGTEST_C       ; $7c
	const DEBUGTEST_D       ; $7d
	const DEBUGTEST_E       ; $7e
	const DEBUGTEST_F       ; $7f

	const_def
	const DEBUGCOLORMAIN_INITSCREEN     ; 0
	const DEBUGCOLORMAIN_UPDATESCREEN   ; 1
	const DEBUGCOLORMAIN_UPDATEPALETTES ; 2
	const DEBUGCOLORMAIN_JOYPAD         ; 3
	const DEBUGCOLORMAIN_INITTMHM       ; 4
	const DEBUGCOLORMAIN_TMHMJOYPAD     ; 5

Overdump_DebugColorPicker:
	ldh a, [hCGB]
	and a
	jr nz, .cgb
	ldh a, [hSGB]
	and a
	ret z

.cgb
	ldh a, [hInMenu]
	push af
	ld a, TRUE
	ldh [hInMenu], a

	call DisableLCD
	call Overdump_DebugColor_InitVRAM
	call Overdump_DebugColor_LoadGFX
	call Overdump_DebugColor_InitPalettes
	call Overdump_DebugColor_InitMonOrTrainerColor
	call EnableLCD
	ld de, MUSIC_NONE
	call $3d5d ; PlayMusic

	xor a
	ld [wJumptableIndex], a
	ld [wDebugColorCurMon], a
	ld [wDebugColorIsShiny], a
.loop
	ld a, [wJumptableIndex]
	bit JUMPTABLE_EXIT_F, a
	jr nz, .exit
	call Overdump_DebugColorMain
	call Overdump_DebugColor_PlaceCursor
	call DelayFrame
	jr .loop

.exit
	pop af
	ldh [hInMenu], a
	ret

Overdump_DebugColor_InitMonOrTrainerColor:
	ld a, [wDebugColorIsTrainer]
	and a
	jr nz, Overdump_DebugColor_InitTrainerColor
	ld hl, PokemonPalettes
	; fallthrough

Overdump_DebugColor_InitMonColor:
	ld de, wDebugOriginalColors
	ld c, NUM_POKEMON + 1
.loop
	push bc
	push hl
	call Overdump_DebugColor_InitColor
	pop hl
	ld bc, 8
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ret

Overdump_DebugColor_InitTrainerColor:
	ld hl, TrainerPalettes
	ld de, wDebugOriginalColors
	ld c, NUM_TRAINER_CLASSES + 1
.loop
	push bc
	push hl
	call Overdump_DebugColor_InitColor
	pop hl
	ld bc, 4
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ret

Overdump_DebugColor_InitColor:
rept 3
	ld a, BANK(PokemonPalettes) ; aka BANK(TrainerPalettes)
	call $3188 ; GetFarByte
	ld [de], a
	inc de
	inc hl
endr
	ld a, BANK(PokemonPalettes) ; aka BANK(TrainerPalettes)
	call $3188 ; GetFarByte
	ld [de], a
	inc de
	ret

Overdump_DebugColor_InitVRAM:
	ld a, $1
	ldh [rVBK], a
	ld hl, STARTOF(VRAM)
	ld bc, SIZEOF(VRAM)
	xor a
	call $31ac ; ByteFill

	ld a, $0
	ldh [rVBK], a
	ld hl, STARTOF(VRAM)
	ld bc, SIZEOF(VRAM)
	xor a
	call $31ac ; ByteFill

	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_AREA
	xor a
	call $31ac ; ByteFill

	hlcoord 0, 0
	ld bc, SCREEN_AREA
	xor a
	call $31ac ; ByteFill

	call $315f ; ClearSprites
	ret

Overdump_DebugColor_LoadGFX:
	ld hl, Overdump_DebugColor_GFX
	ld de, vTiles2 tile DEBUGTEST_TICKS_1
	ld bc, 22 tiles
	call $317a ; CopyBytes

	ld hl, Overdump_DebugColor_UpArrowGFX
	ld de, vTiles0
	ld bc, 1 tiles
	call $317a ; CopyBytes

	call LoadStandardFont
	ld hl, vTiles1
	ld bc, $80 tiles
.loop
	ld a, [hl]
	xor $ff
	ld [hli], a
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ret

Overdump_DebugColor_InitPalettes:
	ldh a, [hCGB]
	and a
	ret z

	ld hl, Overdump_Palette_DebugBG
	ld de, wBGPals2
	ld bc, 16 palettes
	call $317a ; CopyBytes

	ld a, BGPI_AUTOINC
	ldh [rBGPI], a
	ld hl, Overdump_Palette_DebugBG
	ld c, 8 palettes
	xor a
.bg_loop
	ldh [rBGPD], a
	dec c
	jr nz, .bg_loop

	ld a, OBPI_AUTOINC
	ldh [rOBPI], a
	ld hl, Overdump_Palette_DebugOB
	ld c, 8 palettes
.ob_loop
	ld a, [hli]
	ldh [rOBPD], a
	dec c
	jr nz, .ob_loop

	ld a, LOW(palred 20 + palgreen 20 + palblue 20)
	ld [wDebugLightColor + 0], a
	ld a, HIGH(palred 20 + palgreen 20 + palblue 20)
	ld [wDebugLightColor + 1], a
	ld a, LOW(palred 10 + palgreen 10 + palblue 10)
	ld [wDebugDarkColor + 0], a
	ld a, HIGH(palred 10 + palgreen 10 + palblue 10)
	ld [wDebugDarkColor + 1], a
	ret

Overdump_Palette_DebugBG:
INCLUDE "gfx/debug/bg.pal"

Overdump_Palette_DebugOB:
INCLUDE "gfx/debug/ob.pal"

Overdump_DebugColorMain:
	call JoyTextDelay
	ld a, [wJumptableIndex]
	cp DEBUGCOLORMAIN_INITTMHM
	jr nc, .no_start_select
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_SELECT
	jr nz, .NextMon
	ld a, [hl]
	and PAD_START
	jr nz, .PreviousMon

.no_start_select
	jumptable .Jumptable, wJumptableIndex

.NextMon:
	call Overdump_DebugColor_BackupSpriteColors
	call .SetMaxNum
	ld e, a
	ld a, [wDebugColorCurMon]
	inc a
	cp e
	jr c, .SwitchMon
	xor a
	jr .SwitchMon

.PreviousMon:
	call Overdump_DebugColor_BackupSpriteColors
	ld a, [wDebugColorCurMon]
	dec a
	cp -1
	jr nz, .SwitchMon
	call .SetMaxNum
	dec a

.SwitchMon:
	ld [wDebugColorCurMon], a
	ld a, DEBUGCOLORMAIN_INITSCREEN
	ld [wJumptableIndex], a
	ret

.SetMaxNum:
	ld a, [wDebugColorIsTrainer]
	and a
	jr nz, .trainer
; mon
	ld a, NUM_POKEMON
	ret
.trainer
	ld a, NUM_TRAINER_CLASSES
	ret

.Jumptable:
	dw Overdump_DebugColor_InitScreen
	dw Overdump_DebugColor_UpdateScreen
	dw Overdump_DebugColor_UpdatePalettes
	dw Overdump_DebugColor_Joypad
	dw Overdump_DebugColor_InitTMHM
	dw Overdump_DebugColor_TMHMJoypad

Overdump_DebugColor_InitScreen:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, SCREEN_AREA
	ld a, DEBUGTEST_BLACK
	call $31ac ; ByteFill
	hlcoord 1, 3
	lb bc, 7, 18
	ld a, DEBUGTEST_WHITE
	call Overdump_DebugColor_FillBoxWithByte
	hlcoord 11, 0
	lb bc, 2, 3
	ld a, DEBUGTEST_LIGHT
	call Overdump_DebugColor_FillBoxWithByte
	hlcoord 16, 0
	lb bc, 2, 3
	ld a, DEBUGTEST_DARK
	call Overdump_DebugColor_FillBoxWithByte
	call Overdump_DebugColor_LoadRGBMeter
	call Overdump_DebugColor_SetRGBMeter
	ld a, [wDebugColorCurMon]
	inc a
	ld [wCurPartySpecies], a
	ld [wTextDecimalByte], a
	hlcoord 0, 1
	ld de, wTextDecimalByte
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call $329d ; PrintNum
	ld a, [wDebugColorIsTrainer]
	and a
	jr nz, .trainer

; mon
	ld a, UNOWN_A
	ld [wUnownLetter], a
	call $3684 ; GetPokemonName
	hlcoord 4, 1
	call PlaceString
	xor a
	ld [wBoxAlignment], a
	hlcoord 2, 3
	call $39c7 ; _PrepMonFrontpic
	ld de, vTiles2 tile $31
	predef_overdump GetMonBackpic
	ld a, $31
	ldh [hGraphicStartTile], a
	hlcoord 12, 4
	lb bc, 6, 6
	predef_overdump PlaceGraphic

	ld a, [wDebugColorIsShiny]
	and a
	jr z, .normal
; shiny
	ld de, .ShinyText
	jr .place_text
.normal
	ld de, .NormalText
.place_text
	hlcoord 7, 17
	call PlaceString
	hlcoord 0, 17
	ld de, .SwitchText
	call PlaceString
	jr .done

.trainer
	ld a, [wTextDecimalByte]
	ld [wTrainerClass], a
	callfar GetTrainerAttributes
	ld de, wStringBuffer1
	hlcoord 4, 1
	call PlaceString
	ld de, vTiles2
	ld hl, $586b ; GetTrainerPic
	ld a, BANK(GetTrainerPic)
	rst FarCall
	xor a
	ld [wTempEnemyMonSpecies], a
	ldh [hGraphicStartTile], a
	hlcoord 2, 3
	lb bc, 7, 7
	predef_overdump PlaceGraphic

.done
	ld a, DEBUGCOLORMAIN_UPDATESCREEN
	ld [wJumptableIndex], a
	ret

.ShinyText:
	db "レア", DEBUGTEST_BLACK, DEBUGTEST_BLACK, "@"

.NormalText:
	db "ノーマル@"

.SwitchText:
	db DEBUGTEST_A, "きりかえ▶@"

Overdump_DebugColor_LoadRGBMeter:
	decoord 0, 11, wAttrmap
	hlcoord 2, 11
	ld a, 1
	call .load_meter
	decoord 0, 13, wAttrmap
	hlcoord 2, 13
	ld a, 2
	call .load_meter
	decoord 0, 15, wAttrmap
	hlcoord 2, 15
	ld a, 3
.load_meter:
	push af
	ld a, DEBUGTEST_TICKS_1
	ld [hli], a
	ld bc, 15
	ld a, DEBUGTEST_TICKS_2
	call $31ac ; ByteFill
	ld l, e
	ld h, d
	pop af
	ld bc, 20 * 2
	call $31ac ; ByteFill
	ret

Overdump_DebugColor_SetRGBMeter:
	ld a, [wDebugColorCurMon]
	inc a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, wDebugOriginalColors
	add hl, de
	ld de, wDebugMiddleColors
	ld bc, 4
	call $317a ; CopyBytes
	xor a
	ld [wDebugColorRGBJumptableIndex], a
	ld [wDebugColorCurColor], a
	ld de, wDebugLightColor
	call Overdump_DebugColor_CalculateRGB
	ret

Overdump_DebugColor_UpdateScreen:
	ldh a, [hCGB]
	and a
	jr z, .sgb

	ld a, 2
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call DelayFrame

.sgb
	call $3452 ; WaitBGMap

	ld a, DEBUGCOLORMAIN_UPDATEPALETTES
	ld [wJumptableIndex], a
	ret

Overdump_DebugColor_UpdatePalettes:
	ldh a, [hCGB]
	and a
	jr z, .sgb

; cgb
	ld hl, wBGPals2
	ld de, wDebugMiddleColors
	ld c, 1
	call Overdump_DebugColor_LoadPalettes_White_Col1_Col2_Black

	hlcoord 10, 2
	ld de, wDebugLightColor
	call Overdump_DebugColor_PrintHexColor
	hlcoord 15, 2
	ld de, wDebugDarkColor
	call Overdump_DebugColor_PrintHexColor

	ld a, TRUE
	ldh [hCGBPalUpdate], a

	ld a, DEBUGCOLORMAIN_JOYPAD
	ld [wJumptableIndex], a
	ret

.sgb
	ld hl, wSGBPals
	ld a, 1
	ld [hli], a
	ld a, LOW(PALRGB_WHITE)
	ld [hli], a
	ld a, HIGH(PALRGB_WHITE)
	ld [hli], a
	ld a, [wDebugLightColor + 0]
	ld [hli], a
	ld a, [wDebugLightColor + 1]
	ld [hli], a
	ld a, [wDebugDarkColor + 0]
	ld [hli], a
	ld a, [wDebugDarkColor + 1]
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld hl, wSGBPals
	call Overdump_DebugColor_PushSGBPals

	hlcoord 10, 2
	ld de, wDebugLightColor
	call Overdump_DebugColor_PrintHexColor
	hlcoord 15, 2
	ld de, wDebugDarkColor
	call Overdump_DebugColor_PrintHexColor

	ld a, DEBUGCOLORMAIN_JOYPAD
	ld [wJumptableIndex], a
	ret

Overdump_DebugColor_PrintHexColor:
	inc hl
	inc hl
	inc hl
	ld a, [de]
	call .place_tile
	ld a, [de]
	swap a
	call .place_tile
	inc de
	ld a, [de]
	call .place_tile
	ld a, [de]
	swap a
.place_tile:
	and $f
	add DEBUGTEST_0
	ld [hld], a
	ret

Overdump_DebugColor_Joypad:
	ldh a, [hJoyLast]
	and PAD_B
	jr nz, .tmhm
	ldh a, [hJoyLast]
	and PAD_A
	jr nz, .toggle_shiny

	ld a, [wDebugColorRGBJumptableIndex]
	maskbits 4
	ld e, a
	ld d, 0
	ld hl, .PointerTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.tmhm
	ld a, DEBUGCOLORMAIN_INITTMHM
	ld [wJumptableIndex], a
	ret

.toggle_shiny
	ld a, [wDebugColorIsTrainer]
	and a
	ret nz

	ld a, [wDebugColorIsShiny]
	xor %00000100
	ld [wDebugColorIsShiny], a
	ld c, a
	ld b, 0
	ld hl, PokemonPalettes
	add hl, bc
	call Overdump_DebugColor_InitMonColor

	ld a, DEBUGCOLORMAIN_INITSCREEN
	ld [wJumptableIndex], a
	ret

.PointerTable:
	dw Overdump_DebugColor_SelectColorBox
	dw Overdump_DebugColor_ChangeRedValue
	dw Overdump_DebugColor_ChangeGreenValue
	dw Overdump_DebugColor_ChangeBlueValue

Overdump_DebugColor_SelectColorBox:
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_DOWN
	jr nz, Overdump_DebugColor_NextRGBColor
	ld a, [hl]
	and PAD_LEFT
	jr nz, .light
	ld a, [hl]
	and PAD_RIGHT
	jr nz, .dark
	ret

.light
	xor a
	ld [wDebugColorCurColor], a
	ld de, wDebugLightColor
	call Overdump_DebugColor_CalculateRGB
	ret

.dark
	ld a, TRUE
	ld [wDebugColorCurColor], a
	ld de, wDebugDarkColor
	call Overdump_DebugColor_CalculateRGB
	ret

Overdump_DebugColor_ChangeRedValue:
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_DOWN
	jr nz, Overdump_DebugColor_NextRGBColor
	ld a, [hl]
	and PAD_UP
	jr nz, Overdump_DebugColor_PreviousRGBColor
	ld hl, wDebugRedChannel
	jr Overdump_DebugColor_UpdateRGBColor

Overdump_DebugColor_ChangeGreenValue:
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_DOWN
	jr nz, Overdump_DebugColor_NextRGBColor
	ld a, [hl]
	and PAD_UP
	jr nz, Overdump_DebugColor_PreviousRGBColor
	ld hl, wDebugGreenChannel
	jr Overdump_DebugColor_UpdateRGBColor

Overdump_DebugColor_ChangeBlueValue:
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_UP
	jr nz, Overdump_DebugColor_PreviousRGBColor
	ld hl, wDebugBlueChannel
	; fallthrough

Overdump_DebugColor_UpdateRGBColor:
	ldh a, [hJoyLast]
	and PAD_RIGHT
	jr nz, .increment
	ldh a, [hJoyLast]
	and PAD_LEFT
	jr nz, .decrement
	ret

.increment
	ld a, [hl]
	cp 31
	ret nc
	inc [hl]
	jr .done

.decrement
	ld a, [hl]
	and a
	ret z
	dec [hl]

.done
	call Overdump_DebugColor_CalculatePalette
	ld a, DEBUGCOLORMAIN_UPDATEPALETTES
	ld [wJumptableIndex], a
	ret

Overdump_DebugColor_PreviousRGBColor:
	ld hl, wDebugColorRGBJumptableIndex
	dec [hl]
	ret

Overdump_DebugColor_NextRGBColor:
	ld hl, wDebugColorRGBJumptableIndex
	inc [hl]
	ret

Overdump_DebugColor_InitTMHM:
	hlcoord 0, 10
	ld bc, SCREEN_WIDTH * 8
	ld a, DEBUGTEST_BLACK
	call $31ac ; ByteFill
	hlcoord 2, 12
	ld de, Overdump_DebugColor_AreYouFinishedString
	call PlaceString
	xor a
	ld [wDebugColorCurTMHM], a
	call Overdump_DebugColor_PrintTMHMMove
	ld a, DEBUGCOLORMAIN_TMHMJOYPAD
	ld [wJumptableIndex], a
	ret

Overdump_DebugColor_TMHMJoypad:
	ld hl, hJoyPressed
	ld a, [hl]
	and PAD_B
	jr nz, .cancel
	call .scroll
	ret

.cancel
	ld a, DEBUGCOLORMAIN_INITSCREEN
	ld [wJumptableIndex], a
	ret

.exit
	ld hl, wJumptableIndex
	set JUMPTABLE_EXIT_F, [hl]
	ret

.scroll:
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_UP
	jr nz, .up
	ld a, [hl]
	and PAD_DOWN
	jr nz, .down
	ret

.up
	ld a, [wDebugColorCurTMHM]
	cp NUM_TM_HM - 1
	jr z, .wrap_down
	inc a
	jr .done

.wrap_down
	xor a
	jr .done

.down
	ld a, [wDebugColorCurTMHM]
	and a
	jr z, .wrap_up
	dec a
	jr .done

.wrap_up
	ld a, NUM_TM_HM - 1

.done
	ld [wDebugColorCurTMHM], a
	call Overdump_DebugColor_PrintTMHMMove
	ret

Overdump_DebugColor_PrintTMHMMove:
	hlcoord 10, 11
	call .ClearRow
	hlcoord 10, 12
	call .ClearRow
	hlcoord 10, 13
	call .ClearRow
	hlcoord 10, 14
	call .ClearRow

	ld a, [wDebugColorCurTMHM]
	inc a
	ld [wTempTMHM], a
	predef_overdump GetTMHMMove
	ld a, [wTempTMHM]
	ld [wPutativeTMHMMove], a
	call $3745 ; GetMoveName
	hlcoord 10, 12
	call PlaceString

	ld a, [wDebugColorCurTMHM]
	call .GetNumberedTMHM
	ld [wCurItem], a
	predef_overdump CanLearnTMHMMove
	ld a, c
	and a
	ld de, .AbleText
	jr nz, .place_string
	ld de, .NotAbleText
.place_string
	hlcoord 10, 14
	call PlaceString
	ret

.AbleText:
	db "おぼえられる@"

.NotAbleText:
	db "おぼえられない@"

.GetNumberedTMHM:
	cp NUM_TMS
	jr c, .tm
; hm - skip two gap items
	inc a
	inc a
.tm
	add TM01
	ret

.ClearRow:
	ld bc, 10
	ld a, DEBUGTEST_BLACK
	call $31ac ; ByteFill
	ret

Overdump_DebugColor_CalculatePalette:
	ld a, [wDebugRedChannel]
	and %00011111
	ld e, a
	ld a, [wDebugGreenChannel]
	and %00000111
	sla a
	swap a
	or e
	ld e, a
	ld a, [wDebugGreenChannel]
	and %00011000
	sla a
	swap a
	ld d, a
	ld a, [wDebugBlueChannel]
	and %00011111
	sla a
	sla a
	or d
	ld d, a
	ld a, [wDebugColorCurColor]
	and a
	jr z, .light

; dark
	ld a, e
	ld [wDebugDarkColor + 0], a
	ld a, d
	ld [wDebugDarkColor + 1], a
	ret

.light
	ld a, e
	ld [wDebugLightColor + 0], a
	ld a, d
	ld [wDebugLightColor + 1], a
	ret

Overdump_DebugColor_CalculateRGB:
	ld a, [de]
	and %00011111
	ld [wDebugRedChannel], a
	ld a, [de]
	and %11100000
	swap a
	srl a
	ld b, a
	inc de
	ld a, [de]
	and %00000011
	swap a
	srl a
	or b
	ld [wDebugGreenChannel], a
	ld a, [de]
	and %01111100
	srl a
	srl a
	ld [wDebugBlueChannel], a
	ret

Overdump_DebugColor_BackupSpriteColors:
	ld a, [wDebugColorCurMon]
	inc a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, wDebugOriginalColors
	add hl, de
	ld e, l
	ld d, h
	ld hl, wDebugMiddleColors
	ld bc, 4
	call $317a ; CopyBytes
	ret

Overdump_DebugColor_LoadPalettes_White_Col1_Col2_Black:
.loop
	ld a, LOW(PALRGB_WHITE)
	ld [hli], a
	ld a, HIGH(PALRGB_WHITE)
	ld [hli], a
rept 4
	ld a, [de]
	inc de
	ld [hli], a
endr
	xor a
	ld [hli], a
	ld [hli], a
	dec c
	jr nz, .loop
	ret

Overdump_DebugColor_FillBoxWithByte:
.row
	push bc
	push hl
.col
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

Overdump_DebugColor_PushSGBPals:
	ld a, [wJoypadDisable]
	push af
	set JOYPAD_DISABLE_SGB_TRANSFER_F, a
	ld [wJoypadDisable], a
	call Overdump__DebugColor_PushSGBPals
	pop af
	ld [wJoypadDisable], a
	ret

Overdump__DebugColor_PushSGBPals:
	ld a, [hl]
	and $7
	ret z
	ld b, a
.loop
	push bc
	xor a
	ldh [rJOYP], a
	ld a, JOYP_SGB_FINISH
	ldh [rJOYP], a
	ld b, 16
.loop2
	ld e, 8
	ld a, [hli]
	ld d, a
.loop3
	bit 0, d
	ld a, JOYP_SGB_ONE
	jr nz, .okay
	ld a, JOYP_SGB_ZERO
.okay
	ldh [rJOYP], a
	ld a, JOYP_SGB_FINISH
	ldh [rJOYP], a
	rr d
	dec e
	jr nz, .loop3
	dec b
	jr nz, .loop2
	ld a, JOYP_SGB_ZERO
	ldh [rJOYP], a
	ld a, JOYP_SGB_FINISH
	ldh [rJOYP], a
	ld de, 7000
.wait
	nop
	nop
	nop
	dec de
	ld a, d
	or e
	jr nz, .wait
	pop bc
	dec b
	jr nz, .loop
	ret

Overdump_DebugColor_PlaceCursor:
	ld a, DEBUGTEST_BLACK
	hlcoord 10, 0
	ld [hl], a
	hlcoord 15, 0
	ld [hl], a
	hlcoord 1, 11
	ld [hl], a
	hlcoord 1, 13
	ld [hl], a
	hlcoord 1, 15
	ld [hl], a

	ld a, [wJumptableIndex]
	cp DEBUGCOLORMAIN_JOYPAD
	jr nz, .clearsprites

	ld a, [wDebugColorRGBJumptableIndex]
	and a
	jr z, .place_cursor
	dec a
	hlcoord 1, 11
	ld bc, 2 * SCREEN_WIDTH
	call $3203 ; AddNTimes
	ld [hl], '▶'

.place_cursor
	ld a, [wDebugColorCurColor]
	and a
	jr z, .light
; dark
	hlcoord 15, 0
	jr .place
.light
	hlcoord 10, 0
.place
	ld [hl], '▶'

	ld b, $70
	ld c, 5
	ld hl, wShadowOAM
	ld de, wDebugRedChannel
	call .placesprite
	ld de, wDebugGreenChannel
	call .placesprite
	ld de, wDebugBlueChannel
	call .placesprite
	ret

.placesprite:
	ld a, b
	ld [hli], a
	ld a, [de]
	add a
	add a
	add 3 * TILE_WIDTH
	ld [hli], a
	xor a
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, 2 * TILE_WIDTH
	add b
	ld b, a
	inc c
	ret

.clearsprites:
	call $315f ; ClearSprites
	ret

Overdump_DebugColor_AreYouFinishedString:
	db   "おわりますか？"
	next "はい．．．", DEBUGTEST_A
	next "いいえ．．", DEBUGTEST_B
	db   "@"

Overdump_DebugColor_UpArrowGFX:
INCBIN "gfx/debug/up_arrow.2bpp"

Overdump_DebugColor_GFX:
INCBIN "gfx/debug/color_test.2bpp"

Overdump_TilesetColorPicker:
	ldh a, [hCGB]
	and a
	ret z
	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	call .InitMenu
.loop
	call JoyTextDelay
	ldh a, [hJoyLast]
	and PAD_START
	jr nz, .quit
	call Overdump_DebugColorMain2
	ldh a, [hWY]
	cp $90
	call nz, Overdump_DebugTileset_PlaceCursor
	call DelayFrame
	jr .loop
.quit
	ld a, $90
	ldh [hWY], a
	pop af
	ldh [hInMenu], a
	ret

.InitMenu
	xor a
	ld [wJumptableIndex], a
	ld [wDebugTilesetCurPalette], a
	ld [wDebugTilesetRGBJumptableIndex], a
	ld [wDebugTilesetCurColor], a
	ldh [hMapAnims], a
	call $315f ; ClearSprites
	call $1fd5 ; LoadOverworldTilemapAndAttrmapPals
	call $345c ; WaitBGMap2
	xor a
	ldh [hBGMapMode], a
	ld de, Overdump_DebugColor_GFX
	ld hl, vTiles2 tile DEBUGTEST_TICKS_1
	lb bc, BANK(Overdump_DebugColor_GFX), 22
	call Request2bpp
	ld de, Overdump_DebugColor_UpArrowGFX
	ld hl, vTiles1
	lb bc, BANK(Overdump_DebugColor_UpArrowGFX), 1
	call Request2bpp
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	hlcoord 0, 0
	ld bc, SCREEN_AREA
	ld a, DEBUGTEST_BLACK
	call $31ac ; ByteFill
	hlcoord 0, 0, wAttrmap
	ld bc, SCREEN_AREA
	ld a, PAL_BG_TEXT
	call $31ac ; ByteFill
	decoord 1, 1, 0
	ld a, DEBUGTEST_WHITE
	call Overdump_DebugTileset_DrawColorSwatch
	decoord 6, 1, 0
	ld a, DEBUGTEST_LIGHT
	call Overdump_DebugTileset_DrawColorSwatch
	decoord 11, 1, 0
	ld a, DEBUGTEST_DARK
	call Overdump_DebugTileset_DrawColorSwatch
	decoord 16, 1, 0
	ld a, DEBUGTEST_BLACK
	call Overdump_DebugTileset_DrawColorSwatch
	call Overdump_DebugTileset_LoadRGBMeter
	call Overdump_DebugTileset_LoadPalettes
	call $345c ; WaitBGMap2
	ld [wJumptableIndex], a
	ld a, $40
	ldh [hWY], a
	ret

Overdump_DebugTileset_DrawColorSwatch:
	hlcoord 0, 0
	call Overdump__DebugColor_DrawSwatch

Overdump_DebugColor_DrawAttributeSwatch:
	ld a, [wDebugTilesetCurPalette]
	hlcoord 0, 0, wAttrmap
	; fallthrough

Overdump__DebugColor_DrawSwatch:
	add hl, de
rept 4
	ld [hli], a
endr
rept 2
	ld bc, SCREEN_WIDTH - 4
	add hl, bc
rept 4
	ld [hli], a
endr
endr
	ret

Overdump_DebugTileset_LoadRGBMeter:
	hlcoord 2, 4
	call .Place
	hlcoord 2, 6
	call .Place
	hlcoord 2, 8
.Place:
	ld a, DEBUGTEST_TICKS_1
	ld [hli], a
	ld bc, 15
	ld a, DEBUGTEST_TICKS_2
	call $31ac ; ByteFill
	ret

Overdump_DebugTileset_LoadPalettes:
	ld a, [wDebugTilesetCurPalette]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, wBGPals1
	add hl, de
	ld de, wDebugPalette
	ld bc, 1 palettes
	call $317a ; CopyBytes
	ld de, wDebugPalette
	call Overdump_DebugColor_CalculateRGB
	ret

Overdump_DebugColorMain2:
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_SELECT
	jr nz, .next_palette
	ld a, [hl]
	and PAD_B
	jr nz, .cancel
	call Overdump_DebugTileset_Joypad
	ret

.next_palette
	ld hl, wDebugTilesetCurPalette
	ld a, [hl]
	inc a
	and OAM_PALETTE
	cp PAL_BG_TEXT
	jr nz, .palette_ok
	xor a
.palette_ok
	ld [hl], a
	decoord 1, 1, 0
	call Overdump_DebugColor_DrawAttributeSwatch
	decoord 6, 1, 0
	call Overdump_DebugColor_DrawAttributeSwatch
	decoord 11, 1, 0
	call Overdump_DebugColor_DrawAttributeSwatch
	decoord 16, 1, 0
	call Overdump_DebugColor_DrawAttributeSwatch
	ld hl, wBGPals2
	ld a, [wDebugTilesetCurPalette]
	ld bc, 1 palettes
	call $3203 ; AddNTimes
	ld de, wDebugPalette
	ld bc, 1 palettes
	call $317a ; CopyBytes
	ld a, 2
	ldh [hBGMapMode], a
	ld c, 3
	call DelayFrames
	ld a, 1
	ldh [hBGMapMode], a
	ret

.cancel
	call $315f ; ClearSprites
	ldh a, [hWY]
	xor %11010000
	ldh [hWY], a
	ret

Overdump_DebugTileset_UpdatePalettes:
	ld hl, wBGPals2
	ld a, [wDebugTilesetCurPalette]
	ld bc, 1 palettes
	call $3203 ; AddNTimes
	ld e, l
	ld d, h
	ld hl, wDebugPalette
	ld bc, 1 palettes
	call $317a ; CopyBytes

	hlcoord 1, 0
	ld de, wDebugWhiteTileColor
	call Overdump_DebugColor_PrintHexColor
	hlcoord 6, 0
	ld de, wDebugLightTileColor
	call Overdump_DebugColor_PrintHexColor
	hlcoord 11, 0
	ld de, wDebugDarkTileColor
	call Overdump_DebugColor_PrintHexColor
	hlcoord 16, 0
	ld de, wDebugBlackTileColor
	call Overdump_DebugColor_PrintHexColor

	ld a, TRUE
	ldh [hCGBPalUpdate], a

	call DelayFrame
	ret

Overdump_DebugTileset_Joypad:
	ld a, [wDebugTilesetRGBJumptableIndex]
	maskbits 4
	ld e, a
	ld d, 0
	ld hl, .PointerTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.PointerTable:
	dw Overdump_DebugTileset_SelectColorBox
	dw Overdump_DebugTileset_ChangeRedValue
	dw Overdump_DebugTileset_ChangeGreenValue
	dw Overdump_DebugTileset_ChangeBlueValue

Overdump_DebugTileset_SelectColorBox:
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_DOWN
	jr nz, Overdump_DebugTileset_NextRGBColor
	ld a, [hl]
	and PAD_LEFT
	jr nz, .left
	ld a, [hl]
	and PAD_RIGHT
	jr nz, .right
	ret

.left
	ld a, [wDebugTilesetCurColor]
	dec a
	jr .done

.right
	ld a, [wDebugTilesetCurColor]
	inc a

.done
	maskbits PAL_COLORS
	ld [wDebugTilesetCurColor], a
	ld e, a
	ld d, 0
	ld hl, wDebugPalette
	add hl, de
	add hl, de
	ld e, l
	ld d, h
	call Overdump_DebugColor_CalculateRGB
	ret

Overdump_DebugTileset_ChangeRedValue:
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_DOWN
	jr nz, Overdump_DebugTileset_NextRGBColor
	ld a, [hl]
	and PAD_UP
	jr nz, Overdump_DebugTileset_PreviousRGBColor
	ld hl, wDebugRedChannel
	jr Overdump_DebugTileset_UpdateRGBColor

Overdump_DebugTileset_ChangeGreenValue:
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_DOWN
	jr nz, Overdump_DebugTileset_NextRGBColor
	ld a, [hl]
	and PAD_UP
	jr nz, Overdump_DebugTileset_PreviousRGBColor
	ld hl, wDebugGreenChannel
	jr Overdump_DebugTileset_UpdateRGBColor

Overdump_DebugTileset_ChangeBlueValue:
	ld hl, hJoyLast
	ld a, [hl]
	and PAD_UP
	jr nz, Overdump_DebugTileset_PreviousRGBColor
	ld hl, wDebugBlueChannel
	; fallthrough

Overdump_DebugTileset_UpdateRGBColor:
	ldh a, [hJoyLast]
	and PAD_RIGHT
	jr nz, .increment
	ldh a, [hJoyLast]
	and PAD_LEFT
	jr nz, .decrement
	ret

.increment
	ld a, [hl]
	cp 31
	ret nc
	inc [hl]
	jr .done

.decrement
	ld a, [hl]
	and a
	ret z
	dec [hl]

.done
	call Overdump_DebugTileset_CalculatePalette
	call Overdump_DebugTileset_UpdatePalettes
	ret

Overdump_DebugTileset_PreviousRGBColor:
	ld hl, wDebugTilesetRGBJumptableIndex
	dec [hl]
	ret

Overdump_DebugTileset_NextRGBColor:
	ld hl, wDebugTilesetRGBJumptableIndex
	inc [hl]
	ret

Overdump_DebugTileset_CalculatePalette:
	ld a, [wDebugRedChannel]
	and %00011111
	ld e, a
	ld a, [wDebugGreenChannel]
	and %0000111
	sla a
	swap a
	or e
	ld e, a
	ld a, [wDebugGreenChannel]
	and %00011000
	sla a
	swap a
	ld d, a
	ld a, [wDebugBlueChannel]
	and %00011111
	sla a
	sla a
	or d
	ld d, a
	ld a, [wDebugTilesetCurColor]
	ld c, a
	ld b, 0
	ld hl, wDebugPalette
	add hl, bc
	add hl, bc
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

Overdump_DebugTileset_PlaceCursor:
	ld a, DEBUGTEST_BLACK
	hlcoord 0, 4
	ld [hl], a
	hlcoord 0, 6
	ld [hl], a
	hlcoord 0, 8
	ld [hl], a
	hlcoord 0, 2
	ld [hl], a
	hlcoord 5, 2
	ld [hl], a
	hlcoord 10, 2
	ld [hl], a
	hlcoord 15, 2
	ld [hl], a

	ld a, [wDebugTilesetRGBJumptableIndex]
	and a
	jr z, .place_cursor
	dec a
	hlcoord 0, 4
	ld bc, 2 * SCREEN_WIDTH
	call $3203 ; AddNTimes
	ld [hl], '▶'

.place_cursor
	ld a, [wDebugTilesetCurColor]
	hlcoord 0, 2
	ld bc, 5
	call $3203 ; AddNTimes
	ld [hl], '▶'

	ld b, $78
	ld hl, wShadowOAM
	ld de, wDebugRedChannel
	call .placesprite
	ld de, wDebugGreenChannel
	call .placesprite
	ld de, wDebugBlueChannel
	call .placesprite
	ret

.placesprite:
	ld a, b
	ld [hli], a
	ld a, [de]
	add a
	add a
	add 3 * TILE_WIDTH
	ld [hli], a
	ld a, 16 * TILE_WIDTH
	ld [hli], a
	ld a, 5
	ld [hli], a
	ld a, 2 * TILE_WIDTH
	add b
	ld b, a
	inc c
	ret

.clearsprites:
	call $315f ; ClearSprites
	ret

.dummy:
	ret

ENDSECTION

ENDC
