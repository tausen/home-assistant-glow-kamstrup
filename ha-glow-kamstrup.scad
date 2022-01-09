$fa = 1;
$fs = 0.4;
tw = 5; // top width
bw = 5; // back width 
fw = 15; // front width
h = 105; // height excl tw
d = 64; // depth excl fw/bw
w = 110; // width
tol = 0.002;
difference() {
    // "main" box
    cube([bw+d+fw, w, h+tw], center=true);
    
    // cutouts
    union() {
        // sideways middle
        translate([-5, 0, -(tw/2+tol)])
            cube([d, w+tol*2, h], center=true);

        // sideways back
        translate([-((bw+d+fw)/2-bw/2+tol), 0, -(30+tw)])
            cube([bw+4*tol, w+tol*2, h+tw], center=true);

        // front top
        translate([0, 2.5, (h+tw-(65+tw))/2+tol])
            cube([bw+d+fw+2*tol, w-20-15, 65+tw], center=true);

        // front right
        translate([0, w/2-15-28/2, (h+tw)/2-(65+5)-20/2+tol])
            cube([bw+d+fw+2*tol, 28, 20+2*tol], center=true);

        // nub cutout, depth is [cube x size]/2
        translate([(bw+d+fw)/2-fw, -(10+17.6), -(83+tw-(h+tw)/2)])
            cube([10, 40, 10], center=true);
    }
}
