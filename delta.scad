use <arm.scad>
use <motor_end.scad>

use <nema.scad>

$fn=100;
rod_d = 10; // Inner rod diameter
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

module fins(fin_h, triangle=false){
    
    if(triangle){
        difference() {
            cube([3, ((fin_h*sin(ang))/cos(ang))*2, fin_h], center=true);
            rotate([ang, 0, 0]) translate([0, -fin_h-5, 0])cube([20, fin_h*2, fin_h*2], center=true);
            rotate([-ang, 0, 0]) translate([0, fin_h+5, 0])cube([20, fin_h*2, fin_h*2], center=true);
        }
    }else{
        translate([0,2,fin_h])
        intersection() {
            cube([5, (fin_h*sin(ang))/cos(ang), fin_h], center=true);
            rotate([ang, 0, 0]) translate([0, -fin_h, 0])cube([20, fin_h*2, fin_h*2], center=true);
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


module rodMountingFoot(rod_h){
    
    union(){    
    difference(){
        union(){
            // rods
            translate([0,rod_d_o-1.3,rod_h/2-3.1])rotate([-ang,0,0])
                cylinder(r=rod_d_o/2, h=rod_h, center=true);
            translate([rod_d+2.35,(rod_h/2)-(rod_d/2)+1.4,0])rotate([90,0,-30])
                cylinder(r=rod_d_o/2, h=rod_h, center=true);
            translate([-rod_d-2.35,(rod_h/2)-(rod_d/2)+1.4,0])rotate([90,0,30])
                cylinder(r=rod_d_o/2, h=rod_h, center=true);
            
            //fins
            translate([-8.6,32,-(rod_d_o/2)+1.5])rotate([0,90,-30])fins(40, true);
            translate([14,30,10.5])rotate([63,-15,-30])fins(40, true);
            translate([-14,30,10.5])rotate([63,15,30])fins(40, true);
        }
        union(){
            translate([0,rod_d_o-1.3,rod_h/2-3.1])rotate([-ang,0,0])
                translate([0,0,-1])cylinder(r=rod_d/2, h=rod_h+5, center=true);
            translate([rod_d+2.35,(rod_h/2)-(rod_d/2)+1.4,0])rotate([90,0,-30])
                translate([0,0,-1])cylinder(r=rod_d/2, h=rod_h+5, center=true);
            translate([-rod_d-2.35,(rod_h/2)-(rod_d/2)+1.4,0])rotate([90,0,30])
                translate([0,0,-1])cylinder(r=rod_d/2, h=rod_h+5, center=true);
        }
    }
    // elbow
    sphere(r=rod_d_o/2, center=true);
    }
        
}



module delta(export){
    
    arm_angle = 0;
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
                    rotate([0,90,120*a])translate([-27,50,5])rotate([0,180,arm_angle])arm();
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


//microSwitch(false);
rodMountingFoot(50);
//delta(true);
