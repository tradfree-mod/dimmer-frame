include <../config.scad>
include <../include/modules.scad>
include <../include/sizes.scad>
include <main_body_supports.scad>


module mainBody() {
	union() {
		color("white")
		difference() {
			union() {
				difference() {
					// Main body shape
					roundedCube(main_body_dimens, main_body_corner_rad, $fn=fn);

					// Carve out membrane inset
					translate(membrane_inset_pos)
					roundedCube(membrane_inset_dimens + [0, 0, 1], membrane_inset_corner_rad, $fn=fn);

					// Carve out PCB housing
					translate(pcb_housing_pos)
					roundedCube(pcb_housing_dimens + [0, 0, 1], pcb_housing_corner_rad, $fn=fn);

					// Carve out PCB housing floor from the bottom to reduce mass
					translate(-[0, 0, 1])
					translate(bottom_cavity_pos)
					roundedCube(bottom_cavity_dimens + [0, 0, 1], bottom_cavity_corner_rad, $fn=fn);


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

					// Lid clip slots
					translate([
						wall_thickn-lid_clips_slot_dimens.x,
						main_body_dimens.x/2+membr_spacial_offset_center,
						lid_clips_slot_z
					])
					cube(lid_clips_slot_dimens + [.2, 0, 1]);

					translate([
						wall_thickn-lid_clips_slot_dimens.x,
						main_body_dimens.x/2-membr_spacial_offset_center-lid_clips_slot_dimens.y,
						lid_clips_slot_z
					])
					cube(lid_clips_slot_dimens + [.2, 0, 1]);

					// Carve out the PCB holder hole
					translate(pcb_holder_hole_pos - [.5, 0, 0])
					cube(pcb_holder_hole_dimens + [1, 0, 0]);

					// Carve some space for the bottom lid support clip
					if (custom_case_clip) {
						intersection() {
							translate(custom_case_clip_sphere_pos)
							sphere(d=custom_case_clip_sphere_d, $fn=fn);

							translate([
								(main_body_dimens.x-4*wall_thickn-pcb_housing_dimens.x)/2+1,
								(main_body_dimens.y-4*wall_thickn-pcb_housing_dimens.y)/2,
								-1
							])
							roundedCube(pcb_housing_dimens+[2, 2, 10]*wall_thickn, pcb_housing_corner_rad+wall_thickn, $fn=fn);
						}
					}

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
			if (carve_swd_hole) {
				translate(swd_hole_pos)
				cube(concat(swd_hole_dimens, [30]));
			}

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

			// Screw hole
			translate(-[0, 0, 1])
			translate(screw_pos)
			cylinder(h=screw_rod_h-wall_thickn+1, r=screw_hole_rad, $fn=screw_hole_fn);

			// Battery removal screwdriver dent
			translate([0, 0, battery_housing_pos.z - 0.01])
			translate(battery_hole_pos)
			translate([1, 1]*battery_hole_rad)
			rotate(battery_removal_dent_rot)
			translate(battery_removal_dent_pos1)
			clipDent(battery_removal_dent_size);


			// Hinges holes
			translate([
				main_body_dimens.x/2,
				main_body_dimens.y-wall_thickn/2,
				hinges_hole_z+hinges_hole_rad
			])
			rotate([0, 90, 90])
			cylinder(h=wall_thickn+1, r=hinges_hole_rad, center=true, $fn=fn);

			translate([
				main_body_dimens.x/2,
				wall_thickn/2,
				hinges_hole_z+hinges_hole_rad
			])
			rotate([0, 90, 90])
			cylinder(h=wall_thickn+1, r=hinges_hole_rad, center=true, $fn=fn);

			// Hinges holes guides
			translate([
				main_body_dimens.x/2,
				main_body_dimens.y-hinges_hole_guide_thickn/2 + .5,
				hinges_hole_z+hinges_hole_rad
			])
			rotate([0, 90, 90])
			hingeGuide(
			    hinges_hole_rad,
			    hinges_hole_guide_rad_top,
			    hinges_hole_guide_thickn + 1,
			    4,
			    center=true,
			    $fn=fn
			);

			translate([
				main_body_dimens.x/2,
				hinges_hole_guide_thickn/2 - .5,
				hinges_hole_z+hinges_hole_rad
			])
			rotate([0, 90, 90])
			hingeGuide(
			    hinges_hole_rad,
			    hinges_hole_guide_rad_top,
			    hinges_hole_guide_thickn + 1,
			    4,
			    center=true,
			    $fn=fn
			);

			// Alignment notches
			translate(alignment_notch_pos - [0, 1, 0])
			cube(alignment_notch_dimens + [0, 1, 1]);

			translate([0,  main_body_dimens.y - alignment_notch_dimens.y])
			translate(alignment_notch_pos)
			cube(alignment_notch_dimens + [0, 1, 1]);

		} // difference
	
		color("white") {
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

						translate(-[0, .5, .5])
						translate([(battery_small_clip_dimens.x-battery_small_clip_cutout_dimens.x)/2, 0])
						cube(battery_small_clip_cutout_dimens + [0, 1, 1]);
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

			// PCB holder stopper
			translate(pcb_holder_stopper_pos)
			cube(pcb_holder_stopper_dimens);

			// Small PCB clips
			for(pos = pcb_small_clip_positions) {
				translate([0, 0, pcb_small_clip_pos_z])
				translate(pos)
				cube(pcb_small_clip_dimens);
			}

			// Custom case clip
			if (custom_case_clip) {
				translate([
					main_body_dimens.x - 3,
					3
				])
				rotate([0, 0, 45])
				translate([-custom_case_clip_dimens.x/2, 0])
				cube(custom_case_clip_dimens);
			}

		}

		if (build_supports == "hardcore") {
			mainBodySupportsHardcore();
		} else if (build_supports == "easy") {
			mainBodySupportsEasy();
		}




	} // union
} // module







