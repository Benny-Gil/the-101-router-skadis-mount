# SKÅDIS mount for the rain "the101" 5G router

**Get your the101 router off the desk and onto an IKEA SKÅDIS pegboard — no screws, no drilling, no adhesive.**

[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](LICENSE)
[![Made with OpenSCAD](https://img.shields.io/badge/made%20with-OpenSCAD-blue.svg)](https://openscad.org)

rain's the101 has no screw holes, no VESA pattern and no wall-mount accessory —
it's designed to sit on a shelf. But its underside hides a slide-in captive
plate, and that's the interface this project rebuilds, with pegboard pegs where
the wall screws would have gone.

| <img src="docs/images/bracket.png" width="380">                                                                       | <img src="docs/images/hooks.png" width="380">                                              |
| :-------------------------------------------------------------------------------------------------------------------- | :----------------------------------------------------------------------------------------- |
| **Option A — the bracket**                                                                                            | **Option B — cradle hooks**                                                                |
| A thin plate that slides into the router's base and disappears behind it. Tidy, but it has to match your unit's base. | Two L-shaped hooks the router simply sits in. Nothing to fit, so these work on any the101. |

## Which one should I print?

|                  | Bracket                                             | Cradle hooks                   |
| ---------------- | --------------------------------------------------- | ------------------------------ |
| **Looks**        | Router sits flush to the board, no visible hardware | Visible shelf under the router |
| **Will it fit?** | Needs your base to match the measurements below     | Fits any the101 — no measuring |
| **Prints**       | 1 part, ~28 g, ~2 h                                 | 2 parts, ~19 g each            |
| **Supports**     | None                                                | Only on the pegs               |

**Not sure? Print the hooks.** They need no measuring and can't not fit. The
bracket is the nicer result if your unit matches — see
[Will it fit mine?](#will-it-fit-mine) below, it takes about a minute to check.

## What you'll need

- An IKEA **SKÅDIS** pegboard — any size. (The 3 mm thin variant works too; see [Customising](#customising).)
- A 3D printer and a little filament — ~28 g for the bracket, ~38 g for a pair of hooks. PLA is fine; **PETG** if the router runs warm or the board catches direct sun.
- A ruler or calipers, if you're printing the bracket.

## Quick start

**1. Download the part you picked.** GitHub previews STLs in the browser, so you
can spin them around before downloading:

- Bracket → [`stl/101_skadis_bracket.stl`](stl/101_skadis_bracket.stl)
- Cradle hooks → [`stl/101_skadis_hooks.stl`](stl/101_skadis_hooks.stl) _(print two)_

**2. Slice it.**

|                | Bracket                                     | Cradle hooks                                |
| -------------- | ------------------------------------------- | ------------------------------------------- |
| Orientation    | Flat, plate face **down**, ribs and pegs up | On its side, the 30 mm flat face on the bed |
| Supports       | **None needed**                             | Tree supports, **pegs only**                |
| Layer height   | **0.2 mm** (see note)                       | 0.2 mm                                      |
| Walls / infill | 3 walls, 25 %                               | 3 walls, 25 %                               |

> **Why 0.2 mm matters on the bracket.** The plate is 2.0 mm thick and has to
> slide into a 4.0 mm slot. Pick a layer height that divides into 2.0 mm evenly —
> 0.2 mm gives you ten clean layers. At 0.28 mm the slicer rounds to 7 layers and
> the plate comes out off-spec.

**3. Hang it.** Push the pegs in near the _top_ of their slots, then drop the
part about 11 mm so the barbs catch behind the board.

- **Bracket:** mount it so the router is lowered **down** onto the plate — the
  open side of the router's base facing down once it's up. Gravity holds it
  seated, so it needs no latch. To remove the router, just lift it off.
- **Hooks:** space them **160 mm apart**, which is four columns of slots.

## Will it fit mine?

Every measurement here came off one specific unit with calipers. Commercially
sold "the101 brackets" advertise dimensions that don't match it, so none of their
specs are used here.

**The bracket** assumes your router's base has a **112 mm square well** with a
**4.0 mm gap** under its retention tabs. Measure those two and you'll know in a
minute. If they differ, don't give up — change two numbers and re-export, see
below.

**The hooks** need none of this. They only use the router's outside dimensions
(230 × 230 × 56 mm), which are published by rain.

> One number in the model — the depth of the well — was never measured, and is
> assumed at 5.7 mm. It only sets how far the bracket stands off the board, and
> it errs deliberately high, so the worst case is a slightly wider air gap than
> necessary. [More on this in the build guide](docs/build-guide.md).

## Customising

Everything is parametric. Install [OpenSCAD](https://openscad.org), open
[`src/skadis_101_mount.scad`](src/skadis_101_mount.scad), change a number, and
re-export:

```sh
make            # re-export both STLs into stl/
make preview    # re-render the images in this README
```

The variables you're most likely to want:

| Variable     | Default | Change it when                                                                                                                                                 |
| ------------ | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `tongue_t`   | 2.0     | You want a snug plate. The stock 2.0 mm plate in a 4.0 mm slot leaves ~2 mm of play, so the router can rock a little — raise this toward 3.8 to take that out. |
| `plate_sq`   | 112.0   | Your well measures differently                                                                                                                                 |
| `tongue_fit` | 0       | The plate binds going in — raise for more clearance                                                                                                            |
| `peg_clear`  | 0.4     | Pegs too tight in the slots → raise. Too loose → lower.                                                                                                        |
| `board_t`    | 5.2     | You have the 3 mm SKÅDIS variant                                                                                                                               |
| `air_gap`    | 6.0     | You want the router closer to, or further off, the board                                                                                                       |
| `lighten`    | true    | Set `false` for a solid plate with no centre window                                                                                                            |

## How it works

The [**build guide**](docs/build-guide.md) covers the whole design: what the
router's mounting interface actually is, a cross-section through the assembly,
why the standoff ribs exist, where a third of the weight went, and the load
numbers.

```
src/skadis_101_mount.scad    the model — every parameter is at the top
stl/                         ready-to-slice exports
docs/build-guide.md          the long version
docs/images/                 renders and the section drawing
Makefile                     re-export the STLs and images
```

## Contributing

Issues and pull requests welcome. The **most useful** thing you can contribute is
measurements from another the101 — there's a real chance rain shipped more than
one base moulding, and right now this is built from a sample of one. If you
measure yours, please open an issue with:

- your well width and tab slot gap
- the well depth, if you can get at it
- whether the stock bracket fitted

Prints in the wild are also very welcome — photos make the docs better.

## License

[**CC BY-SA 4.0**](LICENSE) — print it, sell prints of it, remix it. Just credit
Benny-Gil and share your modified designs under the same license.

## Sources

- [rain — the101](https://www.rain.co.za/the101) — 230 × 230 × 56 mm body
- [TechCentral — rain unveils 'the101'](https://techcentral.co.za/rain-the101-5g-smart-router-raipr/234417/) — platform details
- [Parametric SKÅDIS Board Generator](https://www.printables.com/model/206256-parametric-skadis-board-generator) — 5 mm nominal slot width
- [IKEA SKÅDIS Add-Ons](https://makerworld.com/en/models/799571-ikea-skadis-add-ons-parametric-bins-and-shelves) — published hook geometry

The router's mounting interface came from measuring the unit, not from any of these.
