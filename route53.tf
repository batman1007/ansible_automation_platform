resource "aws_route53_record" "aap_front_url" {
  zone_id = data.aws_route53_zone.batman.zone_id
  name    = "automation-controller.batmansbatcave.com"
  type    = "A"

  alias {
    name                   = aws_lb.aap_alb.dns_name
    zone_id                = aws_lb.aap_alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "hub_front_url" {
  zone_id = data.aws_route53_zone.batman.zone_id
  name    = "automation-hub.batmansbatcave.com"
  type    = "A"

  alias {
    name                   = aws_lb.aap_alb.dns_name
    zone_id                = aws_lb.aap_alb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_zone" "private_zone" {
  name = "waynemanor"

  vpc {
    vpc_id = data.aws_vpc.target_vpc.id
  }
}

resource "aws_route53_record" "db_hostname" {
  zone_id = aws_route53_zone.private_zone.zone_id
  name    = "rds-controller.waynemanor"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_db_instance.aap_rds.address]
}  

resource "aws_route53_record" "db_hub_hostname" {
  zone_id = aws_route53_zone.private_zone.zone_id
  name    = "rds-hub.waynemanor"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_db_instance.hub_rds.address]
}

resource "aws_route53_record" "controller_hostname" {
  zone_id = aws_route53_zone.private_zone.zone_id
  name    = "controller.waynemanor"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_instance.controller_instance.private_dns]
}

resource "aws_route53_record" "hub_hostname" {
  zone_id = aws_route53_zone.private_zone.zone_id
  name    = "hub.waynemanor"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_instance.hub_instance.private_dns]
}

resource "aws_route53_record" "exec_hostname" {
  zone_id = aws_route53_zone.private_zone.zone_id
  name    = "execution-node.waynemanor"
  type    = "CNAME"
  ttl     = "300"
  records = [aws_instance.exec_instance.private_dns]
}
