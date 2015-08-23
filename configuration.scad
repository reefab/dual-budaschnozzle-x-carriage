// Rendering options
draw_complete = 1;
draw_belt_clamps = 0;
draw_cooling_duct = 0;
draw_extruder= 0;
draw_idler = 0;
draw_carriage = 0;

variant=0; //0 for metric


vars=[
//[m8_dia, m8_nut, m4_dia, m4_nut, m3_dia, m3_nut, bush_dia, mot_shaft, bush_rod, bush_outerdia, bush_length]
[9,16.4,5,9,4.4,7,11,5.3,8,16,11],//metric
[9,15.7,5.5,10.6,5.5,10.6,11.5,5.3,7.9375,16,11]//SAE
];

//BUSHING TYPE Can generate three versions
// 1 - regular old ones
// 2 - helical ones
// 3 - holders for brass or any other bought bushings
bushing_type = 2;

//Round corner diameter
round_corner_diameter = 8;

//Thin wall size
thin_wall = 3;

//DO NOT TOUCH THIS SECTION!
m8_diameter = vars[variant][0];
m8_nut_diameter = vars[variant][1];
m4_diameter = vars[variant][2];
m4_nut_diameter = vars[variant][3];
m3_diameter = vars[variant][4];
m3_nut_diameter = vars[variant][5];
m3_nut_diameter_bigger = ((m3_nut_diameter  / 2) / cos (180 / 6))*2;
bushing_diameter = vars[variant][6];
motor_shaft=vars[variant][7];
bushing_rodsize = vars[variant][8];
bushing_outerDiameter = vars[variant][9];
bushing_lenght = vars[variant][10];

// X-carriage options

base_length = 110;
rod_dist = 50;

hotends_spacing = 58;
space_width = 30;
fan_hole_spacing = 32;

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

mount_plate_thickness = 5;

belt_loop_height = 18;

extruder_color = "SteelBlue";
carriage_color = "DimGray";
fanduct_color = "ForestGreen";

// Extruder options

//Set motor- and bolt-elevation for additional clearance when using e.g. 9/47 gears like in http://www.thingiverse.com/thing:11152
elevation=10;

//Set extra gear separation when using slightly bigger non-standard gears like 9/47 herringbone gears
extra_gear_separation=2;

// Nut wrench sizes ISO 4032
m3_wrench = 5.5;
m4_wrench = 7;

// Adjust for deeper groove in hobbed bolt, so that idler is still vertical when tightened
// Values like 0.5 to 1 should work, the more, the closer the idler will move to the bolt
// Sometimes the idler will be slightly angled towards the bolt which causes the idler screws
// to slip off the slots in die idler to the top.. Adjusting this should help:
less_idler_bolt_dist = 0;
wade_block_height=60+elevation;
wade_block_width=24;
wade_block_depth=28;

block_bevel_r=6;

wade_base_thickness=7;
wade_base_length=71;
base_leadout=29.5;

nema17_hole_spacing=1.2*25.4;
nema17_width=1.7*25.4;
nema17_support_d=nema17_width-nema17_hole_spacing;

screw_head_recess_diameter=7.2;
screw_head_recess_depth=3;

motor_mount_rotation=45;
motor_mount_translation=[50.5+extra_gear_separation,34+elevation,0];
motor_mount_thickness=8;

m8_clearance_hole=8.8;
hole_for_608=22.6;
608_diameter=22;

block_top_right=[wade_block_width,wade_block_height];

layer_thickness=0.2;
filament_feed_hole_d=3.5;
filament_diameter=3;
filament_feed_hole_offset=filament_diameter+1.5;
idler_nut_trap_depth=7.3;
idler_nut_thickness=3.7;

gear_separation=7.4444+32.0111+0.25+extra_gear_separation;

ptfe_tube_dia = 6;
