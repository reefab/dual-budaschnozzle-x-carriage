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

include <nutsnbolts/cyl_head_bolt.scad>;

// Fan module
include <fan.scad>

include <funnel.scad>

draw_carriage = 1;
draw_belt_clamps = 0;
draw_side_fan_duct = 0;
draw_rear_fan_duct = 0;

belt_clamp_thickness=2;
belt_clamp_width=m3_diameter+3*belt_clamp_thickness+2;


base_length = 110;
rod_dist = 50;

hotends_spacing = 58;
space_width = 30;
fan_hole_spacing = 32;
rear_fan_duct_hole_spacing = 15;


if (draw_carriage == 1) {
    % simonkuehling_x_carriage();
    % mount_plate();
    // side fans
    for (i=[-1,1]) {
        translate([0, i* (base_length/2 + 5), 18]) {
            rotate([0, 90, 90]) % fan(40,10.2);
             side_fan_duct();
        }
    }
    // Rods
    for (i=[-1,1])
        translate([25* i,0,LM8UU_dia/2+body_wall_thickness+4])
            rotate([90,0,0])
            % cylinder(h=base_length,r=4,$fs=1,center=true);
    // rear fan duct
    translate([-body_width/2 -rod_dist/2 -body_wall_thickness, 0, 0]) {
        fan_duct();
        translate([-7, 0, 30]) rotate([0, 90, 0]) % fan(40,10.2);
    }
}

if (draw_belt_clamps == 1) {
    for (i=[-1,1])
        translate([0,i*(28),0])
            belt_clamp();
}

if (draw_side_fan_duct == 1) {
    rotate([0, 180, 0]) side_fan_duct();
}

if (draw_rear_fan_duct == 1) {
    translate([0, 0, 50]) rotate([180, 0, 0]) fan_duct();
}


module fan_duct() {
    thickness = 3;
    height = 50;
    difference() {
        // main plate
        translate([-thickness/2, -20, 0]) cube([thickness, 40, height]);
        // holes for affixing to the x-carriage
        for(i=[-1,1]) {
                translate([0, i*rear_fan_duct_hole_spacing/2, body_wall_thickness + 1])
                    rotate([0, 90, 0]) 
                     cylinder(d=3 + clearance, h=thickness + 1, center=true, $fn=10);
        }
        // fan hole
        translate([0, 0, height-20]) {
            rotate([0, 90, 0]) 
             cylinder(d=38, h=thickness + 1, center=true);
            // fan support holes
            for(i=[-1,1])
                for(j=[-1,1])
                    translate([0, i*fan_hole_spacing/2, j*fan_hole_spacing/2])
                        rotate([0, 90, 0]) 
                          cylinder(d=3 + clearance, h=thickness + 1, center=true, $fn=10);
        }
    }
    // bottom funnel
    translate([0, 0, 30]) rotate([0, 90, 0]) tube(d1=40, d2=31, height=10, thickness=2, offset=[20, 0, 0]);
    // middle funnel
    translate([10, 0, 34.5]) rotate([0, 90, 0]) tube(d1=31, d2=31, height=25, thickness=2);
    /*translate([40, 0, 34.5]) rotate([0, 90, 0]) tube(d1=31, d2=31, height=10, thickness=2);*/
}

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


module mount_plate()
{
    rotate([180, 0, 0]) union()
    {
        cube([71, 85, 5], center = true);
        translate([0, hotends_spacing/2, -47]) rotate([0, 0, 0]) import("Budaschnozzle.stl");
        translate([0, -hotends_spacing/2, -47]) rotate([0, 0, 180]) import("Budaschnozzle.stl");
    }
}

