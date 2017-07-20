use <arm.scad>
use <motor_end.scad>

use <nema.scad>


radius = 100; // 175
radius2 = radius/cos(30);


module microSwitch(){
/*

        5.82
  _    |___|
       /  /| _
 12.6 /  / | 1 (desde el fondo del switch hasta el centro del hueco)
  _  /__/ o/
 6.2 |  |o/|
  _  |__|/|6.6 (centro a centro de los huecos, equidistantes horizontalmente)
    
    o: m2
    
*/
    
    union(){
        difference(){
            union(){
                translate([8,0,0])cube([3,15,20]);
                cube([11,15,8]);
                
            }
            union(){
                translate([1.5,1.5,-1])cube([5.82,12.6,12]);
                translate([-1,6.5,-1])cube([5,2.6,12]);
            }
            //rotate([0,-90,0])translate([15,7.5,-20])nut();
        }
        translate([1.5,4.5,5.2])sphere(r=1, $fn=50);
        translate([1.5,11.1,5.2])sphere(r=1, $fn=50);
    }
}


module support(){
    union(){
        translate([55,-35,0])rotate([0,0,30])cube([30,60,5]);
        difference(){
            translate([-10,0,0])cube([57,95,5]);
            translate([0,-25,-2])rotate([0,0,45])cube([30,50,9]);
        }
    }
}

module fins(){
    translate([0,0,28])intersection() {
        cube([5, 40, 46], center=true);
        rotate([45, 0, 0]) translate([0, -53, 0])cube([20, 100, 100], center=true);
    }
}


module rodMounting(){
    
    rod_d = 8; // Rod diameter
    rod_h = 50; // Rod diameter
    fin_h = 30;
    ang = 45;
    
    union(){
        rotate([ang,0,0])difference(){
            cylinder(r=rod_d, h=rod_h, center=true);
            translate([0,0,-1])cylinder(r=rod_d/2, h=rod_h+5, center=true);
        }
        translate([0,-4,-5])intersection() {
            cube([5, fin_h, fin_h], center=true);
            rotate([ang, 0, 0]) translate([0, -fin_h, 0])cube([20, fin_h*2, fin_h*2], center=true);
        }
        rotate([ang,0,0])translate([0,0,rod_h/2])sphere(r=rod_d, center=true);
    }
    
    
}


module delta(){
    
    arm_angle = 0;
    
    // Center spheric support
    intersection(){
        translate([0,0,21])cube([62,62,32], center=true);
        rotate([0,0,0])sphere(r=35.9, $fn = 6);
    }
    
    translate([150,0,0])rodMounting();
    
    for(a=[0:2]){
        rotate([0,0,(120*a)])translate([-62,-10,0])support();
        
        rotate([0,-120,(120*a)-30])translate([11,-8,-40])microSwitch();
        
        //rotate([0,0,(120*a)+90])translate([-2,17.5,0])rotate([0,0,90])fins();
        rotate([0,0,(120*a)+90])translate([50,10,5])motor_end(false);
        
        // Motor and arm
        rotate([0,0,(120*a)+30])translate([-50,-3,27])nema17(48);
        rotate([0,90,120*a])translate([-27,50,5])rotate([0,180,arm_angle])arm();
    }
    //cylinder(r=radius2, h=5, center=true, $fn=6);
}

delta();