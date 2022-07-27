resource "aws_autoscaling_group" "app-asg" {
    name                 = "Application ASG"
    min_size             = 1
    max_size             = 3
    desired_capacity     = 1
    launch_configuration = aws_launch_configuration.lc_config.name
    vpc_zone_identifier  = var.app_subnet_ids

    tag {
    Name = "Application ASG"
    }
}

