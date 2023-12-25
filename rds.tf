resource "aws_db_subnet_group" "sonarqube_subnet_group" {
  name       = "sonarqube_subnet_group"
  subnet_ids = [aws_subnet.sonarqube_private_subnet_2a.id, aws_subnet.sonarqube_private_subnet_2b.id,sonarqube_private_subnet_2c.id]

  tags = {
    Name = "sonarqube_subnet_group"
  }
}

#db instance
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  availability_zone    = "ap-northest-2a"
  port                 = "5432"
  db_name              = "sonar"
  engine               = "Aurora PostgreSQL"
  engine_version       = "15.3"
  instance_class       = "db.t3.medium"
  username             = "sonar"
  parameter_group_name = "default.aurora-postgresql15"
  skip_final_snapshot  = true
  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.sonarqube_key.key_id
  vpc_security_group_ids = [aws_security_group.sonarqube_db.id]
  db_subnet_group_name = aws_db_subnet_group.sonarqube_subnet_group.id
}