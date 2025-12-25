SECTION "sram0", SRAM[$ab50], BANK[0]

sMysteryGiftItem:: db
sMysteryGiftUnlocked:: db
sBackupMysteryGiftItem:: db

sNumDailyMysteryGiftPartnerIDs::
	ds 21
sMysteryGiftTimer:: dw
	ds 1
sMysteryGiftTrainerHouseFlag::
	ds $33
sBackupMysteryGiftItemEnd::
	ds $462

sRTCStatusFlags::
	ds $100

sLuckyNumberDay:: db
sLuckyIDNumber::

ENDSECTION
