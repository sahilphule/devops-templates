locals {
  # vpc-id               = module.vpc.vpc-id
  # vpc-public-subnets   = module.vpc.vpc-public-subnets
  # lb-target-group-arn  = module.load-balancer.lb-target-group-arn
  # lb-security-group-id = module.load-balancer.lb-security-group-id

  # ecs properties
  ecs-properties = {
    ecs-cluster-name = "ecs-cluster"

    ecs-task-execution-role-name = "ecs-task-execution-role"

    ecs-task-definition-family                   = "ecs-task-definition-family"
    ecs-task-definition-network-mode             = "awsvpc"
    ecs-task-definition-requires-compatibilities = ["FARGATE"]
    ecs-task-definition-cpu                      = 512
    ecs-task-definition-memory                   = 1024

    ecs-service-security-group-name      = "ecs-service-security-group"
    ecs-service-security-group-tags-Name = "ecs-service-security-group"

    ecs-service-name          = "ecs-service"
    ecs-service-launch-type   = "FARGATE"
    ecs-service-desired-count = 1

    ecs-container-name = "nginx-container"
    ecs-container-port = 80
  }

  # ecs-container-image = local.ecr-repository-url
  # s3-config-bucket    = local.s3-properties.s3-bucket-name
  s3-config-path = ""

  ecs-container-definitions = [
    {
      name = local.ecs-properties.ecs-container-name
      # image     = local.ecs-container-image
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = local.ecs-properties.ecs-container-port
          hostPort      = local.ecs-properties.ecs-container-port
          protocol      = "tcp"
        }
      ]
      environment = [
        {
          name = "S3_CONFIG_BUCKET"
          # value = local.s3-config-bucket
        },
        {
          name = "S3_CONFIG_PATH"
          # value = local.s3-config-path
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          # awslogs-group         = module.cloudwatch.cloudwatch-log-group-name[0]
          awslogs-region        = "ap-south-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ]
}
