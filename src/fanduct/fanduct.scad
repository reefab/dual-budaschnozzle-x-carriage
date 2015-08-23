duct_height = 20;
hole_x = 30;
hole_y = 35;

module cooling_duct() {
    difference() {
        union() {
            cube([rod_dist + body_width, base_length, duct_height], center=true);
            // front/back fans fascia
            for(i=[-1, 1]) {
                translate([i * (body_width/2 + rod_dist/2 -body_wall_thickness/2), 0, -duct_height/2]) {
                    cube([body_wall_thickness, 40, 40], center=true);
                    rotate([90, 0, -i*90]) quarter_sphere(18.5);
                }
                // baffle for the side fans
                /* translate([0, i*(base_length/2 -10.5), -duct_height/2 - 2.5]) cube([40, 5, 5], center=true); */
            }
        }

        for (i=[-1, 1]) {
            // hotend nozzle holes
            translate([0, i*(hotends_spacing -8)/2, -5]) cube([hole_x, hole_y, duct_height+1], center=true);

            // fan holes
            translate([i * (body_width/2 + rod_dist/2 -body_wall_thickness/2), 0, -duct_height/2]) difference() {
                sphere(d=37-body_wall_thickness);
                translate([0, 0, -15]) cube([25, 30, 10], center=true);
            }

            // rod clearance
            translate([i * rod_dist/2, 0, -27]) cube([15, 30, 10], center=true);

            // interior duct works
            for(j=[-1,1]) {
                 translate([i*23.5, j*18.5, 0.5]) quarter_pipe([16, 37, duct_height - body_wall_thickness], center=true, flip=i);
                 translate([i*23.5, j*40, 0.5]) rotate([j*90, 0, 0]) quarter_pipe([16, duct_height - body_wall_thickness, 10], center=true, flip=-i);
                 translate([i*17.5, j*29, duct_height/2 -2 ]) rotate([0,0,0]) cube([10, 32, 2], center=true);
                 translate([i*12.5, i*6.5, duct_height/2 -2 ]) rotate([0,0,0]) cube([35.5, 10, 2], center=true);
                 translate([i*0, i*8, duct_height/2 -2 ]) rotate([0,0,0]) cube([10, 10, 2], center=true);
            }

            // let's call them speed holes
            /* translate([i*26, i*-(base_length/4 + 6), 0]) cube([15, base_length/2 -25, duct_height + 1], center=true); */
            translate([0, i*-(base_length/2 - body_wall_thickness), 0]) cube([20, 10, duct_height + 1], center=true);
            translate([0, 0, -5]) cube([30, 12, duct_height + 1], center=true);


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
                    cylinder(d=2.7, h=15, center=true, $fn=10);
                }
                // side fans holes
                translate([i * fan_hole_spacing/2, j*(base_length/2 - body_wall_thickness) + 1.5, -duct_height/2 + 3]) rotate([0, 90, 90]) {
                    nutcatch_sidecut("M3", l=4);
                    cylinder(d=3+clearance, h=15, center=true);
                }
            }
        }
    }
    for(i=[-1,1]) {
        translate([0, i*hotends_spacing/2, duct_height/2 - 3])
            difference() {
                 union() {
                     cylinder(d1=25, d2=20, h=3);
                     for(j=[30, 150, 210, 330]) {
                          rotate(j) cube([1,18, 3]);
                        }
                 }
                 translate([0,0, -7]) cylinder(d1=23, d2=18, h=15);
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

