include <BOSL2/std.scad>
$fn= $preview ? 32 : 512;

walls=2;
x_size=70;
y_size=50;
z_size=40;

handheld_x=55;
handheld_y=30;

screw_depth=2;
screw_diameter=2;
screw_head=5;

// --- Main Model ---
difference() {
    base_cube();
    handheld_cutout();
    screw_holes();
}

module base_cube() {
    cuboid([x_size, y_size, z_size], rounding=walls, except=[BACK], p1=[0, 0, 0]);
}

module handheld_cutout() {
    cuboid([handheld_x, handheld_y, z_size], rounding=walls*2, except=[TOP], p1=[(x_size-handheld_x)/2, walls*2, walls]);
}

module screw_hole(x_position) {
    cuboid([screw_diameter,screw_depth+walls+1,(screw_diameter*3)+(screw_head/2)], rounding=screw_diameter/2, edges=["Y"], p1=[x_position-(screw_diameter/2), y_size-screw_depth-walls, (z_size/3)*2]);
    cuboid([screw_head,screw_depth,(screw_diameter*3)+screw_head-(screw_diameter/2)], rounding=screw_head/2, edges=["Y"], p1=[x_position-(screw_head/2), y_size-screw_depth-walls, (z_size/3)*2]);
    cuboid([screw_head,screw_depth+walls+1,screw_head], rounding=screw_head/2, edges=["Y"], p1=[x_position-(screw_head/2), y_size-screw_depth-walls, (z_size/3)*2]);
}

module screw_holes() {
    screw_hole(x_size/3);
    screw_hole((x_size/3)*2);
}
