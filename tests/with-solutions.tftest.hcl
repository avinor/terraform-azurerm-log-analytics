variables {
  name                = "common"
  resource_group_name = "test"
  location            = "westeurope"

  solutions = [
    {
      solution_name = "ContainerInsights",
      publisher     = "Microsoft",
      product       = "OMSGallery/ContainerInsights",
    },
  ]
}
run "with-solutions" {
  command = plan
}