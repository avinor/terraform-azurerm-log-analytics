# Log Analytics

Deploys a log analytics workspace for collecting all diagnostics logs and metrics. Can collect logs across multiple subscriptions and connect to Security Center. It is recommended to deploy only one instance per region to collect all diagnostics in one place. For multiple regions it can be advantagious to deploy one in each region, as recommended by Microsoft.

## Setup

Not all options are available in terraform yet. To collect Azure Activity logs additional configuration is required after deployment.

Open deployed log analytics workspace and go to "Workspace Data Sources" -> "Azure Activity log" and connect to subscriptions that should collect activity logs.

## Usage

```terraform
module "workspace" {
    source = "avinor/log-analytics/azurerm"
}
```

It comes pre-configured with following workspaces:

- Antimalware Assessment
- Azure Activity Logs
- Azure Application Gateway Analytics
- Container Monitoring Solution
- Key Vault Analytics
- Network Performance Monitor
- Security and Audit

In addition it is recommended to install the [Azure Firewall sample workspace](https://docs.microsoft.com/en-us/azure/firewall/log-analytics-samples) for viewing firewall logs.