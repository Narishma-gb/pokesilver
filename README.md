# Japanese Pokémon Gold and Silver

This is a disassembly of ポケットモンスター　金・銀.

This branch focuses on two prototype builds of Gold & Silver:
- `AAUJe0-0.gb` is a Gold version, dated September 30, 1999.
- `MONS2.isx` is a Debug Silver version, dated October 6, 1999. The compressed Pokémon sprites are not present on the image, and have been added using the same layout as on the final ROMs.


It builds the following ROMs:

- Pocket Monsters - Gold (1999.09.30) `sha1: 896715709d377499737480a01835bd739b2805b5`
- Pocket Monsters - Debug Silver (1999.10.06) `sha1: f4043695365124c1b5805a7c86b3cbad712fcf71`
- Pocket Monsters - Gold Version (J) - Rev.0 `sha1: 8814f1039450a5d3684b1389f588ccd7ee7c3436`
- Pocket Monsters - Silver Version (J) - Rev.0 `sha1: fa8c51059c1642faa570db56ef089f54d1d2011f`

To set up the repository, see [INSTALL.md](INSTALL.md).

## Credits

- The whole repository structure, most ASM files, tools and build scripts originate from pret [**pokegold**][pokegold].
- [**Emulicious**][emulicious] debugger features have been invaluable, navigating the ROM to look for differences with the US release.

[pokegold]: https://github.com/pret/pokegold
[emulicious]: https://www.emulicious.net
