# RDS 설정
# RDS Security Rules
resource "aws_security_group" "rds_sg" {
  name = "allow-mysql"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

# 인스턴스 정의
resource "aws_db_instance" "integrated-server-db" {
  allocated_storage = 20
  max_allocated_storage = 20
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t4g.micro"
  availability_zone = "ap-northeast-2a"
  multi_az = false
  backup_retention_period = 0
  skip_final_snapshot = true
  apply_immediately = true
  name = "IntegratedServerDB"
  username = ""
  password = ""
  vpc_security_group_ids = [ aws_security_group.rds_sg.id ]
}
