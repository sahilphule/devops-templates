locals {
  # vpc-id              = module.vpc.vpc-id
  # vpc-public-subnets  = module.vpc.vpc-public-subnets
  # vpc-private-subnets = module.vpc.vpc-private-subnets

  # rds properties
  rds-properties = {
    rds-db-subnet-group-name        = "rds-db-subnet-group"
    rds-db-subnet-group-description = "rds db subnet group"

    rds-security-group-name      = "rds-security-group"
    rds-security-group-tags-Name = "rds-security-group"

    rds-security-group-ingress-from-port   = 3306 # 5432
    rds-security-group-ingress-to-port     = 3306 # 5432
    rds-security-group-ingress-protocol    = "tcp"
    rds-security-group-ingress-cidr-blocks = ["0.0.0.0/0"]
    # rds-security-group-ingress-security-groups = []

    rds-security-group-egress-from-port   = 0
    rds-security-group-egress-to-port     = 0
    rds-security-group-egress-protocol    = -1
    rds-security-group-egress-cidr-blocks = ["0.0.0.0/0"]

    rds-db-instance-count      = 1
    rds-db-instance-identifier = ["rds-db-instance"]

    rds-db-instance-class               = ["db.t3.micro"]
    rds-db-instance-engine              = ["mysql"]  # mysql, postgres
    rds-db-instance-engine-version      = ["8.0.35"] # 8.0.35, 17.4
    rds-db-instance-allocated-storage   = [20]
    rds-db-instance-storage-type        = ["gp2"]
    rds-db-instance-publicly-accessible = [false]
    rds-db-instance-skip-final-snapshot = [true]

    rds-db-instance-db-name  = ["db"]
    rds-db-instance-username = [""]
    rds-db-instance-password = [""]
  }

  # bastion-host-properties
  bastion-host-properties = {
    bastion-host-count = 1

    bastion-host-ami-owners = "137112412989"
    bastion-host-ami-value  = "al2023-ami-2023.7.20250609.0-kernel-6.1-x86_64"

    bastion-host-security-group-name      = "bastion-host-security-group"
    bastion-host-security-group-tags-Name = "bastion-host-security-group"

    bastion-host-key-pair-name = "bastion-host-ssh-key-pair"
    bastion-host-public-key    = "~/desktop/aws/ssh-keys/bastion-host-ssh-key-pair.pub"

    bastion-host-instance-type = "t2.micro"
    bastion-host-tags-Name     = "bastion-host"
  }
}
