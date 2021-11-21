resource "aws_db_subnet_group" "week12-sng" {
  name       = "week12-sng"
  subnet_ids = [aws_subnet.week12-pri-a.id, aws_subnet.week12-pri-b.id]

  tags = {
    Name = "week12-sng"
  }
}

resource "aws_security_group" "week12-rds-sg" {
  name        = "week12-rds-sg"
  description = "Allow MySQL inbound traffic"
  vpc_id      = aws_vpc.week12-vpc.id

  ingress = [
    {
      description = "TCP for MySQL"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]

      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description = "Allow all outbound"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]

      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  tags = {
    Name = "week12-rds-sg"
  }
}

resource "aws_rds_cluster" "week12-rds" {
  cluster_identifier     = "week12-rds"
  database_name          = "week12_rds"
  engine                 = "aurora-mysql"
  engine_mode            = "serverless"
  master_username        = "admin"
  master_password        = "secret123"
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.week12-sng.id
  vpc_security_group_ids = [aws_db_subnet_group.week12-sng.id]

  scaling_configuration {
    auto_pause              = true
    max_capacity            = 2
    min_capacity            = 1
    seconds_until_auto_pause = 300
  }
}


