$fn=64;

/*
difference() {
    hull() {
        puck(side=120, corner_radius=15/2, height=10);
        translate([30, 90, 20]) {
            fan_interface(radius=92/2, dist=98, height=10);
        }
    }
    hull() {
        inset=5;
        translate([inset, inset, -1]) {
            puck(side=120-inset*2, corner_radius=10/2, height=11);
        }
        translate([30+inset, 90+inset, 20]) {
            fan_interface(radius=(92/2)-inset*2, dist=98, height=11);
        }
    }
}
*/

gpu_fan_rad=92/2; // Radius of the GPU fans
gpu_fan_sep=98; // Dist between the centres of the GPU fans. If there are 3 fans take the distance between the first and last fan
gpu_rise=30; // Distance between the GPU and the case (basically the height of the duct

gpu_plate_rim_thickness=3; // Thickness of the face that the GPU sits on
gpu_height=30; // Distance between the bottom of the GPU and the case

gpu_plate(
    fan_radius=gpu_fan_rad,
    fan_sep=gpu_fan_sep,
    rim_thickness=gpu_plate_rim_thickness);

duct_body(
    height=50,
    fan_rad=gpu_fan_rad,
    rim_thickness=gpu_plate_rim_thickness);

case_mount();

// Plate that the GPU rests on, with cutouts for the fans
module gpu_plate(fan_radius=92/2, rim_thickness=5, fan_sep=98, height=5) {
    difference() {
        fan_interface(fan_radius + rim_thickness, dist=fan_sep, height=height);
        translate([0, 0, -.5]) {
            fan_interface(radius=fan_radius, dist=fan_sep, height=height+1);
        }
    }
}

module duct_body(fan_rad, rim_thickness=5, height=50) {
    difference() {
        hull() {
            scale([1, 1, -1]) {
                fan_interface(radius=fan_rad + rim_thickness, dist=98, height=2);
            }
            translate([0, 0, -height]) {
                puck(side=120, corner_radius=15/2, height=1);
            }
        }
        union() {
            inset=6;
            hull() {
                fan_interface(radius=fan_rad, dist=98, height=1);
                translate([inset, inset, -height]) {
                    cube([120-inset*2, 120-inset*2, 1]);
                }
            }
            translate([inset, inset, -height+.5]) {
                scale([1, 1, -1]) {
                    cube([120-inset*2, 120-inset*2, 1]);
                }
            }
        }
    }
}

module case_mount() {
    difference() {
        translate([0, 0, -60]) {
            puck(side=120, corner_radius=15/2, height=10);
        }
        inset = 6;
        translate([inset, inset, -60.5]) {
            cube([120-inset*2, 120-inset*2, 11]);
        }
    }
    translate([0, 0, -60]) {
        difference() {
            corners(side=120, inset=15/2) {
                cylinder(r=15/2, h=10);
            }
            
            corners(side=120, inset=15/2) {
                translate([0, 0, -1]) {
                    cylinder(r=4.3/2, h=100);
                }
            }
            
        }
    }
}




/*
translate([0, 0, -1]) {
    fan_interface(radius=92/2, dist=98, height=1);
}
*/

/*
difference() {
    union() {
        inset = 6;
        height = 8;
        difference() {
            hull() {
                corners() {
                    cylinder(r=15/2, h=height);
                }
            }
            hull() {
                translate([inset, inset, -0.5]){
                    corners(side=120-inset*2) {
                        cylinder(r=15/2, h=11);
                    }
                }
            }
        }
        difference() {
            corners() {
                cylinder(r=inset, h=height);
            }
            
        }
    }
    corners() {
        translate([0, 0, -1]) {
            cylinder(r=4.3/2, h=100);
        }
    }
}
*/


/*
difference() {
    puck(side=120, corner_radius=15/2, height=10);
    inset=6;
    translate([inset, inset, -0.5]){
        cube([120-inset*2, 120-inset*2, 11]);
    }
}
*/



module fan_interface(radius, dist, height) {
    hull() {
        cylinder(r=radius, h=height);
        translate([dist, 0, 0]) {
            cylinder(r=radius, h=height);
        }
    }
}

module puck(side, r, h) {
    hull() {
        corners(side=side, inset=corner_radius) {
            cylinder(r=corner_radius, h=height);
        }
    }
}

module corners(side, inset) {
    translate([inset, inset, 0]) {
        children();
    }
    translate([side-inset, inset, 0]) {
        children();
    }
    translate([side-inset, side-inset, 0]) {
        children();
    }
    translate([inset, side-inset, 0]) {
        children();
    }
}
