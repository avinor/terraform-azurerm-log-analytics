module "workspace" {
  source = "../../"

  name                = "simple"
  resource_group_name = "simple-rg"
  location            = "westeurope"
}