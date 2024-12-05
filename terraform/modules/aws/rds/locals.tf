locals {
  vpc-id              = module.vpc.vpc-id
  vpc-public-subnets  = module.vpc.vpc-public-subnets
  vpc-private-subnets = module.vpc.vpc-private-subnets

  # rds properties
  rds-properties = {
    db-identifier          = "db"
    db-allocated-storage   = 20
    db-engine              = "mysql"
    db-engine-version      = "8.0.35"
    db-instance-class      = "db.t3.micro"
    db-skip-final-snapshot = true
    db-publicly-accessible = false

    db-username = ""
    db-password = ""

    db-sg-tag-value = "db-sg"
  }

  # bastion-host-properties
  bastion-host-properties = {
    bastion-host-instance-type = "t2.micro"
    bastion-host-public-key    = "~/.ssh/bastion-key.pub"

    bastion-host-sg-tag-value = "bastion-host-sg"
    bastion-host-tag-value    = "bastion-host"
  }
}