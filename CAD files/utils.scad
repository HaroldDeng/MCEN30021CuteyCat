include <./Constants.scad>;



module disk(){
    color("cyan") rotate(RT_X_CW_90) difference(){
        cube([6, 10, 3], center=true);
        translate([0, 2, 0])cylinder(5, 2, 2, center=true);
    }
}

module rightBar(){
    color("cyan") 

    difference(){
        cylinder(15, 1.85, 1.85, center=true);
        translate([0, 0, 9]) rotate([-30, 0, 0]) cube(10, center=true);
    }
}

module leftBar(){
    color("cyan") 

    difference(){
        cylinder(15, 1.85, 1.85, center=true);
        translate([0, 0, 9]) rotate([30, 0, 0]) cube(10, center=true);
    }
}