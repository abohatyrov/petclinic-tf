data "google_compute_image" "vm" {
  family  = "debian-11"
  project = "debian-cloud"
}

data "google_service_account" "petclinic-sa" {
  project    = var.project
  account_id = "petclinic-sa"
}

resource "google_compute_instance" "default" {
  project      = var.project
  name         = var.instance_name
  machine_type = "e2-medium"
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.vm.self_link
    }
  }

  service_account {
    email = data.google_service_account.petclinic-sa.email
    scopes = ["cloud-platform"]
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    access_config {
    }
  }
}