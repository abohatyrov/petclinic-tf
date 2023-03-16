output "network_id" {
  value = google_compute_network.petclinic-app.id
}

output "network_name" {
  value = google_compute_network.petclinic-app.name
}

output "subnet" {
  value = google_compute_subnetwork.petclinic-app.id
}
