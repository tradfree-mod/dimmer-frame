include <../config.scad>

module cubicSupport(dimens, hole=false) {
	actual_dimens=hole
		? dimens + [supports_thickn, supports_thickn, 0]
		: dimens;
	offset=hole
		? -[supports_thickn, supports_thickn]
		: [0, 0];

	translate(offset)
	difference() {
		cube(actual_dimens);

		translate([1, 1, -1]*supports_thickn)
		cube(actual_dimens - [2, 2, -2]*supports_thickn);
	}
}

module roundedCubeSupport(dimens, corner_radius, $fn=50, hole=false) {
	actual_dimens=hole
		? dimens + [supports_thickn, supports_thickn, 0]
		: dimens;
	offset=hole
		? -[supports_thickn, supports_thickn]
		: [0, 0];

	translate(offset)
	difference() {
		roundedCube(actual_dimens, corner_radius, $fn=$fn);

		translate([1, 1, -1]*supports_thickn)
		roundedCube(actual_dimens - [2, 2, -2]*supports_thickn, corner_radius-supports_thickn, $fn=$fn);
	}
}

module circularSupport(r=undef, d=undef, h=undef, $fn=undef, hole=false) {
	actual_r=hole
		? r+supports_thickn
		: r;
	actual_d=hole
		? d+2*supports_thickn
		: d;

	difference() {
		cylinder(r=actual_r, d=actual_d, h=h, $fn=$fn);

		translate([0, 0, -1]*supports_thickn)
		cylinder(
			r=actual_r-supports_thickn,
			d=actual_d-2*supports_thickn,
			h=h+2*supports_thickn,
			$fn=$fn
		);
	}
}

module doubleCircularSupport(r=undef, d=undef, h=undef, thickn=1, $fn=undef) {
	circularSupport(r=r, d=d, h=h, $fn=$fn);
	circularSupport(r=r-thickn, d=d-thickn*2, h=h, $fn=$fn);
}

module arcSupport(r=undef, d=undef, angle=undef, h=undef, $fn=undef, hole=false) {
	actual_r=hole
		? r+supports_thickn
		: r;
	actual_d=hole
		? d+2*supports_thickn
		: d;
	offset=actual_r == undef
		? actual_d/2
		: actual_r;

	rotate_extrude(angle=angle, $fn=fn)
	translate([offset, 0])
	square([supports_thickn, h]);
}

module squareSupport(dimens) {
	cube(concat(dimens, [supports_thickn]));
}

module bridgeSupport(bridge_dimens, h, pillar_w=1) {
	union() {
		translate([0, 0, h])
		squareSupport(bridge_dimens + [pillar_w, 0]);

		translate([bridge_dimens.x, 0])
		cubicSupport([
			pillar_w,
			bridge_dimens.y,
			h
		], hole=false);
	}
}