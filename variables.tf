##################################################################################
# VARIABLES
##################################################################################

variable "public_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIISLxyrw7SGaqlZdZHjVrjTv1k/Q48OWiz6rrhY/BHtc tsanghan"
}

variable "key_pair_name" {
  type    = string
  default = "tsanghan-juice"
}

## Global variables
variable "name" {
  type    = string
  default = "tsanghan"
}

variable "namespace" {
  type    = string
  default = "tsanghan"
}

## Vars for Health check
variable "health_check_path" {
  type    = string
  default = "/"
}

variable "origin_pool_port" {
  type    = number
  default = 1012
}

variable "origin_pool_dns_name" {
  type    = string
  default = "juice-origin.learnf5.cloud"
}

## Load Balancer
variable "domains" {
  type    = string
  default = "juice.learnf5.cloud"
}

variable "http_port" {
  type    = number
  default = 443
}

variable "enable_lb_op_hc" {
  type    = bool
  default = true
}
