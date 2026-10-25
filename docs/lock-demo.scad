// One slot of the board, seen from the bracket side, with and without the lock.
include <../src/skadis_101_mount.scad>

part = "none";       // the last assignment wins, so the file renders nothing
show_wedge = true;   // overridden with -D on the command line

w  = slot_w - wedge_clear;
h  = slot_h - neck_h - wedge_fit;
bz = -(standoff + board_t);     // board back face

module board_tile() {
    difference() {
        translate([-16, -16, bz]) cube([32, 40, board_t]);
        translate([-slot_w / 2, -neck_h, bz - 1])
            cube([slot_w, slot_h, board_t + 2]);
    }
}

color("#b9c2cb") board_tile();
color("#44515c") skadis_peg(standoff);

if (show_wedge)
    color("#c6491a")
        translate([w / 2, 0, bz])
            rotate([0, -90, 0])
                lock_wedge();
