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
//	- "Lm8uu X Carriage with Fan Mount for Prusa Mendel" by Greg Frost
//	  http://www.thingiverse.com/thing:9869
//	- "Slim LM8UU Holder Parametric" by Jonas Kühling
//	  http://www.thingiverse.com/thing:16158

// Gregs configuration file
include <configuration.scad>

include <LM8UU_holder_ziptie.scad>

// jonaskuehling's slim LM8UU Holder
/*include <lm8uu-holder-slim.scad>*/


// Fan module
include <fan.scad>

draw_carriage = 1;
draw_belt_clamps = 0;
draw_plate_clamp = 0;

belt_clamp_thickness=2; 
belt_clamp_width=m3_diameter+3*belt_clamp_thickness+2;


/*belt_clamp_channel();*/
base_length = 115;
rod_dist = 50;

hotends_spacing = 58;
space_width = 34;


if (draw_carriage == 1) {
    simonkuehling_x_carriage();
    % mount_plate();
    // Front fan
    % translate([rod_dist/2 + body_width/2 + body_wall_thickness + 1, 0, 19]) rotate([0, 90, 0]) fan(40,10.2);
}

/*% translate([-(rod_dist/2 + body_width/2 + body_wall_thickness + 23), -50, 99]) rotate([270, 0, 270]) import("40mm_Fan_Shroud.stl");*/

if (draw_belt_clamps == 1) {
    for (i=[-1,1])
    translate([0,i*(28),0])
    belt_clamp();
}

if (draw_plate_clamp == 1) {
    for (i=[-1,1])
    translate([0,i*(28),0])
    plate_clamp();
}



module mount_plate()
{
    rotate([180, 0, 0])
    union()
    {
        cube([71, 97, 5], center = true);
        translate([0, hotends_spacing/2, -49]) rotate([0, 0, 180]) import("Budaschnozzle.stl");
        translate([0, -hotends_spacing/2, -49]) import("Budaschnozzle.stl");
    }
}

module simonkuehling_x_carriage() 
{
	render()
	difference()
	{
		union ()
		{			
			// base plate
			translate([0,0,body_wall_thickness/2])
			cube([rod_dist+body_width,base_length,body_wall_thickness],center=true);

			// base plate support
			for(i=[-1,1]){
				translate([i*(rod_dist/2+body_width/2-body_wall_thickness/2),0,body_wall_thickness]) cube([body_wall_thickness,base_length,2*body_wall_thickness], center=true);
				translate([0,i*(base_length/2 - body_wall_thickness/2),body_wall_thickness]) rotate([0,0,90])  cube([body_wall_thickness,rod_dist + body_width, 2*body_wall_thickness], center=true);
                // support for the latches holes
				translate([0,i*(base_length/2 - body_wall_thickness),body_wall_thickness]) rotate([0,0,90])  cube([body_wall_thickness * 2 , body_wall_thickness * 2, 2*body_wall_thickness], center=true);
			}
			// belt clamp support
			/*translate([-(rod_dist/2+body_width/2-body_wall_thickness/2+10.5),0,body_wall_thickness]) cube([body_wall_thickness,((28-body_length/2)-belt_clamp_width/2),2*body_wall_thickness], center=true);*/

		}

		// Clearance for Rods
		/*for (i=[1,-1])*/
		/*translate([i*(25-body_wall_thickness/2),0,5+body_wall_thickness])*/
		/*# cube([body_width-body_wall_thickness,base_length+2,10],center=true);*/
		
		// Extruder Mounting Holes
        for (i=[-1,1]) {
            # translate([i*25, 0, 0]) cylinder(r=3.5,h=body_wall_thickness*2+2,$fs=1);
            for (j=[-1, 1]) {
                # translate([i*25, j*hotends_spacing/2, 0]) cylinder(r=3.5,h=body_wall_thickness*2+2,$fs=1);
            }
        }

        // Latches holes
        for (i=[-1,1]) {
                # translate([0, i*(48.5 +5), 0]) cylinder(r=m4_diameter/2,h=body_wall_thickness*2+2,$fs=1);
            }

		// Hotend Holes
        for (i=[-1,1])
		translate([0,hotends_spacing/2*i,-2])
		# cylinder(r=21,h=lm8uu_support_thickness*2+25);

        // Space between the hotends
        translate([-space_width/2 + 4, -hotends_spacing/2, 0]) cube([space_width, hotends_spacing, body_wall_thickness*2 + 2]);


		// Substract Belt Clamp Holes from base plate
		for (i=[-1,1])
		translate([-25-13.5-1,i*(base_length/2 - belt_clamp_width/2),0])
		rotate(90*(i+1)+180) 
		belt_clamp_holes();
		

        // Mounting holes for front fan
        for(i=[-1,1]) {
		    translate([25 + 5, i*16, body_wall_thickness]) rotate([0,90,0]) cylinder(r=m3_diameter/2-0.3 ,h=50,center=true,$fn=8);
		    translate([25 + 7, i*16, body_wall_thickness]) rotate([0,90,0]) cylinder(r=m3_nut_diameter/2-0.3 ,h=3.4,center=true,$fn=6);
        }

	}


    // LM8UU Holders
    for(i=[-1,1]) {
        for(j=[-1,1]) {
                translate([j*25,i*(base_length/2 - LM8UU_length/2 - body_wall_thickness),4])
                render() rotate([0,0,90]) LM8UU_holder();
                    /*translate([25,i*-17,0]) # cylinder(r=21,h=lm8uu_support_thickness*2+25);*/
        }
    }
    /*translate([-25,0,4])*/
    /*render()*/
    /*lm8uu_holder();*/



	// Belt Clamp Sockets
	difference()
	{
		for (i=[-1,1])
		translate([-25-13.5-1,i*(base_length/2 - belt_clamp_width/2),0])
		rotate(90*(i+1)+180) 
		belt_clamp_socket ();

		// BeltClamp Socket Rod Clearance
        
		for (i=[-1,1])
            translate([25* i,0,LM8UU_dia/2+body_wall_thickness+4])
            rotate([90,0,0])
            # cylinder(h=base_length,r=5,$fs=1,center=true);
	}

	// back Fan mounts 
    for(i=[-1, 1])
        difference(){
            translate([-(body_width/2+rod_dist/2 + body_wall_thickness + 1),i*hotends_spacing/2,5]) rotate([0,0,90]) cube([15,10,10], center=true);
            translate([-(body_width/2+rod_dist/2 + body_wall_thickness + 1),i*hotends_spacing/2,5]) rotate([0,90,90]) cylinder(r=m3_diameter/2,h=17, center=true, $fn=8);
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

module plate_clamp()
{
    difference(){
        union(){
            translate([0,0,5]) cube([10,15,5]);
            cube([15,15,5]);
        }
        translate([5,7.5,0]) cylinder(r=m4_diameter/2,h=10);
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
