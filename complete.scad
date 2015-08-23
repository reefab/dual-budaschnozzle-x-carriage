// Jonas Kühling <mail@jonaskuehling.de>
// Derivate of http://www.thingiverse.com/thing:16208

// PRUSA Mendel
// LM8UU-Bearing X-Carriage
// Used for sliding on X axis
// GNU GPL v2
// Simon Kühling <mail@simonkuehling.de>
// Derived from
//  - "Lm8uu X Carriage with Fan Mount for Prusa Mendel" by Greg Frost
//    http://www.thingiverse.com/thing:9869

// Gregs configuration file
include <x-carriage/configuration.scad>

include <x-carriage/LM8UU_holder_ziptie.scad>

include <x-carriage/nutsnbolts/cyl_head_bolt.scad>

// Fan module, for display only
include <x-carriage/fan.scad>

include <x-carriage/carriage.scad>
include <x-carriage/belt_clamp.scad>
include <x-carriage/cooling.scad>

draw_carriage = 1;
draw_belt_clamps = 0;
draw_side_fan_duct = 0;
draw_rear_fan_duct = 0;
draw_cooling_duct = 1;

base_length = 110;
rod_dist = 50;

hotends_spacing = 58;
space_width = 30;
fan_hole_spacing = 32;
rear_fan_duct_hole_spacing = 15;

if (draw_carriage == 1) {
    rotate([0, 180, 0]) simonkuehling_x_carriage();
    rotate([0, 180, 0]) % mount_plate();
    // side fans
    for (i=[-1,1]) {
        translate([0, i* (base_length/2 + 5), -18]) {
            rotate([0, 90, 90]) % fan(40,10.2);
        }
    }
    // Rods
    for (i=[-1,1])
        translate([25* i, 0, -(LM8UU_dia/2+body_wall_thickness+4)])
            rotate([90,0,0])
            % cylinder(h=base_length*2,r=4,$fs=1,center=true);
    if (draw_cooling_duct == 1) {
        for (i=[-1,1]) {
            translate([i* (rod_dist/2 + body_width/2 + 5), 0, -33]) {
                rotate([0, -90, 0]) % fan(40,10.2);
            }
        }
        rotate([0, 180, 0]) translate([0,0,42]) cooling_duct();
    }
}


if (draw_belt_clamps == 1 && draw_carriage == 0) {
    for (i=[-1,1])
        translate([0,i*(28),0])
            belt_clamp();
}

if (draw_side_fan_duct == 1 && draw_carriage == 0) {
    rotate([0, 180, 0]) side_fan_duct();
}

if (draw_rear_fan_duct == 1 && draw_carriage == 0) {
    fan_duct();
}

if (draw_cooling_duct == 1 && draw_carriage == 0) {
    rotate([180, 0, 0]) cooling_duct();
}

clearance=0.7;
lm8uu_diameter=15+clearance;
lm8uu_length=24+clearance;
lm8uu_support_thickness=3.2;
lm8uu_end_diameter=m8_diameter+1.5;

lm8uu_holder_width=lm8uu_diameter+2*lm8uu_support_thickness;
lm8uu_holder_length=lm8uu_length+2*lm8uu_support_thickness;
lm8uu_holder_height=lm8uu_diameter*0.75+lm8uu_support_thickness;

lm8uu_holder_gap=(lm8uu_holder_length-6*lm8uu_support_thickness)/2;

screw_hole_r=4/2;


/* include <extruder/extruder.scad>; */
