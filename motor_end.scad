h = 44; // Total height.
m = 29; // Motor mounting screws distance (center to center)
w = 60; // Smooth rod distance (center to center)

module wall(h){
    union() {
      translate([0, 7.5, 0]) cube([w+10, 5, h], center=true);
      // Sandwich mount.
      translate([-w/2, 10, 0]) cylinder(r=5, h=h, center=true);
      translate([w/2, 10, 0]) cylinder(r=5, h=h, center=true);
    }
}


module motor_end() {
    translate([0, 0, h/2]) 
    difference() {
    union() {
      wall(h);
      for (x = [-30, 30]) {
        // Diagonal fins.
        translate([x, 29.5, 0]) intersection() {
          cube([5, 30, h], center=true);
          rotate([45, 0, 0]) translate([0, -50, 0])
            cube([20, 100, 100], center=true);
        }
        // Extra mounting screw holes.
        translate([x, 47, 4-h/2]) difference() {
          cylinder(r=5, h=8, center=true, $fn=24);
          translate([0, 1, 0]) cylinder(r=1.9, h=9, center=true, $fn=12);
        }
      }
    }
    // Sandwich mount.
    translate([-w/2, 10, 0]) cylinder(r=1.9, h=h+1, center=true);
    translate([w/2, 10, 0]) cylinder(r=1.9, h=h+1, center=true);
    
    // Motor shaft
    rotate([90, 0, 0]) cylinder(r=12, h=40, center=true);
    // Motor mounting screw slots
    translate([m/2, 0, m/2]) rotate([0, -45, 0])cube([9, 40, 3], center=true);
    translate([-m/2, 0, m/2]) rotate([0, 45, 0])cube([9, 40, 3], center=true);
    translate([m/2, 0, -m/2]) rotate([0, 45, 0])cube([9, 40, 3], center=true);
    translate([-m/2, 0, -m/2]) rotate([0, -45, 0])cube([9, 40, 3], center=true);
  }
}

motor_end();