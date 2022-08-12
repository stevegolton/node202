
difference() {
    shroud();
    translate([5, 5, -0.1]) {
        scale([0.9, 0.9, 1.01]) {
            shroud();
        }
    }
}

module shroud() {
    hull() {
        translate([30, 30, 40]) {
            cylinder(r=50, h=10);
        }

        mounting_plate();
    }
}

module mounting_plate() {
    difference() {
        //cube([120, 120, 5]);
        hull() {
            posts(7.5, 5);
        }
        translate([0, 0, -1]) {
            posts(3, 100);
        }
    }
}

module posts(r, h) {
    translate([7.5, 7.5, 0]) {
        cylinder(r=r, h=h);
    }
    translate([120-7.5, 7.5, 0]) {
        cylinder(r=r, h=h);
    }
    translate([120-7.5, 120-7.5, 0]) {
        cylinder(r=r, h=h);
    }
    translate([7.5, 120-7.5, 0]) {
        cylinder(r=r, h=h);
    }
}
