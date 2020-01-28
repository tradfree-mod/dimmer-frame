tip_rad=0.3;
tip_len=1.5;
body_rad=0.5;
body_len=2.8;
ring_rad=1;
ring_len=0.4;
solder_tip_rad=0.4;
solder_tip_len=1.5;
fn=100;


translate([0, 0, tip_len+body_len+ring_len])
rotate([180, 0, 0])
union() {
	translate([0, 0, tip_len+body_len+ring_len]) {
		cylinder(r=solder_tip_rad, h=solder_tip_len, $fn=fn);
	}

	translate([0, 0, tip_len+body_len]) {
		cylinder(r=ring_rad, h=ring_len, $fn=fn);
	}

	translate([0, 0, tip_len+body_rad]) {
		cylinder(r=body_rad, h=body_len-body_rad, $fn=fn);
		sphere(r=body_rad, $fn=fn);
	}

	translate([0, 0, tip_rad]) {
		cylinder(r=tip_rad, h=tip_len-tip_rad+1, $fn=fn);
		sphere(r=tip_rad, $fn=fn);
	}
}