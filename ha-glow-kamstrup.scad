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
tth = 69.5; // distance from top excl tw to center of hole
shd = fw-8; // sensor hole depth
pcbw = 2.5; // pcb width
pcbf = pcbw; // pcb front
pcbb = 3; // pcb back
pcbt = 3; // pcb tab width
spcbh = 16; // sensor pcb height
spcbd = 67.5; // sensor pcb slit depth
spcbt = 2; // sensor pcb slit tab width
tol = 0.002;

difference() {
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
                // +7: total width increased by 7mm after measurements
                translate([d+bw-tol, 110-100.75-2.5+7, h-83-nh/2])
                    cube([nd+tol, nw, nh]);

                // sensor hole
                translate([d+bw-tol, w-rw-rhw-15, h-tth])
                    rotate([0, 90, 0])
                    cylinder(h=fw+2*tol, d=5);
                // ..with submersion ring
                translate([d+bw+fw-shd, w-rw-rhw-15.5, h-tth])
                    rotate([0, 90, 0])
                    cylinder(h=shd+tol, d=6);
            }
        }

        difference() {
            // pcb holder plane
            translate([0, -ppd, 0])
                cube([d+fw+bw, ppd+tol, h+tw]);

            // left pcb holder slit
            union() {
                // mid
                translate([(bw+fw)/2, -ppd+pcbf, tw])
                    cube([d, pcbw, h+tol]);

                // outer
                translate([(bw+fw)/2+pcbt, -ppd-tol, tw])
                    cube([d-pcbt*2, pcbt+tol*2, h+tol]);

                // inner
                translate([(bw+fw)/2+pcbt, -ppd-tol+pcbf+pcbw, tw])
                    cube([d-pcbt*2, pcbt+tol*2, h+tol]);
            }
        }

        // extension plate for sensor pcb holder
        translate([d+bw+fw-fw/2, lw-tol, h-fhh-tol])
            cube([fw/2, w-lw-rw-rhw+tol, 5+tol]);
    }

    union() {
        // sensor pcb slit mid
        translate([d+bw+fw-pcbf-pcbw, -ppd-tol, h-tth-spcbh/2])
            cube([pcbw+tol, spcbd, spcbh]);

        // sensor pcb slit outer
        translate([d+bw+fw-pcbf, -ppd-tol, h-tth-spcbh/2+spcbt])
            cube([pcbw+tol, spcbd, spcbh-spcbt*2]);

        // sensor pcb slit inner; 1mm bottom tab, 5mm height
        translate([d+bw+fw-pcbf*2-pcbw, -ppd-tol, h-tth-spcbh/2+1])
            cube([pcbw+tol, spcbd, 5]);
    }
}