provider "google" {
  credentials = file("petclinic-app-94cd559f8bb4.json")
  region      = var.region
}