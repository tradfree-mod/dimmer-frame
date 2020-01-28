include <../config.scad>
include <../include/modules.scad>
include <../include/sizes.scad>

module mainBody() {
	union() {
		difference() {
			union() {
				difference() {
					// Main body shape
					roundedCube(main_body_dimens, main_body_corner_rad, $fn=fn);

					// Carve out membrane inset
					translate(membrane_inset_pos)
					roundedCube(membrane_inset_dimens, membrane_inset_corner_rad, $fn=fn);

					// Carve out PCB housing
					translate(pcb_housing_pos)
					roundedCube(pcb_housing_dimens, pcb_housing_corner_rad, $fn=fn);

					// Carve out PCB housing floor from the bottom to reduce mass
					translate(bottom_cavity_pos)
					roundedCube(bottom_cavity_dimens, bottom_cavity_corner_rad, $fn=fn);


					// Carve out space between outer walls and PCB housing
					translate([0, 0, -main_body_dimens.z+membrane_inset_pos.z])
					translate([1, 1, -1]*wall_thickn)
					difference() {
						roundedCube(main_body_dimens-[2, 2, 1]*wall_thickn, main_body_corner_rad-wall_thickn, $fn=fn);

						translate([
							(main_body_dimens.x-4*wall_thickn-pcb_housing_dimens.x)/2,
							(main_body_dimens.y-4*wall_thickn-pcb_housing_dimens.y)/2,
							-1
						])
						roundedCube(pcb_housing_dimens+[2, 2, 10]*wall_thickn, pcb_housing_corner_rad+wall_thickn, $fn=fn);
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


					// Carve out a slot for the PCB big clip
					translate(pcb_clip_cutoff_pos)
					cube(pcb_clip_cutoff_dimens);

				} // difference


				// Battery housing
				translate(battery_housing_pos)
				translate([1, 1]*battery_housing_rad)
				cylinder(h=battery_housing_h, r=battery_housing_rad, $fn=fn);


				// PCB standoffs
				for(pos = pcb_standoffs_positions) {
					translate([0, 0, pcb_housing_pos.z])
					translate(pos)
					cube(pcb_standoffs_dimens);
				}


				// Screw rod
				translate(screw_pos)
				cylinder(h=screw_rod_h, r=screw_rod_rad, $fn=fn);

			} // union

			// Button hole
			translate(button_hole_pos)
			cylinder(h=30, r=button_hole_rad, $fn=fn);

			// SWD header hole
			translate(swd_hole_pos)
			cube(concat(swd_hole_dimens, [30]));

			// Battery hole
			translate(battery_hole_pos)
			translate([1, 1]*battery_hole_rad)
			cylinder(h=30, r=battery_hole_rad, $fn=fn, center=false);

			// Battery connector gap
			translate([
				battery_hole_pos.x+battery_hole_rad+1,
				battery_hole_pos.y-1,
				pcb_housing_pos.z
			])
			cube([battery_hole_rad, battery_hole_rad, 10]);

			// Screw rod
			translate(screw_pos)
			cylinder(h=screw_rod_h-wall_thickn, r=screw_hole_rad, $fn=screw_hole_fn);

		} // difference
	
		// Battery clips
		difference() {
			union() {
				// Big clip
				translate(battery_hole_pos)
				translate([1, 1]*battery_hole_rad)
				rotate(battery_clips_rot_angle)
				translate(battery_big_clip_pos1)
				cube(battery_big_clip_dimens);

				// Small clips
				translate(battery_hole_pos)
				translate([1, 1]*battery_hole_rad)
				rotate(battery_clips_rot_angle + [0, 0, 180])
				translate(battery_small_clips_pos1)
				difference() {
					cube(battery_small_clip_dimens);

					translate([(battery_small_clip_dimens.x-battery_small_clip_cutout_dimens.x)/2, 0])
					cube(battery_small_clip_cutout_dimens);
				}

			}

			// Clip them with the shape of the battery housing
			difference() {
				cube([100, 100, 100]);
			
				translate([0, 0, -2])
				translate(battery_housing_pos)
				translate([1, 1]*battery_housing_rad)
				cylinder(h=battery_housing_h, r=battery_housing_rad, $fn=fn);
			}
		}

		// Big PCB clip
		translate(pcb_clip_stick_pos)
		cube(pcb_clip_stick_dimens);

		#translate(pcb_clip_dent_pos)
		rotate(pcb_clip_dent_rot)
		clipDent(pcb_clip_dent_dimens);

		// Small PCB clips
		for(pos = pcb_small_clip_positions) {
			translate([0, 0, pcb_small_clip_pos_z])
			translate(pos)
			cube(pcb_small_clip_dimens);
		}

	} // union
} // module







