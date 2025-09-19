/* [Parts] */
// Thickness of a shelf
Shelf_height = 45; // [1:1:100]

// Thickness of the wall mount (at least the distance between a shelf and a wall)
Wall_mount_thickness = 30; // [10:1:200]

// Thickness of the sliding part (at least the size of shelf screw's head's size with some margin)
Slider_thickness = 20; // [5:1:50]

// Angle between a wall and the bottom of the wall mount (degrees)
Wall_mount_angle = 45; // [20:1:90]

// Additional thickness of a wall mount in the space where it is screwed to a wall
Wall_mount_additional_thickness = 4; // [0:1:50]

// Base value for the thickness of model's walls
Base_thickness = 2; // [0.1:0.1:20]

// Size of nothes helping the sliding part to stay parallel to a wall
Notch_size = 5; // [0.1:0.1:50]


/* [Wall mount screws] */
// Should the custom diameter of screw for the wall mount be used
Use_custom_wall_mount_screw = false;

// Type of a screw used for mounting the wall mount (ignored if custom is selected)
Wall_mount_screw = 4; // [3:M3, 4:M4, 5:M5, 6:M6, 7:M7, 8:M8, 9:M9, 10:M10]

// Diameter of a screw used to mount the wall mount (used if custom is selected)
Custom_wall_mount_screw = 4; // [1:0.2:20]

// Shape of a hole that will host the wall mount's screw head
Wall_mount_screw_head_hole = "countersink"; // [countersink, counterbore]

// Major diameter of wall mount's screw head
Wall_mount_screw_head_major = 6; // [2:0.2:40]

// Height of counterbore hole for wall mount's screw head
Wall_mount_screw_head_height = 4; // [2:1:10]


/* [Sliding part screws] */
// Should the custom diameter of screw for the sliding part be used
Use_custom_slider_screw = false;

// Type of a screw used for mounting the sliding part (ignored if custom is selected)
Slider_screw = 3; // [3:M3, 4:M4, 5:M5, 6:M6, 7:M7, 8:M8, 9:M9, 10:M10]

// Diameter of a screw used to mount the sliding part (used if custom is selected)
Custom_slider_screw = 3; // [1:0.2:20]

// Shape of a hole that will host the sliding part's screw head
Slider_screw_head_hole = "counterbore"; // [countersink, counterbore]

// Major diameter of the sliding part's screw head
Slider_screw_head_major = 6; // [2:0.2:40]

// Height of counterbore hole for sliding part's screw head
Slider_screw_head_height = 4; // [2:0.2:40]

// Type/shape of a nut used for the sliding part
Slider_nut_type = "hexagonal"; // [square, hexagonal]

// Size of a nut used for the sliding part - side for square, side-to-side for hex
Slider_nut_size = 6; // [2:0.2:40]

// Thickness of a nut used for the sliding part
Slider_nut_thickness = 3; // [1:0.2:10]


/* [Shelf screws] */
// Should the custom diameter of screw for the shelf be used
Use_custom_shelf_screw = false;

// Spacing of shelf screws, center-to-center
Shelf_screws_spacing = 12; // [2:0.5:100]

// Type of a screw used for mounting the shelf (ignored if custom is selected)
Shelf_screw = 4; // [3:M3, 4:M4, 5:M5, 6:M6, 7:M7, 8:M8, 9:M9, 10:M10]

// Diameter of a screw used to mount the shelf (used if custom is selected)
Custom_shelf_screw = 1; // [1:0.2:20]

// Shape of a hole that will host the shelf's screw head
Shelf_screw_head_hole = "countersink"; // [countersink, counterbore]

// Major diameter of the shelf's screw head
Shelf_screw_head_major = 6; // [2:0.2:40]

// Height of counterbore hole for shelf's screw head
Shelf_screw_head_height = 4; // [2:0.2:40]


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

// Thickness of a wall the mount will be attached to
Wall_thickness = 18; // [1:1:50]

// How deep should shelf mounting screw penetrate it
Shelf_screw_penetration = 25; // [1:1:50]

// Additional length of a screw for more visible visual clues
Additional_screws_length = 2; // [0:0.1:20]


/* [Hidden] */


// Calculate and set values for later use
$fa = $preview ? 6 : Minimum_angle;
$fs = $preview ? 1 : Minimum_size;

e = 0.01;

wall_mount_screw_size = Use_custom_wall_mount_screw ? Custom_wall_mount_screw : Wall_mount_screw;
slider_screw_size = Use_custom_slider_screw ? Custom_slider_screw : Slider_screw;
shelf_screw_size = Use_custom_shelf_screw ? Custom_shelf_screw : Shelf_screw;

