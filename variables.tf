variable "name" {
  description = "Name of Log Analystics Workspace."
}

variable "resource_group" {
  description = "Name of resource group to deploy resources in."
}

variable "sku" {
  description = "Specified the Sku of the Log Analytics Workspace."
  default     = "PerNode"
}

variable "retention_in_days" {
  description = "The workspace data retetion in days. Possible values range between 30 and 730."
  default     = 30
}

variable "security_center_subscription" {
  description = "List of subscriptions this log analytics should collect data for."
  type        = list(string)
  default     = []
}

variable "solutions" {
  description = "A list of solutions to add to the workspace. Should contain solution_name, publisher and product."
  type        = list(object({ solution_name = string, publisher = string, product = string }))
  default     = []
}

variable "lock" {
  description = "Add a lock on resource group as part of deployment."
  default     = false
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}
