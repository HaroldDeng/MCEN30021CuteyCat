include <./head.scad>
include <./body.scad>
include <./tail.scad>
include <./headRod.scad>
include <./motorWithHorn.scad>


module cutRoomForHead(){
    difference(){
        scaleAndPlaceHolder();
        scale(FINAL_SCALE){
            translate(FINAL_HEAD_POS) scale(FINAL_HEAD_SCALE) solidRod(radius=ROD_RADIUS*1.1);
            translate(FINAL_HEAD_POS*2.25) rotate([0, 34, 0]) cube([10, 10, 1], true);
            translate(FINAL_HEAD_POS*2.31) rotate([0, 30, 0]) cube([10, 10, 1], true);
        }
    }
}

module placeFrontMotro(){
    translate([18, 5, -8]) rotate([-90, 0, 0]) motroWithHorn(FINAL_HEAD_RT[1]+170);
    color("green") translate([20-sin(360*$t+10)/2, 4.5, 7]) rotate([0, -35+sin(-360*$t+180)/2, 0]) cube([33, 3, 1]);
}

module placeRearMotor(){
    translate([-25, 5, -8]) rotate([-90, 0, 0]) motroWithHorn(FINAL_HEAD_RT[1] + 180);
    color("green") translate([-67-sin(360*$t+10)/2, 15.5, -16]) rotate([0, -30, -16]) cube([53, 3, 1]);
}

module placeTail(){
    translate(REAR_ANCHOR_POS - [0, 0, 3]) rotate([0, 0, 180]) catTail(FINAL_HEAD_RT[1]-40);
}


// cat's head
//scale(FINAL_SCALE) union(){
//    translate(FINAL_HEAD_POS) scale(FINAL_HEAD_SCALE) rotate(FINAL_HEAD_RT) {
//        %catHead();
//        headRod();
//    }
//}

%cutRoomForHead();
placeFrontMotro();
placeRearMotor();
placeTail();


// Ardurio UNO
//color("orange") translate([0, 20, -17]) rotate([22, 0, 0]) cube([80, 50, 15], center=true);
