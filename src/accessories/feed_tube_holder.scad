tube_dia = 6;
inner_dia = 4;
fn = 50;
screw_dia = 4;
thickness = 3;
rod_dia = 8;
clearance = 0.2;

rotate([-90, 0, 0]) {
    difference() {
        union() {
            cylinder(d=tube_dia + thickness * 2, h=20);
            translate([-15, thickness, 0]) cube([30, thickness, 20]);
        }
        cylinder(d=tube_dia + clearance, h=9, $fn=fn);
        translate([0, 0, 9]) # cylinder(d=inner_dia + clearance, h=10, $fn=fn);
        translate([0, 0, 11]) cylinder(d=tube_dia + clearance, h=9, $fn=fn);
        for(i=[-1,1]) {
            translate([i*10, 7.5 - thickness/2, 10]) rotate([90, 0, 0]) # cylinder(d=screw_dia + clearance, h=thickness);
        }
    }
}
