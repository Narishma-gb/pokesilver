CorrectNickErrors::
; error-check monster nick before use
; must be a peace offering to gamesharkers

; input: de = nick location

	push bc
	push de
	ld b, NAME_LENGTH

.checkchar
; end of nick?
	ld a, [de]
	cp '@' ; terminator
	jr z, .end

; check if this char is a text command
	ld hl, .textcommands
	dec hl
.loop
; next entry
	inc hl
; reached end of commands table?
	ld a, [hl]
	cp -1
	jr z, .done

; is the current char between this value (inclusive)...
	ld a, [de]
	cp [hl]
	inc hl
	jr c, .loop
; ...and this one?
	cp [hl]
	jr nc, .loop

; replace it with a '？'
	ld a, '？'
	ld [de], a
	jr .loop

.done
; next char
	inc de
; reached end of nick without finding a terminator?
	dec b
	jr nz, .checkchar

; change nick to "？@"
	pop de
	push de
	ld a, '？'
	ld [de], a
	inc de
	ld a, '@'
	ld [de], a
.end
; if the nick has any errors at this point it's out of our hands
	pop de
	pop bc
	ret

.textcommands
; table defining which characters are illegal in a nickname
; format:
	;      ≥       <
	db '<NULL>',  'ガ'
	db 'ド' + 1,   'バ'
	db 'ボ' + 1,   'が'
	db 'ど' + 1,   'ば'
	db 'ぼ' + 1,   'パ'
	db 'ぽ' + 1,   '<TRAINER>'
	db '<ROCKET>', '　'
	db -1 ; end
