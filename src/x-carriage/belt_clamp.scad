belt_width=6;
belt_thickness=1.5; 
tooth_height=1.5;
tooth_spacing=2;
belt_clamp_thickness=2;
belt_clamp_width=m3_diameter+3*belt_clamp_thickness+2;

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

