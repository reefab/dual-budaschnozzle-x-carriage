module tube(d1, d2, height, thickness, offset=[0, 0, 0], center=true) {
    translate([0, 0, height/2])
    translate(-offset)
    difference() {
        linear_extrude(height = height, scale = d2/d1, center = center) translate(offset) circle(d=d1);
        linear_extrude(height = height, scale = d2/d1, center = center) translate(offset) circle(d=d1-thickness);
    }
}

/*tube(d1=40, d2=20, height=20, thickness=2, offset=[5, 0, 0]);*/
