// ------- GEAR BASE CODE --------------
//Taken from forum.openscad.org/file/n11323/gearModule.scad and slightly adapted
module tooth(width, thickness, height){
  scale([width/5,thickness/5,height/10]){
    difference(){
      translate([-2.5,0,0])
      cube([5,5,10]);
      translate([5+1.25-2.5,0-1,0])
      rotate([0,-14.0362434,0])
        cube([5,5+2,12]);
      translate([0-1.25-2.5,0+5+1,0])
      rotate([0,-14.0362434,180])
        cube([5,5+2,12]);
    }
  }
}
module gear(toothNo, toothWidth, toothHeight, thickness,holeRadius,holeSides){
  radius = (toothWidth*1.7*toothNo)/3.141592653589793238/2;
  rotate([-90,0,0])
  difference(){
    union(){
      for(i=[0:toothNo]){
        rotate([0,(360/toothNo)*i,0])
        translate([0,0,radius-0.5])
          tooth(toothWidth,thickness,toothHeight);
      }
      translate([0,thickness,0])
      rotate([90,0,0])
        cylinder(r=radius, h=thickness);
    }
  translate([0,thickness+1,0])
  rotate([90,0,0])
    cylinder(r=holeRadius,h=thickness+2,$fn=holeSides);
  }
}

//This is just a common bolt size; it's not precise but rather based on slight over-print from my machine
quarterInchR = 3.4;

//-----------------------------------
// --------- Parameters -------------
//-----------------------------------
towerBaseGearZ = 12; //How tall/thick the pan gear is
towerBaseGearR = 55; //Roughly how big around the pan gear is
motorGearR = 13; //Roughly how big the gear that fits on the motor is
motorGearZ = towerBaseGearZ; //Same thickness as the pan gear
motorGearHoleR = 4.2; //The hole cut that the motor fits into; roughly 5/16" for this one.
motorGearHoleCutR = 3.3; //The motos has a flat side, how close is the flat part to the center at it's closest
motorGearBaseHoleR = motorGearR+8; //The hole cut in the base to make room for the motor's gear.
motorGearLocationZ = 25;
motorGearBaseHoleExtraZ = 3;
//WARNING: Motor location is tuned by hand, because the math of where it should be is hard (gear interactions and the triangles of it's location).
baseMotorXLocation = 59;
baseMotorYLocation = 59;
baseMotorZLocation = 19;
//END TODO
baseMotorExtraZ = 8;
panToothWidth = 4;
ballBearingR = quarterInchR;
racewayReducedDepth = 1;
racewayR = towerBaseGearR - 20;
//tmp = towerBaseGearR - 9;
//rad = (toothWidth*1.7*toothNo)/3.141592653589793238/2;
towerGearTeeth = floor(towerBaseGearR*2*3.141592653589793238/1.7/panToothWidth);
motorGearTeeth = floor(motorGearR*2*3.141592653589793238/1.7/panToothWidth);
panToothHeight = 5;

baseInnerGearR = towerBaseGearR + 6; //this is the gap between inside wall and gear, ish
baseInnerGearZ = towerBaseGearZ + 4*racewayReducedDepth; //This is applied 2x for each of the two raceways 
baseInnerAttachmentHoleR = racewayR - ballBearingR - 3;
//tmp2 = tmp = towerBaseGearR - 9 - ballBearingR - 3;
baseZWallThickness = 7;
baseZ = baseZWallThickness*2+baseInnerGearZ;
baseR = baseInnerGearR + 7;
baseSliceGap = 0.3; //Twice this is the gap between the four base pieces.

towerBaseAttachmentHoleR = quarterInchR;
towerBaseAttachmentHoleZStart = 18; //Where the holes begin, as measured from above the gear top
towerBaseAttachmentHoleZOffsets = 8; //Distance between holes
towerBaseAttachmentCylinderZ = 35; // Height of the tower
//towerBaseAttachmentCylinderOuterR = baseInnerAttachmentHoleR-2;
towerBaseAttachmentCylinderOuterR = 22;
towerBaseAttachmentCylinderInnerR = towerBaseAttachmentCylinderOuterR - 8;

baseTabHoleR = quarterInchR;
baseTabWallExtra = 5; //Space around the hole
//Center of where the hole is
baseTabThickness = 20; //Total thickness 
//The tabs that attach the different parts of the base to itself. 


tiltGearR = 55;
tiltGearWidth = 12;
tiltGearToothWidth = 4;
tiltGearToothHeight = 5;

tiltGearTeeth = floor(tiltGearR*2*3.141592653589793238/1.7/tiltGearToothWidth);

towerZ = 110;
towerMainPivotHoleR = quarterInchR;
towerMainPivotGap = 0.5;
towerTopToBaseZGap = 0.3; //Space between where the tower sits and the base
towerTopToBaseRGap = 0.2; //Space between the inner cylinder and hole it must fit in
towerTopR = 20;


