use <arm.scad>
use <fins.scad>
use <motor_end.scad>

use <nema.scad>

$fn=100;
rod_d = 9.6; // Inner rod diameter
rod_d_o = 14; // Outer rod diameter
ang = 30;

module microSwitch(negative){

    union(){
        difference(){
            union(){
                if(negative){
                    translate([7.8,-0.5,0])cube([3.4,16,22]);
                }else{
                    translate([8,-0.3,0])cube([3,15.6,20]);
                }
                translate([0,-0.3,0])cube([11,15.6,8]);
                
            }
            union(){
                translate([1.4,0.8,-1])cube([6,13.4,12]);
                translate([-1,6,-1])cube([5,2.6,12]);
            }
        }
        translate([1.1,4,5.2])sphere(r=1, $fn=50);
        translate([1.1,11.1,5.2])sphere(r=1, $fn=50);
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



module rodMounting(rod_h){
    
    union(){
        rotate([ang,0,0])difference(){
            cylinder(r=rod_d_o/2, h=rod_h, center=true);
            translate([0,0,-1])cylinder(r=rod_d/2, h=rod_h+5, center=true);
        }
        translate([0,-9,-35])fins(35);
        rotate([ang,0,0])translate([0,0,rod_h/2])sphere(r=rod_d_o/2, center=true);
    }
    
    
}



module bearing_clamp(){
    union(){
        difference(){
            cylinder(8, 15, 15);
            translate([0,0,-0.5])cylinder(9, 10.92, 10.92);
            translate([-3,10,-0.5])cube([6,5,9]);
        }
        difference(){
            union(){
                translate([3,12,0])cube([4,11,8]);
                translate([-7,12,0])cube([4,11,8]);
            }
            rotate([0,90,0])translate([-4,18,-8.5])rotate([0,0,90])bolt();
        }
    }
}




module delta(export){
    
    arm_angle = 80;
    difference(){
        union(){
            // Center spheric support
            intersection(){
                translate([0,0,21])cube([62,62,32], center=true);
                sphere(r=35.9, $fn = 6);
            }
            
            for(a=[0:2]){
                difference(){
                    rotate([0,0,(120*a)])translate([-62,-10,0])support();
                    rotate([ang,0,(120*a)+90])translate([10,42,-30])cylinder(r=(rod_d/2)+1, h=40, center=true);
                }
                
                //rotate([0,-120,(120*a)+90])translate([11,-8,-40])microSwitch();
                
                rotate([0,0,(120*a)+90])translate([50,10,5])motor_end(false, false);
                
                // Rod support
                //rotate([0,0,(120*a)+60])translate([-19,60,23.3])rodMounting();
                difference(){
                    rotate([0,0,(120*a)+90])translate([10,40,15])rodMounting(60);
                    rotate([0,0,(120*a)+90])translate([-5,10,-15])cube([35,60,15]);
                }
                
                
                // Motor and arm
                if(!export){
                    rotate([0,0,(120*a)+30])translate([-50,-3,27])nema17(48);
                    //rotate([0,90,120*a])translate([-27,50,5])rotate([0,180,arm_angle])arm();
                    rotate([0,90,120*a])translate([40,70,16])rotate([0,180,arm_angle])arm();
                }
                
            }
        }
        union(){
            for(a=[0:2]){
                rotate([0,-120,(120*a)+90])translate([11,-8,-40])microSwitch(true);
                // Bottom clamps
                rotate([0,0,(120*a)+20])translate([25,0,-4])rotate([0,0,90])union(){
                    cube([5,7,10]);
                    translate([0,0,9])cube([5,12,5]);
                }
            }
            
        }
        // Central hole
        union(){
            translate([0,0,26])cylinder(r=4, h=50, center=true);
            translate([0,0,-1])cylinder(r=2.5, h=10, center=true);
        }
    }
}



//bearing_clamp();
//microSwitch(false);
delta(false);
