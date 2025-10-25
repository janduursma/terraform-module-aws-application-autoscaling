resource "aws_appautoscaling_policy" "this" {
  count = length(var.policies)

  name               = var.policies[count.index]["name"]
  policy_type        = try(var.policies[count.index]["policy_type"], null)
  region             = try(var.policies[count.index]["region"], null)
  resource_id        = var.policies[count.index]["resource_id"]
  scalable_dimension = var.policies[count.index]["scalable_dimension"]
  service_namespace  = var.policies[count.index]["service_namespace"]

  dynamic "predictive_scaling_policy_configuration" {
    for_each = length(keys(try(var.policies[count.index]["predictive_scaling_policy_configuration"], {}))) > 0 ? [var.policies[count.index]["predictive_scaling_policy_configuration"]] : []

    content {
      max_capacity_breach_behavior = try(predictive_scaling_policy_configuration.value["max_capacity_breach_behavior"], null)
      max_capacity_buffer          = try(predictive_scaling_policy_configuration.value["max_capacity_buffer"], null)
      mode                         = try(predictive_scaling_policy_configuration.value["mode"], null)
      scheduling_buffer_time       = try(predictive_scaling_policy_configuration.value["scheduling_buffer_time"], null)

      metric_specification {
        target_value = predictive_scaling_policy_configuration.value["metric_specification"]["target_value"]

        dynamic "customized_capacity_metric_specification" {
          for_each = try(var.policies[count.index]["predictive_scaling_policy_configuration"]["metric_specification"]["customized_capacity_metric_specification"], [])

          content {
            dynamic "metric_data_query" {
              for_each = customized_capacity_metric_specification.value["metric_data_queries"]

              content {
                expression  = try(metric_data_query.value["expression"], null)
                id          = metric_data_query.value["id"]
                label       = try(metric_data_query.value["label"], null)
                return_data = try(metric_data_query.value["return_data"], null)

                dynamic "metric_stat" {
                  for_each = length(keys(try(metric_data_query.value["metric_stat"], {}))) > 0 ? [metric_data_query.value["metric_stat"]] : []

                  content {
                    stat = metric_stat.value["stat"]
                    unit = try(metric_stat.value["unit"], null)

                    metric {
                      metric_name = metric_stat.value["metric"]["metric_name"]
                      namespace   = metric_stat.value["metric"]["namespace"]

                      dynamic "dimension" {
                        for_each = try(metric_stat.value["metric"]["dimensions"], [])

                        content {
                          name  = dimension.value["name"]
                          value = dimension.value["value"]
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }

        dynamic "predefined_load_metric_specification" {
          for_each = length(keys(try(var.policies[count.index]["predictive_scaling_policy_configuration"]["metric_specification"]["predefined_load_metric_specification"], {}))) > 0 ? [var.policies[count.index]["predictive_scaling_policy_configuration"]["metric_specification"]["predefined_load_metric_specification"]] : []

          content {
            predefined_metric_type = predefined_load_metric_specification.value["predefined_metric_type"]
            resource_label         = try(predefined_load_metric_specification.value["resource_label"], null)
          }
        }

        dynamic "predefined_metric_pair_specification" {
          for_each = length(keys(try(var.policies[count.index]["predictive_scaling_policy_configuration"]["metric_specification"]["predefined_metric_pair_specification"], {}))) > 0 ? [var.policies[count.index]["predictive_scaling_policy_configuration"]["metric_specification"]["predefined_metric_pair_specification"]] : []

          content {
            predefined_metric_type = predefined_metric_pair_specification.value["predefined_metric_type"]
            resource_label         = try(predefined_metric_pair_specification.value["resource_label"], null)
          }
        }

        dynamic "predefined_scaling_metric_specification" {
          for_each = length(keys(try(var.policies[count.index]["predictive_scaling_policy_configuration"]["metric_specification"]["predefined_scaling_metric_specification"], {}))) > 0 ? [var.policies[count.index]["predictive_scaling_policy_configuration"]["metric_specification"]["predefined_scaling_metric_specification"]] : []

          content {
            predefined_metric_type = predefined_scaling_metric_specification.value["predefined_metric_type"]
            resource_label         = try(predefined_scaling_metric_specification.value["resource_label"], null)
          }
        }
      }
    }
  }

  dynamic "step_scaling_policy_configuration" {
    for_each = length(keys(try(var.policies[count.index]["step_scaling_policy_configuration"], {}))) > 0 ? [var.policies[count.index]["step_scaling_policy_configuration"]] : []

    content {
      adjustment_type          = step_scaling_policy_configuration.value["adjustment_type"]
      cooldown                 = step_scaling_policy_configuration.value["cooldown"]
      metric_aggregation_type  = try(step_scaling_policy_configuration.value["metric_aggregation_type"], null)
      min_adjustment_magnitude = try(step_scaling_policy_configuration.value["min_adjustment_magnitude"], null)

      dynamic "step_adjustment" {
        for_each = length(try(step_scaling_policy_configuration.value["step_adjustments"], [])) > 0 ? step_scaling_policy_configuration.value["step_adjustments"] : []

        content {
          metric_interval_lower_bound = try(step_adjustment.value["metric_interval_lower_bound"], null)
          metric_interval_upper_bound = try(step_adjustment.value["metric_interval_upper_bound"], null)
          scaling_adjustment          = step_adjustment.value["scaling_adjustment"]
        }
      }
    }
  }

  dynamic "target_tracking_scaling_policy_configuration" {
    for_each = length(keys(try(var.policies[count.index]["target_tracking_scaling_policy_configuration"], {}))) > 0 ? [var.policies[count.index]["target_tracking_scaling_policy_configuration"]] : []

    content {
      disable_scale_in   = try(target_tracking_scaling_policy_configuration.value["disable_scale_in"], null)
      scale_in_cooldown  = try(target_tracking_scaling_policy_configuration.value["scale_in_cooldown"], null)
      scale_out_cooldown = try(target_tracking_scaling_policy_configuration.value["scale_out_cooldown"], null)
      target_value       = target_tracking_scaling_policy_configuration.value["target_value"]

      dynamic "customized_metric_specification" {
        for_each = length(keys(try(target_tracking_scaling_policy_configuration.value["customized_metric_specification"], {}))) > 0 ? [target_tracking_scaling_policy_configuration.value["customized_metric_specification"]] : []

        content {
          metric_name = try(customized_metric_specification.value["metric_name"], null)
          namespace   = try(customized_metric_specification.value["namespace"], null)
          statistic   = try(customized_metric_specification.value["statistic"], null)
          unit        = try(customized_metric_specification.value["unit"], null)

          dynamic "dimensions" {
            for_each = try(customized_metric_specification.value["dimensions"], [])

            content {
              name  = dimensions.value["name"]
              value = dimensions.value["value"]
            }
          }

          dynamic "metrics" {
            for_each = try(customized_metric_specification.value["metrics"], [])

            content {
              expression  = try(metrics.value["expression"], null)
              id          = metrics.value["id"]
              label       = try(metrics.value["label"], null)
              return_data = try(metrics.value["return_data"], null)

              dynamic "metric_stat" {
                for_each = length(keys(try(metrics.value["metric_stat"], {}))) > 0 ? [metrics.value["metric_stat"]] : []

                content {
                  stat = metric_stat.value["stat"]
                  unit = try(metric_stat.value["unit"], null)

                  metric {
                    metric_name = metric_stat.value["metric"]["metric_name"]
                    namespace   = metric_stat.value["metric"]["namespace"]

                    dynamic "dimensions" {
                      for_each = try(metric_stat.value["metric"]["dimensions"], [])

                      content {
                        name  = dimensions.value["name"]
                        value = dimensions.value["value"]
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }

      dynamic "predefined_metric_specification" {
        for_each = length(keys(try(target_tracking_scaling_policy_configuration.value["predefined_metric_specification"], {}))) > 0 ? [target_tracking_scaling_policy_configuration.value["predefined_metric_specification"]] : []

        content {
          predefined_metric_type = predefined_metric_specification.value["predefined_metric_type"]
          resource_label         = try(predefined_metric_specification.value["resource_label"], null)
        }
      }
    }
  }
}

resource "aws_appautoscaling_scheduled_action" "this" {
  count = length(var.scheduled_actions)

  end_time           = try(var.scheduled_actions[count.index]["end_time"], null)
  name               = var.scheduled_actions[count.index]["name"]
  service_namespace  = var.scheduled_actions[count.index]["service_namespace"]
  region             = try(var.scheduled_actions[count.index]["region"], null)
  resource_id        = var.scheduled_actions[count.index]["resource_id"]
  scalable_dimension = var.scheduled_actions[count.index]["scalable_dimension"]
  schedule           = var.scheduled_actions[count.index]["schedule"]
  start_time         = try(var.scheduled_actions[count.index]["start_time"], null)
  timezone           = try(var.scheduled_actions[count.index]["timezone"], null)

  scalable_target_action {
    min_capacity = try(var.scheduled_actions[count.index]["scalable_target_action"]["min_capacity"], null)
    max_capacity = try(var.scheduled_actions[count.index]["scalable_target_action"]["max_capacity"], null)
  }
}

resource "aws_appautoscaling_target" "this" {
  count = length(var.targets)

  max_capacity       = var.targets[count.index]["max_capacity"]
  min_capacity       = var.targets[count.index]["min_capacity"]
  resource_id        = var.targets[count.index]["resource_id"]
  region             = try(var.targets[count.index]["region"], null)
  role_arn           = try(var.targets[count.index]["role_arn"], null)
  scalable_dimension = var.targets[count.index]["scalable_dimension"]
  service_namespace  = var.targets[count.index]["service_namespace"]
  tags               = merge(try(var.tags, {}), try(var.targets[count.index]["tags"], {}))

  dynamic "suspended_state" {
    for_each = length(keys(try(var.targets[count.index]["suspended_state"], {}))) > 0 ? [var.targets[count.index]["suspended_state"]] : []

    content {
      dynamic_scaling_in_suspended  = try(suspended_state.value["dynamic_scaling_in_suspended"], null)
      dynamic_scaling_out_suspended = try(suspended_state.value["dynamic_scaling_out_suspended"], null)
      scheduled_scaling_suspended   = try(suspended_state.value["scheduled_scaling_suspended"], null)
    }
  }
}
