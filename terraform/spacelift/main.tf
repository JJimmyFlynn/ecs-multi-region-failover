terraform {
  backend "s3" {
    bucket         = "fly-infra-poc-2025"
    key            = "tfstate/spacelift"
    region         = "us-east-1"
  }

  required_providers {
    spacelift = {
      source = "spacelift-io/spacelift"
      version = "1.25.0"
    }
  }
}

resource "spacelift_stack" "prod-ecs-multi-region-failover" {
  branch     = "main"
  name       = "prod-ecs-multi-region-failover"
  repository = "ecs-multi-region-failover"
  project_root = "terraform/enviornments/prod"
  terraform_workflow_tool = "OPEN_TOFU"
  additional_project_globs = ["terraform/spacelift"]
}

resource "spacelift_stack" "test" {
  branch     = "main"
  name       = "prod-ecs-multi-region-failover"
  repository = "ecs-multi-region-failover"
  terraform_workflow_tool = "OPEN_TOFU"
}
