output "kubernetes_cluster_name" {
  description = "The name of the Kubernetes cluster"
  value       = google_container_cluster.primary.name
}

output "control_plane_node" {
  description = "The machine type of the control plane node"
  value       = var.control_plane_machine_type
}

output "worker_nodes" {
  description = "The number and type of worker nodes"
  value       = {
    count       = var.worker_count
    machineType = var.worker_machine_type
  }
}

output "gsa_email" {
  description = "The email of the Google Service Account"
  value       = google_service_account.service-acct.email
}

output "service_account" {
  description = "The email of the Kubernetes service account"
  value       = var.ksa_name
}

output "load_balancer_ip" {
  description = "The external IP of the load balancer"
  value       = google_compute_address.nat.address
}