output "IpAddr" {
  value = google_compute_instance.petclinic-app.network_interface.0.access_config.0.nat_ip
}