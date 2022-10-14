include <./Constants.scad>;
include <./motorHolder.scad>;
include <./headRod.scad>;
include <./utils.scad>;

// make out of distorted sphere
module torso(radius = BASE_SPHERE_RADIUS){
    rotate([0, -3, 0]) scale(BODY_DISTORTION) sphere(radius);
}

// make out of half sphere
module paw(radius, cutOff = 0){
    difference(){
        sphere(radius);
        translate([0, 0, -(radius+1)/2 + cutOff]) 
            cube([radius*2+1, radius*2+1, radius+1], center = true);
    }
}

module solidThighsAndPaws(topJointR, botJointR, topJointRt, topJointPos, 
    botJointPos, pawPos, pawR, cutOff = 0){
    // left
    hull(){
        translate(topJointPos[0]) rotate(topJointRt[0]) cylinder(0.01, topJointR, topJointR); 
        translate(botJointPos[0]) cylinder(0.01, botJointR, botJointR); 
    }
    translate(pawPos[0]) paw(pawR, cutOff);
    
    // right
    hull(){
        translate(topJointPos[1]) rotate(topJointRt[1]) cylinder(0.01, topJointR, topJointR); 
        translate(botJointPos[1]) cylinder(0.01, botJointR, botJointR); 
    }
    translate(pawPos[1]) paw(pawR, cutOff);
    
}

module hollowBodyThightsAndPaws() {
    difference() {
        union() {
            torso();
            solidThighsAndPaws(SHOULDER_R, WRIST_R, SHOULDER_JOINT_RT, SHOULDER_POS, 
                WRIST_POS, FRONT_PAW_POS, FRONT_PAW_RADIUS);
            solidThighsAndPaws(HIP_R, HEEL_R, HIP_JOINT_RT, HIP_POS, HEEL_POS, 
                REAR_PAW_POS, REAR_PAW_RADIUS);
        }
        // remove inner body
        torso(BASE_SPHERE_RADIUS - WALL_THICKNESS);
        solidThighsAndPaws(SHOULDER_R - WALL_THICKNESS, WRIST_R - WALL_THICKNESS, SHOULDER_JOINT_RT, SHOULDER_POS, 
            WRIST_POS, FRONT_PAW_POS, FRONT_PAW_RADIUS - WALL_THICKNESS, WALL_THICKNESS);
        solidThighsAndPaws(HIP_R - WALL_THICKNESS, HEEL_R - WALL_THICKNESS, HIP_JOINT_RT, HIP_POS, HEEL_POS, 
                        REAR_PAW_POS, REAR_PAW_RADIUS- WALL_THICKNESS, WALL_THICKNESS);
    }
}


module scaleAndPlaceHolder() {
    scale(FINAL_SCALE) difference(){
        hollowBodyThightsAndPaws();
        translate(TAIL_INTRUDE_POS) scale(INTRUDE_BODY_RATIO) cube(BASE_CUBE, center=true);
    }
    difference() {
        union(){
            // front motor holder
            intersection() {
                scale(FINAL_SCALE) torso();
                translate(FRONT_HOLDER_POS) frontMotorHolder();
            }

            // rear motor holder
            intersection() {
                scale(FINAL_SCALE) torso();
                translate(REAR_HOLDER_POS) frontMotorHolder();
            }

            // tail anchor
            intersection() {
                scale(FINAL_SCALE) torso();
                translate(REAR_ANCHOR_POS) tailAnchor();
            }
        }
        translate([0, 0, 65]) cube([1000, 1000, 100], center=true);
    }
}

module catBody() {
    difference(){
        scaleAndPlaceHolder();
        scale(FINAL_SCALE){
            translate(FINAL_HEAD_POS) scale(FINAL_HEAD_SCALE) solidRod(radius=ROD_RADIUS*1.1);
            translate(FINAL_HEAD_POS*2.25) rotate([0, 34, 0]) cube([10, 10, 1], true);
            translate(FINAL_HEAD_POS*2.31) rotate([0, 30, 0]) cube([10, 10, 1], true);
        }
    }
    translate([-2, 0, -34.5])disk();
    translate([-60, 0, -28.5]) rotate([0, 20, 0]) disk();
    translate([60, 0, -23.5]) rotate([0, -20, 0]) disk();

    translate([-78, 0, 15.0]) rotate([0, 150, 0]) disk();
    
}

module removeTop(){
    difference(){
        catBody();
        translate([0, 0, 125])cube(200, center=true);
    }

    translate([0, -42.7, 23]) rotate(-RT_X_CW_90) scale([1, 0.5, 1]) disk();
    translate([0, 42.7, 23]) rotate(RT_X_CW_90) scale([1, 0.5, 1]) disk();
}

module justTop(){
    //translate([0, 0, 150])
    union(){
        intersection(){
            catBody();
            translate([0, 0, 125])cube(200, center=true);
        }

        translate([0, -40.7, 25]) leftBar();
        translate([0, 40.7, 25]) rightBar();
    }
}


//translate([0, -80, 0])
//difference(){
//    removeTop();
//    translate([0, 100, 0]) cube(200, center=true);
//}

//translate([0, 80, 0])
//intersection(){
//    removeTop();
//    translate([0, 100, 0]) cube(200, center=true);
//}

//justTop();
//

