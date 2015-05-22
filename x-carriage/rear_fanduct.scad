// FIXME: not very parametric

fanduct_wall_thickness = 2;
fanduct_height = 52.5;
fanduct_width = 40;
fanduct_length =  50;
nozzle_length = 15;
nozzle_height = 6;

module fan_duct() {

    difference() {
        // main plate
        cube([fanduct_height, fanduct_width, fanduct_wall_thickness]);
        // holes for affixing to the x-carriage
        for(i=[-1,1]) {
                translate([body_wall_thickness + 3, fanduct_width/2 + i*rear_fan_duct_hole_spacing/2, fanduct_wall_thickness/2])
                     rotate([0, 180, 0]) cube([7, 3+clearance, fanduct_wall_thickness + 1], center=true);
                     /*hole_through("M3", l=fanduct_wall_thickness);*/
        }
        // fan hole
        translate([fanduct_height-20, fanduct_width/2, 0]) {
            cylinder(d=36, h=fanduct_wall_thickness);
            // fan support holes
            for(i=[-1,1])
                for(j=[-1,1])
                    translate([i*fan_hole_spacing/2, j*fan_hole_spacing/2, 0])
                          rotate([0, 180, 0]) hole_through("M3", l=fanduct_wall_thickness);
        }
    }

    // bottom part
    difference() {
        union() {
            // bottom plate
            difference() {
            translate([fanduct_height - fanduct_wall_thickness + 2, 0, 0]) cube([fanduct_wall_thickness, fanduct_width, fanduct_length]);
                 // nozzle holes
                 for(i=[-1,1]) {
                    translate([fanduct_height - fanduct_wall_thickness/2 + 2, fanduct_width/2 + i*(14), fanduct_length - nozzle_length - 2] ) cylinder(d=8, h=nozzle_length);
                }
            }
            // bottom walls
            difference() {
                translate([fanduct_height - nozzle_height, 0, fanduct_wall_thickness]) cube([nozzle_height, fanduct_width, fanduct_length - fanduct_wall_thickness]);
                translate([fanduct_height - nozzle_height, 1, fanduct_wall_thickness]) cube([nozzle_height, fanduct_width - 2, fanduct_length - fanduct_wall_thickness -1]);
            }
            // bottom "roof"
            translate([fanduct_height - nozzle_height, 0, fanduct_length - nozzle_length - fanduct_wall_thickness * 2]) cube([fanduct_wall_thickness, fanduct_width, nozzle_length + fanduct_wall_thickness * 2]);
            // "fork"
            translate([fanduct_height - 6, fanduct_width/2, fanduct_length - 10]) {
                rotate([0, 90, 0]) cylinder(d=15, h=7);
                translate([0, -15/2,0]) cube([7, 15, 10]);
            }
        }
        translate([fanduct_height - 15, fanduct_width/2, fanduct_length - 10]) {
            rotate([0, 90, 0]) cylinder(d=13, h=20);
            translate([0, -13/2,0]) cube([20, 13, 15]);
        }
    }

    difference() {
        union() {
            // first funnel
            translate([fanduct_height-20, fanduct_width/2, fanduct_wall_thickness]) {
                difference() {
                    funnel(d1=40, d2=39, l=20, height=10, thickness=fanduct_wall_thickness, offset=[-100,0,0]);
                    translate([34, 0, 0]) cube([40,40,20], center=true);
                }
            }

            // second funnel
            translate([fanduct_height-17.5, fanduct_width/2, fanduct_wall_thickness + 10]) {
                difference() {
                    union() {
                        funnel(d1=39, d2=0, l=18, height=20, thickness=fanduct_wall_thickness, offset=[-13,0,0]);
                        difference() {
                            translate([11.5, -fanduct_width/2, 0]) cube([fanduct_wall_thickness, fanduct_width, 21]);
                            funnel(d1=39, d2=0, l=20, height=20, thickness=100, offset=[-13,0,0]);
                        }
                    }
                    translate([13.5, -fanduct_width/2, -1]) cube([25, fanduct_width,21]);
                }
            }
            // reinforcement to prevent hole after rod clearance
            translate([22, fanduct_width/2, fanduct_wall_thickness + 10.5]) {
                 cube([2,20,3], center=true);
            }
        }
        // rod clearance
         translate([14.5, fanduct_width/2, fanduct_wall_thickness + 10]) {
            rotate([90, 0, 0]) cylinder(d=10, h=30, center=true);
        }
    }
}

module funnel(d1, d2, l, height, thickness, offset=[0, 0, 0], center=true) {
    translate([0, 0, height/2]) translate(-offset) difference() {
        linear_extrude(height = height, scale = d2/d1, center = center) translate(offset) base(d=d1, l=l);
        if (d2 <= thickness) {
            translate([0, 0, -thickness]) linear_extrude(height = height, scale = d2/d1, center = center) translate(offset) base(d=d1, l=l);
        } else {
            linear_extrude(height = height, scale = (d2 - thickness * 2)/(d1 - thickness), center = center) translate(offset) base(d=d1 - thickness * 2, l=l -thickness);
        }
    }
}

module base(d, l) {
        circle(d = d);
        translate([0, -d/2, 0]) square([l, d]);
}

