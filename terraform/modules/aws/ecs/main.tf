resource "aws_ecs_cluster" "ecs-cluster" {
  name = var.ecs-properties.ecs-cluster-name
}

resource "aws_iam_role" "ecs-task-execution-role" {
  name               = var.ecs-properties.ecs-task-execution-role-name
  assume_role_policy = data.aws_iam_policy_document.ecs-assume-role-policy.json
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-AmazonECSTaskExecutionRolePolicy" {
  role       = aws_iam_role.ecs-task-execution-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_ecs_task_definition" "ecs-task-definition" {
  family                   = var.ecs-properties.ecs-task-definition-family
  network_mode             = var.ecs-properties.ecs-task-definition-network-mode
  requires_compatibilities = var.ecs-properties.ecs-task-definition-requires-compatibilities
  cpu                      = var.ecs-properties.ecs-task-definition-cpu
  memory                   = var.ecs-properties.ecs-task-definition-memory
  container_definitions    = jsonencode(var.ecs-container-definitions)
  execution_role_arn       = aws_iam_role.ecs-task-execution-role.arn
}

resource "aws_security_group" "ecs-service-security-group" {
  name   = var.ecs-properties.ecs-service-security-group-name
  vpc_id = var.vpc-id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1

    security_groups = [
      var.lb-security-group-id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.ecs-properties.ecs-service-security-group-tags-Name
  }
}

resource "aws_ecs_service" "ecs-service" {
  name            = var.ecs-properties.ecs-service-name
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.ecs-task-definition.arn
  launch_type     = var.ecs-properties.ecs-service-launch-type
  desired_count   = var.ecs-properties.ecs-service-desired-count

  load_balancer {
    container_name   = var.ecs-properties.ecs-container-name
    container_port   = var.ecs-properties.ecs-container-port
    target_group_arn = var.lb-target-group-arn
  }

  network_configuration {
    subnets = var.vpc-public-subnets

    assign_public_ip = true
    security_groups = [
      aws_security_group.ecs-service-security-group.id
    ]
  }
}
