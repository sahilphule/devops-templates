resource "aws_db_subnet_group" "vpc-db-subnet-group" {
  name        = "db subnet group"
  description = "db subnet group for rean"
  subnet_ids = [
    // for subnet in var.vpc-public-subnets : subnet.id
    for subnet in var.vpc-private-subnets : subnet.id
  ]
}

resource "aws_security_group" "db-sg" {
  name   = "db-sg"
  vpc_id = var.vpc-id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.database-properties.db-sg-tag-value
  }
}

resource "aws_db_instance" "db" {
  db_subnet_group_name = aws_db_subnet_group.vpc-db-subnet-group.name
  vpc_security_group_ids = [
    aws_security_group.db-sg.id
  ]

  identifier          = var.database-properties.db-identifier
  allocated_storage   = var.database-properties.db-allocated-storage
  engine              = var.database-properties.db-engine
  engine_version      = var.database-properties.db-engine-version
  instance_class      = var.database-properties.db-instance-class
  username            = var.database-properties.db-username
  password            = var.database-properties.db-password
  publicly_accessible = var.database-properties.db-publicly-accessible
  skip_final_snapshot = var.database-properties.db-skip-final-snapshot
}

resource "aws_security_group" "bastion-host-sg" {
  name   = "bastion-host-sg"
  vpc_id = var.vpc-id

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.bastion-properties.bastion-host-sg-tag-value
  }
}

resource "aws_key_pair" "bastion-host-key-pair" {
  key_name   = "bastion-host-key-pair"
  public_key = file(var.bastion-properties.bastion-host-public-key)
}

resource "aws_instance" "bastion-host" {
  ami           = data.aws_ami.linux-ami.id
  instance_type = var.bastion-properties.bastion-host-instance-type
  key_name  = aws_key_pair.bastion-host-key-pair.id
  subnet_id = var.vpc-public-subnets[0].id

  vpc_security_group_ids = [
    aws_security_group.bastion-host-sg.id
  ]

  tags = {
    Name = var.bastion-properties.bastion-host-tag-value
  }
}