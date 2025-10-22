# Networking - AWS VPC with public and private subnets
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment}-${var.assoicated_project}-vpc"
  }
}

resource "aws_default_route_table" "default_rtb" {
  default_route_table_id = aws_vpc.main.default_route_table_id
  tags = {
    Name = "${var.environment}-default-rtb"
  }
}

module "subnet" {
  source          = "./modules/network"
  vpc_id          = aws_vpc.main.id
  vpc_cidr        = aws_vpc.main.cidr_block
  region          = var.region
  subnet_az       = var.az
  env             = var.environment
  vpc_endpoint_sg = aws_security_group.vpc_endpoints_sg.id
}

module "computes" {
  source                  = "./modules/computes"
  repo_name               =  var.ecr_name
  vpc_id                  = aws_vpc.main.id
  env                     = var.environment
}

# Security - AWS SG
resource "aws_security_group" "vpc_endpoints_sg" {
  name_prefix = "${var.environment}-vpc-endpoints"
  description = "Associated to ECR/s3 VPC Endpoints"
  vpc_id      = aws_vpc.main.id

  # ingress {
  #   description     = "Allow Nodes to pull images from ECR via VPC endpoints"
  #   protocol        = "tcp"
  #   from_port       = 443
  #   to_port         = 443
  #   security_groups = [aws_security_group.ecs_sg.id]
  # }
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
