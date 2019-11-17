/* [PLATFORM] */
PLATFORM_WIDTH = 124;
PLATFORM_HEIGHT= 8;
PLATFORM_THICKNESS = 1;

/* [SMA] */
SMA_ANGLE = 30;
SMA_MOUNT_HEIGHT = 9;
SMA_SCREW_Z_OFFSET = 9;
SMA_DIAMETER = 6.3;

SMA_VERTICAL_HOLDER_THICKNESS = 1;
SMA_TOP_HOLDER_WIDTH = 10;
SMA_TOP_HOLDER_HEIGHT = 15;

SMA_MOUNT_DISTANCE = 114;

/* [PHOTO SCREW PORT] */
NUT_INSIDE_DIAMETER = 6.350;
NUT_X_OFFSET = -20;

/* [MISC] */
DEBUG = false;
DEBUG_WIDTH = 130;

/* [HIDDEN] */
$fn = 128;
fudge = 0.1;


dock_holder();

module dock_holder(){
    
//    translate([0,0, -PLATFORM_THICKNESS/2])
    union(){
        x_offset = SMA_MOUNT_DISTANCE/2;            
        
        translate([-x_offset, 0, 0])
        rotate([0,0,SMA_ANGLE])        
        sma_mount();
        
        translate([x_offset, 0, 0])
        rotate([0,0,-SMA_ANGLE])
        sma_mount();

        top_platform();
        
        if(DEBUG){
            color("grey")
            translate([0, 0, -SMA_MOUNT_HEIGHT/2])
            translate([0,SMA_TOP_HOLDER_WIDTH*1.5,0])
            cube([DEBUG_WIDTH, 2, PLATFORM_THICKNESS], true);        
        }        
    }
}

module sma_mount(){
    translate([0, SMA_TOP_HOLDER_HEIGHT/2, 0])                    
    cube([SMA_TOP_HOLDER_WIDTH, SMA_TOP_HOLDER_HEIGHT, PLATFORM_THICKNESS], true); 
    
    difference(){
        translate([0, SMA_TOP_HOLDER_HEIGHT, -(SMA_MOUNT_HEIGHT-PLATFORM_THICKNESS)/2 ])                
        cube([SMA_TOP_HOLDER_WIDTH, SMA_VERTICAL_HOLDER_THICKNESS, SMA_MOUNT_HEIGHT], true); 
        
        translate([0, 0, -SMA_SCREW_Z_OFFSET])             
        sma_screw();
    }
}

module top_platform(){
    difference(){
        cube([PLATFORM_WIDTH, PLATFORM_HEIGHT, PLATFORM_THICKNESS], true);
        translate([NUT_X_OFFSET, 0, 0])
        photo_screw();
    }
}

module sma_screw(){
    radius = SMA_DIAMETER/2;
    tube_length = 100;
    
    translate([0, tube_length, 0])    
    rotate([90,0,0])
    cylinder(tube_length, radius, radius);
}

module photo_screw(){
    radius = NUT_INSIDE_DIAMETER/2;
    tube_length = 20;    
    translate([0,0,-tube_length/2])
    cylinder(tube_length, radius, radius);    
}

// To be a library
module rounded_corners(width, height, depth, corner_curve){
    x_translate = width-corner_curve;
    y_translate = height-corner_curve;     
    
    hull(){
            translate([-x_translate/2, -y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);    
            
            translate([-x_translate/2, y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);

            translate([x_translate/2, y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);        
            
            translate([x_translate/2, -y_translate/2, 0])
            cylinder(depth,corner_curve/2, corner_curve/2, true);        
    }        
}
