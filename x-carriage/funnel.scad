module funnel(d1, d2, l, height, thickness, offset=[0, 0, 0], center=true) {
    translate([0, 0, height/2]) translate(-offset) difference() {
        linear_extrude(height = height, scale = d2/d1, center = center) translate(offset) base(d=d1, l=l);
        if (d2 <= thickness) {
            translate([0, 0, -thickness]) linear_extrude(height = height, scale = d2/d1, center = center) translate(offset) base(d=d1, l=l);
        } else {
            linear_extrude(height = height, scale = (d2 - thickness * 2)/(d1 - thickness), center = center) translate(offset) base(d=d1 - thickness * 2, l=l -thickness);
        }
    }
}

module base(d, l) {
        circle(d = d);
        translate([0, -d/2, 0]) square([l, d]);
}

/*funnel(d1=40, d2=20, l=21, height=20, thickness=2, offset=[0, 0, 0]);*/

/*difference() {*/
/*    base(40, 20);*/
/*    base(36, 18);*/
/*}*/
