
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
            translate([x, 5.5, 0])cylinder(r=cutout/2, h=100, center=true, $fn=24);
            translate([x, -4.5, 0])cube([cutout, 20, 100], center=true);
            translate([x, 0, 0]) rotate([0, 90, 0]) rotate([0, 0, 30])cylinder(r=3.3, h=17, center=true, $fn=6);
        }

        translate([0, 2, 0]) cylinder(r=middle, h=100, center=true);
        translate([0, -8, 0]) cube([2*middle, 20, 100], center=true);
    }
}

module carriage() {
    
    union() {
        translate([0, 0, 0])parallel_joints(16);
    }
      
}

carriage();

// Uncomment the following lines to check endstop alignment.
// use <idler_end.scad>;
// translate([0, 0, -20]) rotate([180, 0, 0]) idler_end();
