// =============================================================================
//  SKADIS mount kit for the rain "the101" 5G router
// =============================================================================
//  Copyright (c) 2026 Benny-Gil
//  Licensed CC BY-SA 4.0 - see LICENSE. Credit and share alike.
//
//  MOUNT TYPE (read off a photo of this unit's base, then measured directly):
//
//    the101 is a 230 x 230 x 56 mm rounded-square 5G CPE. Its underside has a
//    shallow square WELL ringed by moulded plastic retention TABS. A flat plate
//    slides in sideways and is captured under those tabs. There are no screw
//    bosses in the router.
//
//    Interface numbers, all measured off the router itself with calipers.
//    Commercially sold "the101 brackets" list dimensions that do not match this
//    unit, so nothing here is taken from them:
//      tab slot gap ......... 4.0 mm    (measured)
//      tab width ............ 12  mm    (measured)
//      well width ........... 112 mm    (measured)
//      well depth ........... NOT MEASURED - see well_depth below
//      BUILD TARGET ......... 112 x 112 x 2.0 mm, with a 104 mm standoff ring.
//                             2.0 mm in a 4.0 mm slot leaves ~2 mm of slop;
//                             see tongue_t.
//
//    So: a SLIDE-IN CAPTIVE PLATE. This file rebuilds that plate with SKADIS
//    pegs on the back instead of wall screws.
//
//  SKADIS interface (IKEA pegboard):
//    slots 5.0 x 15.0 mm on a plain 40 mm rectangular grid, board 5.2 mm thick.
//    Accessories hang off the BOTTOM edge of a slot.
//
//  ORIENTATION - this matters:
//    Hang the bracket so the router is lowered DOWN onto the tongue, i.e. the
//    well's open side faces down once the router is up. Gravity then holds the
//    plate seated, so no latch or detent is needed. To remove, lift.
//
//  PARTS - pick with `part` below:
//    "bracket" - the slide-in captive plate. The real answer. Prints flat with
//                no supports.
//    "hooks"   - a pair of cradle hooks. Needs nothing but the published body
//                size, so it works even if your unit's well differs at all.
// =============================================================================

/* [What to render] */
part = "bracket"; // [bracket:Slide-in plate, hooks:Cradle hooks, all:Both laid out]

/* [SKADIS board - leave alone for a genuine board] */
skadis_pitch = 40;    // slot grid pitch, both axes
slot_w       = 5.0;   // slot width
slot_h       = 15.0;  // slot height
board_t      = 5.2;   // pegboard thickness (use 3.0 for the thin variant)

/* [Printer fit tuning] */
peg_clear = 0.4;  // subtracted from slot_w to get peg width. Raise if pegs bind.
peg_gap   = 0.4;  // slop behind the board before the barb bites

/* [Peg shape] */
neck_h = 4.0;   // peg height sitting inside the slot
barb_h = 5.0;   // how far the barb drops behind the board
barb_d = 5.0;   // barb depth. Keep == barb_h: that is what makes the barb's
                // underside a 45 deg self-supporting face.

/* [Router interface - measured] */
tab_gap    = 4.0;    // the 4 mm slot under the retention tabs. Asserted against
                     // tongue_t below: a plate thicker than this will not enter.
plate_sq   = 112.0;  // what this unit's well takes
well_depth = 5.7;    // ASSUMED, not measured. Well floor down to the router's
                     // outer rim. Only feeds the standoff. Over-estimating is
                     // safe - it just widens the air gap. Under-estimating means
                     // the ribs foul the rim and the plate will not seat, so
                     // this deliberately errs high. Measure yours to tighten it.
tongue_fit = 0;      // extra clearance off plate_sq. Raise if it binds going in.

/* [Slide-in bracket] */
tongue_t = 2.0;   // plate thickness. NOTE this is still under the 4.0 mm tab
                  // slot, so the plate has ~2.0 mm of slop and the router can
                  // rock slightly. Raise toward 3.8 for a snug fit.
air_gap  = 6.0;   // clear air behind the router's vented underside. The whole
                  // point of the standoff ribs: mounted vertically, that face
                  // would otherwise sit flat on the fibreboard.
