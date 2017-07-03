// Configuration

height = 90; // bottom of shelf to rod
width = 28;
thickness = 3;
shelf_thickness = 18;
rod_dia = 22;
clamp_length = 40;
clamp_height = 28;
clearance = 0.2;

module brace() {
    rotate([0, -90, 180]) {
        linear_extrude(height = thickness) {
            polygon(points=[
                [0, thickness * 2],
                [0, height + rod_dia + thickness],
                [clamp_height/2, height + rod_dia + thickness]
            ]);
        }
    }
}

module rod_holder() {
    difference() {
        cube([clamp_length + thickness, shelf_thickness + thickness * 2, clamp_height]);
        translate([thickness, thickness]) cube([clamp_length, shelf_thickness, clamp_height]);
        translate([width + (clamp_length - width)/2, shelf_thickness + thickness * 2, clamp_height / 2]) rotate([90, 0, 0]) cylinder(d1=5, d2=3, h=thickness, $fn=10);
    }

    translate([0, shelf_thickness + thickness * 2]) {
        difference() {
            cube([width, height + rod_dia/2 + thickness, width]);
            translate([thickness, thickness]) cube([width - thickness * 2, height, width]);
            translate([width/2, height]) cylinder(d=rod_dia + clearance, h=width);
        }
        /* translate([0, height + rod_dia + thickness,thickness]) brace(); */
        /* translate([width -thickness, height + rod_dia + thickness, thickness]) brace(); */
    }
}

rod_holder();
/* translate([- 10, 0, 0]) mirror([1, 0, 0]) rod_holder(); */
