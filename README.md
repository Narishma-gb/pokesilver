# Japanese Pokémon Gold and Silver - Spaceworld 1999 Demo

This is a WIP disassembly of the prototype of ポケットモンスター　金・銀, shown at Spaceworld 1999.

It builds the following ROMs:

- Pocket Monsters Gold - Spaceworld 1999 Demo `sha1: 74bab7b6e676b6088c35369067eb7365cac7990c`
- Pocket Monsters Silver - Spaceworld 1999 Demo `sha1: 180339c624f6a5c1b14862dc8d1c27446d74b192`
- Pocket Monsters Gold - Spaceworld 1999 Demo (with correct header) `sha1: 9ec1149aeea30bcf54f0b669373d485d3ce7a2e0`
- Pocket Monsters Silver - Spaceworld 1999 Demo (with correct header) `sha1: 3d438d38c3bfbe507104fc794c9b79825e2f83fe`


To set up the repository, see [INSTALL.md](INSTALL.md).

## Credits

- The whole repository structure, most ASM files, tools and build scripts originate from pret [**pokegold**][pokegold].
- [**Emulicious**][emulicious] debugger features have been invaluable, navigating the ROM to look for differences with the US release.

## Note

The base ROMs of Gold & Silver are required to build, these should be placed at the top-level directory: `baserom_sw99_g.bin` and `baserom_sw99_s.bin`.

[pokegold]: https://github.com/pret/pokegold
[emulicious]:https://www.emulicious.net
