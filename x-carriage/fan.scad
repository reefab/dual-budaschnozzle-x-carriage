module fan(sz,ht)
  {
  difference()
    {
    linear_extrude(height=ht, center = true, convexity = 4, twist = 0)
      difference()
        {
        //overall outside
        square([sz,sz],center=true);
        //main inside bore, less hub
        difference()
          {
          circle(r=(sz-3)/2,center=true);
          //hub. Just imagine the blades, OK?
          circle(r=(sz/2+1.5)/2,center=true);
          }
        //Mounting holes
        translate([+(sz/2-5),+(sz/2-5)]) circle(r=3.4/2,h=ht+0.2,center=true);
        translate([+(sz/2-5),-(sz/2-5)]) circle(r=3.4/2,h=ht+0.2,center=true);
        translate([-(sz/2-5),+(sz/2-5)]) circle(r=3.4/2,h=ht+0.2,center=true);
        translate([-(sz/2-5),-(sz/2-5)]) circle(r=3.4/2,h=ht+0.2,center=true);
        //Outside Radii
        translate([+(sz/2),+(sz/2)]) difference()
          {
          translate([-4.9,-4.9]) square([5.1,5.1]);
          translate([-5,-5]) circle(r=5);
          }
        translate([+(sz/2),-(sz/2)]) difference()
          {
          translate([-4.9,-0.1]) square([5.1,5.1]);
          translate([-5,+5]) circle(r=5);
          }
        translate([-(sz/2),+(sz/2)]) difference()
          {
          translate([-0.1,-4.9]) square([5.1,5.1]);
          translate([+5,-5]) circle(r=5);
          }
        translate([-30,-30]) difference()
          {
          translate([-0.1,-0.1]) square([5+0.1,5+0.1]);
          translate([5,5]) circle(r=5);
          }
      } //linear extrude and 2-d difference
    //Remove outside ring
    difference()
      {
      cylinder(r=(sz+28)/2,h=ht-3.6-3.6,center=true);
      cylinder(r=(sz+4)/2,h=ht-3.6-3.6+0.2,center=true);
      }      
    }// 3-d difference

    //Seven Blades
    linear_extrude(height=ht-1, center = true, convexity = 4, twist = -30)
      for(i=[0:6])
        rotate((360*i)/7)
          translate([0,-1.5/2]) square([(sz-3)/2-0.75,1.5]);
  }
