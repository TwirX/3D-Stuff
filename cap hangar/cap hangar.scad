$fn= $preview ? 128 : 512;

// --- Parameters ---
base_thickness = 3;    // Base plate thickness (mm)
hook_height    = 32;   // Vertical height of the rest (mm)
hook_radius    = 48;   // Radius of arc curvature (mm)
hook_thickness = 4.5;  // Wall thickness (mm)
brim_width     = 7;    // Extra top brim overhang (mm)
hook_angle     = 85;   // Arc angle (degrees)

// Screw Hole Settings
screw_d_shaft  = 2.1;
screw_d_head   = 8.5;
screw_cs_depth = 2.5;
screw_y_start  = -3;
screw_spacing  = 20;

// --- Main Model ---
difference() {
    union() {
        base_plate();
        cap_rest();
    }
    screw_holes();
}

// --- Modules ---

// Base plate outline with filleted edges
module base_profile_2d() {
    offset(r = 4) {
        offset(r = -8) offset(r = 8) {
            union() {
                // Top section supporting the curved hook
                translate([0, 14]) 
                    square([68, 18], center = true);
                
                // Bottom tab for mounting screws
                translate([0, -15]) 
                    square([28, 38], center = true);
            }
        }
    }
}

module base_plate() {
    linear_extrude(height = base_thickness)
        base_profile_2d();
}

// Arc profile cross-section (incorporating top brim)
module hook_cross_section() {
    polygon(points = [
        [hook_radius, 0],
        [hook_radius + hook_thickness, 0],
        [hook_radius + hook_thickness, hook_height - 8],
        [hook_radius + hook_thickness + brim_width, hook_height],
        [hook_radius, hook_height]
    ]);
}

// Curved wall with top brim opening towards -Y (screws)
module cap_rest() {
    y_center = -30; // Center of curvature placed below to bow wall outward
    
    translate([0, y_center, base_thickness]) {
        rotate([0, 0, 90 - hook_angle / 2]) {
            rotate_extrude(angle = hook_angle) {
                hook_cross_section();
            }
        }
    }
}

// Countersunk screw holes
module screw_holes() {
    for (y = [screw_y_start, screw_y_start - screw_spacing]) {
        translate([0, y, 0]) {
            translate([0, 0, -1])
                cylinder(d = screw_d_shaft, h = base_thickness + 2);
            
            translate([0, 0, base_thickness - screw_cs_depth])
                cylinder(d1 = screw_d_shaft, d2 = screw_d_head, h = screw_cs_depth + 0.1);
        }
    }
}
