resource "aws_security_group" "public_sg" {
  name        = "public_aap"
  description = "Allow AAP public traffic"
  vpc_id      = data.aws_vpc.target_vpc.id

  ingress {
    description = "Inbound HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AAP_Public"
  }


}

resource "aws_security_group" "aap_private_sg" {
  name        = "private_aap"
  description = "Allow AAP private traffic"
  vpc_id      = data.aws_vpc.target_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.public_sg.id]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [var.vpn_client_sg_id]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  ingress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = [data.aws_subnet.vpn_client_subnet.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AAP_Private"
  }

}
