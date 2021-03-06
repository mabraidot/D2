use <carriage.scad>

//$fn = 100;
h=8;
platform_hinge_offset = 33; 
cutout = 12.5;
inset = 6;

module platform() {
  translate([0, 0, h/2]) 
  difference() {
    union() {
      for (a = [0:120:359]) {
        rotate([0, 0, a]) {
          translate([0, -platform_hinge_offset, 0]) parallel_joints(0);
          // Close little triangle holes.
          translate([0, 31, 0]) cylinder(r=5, h=h, center=true);
        }
      }
      cylinder(r=30, h=h, center=true);
    }
    cylinder(r=20, h=h+12, center=true);
    for (a = [0:2]) {
      rotate(a*120) {
        //translate([0, -25, 0])cylinder(r=2.2, h=h+1, center=true, $fn=12);
        translate([0, -25, 0])cylinder(r=1.7, h=h+1, center=true, $fn=12);
      }
    }
  }
}

platform();