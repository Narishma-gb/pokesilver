SECTION "sram0", SRAM[$a600], BANK[0]

	ds $550
sMysteryGiftItem:: db
sMysteryGiftUnlocked::
	ds 2

sNumDailyMysteryGiftPartnerIDs::
	ds $4ad

sRTCStatusFlags::
	ds $100

sLuckyNumberDay:: db
sLuckyIDNumber::

ENDSECTION
