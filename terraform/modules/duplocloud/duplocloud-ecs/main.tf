# Create a task definition for NGINX using ECS
resource "duplocloud_ecs_task_definition" "duplocloud-ecs-task-definition" {
  tenant_id = var.duplocloud-tenant-id

  family                   = var.duplocloud-ecs-properties.ecs-family
  container_definitions    = jsonencode(var.duplocloud-ecs-properties.ecs-container-definition)
  cpu                      = var.duplocloud-ecs-properties.ecs-cpu
  memory                   = var.duplocloud-ecs-properties.ecs-memory
  requires_compatibilities = var.duplocloud-ecs-properties.ecs-requires-compatibilities
  prevent_tf_destroy       = "false"
  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "Linux"
  }
  network_mode = "awsvpc"
}

resource "duplocloud_ecs_service" "duplocloud-ecs-service" {
  tenant_id = var.duplocloud-tenant-id

  task_definition = duplocloud_ecs_task_definition.duplocloud-ecs-task-definition.arn
  replicas        = var.duplocloud-ecs-properties.ecs-service-replicas

  load_balancer {
    lb_type              = var.duplocloud-ecs-properties.ecs-service-load-balancer-lb-type
    port                 = var.duplocloud-ecs-properties.ecs-service-load-balancer-port
    external_port        = var.duplocloud-ecs-properties.ecs-service-load-balancer-external-port
    protocol             = var.duplocloud-ecs-properties.ecs-service-load-balancer-protocol
    enable_access_logs   = var.duplocloud-ecs-properties.ecs-service-load-balancer-enable-access-logs
    drop_invalid_headers = var.duplocloud-ecs-properties.ecs-service-load-balancer-drop-invalid-header
    health_check_url     = var.duplocloud-ecs-properties.ecs-service-load-balancer-health-check-url
  }
}
