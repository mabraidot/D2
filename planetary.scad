// Differential Planetary Gearset

use <MCAD/involute_gears.scad>

//$fn = 150;
//fourgears();
//ring1();
//ring2();
//ballbearingCap();
assembly();


d1= 60;// diameter of lower ring
t=6;// thickness of all gears
t1=1.2;// thickness of ring faces
b=0.05;// backlash
c=0.2;// clearance
pc=4;// planet clearance
pa=20;// pressure angle
s=0.4;// vertical clearance
td=0.8;// thickness of planet disk
pd=1.1;// planet disk diameter / pitch diameter
dp=0.85;// ring gear diameter / outside ring diameter

ns=12;// number of teeth on sun (lower)
np1=20;// number of teeth on lower planet
delta=-1;// difference in teeth between upper and lower

// -------- My settings
bd = 2.7; //steel balls diameter
hd = 20; // diameter of the shaft hole
setBoltHoleDiameter = 7; // bolt head diameter of the motor mounting
nema = 17;

// Captive Nut traps allow you to tighten the arm structure onto a bearing. 
nutCount = 6; 
nutDiameter = 5.8; 				 	// The distance across the nut, from flat to flat, default M3
nutThickness = 2.5; 				 	// The thickness of the nut, default M3
setScrewDiameter = 3.3;			 	 	// The diameter of the set screw clearance hole, default M3
attachmentHeight = 10;              // Height of arm structure attachment




//--------- Don't edit below here unless you know what you're doing.

nr1=ns+2*np1;// number of teeth on lower ring
pitch=nr1/(d1*dp); // diametral pitch of all gears
planetPitch = (nr1+pc) / (d1*dp); // diametral pitch of all planets
nr2=nr1+delta;
np2=np1+delta;

R1=(1+nr1/ns);// sun to planet-carrier ratio
R2=nr2/((ns+np1)*(1-np2/np1));// planet-carrier to ring ratio
Rp=(np1+ns)/np1;// planet to planet-carrier ratio
R=R1*R2;// total sun to ring ratio
echo(str("Gear Ratio is 1 : ",R));

module assembly(){
    ring1();
    translate([(nr1/pitch/2/dp)-0.4,0,(2*t+2*s+td-0.4)])ballbearingCap();
    //translate([0,0,2*t+2*s+td+0.1])rotate([180,0,360*$t])ring2();
    
    translate([0,0,t])rotate([180,0,180/ns+360*R*$t])
    sun();
    rotate([0,0,360*R2*$t])translate([(ns+np1)/pitch/2,0,0])rotate([0,0,-360*R2*(1+Rp)*$t])
    planet();
    rotate([0,0,120+360*R2*$t])translate([(ns+np1)/pitch/2,0,0])rotate([0,0,-120-360*R2*(1+Rp)*$t])
    planet();
    rotate([0,0,-120+360*R2*$t])translate([(ns+np1)/pitch/2,0,0])rotate([0,0,120-360*R2*(1+Rp)*$t])
    planet();
}


module fourgears(){
	sun();
	for(i=[0,120,-120])
		rotate([0,0,i])translate([1.2*(ns+np1)/pitch/2,0,0])
			rotate([0,0,-i])planet();
}



module sun(){
    shaftHeight = 25;
    union(){
        gear(number_of_teeth=ns,
            diametral_pitch=pitch,
            gear_thickness=t,
            rim_thickness=t,
            hub_thickness=t,
            bore_diameter=0,
            backlash=b,
            clearance=c,
            pressure_angle=pa);
        
        difference(){
            translate([0,0,t])cylinder(r=4, h=shaftHeight);
            translate([0,0,t+0.1+shaftHeight-15])shaftHole(shaftDiameter = 5.8, shaftHubDiameter = 3.9, height=15);
        }
    }
}


module planet(){
    difference(){
        union(){
            gear(number_of_teeth=np1,
                diametral_pitch=planetPitch,
                gear_thickness=t+s+td/2,
                rim_thickness=t+s+td/2,
                hub_thickness=t+s+td/2,
                bore_diameter=0,
                backlash=b,
                clearance=c,
                pressure_angle=pa);
        translate([0,0,t+s])cylinder(r=pd*np1/planetPitch/2,h=td,$fn=np1);
        translate([0,0,t+s+td/2])
            gear(number_of_teeth=np2,
                diametral_pitch=planetPitch,
                gear_thickness=t+s+td/2,
                rim_thickness=t+s+td/2,
                hub_thickness=t+s+td/2,
                bore_diameter=0,
                backlash=b,
                clearance=c,
                pressure_angle=pa);
        }
        translate([0,0,t*2.1+s])cylinder(r=1,h=2);
    }
}




module ring1() {
    
    attachmentRadius  =  (nr1/pitch/2/dp)+4;
    cubeClearance = 9*c;
    
    difference(){
        union(){
            insidegear(nr1);
            
            // Ballbearing collar
            difference(){
                translate([0,0,-0.2])cylinder(r=(nr1/pitch/2/dp)+4, h=2*t+2*s+td+4.5);
                translate([0,0,-0.5])cylinder(r=(nr1/pitch/2/dp), h=2*t+2*s+td+6);
                translate([0,0,2*t+2*s+td-0.4])rotate([180,0,0])ballSlot(nr1+c);
                
                // Ballbearing insertion hole
                union(){
                    translate([(nr1/pitch/2/dp)+0.6,0,(2*t+2*s+td-0.4)])rotate([0,90,0])cylinder(h=10,r=(bd/2)+4*c);
                    translate([(nr1/pitch/2/dp)+2,-((bd)+cubeClearance)/2,(2*t+2*s+td-0.4)-(((bd)+cubeClearance)/2)])cube([4,(bd)+cubeClearance,(bd)+cubeClearance]);
                }
            }
            // Ballbearing cap
            //translate([(nr1/pitch/2/dp)-0.4,0,(2*t+2*s+td-1.4)])ballbearingCap();
            // Arm attachment
            translate([0,0,-attachmentHeight-0.1])armAttachment(attachmentRadius, attachmentHeight);
        }
        // Bolt traps
        rotate([0,180,0])bolts();
    }
    
}


