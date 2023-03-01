resource "google_storage_bucket" "petclinic-app" {
  project       = var.project
  name          = var.bucket_name
  location      = "EU"
  storage_class = var.storage_class

  uniform_bucket_level_access = var.private
}