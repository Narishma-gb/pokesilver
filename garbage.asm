IF DEF(_REV0) && DEF(_SILVER)
	SECTION "Garbage 0", ROM0
		INCBIN "garbage/rev_0/garbage_0.bin"

	SECTION "Garbage 1", ROMX, BANK[1]
		INCBIN "garbage/rev_0/garbage_1.bin"

	SECTION "Garbage 3", ROMX, BANK[3]
		INCBIN "garbage/rev_0/garbage_3.bin"

	SECTION "Garbage 4", ROMX, BANK[4]
		INCBIN "garbage/rev_0/garbage_4.bin"

	ENDSECTION
ENDC
