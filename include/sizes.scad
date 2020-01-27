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

main_body_h=8;
main_body_dimens=[42, 42, main_body_h];
main_body_corner_rad=10;

membrane_inset_dimens=[40, 40, 1.3];
membrane_inset_corner_rad=10;