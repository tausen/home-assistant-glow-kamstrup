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
tol = 0.002;

module pcbholder() {
    difference() {
        cube([ph, ph+tol, h]);
        translate([-tol, 2, -tol+ph/2])
            cube([ph-ph/2+tol, ph-ph/2, h+tol]);
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
        }
    }
    
    // pcb holder plane
    translate([0, -ppd, 0])
        cube([d+fw+bw, ppd+tol, h+tw]);
    
    // right pcb holder
    translate([d+fw+bw-ph-phd, -ppd-ph, tw/2])
        pcbholder();
    
    // left pcb holder
    translate([phd, -ppd-ph, tw/2]) // position
        translate([ph, ph+tol, 0]) // compensate for rotation
        rotate([180, 180, 0]) // rotate
        pcbholder();

}