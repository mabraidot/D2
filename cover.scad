use <delta.scad>


//delta(false);


/* Nema17
intersection() {
      cube([42, 47, 42], center=true);
      rotate([0, 45, 0]) cube([53, length, 53], center=true);
}*/

roundness = 4;
w = 47;
l = 53;
difference(){
     minkowski(){
        cube([w,l,w], center=true);
        sphere(r=roundness, $fn = 6, center=true);
     }
     translate([0,roundness/2,-roundness])cube([w, l+roundness, w+roundness], center=true);
 }