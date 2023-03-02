locals {
  project_id = jsondecode(file("petclinic-app-94cd559f8bb4.json")).project_id
}

module "petclinic_network" {
  source = "./modules/network"

  project = local.project_id
  region  = var.region
  network = var.network_name

  subnetwork = {
    subnet_eu = {
      name    = var.subnetwork_name
      range   = "10.24.5.0/24"
      region  = var.region
      private = true
    }
  }

  firewall = {
    ssh = {
      name   = "petclinic-allow-ssh-tf"
      tags   = ["ssh"]
      ranges = ["0.0.0.0/0"]
      ports  = ["22"]
    },
    http = {
      name   = "petclinic-allow-http-tf"
      tags   = ["web"]
      ranges = ["0.0.0.0/0"]
      ports  = ["8080"]
    }
  }
}

module "jenkins_instance" {
  source = "./modules/compute_instance"

  project         = local.project_id
  instance_name   = var.jenkins_name
  network         = module.petclinic_network.network_id
  subnetwork      = module.petclinic_network.subnet[0]
  tags            = ["web", "ssh",]
}

module "artifacts_bucket" {
  source = "./modules/bucket"

  project         = local.project_id
  bucket_name     = "petclinic-artifacts-tf"
  storage_class   = "STANDARD"
  private         = true
}

module "jenkins_backups_bucket" {
  source = "./modules/bucket"

  project         = local.project_id
  bucket_name     = "jenkins-backups-tf"
  storage_class   = "STANDARD"
  private         = true
}
