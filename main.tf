module "petclinic_network" {
  source = "./modules/network"

  region  = var.region
  project = jsondecode(file("petclinic-app-94cd559f8bb4.json")).project_id
  network = "petclinic-vpc-tf"

  subnetwork = {
    subnet_eu = {
      name    = "petclinic-subnet-tf-eu-west1"
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

  project         = jsondecode(file("petclinic-app-94cd559f8bb4.json")).project_id
  instance_name   = "jenkins-server"
  network         = module.petclinic_network.network_id
  subnetwork      = module.petclinic_network.subnet[0]
  tags            = ["web", "ssh",]
}

module "artifacts_bucket" {
  source = "./modules/bucket"

  project         = jsondecode(file("petclinic-app-94cd559f8bb4.json")).project_id
  bucket_name     = "petclinic-artifacts-tf"
  storage_class   = "STANDARD"
  private         = true
}