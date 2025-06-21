terraform {
  required_providers {
    spacelift = {
      source = "spacelift-io/spacelift"
      version = "1.25.0"
    }
  }
}

resource "spacelift_stack" "spacelift" {
  branch     = "main"
  name       = "spacelift-self-management"
  repository = "ecs-multi-region-failover"
  project_root = "terraform/spacelift"
  terraform_workflow_tool = "OPEN_TOFU"
}

resource "spacelift_stack" "test" {
  branch     = "main"
  name       = "test"
  repository = "ecs-multi-region-failover"
  project_root = "terraform/something"
  terraform_workflow_tool = "OPEN_TOFU"
}
