//------------------------------------
//--------- Generic ------------------
//------------------------------------
//This is just a common bolt size; it's not precise but rather based on slight over-print from my machine
quarterInch = 3.4*2.0;//7.1; //quarterInch/2.0;25/4;
quarterInchR = quarterInch / 2.0;
module quarterInchHexHead(z)
{
    width = 4;
    length = 8;
    cube([length,width,z],center=true);
    rotate([0,0,120])
        cube([length,width,z],center=true);
    rotate([0,0,-120])
        cube([length,width,z],center=true);
}

//------------------------------------
//--------- PAN TILT INFO ------------
//------------------------------------

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
//quarterInchR = 3.4;

//-----------------------------------
// --------- Parameters -------------
//-----------------------------------
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
engineTiltPlateExtraY = 15; //Added to the side of the engine mount to make sure it attaches
engineTiltPlateThermalDroopY = 1; //The vertical printing of the tiltTower causes this edge of the motor plate to peel up; so we move it down and out a little to make sure it ends up in the right place. 
engineTiltPlateThermalDroopX = 4;

towerBaseGearZ = 12; //How tall/thick the pan gear is
towerBaseGearR = 55; //Roughly how big around the pan gear is
motorGearR = 13; //Roughly how big the gear that fits on the motor is
motorGearZ = towerBaseGearZ; //Same thickness as the pan gear
motorGearHoleR = 4.3; //The hole cut that the motor fits into; roughly 5/16" for this one.
motorGearHoleCutR = 3.4; //The motos has a flat side, how close is the flat part to the center at it's closest
motorGearBaseHoleR = motorGearR+8; //The hole cut in the base to make room for the motor's gear.
motorGearLocationZ = 25-enginePlateZ;
motorGearBaseHoleExtraZ = 3;
//WARNING: Motor location is tuned by hand, because the math of where it should be is hard (gear interactions and the triangles of it's location).
baseMotorXLocation = 59;
baseMotorYLocation = 59;
baseMotorZLocation = 13;
towerMotorXLocation = 14;
towerMotorYLocation = -60;
towerMotorZLocation = -26;
//END TODO
baseMotorExtraZ = 5;
panToothWidth = 4;
ballBearingR = quarterInchR+0.3;
racewayReducedDepth = 1;
racewayR = towerBaseGearR - 15;//20;
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
baseSliceGap = 0.6; //0.3; //Twice this is the gap between the four base pieces.

towerBaseAttachmentHoleR = quarterInchR;
towerBaseAttachmentHoleZStart = 18; //Where the holes begin, as measured from above the gear top
towerBaseAttachmentHoleZOffsets = 8; //Distance between holes
towerBaseAttachmentCylinderZ = 35; // Height of the tower
//towerBaseAttachmentCylinderOuterR = baseInnerAttachmentHoleR-2;
towerBaseAttachmentCylinderOuterR = 22;
towerBaseAttachmentCylinderInnerR = towerBaseAttachmentCylinderOuterR - 8;
towerBaseExtraZ = 40;
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

//Attachments
attachmentXMin = towerTopR+towerMainPivotGap+tiltGearWidth;
attachmentXOuterMin = towerTopR+towerMainPivotGap;

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

//Laser 
laserSmallR = 30.5/2.0;
laserLargeR = 35.0/2.0;
laserSmallToLargeY = 50; //Distance center of front to center of back holder
laserBoltR = quarterInchR;
laserBoltWall = 5;
laserHolderY = 30;
laserHolderX = laserLargeR*2 + laserBoltR*4 + laserBoltWall*4;  
laserHolderZ = laserLargeR*2 + 5*2; 
laserHolderXGap = 1.5; //distance to gear
laserHolderZGap = 1; //Distance to bottom holder

//OLD LASER ACTUATOR
laserActuatorX = 15;
laserActuatorHoleR = 3;
laserActuatorHoleDist = 15;
laserActuatorHoleToSwitchStroke = 20;
laserActuatorExtraZ = 6;
laserActuatorY = laserHolderY;
laserActuatorYCut = 10;

//Stronger actuator
laserActuator2HoleR = 3;
laserActuator2HoleXOffsets = 7; //on either side of the center
laserActuator2HoleLowerZ = 26; //distance to swtich
laserActuator2HoleUpperZ = laserActuator2HoleLowerZ + 21; //distance from this hole to the lower one
laserActuator2YCut = 10;
laserActuator2XCut = 10;
laserActuator2X = laserActuator2HoleXOffsets*2.0 + laserActuator2HoleR*2.0 + 6;
laserActuator2Y = laserHolderY - laserActuator2YCut;
laserActuator2Z = laserActuator2HoleUpperZ + 6;

