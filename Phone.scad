
DIRECTION_LEFT = [90,0,0];

HEIGTH = 127;
WIDTH = 67;
THICKNESS = 10;
CORNER_RADIUS = 5;

CAMERA_HEIGTH = 15;
CAMERA_WIDTH = 20;
CAMERA_THICKNESS = 10;
CAMERA_CORNER_RADIUS = 3;

module phoneBlock(){
	offset_above_line_z=[0,0,WIDTH / 2];
	laptop_position=DIRECTION_LEFT;
	
	translate(offset_above_line_z) 
		rotate(laptop_position)
			roundedBox([
				THICKNESS,
				WIDTH,
				HEIGTH], 
				CORNER_RADIUS);
}

module cameraBlock(){
	camera_offset = [-2,45,30];
	laptop_position=DIRECTION_LEFT;
	
	translate(camera_offset)
		rotate(laptop_position)
			roundedBox([
				CAMERA_THICKNESS,
				CAMERA_WIDTH,
				CAMERA_HEIGTH],
				CAMERA_CORNER_RADIUS);
}

module phone(){
	phoneBlock();
	cameraBlock();
}

module roundedBox(size, radius, sidesonly)
{
	rot = [ [0,0,0], [90,0,90], [90,90,0] ];
	if (sidesonly) {
		cube(size - [2*radius,0,0], true);
		cube(size - [0,2*radius,0], true);
		for (x = [radius-size[0]/2, -radius+size[0]/2],
				 y = [radius-size[1]/2, -radius+size[1]/2]) {
			translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
		}
	}
	else {
		cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

		for (axis = [0:2]) {
			for (x = [radius-size[axis]/2, -radius+size[axis]/2],
					y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
				rotate(rot[axis]) 
					translate([x,y,0]) 
					cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
			}
		}
		for (x = [radius-size[0]/2, -radius+size[0]/2],
				y = [radius-size[1]/2, -radius+size[1]/2],
				z = [radius-size[2]/2, -radius+size[2]/2]) {
			translate([x,y,z]) sphere(radius);
		}
	}
}
phone();
