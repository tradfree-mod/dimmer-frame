fn=30;

wall_thickn=1;

main_body_h=8;
main_body_dimens=[42, 42, main_body_h];
main_body_corner_rad=10;

membrane_inset_dimens=[40, 40, 1];
membrane_inset_pos=[
    (main_body_dimens.x-membrane_inset_dimens.x)/2,
    (main_body_dimens.y-membrane_inset_dimens.y)/2,
    main_body_dimens.z-membrane_inset_dimens.z
];
membrane_inset_corner_rad=10;

pcb_housing_dimens=[33.4, 33.4, 4.5];
pcb_housing_pos=[
    (main_body_dimens.x-pcb_housing_dimens.x)/2,
    (main_body_dimens.y-pcb_housing_dimens.y)/2,
    main_body_dimens.z-membrane_inset_dimens.z-pcb_housing_dimens.z
];
pcb_housing_corner_rad=6.5;

pcb_standoffs_h=2;
pcb_standoffs_dimens=[1.5, 1.5, pcb_standoffs_h];
pcb_standoffs_positions=[
    // Bottom-left
    [pcb_housing_pos.x, pcb_housing_pos.y+6],
    [pcb_housing_pos.x+6, pcb_housing_pos.y],

    // Bottom right
    [pcb_housing_pos.x+pcb_housing_dimens.x-pcb_standoffs_dimens.x, pcb_housing_pos.y+6],
    [pcb_housing_pos.x+pcb_housing_dimens.x-pcb_standoffs_dimens.x-6, pcb_housing_pos.y],

    // Top left
    [pcb_housing_pos.x, pcb_housing_pos.y+pcb_housing_dimens.y-pcb_standoffs_dimens.y-6],
    [pcb_housing_pos.x+6, pcb_housing_pos.y+pcb_housing_dimens.y-pcb_standoffs_dimens.y],

    // Top right
    [pcb_housing_pos.x+pcb_housing_dimens.x-pcb_standoffs_dimens.x, pcb_housing_pos.y+pcb_housing_dimens.y-pcb_standoffs_dimens.y-6],
    [pcb_housing_pos.x+pcb_housing_dimens.x-pcb_standoffs_dimens.x-6, pcb_housing_pos.y+pcb_housing_dimens.y-pcb_standoffs_dimens.y],
];

bottom_cavity_dimens=[
    30,
    30,
    pcb_housing_pos.z-wall_thickn
];
bottom_cavity_pos=[
    (main_body_dimens.x-bottom_cavity_dimens.x)/2,
    (main_body_dimens.y-bottom_cavity_dimens.y)/2
];
bottom_cavity_corner_rad=5;

button_hole_rad=2.5;
button_hole_pos=[main_body_dimens.x/2, 8.9];

swd_hole_dimens=[3, 11];
swd_hole_pos=[32, 10];

uart_hole_dimens=[4.7, 4.7];
uart_hole_pos=[8.5, 10];


battery_hole_rad=21.5/2;
battery_hole_pos=[9.4, 12.9];

battery_housing_rad=battery_hole_rad+wall_thickn;
battery_housing_h=3.7;
battery_housing_pos=concat(
    battery_hole_pos-[1,1]*wall_thickn,
    [pcb_housing_pos.z+pcb_standoffs_h-battery_housing_h]
);

battery_big_clip_dimens=[7, 4, 1];
battery_small_clip_dimens=[9, 2.3, 1];
battery_small_clip_cutout_dimens=[battery_small_clip_dimens.x-3, 2.3, 1];
battery_big_clip_pos1=[-battery_big_clip_dimens.x/2, -battery_hole_rad-battery_big_clip_dimens.y/4];
battery_small_clips_pos1=[-battery_small_clip_dimens.x/2, -battery_hole_rad-battery_small_clip_dimens.y/4];
battery_clips_rot_angle=[0, 0, 45];
battery_clips_pos2=battery_hole_pos;

battery_removal_dent_size=[
    battery_small_clip_cutout_dimens.x,
    wall_thickn*2,
    battery_housing_h
];

battery_removal_dent_pos1=[
    -battery_removal_dent_size.x/2,
    -battery_hole_rad-battery_removal_dent_size.y/1.3 // magic number
];
battery_removal_dent_rot=battery_clips_rot_angle + [0, 0, 180];

membr_slots_dimens=[5, 2];
membr_spacial_slots_dimens=[1.5, 6];
membr_spacial_offset_center=4;


pcb_thickn=1.2; // just to be on the safe side
pcb_clip_h=1.5;

pcb_clip_stick_dimens=[.7, 4, 5-pcb_clip_h];
pcb_clip_stick_pos=[
    pcb_housing_pos.x-pcb_clip_stick_dimens.x,
    main_body_dimens.y/2-pcb_clip_stick_dimens.y/2,
    pcb_housing_pos.z
];

pcb_clip_dent_dimens=[
    pcb_clip_stick_dimens.y,
    pcb_clip_stick_dimens.x*2,
    pcb_clip_h
];
pcb_clip_dent_rot=[0, 0, 90];
pcb_clip_dent_pos=[
    pcb_clip_stick_pos.x+pcb_clip_dent_dimens.y,
    pcb_clip_stick_pos.y,
    pcb_clip_stick_pos.z+pcb_clip_stick_dimens.z
];

pcb_clip_cutoff_dimens=[3, pcb_clip_stick_dimens.y+2, pcb_housing_dimens.z];
pcb_clip_cutoff_pos=[
    pcb_housing_pos.x-pcb_clip_cutoff_dimens.x,
    main_body_dimens.y/2-pcb_clip_cutoff_dimens.y/2,
    membrane_inset_pos.z-pcb_clip_cutoff_dimens.z
];

pcb_small_clip_dimens=[
    pcb_standoffs_dimens.x,
    pcb_standoffs_dimens.y,
    pcb_housing_dimens.z-pcb_thickn-pcb_standoffs_dimens.z
];
pcb_small_clip_pos_z=pcb_housing_pos.z+pcb_standoffs_dimens.z+pcb_thickn;
pcb_small_clip_positions=[
    // The ones on the right
    pcb_standoffs_positions[2],
    pcb_standoffs_positions[6]
];

screw_diam=2;

// For custom bottom lid
screw_pos=[9, 33];

// For IKEA original bottom lid
/*
screw_pos=[
    33.5,
    main_body_dimens.y/2
];
*/

// Set to false if you want to use it with the IKEA bottom lid
carve_swd_hole=true;

screw_hole_fn=6;

screw_hole_rad=screw_diam*1.2/2;
screw_rod_rad=screw_hole_rad+wall_thickn;
screw_rod_h=pcb_housing_pos.z+pcb_standoffs_dimens.z;