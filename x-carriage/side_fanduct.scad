module side_fan_duct() {
    difference() {
        cylinder(d=40, h=20);
        cylinder(d=37, h=19);
        translate([-20, -5, 0]) cube([40, 40, 40]);
        translate([-20, -55, -28]) cube([40, 40, 40]);
    }
    for(i=[-1,1]) {
        translate([i*fan_hole_spacing/2, -7.5, 15]) {
            difference() {
                cube([5,5,8], center=true);
                rotate([90, 0, 0]) cylinder(d=3, h=6, center=true);
            }
        }
    }
}

