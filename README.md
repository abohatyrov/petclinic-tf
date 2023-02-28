# petclinic-tf

Infrastructure as Code for Petclinic project

### Structure
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

### Backend and provider

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

### Modules
1. Compute instance module:\
Configure an instance on Debian 11, attached service account for project, e2-medium type, and ephermal public ip address.
```terraform
module "example_instance" {
  source = "./modules/compute_instance"

  project         = jsondecode(file("credentials.json")).project_id
  instance_name   = "example-name"
  network         = module.petclinic_network.network_id
  subnetwork      = module.petclinic_network.subnet
  tags            = ["web", "ssh",]
}
```
_Note: This module was used to create Jenkins Server._