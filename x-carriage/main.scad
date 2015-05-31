// Jonas Kühling <mail@jonaskuehling.de>
// Derivate of http://www.thingiverse.com/thing:16208
// - Reinforced frame
// - Added two fan/equipment mounts
// ********************************************

// PRUSA Mendel
// LM8UU-Bearing X-Carriage
// Used for sliding on X axis
// GNU GPL v2
// Simon Kühling <mail@simonkuehling.de>
// Derived from
//  - "Lm8uu X Carriage with Fan Mount for Prusa Mendel" by Greg Frost
//    http://www.thingiverse.com/thing:9869
//  - "Slim LM8UU Holder Parametric" by Jonas Kühling
//    http://www.thingiverse.com/thing:16158

// Gregs configuration file
include <configuration.scad>

include <LM8UU_holder_ziptie.scad>

include <nutsnbolts/cyl_head_bolt.scad>

// Fan module, for display only
include <fan.scad>

include <carriage.scad>
include <belt_clamp.scad>
include <side_fanduct.scad>
include <rear_fanduct.scad>
include <cooling.scad>

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
    simonkuehling_x_carriage();
    % mount_plate();
    // side fans
    for (i=[-1,1]) {
        translate([0, i* (base_length/2 + 5), 18]) {
            rotate([0, 90, 90]) % fan(40,10.2);
        }
    }
    // side fanducts
    if (draw_side_fan_duct == 1) {
        translate([0, (base_length/2 + 5), 18]) side_fan_duct();
        translate([0, -(base_length/2 + 5), 18]) rotate([0, 0, 180]) side_fan_duct();
    }
    // Rods
    for (i=[-1,1])
        translate([25* i,0,LM8UU_dia/2+body_wall_thickness+4])
            rotate([90,0,0])
            % cylinder(h=base_length,r=4,$fs=1,center=true);
    // rear fan duct
    if (draw_rear_fan_duct == 1) {
        translate([-body_width/2 -rod_dist/2 -body_wall_thickness/2, 20, 0]) {
            rotate([0, -90, 180]) fan_duct();
            translate([-5.1, -20, 30]) rotate([0, 90, 0]) % fan(40,10.2);
        }
    }
    if (draw_cooling_duct == 1) {
        for (i=[-1,1]) {
            translate([i* (rod_dist/2 + body_width/2 + 5), 0, 28]) {
                rotate([0, 90, 0]) % fan(40,10.2);
            }
        }
        translate([0,0,40]) cooling_duct();
        /* translate([-rod_dist/2 -body_width/2, -base_length/2, 30]) cooling_duct(); */
    }
}

module mount_plate()
{
    rotate([180, 0, 0]) union()
    {
        cube([71, 85, 5], center = true);
        translate([0, hotends_spacing/2, -44]) rotate([0, 0, 180]) import("Budaschnozzle.stl");
        translate([0, -hotends_spacing/2, -44]) rotate([0, 0, 0]) import("Budaschnozzle.stl");
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
    cooling_duct();
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

function triangulate (point1, point2, length1, length2) = 
point1 + 
length1*rotated(
        atan2(point2[1]-point1[1],point2[0]-point1[0])+
        angle(distance(point1,point2),length1,length2));

function distance(point1,point2)=
sqrt((point1[0]-point2[0])*(point1[0]-point2[0])+
        (point1[1]-point2[1])*(point1[1]-point2[1]));

function angle(a,b,c) = acos((a*a+b*b-c*c)/(2*a*b)); 

function rotated(a)=[cos(a),sin(a),0];
