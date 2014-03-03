$fn=100;

module usb(cutout=false) {
  // main body
  color("White")
  hull() {
    if (cutout == true) {
      translate([-(usb_body_width/2), -(usb_body_height/2), 0]) cylinder(r=usb_body_fillet_radius, h=usb_body_length * 4, center=true);
      translate([ (usb_body_width/2), -(usb_body_height/2), 0]) cylinder(r=usb_body_fillet_radius, h=usb_body_length * 4, center=true);
      translate([ (usb_body_width/2),  (usb_body_height/2), 0]) cylinder(r=usb_body_fillet_radius, h=usb_body_length * 4, center=true);
      translate([-(usb_body_width/2),  (usb_body_height/2), 0]) cylinder(r=usb_body_fillet_radius, h=usb_body_length * 4, center=true);
    } else {
      translate([-(usb_body_width/2), -(usb_body_height/2), 0]) cylinder(r=usb_body_fillet_radius, h=usb_body_length, center=true);
      translate([ (usb_body_width/2), -(usb_body_height/2), 0]) cylinder(r=usb_body_fillet_radius, h=usb_body_length, center=true);
      translate([ (usb_body_width/2),  (usb_body_height/2), 0]) cylinder(r=usb_body_fillet_radius, h=usb_body_length, center=true);
      translate([-(usb_body_width/2),  (usb_body_height/2), 0]) cylinder(r=usb_body_fillet_radius, h=usb_body_length, center=true);
    }
  }

  // metal connector
  color("Silver")
  translate([0,0,(usb_body_length + usb_conn_length)/2]) {
    cube(size=[usb_conn_width, usb_conn_height, usb_conn_length], center=true);
  }
}