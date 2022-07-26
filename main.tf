provider "aws" {
  region  = "us-west-2"
  profile = "TestAccount"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "infracost-test"
}

module "task" {
  source = "./modules/task-def"
}

resource "aws_ecs_service" "service" {
  name                               = "infracost-test"
  task_definition                    = module.task.arn
  cluster                            = aws_ecs_cluster.ecs_cluster.arn
  platform_version                   = "LATEST"
  launch_type                        = "FARGATE"
  propagate_tags                     = "TASK_DEFINITION"
  desired_count                      = 1
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
  network_configuration {
    subnets          = ["subnet-0f6c2ff31a59db1d3"]
    assign_public_ip = false
  }
}

resource "aws_ecs_service" "service-nocost" {
  name                               = "infracost-test"
  task_definition                    = module.task.family
  cluster                            = aws_ecs_cluster.ecs_cluster.arn
  platform_version                   = "LATEST"
  launch_type                        = "FARGATE"
  propagate_tags                     = "TASK_DEFINITION"
  desired_count                      = 1
  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
  network_configuration {
    subnets          = ["subnet-0f6c2ff31a59db1d3"]
    assign_public_ip = false
  }
}
