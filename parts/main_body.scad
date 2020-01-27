include <../config.scad>
include <../include/modules.scad>
include <../include/sizes.scad>

module mainBody() {
	difference() {
		roundedCube(main_body_dimens, main_body_corner_rad);

		translate([0, 0, main_body_dimens.z-membrane_inset_dimens.z])
		#translate([
				main_body_dimens.x-membrane_inset_dimens.x,
				main_body_dimens.y-membrane_inset_dimens.y
			]/2)
		roundedCube(membrane_inset_dimens, membrane_inset_corner_rad);
	}
}