//----------------------------------------
//------------ Motor Mounts---------------
//----------------------------------------
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
module engineHoles(thermalDroop=0)
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
            translate([enginePlateBoltX/2.0+thermalDroop,-enginePlateBoltY/2.0,0])
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
//engineTiltPlateThermalDroopY -- The vertical printing of the tiltTower causes this edge of the motor plate to peel up; so we move it down and out a little to make sure it ends up in the right place. 
//engineTiltPlateThermalDroopX
module engineTiltPlate(showGear)
{
    //Show the gear
    if(showGear == 1)
    {
        translate([engineOutX,engineOutY,motorGearLocationZ])
        motorGear();
    }
    difference()
    {
        union()
        {
            //Plate mounting to engine
            translate([engineTiltPlateThermalDroopX/2.0,engineTiltPlateExtraY/2,-enginePlateZ/2.0])
            cube([enginePlateX+engineTiltPlateThermalDroopX,enginePlateY+engineTiltPlateExtraY,enginePlateZ],center=true);
            //Extra plate to mount to the 
        }
        union()
        {
            engineHoles(thermalDroop=engineTiltPlateThermalDroopX);
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
    translate([0,0,towerBaseAttachmentHoleZStart ])
    rotate([90,0,0])
    cylinder(r=towerBaseAttachmentHoleR,h=100,center=true);
    translate([0,0,towerBaseAttachmentHoleZStart+towerBaseAttachmentHoleZOffsets ])
    rotate([0,90,0])
    cylinder(r=towerBaseAttachmentHoleR,h=100,center=true);
}
module towerBaseAttachment()
{
    difference()
    {
        translate([0,0,towerBaseAttachmentCylinderZ/2.0+towerBaseExtraZ/2.0])
        cylinder(r=towerBaseAttachmentCylinderOuterR,h=towerBaseAttachmentCylinderZ+towerBaseExtraZ,center=true);
        union()
        {
            translate([0,0,50+towerBaseExtraZ])
            cylinder(r=towerBaseAttachmentCylinderInnerR,h=100,center=true);
            translate([0,0,towerBaseExtraZ])
            towerBaseAttachmentHoles();
        }
    }
 }

//The main gear and attachment piece on the bottom
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

module base(sliceNumber,showGear)
{
    //Base #2 is where the motor mounts, so a bunch of special stuff there
    if( sliceNumber == 2)
    {
        translate([baseMotorXLocation,baseMotorYLocation,baseMotorZLocation]) //59, 17
        rotate([180,0,-135])
        {
            if( showGear == 1)
            {
                enginePanGear();
            }
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
            //Most of it is just a big block
            translate([0,0,0])
            cylinder(r=baseR,h=baseZ,center=true);
            //Tabs to attach each of the 4 pieces of the base to the next
            baseTabs();
        }
        union()
        {
            //Cutting out the main gear area
            cylinder(r=baseInnerGearR,h=baseInnerGearZ,center=true);
            raceway();
            translate([0,0,50])
            cylinder(r=baseInnerAttachmentHoleR,h=100,center=true);
            
            //Slice the 4 sections away from eachother
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
            //Again, #2 is the motor mount piece so it needs to have engine holes cut even into the main block (including the hole in which the engine gear sits
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
module towerTop(showGear)
{
    outerZ = towerZ-towerBaseAttachmentCylinderZ+towerTopToBaseZGap;
    //EnginePlate
    translate([towerMotorXLocation,towerMotorYLocation,towerMotorZLocation])
    rotate([0,90,0])
    engineTiltPlate(showGear);
    difference()
    {
        union()
        {
            //Inner cylinder
            translate([0,0,-towerZ/2.0])
            cylinder(r=towerBaseAttachmentCylinderInnerR-towerTopToBaseRGap,h=towerZ,center=true);
            //Outer Cylinder
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


laserXCenter = attachmentXMin+laserHolderX/2.0-0.1;
module laserAttachmentHoles()
{
    //Near-gear hole
    translate([attachmentXMin+laserBoltR+laserBoltWall,0,0])
    union()
    {
        translate([0,laserSmallToLargeY/2.0,0])
        cylinder(r=laserBoltR,h=50,center=true);
        translate([0,-laserSmallToLargeY/2.0,0])
        cylinder(r=laserBoltR,h=50,center=true);
    }
    //Far-gear hole
    translate([attachmentXMin+laserHolderX-laserBoltR-laserBoltWall,0,0])
    union()
    {
        translate([0,laserSmallToLargeY/2.0,0])
        cylinder(r=laserBoltR,h=50,center=true);
        translate([0,-laserSmallToLargeY/2.0,0])
        cylinder(r=laserBoltR,h=50,center=true);
    }
}
module laserHoles()
{
    //Front holder
    translate([laserXCenter,laserSmallToLargeY/2.0])
    rotate([90,0,0])
    cylinder(r=laserLargeR,h=laserHolderY+1,center=true);
    //Back holder
    translate([laserXCenter,-laserSmallToLargeY/2.0])
    rotate([90,0,0])
    cylinder(r=laserSmallR,h=laserHolderY+1,center=true);
}
module laserAttachmentTopBack()
{
    difference()
    {
        translate([laserXCenter+laserHolderXGap/2.0,-laserSmallToLargeY/2.0, laserHolderZ/4.0+laserHolderZGap/2.0])
        cube([laserHolderX-laserHolderXGap,laserHolderY,laserHolderZ/2.0-laserHolderZGap],center=true);
        union()
        {
            laserHoles();
            laserAttachmentHoles();
        }
    }
}

//laserActuator2HoleR = 3;
//laserActuator2HoleXOffsets = 7; //on either side of the center
//laserActuator2HoleLowerZ = 26; //distance to swtich
//laserActuator2HoleUpperZ = laserActuator2HoleLowerZ + 21; //distance from this hole to the lower one
//laserActuator2X = laserActuator2HoleXOffsets + laserActuator2HoleR + 3;
//laserActuator2Y = laserHolderY;
//laserActuator2Z = laserActuator2HoleUpperZ + 4;
//laserActuator2YCut = 10;
module laserActuator2Holes()
{
    //bottom bolt hole
    translate([laserXCenter+laserActuator2HoleXOffsets,0,laserLargeR+laserActuator2HoleLowerZ])
    rotate([90,0,0])
    cylinder(r=laserActuator2HoleR,h=100,center=true);
    //top bolt hole
    translate([laserXCenter-laserActuator2HoleXOffsets,0,laserLargeR+laserActuator2HoleUpperZ])
    rotate([90,0,0])
    cylinder(r=laserActuator2HoleR,h=100,center=true);
}
module laserAttachment2TopFront()
{
    difference()
    {
        union()
        {
            //Main clamp
            translate([laserXCenter+laserHolderXGap/2.0,laserSmallToLargeY/2.0, laserHolderZ/4.0+laserHolderZGap/2.0])
            cube([laserHolderX-laserHolderXGap,laserHolderY,laserHolderZ/2.0-laserHolderZGap],center=true);
            //Actuator holder
            translate([laserXCenter,laserSmallToLargeY/2.0-laserActuator2YCut/2.0,laserLargeR+(laserActuator2Z)/2.0])
            cube([laserActuator2X,laserActuator2Y,laserActuator2Z],center=true);
        }
        union()
        {
            laserHoles();
            laserAttachmentHoles();
            laserActuator2Holes();
            //Hole for actuator to plunge into
            translate([laserXCenter,laserSmallToLargeY/2.0+laserHolderY/2.0-laserActuatorYCut/2.0,50])
            cube([laserActuator2XCut,laserActuator2YCut,100],center=true); 
        }
    }
}

module laserActuatorHoles()
{
    //bottom bolt hole
    translate([laserXCenter,0,laserLargeR+laserActuatorHoleToSwitchStroke])
    rotate([90,0,0])
    cylinder(r=laserActuatorHoleR,h=100,center=true);
    //top bolt hole
    translate([laserXCenter,0,laserLargeR+laserActuatorHoleToSwitchStroke+laserActuatorHoleDist])
    rotate([90,0,0])
    cylinder(r=laserActuatorHoleR,h=100,center=true);
}
module laserAttachmentTopFront()
{
    difference()
    {
        union()
        {
            //Main clamp
            translate([laserXCenter+laserHolderXGap/2.0,laserSmallToLargeY/2.0, laserHolderZ/4.0+laserHolderZGap/2.0])
            cube([laserHolderX-laserHolderXGap,laserHolderY,laserHolderZ/2.0-laserHolderZGap],center=true);
            //Actuator holder
            translate([laserXCenter,laserSmallToLargeY/2.0,(laserActuatorExtraZ+laserLargeR+laserActuatorHoleToSwitchStroke+laserActuatorHoleDist)/2.0])
            cube([laserActuatorX,laserActuatorY,laserActuatorExtraZ+laserLargeR+laserActuatorHoleToSwitchStroke+laserActuatorHoleDist],center=true);
        }
        union()
        {
            laserHoles();
            laserAttachmentHoles();
            laserActuatorHoles();
            //Hole for actuator to plunge into
            translate([laserXCenter,laserSmallToLargeY/2.0+laserHolderY/2.0-laserActuatorYCut/2.0,50])
            cube([laserActuatorX,laserActuatorYCut,100],center=true); 
        }
    }
}
module laserPlatform()
{
    difference()
    {
        union()
        {
            //Front holder
            translate([laserXCenter,laserSmallToLargeY/2.0,-laserHolderZ/4.0])
            cube([laserHolderX,laserHolderY,laserHolderZ/2.0],center=true);
            //Back holder
            translate([laserXCenter,-laserSmallToLargeY/2.0,-laserHolderZ/4.0])
            cube([laserHolderX,laserHolderY,laserHolderZ/2.0],center=true);
        }
        union()
        {
            //holes for the mody of device
            laserHoles();
            //laser holes
            laserAttachmentHoles();
            //Cut the top off and add it in a new object
            //translate([attachmentXMin+50,0,50])
            //cube([100,100,100],center=true);
        }
    }
}

module laserTestbed()
{
    laserPlatform();
    translate([-2.5+attachmentXMin,0,0])
    cube([5,laserSmallToLargeY+laserHolderY,laserHolderZ],center=true);    
}

module shortCameraPlatform()
{
    translate([attachmentXMin-tiltGearWidth+35/2,40,40])
    cube([35,5,20],center=true);
}

module cameraPlatform()
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
            //WORKS: cameraPlatform();
            shortCameraPlatform();
            //The laser
            laserPlatform();
        }
        union()
        {
            towerMainPivotHole();
        }
    }
}







//------------------------------------
//--------- One-side axle wheel ------
//------------------------------------
fiveSixteenthInch = 4.7*2.0;
wheelAttachmentPlateR = 40;
wheelAttachmentPlateZ = 8;
wheelBoltRad = quarterInch/2.0;
wheelCenterHoleR = fiveSixteenthInch/2.0;
wheelCrossBarR = quarterInch/2.0;
wheelBoltDist = 28;
wheelBoltOffset = 13;
wheelBoltHeadZ = 5;
wheelWeldR = fiveSixteenthInch/2.0+2;
wheelPadSpacingBetweenQuarters = 0.4; //This number is doubled in practice by havin it on each side
wheelOuterR = 80; //The real wheel diameter
wheelInnerR = wheelOuterR - 10;
wheelOuterZ = 40; //The width at the rim
wheelInnerZ = 10; //The width in the center, which is less to save material and weight
wheelTreadDepth = 8; //It will actually ususally be about half this. 
wheelUntreadedZ = 8; //The part of the wheel that we don't apply to treads to. This is part of making it fast on concrete but able to handle other surfaces. 
module wheelBoltHoleQuarterSet()
{
 translate([wheelBoltDist,wheelBoltOffset,0])
 {
  translate([0,0,wheelBoltHeadZ/2.0-wheelAttachmentPlateZ-0.1])
  quarterInchHexHead(wheelBoltHeadZ);
  cylinder(r=wheelBoltRad,h=40,center=true);
 }
 translate([wheelBoltDist,-wheelBoltOffset,0])
 {
  translate([0,0,wheelBoltHeadZ/2.0-wheelAttachmentPlateZ-0.1])
  quarterInchHexHead(wheelBoltHeadZ);
  cylinder(r=wheelBoltRad,h=40,center=true);
 }
}
module wheelBoltHoles()
{
 rotate([0,0,-45])
  wheelBoltHoleQuarterSet();
 rotate([0,0,90-45])
  wheelBoltHoleQuarterSet();
 rotate([0,0,180-45])
  wheelBoltHoleQuarterSet();
 rotate([0,0,270-45])
  wheelBoltHoleQuarterSet();
}
module wheelAxleHoles()
{
    //The main axle
    cylinder(r=wheelCenterHoleR,h=70,center=true);
    //The cross piece
    rotate([90,0,-45])
    cylinder(r=wheelCrossBarR,h=2*wheelAttachmentPlateR,center=true);
    //Spacing for the weld
    translate([0,0,-wheelCrossBarR])//Place it right where the weld is
    sphere(r=wheelWeldR,center=true);
}

module wheelAttachmentPlate()
{
 translate([0,0,-wheelAttachmentPlateZ/2.0])
   cylinder(r=wheelAttachmentPlateR,h=wheelAttachmentPlateZ,center=true);
}
module wheelTreading()
{
    numberOfTreads = 45;
    degreesEach = 360 / 45;
    spaceLength = 2*3.1415*wheelOuterR/45/2.0;
    for(i = [0:1:numberOfTreads])
    {
        rotate([0,0,i*degreesEach])
        translate([wheelOuterR,0,wheelUntreadedZ+50/2.0])
        cube([wheelTreadDepth,spaceLength,50],center=true);
    }
        
}
module wheelPads(padNumber)
{
    difference()
    {
        union()
        {
        translate([0,0,wheelOuterZ/2.0])
        cylinder(r=wheelOuterR,h=wheelOuterZ,center=true);
        }
        union()
        {
            //Cut out the big center area so we dont' have to print it
        translate([0,0,(wheelOuterZ-wheelInnerZ)/2.0+(wheelOuterZ-(wheelOuterZ-wheelInnerZ))+.1])
        cylinder(r=wheelInnerR,h=(wheelOuterZ-wheelInnerZ),center=true);
          //Cut out the other pads
          rotate([0,0,90*padNumber])
           {
               translate([100-wheelPadSpacingBetweenQuarters,0,0])
               cube([200,200,100],center=true);
               translate([0,100-wheelPadSpacingBetweenQuarters,0])
               cube([200,200,100],center=true);
           }
        }
    }
}

//------------------
//-- MOTOR MOUNTS --
//------------------
chassisRodR = quarterInchR;
chassisRodWeldR = quarterInchR+2.0;
motorToChassisBoltR = quarterInchR;
motorToChassisBoltWall = 3; //Added material around a bolt
motorToChassisPlateToBoltWall = 2; //Distance from edge of bolt to plate (make sure it can clear the motor)
motorToChassisBoltToChassisWall = 2; //Distance from edge of bolt to edge of chassis
motorToChassisZ = chassisRodR+4; //Needs to be at least the rod and then some


//enginePlateX = 60;
//enginePlateY = 50;
//enginePlateZ = 7;
driveCouplerR = 18; //Really 15, adding some space. The piece that connects engine to wheel. This is total distance; padding must be included in this number.
driveCouplerX = 50; //This is the total distance; padding must be included in this number. Measured from motor mount face to center of the first bearing 
driveBearingXSpacing = 30; //This is purely a decision variable. Measured as from center of one bearing to the next. 
bearingR = 11.5;
bearingX = 8;
bearingZToChassis = bearingR+chassisRodR+4.0; //Distance from bearing to the chassis above it that it attaches to
bearingBoltR = 7.1/2.0;//1/4"
bearingHoleR = 6.9/2.0+1.5; //1/4"
bearingBoltYSpacing = bearingHoleR + 3 + bearingBoltR;
bearingHolderXFromBearingToEdge = bearingX/2.0+4; //Distance from center of bearing to end of the holder
bearingHolderX = bearingHolderXFromBearingToEdge*2.0 + driveBearingXSpacing;
bearingHolderY = bearingBoltYSpacing*2.0+bearingBoltR*2.0+5*2;
bearingHolderZBottom = bearingR+4;
bearingHolderZMiddle = bearingZToChassis;
bearingHolderZTop = chassisRodR+5;
bearingHolderZ = bearingHolderZBottom + bearingHolderZMiddle + bearingHolderZTop;
bearingHolderZGaps = 0.3; //This is doubled on both sides. This is used for both the bearings and chassis clamps

module driveChassisCutout()
{
    //The verical one next to the motor
    translate([0,0,50+bearingZToChassis])
    cylinder(r=chassisRodR,h=100,center=true);
    translate([0,0,bearingZToChassis])
    sphere(r=chassisRodWeldR,center=true);
    //The one next to the motor
    translate([0,0,bearingZToChassis])
    rotate([90,0,0])
    cylinder(r=chassisRodR,h=150,center=true);
    //The one next to the middle bearing
    translate([driveCouplerX,0,bearingZToChassis])
    rotate([90,0,0])
    cylinder(r=chassisRodR,h=100,center=true);
    //The one next to the outer bearing
    translate([driveCouplerX+driveBearingXSpacing,0,bearingZToChassis])
    rotate([90,0,0])
    cylinder(r=chassisRodR,h=100,center=true);
}
module engineWheelPlate(extraZ=0,showMotor=0)
{
    //Centered on the output
    translate([-engineOutX,-engineOutY,0])
    difference()
    {
        union()
        {
            translate([0,0,-(enginePlateZ+extraZ)/2.0])
            //Main plate
                cube([enginePlateX,enginePlateY,enginePlateZ+extraZ],center=true);
            //Extra main plate
            translate([engineOutX,engineOutY,-enginePlateZ-extraZ])
                motorChassisPlate(z=enginePlateZ+extraZ,removeChassis=0);
            //Motor to chassis plate
            //cube([enginePlate
            if(showMotor==1)
            {
                translate([0,0,-75/2.0-enginePlateZ-extraZ])
                cube([20,20,75],center=true);
            }
            
        }
        union()
        {
            translate([0,0,-extraZ])
            engineHoles(thermalDroop=0);
            translate([engineOutX,engineOutY,0])
            rotate([0,-90,0])
            driveChassisCutout();
            translate([engineOutX,engineOutY,0])
            motorChassisBoltHoles();
        }
    }
}
//module motorEnginePlate()
//{
//    extZ = 2;
 //   rotate([0,-90,0])
 //   difference()
 //   {
 //       rotate([0,90,0])
 //       {
 //           engineWheelPlate(extraZ=extZ);//chassisRodR)
 //           translate([0,0,-enginePlateZ-extZ])
 //           motorChassisPlate(z=enginePlateZ+extZ,removeChassis=0);
        //}
        //driveChassisCutout();
    //}
//}
module motorChassisBoltHoles()
{ 
    //-Y bolts
    negYLocation = -enginePlateY/2.0-engineOutY-motorToChassisBoltR-motorToChassisPlateToBoltWall;
    //  -x side
    translate([-bearingZToChassis-motorToChassisBoltToChassisWall-chassisRodR-motorToChassisBoltR,negYLocation,0])
    cylinder(r=motorToChassisBoltR,h=50,center=true);
    //  +x side
    translate([-bearingZToChassis+motorToChassisBoltToChassisWall+chassisRodR+motorToChassisBoltR,negYLocation,0])
    cylinder(r=motorToChassisBoltR,h=50,center=true);
    
    //+Y bolts
    posYLocation = enginePlateY/2.0-engineOutY+motorToChassisBoltR+motorToChassisPlateToBoltWall;
    //  -x side
    translate([-bearingZToChassis-motorToChassisBoltToChassisWall-chassisRodR-motorToChassisBoltR,posYLocation,0])
    cylinder(r=motorToChassisBoltR,h=50,center=true);
    //  +x side
    translate([-bearingZToChassis+motorToChassisBoltToChassisWall+chassisRodR+motorToChassisBoltR,posYLocation,0])
    cylinder(r=motorToChassisBoltR,h=50,center=true);
    
    //-X bolts
    negXLocation = -enginePlateX/2.0-engineOutX - motorToChassisBoltR-motorToChassisPlateToBoltWall;
    translate([negXLocation,chassisRodR+motorToChassisBoltR+motorToChassisBoltToChassisWall,0])
    cylinder(r=motorToChassisBoltR,h=50,center=true);
    translate([negXLocation,-chassisRodR-motorToChassisBoltR-motorToChassisBoltToChassisWall,0])
    cylinder(r=motorToChassisBoltR,h=50,center=true);
}

module motorChassisPlate(z=motorToChassisZ,removeChassis=1)
{   //Need 3cm diameter and 5cm len for coupler
    //2 bolts on each side, 2mm to the chassis
    yTabX = motorToChassisBoltR*4+motorToChassisBoltWall*2+motorToChassisBoltToChassisWall*2+chassisRodR*2;
    yTabY = motorToChassisBoltR*2+motorToChassisBoltWall+motorToChassisPlateToBoltWall;
    xTabX = yTabY;
    xTabY = yTabX;
    difference()
    {
        
        union()
        {
            xLen = enginePlateX/2.0+xTabX;
            //The one top tab -bearingZToChassis
            translate([-engineOutX-xLen/2.0,0,z/2.0])
            cube([xLen,xTabY,z],center=true);
            //The long connection
            translate([-bearingZToChassis,-engineOutY,z/2.0])
            cube([yTabX,enginePlateY+yTabY*2.0,z],center=true);
        }
        //Remove the section around the coupler
        union()
        {
            if(removeChassis == 1)
            {
                cylinder(r=driveCouplerR,h=50,center=true);
                rotate([0,-90,0])
                driveChassisCutout();
            }
            motorChassisBoltHoles();
            cylinder(r=motorToChassisBoltR,h=50,center=true);
        }
    }
}
module bearingCutout()
{
    //The bearing itself
    rotate([0,90,0])
    union()
    {
        cylinder(r=bearingR,h=bearingX,center=true);
        cylinder(r=bearingHoleR,h=40,center=true);
    }
}
module bearingsBoltsCutout()
{
    translate([driveCouplerX+driveBearingXSpacing/2.0,bearingBoltYSpacing,0])
    cylinder(r=bearingBoltR,h=100,center=true);
        translate([driveCouplerX+driveBearingXSpacing/2.0,-bearingBoltYSpacing,0])
    cylinder(r=bearingBoltR,h=100,center=true);
}

//Holds both of them, this is all three pieces put together.
module bearingsHolder()
{
    difference()
    {
        union()
        {
            //The bearing holder itself
            translate([bearingHolderX/2.0+driveCouplerX-        bearingHolderXFromBearingToEdge,0,bearingHolderZ/2.0-bearingHolderZBottom])
            cube([bearingHolderX,bearingHolderY,bearingHolderZ],center=true);
        }
        union()
        {
            //Cutout where the bearings and their axles sit
            translate([driveCouplerX,0,0])
            bearingCutout();
            translate([driveCouplerX+driveBearingXSpacing,0,0])
            bearingCutout();
            //Remove the bolts
            bearingsBoltsCutout();
            //Remove where it must attach to chassis
            driveChassisCutout();
        }
    }
}
module bearingsHolderTop()
{
    difference()
    {
        bearingsHolder();
        translate([0,0,-50+bearingZToChassis+bearingHolderZGaps])
        cube([300,100,100],center=true);
    }
}
module bearingsHolderMiddle()
{
    difference()
    {
        bearingsHolder();
        union()
        {
            //Cut the top
            translate([0,0,50+bearingZToChassis-bearingHolderZGaps])
            cube([300,100,100],center=true);
            //Cut the bottom
            translate([0,0,-50+bearingHolderZGaps])
            cube([300,100,100],center=true);
        }
    }
}
module bearingsHolderBottom()
{
    difference()
    {
        bearingsHolder();
        union()
        {
            //Cut the top
            translate([0,0,50-bearingHolderZGaps])
            cube([300,100,100],center=true);
        }
    }
}

//-----------------------------------------
//-- VISUALIZATIONS OF OVERALL STRUCTURE --
//-----------------------------------------
chassisWheelSpacing = 100; //Disance from outside of one wheel to next; total
chassisMotorSpacing = wheelOuterR*2.0 + chassisWheelSpacing; 
chassisY = 25.4*18;//chassisMotorSpacing + 60*2; //This could depend on the engine mount width but I'd rather be a bit less specific with our design
chassisX = 25.4*14; //Just eyeball it since we don't have exact measures of the motors
chassisZ = 25.4*6; //Again, just an estimat
chassisOuterRodXLocation = chassisX/2.0;
chassisMiddleRodXLocation = chassisOuterRodXLocation - driveBearingXSpacing;
chassisInnerRodXLocation = chassisMiddleRodXLocation - driveCouplerX;
//The xy-plane is the bottom of the chassis rods
//The origin is the very center of the robot

module pi()
{
    cube([65,90,20],center=true);
}
module relay()
{
    cube([95,170,20],center=true);
}
module battery()
{
    rotate([90,0,0])
    cylinder(r=40,h=110,center=true);
}

module chassisBrace(lx,ly,lz,ux,uy,uz,r)
{
    //0: outlower, 1: xinnerLower, 2: yinnerLower, 3: outupper, 4: xinnerUpper, 5: yinnerUpper
    //Faces;outside1, outside2, inside, lower, upper
    polyhedron(points=[[lx,ly,lz],[lx-r,ly,lz],[lx,ly-r,lz],[ux,uy,uz],[ux-r,uy,uz],[ux,uy-r,uz]],faces=[[0,3,4,1],[3,0,2,5],[4,5,2,1],[3,5,4],[0,1,2]]);
}
module chassis()
{
    //-------- SYSTEMS -------
    translate([0,0,50])
    pi();
    translate([0,0,90])
    relay();
    translate([chassisInnerRodXLocation,0,40])
    battery();
    translate([-chassisInnerRodXLocation,0,40])
    battery();
    
    lowerCrossX = chassisX/2.0;
    lowerCrossY = chassisY/2.0;
    lowerCrossZ = 0;
    upperCrossX = chassisInnerRodXLocation;
    upperCrossY = chassisMotorSpacing/2.0;
    upperCrossZ = chassisZ;
    //-------- CROSS BRACES --
    //Not qutie right, but I don't need this to print, I need it to be shown. And this is easier...
    chassisBrace(lowerCrossX,lowerCrossY,lowerCrossZ,upperCrossX,upperCrossY,upperCrossZ,chassisRodR);
    chassisBrace(-lowerCrossX,lowerCrossY,lowerCrossZ,-upperCrossX,upperCrossY,upperCrossZ,chassisRodR);
    chassisBrace(-lowerCrossX,-lowerCrossY,lowerCrossZ,-upperCrossX,-upperCrossY,upperCrossZ,chassisRodR);
    chassisBrace(lowerCrossX,-lowerCrossY,lowerCrossZ,upperCrossX,-upperCrossY,upperCrossZ,chassisRodR);
    
    //-------- BASE ----------
    //--LEFT--
    //Outer
    translate([chassisOuterRodXLocation,0,0])
    rotate([90,0,0])
    cylinder(r=chassisRodR,h=chassisY,center=true);
    //Middle
    translate([chassisMiddleRodXLocation,0,0])
    rotate([90,0,0])
    cylinder(r=chassisRodR,h=chassisY,center=true);
    //Inner
    translate([chassisInnerRodXLocation,0,0])
    rotate([90,0,0])
    cylinder(r=chassisRodR,h=chassisY,center=true);
    //--RIGHT--
    //Outer
    translate([-chassisOuterRodXLocation,0,0])
    rotate([90,0,0])
    cylinder(r=chassisRodR,h=chassisY,center=true);
    //Middle
    translate([-chassisMiddleRodXLocation,0,0])
    rotate([90,0,0])
    cylinder(r=chassisRodR,h=chassisY,center=true);
    //Inner
    translate([-chassisInnerRodXLocation,0,0])
    rotate([90,0,0])
    cylinder(r=chassisRodR,h=chassisY,center=true);
    //-- OUTER --
    translate([0,chassisY/2.0,0])
    rotate([0,90,0])
    cylinder(r=chassisRodR,h=chassisX,center=true);
    translate([0,-chassisY/2.0,0])
    rotate([0,90,0])
    cylinder(r=chassisRodR,h=chassisX,center=true);
    //--------- VERTICLE -----------
    //-- MOTOR MOUNTS --
    //Front left
    translate([chassisInnerRodXLocation,-chassisMotorSpacing/2.0,chassisZ/2.0])
    cylinder(r=chassisRodR,h=chassisZ,center=true);
    //Front right
    translate([chassisInnerRodXLocation,chassisMotorSpacing/2.0,chassisZ/2.0])
    cylinder(r=chassisRodR,h=chassisZ,center=true);
    //Back left
    translate([-chassisInnerRodXLocation,-chassisMotorSpacing/2.0,chassisZ/2.0])
    cylinder(r=chassisRodR,h=chassisZ,center=true);
    //Back right
    translate([-chassisInnerRodXLocation,chassisMotorSpacing/2.0,chassisZ/2.0])
    cylinder(r=chassisRodR,h=chassisZ,center=true);
    //-- TOP
    //Right and left
    translate([chassisInnerRodXLocation,0,chassisZ])
    rotate([90,0,0])
    cylinder(r=chassisRodR,h=chassisMotorSpacing,center=true);
    translate([-chassisInnerRodXLocation,0,chassisZ])
    rotate([90,0,0])
    cylinder(r=chassisRodR,h=chassisMotorSpacing,center=true);
    //Front and back
    translate([0,chassisMotorSpacing/2.0,chassisZ])
    rotate([0,90,0])
    cylinder(r=chassisRodR,h=chassisInnerRodXLocation*2.0,center=true);
    translate([0,-chassisMotorSpacing/2.0,chassisZ])
    rotate([0,90,0])
    cylinder(r=chassisRodR,h=chassisInnerRodXLocation*2.0,center=true);
    
    //-- BATTERY MOUNT
    //Right and left
    translate([chassisInnerRodXLocation,0,90])
    rotate([90,0,0])
    cylinder(r=chassisRodR,h=chassisMotorSpacing,center=true);
    translate([-chassisInnerRodXLocation,0,90])
    rotate([90,0,0])
    cylinder(r=chassisRodR,h=chassisMotorSpacing,center=true);
}

//--------------------
//-- PRINT CONTROLS --
//--------------------
module motorMount()
{
            //The mounting plate
            rotate([0,90,0])
            {
             engineWheelPlate(showMotor=1);
             //The holder plate
             motorChassisPlate();
            }
            //The bearing holders
            bearingsHolderTop();
            bearingsHolderMiddle();
            bearingsHolderBottom();
}
module wheel()
{
    difference()
    {
        union()
        {
            wheelAttachmentPlate();
            wheelPads(0);
            wheelPads(1);
            wheelPads(2);
            wheelPads(3);
        }
        union()
        {
            wheelTreading();
            wheelBoltHoles();
            wheelAxleHoles();
        }
    }
}

module overallRendering(showWheels=1)
{
 chassis();
 translate([0,0,-bearingZToChassis])
 {
     //FRONT
     translate([0,-chassisMotorSpacing/2.0,0])
     {
        //LEFT
        translate([chassisInnerRodXLocation,0,0])
        motorMount();
        if(showWheels == 1)
        {
         translate([chassisOuterRodXLocation+20,0,0])
         rotate([0,90,0])
         wheel();
        }
         //RIGHT
        translate([-chassisInnerRodXLocation,0,0])
        rotate([0,0,180])
        motorMount();
        if(showWheels == 1)
        {
            translate([-chassisOuterRodXLocation-20,0,0])
            rotate([0,-90,0])
            wheel();
        }
    }
    //Back
     translate([0,chassisMotorSpacing/2.0,0])
     {
        //LEFT
        translate([chassisInnerRodXLocation,0,0])
        motorMount();
        if(showWheels == 1)
        {
            translate([chassisOuterRodXLocation+20,0,0])
            rotate([0,90,0])
            wheel();
        }
         //RIGHT
        translate([-chassisInnerRodXLocation,0,0])
        rotate([0,0,180])
        motorMount();
        if(showWheels == 1)
        {
            translate([-chassisOuterRodXLocation-20,0,0])
            rotate([0,-90,0])
            wheel();
        }
    }
 }
}

//------------------------------------
//-------- MODULES TO PRINT ----------
//------------------------------------
//laserTestbed();
//laserAttachmentTopFront();
//laserAttachment2TopFront();
//laserAttachmentTopBack();

//laserPlatform();
//towerBaseAttachment();
//enginePanGear();
//engineTiltPlate();
//difference()
//{
  //  enginePanPlate();
//    engineHoles();
//}

translate([0,0,160+chassisZ])
rotate([0,0,45])
{
    laserAttachmentTopFront();
    laserAttachmentTopBack();
    towerTop(0); //Show gear or not 
    tiltUnit();
translate([0,0,-149])
{
 base(0,1);
 base(1,1);
 base(2,0);
 base(3,1);
 towerBase();
}
}
//WHEEL RENDERINGS
//engineWheelPlate(showMotor=1);
//motorChassisPlate();
//motorMount();
overallRendering(showWheels=1);