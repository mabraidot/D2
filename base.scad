


module clamp(){
    difference(){
        cylinder(r=8, h=15, center=true);
        cylinder(r=5, h=60, center=true);
        translate([13,0,0])cube([20,20,20], center=true);
    }
}

module bar(){
    translate([-102.5,-3.8,0.5])rotate([0,90,120])clamp();
    translate([102.5,-3.8,0.5])rotate([0,90,-120])clamp();
    difference(){
        cube([200,12,5], center=true);
        translate([105,-5,0])rotate([0,0,-120])cube([20,20,10], center=true);
        translate([-105,-5,0])rotate([0,0,120])cube([20,20,10], center=true);
    }
}

module base(){

    %cube([190,190,10], center=true);
    for (a = [0:2]) {
        rotate(a*120) translate([0, 160, 0])rotate([0,90,0])cylinder(r=5, h=500, center=true);
    }
    for (a = [0:2]) {
        //translate([120,69.3,-0.5])rotate([0,0,a*120])bar();
        
    }
    
    translate([-120,69.3,-0.5])rotate([0,0,240])bar();
    translate([120,69.3,-0.5])rotate([0,0,120])bar();
    translate([0,-139,-0.5])rotate([0,0,0])bar();
    
    
}

base();