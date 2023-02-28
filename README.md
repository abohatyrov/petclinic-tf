# Petclinic Infrastructure as a Code

Infrastructure as Code for Petclinic project

---

## TO-DO:
- [ ] Create bucket for artifacts
- [*] Update network module:
  - [*] Subnetwork creation. Add the ability to create several subnets
- [ ] Add Lenkins startup script using templating
- [ ] Start use terrafrom auto documentation

---

## Structure
```
📦petclinic-tf
 ┣ 📂modules
 ┃ ┣ 📂compute_instance
 ┃ ┗ 📂network
 ┣ 📜backend.tf
 ┣ 📜main.tf
 ┣ 📜outputs.tf
 ┣ 📜provider.tf
 ┗ 📜variables.tf
```

## Backend and provider

This project uses Google Cloud Platform as a cloud provide therefore, Google provider was used for terraform. As a backend was used `gcs` bucket.
```terraform
terraform {
  required_providers {
    google = {
      version = "~> 3.83.0"
    }
  }
  
  backend "gcs" {
    credentials = "petclinic-app-94cd559f8bb4.json" # JSON file with credentials
    bucket      = "petclinic-tfstate"               # Bucket name
    prefix      = "terraform/state"                 # tfstate file location in GCS
  }
}
```

## Modules
### 1. Compute instance module:
  Configure an instance on Debian 11, attached service account for project, e2-medium type, and ephermal public ip address.
```terraform
module "example_instance" {
  source = "./modules/compute_instance"

  project         = jsondecode(file("credentials.json")).project_id # JSON file with credentials
  instance_name   = "example-name"                                  # Instance name
  network         = module.petclinic_network.network_id             # VPC network id
  subnetwork      = module.petclinic_network.subnet                 # Subnetwork name
  tags            = ["web", "ssh",]                                 # Tags fo firewall
}
```
  _Note: This module was used to create Jenkins Server._

### 2. Network module:
  Creates VPC network, subnetworks, firewall rules, router, and NAT router for project.
```terraform
module "example_network" {
  source = "./modules/network"

  region  = var.region
  project = jsondecode(file("credentials.json")).project_id # JSON file with credentials
  network = "example-vpc-tf"                                # VPC network name

  subnetwork = {  # Subnetwork name and ip range
    name     = "example-subnet-tf-eu-west1"
    ip_range = "10.24.5.0/24"
  }

  firewall = {  # Firewall rules in a dictionary format
    ssh = {
      name   = "example-allow-ssh-tf"
      tags   = ["ssh"]
      ranges = ["0.0.0.0/0"]
      ports  = ["22"]
    },
    http = {
      name   = "example-allow-http-tf"
      tags   = ["web"]
      ranges = ["0.0.0.0/0"]
      ports  = ["8080"]
    }
  }
}
```
  _Note: VPC, subnet and firewall was used in Jenkins Server._
