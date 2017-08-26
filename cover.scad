use <delta.scad>
use <moab.scad>
use <motor_cover.scad>

cover();

module cover(){
    
    rotate([0,0,2])union(){
        translate([0,0,-26.25])delta(false);
        for(a=[0:2]){
            rotate([0,0,(120*a)])translate([70,0,0])
            rotate([0,0,150])translate([10.6,-1.78-4,0])motorCover();
            rotate([0,0,(120*a)])translate([22,75,27])rotate([90,0,0])microSwitchHolder();
        }
    }
    // ramps
    //translate([2,20,40])rotate([0,0,-30])ramps();
    
    
    fn = 12;
    
    // mounting tabs
    difference(){
        union(){
            for(a=[0:2]){
                rotate([0,0,(120*a)])translate([80,-20,42])cylinder(r=7.2, h=30, $fn=50, center=true);
            }
        }
        union(){
            for(a=[0:2]){
                rotate([0,0,(120*a)])translate([80,-20,30])cylinder(r=1.7, h=15, $fn=50, center=true);
                rotate([0,0,(120*a)-30])translate([80,20,46])cube([20,13,26], center=true);
                rotate([0,0,(120*a)-30])translate([80,11,30])cube([20,13,26], center=true);
                rotate([0,0,(120*a)-20])translate([90,18,46])cube([10,23,26], center=true);
            }
        }
    }
    // cover
    difference(){
        union(){
            translate([0,0,47])cylinder(r=90,h=40,center=true, $fn=fn);
            translate([0,0,-11])intersection(){
                translate([0,0,127])cylinder(r=90,h=100,center=true, $fn=fn);
                sphere(r=120, center=true, $fn=fn);
            }
        }
        
        for(a=[0:2]){
            rotate([0,20,(120*a)-30])translate([50,3,70])cylinder(r=20,h=140,center=true, $fn=fn);
            rotate([0,20,(120*a)-30])translate([70,3,70])cube([40,40,100], center=true);
        }
        
        // fan hole
        translate([0,0,60])cylinder(r=19, h=120, center=true);
        translate([0,0,115])cube([140,140,20], center=true);
        
        // side cutouts
        sfn = 8; // extra smothness on the sphere cutouts
        for(a=[0:2]){
            rotate([0,0,(120*a)])translate([150,100,50])sphere(r=120,center=true, $fn=fn+sfn);
        }
        inlet = 2;
        // inner cutout
        difference(){
            union(){
                translate([0,0,42])cylinder(r=90-inlet,h=50,center=true, $fn=fn);
                translate([0,0,-11])intersection(){
                    translate([0,0,127])cylinder(r=90-inlet,h=100,center=true, $fn=fn);
                    sphere(r=120-inlet, center=true, $fn=fn);
                }
            }
            for(a=[0:2]){
                rotate([0,10,(120*a)-30])translate([60,3,70])cylinder(r=24,h=100,center=true, $fn=fn);
                rotate([0,10,(120*a)-30])translate([82,3,70])cube([48,48,100], center=true);
            }
            translate([0,0,115-inlet])cube([140,140,20], center=true);
            // side cutouts
            for(a=[0:2]){
                rotate([0,0,(120*a)])translate([150,100,50])sphere(r=120+inlet,center=true, $fn=fn+sfn);
            }
        }
        
        // ramps connections.
        union(){
            rotate([0,0,-30])translate([-65,0,54-inlet])cube([20,65,18], center=true);
            rotate([0,0,-30])translate([-65,-17.5,64-inlet])cube([20,30,16], center=true);
        }
        
        // motor mounting
        for(a=[0:2]){
            rotate([0,0,(120*a)])translate([80,-20,40])cylinder(r=4, h=30, $fn=50, center=true);
        }
        
        // fan mountings
        union(){
            rotate([0,0,-30])translate([16,16,100])cylinder(r=1.7, h=40, center=true, $fn=30);
            rotate([0,0,-30])translate([-16,16,100])cylinder(r=1.7, h=40, center=true, $fn=30);
            rotate([0,0,-30])translate([-16,-16,100])cylinder(r=1.7, h=40, center=true, $fn=30);
            rotate([0,0,-30])translate([16,-16,100])cylinder(r=1.7, h=40, center=true, $fn=30);
        }
        
        
    }
    
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
    translate([-7,l,h])rotate([90,0,90])bracket();
    translate([24,l,h])rotate([90,0,-90])bracket();
    
    /*hs = 5;
    union(){
        translate([-25,-61.7,-hs])rotate([0,0,0])cube([55,10,hs]);
        translate([-60.4,-87.6,-hs])cylinder(r=5,h=hs, $fn=50);
        translate([-58,-92,-hs])rotate([0,0,30])cube([61,10,hs]);
    }*/
    
    // RAMPS, Downloaded from https://www.thingiverse.com/thing:34174
    import("RAMPS1_4.STL");
}
