use <arm.scad>
use <motor_end.scad>

use <nema.scad>

radius = 100; // 175
radius2 = radius/cos(30);


module support(){
    union(){
        translate([47.4,-30,0])rotate([0,0,45])cube([30,60,5]);
        difference(){
            cube([47,95,5]);
            translate([0,-25,-2])rotate([0,0,45])cube([30,40,9]);
        }
    }
}
module fins(){
    translate([0,0,28])intersection() {
        cube([5, 40, 46], center=true);
        rotate([45, 0, 0]) translate([0, -50, 0])
        cube([20, 100, 100], center=true);
    }
}

module delta(){
    arm_angle = 45;
    intersection(){
        translate([0,0,16])cube([62,62,32], center=true);
        sphere(r=26, $fn = 100);
    }
    
    for(a=[0:2]){
        rotate([0,0,(120*a)])translate([-54,0,0])support();
        
        
        rotate([0,0,(120*a)+90])translate([11,9.5,0])rotate([0,0,90])fins();
        rotate([0,0,(120*a)+90])translate([60,2,5])motor_end(false);
        
        rotate([0,0,(120*a)+30])translate([-60,5,27])nema17(47);
        rotate([0,90,120*a])translate([-27,60,0])rotate([0,0,arm_angle])arm();
    }
    //cylinder(r=radius2, h=5, center=true, $fn=6);
}

delta();