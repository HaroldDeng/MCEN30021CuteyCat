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
            translate([0, -4, 0]) cube([3, 6, 1], center=true);
            

        }


        // holes
        circle(0.5);
        for(i = [0:2]){
            translate([0, -4 - 2 * i, 0]) cylinder(5, 0.5, 0.5, center=true);
        }


    }
}

// $fn = 15;
// catTail();