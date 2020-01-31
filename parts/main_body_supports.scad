include <../config.scad>
include <../include/sizes.scad>
include <../include/supports.scad>

// 3D printing supports
module mainBodySupportsHardcore() {
	difference() {
		color("cyan")
		union() {
			// SWD header hole
			if (carve_swd_hole) {
				translate([0, 0, pcb_housing_pos.z + supports_contanct_z_dist])
				translate([swd_hole_pos.x, swd_hole_pos.y])
				cubicSupport([
					swd_hole_dimens.x,
					swd_hole_dimens.y,
					50
				], hole=true);
			}

			//bridgeSupport(bridge_dimens, h, pillar_w=1) {
			// PCB standoffs
			for(pos = pcb_standoffs_positions) {
				angle=(pos.x < 5)
					? 0
					: (pos.x > 35)
					? 180
					: (pos.y < 10)
					? 90
					: -90;

				translate([0, 0, pcb_housing_pos.z + pcb_standoffs_dimens.z])
				translate(pos)
				translate([pcb_standoffs_dimens.x/2, pcb_standoffs_dimens.x/2, 10])
				rotate([0, 0, angle])
				translate(-[pcb_standoffs_dimens.x, pcb_standoffs_dimens.y]/2)
				mirror([0, 0, 1])
				bridgeSupport([
					pcb_standoffs_dimens.y+1,
					pcb_standoffs_dimens.x
				], 10, .5);
			}
 

			// Small PCB clips
			for(pos = pcb_small_clip_positions) {
				translate([0, 0, pcb_small_clip_pos_z + pcb_small_clip_dimens.z])
				translate(pos)
				translate([pcb_standoffs_dimens.x/2, pcb_standoffs_dimens.x/2, 10])
				rotate([0, 0, 180])
				translate(-[pcb_standoffs_dimens.x, pcb_standoffs_dimens.y]/2)
				mirror([0, 0, 1])
				bridgeSupport([
					pcb_standoffs_dimens.y+1,
					pcb_standoffs_dimens.x
				], 10, .5);
			}

			// UART header hole
			translate([0, 0, pcb_housing_pos.z + supports_contanct_z_dist])
			translate([uart_hole_pos.x, uart_hole_pos.y])
			cubicSupport([
				uart_hole_dimens.x,
				uart_hole_dimens.y,
				50
			], hole=true);

			// Button hole
			translate([0, 0, pcb_housing_pos.z + supports_contanct_z_dist])
			translate([button_hole_pos.x, button_hole_pos.y])
			circularSupport(
				r=button_hole_rad,
				h=50,
				$fn=fn,
				hole=true
			);

			// Battery housing
			translate([0, 0, battery_housing_pos.z + battery_housing_h + supports_contanct_z_dist + 10])
			translate([battery_housing_pos.x, battery_housing_pos.y])
			translate([1, 1]*battery_housing_rad)
			mirror([0, 0, 1])
			doubleCircularSupport(
				r=battery_housing_rad,
				h=10,
				thickn=battery_housing_rad-battery_hole_rad,
				$fn=fn
			);

			// Battery hole
			translate([0, 0, pcb_housing_pos.z + 0])
			translate([battery_hole_pos.x, battery_hole_pos.y])
			translate([1, 1]*battery_hole_rad)
			rotate([0, 0, -80])
			arcSupport(
				r=battery_hole_rad,
				h=50,
				angle=360,
				$fn=fn,
				hole=true
			);

			// Battery big clip
			translate([0, 0, battery_big_clip_dimens.z + supports_contanct_z_dist])
			translate(battery_hole_pos)
			translate([1, 1]*battery_hole_rad)
			rotate(battery_clips_rot_angle)
			translate(battery_big_clip_pos1 + [0, battery_big_clip_dimens.y - 1])
			translate([battery_big_clip_dimens.x, 0, 10-supports_thickn])
			rotate([0, 0, 90])
			mirror([0, 0, 1])
			bridgeSupport([3, battery_big_clip_dimens.x], 10);

			// Battery small clips
			translate([0, 0, battery_big_clip_dimens.z + supports_contanct_z_dist])
			translate(battery_hole_pos)
			translate([1, 1]*battery_hole_rad)
			rotate(battery_clips_rot_angle + [0, 0, 180])
			translate(battery_small_clips_pos1 + [0, battery_small_clip_dimens.y])
			translate([battery_small_clip_width, -1, 10-supports_thickn])
			rotate([0, 0, 90])
			mirror([0, 0, 1])
			bridgeSupport([3, battery_small_clip_width], 10);

						// Battery small clips
			translate([0, 0, battery_big_clip_dimens.z + supports_contanct_z_dist])
			translate(battery_hole_pos)
			translate([1, 1]*battery_hole_rad)
			rotate(battery_clips_rot_angle + [0, 0, 180])
			translate(battery_small_clips_pos1 + [battery_small_clip_dimens.x - battery_small_clip_width, battery_small_clip_dimens.y])
			translate([battery_small_clip_width, -1, 10-supports_thickn])
			rotate([0, 0, 90])
			mirror([0, 0, 1])
			bridgeSupport([3, battery_small_clip_width], 10);

			// Membrane + slots inset
			translate([0, 0, membrane_inset_pos.z + supports_contanct_z_dist]) {
				translate([pcb_housing_pos.x, pcb_housing_pos.y])
				roundedCubeSupport(pcb_housing_dimens + [0, 0, 50], pcb_housing_corner_rad, $fn=fn);

				translate([pcb_housing_pos.x, pcb_housing_pos.y] - [2, 2]/2)
				roundedCubeSupport(pcb_housing_dimens + [2, 2, 50], pcb_housing_corner_rad+1, $fn=fn);

				translate([pcb_housing_pos.x, pcb_housing_pos.y] - [3, 3]/2)
				roundedCubeSupport(pcb_housing_dimens + [3, 3, 50], pcb_housing_corner_rad+1.5, $fn=fn);
			}

			// Alignment notches
			translate([0, 0, alignment_notch_pos.z + supports_contanct_z_dist])		
			translate([alignment_notch_pos.x + .5, alignment_notch_pos.y, 0])
			cubicSupport(alignment_notch_dimens + [-1, 0, 50]);

			translate([0, 0, alignment_notch_pos.z + supports_contanct_z_dist])
			translate([0,  main_body_dimens.y - alignment_notch_dimens.y])
			translate([alignment_notch_pos.x + .5, alignment_notch_pos.y, 0])
			cubicSupport(alignment_notch_dimens + [-1, 0, 50]);


			// Screw rod
			translate([0, 0, screw_rod_h + supports_contanct_z_dist])
			translate(screw_pos)
			circularSupport(h=screw_rod_h, r=screw_rod_rad, $fn=fn);

		} // union

		translate([-10, -10, main_body_dimens.z])
		cube([100, 100, 100]);
	} // difference
}

