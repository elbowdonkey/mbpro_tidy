$fn=100;

module thunderbolt(cutout=false) {
  // main body
  color("White")
  hull() {
    if (cutout == true) {
      translate([-(tb_body_width/2), -(tb_body_height/2), 0]) cylinder(r=tb_body_fillet_radius, h=tb_body_length * 2, center=true);
      translate([ (tb_body_width/2), -(tb_body_height/2), 0]) cylinder(r=tb_body_fillet_radius, h=tb_body_length * 2, center=true);
      translate([ (tb_body_width/2),  (tb_body_height/2), 0]) cylinder(r=tb_body_fillet_radius, h=tb_body_length * 2, center=true);
      translate([-(tb_body_width/2),  (tb_body_height/2), 0]) cylinder(r=tb_body_fillet_radius, h=tb_body_length * 2, center=true);
    } else {
      translate([-(tb_body_width/2), -(tb_body_height/2), 0]) cylinder(r=tb_body_fillet_radius, h=tb_body_length, center=true);
      translate([ (tb_body_width/2), -(tb_body_height/2), 0]) cylinder(r=tb_body_fillet_radius, h=tb_body_length, center=true);
      translate([ (tb_body_width/2),  (tb_body_height/2), 0]) cylinder(r=tb_body_fillet_radius, h=tb_body_length, center=true);
      translate([-(tb_body_width/2),  (tb_body_height/2), 0]) cylinder(r=tb_body_fillet_radius, h=tb_body_length, center=true);
    }

  }

  // metal connector
  color("Silver")
  translate([0,0,(tb_body_length + tb_conn_length)/2]) {
    hull() {
      translate([-(tb_conn_width - tb_conn_chamfer)/2, -(tb_conn_height/2), 0]) rotate([0,0,0]) cylinder(r=tb_conn_chamfer, h=tb_conn_length, center=true, $fn=4);
      translate([ (tb_conn_width - tb_conn_chamfer)/2, -(tb_conn_height/2), 0])  rotate([0,0,0]) cylinder(r=tb_conn_chamfer, h=tb_conn_length, center=true, $fn=4);
      translate([ (tb_conn_width/2),  (tb_conn_height/2), 0]) cube(size=[tb_conn_chamfer, tb_conn_chamfer, tb_conn_length], center=true);
      translate([-(tb_conn_width/2),  (tb_conn_height/2), 0]) cube(size=[tb_conn_chamfer, tb_conn_chamfer, tb_conn_length], center=true);
    }
  }
}