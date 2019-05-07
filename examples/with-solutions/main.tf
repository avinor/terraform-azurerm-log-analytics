module "workspace" {
    source = "../../"

    name = "common"
    resource_group = "test"

    solutions = [
        {
            solution_name = "ContainerInsights",
            publisher = "Microsoft",
            product = "OMSGallery/ContainerInsights",
        }
    ]
}