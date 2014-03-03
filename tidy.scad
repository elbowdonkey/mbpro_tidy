include <thunderbolt.scad>;
include <usb.scad>;
include <magsafe.scad>;

/*
  Test prints with PLA measured about 96% of target size, so bumping sizes up by 4%
  should help get things printing accurately.

  Your printer, filament, and slicing choices may require you tweak this to something else.

*/
shrink_compensation    = 1.08;

/*
  Thunderbolt connector dimensions

  After measuring several Apple thunderbolt connectors it's clear
  that there can be slight variations in size.

  The dimensions used here are from a pre-Thunderbolt 27" Cinema Display.
*/
tb_body_fillet_radius  = 2;
tb_body_length         = 16;
tb_body_width          = shrink_compensation * (10.8 - (tb_body_fillet_radius * 2));
tb_body_height         = shrink_compensation * (8.0 - (tb_body_fillet_radius * 2));
tb_conn_chamfer        = 1;
tb_conn_length         = 8.36;
tb_conn_width          = 7.44 - (tb_conn_chamfer);
tb_conn_height         = 4.55 - (tb_conn_chamfer);

/*
  USB connectors

  The dimensions used here are from a pre-Thunderbolt 27" Cinema Display.
*/
usb_body_fillet_radius = 2;
usb_body_length        = 16;
usb_body_width         = shrink_compensation * (14.6 - (usb_body_fillet_radius * 2));
usb_body_height        = shrink_compensation * (7.2 - (usb_body_fillet_radius * 2));
usb_conn_length        = 12;
usb_conn_width         = 12;
usb_conn_height        = 4.6;

/*
  Magsafe

  This is where you can tweak dimensions for the older Magsafe connector found
  on the pre-Thunderbolt displays when used with the Magsafe 2 adapter.

*/
ms_body_fillet_radius  = 2;
ms_body_length         = 10;
ms_body_width          = shrink_compensation * (17.5 - (ms_body_fillet_radius * 2));
ms_body_height         = shrink_compensation * (7.6 - (ms_body_fillet_radius * 2));
ms_conn_fillet_radius  = 1;
ms_conn_length         = 2.15;
ms_conn_width          = 15.6 - (ms_conn_fillet_radius * 2);
ms_conn_height         =  3.7 - (ms_conn_fillet_radius * 2);
oms_barrel_diam        = 7;
oms_barrel_length      = 26;

/*
  This is where you'd adjust the spacing between connections.
  These values are added to each plug's x position, starting from left to right.

  For example:

  [<-- usb -->][<--- usb to thunderbolt gap -->][<-- thunderbolt -->][ etc ]

*/
usb_tb_gap             = 3.0;  // 3.75 - (3.75 * 0.2);
tb_tb_gap              = 2.75; // 3.50 - (3.75 * 0.2);
tb_mag_gap             = -1.0; // 4.00 - (3.75 * 0.2) - 4.24;

usb_x = 0;
tb1_x = usb_body_width + tb_body_fillet_radius + usb_tb_gap;
tb2_x = tb1_x + tb_body_width + (tb_body_fillet_radius * 2) + tb_tb_gap;
mag_x = tb2_x + ms_body_width + (ms_body_fillet_radius * 2) + tb_mag_gap;

tidy_body_height = 11;
tidy_body_width = usb_body_length;
tidy_body_length = 69;

/* Uncomment to see plugs in their ports */
// translate([0,-0.2,0]) rotate([90,0,0]) usb();
// translate([tb1_x,-0.2,0]) rotate([90,0,0]) thunderbolt();
// translate([tb2_x,-0.2,0]) rotate([90,0,0]) thunderbolt();
// translate([mag_x,-3.2,0]) rotate([90,0,0]) magsafe();

tidy_x = -((usb_body_width/2) + tb_body_fillet_radius + 1.75);
tidy_y = -(usb_body_length/2);
tidy_z = -(tidy_body_height/2);

module tidy() {
  difference() {
    // main body of the cable tidy
    translate([tidy_x,tidy_y,tidy_z]) cube(size=[tidy_body_length, tidy_body_width, tidy_body_height]);

    // connectors, each long enough to cut straight through the body
    translate([usb_x, 0.00, 0.00]) rotate([90,0,0]) usb(true);
    translate([tb1_x, 0.00, 0.00]) rotate([90,0,0]) thunderbolt(true);
    translate([tb2_x, 0.00, 0.00]) rotate([90,0,0]) thunderbolt(true);
    translate([mag_x,-3.05, 0.00]) rotate([90,0,0]) magsafe(true);

    // cutout for the magsafe connector
    hull() {
      translate([mag_x - (ms_body_width/2), 3,0]) cylinder(r=3, h=20, center=true);
      translate([mag_x - (ms_body_width/2), 10,0]) cylinder(r=3, h=20, center=true);
      translate([mag_x + 20, 3,0]) cylinder(r=3, h=20, center=true);
      translate([mag_x + 20, 10,0]) cylinder(r=3, h=20, center=true);
    }
  }
}

tidy();

