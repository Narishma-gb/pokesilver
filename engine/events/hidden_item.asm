HiddenItemScript::
	opentext
	readmem wHiddenItemID
	getitemname STRING_BUFFER_3, USE_SCRIPT_VAR
	writetext .PlayerFoundItemText
	giveitem ITEM_FROM_MEM
	iffalse .bag_full
	callasm SetMemEvent
	specialsound
	itemnotify
	sjump .finish

.bag_full
	promptbutton
	writetext .ButNoSpaceText
	waitbutton

.finish
	closetext
	end

.PlayerFoundItemText:
	text "<PLAYER>は"
	line "@"
	text_ram wStringBuffer3
	text "を　みつけた！"
	done

.ButNoSpaceText:
	text "しかし　<PLAYER>は"
	line "どうぐを　もう　もてない！"
	done

SetMemEvent:
	ld hl, wHiddenItemEvent
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld b, SET_FLAG
	call EventFlagAction
	ret
