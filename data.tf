data "aws_vpc" "target_vpc" {
  filter {
    name = "tag:Name"
    values = ["batman_london"]
  }
}

data "aws_subnet" "vpn_client_subnet" {
  vpc_id = data.aws_vpc.target_vpc.id
  id     = var.vpn_client_subnet_id
}

data "aws_acm_certificate" "batman" {
  domain = "*.batmansbatcave.com"
  types  = ["AMAZON_ISSUED"]
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_route53_zone" "batman" {
  name         = "batmansbatcave.com."
}

data "aws_security_group" "vpn_client_sg" {
  vpc_id = data.aws_vpc.target_vpc.id
  id     = var.vpn_client_sg_id
}
