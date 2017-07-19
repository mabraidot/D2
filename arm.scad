
support_width = 10; // The same as in carriage.scad, thoug without clearance
shaft_diam = 5.2;
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
            difference(){
                translate([10,0,0])rotate([0,0,8])cube([10,110,support_width]);
                translate([-15.35,105,-1])rotate([0,0,-8])cube([10,10,support_width+2]);
                translate([-10,108,-1])cube([20,10,support_width+2]);
            }
            translate([-20,0,0])rotate([0,0,-8])cube([10,108,support_width]);
        }
        translate([0,0,-1])cylinder(r=shaft_diam/2, h=30);
        // Mounting hole
        // Long hole
        //translate([-20,70,((support_width/2)-(3.4/2))])rotate([0,0,10])cube([40,30,3.4]);
        // left hand
        //translate([-20,97,support_width/2])rotate([-10,90,0])cylinder(r=1.7, h=40);
        // Right hand
        translate([-20,102,support_width/2])rotate([10,90,0])cylinder(r=1.7, h=40);
    
    }
    
    
}

arm();