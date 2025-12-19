EXPORT DEF wBoxPartialData EQU $C508
EXPORT DEF wMonOrItemNameBuffer EQU $CF72
EXPORT DEF wNewGameResetWIP EQU $D18B
EXPORT DEF wOptions EQU $D1AB
EXPORT DEF wSaveFileExists EQU $D1AC
EXPORT DEF wTextboxFlags EQU $D1AE
EXPORT DEF wOptions2 EQU $D1B0
EXPORT DEF wOTPartyCount EQU $DCC6
EXPORT DEF wDudeNumItems EQU $DCCE
EXPORT DEF wDudeNumKeyItems EQU $DCD8
EXPORT DEF wDudeNumBalls EQU $DCEC
EXPORT DEF wGameDataEnd EQU $DE36
EXPORT DEF wStackTop EQU $DFFF


SECTION "wram1_2", WRAMX[$DCCE], BANK[1]

wOTPartyMons::
; wOTPartyMon1 - wOTPartyMon6
for n, 1, PARTY_LENGTH + 1
wOTPartyMon{d:n}:: party_struct wOTPartyMon{d:n}
endr

wOTPartyMonOTs::
; wOTPartyMon1OT - wOTPartyMon6OT
for n, 1, PARTY_LENGTH + 1
wOTPartyMon{d:n}OT:: ds NAME_LENGTH
endr

wOTPartyMonNicknames::
; wOTPartyMon1Nickname - wOTPartyMon6Nickname
for n, 1, PARTY_LENGTH + 1
wOTPartyMon{d:n}Nickname:: ds NAME_LENGTH
endr

ENDSECTION
