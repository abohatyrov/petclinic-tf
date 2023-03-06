variable "instance_name" {
    type    = string
    default = "instance name"
}

variable "tags" {
    type    = list(string)
    default = []
}

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

variable "network" {
    type    = string
    default = "europe-west1-b"
}

variable "subnetwork" {
    type    = string
    default = "europe-west1-b"
}

variable "jenkins" {
  type    = bool
  default = false
}

variable "service_account_email" {
  type    = string
  default = "service_account@email.com"
}
