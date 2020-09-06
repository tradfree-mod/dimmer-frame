include <config.scad>
include <include/sizes.scad>
include <include/modules.scad>
include <parts/main_body.scad>

// Overrides for IKEA original bottom lid
screw_pos=[
    33.5,
    21
];
carve_swd_hole=false;
custom_case_clip=false;

mainBody();