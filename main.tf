terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "bastion-playground-tfstate"
    key          = "terraform.tfstate"
    region       = "ap-northeast-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region  = "ap-northeast-1"

  default_tags {
    tags = {
      Project   = "bastion-playground"
      ManagedBy = "terraform"
    }
  }
}

data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}
