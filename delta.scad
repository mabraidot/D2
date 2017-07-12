use <arm.scad>
use <motor_end.scad>

radius = 100; // 175
radius2 = radius/cos(30);


module delta(){
    for(a=[0:2]){
        rotate([0,90,120*a])translate([-25,60,0])arm();
        rotate([0,0,(120*a)+90])translate([60,2,0])motor_end();
    }
    cylinder(r=radius2, h=5, center=true, $fn=6);
}

delta();