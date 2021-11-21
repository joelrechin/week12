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

