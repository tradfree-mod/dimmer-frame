include <../config.scad>
include <../include/modules.scad>
include <../include/sizes.scad>

module customLid() {
	union() {
		difference() {
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

				} // difference

				// PCB supports
				translate(antenna_notch_pos)
				cube(antenna_notch_dimens);

				translate([.6, .7])
				translate(custom_pcb_housing_pos)
				linear_extrude(antenna_notch_dimens.z)
				import("include/pcb_supports.svg");


				translate(custom_pcb_housing_pos)
				translate([.7, .7, antenna_notch_dimens.z])
				linear_extrude(1.2)
				import("include/pcb_spacers.svg");

				// Top dent
				translate([1.1, 1.1, 0]*wall_thickn)
				translate([0, 0, lid_dimens.z])
				difference() {
					roundedCube([lid_dimens.x, lid_dimens.y, 3] - [1.1, 1.1, 0]*wall_thickn*2, lid_corner_rad - 1.1*wall_thickn, $fn=fn);

					translate([1.1, 1.1, -1]*wall_thickn/2)
					roundedCube(lid_dimens - [1.1, 1.1, 0]*wall_thickn*3, lid_corner_rad - 1.1*wall_thickn, $fn=fn);

					translate([-1, -1, 1])
					cube([lid_dimens.x - lid_corner_rad + 2, lid_dimens.y + 10, 20]);

					translate([-1, -1, 1])
					cube([lid_dimens.x + 10, lid_dimens.y - lid_corner_rad + 2, 20]);

					translate([lid_dimens.x - lid_corner_rad/2 + 1, lid_dimens.y - lid_corner_rad/2 + 1])
					rotate([0, 0, 135])
					translate([-custom_case_clip_dimens.x*1.4/2, 0])
					cube(custom_case_clip_dimens*1.4);
				}

			} // union

			// Button pusher hole
			translate([0, 0, -1])
			translate(button_pusher_pos)
			hull() {
				cylinder(d=button_pusher_d+1.5, h=10, $fn=fn);

				translate([0, button_pusher_horz_len])
				cylinder(d=button_pusher_d+1.5, h=10, $fn=fn);
			}

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

			// Carve out inset where there is the waterproof gasket in the original case
			translate([0, 0, -1])
			translate(gasket_pos)
			difference() {
				roundedCube(gasket_dimens + [0, 0, 1], custom_pcb_housing_corner_rad, $fn=fn);

				translate([gasket_thickn, gasket_thickn, -1])
				roundedCube(gasket_dimens + [-2, -2, 10]*gasket_thickn, custom_pcb_housing_corner_rad-gasket_thickn, $fn=fn);
			} // difference

			// Screw hole
			translate([0, 0, -1])
			translate([screw_pos.x, main_body_dimens.y - screw_pos.y])
			cylinder(d=screw_diam + 1, h=40, $fn=fn);

			// IKEA screw hole
			translate([0, 0, -1])
			translate(ikea_screw_pos)
			cylinder(d=ikea_screw_d, h=2.9, $fn=6);

			translate([0, 0, -1])
			translate(ikea_screw_pos)
			cylinder(d=ikea_screw_d + 4, h=1.5, $fn=fn);

			// Magnet
			translate([0, 0, -1])
			translate(magnet_pos)
			cylinder(d=magnet_d, h=magnet_h + 1, $fn=fn);

			// Text
			translate([0, 0, -1])
			translate(bottom_text_pos)
			rotate([0, 0, 90])
			mirror([1, 0, 0])
			linear_extrude(0.5 + 1)
			import("include/branding_bottom.svg", convexity=100);


			translate(top_text_pos)
			translate([0, 0, custom_pcb_standoffs_h + custom_pcb_housing_pos.z - 0.5])
			rotate([0, 0, 90])
			linear_extrude(0.5 + 1)
			import("include/branding_top.svg", convexity=100);

		} // difference

			// Button pusher rod
		translate(button_pusher_pos) {
			cylinder(d=button_pusher_d, h=button_pusher_h, $fn=fn);
			translate([-button_pusher_d/2, 0])
			cube([button_pusher_d, button_pusher_horz_len + button_pusher_d, 1]);
		}
	} // union
}