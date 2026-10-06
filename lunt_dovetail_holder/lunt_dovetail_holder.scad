include <BOSL2/std.scad>
$fn= $preview ? 128 : 512;

depth=46.1;
height=10;
walls=3;
jettylength=50;
jettywidth=15.9;
borelength=30;
borewidth=5;

angle=60;
prismbase=34;

union() {
    difference() {
        cube([prismbase+(walls*2), depth, height+walls], center=false);
        translate([(prismbase+(walls*2))/2, ((depth-walls)/2)-1, walls])
            prismoid(size1=[prismbase,depth-walls+1], size2=[0,depth-walls+1], h=((prismbase/2)*tan(angle)));
    }

    translate([(prismbase/2)+walls-(jettywidth/2), depth, 0])
        difference() {
            cube([jettywidth, jettylength, walls], center=false);
            translate([jettywidth/2,jettylength/2,walls/2])
                cuboid([borewidth,borelength,walls+1], rounding=borewidth/2, except=[TOP,BOT]);
        }
}

color("black")
    difference() {
        translate([(prismbase/2)+walls, 1, walls])
            rotate(a=[0, 90, 0])
                cylinder(h=prismbase-1, r=1, center=true);

        translate([(prismbase/2)+walls, 1, walls])
            rotate(a=[0, 90, 0])
                cylinder(h=prismbase-11, r=1.1, center=true);
    }
