locals {
  # duplocloud tenant id
  duplocloud-tenant-id = module.duplocloud-tenant.duplocloud-tenant-id

  # duplocloud ecs properties
  duplocloud-ecs-properties = {
    ecs-task-definition-family                   = "duploservices-ecs-service"
    ecs-task-definition-network-mode             = "awsvpc"
    ecs-task-definition-requires-compatibilities = ["FARGATE"]

    ecs-task-definition-runtime-platform-cpu-architecture        = "X86_64"
    ecs-task-definition-runtime-platform-operating-system-family = "Linux"

    ecs-task-definition-cpu    = "256"
    ecs-task-definition-memory = "1024"

    ecs-task-definition-prevent-tf-destroy = "false"

    ecs-task-definition-container-definitions = [
      {
        Name  = "default"
        Image = "nginx:latest"
        Environment = [
          {
            Name  = "NGINX_HOST",
            Value = "foo"
          }
        ]
        PortMappings = [
          {
            ContainerPort = "80",
            HostPort      = "80",
            Protocol = {
              Value = "tcp"
            }
          }
        ]
      }
    ]

    ecs-service-replicas = 2

    ecs-service-load-balancer-lb-type             = 1
    ecs-service-load-balancer-port                = "8080"
    ecs-service-load-balancer-external-port       = 80
    ecs-service-load-balancer-protocol            = "HTTP"
    ecs-service-load-balancer-enable-access-logs  = false
    ecs-service-load-balancer-drop-invalid-header = true
    ecs-service-load-balancer-health-check-url    = "https://example.healthcheckurl.com/healthcheck"
  }
}
