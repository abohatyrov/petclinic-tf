variable "bucket_name" {
    type    = string
    default = "bucket name"
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

variable "storage_class" {
    type = string
}

variable "private" {
    type = bool
}


