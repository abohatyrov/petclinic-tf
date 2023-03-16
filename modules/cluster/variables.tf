variable "project" {
    type    = string
    default = "project"
}

variable "region" {
    type    = string
    default = "europe-west1"
}

variable "zone" {
    type    = string
    default = "europe-west1-b"
}

variable "cluster_name" {
  type    = string
  default = "gke-cluster"
}

variable "service_account_email" {
  type    = string
  default = "service_account@email.com"
}

variable "pod_range" {
  type    = string
  default = "pod_range"
}

variable "service_range" {
  type    = string
  default = "service_range"
}

variable "network" {
  type    = string
  default = "petclinic-vpc"
}

variable "subnetwork" {
  type    = string
  default = "petclinic-subnet"
}