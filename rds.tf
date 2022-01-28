resource "aws_db_instance" "aap_rds" {
  allocated_storage    = 40
  identifier           = "ansible-automation-rdsdb"
  engine               = "postgres"
  engine_version       = "12.8"
  instance_class       = "db.m5.large"
  name                 = "aaprds"
  username             = "awx"
  password             = "aap2.1Password!!"
  skip_final_snapshot  = true
}

resource "aws_db_instance" "hub_rds" {
  allocated_storage    = 40
  identifier           = "ansible-automation-hub-rdsdb"
  engine               = "postgres"
  engine_version       = "12.8"
  instance_class       = "db.m5.large"
  name                 = "aaprds"
  username             = "awx"
  password             = "aap2.1Password!!"
  skip_final_snapshot  = true
}