//Tilt gear and platform are add-on specific for now.
//   Might as well just print them together; makes it easier to print laying down.
tiltPlatformX = 70;
tiltPlatformZ = 24; //Should be wider than camera holes
tiltPlatformY = 10;
tiltPlatformZGap=10; //How far above the pivot does it sit (room for bolts)
tiltPlatformYOffset = 10; //How far foreward of pivot does it attach
tittPlatformHoleR = quarterInchR;
tiltPlatformSupportY = 20;
tiltPlatformSupportHoleR = quarterInchR;
tiltPlatformSupportX = 6;
tiltPlatformSupportHoleY = quarterInchR*2; //There is one on each side

//Add-ons to the tilt platform
//  They can reference the platform's edges for easier coding
tiltPlatformXMin = tiltPlatformX-towerTopR-towerMainPivotGap-tiltGearWidth;
tiltPlatformYMax = tiltPlatformY/2.0+tiltPlatformYOffset;
tiltPlatformZMax = tiltPlatformZ+towerTopR+tiltPlatformZGap;

cameraHolesX = 18;
cameraHolesZ = 13;
cameraHoleR = 2;
cameraEdgeExtra = 4;
cameraZ = cameraHolesZ+cameraEdgeExtra*2.0; 
cameraX = cameraHolesX+cameraEdgeExtra*2.0; 
cameraY = 5; //Width

cameraCenterX = 55;
cameraYCutout = tiltPlatformY - 10; //How much Y to cut out
cameraXCutout = cameraHolesX/2.0 + 5; //how much X to cut out behind camera

//----------------------------------------
//------------ Motor Mounts---------------
//----------------------------------------
//Used on both the top and bottom section
enginePlateBoltX = 60;
enginePlateBoltY = 63;
enginePlateBoltRad = 3.5; //2.7;
enginePlateBoltExtraRad = 5.5;
enginePlateBoltExtraDepth = 3;
enginePlateX = enginePlateBoltX + 20;
enginePlateY = enginePlateBoltY + 20;
enginePlateZ = 6;
//Engine Axle output
engineOutX = 11; //Relative to center
engineOutY = -2.5;
engineOutRad = 20/2.0; //The pip on the engine

//Used in both Pan and Tilt unit
module motorGear()
{
    rotate([0,0,15])
    difference()
    {
        gear(motorGearTeeth,panToothWidth,panToothHeight,motorGearZ,0,4);
        difference()
        {
            cylinder(r=motorGearHoleR,h=50,center=true);
            translate([5+motorGearHoleCutR,0,0])
            cube([10,10,50],center=true);
        }
    }
}

//Used in both pan and tilt
module engineHoles()
{
    holeDepth = 20;
    //Holes for mounting to engine
            translate([enginePlateBoltX/2.0,enginePlateBoltY/2.0,0]) 
            {
                cylinder(r=enginePlateBoltRad,h=holeDepth,center=true);
                translate([0,0,-10-enginePlateZ+enginePlateBoltExtraDepth])
                cylinder(r=enginePlateBoltExtraRad,h=20,center=true);
            }
            translate([-enginePlateBoltX/2.0,enginePlateBoltY/2.0,0])
            {
                cylinder(r=enginePlateBoltRad,h=holeDepth,center=true);
                translate([0,0,-10-enginePlateZ+enginePlateBoltExtraDepth])
                cylinder(r=enginePlateBoltExtraRad,h=20,center=true);
            }
            translate([enginePlateBoltX/2.0,-enginePlateBoltY/2.0,0])
            {
                cylinder(r=enginePlateBoltRad,h=holeDepth,center=true);
                translate([0,0,-10-enginePlateZ+enginePlateBoltExtraDepth])
                cylinder(r=enginePlateBoltExtraRad,h=20,center=true);
            }
            translate([-enginePlateBoltX/2.0,-enginePlateBoltY/2.0,0])
            {
                cylinder(r=enginePlateBoltRad,h=holeDepth,center=true);
                translate([0,0,-10-enginePlateZ+enginePlateBoltExtraDepth])
                cylinder(r=enginePlateBoltExtraRad,h=20,center=true);
            }
            //Hole for engine output
            translate([engineOutX,engineOutY,-40])
            cylinder(r=engineOutRad,h=100,center=true);
            
            //Make sure there's nothing in the way of the gear
            translate([engineOutX,engineOutY,motorGearLocationZ-motorGearZ/2.0])
            cylinder(r=motorGearBaseHoleR,h=motorGearZ+motorGearBaseHoleExtraZ*2.0,center=true);
}

