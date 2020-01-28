include <../config.scad>
include <../include/modules.scad>
include <../include/sizes.scad>

module mainBody() {
	difference() {
		union() {
			difference() {
				// Main body shape
				roundedCube(main_body_dimens, main_body_corner_rad);

				// Carve out membrane inset
				translate(membrane_inset_pos)
				roundedCube(membrane_inset_dimens, membrane_inset_corner_rad);

				// Carve out PCB housing
				translate(pcb_housing_pos)
				roundedCube(pcb_housing_dimens, pcb_housing_corner_rad);

				// Carve out PCB housing floor from the bottom to reduce mass
				translate(bottom_cavity_pos)
				roundedCube(bottom_cavity_dimens, bottom_cavity_corner_rad);


				// Carve out space between outer walls and PCB housing
				translate([0, 0, -main_body_dimens.z+membrane_inset_pos.z])
				translate([1, 1, -1]*wall_thickn)
				difference() {
					roundedCube(main_body_dimens-[2, 2, 1]*wall_thickn, main_body_corner_rad-wall_thickn);

					translate([
						(main_body_dimens.x-4*wall_thickn-pcb_housing_dimens.x)/2,
						(main_body_dimens.y-4*wall_thickn-pcb_housing_dimens.y)/2,
						-1
					])
					roundedCube(pcb_housing_dimens+[2, 2, 10]*wall_thickn, pcb_housing_corner_rad+wall_thickn);
				}

				// UART header hole
				translate(uart_hole_pos)
				cube(concat(uart_hole_dimens, [30]));

				// Membrane slots
				translate([
					main_body_dimens.x/2-membr_slots_dimens.x/2,
					main_body_dimens.y-wall_thickn-membr_slots_dimens.y
				])
				cube(concat(membr_slots_dimens, [30]));

				translate([
					main_body_dimens.x/2-membr_slots_dimens.x/2,
					wall_thickn
				])
				cube(concat(membr_slots_dimens, [30]));

				translate([
					main_body_dimens.x-wall_thickn-membr_slots_dimens.y,
					main_body_dimens.y/2-membr_slots_dimens.x/2
				])
				cube(concat(swap(membr_slots_dimens), [30]));

				translate([
					wall_thickn,
					main_body_dimens.x/2+membr_spacial_offset_center
				])
				cube(concat(membr_spacial_slots_dimens, [30]));

				translate([
					wall_thickn,
					main_body_dimens.x/2-membr_spacial_offset_center-membr_spacial_slots_dimens.y
				])
				cube(concat(membr_spacial_slots_dimens, [30]));
			} // difference


			// Battery housing
			translate(battery_housing_pos)
			translate([1, 1]*battery_housing_rad)
			cylinder(h=battery_housing_h, r=battery_housing_rad, $fn=100);


			// PCB standoffs
			for(pos = pcb_standoffs_positions) {
				translate([0, 0, pcb_housing_pos.z])
				translate(pos)
				cube(pcb_standoffs_dimens);
			}
		} // union

		// Button hole
		translate(button_hole_pos)
		cylinder(h=30, r=button_hole_rad, $fn=30);

		// SWD header hole
		translate(swd_hole_pos)
		cube(concat(swd_hole_dimens, [30]));

		// Battery hole
		translate(battery_hole_pos)
		translate([1, 1]*battery_hole_rad)
		cylinder(h=30, r=battery_hole_rad, $fn=100, center=false);

	} // difference
} // module