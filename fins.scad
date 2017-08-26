ang = 30;

module fins(fin_h, triangle=false){
    
    if(triangle){
        difference() {
            cube([3, ((fin_h*sin(ang))/cos(ang))*2, fin_h], center=true);
            rotate([ang, 0, 0]) translate([0, -fin_h-5, 0])cube([20, fin_h*2, fin_h*2], center=true);
            rotate([-ang, 0, 0]) translate([0, fin_h+5, 0])cube([20, fin_h*2, fin_h*2], center=true);
        }
    }else{
        translate([0,2,fin_h])
        intersection() {
            cube([5, (fin_h*sin(ang))/cos(ang), fin_h], center=true);
            rotate([ang, 0, 0]) translate([0, -fin_h, 0])cube([20, fin_h*2, fin_h*2], center=true);
        }
    }
}


fins(40);