wall_mount_screw_length = Base_thickness + Wall_mount_additional_thickness + Wall_thickness / 2;
slider_screw_length = Shelf_height + Clearance * 2 + Base_thickness * 2 + Slider_nut_thickness;
shelf_screw_length = Slider_thickness + Shelf_screw_penetration;

wall_mount_support = Wall_mount_thickness / tan(Wall_mount_angle);

slider_width = 2 * (Shelf_screws_spacing + 2 * Base_thickness + Notch_size) + Shelf_screw_head_major + 2 * max(Slider_screw_head_major, Slider_nut_size);
slider_needed_space = Shelf_height + Notch_size * 2 + Clearance * 2;

slider_screw_position = Shelf_screws_spacing + Base_thickness + (Shelf_screw_head_major + max(Slider_screw_head_major, Slider_nut_size)) / 2;
wall_mount_screw_position = slider_screw_position;
nut_position = -(Shelf_height / 2 + Base_thickness + Clearance + Slider_nut_thickness / 2);



// Functions

function isCountersink(type) = type == "countersink";
function isSquare(type) = type == "square";
function toleranceAware(size, with_tolerances, doubleSided=true) = size + (with_tolerances ? (doubleSided ? 2 : 1) * Clearance : 0);



// Modules

module screwHead(type, minor, major, height) {
    translate([0, 0, -height / 2])
        cylinder(h = height + e, d1 = (isCountersink(type) ? minor : major), d2 = major, center = true);
}

// Generates a full screw from arguments
//   length - screw's length without head
//   type - type of screw's head (countersink or counterbore)
//   minor - screw's diameter
//   major - screw head's diameter
//   height - screw head's height
module screw(length, type, minor, major, height, with_tolerances=true) {
    union() {
        cylinder(h = length + e, d = toleranceAware(minor, with_tolerances), center = true);
        translate([0, 0, toleranceAware(height, with_tolerances, doubleSided = false) + (length + e) / 2])
            screwHead(type, toleranceAware(minor, with_tolerances), toleranceAware(major, with_tolerances), toleranceAware(height, with_tolerances, doubleSided = false));
    }
}

// Generates a nut from arguments
//   thickness - thickness of the nut (height when it's horizontal)
//   size - nut's side length if square, or diameter for hexagonal
//   screw - what is the size of a screw that goes through this nut
//   shape - the shape of the nut (square or hexagonal)
//   with_hole - should it include a hole for a screw
module nut(thickness, size, screw, shape, with_hole=true, with_tolerances=true) {
    difference() {
        if (isSquare(shape)) {
            cube([toleranceAware(size, with_tolerances), toleranceAware(size, with_tolerances), toleranceAware(thickness, with_tolerances)], center = true);
        }
        else {
            rotate(30, [0, 0, 1])
                linear_extrude(height = toleranceAware(thickness, with_tolerances), center = true)
                    polygon([ for (i = [0 : 60 : 300]) [toleranceAware(size, with_tolerances) * cos(i) / 2, toleranceAware(size, with_tolerances) * sin(i) / 2] ]);
        }
        if (with_hole) {
            cylinder(h = toleranceAware(thickness, with_tolerances) + e, d = toleranceAware(screw, with_tolerances), center = true);
        }
    }
}

module slot(diameter, length, height, with_tolerances=true) {
    linear_extrude(height = height, center = true)
        hull() {
            translate([(length - diameter) / 2, 0, 0])
                circle(d=diameter);
            translate([(length - diameter) / -2, 0, 0])
                circle(d=diameter);
        }
}

module triangleNotch(thickness, with_tolerances=true) {
    let (tolerance = toleranceAware(0, with_tolerances, false), start = -tolerance, size = 2 * (sqrt(2 * pow(Notch_size, 2)) / 2 + tolerance + sqrt(2 * pow(tolerance, 2))) / sqrt(2), end = size + start) {
        difference() {
            linear_extrude(height = thickness, center = true)
                polygon([[start, start], [start, end], [end, start]]);
            translate([start - e, tolerance / 2, -(thickness + e) / 2])
                mirror([0, 1, 0])
                    cube([end - start + e * 2, 2 * tolerance - e, thickness + e * 2], center = false);
        }
    }
}

// Generates a shelf screw
module shelfScrew(with_tolerances=true) {
    translate([0, 0, -(Additional_screws_length + Shelf_screw_penetration) / 2 - Shelf_screw_head_height])
        screw(shelf_screw_length + Additional_screws_length, Shelf_screw_head_hole, shelf_screw_size, Shelf_screw_head_major, Shelf_screw_head_height, with_tolerances);
}

