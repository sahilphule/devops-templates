locals {
  # vpc-id              = module.vpc.vpc-id
  # vpc-public-subnets  = module.vpc.vpc-public-subnets
  # vpc-private-subnets = module.vpc.vpc-private-subnets

  # rds properties
  rds-properties = {
    rds-owners    = ["137112412989"]
    rds-ami-value = ["al2023-ami-2023.6.20241121.0-kernel-6.1-x86_64"]

    rds-db-subnet-group-name        = "rds-db-subnet-group"
    rds-db-subnet-group-description = "rds db subnet group"

    rds-security-group-name      = "rds-security-group"
    rds-security-group-tags-Name = "rds-security-group"

    rds-db-instance-identifier          = "rds-db-instance"
    rds-db-instance-allocated-storage   = 20
    rds-db-instance-engine              = "mysql"
    rds-db-instance-engine-version      = "8.0.35"
    rds-db-instance-class               = "db.t3.micro"
    rds-db-instance-name                = "rds-db-instance"
    rds-db-instance-username            = ""
    rds-db-instance-password            = ""
    rds-db-instance-skip-final-snapshot = true
    rds-db-instance-publicly-accessible = false
  }

  # bastion-host-properties
  bastion-host-properties = {
    bastion-host-security-group-name      = "bastion-host-security-group"
    bastion-host-security-group-tags-Name = "bastion-host-security-group"

    bastion-host-key-pair-name = "bastion-host-key-pair"
    bastion-host-public-key    = "~/.ssh/bastion-key.pub"

    bastion-host-instance-type = "t2.micro"
    bastion-host-tags-Name     = "bastion-host"
  }
}
