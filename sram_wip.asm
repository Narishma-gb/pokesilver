SECTION "sram0", SRAM[$ab50], BANK[0]

sMysteryGiftItem:: db
sMysteryGiftUnlocked::
	ds 2

sNumDailyMysteryGiftPartnerIDs::
	ds 21
sMysteryGiftTimer:: dw
	ds 1
sMysteryGiftTrainerHouseFlag::
	ds $495

sRTCStatusFlags::
	ds $100

sLuckyNumberDay:: db
sLuckyIDNumber::

ENDSECTION
