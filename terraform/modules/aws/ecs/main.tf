resource "aws_ecs_cluster" "ecs-cluster" {
  name = var.ecs-properties.ecs-cluster-name
}

resource "aws_iam_role" "ecs-task-execution-role" {
  assume_role_policy = data.aws_iam_policy_document.ecs-assume-role-policy.json
  name               = var.ecs-properties.ecs-task-execution-role-name
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-AmazonECSTaskExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecs-task-execution-role.name
}

resource "aws_ecs_task_definition" "ecs-task" {
  family                   = var.ecs-properties.ecs-task-family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  container_definitions    = var.ecs-container-definition
  execution_role_arn       = aws_iam_role.ecs-task-execution-role.arn
}

resource "aws_security_group" "ecs-service-sg" {
  name   = "ecs-service-sg"
  vpc_id = var.vpc-id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    security_groups = [
      var.load-balancer-sg-id
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.ecs-properties.ecs-service-sg-tag-value
  }
}

resource "aws_ecs_service" "ecs-service" {
  name            = var.ecs-properties.ecs-service-name
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.ecs-task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  load_balancer {
    container_name   = var.ecs-properties.ecs-container-name
    container_port   = var.ecs-properties.ecs-container-port
    target_group_arn = var.target-group-arn
  }

  network_configuration {
    subnets = [
      for subnet in var.vpc-public-subnets : subnet.id
      // for subnet in var.vpc-private-subnets : subnet.id
    ]

    assign_public_ip = true
    security_groups = [
      aws_security_group.ecs-service-sg.id
    ]
  }
}