rib_w    = 6.0;   // standoff rib width. A rib's stiffness goes as its HEIGHT
                  // cubed and only linearly with width, so the 9.7 mm standoff
                  // is doing the work - 10 mm of width was just mass. 6 mm still
                  // leaves 1 mm either side of a peg neck.

rib_in   = 4.0;   // perimeter rib inset from the plate edge, i.e. the width of
                  // the bare lip around the outside of the plate. Also sets the
                  // ring's outer size: plate_sq - 2*rib_in = 104.
lead_in  = 1.0;   // 45 deg chamfer on the tongue's leading (top) edge
peg_cols = [-40, 0, 40];   // peg x positions. Spacings must be multiples of 40.
peg_rows = [40, -40];      // peg y positions. Spacings must be multiples of 40.

/* [Weight saving] */
lighten    = true;  // cut the dead centre out of the plate
light_edge = 4.0;   // plate left between that cutout and the ribs

/* [Cradle hooks] */
body_t       = 56;   // the101 body thickness, from rain's spec
hook_plate_w = 30;   // backplate width
hook_plate_h = 80;   // backplate height: 40 mm peg column + gusset tail below
hook_plate_t = 5;    // backplate thickness
hook_shelf_d = body_t + 6;   // shelf depth, the body plus a little
hook_shelf_t = 5;    // shelf thickness
hook_lip_h   = 22;   // front lip, stops the router tipping off
hook_lip_t   = 5;    // front lip thickness
hook_gusset  = 24;   // web height. The backplate runs on DOWN past the shelf by
                     // this much so the web has something to tie into - a web
                     // above the shelf would foul the router body.

$fn = 64;

assert(tongue_t <= tab_gap,
       "tongue_t exceeds tab_gap - the plate will not enter the tab slot");

// Standoff needed at the plate's back face. The plate sits tongue_t into the
// well, so the router's rim hangs (well_depth - tongue_t) proud of the plate's
// back and the ribs must clear that before the air gap even starts. With
// well_depth only assumed, this errs high on purpose.
standoff = air_gap + (well_depth - tongue_t);

// =============================================================================
//  SKADIS peg
// =============================================================================
//  Local origin sits on the plate's BACK face, neck top at y = 0. The peg grows
//  into -Z: first across the standoff gap, then through the board, then the barb.
//
//  Fitting: push all pegs in near the top of their slots, then drop the part
//  ~11 mm. The neck lands on the slot's bottom edge and the barb sits behind the
//  board. neck_h + barb_h = 9 mm, comfortably inside the 15 mm slot.
//
//  Printing: with the plate's front face on the bed (pegs up) the barb's only
//  overhang is its 45 deg ramp, so this needs no supports.

module skadis_peg(so = 0) {
    w   = slot_w - peg_clear;         // 4.6 in a 5.0 slot
    nd  = so + board_t + peg_gap;     // neck depth: standoff, then through
    tot = nd + barb_d;                // total protrusion behind the plate
    ch  = 0.8;                        // lead-in chamfer on the back top corner

    pts = [
        [0,           0                ],
        [-(tot - ch),  0               ],
        [-tot,        -ch              ],
        [-tot,        -(neck_h + barb_h)],  // barb tip: deepest and lowest
        [-nd,         -neck_h          ],   // 45 deg ramp back up to the neck
        [0,           -neck_h          ],
    ];

    translate([w / 2, 0, 0])
        rotate([0, -90, 0])
            linear_extrude(height = w)
                polygon(pts);
}

// rounded rectangle / square helpers
module rrect(w, h, r) {
    offset(r = r) offset(r = -r) square([w, h], center = true);
}
module rsq(size, r) { rrect(size, size, r); }

// =============================================================================
//  Part 1: slide-in captive plate
// =============================================================================
//  Plate front face (z = tongue_t) lies against the well floor and the tabs grip
//  its edges. Standoff ribs and pegs grow into -Z toward the pegboard.
//
//  Deliberately ONE flat plate rather than a stepped plate with an oversailing
//  slab: a step would leave an unsupported ledge on the bed. This way the whole
//  thing prints face-down with nothing but the self-supporting peg barbs above.

