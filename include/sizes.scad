include <../config.scad>

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

pcb_housing_dimens=[35, 35, 4.5];
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

battery_big_clip_dimens=[7, 4, 0.8];
battery_small_clip_dimens=[9, 1.8, 0.8];
battery_small_clip_cutout_dimens=[battery_small_clip_dimens.x-3, 2.3, 1];
battery_big_clip_pos1=[-battery_big_clip_dimens.x/2, -battery_hole_rad-battery_big_clip_dimens.y/4];
battery_small_clips_pos1=[-battery_small_clip_dimens.x/2, -battery_hole_rad-battery_small_clip_dimens.y/4-0.2];
battery_clips_rot_angle=[0, 0, 45];
battery_clips_pos2=battery_hole_pos;
battery_small_clip_width=(battery_small_clip_dimens.x-battery_small_clip_cutout_dimens.x)/2;

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
lid_clips_slot_z=1.3;
lid_clips_slot_dimens=[0.5, membr_spacial_slots_dimens.y, main_body_dimens.z-lid_clips_slot_z];

custom_lid_clips_slot_dimens=lid_clips_slot_dimens-[0, 0, 3];

pcb_thickn=1.4; // just to be on the safe side
pcb_clip_h=2;

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

pcb_holder_stopper_dimens=[
    1.5,
    5,
    membrane_inset_dimens.z
];

pcb_holder_stopper_pos=[
    pcb_housing_pos.x-pcb_holder_stopper_dimens.x,
    (main_body_dimens.y-pcb_holder_stopper_dimens.y)/2,
    membrane_inset_pos.z
];

pcb_holder_hole_dimens=[
    (main_body_dimens.x-pcb_housing_dimens.x)/2,
    4,
    membrane_inset_pos.z-pcb_housing_pos.z-pcb_thickn-pcb_standoffs_dimens.z
];

pcb_holder_dimens=[
    5.6,
    pcb_holder_hole_dimens.y - .3,
    pcb_holder_hole_dimens.z - .3
];

pcb_holder_hole_pos=[
    0,
    (main_body_dimens.y-pcb_holder_hole_dimens.y)/2,
    pcb_housing_pos.z+pcb_standoffs_dimens.z+pcb_thickn
];

screw_hole_rad=screw_diam*1.2/2;
screw_rod_rad=screw_hole_rad+wall_thickn;
screw_rod_h=pcb_housing_pos.z+pcb_standoffs_dimens.z;


hinges_hole_rad=1.5;
hinges_hole_z=3.2;

hinges_hole_guide_rad_top=2;
hinges_hole_guide_thickn=0.5;

alignment_notch_dimens=[
    3,
    wall_thickn + 0.08,
    3
];
alignment_notch_pos=[
    main_body_dimens.x/2 - 8.5,
    0,
    main_body_dimens.z - alignment_notch_dimens.z
];


// Lid sizes

//lid_dimens=[main_body_dimens.x, main_body_dimens.y, ]