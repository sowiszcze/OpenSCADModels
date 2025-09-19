# OpenSCADModels

A set of OpenSCAD models I made for personal use.

Every model has settings related to preparing the model for 3D printing. An
example of such is a desired clearance.

If not stated different, all values are in millimeters.

## List of models

### `Variable_shelf_mount.scad`

The result of this models is a mounting system allowing a shelf or a drawer to
be mounted in a wider space than themselves. The model consists of two parts:

- *Wall mount* is to be screwed (or glued, it's up to you) to a wall or other
immovable object.
- *Sliding part* is a part to which a drawer, shelf or drawer mechanism should
be mounted to.

Both parts have spaces for screws and nuts to allow for easy mounting, and
adjustment.

The model itself is parametric, so there is no set bill of materials, but if you
wish to leave all the default settings, the resulting BOM per model is:

| Name                    | Amount |
| ----------------------- | -----: |
| M4×40 countersink screw |      3 |
| M4×55 counterbore screw |      2 |
| M3×15 counterbore screw |      4 |
| M4 square nut           |      2 |

Suggested lengths for screws to use with the model are printed to the console
at the end of rendering process.
