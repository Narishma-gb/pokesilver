SECTION "sram0", SRAM[$ab50], BANK[0]

sMysteryGiftData::
sMysteryGiftItem:: db
sMysteryGiftUnlocked:: db
sBackupMysteryGiftItem:: db
sNumDailyMysteryGiftPartnerIDs:: db
sDailyMysteryGiftPartnerIDs:: ds MAX_MYSTERY_GIFT_PARTNERS * 2
sMysteryGiftDecorationsReceived:: flag_array NUM_NON_TROPHY_DECOS
	ds 4
sMysteryGiftTimer:: dw
	ds 1
sMysteryGiftTrainerHouseFlag:: db
sMysteryGiftPartnerName:: ds NAME_LENGTH
sMysteryGiftUnusedFlag:: db
sMysteryGiftTrainer:: ds wMysteryGiftTrainerEnd - wMysteryGiftTrainer
sBackupMysteryGiftItemEnd::

	ds $462

sRTCStatusFlags::
	ds $100

sLuckyNumberDay:: db
sLuckyIDNumber::

ENDSECTION
