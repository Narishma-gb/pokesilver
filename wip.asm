; \1 Label
; \2 Label address
MACRO dr
	IF BANK(@) == 0
		DEF inc_start = @
	ELSE
		DEF inc_start = @ - $4000
	ENDC

	DEF bank_start = BANK(@) * $4000
	DEF inc_size = (\2) - @

	ASSERT FATAL, inc_size + inc_start <= $4000, "Bank overflow: \1"
	ASSERT FATAL, inc_size >= 0, "Negative binary INCLUDE: \1"

	IF DEF(_GOLD)
		INCBIN "baserom_sw99_g.bin", bank_start + inc_start, inc_size
	ELIF DEF(_SILVER)
		INCBIN "baserom_sw99_s.bin", bank_start + inc_start, inc_size
	ENDC
	\1::
ENDM

; G/S label offset, in places where the ROMs diverge
MACRO set_gs_diff
	IF DEF(_GOLD)
		DEF gs_diff = \1
	ELIF DEF(_SILVER)
		DEF gs_diff = 0
	ENDC
ENDM

MACRO drd
	dr \1, (\2) + gs_diff
ENDM


;INCLUDE "main.asm"

SECTION "rom0", ROM0[$150]
; ROM $00 : $0000 - $3FFF

	dr VBlank, $0150
	dr LCD, $046a
	dr _Start, $0614
	dr Serial, $06f0
	dr Joypad, $08ef
	dr FarCall_hl, $2d65


;SECTION "rom1", ROMX[$4000], BANK[1]
; ROM $01 : $4000 - $7FFF


;SECTION "rom2", ROMX[$4000], BANK[2]
; ROM $02 : $8000 - $BFFF


;SECTION "rom3", ROMX[$4000], BANK[3]
; ROM $03 : $C000 - $FFFF


;SECTION "rom4", ROMX[$4000], BANK[4]
; ROM $04 : $10000 - $13FFF


;SECTION "rom5", ROMX[$4000], BANK[5]
; ROM $05 : $14000 - $17FFF


;SECTION "rom6", ROMX[$4000], BANK[6]
; ROM $06 : $18000 - $1BFFF


;SECTION "rom7", ROMX[$4000], BANK[7]
; ROM $07 : $1C000 - $1FFFF


;SECTION "rom8", ROMX[$4000], BANK[8]
; ROM $08 : $20000 - $23FFF


;SECTION "rom9", ROMX[$4000], BANK[9]
; ROM $09 : $24000 - $27FFF


;SECTION "rom10", ROMX[$4000], BANK[10]
; ROM $0a : $28000 - $2BFFF


;SECTION "rom11", ROMX[$4000], BANK[11]
; ROM $0b : $2C000 - $2FFFF


;SECTION "rom12", ROMX[$4000], BANK[12]
; ROM $0c : $30000 - $33FFF


;SECTION "rom13", ROMX[$4000], BANK[13]
; ROM $0d : $34000 - $37FFF


;SECTION "rom14", ROMX[$4000], BANK[14]
; ROM $0e : $38000 - $3BFFF


;SECTION "rom15", ROMX[$4000], BANK[15]
; ROM $0f : $3C000 - $3FFFF


;SECTION "rom16", ROMX[$4000], BANK[16]
; ROM $10 : $40000 - $43FFF


;SECTION "rom17", ROMX[$4000], BANK[17]
; ROM $11 : $44000 - $47FFF


;SECTION "rom18", ROMX[$4000], BANK[18]
; ROM $12 : $48000 - $4BFFF


;SECTION "rom19", ROMX[$4000], BANK[19]
; ROM $13 : $4C000 - $4FFFF


;SECTION "rom20", ROMX[$4000], BANK[20]
; ROM $14 : $50000 - $53FFF


;SECTION "rom21", ROMX[$4000], BANK[21]
; ROM $15 : $54000 - $57FFF


;SECTION "rom22", ROMX[$4000], BANK[22]
; ROM $16 : $58000 - $5BFFF


;SECTION "rom23", ROMX[$4000], BANK[23]
; ROM $17 : $5C000 - $5FFFF


;SECTION "rom24", ROMX[$4000], BANK[24]
; ROM $18 : $60000 - $63FFF


;SECTION "rom25", ROMX[$4000], BANK[25]
; ROM $19 : $64000 - $67FFF


;SECTION "rom26", ROMX[$4000], BANK[26]
; ROM $1a : $68000 - $6BFFF


