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

variable "jenkins_name" {
    type    = string
    default = "jenkins"
}

variable "network_name" {
    type    = string
    default = "network"
}

variable "subnetwork_name" {
    type    = string
    default = "subnetwork"
}

variable "cluster_name" {
    type    = string
    default = "gke-cluster"
}

variable "pod_range" {
    type    = string
    default = "gke-pod_range"
}

variable "service_range" {
    type    = string
    default = "gke-pod_range"
}
