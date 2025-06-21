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

provider "spacelift" {
  api_key_endpoint = "https://jjimmyflynn.app.spacelift.io"
  api_key_id       = "01JY875A35R6ZA20K6P4PE7FZK"
  api_key_secret   = var.spacelift_api_key
}

resource "spacelift_stack" "prod-ecs-multi-region-failover" {
  branch     = "main"
  name       = "prod-ecs-multi-region-failover"
  repository = "ecs-multi-region-failover"
  terraform_workflow_tool = "OPEN_TOFU"
}
