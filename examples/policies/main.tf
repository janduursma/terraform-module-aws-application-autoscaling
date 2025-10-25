module "application_autoscaling" {
  source = "../../"

  policies = [{
    name               = "scale-down"
    policy_type        = "StepScaling"
    resource_id        = aws_appautoscaling_target.demo.resource_id
    scalable_dimension = aws_appautoscaling_target.demo.scalable_dimension
    service_namespace  = aws_appautoscaling_target.demo.service_namespace

    step_scaling_policy_configuration = {
      adjustment_type         = "ChangeInCapacity"
      cooldown                = 60
      metric_aggregation_type = "Maximum"

      step_adjustments = [{
        metric_interval_upper_bound = 0
        scaling_adjustment          = -1
      }]
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
