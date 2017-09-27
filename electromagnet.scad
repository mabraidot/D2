
module electromagnet_top(){
    
    difference(){
        union(){
            translate([0,0,16])cube([8,15,6], center=true);
            difference(){
                intersection(){
                    translate([0,0,-2])sphere(r=32, $fn=100);
                    translate([0,0,11])cylinder(r=22, h=22, $fn=100, center=true);
                }
                translate([0,0,9])cylinder(r=20, h=20, center=true);
            }
            for (a = [0:2]) {
              rotate(a*120) {
                translate([0, -20, 1.5])cylinder(r=10, h=3, center=true, $fn=52);
              }
            }
        }
        translate([0,0,9.5])cube([10.4,5.4,19], center=true);
        translate([0,6,-10])nut();
        translate([0,-6,-10])nut();
        translate([0,0,0])cylinder(r=20, h=10, center=true);
        for (a = [0:2]) {
          rotate(a*120) {
            translate([0, -25, 28])cylinder(r=4.6, h=50, center=true, $fn=52);
            translate([0, -25, 0])cylinder(r=1.7, h=50, center=true, $fn=52);
          }
        }
        translate([15,0,0])nut();
    }
}

module electromagnet_bottom(){
    difference(){
        union(){
            translate([0,0,1])cylinder(r=19, h=2, $fn=100, center=true);
            translate([0,0,4])cube([13,8,8], center=true);
            translate([0,0,3])cube([13,22,6], center=true);
        }
        translate([0,0,4])cube([10.8,5.6,10], center=true);
        translate([0,6.2,-3])rotate([0,0,0])nut();
        translate([0,-6.2,-3])rotate([0,0,0])nut();
    }
}

module electromagnet_tip(){
    
    difference(){
        union(){
            translate([0,0,4])cube([13,8,8], center=true);
            translate([0,0,2])sphere(r=8, center=true, $fn=70);
        }
        translate([0,0,4])cube([10.8,5.6,20], center=true);
        translate([0,0,13])cube([20,20,10], center=true);
        translate([0,0,-5])cube([20,20,10], center=true);
        sphere(r=6.5, center=true);
    }
    
}


module nut(){
    union(){
        cylinder(35, 1.7, 1.7, $fn=30);
        translate([-0.5,0,5])cylinder(3, 3.7, 3.7, $fn=6);
        translate([-2.2,-3.20,5])cube([10,6.4,3]);
        translate([0,0,30])cylinder(3, 3.7, 3.7, $fn=20);
    }
}


electromagnet_tip();
//electromagnet_bottom();
//electromagnet_top();