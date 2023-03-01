data "google_compute_image" "petclinic-app" {
  family  = "debian-11"
  project = "debian-cloud"
}

data "google_service_account" "petclinic-app" {
  project    = var.project
  account_id = "petclinic-sa"
}

resource "google_compute_instance" "petclinic-app" {
  project      = var.project
  name         = var.instance_name
  machine_type = "e2-medium"
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.petclinic-app.self_link
    }
  }

  service_account {
    email = data.google_service_account.petclinic-app.email
    scopes = ["cloud-platform"]
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    access_config {
    }
  }
}