//Used only on the tilt unit... TODO: Clean and consolidate
module enginePlate()
{
    difference()
    {
        union()
        {
            //Plate mounting to engine
            translate([0,0,-enginePlateZ/2.0])
            cube([enginePlateX,enginePlateY,enginePlateZ],center=true);
            //Show the gear
            translate([engineOutX,engineOutY,motorGearLocationZ])
            motorGear();
        }
        union()
        {
            engineHoles();
        }
    }
}
//Used on the pan unit. This is split into several pieces in order to interact correctly with the base; e.g. extra padding on part of it, able to make cutouts of the base
module enginePanPlate()
{
    //Plate mounting to engine
    translate([0,0,-enginePlateZ/2.0])
    cube([enginePlateX,enginePlateY,enginePlateZ],center=true);
    //A little extra to hold it up on the base plate
    translate([enginePlateX/4.0,0,baseMotorExtraZ/2.0-0.1])
    cube([enginePlateX/2.0,enginePlateY,baseMotorExtraZ],center=true);
}
module enginePanGear()
{
    //Show the gear
    translate([engineOutX,engineOutY,motorGearLocationZ])
    motorGear();
}

//----------------------------------------
//-------------- TOWER BASE --------------
//----------------------------------------

//Where the ball-bearings will sit
module raceway()
{
    //There are raceways on the top and bottom so it can operate on an incline or even upside down.
            //Bottom raceway
            translate([0,0,towerBaseGearZ/2.0+racewayReducedDepth])
            rotate_extrude(convexity = 10)
            translate([racewayR, 0, 0])
            circle(r = ballBearingR);
            //Top raceway
            translate([0,0,-towerBaseGearZ/2.0-racewayReducedDepth])
            rotate_extrude(convexity = 10)
            translate([racewayR, 0, 0])
            circle(r = ballBearingR);
}
//The holes that attach the tower base to the tower top (not the base pieces to eachother)
module towerBaseAttachmentHoles()
{
    translate([0,0,towerBaseAttachmentHoleZStart])
    rotate([90,0,0])
    cylinder(r=towerBaseAttachmentHoleR,h=100,center=true);
    translate([0,0,towerBaseAttachmentHoleZStart+towerBaseAttachmentHoleZOffsets])
    rotate([0,90,0])
    cylinder(r=towerBaseAttachmentHoleR,h=100,center=true);
}
module towerBaseAttachment()
{
    difference()
    {
        translate([0,0,towerBaseAttachmentCylinderZ/2.0])
        cylinder(r=towerBaseAttachmentCylinderOuterR,h=towerBaseAttachmentCylinderZ,center=true);
        union()
        {
            cylinder(r=towerBaseAttachmentCylinderInnerR,h=100,center=true);
            towerBaseAttachmentHoles();
        }
    }
 }

module towerBase()
{
    difference()
    {
        union()
        {
            //The big gear on the bottom
            translate([0,0,towerBaseGearZ/2.0])
            gear(towerGearTeeth,panToothWidth,panToothHeight,towerBaseGearZ,0,4);
            //Attachment system
            translate([0,0,(towerBaseGearZ)/2.0-0.1])
            towerBaseAttachment();    
        }
        union()
        {
            raceway();
        }
    }
}

//The tabs that attach the base sections to eachother
module baseTabs()
{
    width = baseTabHoleR*2.0+baseTabWallExtra*2.0;
    thickness = baseTabThickness;
    //baseTabTopR = baseR-baseTabHoleR-baseTabWallExtra-2;
    baseTabTopR = baseInnerAttachmentHoleR+baseTabHoleR+baseTabWallExtra;
    baseTabTopZ = baseZ/2.0 + width/2.0 - 0.1;
    baseTabSideR = baseR+baseTabHoleR+baseTabWallExtra;
    baseTabSideZ = 0;
    for(i=[0:3])
    {
        rotate([0,0,i*90])
        {
            //Top
            translate([0,baseTabTopR,baseTabTopZ])
            {
                difference()
                {
                    cube([thickness,width,width],center=true);
                    rotate([0,90,0])
                    cylinder(r=baseTabHoleR,h=100,center=true);
                }
            }
            //Side
            translate([0,baseTabSideR-3,baseTabSideZ])
            {
                difference()
                {
                    cube([thickness,width,baseZ],center=true);
                    rotate([0,90,0])
                    cylinder(r=baseTabHoleR,h=100,center=true);
                }
            }
        }
    }
}

