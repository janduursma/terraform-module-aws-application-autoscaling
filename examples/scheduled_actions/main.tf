module "application_autoscaling" {
  source = "../../"

  scheduled_actions = [{
    name               = "ecs"
    service_namespace  = aws_appautoscaling_target.demo.service_namespace
    resource_id        = aws_appautoscaling_target.demo.resource_id
    scalable_dimension = aws_appautoscaling_target.demo.scalable_dimension
    schedule           = "at(2006-01-02T15:04:05)"

    scalable_target_action = {
      min_capacity = 1
      max_capacity = 10
    }
  }]
}

resource "aws_appautoscaling_target" "demo" {
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/demo/demo"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
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
