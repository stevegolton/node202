$fn=64;

gpu_fan_rad=92/2; // Radius of the GPU fans
gpu_fan_sep=98; // Dist between the centres of the GPU fans. If there are 3 fans take the distance between the first and last fan
gpu_rise=30; // Distance between the GPU and the case (basically the height of the duct

gpu_plate_rim_thickness=3; // Thickness of the face that the GPU sits on
gpu_height=30; // Distance between the bottom of the GPU and the case

offset_lat=-16.5; // GPU offset (latitudinal)
offset_long=-36.5; // GPU offset (longitudinal)

screw_hole_size=3.5; // 4.3

// The duct is composed of three parts:
// - The GPU plate
// - The mouting plate (mounts to the case)
// - The duct body (joins the two plates)

difference() {
    union() {
        mounting_plate(height=2);

        translate([offset_lat, offset_long, 30]) {
            gpu_plate(height=2);
        }

        translate([0, 0, 2]) {
            duct_body(height=26);
        }
        // Lugs
        translate([-120/2, -120/2, 0]) {
            corners(size=[120, 120], inset=15/2) {
                cylinder(r=12/2, h=15);
            }
        }
    }
    // Screw holes
    translate([-120/2, -120/2, 0]) {
        corners(size=[120, 120], inset=15/2) {
            translate([0, 0, -.5]) {
                cylinder(r=screw_hole_size/2, h=15+1);
            }
        }
    }
}

// Plate that the GPU rests on, with cutouts for the fans
module gpu_plate(fan_rad=92/2, rim_thickness=5, fan_sep=98, height=5) {
    scale([1, 1, -1]) {
        difference() {
            fan_interface(fan_rad + rim_thickness, dist=fan_sep, height=height);
            translate([0, 0, -.5]) {
                fan_interface(radius=fan_rad, dist=fan_sep, height=height+1);
            }
        }
    }
}

module duct_body(fan_rad=92/2, rim_thickness=5, fan_sep=98, height=15) {
    depth=120;
    length=190;
    inset=15/2;
    
    difference() {
        
        hull() {
            translate([-depth/2, -depth/2, 0]) {
                puck(size=[depth, length], corner_radius=inset, height=1);
            }
            
            translate([offset_lat, offset_long, height]) {
                scale([1, 1, -1]) {
                    fan_interface(fan_rad + rim_thickness, dist=fan_sep, height=1);
                }
            }
        }
    
        hull() {
            translate([-depth/2, -depth/2, 0]) {
                translate([inset, inset, -0.5]) {
                    cube([depth-inset*2, length-inset*2, 2]);
                }
            }
            translate([offset_lat, offset_long, height]) {
                scale([1, 1, -1]) {
                    translate([0, 0, -.5]) {
                        fan_interface(radius=fan_rad, dist=fan_sep, height=2);
                    }
                }
            }
        }
    }
}

module mounting_plate(height=10) {
    depth=120;
    length=190;
    inset=15/2;
    
    translate([-depth/2, -depth/2, 0]) {
        difference() {
            union() {
                // Plate
                difference() {
                    puck(size=[depth, length], length=length, corner_radius=inset, height=height);
                    translate([inset, inset, -0.5]) {
                        cube([depth-inset*2, length-inset*2, height+1]);
                    }
                }
                // Mounting tabs
                /*
                corners(size=[depth, depth], inset=inset) {
                    cylinder(r=inset, h=10);
                }
                */
            }
            // Screw holes
            /*
            corners(size=[depth, depth], inset=inset) {
                translate([0, 0, -.5]) {
                    cylinder(r=screw_hole_size/2, h=height+1);
                }
            }
            */
        }
    }
}

module fan_interface(radius, dist, height) {
        hull() {
            cylinder(r=radius, h=height);
            translate([0, dist, 0]) {
                cylinder(r=radius, h=height);
            }
        }
    
}

module puck(size, r, h, length=side) {
    hull() {
        corners(size=size, inset=corner_radius) {
            cylinder(r=corner_radius, h=height);
        }
    }
}

module corners(size, inset) {
    translate([inset, inset, 0]) {
        children();
    }
    translate([size[0]-inset, inset, 0]) {
        children();
    }
    translate([size[0]-inset, size[1]-inset, 0]) {
        children();
    }
    translate([inset, size[1]-inset, 0]) {
        children();
    }
}
