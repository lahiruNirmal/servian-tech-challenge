# Scale out and scale in policies to the application VMs auto scaling group
resource "aws_autoscaling_policy" "asg-scaling-out-policy" {
  name                   = "asg-scaling-out-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.app-asg.name
}

resource "aws_autoscaling_policy" "asg-scaling-in-policy" {
  name                   = "asg-scaling-in-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  policy_type            = "SimpleScaling"
  autoscaling_group_name = aws_autoscaling_group.app-asg.name
}

# CloudWatch alarms to trigger scale out and scale in policies of application ASG
resource "aws_cloudwatch_metric_alarm" "asg-scaling-out-alarm" {
  alarm_name          = "asg-scaling-out-alarm"
  alarm_description   = "asg-scaling-out-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app-asg.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.asg-scaling-out-policy.arn]
}

resource "aws_cloudwatch_metric_alarm" "asg-scaling-in-alarm" {
  alarm_name          = "asg-scaling-in-alarm"
  alarm_description   = "asg-scaling-in-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.app-asg.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.asg-scaling-in-policy.arn]
}
