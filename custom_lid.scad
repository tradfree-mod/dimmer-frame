include <config.scad>
include <include/sizes.scad>
include <include/modules.scad>
include <parts/custom_lid.scad>

translate([0, 0, custom_pcb_thickn+usb_c_hole_pos.z+usb_c_hole_dimens.z])
translate([lid_dimens.x, lid_dimens.y]/2)
rotate([0, 180, 90])
color("purple")
union() {
	translate(-[33, 33]/2)
	linear_extrude(0.8)
	import("custom-pcb-board.svg");
	import("zigbee_coordinator2.stl");
}

customLid();