// Generates a slider screw
module sliderScrew(with_tolerances=true) {
    translate([0, 0, -(Slider_nut_thickness + Additional_screws_length + Slider_screw_head_height) / 2])
        screw(slider_screw_length + Additional_screws_length, Slider_screw_head_hole, slider_screw_size, Slider_screw_head_major, Slider_screw_head_height, with_tolerances);
}

//Generates a wall mount screw
module wallMountScrew(with_tolerances=true) {
    mirror([0, 0, 1])
        translate([0, 0, -Additional_screws_length / 2])
            screw(wall_mount_screw_length + Additional_screws_length, Wall_mount_screw_head_hole, wall_mount_screw_size, Wall_mount_screw_head_major, Wall_mount_screw_head_height, with_tolerances);
}

module slider(thickness, with_tolerances=true) {
    union() {
        cube([toleranceAware(slider_width, with_tolerances), toleranceAware(Shelf_height, with_tolerances), thickness], center = true);
        translate([0, Shelf_height / 2, 0])
            cylinder(r=toleranceAware(Notch_size, with_tolerances), h=thickness, center=true);
        translate([0, -Shelf_height / 2, 0])
            cylinder(r=toleranceAware(Notch_size, with_tolerances), h=thickness, center=true);
        translate([-slider_width / 2, Shelf_height / 2, 0])
            triangleNotch(thickness, with_tolerances);
        translate([slider_width / 2, Shelf_height / 2, 0])
            mirror([1, 0, 0])
                triangleNotch(thickness, with_tolerances);
        translate([-slider_width / 2, -Shelf_height / 2, 0])
            mirror([0, 1, 0])
                triangleNotch(thickness, with_tolerances);
        translate([slider_width / 2, -Shelf_height / 2, 0])
            mirror([1, 0, 0])
                mirror([0, 1, 0])
                    triangleNotch(thickness, with_tolerances);
    }
}



// Sliding part

if (Render_shelf_mount) {
    echo(str("Size of shelf screws should be at least ", shelf_screw_length, "mm."))
    difference() {
        slider(Slider_thickness, false);

        translate([Shelf_screws_spacing, 0, 0])
            shelfScrew();
        shelfScrew();
        translate([-Shelf_screws_spacing, 0, 0])
            shelfScrew();

        translate([slider_screw_position, Slider_screw_head_height - Slider_nut_thickness / 2, 0])
            rotate(90, [-1, 0, 0])
                sliderScrew();
        translate([-slider_screw_position, Slider_screw_head_height - Slider_nut_thickness / 2, 0])
            rotate(90, [-1, 0, 0])
                sliderScrew();
    }
    if ($preview) {
        translate([Shelf_screws_spacing, 0, 0])
            #shelfScrew(false);
        #shelfScrew(false);
        translate([-Shelf_screws_spacing, 0, 0])
            #shelfScrew(false);
    }
}



// Wall mount

