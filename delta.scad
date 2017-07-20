use <arm.scad>
use <motor_end.scad>

use <nema.scad>


rod_d = 8; // Rod diameter
//rod_h = 50; // Rod support height

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

module fins(fin_h){
    ang = 45;
    
    translate([0,0,fin_h])intersection() {
        cube([5, fin_h, fin_h], center=true);
        rotate([ang, 0, 0]) translate([0, -fin_h, 0])cube([20, fin_h*2, fin_h*2], center=true);
    }
}


module rodMounting(rod_h){
    
    ang = 45;
    
    union(){
        rotate([ang,0,0])difference(){
            cylinder(r=rod_d, h=rod_h, center=true);
            translate([0,0,-1])cylinder(r=rod_d/2, h=rod_h+5, center=true);
        }
        translate([0,-10,-35])fins(35);
        rotate([ang,0,0])translate([0,0,rod_h/2])sphere(r=rod_d, center=true);
    }
    
    
}


module rodMountingFoot(rod_h){
    
    ang = 45;
    
    union(){
        rotate([0,ang,ang])translate([0,0,rod_h/2])rotate([0,0,0])difference(){
            cylinder(r=rod_d, h=rod_h, center=true);
            translate([0,0,-1])cylinder(r=rod_d/2, h=rod_h+5, center=true);
        }
        translate([0,rod_h/2,0])rotate([90,0,0])difference(){
            cylinder(r=rod_d, h=rod_h, center=true);
            translate([0,0,-1])cylinder(r=rod_d/2, h=rod_h+5, center=true);
        }
        translate([rod_h/2,0,0])rotate([0,90,0])difference(){
            cylinder(r=rod_d, h=rod_h, center=true);
            translate([0,0,-1])cylinder(r=rod_d/2, h=rod_h+5, center=true);
        }
        sphere(r=rod_d, center=true);
    }
    
    union(){
        intersection(){
            translate([-5,25,-7])rotate([0,35,0])fins(30);
            translate([-13,9,10])rotate([-45,35,-20])cube([20,40,40]);
        }
        intersection(){
            translate([-5,12,18])rotate([90,35,90])fins(30);
            translate([3,0,0])rotate([-20,30,-20])cube([40,20,40]);
        }
    }
    translate([-12,18,-rod_d+2.5])rotate([0,90,0])translate([0,0,0])fins(30);
        
}



module delta(){
    
    arm_angle = 0;
        
    union(){
        // Center spheric support
        intersection(){
            translate([0,0,21])cube([62,62,32], center=true);
            rotate([0,0,0])sphere(r=35.9, $fn = 6);
        }
        
        for(a=[0:2]){
            difference(){
                rotate([0,0,(120*a)])translate([-62,-10,0])support();
                rotate([45,0,(120*a)+90])translate([10,40,-30])cylinder(r=6, h=40, center=true);    
            }
            
            rotate([0,-120,(120*a)+90])translate([11,-8,-40])microSwitch();
            
            rotate([0,0,(120*a)+90])translate([50,10,5])motor_end(false);
            
            // Rod support
            //rotate([0,0,(120*a)+60])translate([-19,60,23.3])rodMounting();
            difference(){
                rotate([0,0,(120*a)+90])translate([10,40,15])rodMounting(60);
                rotate([0,0,(120*a)+90])translate([-5,10,-15])cube([35,60,15]);
            }
            
            
            // Motor and arm
            //rotate([0,0,(120*a)+30])translate([-50,-3,27])nema17(48);
            //rotate([0,90,120*a])translate([-27,50,5])rotate([0,180,arm_angle])arm();
            
        }
    }
}

//rodMountingFoot(50);
delta();