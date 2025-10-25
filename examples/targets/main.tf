module "application_autoscaling" {
  source = "../../"

  targets = [{
    max_capacity       = 4
    min_capacity       = 1
    resource_id        = "service/${aws_ecs_cluster.demo.name}/${aws_ecs_service.demo.name}"
    scalable_dimension = "ecs:service:DesiredCount"
    service_namespace  = "ecs"
  }]
}

resource "aws_ecs_service" "demo" {
  name            = "demo"
  cluster         = "demo"
  task_definition = "nginx:latest"
  desired_count   = 2

  lifecycle {
    ignore_changes = [desired_count]
  }
}

resource "aws_ecs_cluster" "demo" {
  name = "demo"
}
