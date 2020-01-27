module roundedCube(dimens, corner_radius, $fn=50) {
	hull() {
		translate([corner_radius, corner_radius])
		cylinder(r=corner_radius, h=dimens.z);

		translate([corner_radius, dimens.y-corner_radius])
		cylinder(r=corner_radius, h=dimens.z);


		translate([dimens.x-corner_radius, corner_radius])
		cylinder(r=corner_radius, h=dimens.z);


		translate([dimens.x-corner_radius, dimens.y-corner_radius])
		cylinder(r=corner_radius, h=dimens.z);
	}
}