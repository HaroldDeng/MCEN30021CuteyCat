include <./Constants.scad>;
include <./headRod.scad>;

// create soild ear, the ear is make out of a distorted sphere
module ear(radius){
    scale(EARS_DISTORTION) sphere(radius);
}

// create soild face (empty ball)
module face(radius){
    sphere(radius);
}

// create hollow face and ears
module hollowFaceAndEars(){
    difference(){
        union() {
            // face
            face(BASE_SPHERE_RADIUS);
            // ears
            translate(LF_EAR_POS) rotate(LF_EAR_RT) ear(HERS_SIZE);
            translate(RG_EAR_POS) rotate(RG_EAR_RT) ear(HERS_SIZE);
        }

        translate(LF_EAR_POS) rotate(LF_EAR_RT) ear(HERS_SIZE - WALL_THICKNESS);
        translate(RG_EAR_POS) rotate(RG_EAR_RT) ear(HERS_SIZE - WALL_THICKNESS);
        face(BASE_SPHERE_RADIUS - WALL_THICKNESS);
    }
}

module intrudeHead() {
    difference() {
        hollowFaceAndEars();
        translate(HEAD_INTRUDE_POS) scale(INTRUDE_HEAD_RATIO) sphere(1);    
    }
}



module catHead(){
    scale(FINAL_SCALE) union(){
        translate(FINAL_HEAD_POS) scale(FINAL_HEAD_SCALE) rotate(FINAL_HEAD_RT) {
            translate(HEAD_POS) {
                intrudeHead();
            }
            headRod();
        }
    }
}

//catHead();
