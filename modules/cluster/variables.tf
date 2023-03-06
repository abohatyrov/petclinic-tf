variable "project" {
    type    = string
    default = "project"
}

variable "region" {
    type    = string
    default = "europe-west1"
}

variable "cluster_name" {
  type    = string
  default = "gke-cluster"
}

variable "service_account_email" {
  type    = string
  default = "service_account@email.com"
}