;SECTION "rom27", ROMX[$4000], BANK[27]
; ROM $1b : $6C000 - $6FFFF


;SECTION "rom28", ROMX[$4000], BANK[28]
; ROM $1c : $70000 - $73FFF


;SECTION "rom29", ROMX[$4000], BANK[29]
; ROM $1d : $74000 - $77FFF


;SECTION "rom30", ROMX[$4000], BANK[30]
; ROM $1e : $78000 - $7BFFF


;SECTION "rom31", ROMX[$4000], BANK[31]
; ROM $1f : $7C000 - $7FFFF


;SECTION "rom32", ROMX[$4000], BANK[32]
; ROM $20 : $80000 - $83FFF


;SECTION "rom33", ROMX[$4000], BANK[33]
; ROM $21 : $84000 - $87FFF


;SECTION "rom34", ROMX[$4000], BANK[34]
; ROM $22 : $88000 - $8BFFF


;SECTION "rom35", ROMX[$4000], BANK[35]
; ROM $23 : $8C000 - $8FFFF


;SECTION "rom36", ROMX[$4000], BANK[36]
; ROM $24 : $90000 - $93FFF


;SECTION "rom37", ROMX[$4000], BANK[37]
; ROM $25 : $94000 - $97FFF


;SECTION "rom38", ROMX[$4000], BANK[38]
; ROM $26 : $98000 - $9BFFF


;SECTION "rom39", ROMX[$4000], BANK[39]
; ROM $27 : $9C000 - $9FFFF


;SECTION "rom40", ROMX[$4000], BANK[40]
; ROM $28 : $A0000 - $A3FFF


;SECTION "rom41", ROMX[$4000], BANK[41]
; ROM $29 : $A4000 - $A7FFF


;SECTION "rom42", ROMX[$4000], BANK[42]
; ROM $2a : $A8000 - $ABFFF


;SECTION "rom43", ROMX[$4000], BANK[43]
; ROM $2b : $AC000 - $AFFFF


;SECTION "rom44", ROMX[$4000], BANK[44]
; ROM $2c : $B0000 - $B3FFF


;SECTION "rom45", ROMX[$4000], BANK[45]
; ROM $2d : $B4000 - $B7FFF


;SECTION "rom46", ROMX[$4000], BANK[46]
; ROM $2e : $B8000 - $BBFFF


;SECTION "rom47", ROMX[$4000], BANK[47]
; ROM $2f : $BC000 - $BFFFF


;SECTION "rom48", ROMX[$4000], BANK[48]
; ROM $30 : $C0000 - $C3FFF


;SECTION "rom49", ROMX[$4000], BANK[49]
; ROM $31 : $C4000 - $C7FFF


;SECTION "rom50", ROMX[$4000], BANK[50]
; ROM $32 : $C8000 - $CBFFF


;SECTION "rom51", ROMX[$4000], BANK[51]
; ROM $33 : $CC000 - $CFFFF


;SECTION "rom52", ROMX[$4000], BANK[52]
; ROM $34 : $D0000 - $D3FFF


;SECTION "rom53", ROMX[$4000], BANK[53]
; ROM $35 : $D4000 - $D7FFF


;SECTION "rom54", ROMX[$4000], BANK[54]
; ROM $36 : $D8000 - $DBFFF


;SECTION "rom55", ROMX[$4000], BANK[55]
; ROM $37 : $DC000 - $DFFFF


;SECTION "rom56", ROMX[$4000], BANK[56]
; ROM $38 : $E0000 - $E3FFF


;SECTION "rom57", ROMX[$4000], BANK[57]
; ROM $39 : $E4000 - $E7FFF


;SECTION "rom58", ROMX[$4000], BANK[58]
; ROM $3a : $E8000 - $EBFFF


;SECTION "rom59", ROMX[$4000], BANK[59]
; ROM $3b : $EC000 - $EFFFF


;SECTION "rom60", ROMX[$4000], BANK[60]
; ROM $3c : $F0000 - $F3FFF


;SECTION "rom61", ROMX[$4000], BANK[61]
; ROM $3d : $F4000 - $F7FFF


;SECTION "rom62", ROMX[$4000], BANK[62]
; ROM $3e : $F8000 - $FBFFF


;SECTION "rom63", ROMX[$4000], BANK[63]
; ROM $3f : $FC000 - $FFFFF
