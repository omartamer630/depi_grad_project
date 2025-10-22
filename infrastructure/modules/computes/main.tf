# ECR 
resource "aws_ecr_repository" "my-app" {
  name = var.repo_name
}
