include <./Constants.scad>;
include <./headRod.scad>;
include <./utils.scad>;

// create soild ear, the ear is make out of a distorted sphere
module ear(radius){
    scale(EARS_DISTORTION) sphere(radius);
}

// create soild face (empty ball)
module face(radius){
    sphere(radius);
}

// create hollow face and ears
module hollowFaceAndEars(){
    difference(){
        union() {
            // face
            face(BASE_SPHERE_RADIUS);
            // ears
            translate(LF_EAR_POS) rotate(LF_EAR_RT) ear(HERS_SIZE);
            translate(RG_EAR_POS) rotate(RG_EAR_RT) ear(HERS_SIZE);
        }

        translate(LF_EAR_POS) rotate(LF_EAR_RT) ear(HERS_SIZE - WALL_THICKNESS * 1.5);
        translate(RG_EAR_POS) rotate(RG_EAR_RT) ear(HERS_SIZE - WALL_THICKNESS * 1.5);
        face(BASE_SPHERE_RADIUS - WALL_THICKNESS);
        translate([0, 0, 1]) cube([0.1, 0.2, 1], center=true);
        translate([0.04, 0, 1.2]) cube([0.05, 0.8, 0.4], center=true);
    }
}

module intrudeHead() {
    difference() {
        hollowFaceAndEars();
        translate(HEAD_INTRUDE_POS) scale(INTRUDE_HEAD_RATIO) sphere(1);    
    }
}



module catHead(){
    scale(FINAL_SCALE) union(){  //rotate(FINAL_HEAD_RT) 
        translate(FINAL_HEAD_POS) scale(FINAL_HEAD_SCALE) {
            translate(HEAD_POS) {
                intrudeHead();
            }
            headRod();
        }
    }
    
    translate([80, 0, 9]) disk();
    translate([129, 0, 91]) rotate([0, -122, 0]) disk();
    translate([34, 0, 40]) rotate([0, 60, 0]) disk();
}

//translate([0, -50, 0])difference(){
//    catHead();
//    translate([100, 100, 100]) cube(200, center=true);
//}
//translate([0, 50, 0])intersection(){
//    catHead();
//    translate([100, 100, 100]) cube(200, center=true);
//}

//catHead();

//color("blue", 0.2) translate([18, 6, 17]) rotate([0, 0, 90]) import("./sensor.stl");
