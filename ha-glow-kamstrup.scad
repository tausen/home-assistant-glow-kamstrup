$fa = 1;
$fs = 0.4;
tw = 15; // top width
bw = 5; // back width 
fw = 15; // front width
h = 105; // height excl tw
d = 64; // depth excl fw/bw
w = 117; // width
bh = 30; // back height excl tw
lw = 27; // left hook width
rw = 15; // right hook width
fhh = 65; // front hole height excl tw
rhw = 28; // front right hole width
rhh = 20; // front right hole height
nw = 40; // nub cutout width
nh = 10; // nub cutout height
nd = 5; // nub cutout depth
ppd = 15; // pcb holder plane depth
ph = 8; // pcb holder width and height
phd = 10; // pcb holder distance from edge
sh = 5; // sensor pcb holder height
tth = 69.5; // distance from top excl tw to center of hole
tol = 0.002;

// pcb slide-in rail
// a: short dimensions
// b: long dimension
module pcbholder(a, b) {
    difference() {
        cube([a, a, b]);
        translate([-tol, a/4, -tol+a/2])
            cube([a-a/2+tol, a-a/2, b+tol]);
    }
}

union() {
    // main
    difference() {
        // "main" box
        cube([bw+d+fw, w, h+tw]);

        // cutouts
        union() {
            // sideways middle
            translate([bw, -tol, -tol])
                cube([d, w+tol*2, h+tol]);

            // sideways back
            translate([-tol, -tol, -tol])
                cube([bw+2*tol, w+tol*2, h-bh+tol]);

            // front top
            translate([-tol, lw, h+tw-(fhh+tw)])
                cube([bw+d+fw+2*tol, w-lw-rw, fhh+tw+tol]);

            // front right
            translate([-tol, w-rw-rhw,h+tw-(fhh+tw+rhh)])
                cube([bw+d+fw+2*tol, rhw, rhh+tol]);

            // nub cutout, position based on measurements
            translate([d+bw-tol, 110-100.75-2.5+7, h-83-nh/2])
                cube([nd+tol, nw, nh]);

            // sensor hole
            translate([d+bw-tol, w-rw-rhw-15, h-tth])
                rotate([0, 90, 0])
                cylinder(fw+2*tol, 2.5, 2.5);            

        }
    }

    // pcb holder plane
    translate([0, -ppd, 0])
        cube([d+fw+bw, ppd+tol, h+tw]);

    // right pcb holder
    translate([d+fw+bw-ph-phd, -ppd-ph+tol, tw/2])
        pcbholder(ph, h);

    // left pcb holder
    translate([phd, -ppd-ph+tol, tw/2]) // position
        translate([ph, ph, 0]) // compensate for rotation
        rotate([180, 180, 0]) // rotate
        pcbholder(ph, h);

    // sensor pcb holder upper
    translate([d+fw+bw-tol, 10, h-tth-sh/2+17/2])
        translate([sh, 40, 0]) // compensate for rotation
        rotate([90, 270, 0])
        pcbholder(sh, 50);
    translate([d+fw+bw-tol, 10, h-tth-sh/2-17/2])
        translate([0, 40, sh]) // compensate for rotation
        rotate([90, 90, 0])
        pcbholder(sh, 50);

    // extension plate for sensor pcb holder
    translate([d+bw+fw-fw/2, lw-tol, h-fhh-tol])
        cube([fw/2, w-lw-rw-rhw+tol, 10+tol]);

}