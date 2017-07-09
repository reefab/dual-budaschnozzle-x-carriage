module bridge() {
    difference() {
        union() {
            cube([39, 70, 5]);
            translate([0.7, 0, 3]) rotate([270, 0, 0]) cylinder(d=4, h=70, $fn=20);
            translate([39, 0, 3]) rotate([270, 0, 0]) cylinder(d=4, h=70, $fn=20);
            translate([-1.2, 0, 0]) cube([42.1, 70, 3]);
        };
        translate([3, -3, 0]) linear_extrude(height = 5) polygon([[0,10], [0, 65], [30, 10]]);
        translate([36, 72, 0]) rotate([0, 0, 180]) linear_extrude(height = 5) polygon([[0,10], [0, 65], [30, 10]]);
        translate([39/2 + 2, 70/2 - 1, 2.5]) {
            for(i=[-1,1]) for(j=[-1,1]) {
                translate([i*15.5, j*31, 0]) rotate([90, -90, 0]) nutcatch_sidecut("M3", l=5);
                translate([i*15.5, j*31 - 3, 0]) rotate([90, -90, 0]) hole_through("M3", l=10);
            }
        }
        translate([21, 32.5, 0])  cube([20, 5, 5]);
    }
    translate([21, 30, 0]) difference() {
        cube([18, 10, 5]);
        translate([2.5, 2.5, 0]) cube([20, 5, 5]);
    }
}
