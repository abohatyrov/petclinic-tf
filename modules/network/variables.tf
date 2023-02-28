variable "region" {
  type    = string
  default = "europe-west1"
}

variable "project" {
  type    = string
  default = "project"
}

variable "zone" {
  type    = string
  default = "europe-west1-b"
}

variable "network" {
  type    = string
  default = "network-vpc"
}

variable "subnetwork" {
  type  = map(object({
    name    = string
    range   = string
    region  = string
    private = bool
  }))
}

variable "ip_name" {
  type    = string
  default = "ip_name"
}

variable "firewall" {
  type  = map(object({
    name   = string
    tags   = list(string)
    ranges = list(string)
    ports  = list(string)
  }))
}