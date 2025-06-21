terraform {
  required_providers {
    spacelift = {
      source = "spacelift-io/spacelift"
      version = "1.25.0"
    }
  }
}

resource "spacelift_stack" "prod-ecs-multi-region" {
  branch     = "main"
  name       = "prod-ecs-multi-region"
  repository = "ecs-multi-region-failover"
  project_root = "terraform/environments/prod"
  terraform_workflow_tool = "OPEN_TOFU"
  autodeploy = true
}
