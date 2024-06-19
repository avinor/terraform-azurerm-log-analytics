variables {
  name                = "simple"
  resource_group_name = "simple-rg"
  location            = "westeurope"
}
run "simple-workspace" {
  command = plan
}