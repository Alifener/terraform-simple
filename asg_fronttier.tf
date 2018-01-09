resource "aws_launch_configuration" "prod_launchconfig_fronttier" {
  name_prefix          = "launchconfig_fronttier"
  image_id             = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type        = "${var.FRONTTIER__MACHINE_TYPE}"
  associate_public_ip_address = true
  key_name             = "${aws_key_pair.key.key_name}"
  security_groups      = ["${aws_security_group.sg_prod_fronttier.id}"]
  user_data = "${data.template_cloudinit_config.cloudinit-fronttier.rendered}"
  lifecycle              { create_before_destroy = true }
  
}

resource "aws_autoscaling_group" "prod_autoscaling_fronttier" {
  name                 = "autoscaling_frontier"
  vpc_zone_identifier  = ["${aws_subnet.prod_public_1.id}","${aws_subnet.prod_public_2.id}"]
  launch_configuration = "${aws_launch_configuration.prod_launchconfig_fronttier.name}"
  min_size             = "${var.FRONTTIER_MACHINE_COUNT}" 
  max_size             = "${var.FRONTTIER_MACHINE_COUNT_MAX}" 
  tag {
      key = "Name"
      value = "fronttier Docker instance"
      propagate_at_launch = true
  }
}
