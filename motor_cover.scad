use <delta.scad>
use <cover.scad>


//translate([0,0,26.7])rotate([0,180,0])motorCover();
assembly();

module assembly(){
    cover();
    for(a=[0:2]){
        rotate([0,0,(120*a)])translate([70,0,0])
        rotate([0,0,150])translate([10.6,-1.78-4,0])motorCover();
    }
}

module motorCover(){
    
   roundness = 4;
   thickness = 3;
   w = 66;
   h = 45.5;
   l = 63.5;
   fn = 10;

   difference(){
        minkowski(){
            union(){
                cube([w,l,h], center=true);
                intersection(){
                    cube([w,l*3,h], center=true);
                    translate([0,-h/2,h/2])rotate([0,90,0])cylinder(r=h, h=w, center=true, $fn=fn);
                }
            }
            sphere(r=roundness, $fn = 6, center=true);
        }
        
        
        
        union(){
            translate([0,roundness/2,-roundness+4])cube([w+4, l+roundness+4, h+roundness-4], center=true);
            translate([0,roundness/2,-roundness+4])intersection(){
                cube([w+10,l*3,h], center=true);
                translate([0,-h/2,h/2])rotate([0,90,0])cylinder(r=h+4, h=w+4, center=true, $fn=fn);
            }
        
            translate([0,40.9,0])cube([l+20,30,l+20], center = true);
            translate([5,15.5,-31])cube([80,l+30,20], center = true);
            translate([30,24,-40])rotate([60,0,0])cube([20,l+30,l+20], center = true);
            translate([30,21.2,12])cube([20,20,20], center = true);
        
            // bolts
            translate([(w/2)-2.98, (l/2)-10.97, 40])cylinder(r=1.9, h=50, center=true, $fn=50);
            translate([-(w/2)+2.98, (l/2)-10.97, 40])cylinder(r=1.9, h=50, center=true, $fn=50);
            
            // vent holes
            for(o=[0:10]){
                v = ((o % 2) == 0) ? 0 : 5;
                translate([30-(o*6),-60,17-v])rotate([90,0,0])cylinder(r=1.9, h=50, center=true, $fn=50);
            }
        }
    }
}