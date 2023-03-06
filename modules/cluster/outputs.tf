output "name" {
  value = google_container_cluster.petclinic-app.name
}

output "version" {
  value       = google_container_cluster.petclinic-app.master_version
}

output "ip_addres" {
  value       = google_container_cluster.petclinic-app.endpoint
}