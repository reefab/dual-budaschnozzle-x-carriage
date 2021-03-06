// Main configuration file
include <configuration.scad>

include <src/x-carriage/LM8UU_holder_ziptie.scad>

include <src/nutsnbolts/cyl_head_bolt.scad>

// Fan module, for display only
include <src/x-carriage/fan.scad>

include <src/x-carriage/carriage.scad>
include <src/x-carriage/belt_clamp.scad>
include <src/fanduct/fanduct.scad>
include <src/extruder/extruder.scad>
include <src/extruder/bridge.scad>

if (draw_complete == 1) {
    rotate([0, 180, 0]) color(carriage_color) simonkuehling_x_carriage();
    rotate([0, 180, 0]) % mount_plate();
    // side fans
    for (i=[-1,1])
        translate([0, i* (base_length/2 + 5), -18])
            rotate([0, 90, 90]) % fan(40,10.2);
    // Rods
    for (i=[-1,1])
        translate([rod_dist / 2* i, 0, -(LM8UU_dia/2+body_wall_thickness+4)])
            rotate([90,0,0])
            % cylinder(h=base_length*2,r=4,$fs=1,center=true);

    // Belt
    translate([40, 0, belt_loop_height/2])
        % cube([5, base_length * 2, belt_loop_height], center=true);

    // Front/back fans
    for (i=[-1,1])
        translate([i* (rod_dist/2 + body_width/2 + 5), 0, -33])
            rotate([0, -90, 0]) % fan(40,10.2);
    // Fanduct
    rotate([0, 180, 0]) translate([0,0,42]) color(fanduct_color) cooling_duct();

    // extruders
    extruder_offset = -7.5;
    translate([extruder_offset, hotends_spacing/2 + wade_block_depth/2 , mount_plate_thickness])
        rotate([90, 0, 0])
            color(extruder_color) wade(hotend_mount=groovemount, legacy_mount=false);
    translate([extruder_offset, -hotends_spacing/2 - wade_block_depth/2 , mount_plate_thickness])
        rotate([90, 0, 0])
            mirror([0, 0, 1])
                color(extruder_color) wade(hotend_mount=groovemount, legacy_mount=false);
    // extruders idlers
    translate([extruder_offset, hotends_spacing/2 + wade_block_depth/2 , mount_plate_thickness])
        rotate([90, 0, 0])
            color(extruder_color) wadeidler();
    translate([extruder_offset, -hotends_spacing/2 - wade_block_depth/2 , mount_plate_thickness])
        rotate([90, 0, 0])
            mirror([0, 0, 1])
                color(extruder_color) wadeidler();

    // Extruder bridge
    translate([15, -35, 89.1]) bridge();

}

if (draw_carriage == 1 && draw_complete == 0) {
    simonkuehling_x_carriage();
}

if (draw_belt_clamps == 1 && draw_complete == 0) {
    translate([-6, 0, 0]) difference() {
        translate([0, 0, 1.5]) cube([10, 92.5, 3], center=true);
        cylinder(d=5.2, h=4, $fn=20);
    }
    for (i=[-1,1])
        translate([0,i*(48.5),0])
            belt_clamp();
}

if (draw_cooling_duct == 1 && draw_complete == 0) {
    rotate([180, 0, 0]) cooling_duct();
}

if (draw_extruder == 1 && draw_complete == 0) {
    translate([30, 2, 0]) wade(hotend_mount=groovemount, legacy_mount=false);
    translate([30, -2, 0]) mirror([0, 1, 0]) wade(hotend_mount=groovemount, legacy_mount=false);
}

if (draw_idler == 1 && draw_complete == 0) {
    rotate([0,-90,0])
        wadeidler();
    mirror ([0, 1, 0])
        rotate([0,-90,0])
            wadeidler();
}

if (draw_bridge == 1 && draw_complete == 0) {
    bridge();
}

if (draw_numbers == 1 && draw_complete == 0) {
    linear_extrude(1) text("1", size=8);
    translate([10, 0, 0]) linear_extrude(1) text("2", size=8);
}




