resource "aws_db_subnet_group" "rds-db-subnet-group" {
  name        = var.rds-properties.rds-db-subnet-group-name
  description = var.rds-properties.rds-db-subnet-group-description

  subnet_ids = [
    for subnet in var.vpc-private-subnets : subnet.id
  ]
}

resource "aws_security_group" "rds-security-group" {
  name   = var.rds-properties.rds-security-group-name
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
    Name = var.rds-properties.rds-security-group-tags-Name
  }
}

resource "aws_db_instance" "db-instance" {
  db_subnet_group_name = aws_db_subnet_group.rds-db-subnet-group.name
  vpc_security_group_ids = [
    aws_security_group.rds-security-group.id
  ]

  identifier          = var.rds-properties.rds-db-instance-identifier
  allocated_storage   = var.rds-properties.rds-db-instance-allocated-storage
  engine              = var.rds-properties.rds-db-instance-engine
  engine_version      = var.rds-properties.rds-db-instance-engine-version
  instance_class      = var.rds-properties.rds-db-instance-class
  db_name             = var.rds-properties.rds-db-instance-name
  username            = var.rds-properties.rds-db-instance-username
  password            = var.rds-properties.rds-db-instance-password
  publicly_accessible = var.rds-properties.rds-db-instance-publicly-accessible
  skip_final_snapshot = var.rds-properties.rds-db-instance-skip-final-snapshot
}

resource "aws_security_group" "bastion-host-security-group" {
  name   = var.bastion-host-properties.bastion-host-security-group-name
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
    Name = var.bastion-host-properties.bastion-host-security-group-tags-Name
  }
}

resource "aws_key_pair" "bastion-host-key-pair" {
  key_name   = var.bastion-host-properties.bastion-host-key-pair-name
  public_key = file(var.bastion-host-properties.bastion-host-public-key)
}

resource "aws_instance" "bastion-host" {
  ami           = data.aws_ami.rds-ami.id
  instance_type = var.bastion-host-properties.bastion-host-instance-type
  key_name      = aws_key_pair.bastion-host-key-pair.id
  subnet_id     = var.vpc-public-subnets[0].id

  vpc_security_group_ids = [
    aws_security_group.bastion-host-security-group.id
  ]

  tags = {
    Name = var.bastion-host-properties.bastion-host-tags-Name
  }
}
