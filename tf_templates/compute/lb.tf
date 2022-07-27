resource "aws_lb" "app-lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = var.public_subnet_ids
}

resource "aws_lb_listener" "lb-http-listener" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-tg.arn
  }
}

resource "aws_lb_target_group" "app-tg" {
   name     = "app-tg"
   port     = 3000
   protocol = "HTTP"
   vpc_id   = var.vpc-id
 }

resource "aws_autoscaling_attachment" "as-attachment" {
  autoscaling_group_name = aws_autoscaling_group.app-asg.id
  alb_target_group_arn   = aws_lb_target_group.app-tg.arn
}

