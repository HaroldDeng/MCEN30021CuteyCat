include <./head.scad>
include <./body.scad>
include <./tail.scad>
include <./headRod.scad>
include <./motorWithHorn.scad>


// left of head
rotate(-RT_X_CW_90) difference() {
    rotate(-FINAL_HEAD_RT) catHead();
    translate([0, 500, 0]) cube(1000, center=true);
}

rotate(RT_X_CW_90) difference() {
    rotate(-FINAL_HEAD_RT) catHead();
    translate([0, -500, 0]) cube(1000, center=true);
}

translate([-130, 50, 0]) rotate(RT_X_CW_90 + [0, 0, 5]) difference() {
    intersection() {
        catBody();
        translate([0, 0, -470]) cube(1000, center=true);
    }
    
    translate([0, -500, 0]) cube(1000, center=true);
}

translate([-130, -50, 0]) rotate(-RT_X_CW_90 - [0, 0, 5]) difference() {
    intersection() {
        catBody();
        translate([0, 0, -470]) cube(1000, center=true);
    }
    translate([0, 500, 0]) cube(1000, center=true);
}

translate([-20, 0, -30]) difference() {
    catBody();
    translate([0, 0, -470]) cube(1000, center=true);
}