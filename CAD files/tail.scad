include <./Constants.scad>;

FUNC_START = 30;
FUNC_STOP = 60;
FUNC_STEPS = 0.5;
AMPLITUDE = 30;
SHIFT = [-FUNC_START, -sin(2 * FUNC_START) * AMPLITUDE, 0];

HOLE_SIZE = 0.5;

module catTail(degree){
    rotate(degree) scale([4, 4, 0.5]) difference() {
        union() {

            for (i = [FUNC_START: FUNC_STEPS : FUNC_STOP]){
                translate([i, AMPLITUDE*sin(2*i), 0] + SHIFT) circle(2);
            }


            c_length  = 3;
            c_width = 4;
            c_height = 1.5;
            translate([0, -4, 0]) square([3, 6], center=true);
            

        }


        // holes
        circle(0.5);
        for(i = [0:2]){
            translate([0, -4 - 2 * i, 0]) circle(r=0.5);
        }


    }
}

//color("grey") {
    catTail(0);
//    translate([150, 0, 0]) rotate([-90, 0, 0]) catTail(0);
//    translate([50, -100, 0]) rotate([-90, 90, 0]) catTail(0);
//    translate([150, -100, 0])rotate([130, -40, 0]) catTail(0);
//}
