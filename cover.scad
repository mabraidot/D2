use <delta.scad>
use <moab.scad>

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
        translate([(w/2)-2.98, (l/2)-10.97, 40])cylinder(r=1.9, h=50, center=true, $fn=50);
        translate([-(w/2)+2.98, (l/2)-10.97, 40])cylinder(r=1.9, h=50, center=true, $fn=50);
    }
    
}


module cover(){
    %translate([0,0,-26.25])delta(false);
    for(a=[0:2]){
        rotate([0,0,(120*a)])translate([70,0,0])
        rotate([0,0,150])translate([10.6,-1.78-4,0])motorCover();
    }
    // ramps
    translate([0,30,40])rotate([0,0,0])ramps();
    //translate([0,0,130])rotate([0,0,90])psu();

}


module psu(){
    w=150;
    l=160;
    h=86;
    difference(){
        cube([l,w,h], center=true);
        translate([0,0,(h/2)-4])cylinder(r=50, h=10, center=true);
        translate([l/2,22,0])rotate([0,90,0])cylinder(r=20, h=10, center=true);
        translate([l/2,-22,0])rotate([0,90,0])cylinder(r=20, h=10, center=true);
    }
    
}

module ramps(){
    //fan
    //%translate([-23,-40,50])cube([40,40,10]);
    
    // brackets
    h = 49.5;
    l = -17.7;
    translate([-20,l,h])rotate([90,0,90])bracket();
    translate([14,l,h])rotate([90,0,-90])bracket();
    
    // RAMPS, Downloaded from https://www.thingiverse.com/thing:34174
    import("RAMPS1_4.STL");
}
