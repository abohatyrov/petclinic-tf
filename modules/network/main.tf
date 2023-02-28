resource "google_compute_network" "petclinic-app" {
  project                 = var.project
  name                    = var.network
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "petclinic-app" {
  project  = var.project
  for_each = var.subnetwork

  name                     = each.value.name
  ip_cidr_range            = each.value.range
  region                   = each.value.region
  network                  = google_compute_network.petclinic-app.id
  private_ip_google_access = each.value.private
}

resource "google_compute_firewall" "petclinic-app" {
  project  = var.project
  for_each = var.firewall

  name          = each.value.name
  network       = google_compute_network.petclinic-app.id
  target_tags   = each.value.tags
  source_ranges = each.value.ranges

  allow {
    protocol = "tcp"
    ports    = each.value.ports
  }
}

resource "google_compute_router" "petclinic-app" {
  project = var.project
  name    = "petclinic-router"
  region  = var.region
  network = google_compute_network.petclinic-app.id
}

resource "google_compute_router_nat" "petclinic-app" {
  project                            = var.project
  name                               = "petclinic-router-nat"
  router                             = google_compute_router.petclinic-app.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}