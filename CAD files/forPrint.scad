include <./head.scad>
include <./body.scad>
include <./tail.scad>
include <./headRod.scad>
include <./motorWithHorn.scad>


// left of head
//rotate(-RT_X_CW_90) difference() {
//    rotate(-FINAL_HEAD_RT) catHead();
//    translate([0, 500, 0]) cube(1000, center=true);
//}

rotate(RT_X_CW_90) difference() {
    rotate(-FINAL_HEAD_RT) catHead();
    translate([0, -500, 0]) cube(1000, center=true);
}

//translate([-130, 50, 0]) rotate(-RT_X_CW_90 - [0, 0, 5]) difference() {
//    removeTop();
//    translate([0, 100, 0]) cube(200, center=true);
//}

//translate([130, 50, 0]) rotate(RT_X_CW_90 - [0, 0, 5]) difference() {
//    removeTop();
//    translate([0, -100, 0]) cube(200, center=true);
//}

// translate([0, 0, -170]) justTop();