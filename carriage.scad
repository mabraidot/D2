
//$fn = 100;
support_width = 10.6;
width = 76;
height = 24;

offset = 25;
cutout = 13;
middle = 2*offset - width/2;

module parallel_joints(reinforced) {
    difference() {
        union() {
            intersection() {
                cube([width, 20, 8], center=true);
                rotate([0, 90, 0]) cylinder(r=5, h=width, center=true);
            }
            
            translate([0, 8, 0]) cube([width, 16, 8], center=true);
            
            intersection() {
                translate([0, 18, 4]) rotate([45, 0, 0])cube([width, reinforced, reinforced], center=true);
                translate([0, 0, 16]) cube([width, 35, 40], center=true);
            }
        }

        rotate([0, 90, 0]) cylinder(r=1.55, h=80, center=true, $fn=12);

        for (x = [-offset, offset]) {
            translate([x, 5.5, 0])cylinder(r=cutout/2, h=100, center=true);
            translate([x, -4.5, 0])cube([cutout, 20, 100], center=true);
            translate([x, 0, 0]) rotate([0, 90, 0]) rotate([0, 0, 30])cylinder(r=3.3, h=17, center=true, $fn=6);
        }

        translate([0, 2, 0]) cylinder(r=middle, h=100, center=true);
        translate([0, -8, 0]) cube([2*middle, 20, 100], center=true);
    }
}



module carriage() {
    difference(){
        union(){
            difference(){
                parallel_joints(16);
                union(){
                    mirror([1,0,0])translate([39,11,-5])intersection(){
                        translate([-10,-8, 0])cube([10,16,25]);
                        translate([0, 0, 0])rotate([0,0,45])cube([10,10,25]);
                    }
                    translate([39,11,-5])intersection(){
                        translate([-10,-8, 0])cube([10,16,25]);
                        translate([0, 0, 0])rotate([0,0,45])cube([10,10,25]);
                    }
                }
            }
            difference(){
                translate([0, 9.5, -4])union(){
                    translate([20,0,0])intersection(){
                        translate([0, 8, 0])cube([10,16,20]);
                        translate([0, 0, 0])rotate([0,0,45])cube([10,10,20]);
                    }
                    translate([-20, 8, 0])cube([40,6.1,20]);
                    mirror([1,0,0])translate([20,0,0])intersection(){
                        translate([0, 8, 0])cube([10,16,20]);
                        translate([0, 0, 0])rotate([0,0,45])cube([10,10,20]);
                    }
                }
                w=support_width;
                translate([-(w/2), 18, -5])cube([w,10,25]);
            }
        }
        translate([-50, 10, 12])cube([100,20,15]);
        // bolt hole
        translate([0,10,3])rotate([90, 90, 0]) cylinder(r=1.55, h=30, center=true, $fn=12);
    }
    
}

carriage();
