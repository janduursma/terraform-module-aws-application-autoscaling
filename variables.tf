variable "policies" {
  description = "List of configuration blocks to create autoscaling policies."
  type        = any
  default     = []
}

variable "scheduled_actions" {
  description = "List of configuration blocks to create scheduled actions."
  type        = any
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "targets" {
  description = "List of configuration blocks to create autoscaling targets."
  type        = any
  default     = []
}
