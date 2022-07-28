# ALB to handle incoming traffic to application
resource "aws_lb" "app-lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = var.public_subnet_ids
}

# HTTP listener for ALB
resource "aws_lb_listener" "lb-http-listener" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-tg.arn
  }
}

# Application VMs target group
resource "aws_lb_target_group" "app-tg" {
  name     = "app-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    unhealthy_threshold = 3
    interval            = 10
    path                = "/healthcheck/"
    port                = 3000
    timeout             = 5
  }
}

# ASG attachment to target group
resource "aws_autoscaling_attachment" "as-attachment" {
  autoscaling_group_name = aws_autoscaling_group.app-asg.id
  lb_target_group_arn    = aws_lb_target_group.app-tg.arn
}

