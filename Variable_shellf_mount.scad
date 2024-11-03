/* [Parts] */
//
Shelf_height = 18; // [0.1:0.1:50]

// Thickness of the wall mount (at least the distance between a shelf and a wall)
Wall_mount_thickness = 30; // [10:0.1:200]

// Angle between a wall and the bottom of the wall mount (degrees)
Wall_mount_angle = 45; // [20:0.1:90]

// Base value for the thickness of model's walls
Base_thickness = 0.4; // [0.1:0.05:5]

// Size of nothes helping the sliding part to stay parallel to a wall
Notch_size = 10; // [0.1:0.1:50]


/* [Wall mount screws] */
// Should the custom diameter of screw for the wall mount be used
Use_custom_wall_mount_screw = false;

// Type of a screw used for mounting the wall mount (ignored if custom is selected)
Wall_mount_screw = 3; // [3:M3, 4:M4, 5:M5, 6:M6, 7:M7, 8:M8, 9:M9, 10:M10]

// Diameter of a screw used to mount the wall mount (used if custom is selected)
Custom_wall_mount_screw = 3; // [1:0.25:20]

// Shape of a hole that will host the wall mount's screw head
Wall_mount_screw_head_hole = "counterbore"; // [countersink, counterbore]

// Major diameter of wall mount's screw head
Wall_mount_screw_head_major = 6; // [2:0.25:40]

// Angle of countersink hole for wall mount's screw head (degrees)
Wall_mount_screw_head_angle = 90; // [30:1:150]

// Height of counterbore hole for wall mount's screw head
Wall_mount_screw_head_height = 4; // [2:0.25:40]


/* [Sliding part screws] */
// Should the custom diameter of screw for the sliding part be used
Use_custom_slider_screw = false;

// Type of a screw used for mounting the sliding part (ignored if custom is selected)
Slider_screw = 3; // [3:M3, 4:M4, 5:M5, 6:M6, 7:M7, 8:M8, 9:M9, 10:M10]

// Diameter of a screw used to mount the sliding part (used if custom is selected)
Custom_slider_screw = 3; // [1:0.25:20]

// Should there be a space made for screw head, nut or both on the top of the wall mount
Slider_make_top_holes = "screw"; // [screw:screw head, nut, both]

// Should there be a space made for screw head, nut or both on the bottom of the wall mount
Slider_make_bottom_holes = "screw"; // [screw:screw head, nut, both]

// Shape of a hole that will host the sliding part's screw head
Slider_screw_head_hole = "counterbore"; // [countersink, counterbore]

// Major diameter of the sliding part's screw head
Slider_screw_head_major = 6; // [2:0.25:40]

// Angle of countersink hole for the sliding part's screw head (degrees)
Slider_screw_head_angle = 90; // [30:1:150]

// Height of counterbore hole for sliding part's screw head
Slider_screw_head_height = 4; // [2:0.25:40]

// Type/shape of a nut used for the sliding part
Slider_nut_type = "hexagonal"; // [square, hexagonal]

// Size of a nut used for the sliding part - side for square, side-to-side for hex
Slider_nut_size = 6; // [2:0.25:40]


/* [Shelf screws] */
// Should the custom diameter of screw for the shelf be used
Use_custom_shelf_screw = false;

// Spacing of shelf screws, center-to-center
Shelf_screws_spacing = 23; // [2:0.1:100]

// Type of a screw used for mounting the shelf (ignored if custom is selected)
Shelf_screw = 3; // [3:M3, 4:M4, 5:M5, 6:M6, 7:M7, 8:M8, 9:M9, 10:M10]

// Diameter of a screw used to mount the shelf (used if custom is selected)
Custom_shelf_screw = 3; // [1:0.25:20]

// Should there be a space made for screw head, nut or both in the sliding part
Shelf_make_holes = "screw"; // [screw:screw head, nut, both]

// Shape of a hole that will host the shelf's screw head
Shelf_screw_head_hole = "counterbore"; // [countersink, counterbore]

// Major diameter of the shelf's screw head
Shelf_screw_head_major = 6; // [2:0.25:40]

// Angle of countersink hole for the shelf's screw head (degrees)
Shelf_screw_head_angle = 90; // [30:1:150]

// Height of counterbore hole for shelf's screw head
Shelf_screw_head_height = 4; // [2:0.25:40]

// Type/shape of a nut used for the shelf
Shelf_nut_type = "hexagonal"; // [square, hexagonal]

// Size of a nut used for the shelf - side for square, side-to-side for hex
Shelf_nut_size = 6; // [2:0.25:40]


/* [3D printing] */
// Additional clearance for printing, set this to a value that enables easy movement of parts, but not too loose
Clearance = 0.2; // [0:0.01:1]


/* [Render options] */
// Should the part mounted to a wall be rendered
Render_wall_mount = true;

// Should the part holding the shelf be rendered
Render_shelf_mount = true;

// Minimum angle for a fragment for full render ($fa value when $preview is false)
Minimum_angle = 0.6; // [0.01:0.01:45]

// Minimum size for a fragment for full render ($fs value when $preview is false)
Minimum_size = 0.1; // [0.01:0.01:10]


/* [Hidden] */


// Calculate and set values for later use
$fa = $preview ? 6 : Minimum_angle;
$fs = $preview ? 1 : Minimum_size;
wall_mount_screw_size = Use_custom_wall_mount_screw ? Custom_wall_mount_screw : Wall_mount_screw;
slider_screw_size = Use_custom_slider_screw ? Custom_slider_screw : Slider_screw;
shelf_screw_size = Use_custom_shelf_screw ? Custom_shelf_screw : Shelf_screw;
slider_width = Shelf_screws_spacing + Shelf_height;
slider_thickness = 10;

// Functions
function isCountersink(type) = type == "countersink";

function screwHeadHeight(type, minor, major, height, angle) = isCountersink(type) ? (major - minor) / (2 * tan(angle / 2)) : height;

// Modules
module screwHead(type, minor, major, height, angle) {
    let (calculated_height = screwHeadHeight(type, minor, major, height, angle)) {
        translate([0, 0, -calculated_height / 2]) cylinder(h = calculated_height, d1 = (isCountersink(type) ? minor : major), d2 = major, center = true);
    }
}

module screw(length, type, minor, major, height, angle, with_tolerances=true) {
    union() {
        cylinder(h = length + 0.01, d = minor + (with_tolerances ? 2 * Clearance : 0), center = true);
        translate([0, 0, (length + 0.01) / 2]) screwHead(type, minor + (with_tolerances ? Clearance * 2 : 0), major + (with_tolerances ? Clearance * 2 : 0), height + (with_tolerances ? Clearance : 0), angle);
    }
}

module shelfScrew(with_tolerances=true) {
    screw(slider_thickness, Shelf_screw_head_hole, Shelf_screw, Shelf_screw_head_major, Shelf_screw_head_height, Shelf_screw_head_angle, with_tolerances);
}

// Sliding part
if (Render_shelf_mount) {
    difference() {
        union() {
            cube([slider_width, Shelf_height, slider_thickness], center = true);
        }
        translate([Shelf_screws_spacing / 2, 0, 0]) shelfScrew();
        translate([-Shelf_screws_spacing / 2, 0, 0]) shelfScrew();
    }
    if ($preview) {
        translate([Shelf_screws_spacing / 2, 0, 0]) #shelfScrew(false);
        translate([-Shelf_screws_spacing / 2, 0, 0]) #shelfScrew(false);
    }
}

// Wall mount
if (Render_wall_mount) {
}
