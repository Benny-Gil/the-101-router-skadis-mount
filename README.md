# SKÅDIS mount for the rain "the101" 5G router

Parametric OpenSCAD. One source file, three parts.

```
skadis_101_mount.scad     source
101_skadis_bracket.stl    the slide-in plate  (print 1)
101_skadis_hooks.stl      cradle hook         (print 2)
101_skadis_gauge.stl      tab gauge           (print 1, optional but do it)
```

## What the router's mount actually is

the101 is a 230 × 230 × 56 mm rounded-square 5G CPE. Its underside has a shallow
square **well** ringed by moulded plastic **retention tabs**. A flat plate slides
in sideways and is captured under those tabs.

There are no screw bosses in the router. Every number below is measured off this
unit — commercially sold "the101 brackets" list dimensions that do not match it,
so none of their specs are used here.

|                  |                          | |
| ---------------- | ------------------------ | --------------- |
| Tab slot gap     | 4.0 mm                   | measured |
| Tab width        | 12 mm                    | measured |
| Well width       | 112 mm                   | measured |
| Router body      | 230 × 230 × 56 mm        | rain.co.za |
| Well depth       | 5.7 mm                   | **assumed — see below** |
| **Build target** | **112 × 112 × 2.0 mm**   | |

`well_depth` is the one number nobody has measured. It only feeds the standoff.
Over-estimating is safe — it just widens the air gap — while under-estimating
means the ribs foul the router's rim and the plate never seats, so it errs high
on purpose. Measure yours with the gauge's rule to tighten it.

SKÅDIS side: slots are 5.0 × 15.0 mm on a plain 40 mm rectangular grid, board is
5.2 mm thick, and accessories hang off the **bottom** edge of a slot.

## Part 1 — the bracket (the real answer)

A 112 × 112 × 2.0 mm plate that slides into the well under the tabs, with six
SKÅDIS pegs on the back.

**Hang it so the router is lowered DOWN onto the tongue** — i.e. the well's open
side faces down once the router is up. Gravity then holds the plate seated, so it
needs no latch or detent. To remove, lift.

> **Fit note.** 2.0 mm sits in a 4.0 mm tab slot, so the plate has ~2.0 mm of
> slop and the router can rock on it slightly. That is the cost of the thin
> plate, not a bug. Raise `tongue_t` toward 3.8 for a snug fit.

The back carries a perimeter ring and two cross ribs that stand the plate 10.1 mm
off the board — a 104 mm ring inside a 4 mm bare lip, with the cross ribs
inboard of it carrying the pegs. That is not decoration: mounted vertically, the router's vented
underside would otherwise sit flat against fibreboard. The ribs leave a 6 mm air
gap, and at 1.6 mm the plate leans on them for all of its stiffness — don't thin
them much. The pegs are lengthened to 20.7 mm to reach through them.

It is deliberately one flat plate rather than a stepped plate with an oversailing
slab — a step would leave an unsupported ledge on the bed.

- **Print face-down, ribs and pegs up. No supports.** The peg barbs are ramped at
  45° so they self-support.
- 3 walls, 25 % infill, 0.2 mm. ~28 g, roughly 2 h.
- Keep the layer height a divisor of `tongue_t`. At 2.0 mm that means 0.2 mm
  (10 layers) — 0.28 mm gives 7.1 and the slicer will round the plate off spec.
- PETG holds up better than PLA if the router runs warm or the board is in sun.

## Part 2 — the cradle hooks

Two L-hooks that the router simply sits in. These need **no** measurements of
your unit's well, so they work even if the numbers above are off. Print two and
space them **160 mm apart** (4 slot columns) on the board.

The 62 mm shelf swallows the full 56 mm body depth and the 22 mm lip stops it
tipping out. Two pegs 40 mm apart per hook — one peg alone would let the hook
swing.

- **Print on its side**, the 30 mm flat face on the bed. The body then has no
  overhangs at all. The two pegs are the exception — give them tree supports.
- ~19 g each.

## Part 3 — the gauge

