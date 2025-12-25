PhotoStudio:
	ld hl, .WhichMonPhotoText
	call PrintText
	farcall SelectMonFromParty
	jr c, .cancel
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg

	ld hl, .HoldStillText
	call PrintText
	call DisableSpriteUpdates
	farcall PrintPartymon
	call ReturnToMapWithSpeechTextbox
	ldh a, [hPrinter]
	and a
	jr nz, .cancel
	ld hl, .PrestoAllDoneText
	jr .print_text

.cancel
	ld hl, .NoPhotoText
	jr .print_text

.egg
	ld hl, .EggPhotoText

.print_text
	call PrintText
	ret

.WhichMonPhotoText:
	text "どの　#を"
	line "さつえい　するんだい？"
	prompt

.HoldStillText:
	text "よしっ　わかった！"
	line "しばらく　ジッと　しててくれよ"
	prompt

.PrestoAllDoneText:
	text "ほい！おわったよ"
	line "また　きてくれよ"
	done

.NoPhotoText:
	text "なんだ<⋯>やめるのか"
	line "また　きてくれよ"
	done

.EggPhotoText:
	text "タマゴを"
	line "さつえい　してもなあ<⋯><⋯>"
	done
