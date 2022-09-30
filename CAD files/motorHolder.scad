include <./motorWithHorn.scad>;
include <./Constants.scad>;

module frontMotorHolder() {
    color("red") difference(){
        cube(HOLDER_BED_SIZE, center=true);
        cube(MOTOR_SIZE, center=true);
    }
}

module rearMotorHolder() {
    color("red"){
        translate([0, -25, 0]) rotate(RT_X_CW_90) difference(){
            cube(HOLDER_BED_SIZE, center=true);
            cube(MOTOR_SIZE, center=true);
        }
        cylinder(HOLDER_PIN_LENGTH, HOLDER_PIN_RADIUS, HOLDER_PIN_RADIUS, center=true);
    }
    translate([0, -20, 15]) motroWithHorn(-90);
}

module tailAnchor() {
    color("red") cylinder(ANCHOR_LENGTH, ANCHOR_RADIUS, ANCHOR_RADIUS, center=true);
}





