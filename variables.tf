variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "cloudtest1-453217"
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "Nama Kubernetes Cluster"
  type        = string
  default     = "my-k8s-cluster"
}

variable "control_plane_machine_type" {
  description = "Jenis mesin untuk Control Plane"
  type        = string
  default     = "e2-medium"
}

variable "worker_machine_type" {
  description = "Jenis mesin untuk Worker Nodes"
  type        = string
  default     = "e2-medium"
}

variable "worker_count" {
  description = "Jumlah Worker Nodes"
  type        = number
  default     = 2
}

variable "ksa_name" {
  description = "Kubernetes Service Account Name"
  type        = string
  default     = "ksa-devops"
}

variable "gsa_name" {
  description = "Google Service Account Name"
  type        = string
  default     = "devops"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-a"
}
variable "location" {
  description = "GCP location"
  type        = string
  default     = "us-central1-a"
}