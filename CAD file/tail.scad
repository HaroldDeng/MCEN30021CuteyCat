

FUNC_START = 30;
FUNC_STOP = 80;
FUNC_STEPS = 0.5;
AMPLITUDE = 30;
SHIFT = [-FUNC_START, -sin(2 * FUNC_START) * AMPLITUDE, 0];

HOLE_SIZE = 0.5;

module catTail(){
    scale([1/30, 1/30, 1/10]) difference() {
        for (i = [FUNC_START: FUNC_STEPS : FUNC_STOP]){
            translate([i, AMPLITUDE*sin(2*i), 0] + SHIFT) circle(2);
        }

        circle(0.5);
    }
}

// $fn = 15;
// catTail();