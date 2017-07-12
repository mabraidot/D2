use <arm.scad>

radius = 100; // 175
radius2 = radius/cos(30);

module delta(){
    for(a=[0:2]){
        //rotate([0,0,120*a])cube([radius2,10,10]);
        rotate([0,90,120*a])translate([-25,60,0])arm();
    }
    cylinder(r=radius2, h=5, center=true, $fn=6);
}

delta();