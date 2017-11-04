

module bumper(){
    cylinder(r=13,h=4, $fn=70, center=true);
}

bumper();
translate([0,35,0])bumper();
translate([25,18,0])bumper();