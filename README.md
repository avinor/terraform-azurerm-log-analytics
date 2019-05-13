# Log Analytics

Deploys a log analytics workspace for collecting all diagnostics logs and metrics. Can collect logs across multiple subscriptions and connect to Security Center. It is recommended to deploy only one instance per region to collect all diagnostics in one place. For multiple regions it can be advantagious to deploy one in each region, as recommended by Microsoft.

## Setup

Not all options are available in terraform yet. To collect Azure Activity logs additional configuration is required after deployment.

Open deployed log analytics workspace and go to "Workspace Data Sources" -> "Azure Activity log" and connect to subscriptions that should collect activity logs.

## Usage

```terraform
module "workspace" {
    source = "avinor/log-analytics/azurerm"
    version = "1.0.0"

    name = "logs"
    resource_group_name = "logs-rg"
    location = "westeurope"
}
```

To add solutions to the workspace use the solutions variable to define solution name, publisher and product.

```terraform
module "workspace" {
    source = "avinor/log-analytics/azurerm"
    version = "1.0.0"

    name = "logs"
    resource_group_name = "logs-rg"
    location = "westeurope"

    solutions = [
        {
            solution_name = "ContainerInsights",
            publisher = "Microsoft",
            product = "OMSGallery/ContainerInsights",
        },
    ]
}
```

Some of the solutions that can be added:

| solution_name | publisher | product |
|---------------|-----------|---------|
| ContainerInsights | Microsoft | OMSGallery/ContainerInsights |
| AzureAppGatewayAnalytics | Microsoft | OMSGallery/AzureAppGatewayAnalytics |
| AzureActivity | Microsoft | OMSGallery/AzureActivity |
| Security | Microsoft | OMSGallery/Security |
| KeyVaultAnalytics | Microsoft | OMSGallery/KeyVaultAnalytics |
| AntiMalware | Microsoft | OMSGallery/AntiMalware |
| NetworkMonitoring | Microsoft | OMSGallery/NetworkMonitoring |

In addition if using Azure Firewall install the [Azure Firewall sample workspace](https://docs.microsoft.com/en-us/azure/firewall/log-analytics-samples) for viewing firewall logs.