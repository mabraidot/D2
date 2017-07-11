
support_width = 10; // The same as in carriage.scad, thoug without clearance
shaft_diam = 5.5;
$fn = 100;

module nut(){
    union(){
        translate([0,0,2])cylinder(25, 1.7, 1.7);
        translate([-0.5,0,5])cylinder(3, 3.5, 3.5, $fn=6);
        translate([-2.2,-3.05,5])cube([10,6.1,3]);
    }
}

module arm(){
    
    difference(){
        union(){
            difference(){
                cylinder(r=10, h=support_width+10);
                translate([1,0,15])rotate([0,-90,0])nut();
            }
            cylinder(r=20, h=support_width);
            translate([10,0,0])rotate([0,0,8])cube([10,110,support_width]);
            translate([-20,0,0])rotate([0,0,-8])cube([10,108,support_width]);
        }
        translate([0,0,-1])cylinder(r=shaft_diam/2, h=30);
    }
    
}

arm();