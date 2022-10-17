include <./Constants.scad>;

// create horizontal row
module solidRod(height=ROD_LENGTH, radius=ROD_RADIUS) {
    // make a horizontal beam
    rotate(RT_X_CW_90) cylinder(height, radius, radius, center=true);
}

// create hollowed horizontal row
module hollowRod() {
    difference() {
        solidRod(ROD_LENGTH, ROD_RADIUS);
        solidRod(ROD_LENGTH + 1, ROD_RADIUS - WALL_THICKNESS);
    }
}

// create a horn for the row
module hornWithHoles(){
    color(HORN_COLOR) translate(HORN_POS) rotate(HORN_RT) difference(){

        // generate horn bed
        cube(HORN_BED_SIZE, center=true);
    
        // create holes
        translate(HORN_HLOE_POS_1) solidRod(HORN_BED_SIZE[1] * 2, HORN_HOLE_RADIUS);
        translate(HORN_HLOE_POS_2) solidRod(HORN_BED_SIZE[1] * 2, HORN_HOLE_RADIUS);
    }
}

// create supporting rod for the head
module headRod() {
    hollowRod();
    hornWithHoles();
}

//headRod();