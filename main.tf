terraform {
  required_version = ">= 0.12.0"
  required_providers {
    azurerm = "~> 1.44.0"
  }
}

resource "azurerm_resource_group" "logs" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

resource "azurerm_role_assignment" "logs" {
  count                = length(var.contributors)
  scope                = azurerm_resource_group.logs.id
  role_definition_name = "Log Analytics Contributor"
  principal_id         = var.contributors[count.index]
}

resource "azurerm_log_analytics_workspace" "logs" {
  name                = "${var.name}-logs"
  location            = azurerm_resource_group.logs.location
  resource_group_name = azurerm_resource_group.logs.name
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
  location              = azurerm_resource_group.logs.location
  resource_group_name   = azurerm_resource_group.logs.name
  workspace_resource_id = azurerm_log_analytics_workspace.logs.id
  workspace_name        = azurerm_log_analytics_workspace.logs.name

  plan {
    publisher = var.solutions[count.index].publisher
    product   = var.solutions[count.index].product
  }
}
