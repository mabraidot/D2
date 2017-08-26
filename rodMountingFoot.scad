use <fins.scad>

$fn=100;
rod_d = 9.6; // Inner rod diameter
rod_d_o = 14; // Outer rod diameter
ang = 30;



module rodMountingFoot(rod_h){
    
    union(){    
    difference(){
        union(){
            // rods
            translate([0,rod_d_o-1.4,rod_h/2-3.2])rotate([-ang,0,0])
                cylinder(r=rod_d_o/2, h=rod_h, center=true);
            translate([rod_d+2.85,(rod_h/2)-(rod_d/2)+1.4,0])rotate([90,0,-30])
                cylinder(r=rod_d_o/2, h=rod_h, center=true);
            translate([-rod_d-2.85,(rod_h/2)-(rod_d/2)+1.4,0])rotate([90,0,30])
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



rodMountingFoot(50);