module simonkuehling_x_carriage() 
{
    difference()
    {
        union ()
        {
            // base plate
            translate([0,0,body_wall_thickness/2])
                cube([rod_dist+body_width,base_length,body_wall_thickness],center=true);

            // base plate support
            for(i=[-1,1]){
                // front/back walls
                translate([i*(rod_dist/2+body_width/2-body_wall_thickness/2),0,body_wall_thickness]) cube([body_wall_thickness, base_length,body_wall_thickness * 2], center=true);
                // center mounting holes nuttrap support
                translate([i*rod_dist/2, 0, body_wall_thickness]) cube([20, 25, body_wall_thickness * 2], center=true);
                // rear fan duct holes support
                translate([-(rod_dist/2 + body_width/2) + body_wall_thickness, 0, body_wall_thickness * 2]) cube([6, 25, body_wall_thickness], center=true);
                // side wall
                translate([0,i*(base_length/2 - body_wall_thickness),body_wall_thickness+1]) rotate([0,0,90])  
                     cube([body_wall_thickness*2,rod_dist-10, 2*body_wall_thickness], center=true);
            }
            // central support beam
            translate([0, 0, body_wall_thickness]) cube([30, 6, body_wall_thickness * 2], center=true);
            // LM8UU Holders
            for(i=[-1,1]) {
                for(j=[-1,1]) {
                    translate([j*25,i*(base_length/2 - LM8UU_length/2 - body_wall_thickness), body_wall_thickness])
                        rotate([0,0,90]) LM8UU_holder();
                }
            }
            // Belt Clamp Sockets
            difference()
            {
                for (i=[-1,1])
                    translate([-25-13.5-1,i*(base_length/2 - belt_clamp_width/2),0])
                        rotate(90*(i+1)+180) 
                        belt_clamp_socket ();
                // clearance for the lm8uu holders
                for (i=[-1,1])
                    translate([25* i,0,LM8UU_dia/2+body_wall_thickness])
                        rotate([90,0,0])
                          cylinder(h=base_length,r=LM8UU_dia/2 + 3,$fs=1,center=true);
            }

        }

        // Extruder Mounting Holes
        for (i=[-1,1]) {
            translate([i*25, 0, body_wall_thickness*2]) nutcatch_parallel("M5", l=3);
            translate([i*25, 0, 5]) hole_through("M5", l=5);
            for (j=[-1, 1]) {
                translate([i*25, j*hotends_spacing/2, 0]) cylinder(r=3.5,h=body_wall_thickness+2,$fs=1);
            }
        }

        // Hotends Holes
        for (i=[-1,1])
            translate([0,hotends_spacing/2*i,-2])
                cylinder(r=21,h=lm8uu_support_thickness*2+25);

        // Space between the hotends
        for (i=[-1, 1])
            translate([0, i*9, 0])
                 cube([space_width, 12, body_wall_thickness*2 + 2], center=true);


        // Substract Belt Clamp Holes from base plate
        for (i=[-1,1]) {
            translate([ -body_width/2 - rod_dist/2, i*(base_length/2 - belt_clamp_width/2), 0]) {
                rotate([0, 0, i*90])
                    translate([0, 0, 5])
                      nutcatch_sidecut("M3", l=belt_clamp_width/2+1);
                    translate([0, 0, 10])
                      hole_through("M3", l=10);
                    translate([-9, 0, 10])
                       nutcatch_parallel("M3");
            }
        }

        // Side fans nut traps and holes
        for (i=[-1,1]) {
            for (j=[-1,1]) {
                translate([i*fan_hole_spacing/2, j*(base_length/2 - body_wall_thickness)-1, 3])
                    rotate([90, 90, 0]) nutcatch_sidecut("M3", l=10);
                translate([i*fan_hole_spacing/2, j*base_length/2 - 5, 3])
                    rotate([90,0,0]) 
                      hole_through("M3", l=10);
            }
        }
        // rear fan duct traps and holes
        for (i=[-1,1]) {
                translate([-(body_width/2 + rod_dist/2) + 2*body_wall_thickness, i*rear_fan_duct_hole_spacing/2, body_wall_thickness + 1]) {
                    rotate([0, 90, 0]) {
                        hole_through("M3", l=10);
                        nutcatch_sidecut("M3", l=10);
                    }
                }
        }


    }

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

belt_clamp_hole_separation=10;

belt_clamp_height=m3_diameter+2*belt_clamp_thickness;
belt_clamp_length=belt_clamp_hole_separation+m3_diameter+2*belt_clamp_thickness;

module belt_clamp_socket()
{
    difference()
    {
        translate([0,0,belt_clamp_height/2])
            union()
            {
                cube([belt_clamp_hole_separation,belt_clamp_width,belt_clamp_height],center=true);
                for(i=[-1,1])
                    translate([i*belt_clamp_hole_separation/2,0,0])
                        cylinder(r=belt_clamp_width/2,h=belt_clamp_height,center=true);
            }
        belt_clamp_holes();
    }
}

belt_width=6;
belt_thickness=1.5; 
tooth_height=1.5;
tooth_spacing=2;

belt_clamp_channel_height=belt_thickness+tooth_height+belt_clamp_thickness*2;

module belt_clamp_channel()
{
    difference()
    {
        translate([0,0,belt_clamp_channel_height/2])
            union()
            {
                cube([belt_clamp_hole_separation,belt_clamp_width,belt_clamp_channel_height],center=true);
                for(i=[-1,1])
                    translate([i*belt_clamp_hole_separation/2,0,0])
                        cylinder(r=belt_clamp_width/2,h=belt_clamp_channel_height,center=true);
            }

        for(i=[-1,1])
            translate([i*belt_clamp_hole_separation/2,0,-1])
                rotate(360/16)
                cylinder(r=m3_diameter/2,h=belt_clamp_channel_height+2,$fn=8);

        translate([-belt_width/2,-belt_clamp_width/2-1,belt_clamp_channel_height-belt_thickness-tooth_height])
            cube([belt_width,belt_clamp_width+2,belt_thickness+tooth_height+1]);
    }
}

module belt_clamp_holes()
{
    translate([0,0,belt_clamp_height/2])
    {
        for(i=[-1,1])
            translate([i*belt_clamp_hole_separation/2,0,0])
                cylinder(r=m3_diameter/2,h=belt_clamp_height+2,center=true,$fn=8);


    }
}

belt_clamp_clamp_height=tooth_height+belt_clamp_thickness*2;

module belt_clamp()
{
    difference()
    {
        translate([0,0,belt_clamp_clamp_height/2])
            union()
            {
                cube([belt_clamp_hole_separation,belt_clamp_width,belt_clamp_clamp_height],center=true);
                for(i=[-1,1])
                    translate([i*belt_clamp_hole_separation/2,0,0])
                        cylinder(r=belt_clamp_width/2,h=belt_clamp_clamp_height,center=true);
            }

        for(i=[-1,1])
            translate([i*belt_clamp_hole_separation/2,0,-1])
                rotate(360/16)
                cylinder(r=m3_diameter/2,h=belt_clamp_clamp_height+2,$fn=8);

        for(i=[-3:3])
            translate([-belt_width/2,-tooth_spacing/4+i*tooth_spacing,belt_clamp_clamp_height-tooth_height])
                cube([belt_width,tooth_spacing/2,tooth_height+1]);
    }
}


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
