resource "spacelift_stack" "prod_use1_ecs_multi_region" {
  branch                  = "main"
  name                    = "prod-ecs-use1-multi-region"
  repository              = "ecs-multi-region-failover"
  project_root            = "terraform/environments/prod/ecs/us-east-1"
  terraform_workflow_tool = "OPEN_TOFU"
  autodeploy              = true
}

resource "spacelift_aws_integration" "this" {
  name     = "Infra POC 2025"
  role_arn = "arn:aws:iam::383395885309:role/TerraformAccess"
}

resource "spacelift_aws_integration_attachment" "prod-ecs-multi-region" {
  integration_id = spacelift_aws_integration.this.id
  stack_id       = spacelift_stack.prod_use1_ecs_multi_region.id
  read           = true
  write          = true
}
