
ch = 15;
cl = 100;

module nut2(){
    union(){
        cylinder(35, 1.7, 1.7, $fn=30);
        translate([0,0,5])cylinder(3, 4, 4, $fn=6);
        //translate([-2.2,-3.20,5])cube([10,6.4,3]);
        translate([0,0,30])cylinder(3, 3.7, 3.7, $fn=20);
    }
}


module clamp(){
    difference(){
        cylinder(r=8, h=ch, center=true);
        cylinder(r=5.1, h=ch*2, center=true);
        translate([5,-0.5,0])cube([10,9,20], center=true);
        translate([13,0,0])cube([20,20,20], center=true);
    }
    
}

module bar(){
    translate([-(cl/2)-5,0,0])rotate([0,90,90])clamp();
    translate([0,0,-3.5])difference(){
        cube([cl,ch,5], center=true);
        union(){
            translate([20,0,-2])cube([40,3.4,10], center=true);
            translate([20,0,-5])cube([44,8,10], center=true);
        }
    }
    
}



module balls(){
    
    bd = 8;
    r1 = 20;
    r2 = 40;
    r3 = 60;
    
    union(){
        translate([0,0,bd])sphere(r=7, center=true, $fn=70);
        for (a = [0:2]) {
            // row 1
            rotate([0,0,a*120-90])translate([r1,-8,bd])sphere(r=7, center=true, $fn=70);
            rotate([0,0,a*120-90])translate([r1,8,bd])sphere(r=7, center=true, $fn=70);
            // row 2
            rotate([0,0,a*120-90])translate([r2,-17,bd])sphere(r=7, center=true, $fn=70);
            rotate([0,0,a*120-90])translate([r2,0,bd])sphere(r=7, center=true, $fn=70);
            rotate([0,0,a*120-90])translate([r2,17,bd])sphere(r=7, center=true, $fn=70);
            
        }
        /*for (a = [0:2]) {
            // row 2
            rotate([0,0,a*120-30])translate([r2,-8,bd])sphere(r=7, center=true, $fn=70);
            rotate([0,0,a*120-30])translate([r2,8,bd])sphere(r=7, center=true, $fn=70);
        }*/
        for (a = [0:5]) {
            // row 3
            rotate([0,0,a*60-90])translate([r3,-17,bd])sphere(r=7, center=true, $fn=70);
            rotate([0,0,a*60-90])translate([r3,0,bd])sphere(r=7, center=true, $fn=70);
            rotate([0,0,a*60-90])translate([r3,17,bd])sphere(r=7, center=true, $fn=70);
        }
    }
    
}


module platform(){
    
    difference(){
        translate([0,0,-1])cube([400,400,10], center=true);
        union(){
            for (a = [0:6]) {
                rotate([0,0,a*60])translate([0,180,0])cube([300,200,40], center=true);
            }
        }
        for (a = [0:2]) {
            rotate([0,0,(a*120)-90])translate([-(80)-5,20,-3.5])cube([cl+1,ch+1,6], center=true);
            rotate([0,0,(a*120)-90])translate([-(80)-5,-20,-3.5])cube([cl+1,ch+1,6], center=true);
            rotate([180,0,(a*120)-90])translate([-(70)-5,20,-9.5])nut2();
            rotate([180,0,(a*120)-90])translate([-(70)-5,-20,-9.5])nut2();
        }
        balls();
    }
    
}

module base(){

    platform();
    
    // Threaded rods
    for (a = [0:2]) {
        rotate(a*120) translate([0, 160, 0])rotate([0,90,0])cylinder(r=5, h=500, center=true);
    }
    // Clamp bars
    for (a = [0:2]) {
        rotate([0,0,(a*120)-90])translate([-(100)-5,20,0])bar();
        rotate([0,0,(a*120)-90])translate([-(100)-5,-20,0])bar();
    }
    
}

//base();
//bar();
platform();