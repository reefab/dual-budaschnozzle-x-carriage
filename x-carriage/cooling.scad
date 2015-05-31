duct_height = 20;

module cooling_duct() {
    difference() {
        cube([rod_dist + body_width, base_length, duct_height], center=true);
        for (i=[-1, 1]) {
            translate([0, i*(hotends_spacing -5)/2, 0]) cube([30, 40, duct_height], center=true);
            for(j=[-1,1]) {
                // front/back fan holes
                translate([ i*(body_width/2 + rod_dist/2 - body_wall_thickness), j*fan_hole_spacing/2, duct_height/2 -3]) rotate([0, -90, 0]) {
                    # nutcatch_sidecut("M3", l=3);
                    # cylinder(d=3+clearance, h=15, center=true);
                }
                // side fans holes
                translate([i * fan_hole_spacing/2, j*(base_length/2 - body_wall_thickness), -duct_height/2 + 3]) rotate([0, 90, 90]) {
                    # nutcatch_sidecut("M3", l=3);
                    # cylinder(d=3+clearance, h=15, center=true);
                }
            }
        }
    }
}
