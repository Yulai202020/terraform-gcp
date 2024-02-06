terraform {
  required_version = "> 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 5.7.0"
    }

    google = {
      source  = "hashicorp/google"
      version = "> 4.7.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "google" {
  credentials = file("key.json")
  project     = var.gcp_project
  region      = var.gcp_region
}