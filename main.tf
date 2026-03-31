terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["./credentials"]
  default_tags {
    tags = {
      Course     = "CSSE6400"
      Name       = "TaskOverflow"
      Automation = "Terraform"
    }
  }
}

variable "database_username" {
  description = "Username for the RDS database"
  type        = string
}

variable "database_password" {
  description = "Password for the RDS database"
  type        = string
  sensitive   = true
}

locals {
  image             = "ghcr.io/csse6400/taskoverflow:latest"
}

data "aws_iam_role" "lab" {
  name = "LabRole"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

