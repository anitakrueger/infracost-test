resource "aws_ecs_task_definition" "task" {
  family                   = "infracost-test"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([{
    name      = "container"
    image     = "alpine:latest"
    essential = true
  }])
}

output "arn" {
  value = aws_ecs_task_definition.task.arn
}

output "family" {
  value = aws_ecs_task_definition.task.family
}

output "revision" {
  value = aws_ecs_task_definition.task.revision
}
