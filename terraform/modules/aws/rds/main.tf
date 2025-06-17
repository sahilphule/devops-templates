resource "aws_db_subnet_group" "rds-db-subnet-group" {
  name        = var.rds-properties.rds-db-subnet-group-name
  description = var.rds-properties.rds-db-subnet-group-description

  subnet_ids = [
    for subnet-id in var.vpc-private-subnets : subnet-id
  ]
}

resource "aws_db_parameter_group" "rds-db-parameter-group" {
  count = var.rds-properties.rds-db-instance-engine[0] == "postgres" ? 1 : 0

  name        = "rds-postgres-db-parameter-group"
  family      = "postgres17"
  description = "Custom parameter group for PostgreSQL"

  parameter {
    name         = "rds.force_ssl"
    value        = "0" # Disables SSL enforcement
    apply_method = "immediate"
  }
}

resource "aws_security_group" "rds-security-group" {
  name   = var.rds-properties.rds-security-group-name
  vpc_id = var.vpc-id

  ingress {
    from_port   = var.rds-properties.rds-security-group-ingress-from-port
    to_port     = var.rds-properties.rds-security-group-ingress-to-port
    protocol    = var.rds-properties.rds-security-group-ingress-protocol
    cidr_blocks = var.rds-properties.rds-security-group-ingress-cidr-blocks
    # security_groups = var.rds-properties.rds-security-group-ingress-security-groups
  }

  egress {
    from_port   = var.rds-properties.rds-security-group-egress-from-port
    to_port     = var.rds-properties.rds-security-group-egress-to-port
    protocol    = var.rds-properties.rds-security-group-egress-protocol
    cidr_blocks = var.rds-properties.rds-security-group-egress-cidr-blocks
  }

  tags = {
    Name = var.rds-properties.rds-security-group-tags-Name
  }
}

resource "aws_db_instance" "db-instance" {
  count = var.rds-properties.rds-db-instance-count

  identifier = var.rds-properties.rds-db-instance-identifier[count.index]

  instance_class      = var.rds-properties.rds-db-instance-class[count.index]
  engine              = var.rds-properties.rds-db-instance-engine[count.index]
  engine_version      = var.rds-properties.rds-db-instance-engine-version[count.index]
  allocated_storage   = var.rds-properties.rds-db-instance-allocated-storage[count.index]
  storage_type        = var.rds-properties.rds-db-instance-storage-type[count.index]
  publicly_accessible = var.rds-properties.rds-db-instance-publicly-accessible[count.index]
  skip_final_snapshot = var.rds-properties.rds-db-instance-skip-final-snapshot[count.index]

  db_name  = var.rds-properties.rds-db-instance-db-name[count.index]
  username = var.rds-properties.rds-db-instance-username[count.index]
  password = var.rds-properties.rds-db-instance-password[count.index]

  db_subnet_group_name = aws_db_subnet_group.rds-db-subnet-group.name
  parameter_group_name = var.rds-properties.rds-db-instance-engine[count.index] == "postgres" ? aws_db_parameter_group.rds-db-parameter-group[0].name : null

  vpc_security_group_ids = [
    aws_security_group.rds-security-group.id
  ]
}

resource "aws_security_group" "bastion-host-security-group" {
  count = var.bastion-host-properties.bastion-host-count == 1 ? 1 : 0

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
  count = var.bastion-host-properties.bastion-host-count == 1 ? 1 : 0

  key_name   = var.bastion-host-properties.bastion-host-key-pair-name
  public_key = file(var.bastion-host-properties.bastion-host-public-key)
}

resource "aws_instance" "bastion-host" {
  count = var.bastion-host-properties.bastion-host-count == 1 ? 1 : 0

  ami           = data.aws_ami.bastion-host-ami.id
  instance_type = var.bastion-host-properties.bastion-host-instance-type
  key_name      = aws_key_pair.bastion-host-key-pair[count.index].id
  subnet_id     = var.vpc-public-subnets[0]

  vpc_security_group_ids = [
    aws_security_group.bastion-host-security-group[count.index].id
  ]

  tags = {
    Name = var.bastion-host-properties.bastion-host-tags-Name
  }
}