A comb of 12 mm fingers in 0.2 mm steps from 3.4 to 4.4 mm, plus a 100 mm rule.
Slide each finger under one of the router's tabs. The thickest one that goes in
without forcing is your real slot gap.

Print this first. It is 10 minutes and ~10 g, and it derisks the bracket.

- If you want a snug plate rather than the thin one, set `tongue_t` to
  _(measured gap − 0.2)_.
- Use the rule to check the well against the 112 mm `plate_sq` figure, and to
  measure the well depth that `well_depth` is currently only assuming.

## Tuning

Everything is a variable at the top of the `.scad`. The ones you are most likely
to touch:

| Variable     | Default | When to change                                    |
| ------------ | ------- | ------------------------------------------------- |
| `tongue_t`   | 1.6     | Raise toward 3.8 to kill the rock in the tab slot |
| `plate_sq`   | 112.0   | Your well measures differently                    |
| `tongue_fit` | 0       | Raise if the plate binds sliding in               |
| `peg_clear`  | 0.4     | Pegs bind in the slots → raise. Sloppy → lower.   |
| `board_t`    | 5.2     | You have the 3 mm SKÅDIS variant                  |
| `air_gap`    | 6.0     | Want the router closer to / further off the board |
| `rib_in`     | 4.0     | Width of the bare lip; also sets the ring outer     |
| `lighten`    | true    | Set false for a solid plate with no centre window  |
| `light_edge` | 4.0     | Plate left between the window and the ribs         |
| `rib_w`      | 6.0     | Below ~5 there is no margin either side of a peg   |

Note `tongue_t` also drives the standoff: the ribs have to clear however far the
router's rim hangs past the plate, so a thinner plate means taller ribs and
longer pegs.

Re-export with:

```sh
openscad -o 101_skadis_bracket.stl -D 'part="bracket"' skadis_101_mount.scad
openscad -o 101_skadis_hooks.stl   -D 'part="hooks"'   skadis_101_mount.scad
openscad -o 101_skadis_gauge.stl   -D 'part="gauge"'   skadis_101_mount.scad
```

## Weight

The bracket started at 74.2 cm³ and is now **49.6 cm³, ~28 g — 33 % lighter**.
Two changes, neither of which costs meaningful strength:

**Narrower ribs, 10 → 6 mm.** A rib's bending stiffness goes as its *height*
cubed and only linearly with width. The 9.7 mm standoff was always doing the
work; 10 mm of width was mass. This drops rib second moment to 60 % of before,
against margins that were already ~40× — and 6 mm still leaves 1 mm either side
of a peg neck.

**A window through the dead centre of the plate.** The tabs grip the perimeter
and the load runs perimeter → ring → cross ribs → pegs, all of it outside the
84 × 62 mm cutout. It vents the well as a bonus.

Set `lighten = false` to get the solid plate back.

For more, go after the slicer rather than the model: 2 walls and 15 % infill
takes another few grams. The ribs are only 6 mm wide, so most of their volume is
perimeter either way — the geometry is what saved the weight here.

## Load

A ~1 kg router on six pegs is well within both the pegs and a 5 mm SKÅDIS panel.
Worst case after lightweighting:

| Path | Stress | Against |
| ---- | ------ | ------- |
| Peg neck bending | 1.3 MPa | ~50 MPa yield |
| 4 mm lip at a tab | 0.6 MPa | ~50 MPa yield |
| Rib bearing on the board | 0.003 MPa | over 3600 mm² |

The perimeter ring bearing flat on the board is what actually takes the tipping
moment; the pegs mostly just stop it falling off.

## Sources

- [rain — the101](https://www.rain.co.za/the101) — 230 × 230 × 56 mm
- [TechCentral — rain unveils 'the101'](https://techcentral.co.za/rain-the101-5g-smart-router-raipr/234417/) — platform details

Everything about the mounting interface came from measuring the unit, not from
any of these.
- [Parametric SKÅDIS Board Generator](https://www.printables.com/model/206256-parametric-skadis-board-generator) — 5 mm nominal slot width
- [IKEA SKÅDIS Add-Ons](https://makerworld.com/en/models/799571-ikea-skadis-add-ons-parametric-bins-and-shelves) — published hook geometry
