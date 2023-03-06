resource "google_container_cluster" "petclinic-app" {
  project  = var.project
  name     = var.cluster_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "petclinic-app" {
  project    = var.project
  name       = "${google_container_cluster.petclinic-app.name}-np"
  location   = var.region
  cluster    = google_container_cluster.petclinic-app.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "f1.micro"

    service_account = var.service_account_email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}