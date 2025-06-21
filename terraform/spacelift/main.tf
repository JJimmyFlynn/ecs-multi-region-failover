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

resource "spacelift_aws_integration" "aws" {
  name     = "Infra POC 2025"
  role_arn = "arn:aws:iam::383395885309:role/TerraformAccess"
}
