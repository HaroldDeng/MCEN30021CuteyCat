module motroWithHorn(hornDegree){
    union(){
        color("blue") translate([-58, -34, -30]) import("./motor.stl");
        color("white") difference(){
            c_length  = 10;
            c_width = 40;
            c_height = 1.5;
            rotate([0, 0, hornDegree]) difference(){

                // generate horn
                cube([c_length, c_width, c_height], center=true);
                translate([0, -c_width / 2 - 5, 0]) cube([c_length + 1, c_width + 1, c_height + 1], center=true);
                
                // seven holes
                for(i = [0:6]){
                    translate([0, 5 + 2 * i, 0]) cylinder(5, 0.5, 0.5, center=true);
                }
            }
        }
    }
}