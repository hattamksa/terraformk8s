#https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = var.project_id
  region  = "us-central1"
}

# https://www.terraform.io/language/settings/backends/gcs
# terraform {
#   backend "gcs" {
#     bucket = "cloudtest1-tf-state"
#     prefix = "terraform/state"
#   }
#   required_providers {
#     google = {
#       source  = "hashicorp/google"
#       version = "~> 4.0"
#     }
#   }
# }