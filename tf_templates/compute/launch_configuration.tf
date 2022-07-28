# Launch configuration of the application VM
resource "aws_launch_configuration" "lc_config" {
  name_prefix          = "tech-challenge-app-server-"
  image_id             = lookup(var.amis, var.region)
  instance_type        = var.app_instance_class
  security_groups      = [var.app_sg_id]
  iam_instance_profile = aws_iam_instance_profile.ec2-iam-instance-profile.name
  user_data            = file("${path.module}/userdata/userdata.sh")
  key_name             = "test-key"
  lifecycle {
    create_before_destroy = true
  }

}


