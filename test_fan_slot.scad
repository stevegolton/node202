difference() {
    cube([120, 15, 120]);
    translate([120/2, -1, 120/2]) {
        rotate([-90, 0, 0]) {
            cylinder(r=110/2, h=100);
        }
    }
}
s