module slide_in_bracket() {
    sq   = plate_sq - tongue_fit;              // 112.0
    lead = min(lead_in, tongue_t * 0.6);       // never chamfer the plate away

    // The dead centre of the plate: everything inside the ring and between the
    // two cross ribs. No load path runs through it, so it is the one place mass
    // can leave without costing anything.
    ring_in = sq - 2 * rib_in - 2 * rib_w;                      // ring's bore
    rib_in_edge = abs(peg_rows[0]) - neck_h / 2 - rib_w / 2;    // cross rib inner edge
    win_x = ring_in - 2 * light_edge;
    win_y = 2 * rib_in_edge - 2 * light_edge;

    // ---- plate, with a chamfered leading edge on +Y so it feeds under the
    //      tabs instead of butting into them
    difference() {
        linear_extrude(height = tongue_t)
            rsq(sq, 4);

        translate([0, sq / 2, tongue_t])
            rotate([45, 0, 0])
                translate([-sq, -lead, -lead])
                    cube([sq * 2, lead * 2, lead * 2]);

        // weight-saving window. The tabs grip the perimeter and the load runs
        // perimeter -> ring -> cross ribs -> pegs, all of it outside this hole,
        // so it costs no strength. It also vents the well.
        if (lighten)
            translate([0, 0, -1])
                linear_extrude(height = tongue_t + 2)
                    rrect(win_x, win_y, 8);
    }

    // ---- standoff ribs on the back: a perimeter ring plus a cross rib through
    //      each peg row. The ring carries the load onto the board and stiffens
    //      the plate; the cross ribs are the pegs' roots.
    translate([0, 0, -standoff])
        linear_extrude(height = standoff) {
            // perimeter ring
            difference() {
                rsq(sq - 2 * rib_in, 4);
                rsq(sq - 2 * rib_in - 2 * rib_w, 2);
            }
            // cross rib centred on each peg row's neck
            for (y = peg_rows)
                translate([0, y - neck_h / 2, 0])
                    square([sq - 2 * rib_in, rib_w], center = true);
        }

    // ---- pegs
    for (x = peg_cols, y = peg_rows)
        translate([x, y, 0])
            skadis_peg(standoff);
}

// =============================================================================
//  Part 2: cradle hooks
// =============================================================================
//  No router measurements needed at all. Two of these, 160 mm apart (4 slot
//  columns), carry the 230 mm wide body. The 62 mm shelf takes the full 56 mm
//  depth and the lip stops it tipping off the front.
//
//  PRINT: lay it on its side, the 30 mm flat face on the bed. The body then
//  extrudes in the bed plane with no overhangs at all. The two pegs are the only
//  exception - give them tree supports.

module cradle_hook() {
    w  = hook_plate_w;
    h  = hook_plate_h;
    t  = hook_plate_t;
    st = hook_shelf_t;
    yb = -h / 2;                // backplate bottom edge
    ys = yb + hook_gusset;      // shelf underside, sits a gusset's height up

    union() {
        // backplate
        translate([-w / 2, yb, 0])
            cube([w, h, t]);

        // shelf. Router's bottom edge lands on its top face, at ys + st.
        translate([-w / 2, ys, t])
            cube([w, st, hook_shelf_d]);

        // front lip, 1 mm clear of the router's front face
        translate([-w / 2, ys, t + hook_shelf_d - hook_lip_t])
            cube([w, st + hook_lip_h, hook_lip_t]);

        // triangular web from the shelf's UNDERSIDE down the backplate
        translate([w / 2, 0, 0])
            rotate([0, -90, 0])
                linear_extrude(height = w)
                    polygon([
                        [t,               ys],
                        [t,               yb],
                        [t + hook_gusset, ys],
                    ]);
    }

    // two pegs in one column, 40 mm apart. A single peg would let the hook swing
    // about its own axis; two rows lock it.
    for (y = [skadis_pitch / 2, -skadis_pitch / 2])
        translate([0, y, 0])
            skadis_peg(0);
}

// =============================================================================
//  Render
// =============================================================================

if      (part == "bracket") slide_in_bracket();
else if (part == "hooks")   cradle_hook();
else if (part == "all") {
    slide_in_bracket();
    translate([-120, 0, 0]) cradle_hook();
}
