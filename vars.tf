### terraform.tf init

variable "gcp_region" {
  type        = string
  default     = "us-central1"
  description = "GCP region"
}

variable "gcp_project" {
  type        = string
  default     = "ngm-yulai-dev"
  description = "GCP project"
}

variable "aws_region" {
  type        = string
  default     = "eu-central-1"
  description = "AWS region"
}

### main.tf vm

variable "name_vm" {
  type        = string
  default     = "ubuntu-vm"
  description = "name of vm on gcp"
}

### main.tf bucket

variable "file_upload_name" {
  type    = string
  default = "index.html"
}

variable "file_upload_path" {
  type    = string
  default = "site/index.html"
}