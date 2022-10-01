include <./head.scad>
include <./body.scad>
include <./tail.scad>
include <./headRod.scad>
include <./motorWithHorn.scad>


module placeFrontMotro(){
    translate([18, 5, -8]) rotate([-90, 0, 0]) motroWithHorn(FINAL_HEAD_RT[1]+170);
    color("green") translate([18-sin(360*$t+10)/2, 4.5, 7]) rotate([0, -35+sin(-360*$t+180)/2, 0]) cube([35, 3, 1]);
}

module placeRearMotor(){
    translate([-25, 5, -8]) rotate([-90, 0, 0]) motroWithHorn(-FINAL_HEAD_RT[1]*2 + 195);
    color("green") translate([-67-sin(360*$t+10), 15.5, -16]) rotate([0, -30, -16]) cube([50, 3, 1]);
}

module placeTail(){
    translate(REAR_ANCHOR_POS - [0, 0, 3]) rotate([0, 0, 180]) catTail(FINAL_HEAD_RT[1]-40);
}

catHead();
catBody();

placeFrontMotro();
placeRearMotor();
placeTail();


// Ardurio UNO
color("orange") translate([0, 20, -17]) rotate([22, 0, 0]) cube([80, 50, 15], center=true);
