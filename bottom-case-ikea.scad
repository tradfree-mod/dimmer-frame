include <config.scad>
include <include/sizes.scad>

// Overrides for IKEA original bottom lid
screw_pos=[
    33.5,
    main_body_dimens.y/2
];
carve_swd_hole=false;


include <include/modules.scad>
include <parts/main_body.scad>


mainBody();