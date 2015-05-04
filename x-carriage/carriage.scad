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



