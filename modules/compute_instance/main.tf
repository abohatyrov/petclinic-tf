data "google_compute_image" "petclinic-app" {
  family  = "debian-11"
  project = "debian-cloud"
}

data "template_file" "jenkins" {
  template = file("${path.module}/jenkins-startup.tpl")
  vars = {
    backup_file = ""
  }
}

resource "google_compute_instance" "petclinic-app" {
  project      = var.project
  name         = var.instance_name
  machine_type = "e2-medium"
  zone         = var.zone
  tags         = var.tags

  metadata_startup_script = var.jenkins ? data.template_file.jenkins.rendered : ""

  boot_disk {
    initialize_params {
      image = data.google_compute_image.petclinic-app.self_link
    }
  }

  service_account {
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork

    access_config {
    }
  }
}