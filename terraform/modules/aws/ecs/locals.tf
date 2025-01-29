locals {
  # vpc-id               = module.vpc.vpc-id
  # vpc-public-subnets   = module.vpc.vpc-public-subnets
  # load-balancer-tg-arn = module.load-balancer.load-balancer-tg-arn
  # load-balancer-sg-id  = module.load-balancer.load-balancer-sg-id

  # ecs properties
  ecs-properties = {
    ecs-cluster-name             = "ecs-cluster"
    ecs-task-execution-role-name = "ecs-task-execution-role"
    ecs-task-family              = "ecs-task-family"
    ecs-task-name                = "ecs-task"
    ecs-container-image          = ""
    ecs-container-name           = ""
    ecs-container-port           = ""
    s3-config-bucket             = local.s3-properties.s3-bucket-name
    s3-config-path               = ""
    ecs-service-name             = "ecs-service"

    ecs-service-sg-tag-value = "ecs-service-sg"
  }

  ecs-container-definition = <<DEFINITION
    [
      {
        "name": "${local.ecs-properties.ecs-container-name}",
        "image": "${local.ecs-properties.ecs-container-image}",
        "cpu": 512,
        "memory": 1024,
        "essential": true,
        "portMappings": [
          {
            "containerPort": ${local.ecs-properties.ecs-container-port},
            "hostPort": ${local.ecs-properties.ecs-container-port}
          }
        ],
        "environment": [
          {
            "name": "S3_CONFIG_BUCKET",
            "value": "${local.ecs-properties.s3-config-bucket}"
          },
          {
            "name": "S3_CONFIG_PATH",
            "value": "${local.ecs-properties.s3-config-path}"
          }
        ]
      }
    ]
    DEFINITION
}