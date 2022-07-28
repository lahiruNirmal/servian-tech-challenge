resource "aws_autoscaling_group" "app-asg" {
  name                 = "Application ASG"
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.lc_config.name
  vpc_zone_identifier  = var.app_subnet_ids
  health_check_type    = "EC2"
  depends_on           = [aws_secretsmanager_secret.db-secret, aws_secretsmanager_secret_version.db-secret-version]

  tag {
    key                 = "Name"
    value               = "tech-challenge db subnet group"
    propagate_at_launch = true
  }
}

