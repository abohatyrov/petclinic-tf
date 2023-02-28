terraform {
  required_providers {
    google = {
      version = "~> 3.83.0"
    }
  }
}

provider "google" {
  credentials = file("petclinic-app-94cd559f8bb4.json")
  region      = var.region
}