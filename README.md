# IKEA TRÅDFRI dimmer 3D-printable frame

[![Gitlab pipeline status](https://img.shields.io/gitlab/pipeline/tradfree/dimmer-frame?label=render)](https://gitlab.com/tradfree/dimmer-frame/-/jobs) [![License: CC BY-SA 4.0](https://img.shields.io/badge/license-cc%20by--sa%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

This is a 3D-printable replica of the IKEA lights dimmer frame.

There are two configations:

- One is compatible with the original IKEA bottom lid
- One also exposes the SWD debug header and will be compatible
  with our debug chip and bottom lid (which we haven't finished yet)

## Building the design

Prebuilt STL downloads:
https://gitlab.com/tradfree/bottom-case/-/jobs/artifacts/master/?job=render

The design can be built in two ways:

- By opening one of the `.scad` files with OpenSCAD (tweak the
  the settings in `config.scad`)
- With make:

    ```
    make case  # Case with SWD hole, screw hole in a different position
    make case-ikea  # Compatible with the original IKEA lid
    ```

## Support material

Since the part is very small and has a lot of tiny parts and clips,
it is practically impossible to print it without supports or with
normal slicer auto-generated supports.

For this reason, we decided to include tailor-made supports in the
model itself. There are two types of supports:

- "easy": supports on the battery (bottom) side. Easier to print and
  remove because there aren't too many floating parts, but it won't
  look as good.
- "hardcore": supports on the PCB (top) side. Huge amount of supports,
  takes 10 minutes and a lot of care to remove. Top part is going to
  look bad but you're going to cover it with the PCB, so you'll only
  see it once ;)

Supports can either be enabled in `config.scad` by setting
`build_supports` to `"easy"` or `"hardcore"`, and disabled by setting
it to `"none"`, or with `make` by passing
`'-Dbuild_supports="easy/hardcore"'` (yes you need the quotation marks)

Under [/img](/img) you can find a preview of the supports (in cyan)
that you can use as reference for removal. Be careful because OpenSCAD
colored the bottom of the battery clips cyan but they're not to be
removed.

### Important

The build does **not** flip the model if you build it with "hardcore"
supports, you need to rotate it 180° before slicing.

## Print settings

It's very important to adjust print settings otherwise the print isn't
gonna be any good.

I suggest you use either Slic3r or Slic3r++ (fork by supermarill) and
not Cura. In my experience Cura wasn't able to detect some bridges and
it would generate spaghetti.

- Disable supports (unless you're using soluble supports)
- Enable thin wall detection and (if available) set it to the smallest
  wall size detection available
- Layer height: 1.5mm
- Optionally enable top surface ironing:
  - Cura: find "Ironing"
  - Slic3r++: set top surface pattern to "ironing"
- Use slow print speeds
- Enable bridge detection and optimization if available
- Set fan to always, 100%, if available
- Remember to rotate the model if using "hardcore" supports

## Troubleshooting

### Screw hole is too wide/tight

Tweak it in `config.scad`

### Can't push battery in

Make sure you've scraped the supports away well enough. Insert the battery
from the PCB side: it must be flush with the battery housing on the other
side.

You can tweak the battery clip sizes in `include/sizes.scad`, change
`battery_small_clip_dimens` and `battery_big_clip_dimens`.

### PCB doesn't click in

Make sure the battery is flush with its housing. Also make sure you didn't
break the clips.

## License

[![Creative Commons License](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)](https://creativecommons.org/licenses/by-sa/4.0/)

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).
