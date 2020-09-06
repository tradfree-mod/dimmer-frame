include <config.scad>
include <include/sizes.scad>
include <include/modules.scad>
include <parts/custom_lid.scad>


module mock_pcb() {
	rotate([0, 0, -90])
	translate([.5, .5]*-33.500) // Center
	rotate([180])
	translate([-91, 96.5])     	// Align to origin
	import("zigbee_coordinator3.stl");
}


/*
#translate([0, 0, custom_pcb_thickn+usb_c_hole_pos.z+usb_c_hole_dimens.z])
translate([lid_dimens.x , lid_dimens.y]/2)
color("green")
union() {

	translate([0, 0, -.2])
	mock_pcb();
}

//*/

color("white")
customLid();