if (Render_wall_mount) {
    echo(str("Size of wall mounting screws should be about ", wall_mount_screw_length, "mm."))
    let (slider_space_depth = Wall_mount_thickness - (Base_thickness + Wall_mount_additional_thickness)) {
        let (base_displace = Wall_mount_thickness - slider_space_depth / 2) {
            let (screw_pos_z = base_displace + wall_mount_screw_length / 2 - (Base_thickness + Wall_mount_additional_thickness), wall_pos_z = base_displace - (Wall_mount_thickness / 2 + Base_thickness + Wall_mount_additional_thickness + Wall_mount_screw_head_height)) {
                let (x1 = 0, x2 = Base_thickness + Wall_mount_additional_thickness + Wall_mount_screw_head_height, x3 = Wall_mount_thickness, y2 = -(Slider_screw_head_height + Base_thickness + slider_needed_space / 2)) {
                    let (y1 = y2 - wall_mount_support, y3 = -y2, screw_pos_bottom = y2 - (wall_mount_support / 3 + Wall_mount_screw_head_major / 2)) {
                        let (y4 = y3 + toleranceAware(Base_thickness, true) * 2 + Wall_mount_screw_head_major, screw_pos_top = y3 + Base_thickness + toleranceAware(Wall_mount_screw_head_major, true) / 2) {
                            difference() {
                                translate([0, 0, base_displace])
                                    rotate(90, [0, 1, 0])
                                        linear_extrude(height = slider_width, center = true)
                                            polygon([[x1,y1],[x3,y2],[x3,y3],[x2,y3],[x2,y4],[x1,y4]]);
                                slider(slider_space_depth + e);
                                translate([wall_mount_screw_position, screw_pos_top, screw_pos_z])
                                    wallMountScrew();
                                translate([-wall_mount_screw_position, screw_pos_top, screw_pos_z])
                                    wallMountScrew();
                                translate([wall_mount_screw_position, screw_pos_bottom, screw_pos_z])
                                    wallMountScrew();
                                translate([-wall_mount_screw_position, screw_pos_bottom, screw_pos_z])
                                    wallMountScrew();
                                translate([wall_mount_screw_position, screw_pos_bottom, wall_pos_z])
                                    cylinder(h = Wall_mount_thickness + e, d = toleranceAware(Wall_mount_screw_head_major, true), center = true);
                                translate([-wall_mount_screw_position, screw_pos_bottom, wall_pos_z])
                                    cylinder(h = Wall_mount_thickness + e, d = toleranceAware(Wall_mount_screw_head_major, true), center = true);
                                let (trans_y = y1 + (y4 - y1) / 2, slot_len = x3 - (x2 + Base_thickness + toleranceAware(Slider_screw_head_major) - toleranceAware(slider_screw_size, true)), slot_height = y4 - y1) {
                                    translate([wall_mount_screw_position, trans_y, -Base_thickness])
                                        rotate(90, [1, 0, 0])
                                            rotate(90, [0, 0, 1])
                                                slot(toleranceAware(slider_screw_size, true), slot_len, slot_height);
                                    translate([-wall_mount_screw_position, trans_y, -Base_thickness])
                                        rotate(90, [1, 0, 0])
                                            rotate(90, [0, 0, 1])
                                                slot(toleranceAware(slider_screw_size, true), slot_len, slot_height);
                                }
                                let (slot_len = x3 - (x2 + Base_thickness), slot_height = y3 - (toleranceAware(Shelf_height, true) / 2 + Base_thickness)) {
                                    let (trans_y = y3 - slot_height / 2) {
                                        translate([wall_mount_screw_position, trans_y, -Base_thickness])
                                            rotate(90, [1, 0, 0])
                                                rotate(90, [0, 0, 1])
                                                    slot(toleranceAware(Slider_screw_head_major), slot_len, slot_height + e);
                                        translate([-wall_mount_screw_position, trans_y, -Base_thickness])
                                            rotate(90, [1, 0, 0])
                                                rotate(90, [0, 0, 1])
                                                    slot(toleranceAware(Slider_screw_head_major), slot_len, slot_height + e);
                                    }
                                }
                                let (slot_size = Wall_mount_thickness - Base_thickness) {
                                    let (trans_z = base_displace - (slot_size / 2 + Base_thickness)) {
                                        translate([wall_mount_screw_position, nut_position, trans_z])
                                            cube([toleranceAware(Slider_nut_size, true), toleranceAware(Slider_nut_thickness), slot_size + e], center = true);
                                        translate([-wall_mount_screw_position, nut_position, trans_z])
                                            cube([toleranceAware(Slider_nut_size, true), toleranceAware(Slider_nut_thickness), slot_size + e], center = true);
                                    }
                                }
                            }
                            if ($preview) {
                                translate([wall_mount_screw_position, screw_pos_top, screw_pos_z])
                                    #wallMountScrew(false);
                                translate([-wall_mount_screw_position, screw_pos_top, screw_pos_z])
                                    #wallMountScrew(false);
                                translate([wall_mount_screw_position, screw_pos_bottom, screw_pos_z])
                                    #wallMountScrew(false);
                                translate([-wall_mount_screw_position, screw_pos_bottom, screw_pos_z])
                                    #wallMountScrew(false);
                            }
                        }
                    }
                }
            }
        }
    }
}



// If any part is rendered

if (Render_shelf_mount || Render_wall_mount) {
    echo(str("Size of slider screws should be at least ", slider_screw_length, "mm"))
    if ($preview) {
        translate([slider_screw_position, Slider_screw_head_height - Slider_nut_thickness / 2, 0])
            rotate(90, [-1, 0, 0])
                #sliderScrew(false);
        translate([-slider_screw_position, Slider_screw_head_height - Slider_nut_thickness / 2, 0])
            rotate(90, [-1, 0, 0])
                #sliderScrew(false);
    }
}



// If both parts are rendered

if (Render_shelf_mount && Render_wall_mount) {
    if ($preview) {
        translate([slider_screw_position, nut_position, 0])
            rotate(90, [-1, 0, 0])
                #nut(Slider_nut_thickness, Slider_nut_size, slider_screw_size, Slider_nut_type, true, false);
        translate([-slider_screw_position, nut_position, 0])
            rotate(90, [-1, 0, 0])
                #nut(Slider_nut_thickness, Slider_nut_size, slider_screw_size, Slider_nut_type, true, false);
    }
}
