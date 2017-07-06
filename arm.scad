use <gt2_pulley_22.scad>
use <gt2_pulley_100.scad>

/**************************************/
//$fn = 150;
armRadius = 30;
armHeight = 20;
armLength = 180;
bearingDiam = 22.8;
/**************************************/

translate([0,50,0])gt2SmallPulley();
translate([0,-70,0])gt2BigPulley();
arm();


module arm(){
    
    difference(){
        // arm structure
        union(){
            cylinder(r=armRadius/2, h=armHeight);
            translate([0,-(armRadius/2),0])cube([armLength,armRadius,armHeight]);
            translate([armLength,0,0])cylinder(r=max(armRadius/2, (bearingDiam/2)+3), h=armHeight);
        }
        // nut and bolt
        union(){
            translate([0,0,armHeight-8])cylinder(r=8,h=10, $fn=6);
            translate([0,0,-1])cylinder(r=4.2,h=50);
        }
        // bearing hole
        translate([armLength,0,0])union(){
            translate([0,0,-1])cylinder(r=4.6,h=50);
            translate([0,0,-1])cylinder(r=bearingDiam/2,h=10);
            translate([-30,-1,-1])cube([30,2,10]);
        }
    }
    
    
}


