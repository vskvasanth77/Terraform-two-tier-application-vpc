#application load balancer

resource "aws_lb" "web-alb" {
  name                             = "application-load-balancer"
  load_balancer_type               = var.lb_type_module
  security_groups                  = [var.alb_sg_gp]
  #subnets                          = [ aws_subnet.public-1.id, aws_subnet.public-2.id]
  subnets = [var.pub_subnet_1,var.pub_subnet_2]
  enable_cross_zone_load_balancing = true

  tags = {
    Name = "vas-alb"
  }

}

resource "aws_lb_target_group" "tg-alb" {
  name     = "tg-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpd_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2

  }
  tags = {
    Name = "tg-alb-vas"
  }

}




resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-alb.arn
  }

}

resource "aws_lb_target_group_attachment" "tg-alb-gp" {
  target_group_arn = aws_lb_target_group.tg-alb.arn
  #target_id        = aws_instance.public_ec2_A.id
  target_id        = var.public_ec2_id
  port             = 80

}