module ring2(){
    
    attachmentRadius = nr2/pitch/2/dp;
    extraHeight = 10;
    union(){
        difference(){
            insidegear(nr2);
            translate([0,0,1.5])ballSlot(nr2-c);
        }
        translate([0,0,-attachmentHeight-0.1-extraHeight])armAttachment(attachmentRadius, attachmentHeight+extraHeight);
    }
}



module ballbearingCap(){
    cubeClearance = 7*c;
    
    union(){
        difference(){
            rotate([0,90,0])cylinder(h=4,r=(bd/2)+3*c);
            translate([0,5,0])rotate([90,0,0])cylinder(r=(bd/2)+3*c, h=10);
            translate([-8.9,5,-5])rotate([90,0,0])cube([10,10,10]);
        }
        translate([2.4,-((bd)+cubeClearance)/2,-((bd)+cubeClearance)/2])cube([1.8,(bd)+cubeClearance,(bd)+cubeClearance]);
    }
}


module insidegear(n){
    rotate([180,0,0])translate([0,0,-t])
    difference(){
        cylinder(r=n/pitch/2/dp,h=t+t1);
        translate([0,0,-0.5])cylinder(r=hd/2,h=t+t1+1);
        translate([0,0,-1])
        gear(number_of_teeth=n,
            diametral_pitch=pitch,
            gear_thickness=t+1,
            rim_thickness=t+1,
            hub_thickness=t+1,
            bore_diameter=0,
            backlash=-b,
            clearance=0,
            pressure_angle=pa);
    }
}


module ballSlot(n){
    union(){
        rotate_extrude(convexity = 10)translate([(n/pitch/2/dp)+c, 0, 0])circle(r = (bd/2)+c);
    }
}

module armAttachment(n, height){
    difference(){
        cylinder(r=n,h=height);
        translate([0,0,5])nuts(n-3);
        translate([0,0,-0.5])cylinder(r=hd/2,h=t+t1+30);
    }
}


module nuts(diameter){
    
    internalWidth = 8;
    holeDiameter = 8;
    wallThickness = (nr1/pitch/2/dp);
    wallCenterRadius = diameter-2;
    
    // Punch out the nut traps if necessary 
    if ( nutCount > 0 ) {
        for ( i = [0 : nutCount-1] ) {
            rotate( i*(360/nutCount), [0, 0, 1]) {
                translate([wallCenterRadius,0,0]) {
                    rotate([0,90,180]) {
                        nutTrap(
                            nutDiameter, 
                            nutThickness, 
                            setScrewDiameter, 
                            depth=(internalWidth/2)+0.5, //0.5 extra so it renders well
                            holeLengthTop=wallThickness/8, 
                            holeLengthBottom=wallThickness/2
                        );
                    }
                }
            }
        }
    }
}

module nutTrap( inDiameter=5.6, thickness=2.4, setScrewHoleDiameter=3, depth=10, holeLengthTop=5, holeLengthBottom=5 ){
    
	side = inDiameter * tan( 180/6 );
	render()
	union() {
		for ( i = [0 : 2] ) {
			rotate( i*120, [0, 0, 1]) 
				cube( [side, inDiameter, thickness], center=true );
		}
	
		translate([(depth/2)+1,0,0]) 
			cube( [depth, inDiameter, thickness], center=true );
	
		translate([0,0,-(thickness/2)-holeLengthBottom]) 
			cylinder(r=setScrewHoleDiameter/2, h=thickness+holeLengthTop+holeLengthBottom);
	}
}


module bolts(){
    
    nemaDistance = (nema==11) ? 23 : (nema==14) ? 26 : (nema==17) ? 31 : (nema==23) ? 47.1 : (nema==34) ? 69.6 : (nema==42) ? 89 : 0;
    wallCenterRadius = sqrt( 2*pow(nemaDistance, 2) ) / 2;
    boltCount = 4; 
    boltThickness = 5;
    boltDepth = 4;
    
    // Punch out the nut traps if necessary 
    if ( boltCount > 0 ) {
        for ( i = [0 : boltCount-1] ) {
            rotate( (i*(360/boltCount))+15, [0, 0, 1]) 
                translate([wallCenterRadius,0,boltDepth]) 
                    boltTrap(
                        setBoltHoleDiameter, 
                        boltThickness, 
                        setScrewDiameter
                        );
        }
    }
}

module boltTrap( setBoltHoleDiameter=7, boltThickness=10, setScrewHoleDiameter=3 ){
	union() {
		translate([0,0,-boltThickness]) 
			cylinder(r=setBoltHoleDiameter/2, h=boltThickness);
		translate([0,0,-boltThickness]) 
			cylinder(r=setScrewHoleDiameter/2, h=boltThickness+20);
	}
}


module shaftHole(shaftDiameter = 8, shaftHubDiameter = 0, height=20){
    
    translateShaftDiameter = (shaftHubDiameter>0) ? (shaftHubDiameter/2) : (shaftDiameter/2);
    
    difference(){
        cylinder(r=shaftDiameter/2, h=height);
        translate([-7.5,translateShaftDiameter,0])cube([15,10,height+0.1]);
    }
    
}