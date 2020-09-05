include <../config.scad>
include <../include/modules.scad>
include <../include/sizes.scad>

module customLid() {
	union() {
		difference() {
			// Main body shape
			roundedCube(lid_dimens, lid_corner_rad, $fn=fn);

			// PCB housing
			translate(custom_pcb_housing_pos)
			roundedCube(custom_pcb_housing_dimens + [0, 0, 1], custom_pcb_housing_corner_rad, $fn);

			// USB-C connector hole
			translate(usb_c_hole_pos+[0, .03, 0])
			translate([0, usb_c_hole_dimens.y])
			rotate([90])
			roundedCube(usb_c_hole_dimens+[0, 0, 1], usb_c_corner_rad, $fn=fn);

			// Carve out space between outer walls and PCB housing
			translate([1, 1, -1]*wall_thickn)
			difference() {
				roundedCube(lid_dimens-[2, 2, 1]*wall_thickn, lid_corner_rad-wall_thickn, $fn=fn);

				translate([
					(lid_dimens.x-4*wall_thickn-custom_pcb_housing_dimens.x)/2,
					(lid_dimens.y-4*wall_thickn-custom_pcb_housing_dimens.y)/2,
					-1
				])
				roundedCube(custom_pcb_housing_dimens+[2, 2, 10]*wall_thickn, custom_pcb_housing_corner_rad+wall_thickn, $fn=fn);

				// Keep material around USB connector
				translate(usb_c_hole_pos+[-1.5, .03, .5])
				translate([0, usb_c_hole_dimens.y+1])
				rotate([90])
				roundedCube(usb_c_hole_dimens+[1, 1, 1], usb_c_corner_rad, $fn=fn);
			} // difference
		} // difference

		translate(antenna_notch_pos)
		cube(antenna_notch_dimens);
	} // union
}