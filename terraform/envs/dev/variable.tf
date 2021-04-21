variable "resource_group_name" {
  type    = string
  default = "somic"
}

variable "prefix" {
  type    = string
  default = "hpst2021"
}

variable "docker_image" {
  type    = string
  default = "stdockerapp"
}

variable "env" {
  type    = string
  default = "dev"
}
