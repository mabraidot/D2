height = 7;
$fn = 50;

module nut(){
    union(){
        cylinder(35, 1.7, 1.7, $fn=30);
        translate([-0.5,0,5])cylinder(3, 3.7, 3.7, $fn=6);
        translate([-2.2,-3.20,5])cube([10,6.4,3]);
        translate([0,0,30])cylinder(3, 3.7, 3.7, $fn=20);
    }
}



module pusher(){
    
    
    difference(){
        cylinder(r=7, h=height, center=true);
        translate([0,7,0])cylinder(r=10, h=height+5, center=true);
        rotate([0,0,45])translate([-6,6,0])cube([10,10,10], center=true);
        rotate([0,0,-45])translate([6,6,0])cube([10,10,10], center=true);
        translate([0,-5,0])rotate([90,-90,0])nut();
    }
    
}

module pencil(){
    
    difference(){
        union(){
            translate([14,0,0])cylinder(r=4.9, h=height, center=true);
            translate([-14,0,0])cylinder(r=4.9, h=height, center=true);
            cube([28,9.8,height], center=true);
            cylinder(r=11.9, h=height, center=true);
            translate([0,-5,0])cylinder(r=12, h=height, center=true);
        }
        
        translate([14,0,29])rotate([0,180,0])nut();
        translate([-14,0,29])rotate([0,180,0])nut();
        
        cylinder(r=8.5, h=height+5, center=true);
        translate([0,-3,0])cylinder(r=9, h=height+5, center=true);
        
        translate([0,-6,0])rotate([90,-90,0])nut();
    }
    
}

module holder_wing(){
    
    height2 = 5;
    difference(){
        union(){
            translate([14,0,0])cylinder(r=5, h=height2, center=true);
            translate([-14,0,0])cylinder(r=5, h=height2, center=true);
            cube([28,10,height2], center=true);
            cylinder(r=13, h=height2, center=true);
            translate([0,-5,0])cylinder(r=12, h=height2, center=true);
        }
        
        translate([14,0,29])rotate([0,180,0])nut();
        translate([-14,0,29])rotate([0,180,0])nut();
        
        cylinder(r=8.5, h=height2*6, center=true);
        translate([0,-3,0])cylinder(r=9, h=height2*6, center=true);
        
    }
    
}

module holder(){
    
    translate([0,0,15])difference(){
        cylinder(r=17, h=35, center=true);
        cylinder(r=13, h=40, center=true);
        translate([0,-11,0])cube([50,30,40], center=true);
        translate([14,0,0])cylinder(r=5, h=40, center=true);
        translate([-14,0,0])cylinder(r=5, h=40, center=true);
    
    }
    
    translate([0,0,30])rotate([0,180,0])holder_wing();
    holder_wing();
    
    difference(){
        union(){
            for (a = [0:2]) {
              rotate(a*120) {
                translate([0, -20, -1])cylinder(r=10, h=3, center=true, $fn=52);
              }
            }
        }
        union(){
            for (a = [0:2]) {
              rotate(a*120) {
                translate([0, -25, 0])cylinder(r=1.7, h=50, center=true, $fn=52);
              }
            }
        }
        translate([14,0,29])rotate([0,180,0])nut();
        translate([-14,0,29])rotate([0,180,0])nut();
        cylinder(r=8.5, h=10, center=true);
        translate([0,-3,0])cylinder(r=9, h=10, center=true);
    }
        
    
    
}



holder();
translate([40,-10,0])pencil();
translate([40,-10,0])pusher();