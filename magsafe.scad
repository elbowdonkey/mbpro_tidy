$fn=100;

module magsafe_adapter(cutout=false) {
  // main body
  color("Silver")
  hull() {
    if (cutout == true) {
      translate([-(ms_body_width/2), -(ms_body_height/2), 0]) cylinder(r=ms_body_fillet_radius, h=ms_body_length * 4, center=true);
      translate([ (ms_body_width/2), -(ms_body_height/2), 0]) cylinder(r=ms_body_fillet_radius, h=ms_body_length * 4, center=true);
      translate([ (ms_body_width/2),  (ms_body_height/2), 0]) cylinder(r=ms_body_fillet_radius, h=ms_body_length * 4, center=true);
      translate([-(ms_body_width/2),  (ms_body_height/2), 0]) cylinder(r=ms_body_fillet_radius, h=ms_body_length * 4, center=true);
    } else {
      translate([-(ms_body_width/2), -(ms_body_height/2), 0]) cylinder(r=ms_body_fillet_radius, h=ms_body_length, center=true);
      translate([ (ms_body_width/2), -(ms_body_height/2), 0]) cylinder(r=ms_body_fillet_radius, h=ms_body_length, center=true);
      translate([ (ms_body_width/2),  (ms_body_height/2), 0]) cylinder(r=ms_body_fillet_radius, h=ms_body_length, center=true);
      translate([-(ms_body_width/2),  (ms_body_height/2), 0]) cylinder(r=ms_body_fillet_radius, h=ms_body_length, center=true);
    }
  }

  if (cutout == false) {
    // metal connector
    color("Silver")
    translate([0,0,(ms_body_length + ms_conn_length)/2]) {
      hull() {
        translate([-(ms_conn_width/2), -(ms_conn_height/2), 0]) cylinder(r=ms_conn_fillet_radius, h=ms_conn_length, center=true);
        translate([ (ms_conn_width/2), -(ms_conn_height/2), 0]) cylinder(r=ms_conn_fillet_radius, h=ms_conn_length, center=true);
        translate([ (ms_conn_width/2),  (ms_conn_height/2), 0]) cylinder(r=ms_conn_fillet_radius, h=ms_conn_length, center=true);
        translate([-(ms_conn_width/2),  (ms_conn_height/2), 0]) cylinder(r=ms_conn_fillet_radius, h=ms_conn_length, center=true);
      }
    }
  }
}

module original_cd_magsafe() {
  color("Silver") cylinder(d=oms_barrel_diam, h=oms_barrel_length, center=true);
}

module magsafe(cutout=false) {
  rotate([0,90,180]) {
    union() {
      rotate([0,-90,0]) magsafe_adapter(cutout);
      if (cutout == false) {
        translate([5 + 3.5,0,-5]) original_cd_magsafe();
      }
    }
  }
}