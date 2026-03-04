CreditsScript:

; Clear the banner.
	db CREDITS_CLEAR

; Pokemon Gold/Silver Version Staff
	db                STAFF, 0

	db CREDITS_WAIT, 8

; Play the credits music.
	db CREDITS_MUSIC

	db CREDITS_WAIT2, 10

	db CREDITS_WAIT, 4

; Update the banner.
	db CREDITS_SCENE, 0 ; Bellossom

	db             DIRECTOR, 1
	db       SATOSHI_TAJIRI, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db          SUBDIRECTOR, 1
	db       JUNICHI_MASUDA, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db          PROGRAMMERS, 0
	db     TETSUYA_WATANABE, 1
	db     SHIGEKI_MORIMOTO, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db          PROGRAMMERS, 0
	db       SOUSUKE_TAMADA, 1
	db        TAKENORI_OOTA, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db    GRAPHICS_DIRECTOR, 1
	db         KEN_SUGIMORI, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db       MONSTER_DESIGN, 0
	db         KEN_SUGIMORI, 1
	db    MOTOFUMI_FUJIWARA, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db       MONSTER_DESIGN, 0
	db     SHIGEKI_MORIMOTO, 1
	db       ATSUKO_NISHIDA, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db       MONSTER_DESIGN, 0
	db     HIRONOBU_YOSHIDA, 1
	db          MUNEO_SAITO, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 0

; Clear the banner.
	db CREDITS_CLEAR

	db CREDITS_WAIT, 1

; Update the banner.
	db CREDITS_SCENE, 1 ; Togepi

	db       MONSTER_DESIGN, 0
	db         SATOSHI_OOTA, 1
	db       RENA_YOSHIKAWA, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db      GRAPHICS_DESIGN, 0
	db          JUN_OKUTANI, 1
	db       ASUKA_IWASHITA, 2
	db     TETSUYA_WATANABE, 3

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db         CREDIT_MUSIC, 0
	db       JUNICHI_MASUDA, 1
	db          GO_ICHINOSE, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db CREDIT_SOUND_EFFECTS, 0
	db        MORIKAZU_AOKI, 1
	db       JUNICHI_MASUDA, 2
	db     TETSUYA_WATANABE, 3

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db          GAME_DESIGN, 0
	db       SATOSHI_TAJIRI, 1
	db        KOHJI_NISHINO, 2
	db     SHIGEKI_MORIMOTO, 3

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db          GAME_DESIGN, 0
	db       JUNICHI_MASUDA, 1
	db     KENJI_MATSUSHIMA, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db        GAME_SCENARIO, 0
	db  TOSHINOBU_MATSUMIYA, 1
	db     KENJI_MATSUSHIMA, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db     TOOL_PROGRAMMING, 1
	db        TAKENORI_OOTA, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 0

; Clear the banner.
	db CREDITS_CLEAR

	db CREDITS_WAIT, 1

; Update the banner.
	db CREDITS_SCENE, 2 ; Elekid

	db    PARAMETRIC_DESIGN, 1
	db        KOHJI_NISHINO, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db        SCRIPT_DESIGN, 1
	db        NOBUHIRO_SEYA, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db      MAP_DATA_DESIGN, 1
	db      KAZUHITO_SEKINE, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db           MAP_DESIGN, 0
	db         TETSUJI_OOTA, 1
	db        KOHJI_NISHINO, 2
	db        NOBUHIRO_SEYA, 3

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db      PRODUCT_TESTING, 0
	db NCL_SUPER_MARIO_CLUB, 1
	db          KENJI_SAIKI, 2
	db         ATSUSHI_TADA, 3

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db      PRODUCT_TESTING, 0
	db          SARUGAKUCHO, 1
	db      TOHRU_HASHIMOTO, 2
	db     NOBORU_MATSUMOTO, 3

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db       SPECIAL_THANKS, 0
	db       NAOKO_KAWAKAMI, 1
	db           AKITO_MORI, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2
	
	db       SPECIAL_THANKS, 0
	db      TAKAHIRO_HARADA, 1
	db         SATORU_IWATA, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2
	
	db       SPECIAL_THANKS, 0
	db      HIROYUKI_ZINNAI, 1
	db      KUNIMI_KAWAMURA, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 0

; Clear the banner.
	db CREDITS_CLEAR

	db CREDITS_WAIT, 1

; Update the banner.
	db CREDITS_SCENE, 3 ; Sentret

	db            PRODUCERS, 1
	db      TAKEHIRO_IZUSHI, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db            PRODUCERS, 1
	db    TAKASHI_KAWAGUCHI, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db            PRODUCERS, 1
	db   TSUNEKAZU_ISHIHARA, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db   EXECUTIVE_PRODUCER, 1
	db     HIROSHI_YAMAUCHI, 2

	db CREDITS_WAIT, 12
	db CREDITS_WAIT, 2

	db            COPYRIGHT, 0

	db CREDITS_WAIT, 20
	db CREDITS_WAIT, 11

; Display "The End" graphic.
	db CREDITS_THEEND

	db CREDITS_WAIT, 20

	db CREDITS_END
