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

draw_carriage = 1;
draw_belt_clamps = 0;

belt_clamp_thickness=2; 
belt_clamp_width=m3_diameter+3*belt_clamp_thickness+2;


/*belt_clamp_channel();*/
base_length = 110;
rod_dist = 50;

hotends_spacing = 58;
space_width = 20;


if (draw_carriage == 1) {
    simonkuehling_x_carriage();
    % mount_plate();
    // side fans
    for (i=[-1,1]) {
        % translate([0, i* (base_length/2 + 5), 19]) rotate([0, 90, 90]) fan(40,10.2);
    }
    // Rods
    for (i=[-1,1])
        translate([25* i,0,LM8UU_dia/2+body_wall_thickness+4])
            rotate([90,0,0])
            % cylinder(h=base_length,r=4,$fs=1,center=true);
}

/*% translate([-(rod_dist/2 + body_width/2 + body_wall_thickness + 23), -50, 99]) rotate([270, 0, 270]) import("40mm_Fan_Shroud.stl");*/

if (draw_belt_clamps == 1) {
    for (i=[-1,1])
        translate([0,i*(28),0])
            belt_clamp();
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
                // side walls
                translate([i*(rod_dist/2+body_width/2-body_wall_thickness/2),0,body_wall_thickness]) cube([body_wall_thickness, base_length,body_wall_thickness * 2], center=true);
                // center mounting holes nuttrap support
                translate([i*25, 0, body_wall_thickness]) cube([16, 15, body_wall_thickness * 2], center=true)

                    translate([0,i*(base_length/2 - body_wall_thickness/2),body_wall_thickness]) rotate([0,0,90])  cube([body_wall_thickness,rod_dist + body_width, 2*body_wall_thickness], center=true);
            }
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
                         cylinder(h=base_length,r=LM8UU_dia/2,$fs=1,center=true);
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
        translate([-space_width/2, -hotends_spacing/2, 0]) 
            cube([space_width, hotends_spacing, body_wall_thickness*2 + 2]);


        // Substract Belt Clamp Holes from base plate
        for (i=[-1,1]) {
            translate([ -body_width/2 - rod_dist/2, i*(base_length/2 - belt_clamp_width/2), 0]) {
                hole_through("M3");
                rotate([0, 0, i*90])
                    translate([0, 0, 5])
                     # nutcatch_sidecut("M3", l=belt_clamp_width/2+1);
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
