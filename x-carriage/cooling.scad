duct_height = 20;
hole_x = 30;
hole_y = 35;

module cooling_duct() {
    difference() {
        cube([rod_dist + body_width, base_length, duct_height], center=true);
        for (i=[-1, 1]) {
            // hotend nozzle holes
            translate([0, i*(hotends_spacing -8)/2, 0]) cube([hole_x, hole_y, duct_height], center=true);

            // carving inside space
            for(j=[-1,1]) {
                translate([i*10, j*3, 0]) cube([18, 4, duct_height - body_wall_thickness], center=true);
                translate([i*10, j*46, 0]) cube([18, 4, duct_height - body_wall_thickness], center=true);
                translate([i*25, j*(base_length/4 -3), 0]) cube([18, base_length/2 - 8, duct_height - body_wall_thickness], center=true);
            }

            // fanduct nozzle holes
            for(j=[-1,1]) {
                translate([i*10, j*3,  duct_height/2])  cube([18, 4, body_wall_thickness], center=true);
                translate([i*10, j*46, duct_height/2])  cube([18, 4, body_wall_thickness], center=true);
                translate([i*18, j*(base_length/4 - 3), duct_height/2]) cube([4, base_length/2 - 8, body_wall_thickness], center=true);
            }


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
