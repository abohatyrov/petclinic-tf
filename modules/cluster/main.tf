resource "google_container_cluster" "petclinic-app" {
  project  = var.project
  name     = var.cluster_name
  location = var.zone

  networking_mode = "VPC_NATIVE"
  network         = var.network
  subnetwork      = var.subnetwork 

  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pod_range
    services_secondary_range_name = var.service_range
  }
}

resource "google_container_node_pool" "petclinic-app" {
  project    = var.project
  name       = "${google_container_cluster.petclinic-app.name}-np"
  location   = var.zone
  cluster    = google_container_cluster.petclinic-app.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    disk_size_gb = 20

    service_account = var.service_account_email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}