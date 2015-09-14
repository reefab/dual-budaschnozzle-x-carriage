duct_height = 20;
hole_x = 30;
hole_y = 98;

module cooling_duct() {
    difference() {
        union() {
            /* translate([0, 0, -2]) cube([rod_dist + body_width, base_length, duct_height], center=true); */
            cube([rod_dist + body_width, base_length, duct_height], center=true);
            // front/back fans fascia
            for(i=[-1, 1]) {
                translate([i * (body_width/2 + rod_dist/2 -body_wall_thickness/2), 0, -duct_height/2]) {
                    translate([i*body_wall_thickness/4, 0, -2.5]) {
                        cube([body_wall_thickness/2, 49, 45], center=true);
                        translate([0, 0, -duct_height/2 + 5]) cube([body_wall_thickness/2, base_length, 16], center=true);
                    }
                    rotate([90, 0, -i*90]) quarter_sphere(18.5);
                }
            }
        }

        for (i=[-1, 1]) {
            // hotend nozzle holes
            translate([0, 0, -5]) cube([hole_x, hole_y, duct_height+1], center=true);

            // fan holes
            translate([i * (body_width/2 + rod_dist/2 -body_wall_thickness/2), 0, -duct_height/2]) difference() {
                sphere(d=37-body_wall_thickness/2);
                translate([0, 0, -15]) cube([25, 30, 10], center=true);
            }

            // rod clearance
            translate([i * rod_dist/2, 0, -27]) cube([15, 30, 10], center=true);

            // interior duct works
            for(j=[-1,1]) {
                 translate([i*26, 0, 0.5]) quarter_pipe([17, base_length - body_wall_thickness - 17, duct_height - body_wall_thickness], center=true, flip=i);
                 translate([i*17.5, j*29, duct_height/2 -2 ]) rotate([0,0,0]) cube([10, 32, 2], center=true);
                 translate([0, 0, duct_height/2 -2 ]) cube([40, 32, 2], center=true);
            }


            // fanduct nozzle holes
             for(i=[-1,1]) {
                translate([0, i*hotends_spacing/2, duct_height/2 - 3]) {
                      cylinder(d=35, h=3.1);
                      translate([0,0, -7]) cylinder(d1=23, d2=18, h=15);
                }
            }

            for(j=[-1,1]) {
                // front/back fan holes
                translate([ i*(body_width/2 + rod_dist/2 - body_wall_thickness), j*fan_hole_spacing/2, duct_height/2 -3]) rotate([0, -90, 0]) {
                    cylinder(d=3+clearance, h=15, center=true, $fn=10);
                }
                // side fans holes
                translate([i * fan_hole_spacing/2, j*(base_length/2 - body_wall_thickness) + 1.5, -duct_height/2 + 3]) rotate([0, 90, 90]) {
                    nutcatch_sidecut("M3", l=4);
                    cylinder(d=3+clearance, h=15, center=true);
                }
                translate([i * (body_width/2 + rod_dist/2 -body_wall_thickness) -1, j*fan_hole_spacing/2, 6.5])
                     rotate([0, -90, 0])  {
                         nutcatch_sidecut("M3", l=4);
                    }
            }
        }
    }
    // nozzle airflow separators
    for(i=[-1,1]) {
        translate([0, i*hotends_spacing/2, duct_height/2 - 3])
            difference() {
                 union() {
                     cylinder(d1=25, d2=20, h=3);
                     for(j=[45, 135, 225, 315]) {
                          rotate(j) cube([1,25, 3]);
                        }
                 }
                 translate([0,0, -7]) cylinder(d1=23, d2=18, h=15);
            }
    }
    // Middle airflow separator
    translate([0, 0, duct_height/2 -2 ]) rotate([0, 0, 35]) cube([40, 2, 3], center=true);

    // support columns for easier printing of the central bridges
    for(i=[-1,1]) {
        translate([0, i*9, duct_height/2 -2 ]) rotate([0, 0, 35]) cylinder(d=3, h=3, center=true, $fn=20);
        for(j=[-hotends_spacing/2, 0, hotends_spacing/2])
            translate([-i*17.5, j, duct_height/2 -2 ]) rotate([0, 0, 35]) cylinder(d=3, h=4, center=true, $fn=20);
    }

    // front fans nut traps
    for(i=[-1,1]) {
        for(j=[-1,1]) {
            translate([i * (body_width/2 + rod_dist/2 -body_wall_thickness) - 1, j*fan_hole_spacing/2, 6.5])
                difference() {
                     translate([1, 0, 0]) cube([5,8,7], center=true);
                     rotate([0, -90, 0])  { 
                         nutcatch_sidecut("M3", l=4);
                         cylinder(d=3+clearance, h=15, center=true);
                    }
                }
        }
    }

}

module quarter_pipe(dimensions, radius=10, center=true, flip=1) {
    vec = center ? [-dimensions[0]/2, -dimensions[1]/2, -dimensions[2]/2] : [0, 0, 0];
    rot = (flip==-1) ? [0, 0, 180] : [0, 0, 0];

    rotate(rot) translate(vec) difference() {
        cube(dimensions);
        translate([radius, dimensions[1] + 0.5, radius]) rotate([-90, 0, 180]) difference() {
            cube([radius + 1, radius + 1, dimensions[1] + 1]);
            cylinder(r=radius, h=dimensions[1] + 1);
        }
    }
}

module quarter_sphere(radius) {
    difference() {
        sphere(r=radius);
        translate([-radius, 0, -radius]) cube([radius*2, radius, radius*2]);
        translate([-radius, -radius, -radius]) cube([radius*2, radius + 2, radius]);
    }
}
