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

module clipDent(dimens) {
	angle=atan2(dimens.z, dimens.y);

	difference() {
		cube(dimens);

		rotate([angle])
		translate([-1, 0])
		cube([dimens.x*2, dimens.y*10, dimens.z*10]);
	}
}

module hingeGuide(r1, r2, h, dist, center=false, $fn=50) {
	hull() {
		cylinder(r=r1, h=h, $fn=$fn, center=center);

		translate([-dist, 0])
		cylinder(r=r2, h=h, $fn=$fn, center=center);
	}
}

function swap(vector) = [vector[1], vector[0]];