module base(sliceNumber)
{
    if( sliceNumber == 2)
    {
        translate([baseMotorXLocation,baseMotorYLocation,baseMotorZLocation]) //59, 17
        rotate([180,0,-135])
        {
            enginePanGear();
            difference()
            {
                enginePanPlate();
                engineHoles();
            }
        }
    }
    difference()
    {
        union()
        {
            translate([0,0,0])
            cylinder(r=baseR,h=baseZ,center=true);
            baseTabs();
        }
        union()
        {
            //Cutting out the main gear area
            cylinder(r=baseInnerGearR,h=baseInnerGearZ,center=true);
            raceway();
            translate([0,0,50])
            cylinder(r=baseInnerAttachmentHoleR,h=100,center=true);
            
            //Slice
            rotate([0,0,sliceNumber*90])
            //{
                union()
                {
                translate([100-baseSliceGap,0,0])
                cube([200,200,200],center=true);
                translate([0,100-baseSliceGap,0])
                cube([200,200,200],center=true);
                }
            //}
            
            if( sliceNumber == 2)
            {
                translate([baseMotorXLocation,baseMotorYLocation,baseMotorZLocation]) //59, 17
                rotate([180,0,-135])
                engineHoles();
            }
        }
    }
}

//----------------------------
//------- TOP SECTION --------
//----------------------------
module towerMainPivotHole()
{
    rotate([0,90,0])
            cylinder(r=towerMainPivotHoleR,h=100,center=true);
}
module towerTop()
{
    //EnginePlate
    translate([8,-60,-26])
    rotate([0,90,0])
    enginePlate();
    difference()
    {
        union()
        {
            //Inner cylinder
            translate([0,0,-towerZ/2.0])
            cylinder(r=towerBaseAttachmentCylinderInnerR-towerTopToBaseRGap,h=towerZ,center=true);
            //Outer Cylinder
            outerZ = towerZ-towerBaseAttachmentCylinderZ+towerTopToBaseZGap;
            translate([0,0,-outerZ/2.0])
            cylinder(r=towerTopR,h=outerZ,center=true);
            //Top
            rotate([0,90,0])
            cylinder(r=towerTopR,h=towerTopR*2.0+1,center=true);
        }
        union()
        {
            towerMainPivotHole();
            //Cutting cylinder
            translate([0,0,100-towerTopR])
            difference()
            {
                cylinder(r=50,h=200,center=true);
                cylinder(r=towerTopR, h=210,center=true);
            }
            //The attachment holes
            translate([0,0,-towerZ+towerTopToBaseZGap])
            towerBaseAttachmentHoles();
        }
    }
}

module cameraCutout()
{
    union()
    {
    //Holes
    translate([cameraHolesX/2.0,0,cameraHolesZ/2.0])
     rotate([90,0,0])
      cylinder(r=cameraHoleR,h=100,center=true);
    translate([cameraHolesX/2.0,0,-cameraHolesZ/2.0])
     rotate([90,0,0])
      cylinder(r=cameraHoleR,h=100,center=true);
    translate([-cameraHolesX/2.0,0,cameraHolesZ/2.0])
     rotate([90,0,0])
      cylinder(r=cameraHoleR,h=100,center=true);
    translate([-cameraHolesX/2.0,0,-cameraHolesZ/2.0])
     rotate([90,0,0])
      cylinder(r=cameraHoleR,h=100,center=true);
    //TODO: For now, we just make the platform thin and figure it out
    //later we'll make it long, add a support
    }
}

module cameraAndLaserPlatform()
{
    difference()
    {
        //The platform
        translate([tiltPlatformX/2.0-tiltPlatformXMin,-tiltPlatformY/2.0+tiltPlatformYMax,-tiltPlatformZ/2.0+tiltPlatformZMax])
        cube([tiltPlatformX,tiltPlatformY,tiltPlatformZ],center=true);
        //The camera
        translate([-tiltPlatformXMin+cameraX/2.0,tiltPlatformYMax-cameraY/2.0,tiltPlatformZMax-cameraZ/2.0])
        cameraCutout();
    }    
}


//Tilt platform itself
module tiltUnit()
{
    difference()
    {
        union()
        {
            //The gear
            translate([tiltGearWidth+towerMainPivotGap+towerTopR,0,0])
            rotate([0,90,0])
            gear(tiltGearTeeth,tiltGearToothWidth,tiltGearToothHeight,tiltGearWidth,0,4);
            //The platform
            //translate([-tiltPlatformX/2.0+towerTopR+towerMainPivotGap+.1,0,towerTopR+tiltPlatformZGap+tiltPlatformZ/2.0])
            //cube([tiltPlatformX,tiltPlatformY,tiltPlatformZ],center=true);
            //Things on the platform
            cameraAndLaserPlatform();
        }
        union()
        {
            towerMainPivotHole();
        }
    }
}

//------------------------------------
//-------- MODULES TO PRINT ----------
//------------------------------------
towerTop();
tiltUnit();

//enginePanGear();
//difference()
{
  //  enginePanPlate();
//    engineHoles();
}
translate([0,0,-120])
{
 //base(0);
 //base(1);
 base(2);
 //base(3);
 towerBase();
}
