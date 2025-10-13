IF DEF(_REV0) && DEF(_SILVER)
	SECTION "Garbage 0", ROM0
		INCBIN "garbage/rev_0/garbage_0.bin"

	SECTION "Garbage 1", ROMX, BANK[1]
		INCBIN "garbage/rev_0/garbage_1.bin"

	ENDSECTION
ENDC
