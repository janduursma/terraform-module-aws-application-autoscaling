# AWS Application Autoscaling Terraform module

Terraform module which creates application autoscaling resources on AWS.

## Available Features

- Policies
- Scheduled actions
- Targets

## Examples:

- [Policies](https://github.com/janduursma/terraform-module-aws-application-autoscaling/tree/main/examples/policies)
- [Scheduled actions](https://github.com/janduursma/terraform-module-aws-application-autoscaling/tree/main/examples/scheduled_actions)
- [Targets](https://github.com/janduursma/terraform-module-aws-application-autoscaling/tree/main/examples/targets)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 6.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.this](https://registry.terraform.io/providers/hashicorp/aws/6.13.0/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_scheduled_action.this](https://registry.terraform.io/providers/hashicorp/aws/6.13.0/docs/resources/appautoscaling_scheduled_action) | resource |
| [aws_appautoscaling_target.this](https://registry.terraform.io/providers/hashicorp/aws/6.13.0/docs/resources/appautoscaling_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_policies"></a> [policies](#input\_policies) | List of configuration blocks to create autoscaling policies. | `any` | `[]` | no |
| <a name="input_scheduled_actions"></a> [scheduled\_actions](#input\_scheduled\_actions) | List of configuration blocks to create scheduled actions. | `any` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_targets"></a> [targets](#input\_targets) | List of configuration blocks to create autoscaling targets. | `any` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
