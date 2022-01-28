resource "aws_instance" "controller_instance" {
  ami                    = var.aap_ami
  instance_type          = "t3.xlarge"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.aap_private_sg.id] 
  associate_public_ip_address = false
  key_name                    = "test_key"
  root_block_device {
    volume_size = 40
  }

  tags = {
    Name = "Ansible Automation Controller"
  }
}


resource "aws_instance" "hub_instance" {
  ami                    = var.aap_ami
  instance_type          = "t3.xlarge"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.aap_private_sg.id]
  associate_public_ip_address = false
  key_name                    = "test_key"
  root_block_device {
    volume_size = 40
  }

  tags = {
    Name = "Ansible Automation Hub"
  }
}

resource "aws_instance" "exec_instance" {
  ami                    = var.aap_ami
  instance_type          = "t3.xlarge"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.aap_private_sg.id]
  associate_public_ip_address = false
  key_name                    = "test_key"
  root_block_device {
    volume_size = 40
  }

  tags = {
    Name = "Ansible Automation Exec Node"
  }
}
