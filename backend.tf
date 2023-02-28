terraform {
  required_providers {
    google = {
      version = "~> 3.83.0"
    }
  }
  
  backend "gcs" {
    credentials = "petclinic-app-94cd559f8bb4.json"
    bucket      = "petclinic-tfstate"
    prefix      = "terraform/state"
  }
}