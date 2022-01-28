resource "aws_lb" "aap_alb" {
  name               = "aap-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_sg.id]
  subnets            = [aws_subnet.public_subnet_a.id,aws_subnet.public_subnet_b.id]

  tags = {
    Name = "AAP_Public_ALB"
  }

}

resource "aws_lb_listener" "aap_front" {
  load_balancer_arn = aws_lb.aap_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = data.aws_acm_certificate.batman.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.aap_target_group.arn
  }
}

resource "aws_lb_listener_rule" "hub_instance" {
  listener_arn = aws_lb_listener.aap_front.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hub_target_group.arn
  }

  condition {
    host_header {
      values = ["automation-hub.batmansbatcave.com"]
    }
  }
}

resource "aws_lb_target_group" "aap_target_group" {
  name        = "aap-tg-https"
  port        = 443
  protocol    = "HTTPS"
  vpc_id      = data.aws_vpc.target_vpc.id

  health_check {
    protocol = "HTTPS"
    port     = 443
  }
}

resource "aws_lb_target_group" "hub_target_group" {
  name        = "hub-tg-https"
  port        = 443
  protocol    = "HTTPS"
  vpc_id      = data.aws_vpc.target_vpc.id

  health_check {
    protocol = "HTTPS"
    port     = 443
  }
}


resource "aws_lb_target_group_attachment" "controller_instance" {
  target_group_arn = aws_lb_target_group.aap_target_group.arn
  target_id        = aws_instance.controller_instance.id
  port             = 443
}

resource "aws_lb_target_group_attachment" "hub_instance" {
  target_group_arn = aws_lb_target_group.hub_target_group.arn
  target_id        = aws_instance.hub_instance.id
  port             = 443
}
