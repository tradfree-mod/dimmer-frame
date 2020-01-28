/*
- Outer size:
    - Size: X 42, Y 42, Z 8
    - Corner radius: 10
- Membrane inset
    - Centered
    - Size: Radial 1, Z 1.3
    - Corner radius: 6.5
- Membrane slots
    - Top, bottom, right: 5x2, centered
    - Left: 2 slots, 6x1.5, 4 from center
- PCB housing
    - Centered
    - Size: X 33.4, Y 33.4, Z 5 (with 1mm PCB standoffs from bottom of housing to Z 2.5)
- Battery housing
    - Position: X 9.9, Y 13.4, Z 0
        - Z relative to PCB housing top
        - X, Y relative to outer size
    - Size: ø 19.7, Z 3.7
- Button hole
    - Position: X centered, Y 8.9 to center 
    - Size: ø 4
- JTAG hole
    - Position: X 32, Y 9.5
    - Size: X 3, Y 11
- UART hole
    - Position: X 29, Y 10
    - Size: X 4.7, Y 4.7
- Pivot holes
    - Position: top+bottom sides, 1.9 from top to top of hole
    - Size: 2.9
- Orientation slot
    - Position: top side, 5.6 left from center
    - Size: Y 1, Z 3
*/

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
    [pcb_housing_pos.x, pcb_housing_pos.y+6],
    [pcb_housing_pos.x+6, pcb_housing_pos.y],

    [pcb_housing_pos.x+pcb_housing_dimens.x-pcb_standoffs_dimens.x, pcb_housing_pos.y+6],
    [pcb_housing_pos.x+pcb_housing_dimens.x-pcb_standoffs_dimens.x-6, pcb_housing_pos.y],

    [pcb_housing_pos.x, pcb_housing_pos.y+pcb_housing_dimens.y-pcb_standoffs_dimens.y-6],
    [pcb_housing_pos.x+6, pcb_housing_pos.y+pcb_housing_dimens.y-pcb_standoffs_dimens.y],

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

membr_slots_dimens=[5, 2];
membr_spacial_slots_dimens=[1.5, 6];
membr_spacial_offset_center=4;
