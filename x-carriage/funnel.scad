module funnel(d1, d2, l, height, thickness, offset=[0, 0, 0], center=true) {
    translate([0, 0, height/2])
    translate(-offset)
    difference() {
        linear_extrude(height = height, scale = d2/d1, center = center) translate(offset) base(d=d1, l=l);
        linear_extrude(height = height, scale = d2/d1, center = center) translate(offset) base(d=d1-thickness, l=l - thickness);
    }
}

module base(d, l) {
    circle(d = d);
    translate([0, -d/2, 0]) square([l, d]);
}

/*funnel(d1=40, d2=20, l=40, height=20, thickness=10, offset=[0, 0, 0]);*/

/*base(40, 20);*/
