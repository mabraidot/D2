use <delta.scad>

cover();



module motorCover(){
    
   roundness = 4;
   thickness = 3;
   w = 66;
   h = 45.5;
   l = 63.5;

   difference(){
        minkowski(){
           cube([w,l,h], center=true);
           sphere(r=roundness, $fn = 6, center=true);
        }
        union(){
            translate([0,roundness/2,-roundness+4])cube([w+4, l+roundness+4, h+roundness-4], center=true);
        
            translate([0,40.9,0])cube([l+20,30,l+20], center = true);
            translate([5,15.5,-31])cube([80,l+30,20], center = true);
            translate([30,24,-40])rotate([60,0,0])cube([20,l+30,l+20], center = true);
            translate([30,21.2,12])cube([20,20,20], center = true);
        }
    }
}


module cover(){
    %translate([0,0,-26.25])delta(false);
    for(a=[0:2]){
        rotate([0,0,(120*a)])translate([70,0,0])
        rotate([0,0,150])translate([10.6,-1.78-4,0])motorCover();
    }
}