module mainBodySupportsEasy() {
	color ("cyan") {
		// SWD header hole
		if (carve_swd_hole) {
			translate([swd_hole_pos.x, swd_hole_pos.y])
			cubicSupport([
				swd_hole_dimens.x,
				swd_hole_dimens.y,
				bottom_cavity_dimens.z-supports_contanct_z_dist
			], hole=true);
		}

		// UART header hole
		translate([uart_hole_pos.x, uart_hole_pos.y])
		cubicSupport([
			uart_hole_dimens.x,
			uart_hole_dimens.y,
			bottom_cavity_dimens.z-supports_contanct_z_dist
		], hole=true);

		// Button hole
		translate([button_hole_pos.x, button_hole_pos.y])
		circularSupport(
			r=button_hole_rad,
			h=bottom_cavity_dimens.z-supports_contanct_z_dist,
			$fn=fn,
			hole=true
		);

		// Battery housing
		translate([battery_housing_pos.x, battery_housing_pos.y])
		translate([1, 1]*battery_housing_rad)
		circularSupport(
			r=battery_housing_rad,
			h=battery_housing_pos.z-supports_contanct_z_dist,
			$fn=fn
		);

		// Battery hole
		translate([battery_hole_pos.x, battery_hole_pos.y])
		translate([1, 1]*battery_hole_rad)
		circularSupport(
			r=battery_hole_rad,
			h=battery_housing_pos.z-supports_contanct_z_dist,
			$fn=fn,
			hole=true
		);

		// Big PCB clip
		translate([
			pcb_clip_dent_pos.x-pcb_clip_dent_dimens.y,
			pcb_clip_dent_pos.y,
			pcb_housing_pos.z + supports_contanct_z_dist
		])
		bridgeSupport(
			bridge_dimens=[
				pcb_clip_dent_dimens.y+1,
				pcb_clip_dent_dimens.x
			],
			h=pcb_clip_dent_pos.z-pcb_housing_pos.z-supports_contanct_z_dist
		);

		// Small PCB clip (bottom)

		// Ditch SWD hole if carved
		bridge_offset=carve_swd_hole
			? swd_hole_dimens.x
			: 0;

		translate([0, 0, pcb_housing_pos.z + supports_contanct_z_dist])
		translate(pcb_small_clip_positions[0] + [pcb_small_clip_dimens.x, 0])
		mirror([1, 0, 0])
		bridgeSupport(
			bridge_dimens=[
				pcb_small_clip_dimens.x+1.5+bridge_offset,
				pcb_small_clip_dimens.y
			],
			h=pcb_small_clip_pos_z-pcb_housing_pos.z-supports_contanct_z_dist,
			pillar_w=1
		);
		
		// Small PCB clip (top)
		translate([0, 0, pcb_housing_pos.z + supports_contanct_z_dist])
		translate(pcb_small_clip_positions[1] + [pcb_small_clip_dimens.x, 0])
		mirror([1, 0, 0])
		bridgeSupport(
			bridge_dimens=[
				pcb_small_clip_dimens.x+1.5,
				pcb_small_clip_dimens.y
			],
			h=pcb_small_clip_pos_z-pcb_housing_pos.z-supports_contanct_z_dist,
			pillar_w=1
		);
	}
}