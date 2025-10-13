EXPORT DEF wMovementBufferCount EQU $CF21
EXPORT DEF wMovementBufferObject EQU $CF22
EXPORT DEF wUnusedMovementBufferBank EQU $CF23
EXPORT DEF wUnusedMovementBufferPointer EQU $CF24
EXPORT DEF wCurBGEvent EQU $CF53
EXPORT DEF wCurCoordEvent EQU $CF53
EXPORT DEF wSeenTrainerBank EQU $CF53
EXPORT DEF wSeenTrainerDistance EQU $CF54
EXPORT DEF wSeenTrainerDirection EQU $CF55
EXPORT DEF wTempTrainer EQU $CF56
EXPORT DEF wWinTextPointer EQU $CF5C
EXPORT DEF wLossTextPointer EQU $CF5E
EXPORT DEF wRunningTrainerBattleScript EQU $CF62
EXPORT DEF wTempTrainerEnd EQU $CF63
EXPORT DEF wPlayerTurningDirection EQU $CF63
EXPORT DEF wBoxAlignment EQU $CF65
EXPORT DEF wFarDecompressPicPointer EQU $CF66
EXPORT DEF wBGP EQU $CF6D
EXPORT DEF wOBP0 EQU $CF6E
EXPORT DEF wOBP1 EQU $CF6F
EXPORT DEF wMonOrItemNameBuffer EQU $CF72
EXPORT DEF wStringBuffer1 EQU $CF87
EXPORT DEF wStringBuffer2 EQU $CF92
EXPORT DEF wStringBuffer3 EQU $CF9D
EXPORT DEF wCurBattleMon EQU $CFC0
EXPORT DEF wPartyMenuCursor EQU $CFC3
EXPORT DEF wMenuScrollPosition EQU $CFCE
EXPORT DEF wQueuedScriptBank EQU $CFD2
EXPORT DEF wQueuedScriptAddr EQU $CFD3
EXPORT DEF wPredefID EQU $CFD5
EXPORT DEF wPredefHL EQU $CFD6
EXPORT DEF wPredefAddress EQU $CFD8
EXPORT DEF wFarCallBC EQU $CFDA
EXPORT DEF wNumMoves EQU $CFDD
EXPORT DEF wStateFlags EQU $CFDF
EXPORT DEF wBattleResult EQU $CFE3
EXPORT DEF wUnusedNamesPointer EQU $CFF8
EXPORT DEF wCurPartySpecies EQU $CFFE
EXPORT DEF wCurPartyMon EQU $CFFF
EXPORT DEF wNewGameResetWIP EQU $D18B
EXPORT DEF wOptions EQU $D1AB
EXPORT DEF wSaveFileExists EQU $D1AC
EXPORT DEF wTextboxFlags EQU $D1AE
EXPORT DEF wGameDataEnd EQU $DE36
EXPORT DEF wStackTop EQU $DFFF


SECTION "wram0", WRAM0[$CF26]

wMovementBuffer::


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
