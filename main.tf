provider "azurerm" {}

terraform {
  backend "azurerm" {}
}

data "azurerm_resource_group" "logs" {
  name = var.resource_group
}

resource "azurerm_log_analytics_workspace" "logs" {
  name                = "${var.name}-logs"
  location            = data.azurerm_resource_group.logs.location
  resource_group_name = data.azurerm_resource_group.logs.name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days

  tags = var.tags
}

resource "azurerm_security_center_workspace" "logs" {
  count        = length(var.security_center_subscription)
  scope        = "/subscriptions/${element(var.security_center_subscription, count.index)}"
  workspace_id = azurerm_log_analytics_workspace.logs.id
}

resource "azurerm_log_analytics_solution" "logs" {
  count                 = length(var.solutions)
  solution_name         = var.solutions[count.index].solution_name
  location              = data.azurerm_resource_group.logs.location
  resource_group_name   = data.azurerm_resource_group.logs.name
  workspace_resource_id = azurerm_log_analytics_workspace.logs.id
  workspace_name        = azurerm_log_analytics_workspace.logs.name

  plan {
    publisher = var.solutions[count.index].publisher
    product   = var.solutions[count.index].product
  }
}

resource "azurerm_management_lock" "logs" {
  count      = var.lock
  name       = "resource-group-level"
  scope      = data.azurerm_resource_group.logs.id
  lock_level = "CanNotDelete"
  notes      = "Locked by terraform."
}
