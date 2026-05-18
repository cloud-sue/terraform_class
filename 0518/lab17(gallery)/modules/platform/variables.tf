variable "namespace" {
  type = string
}

variable "region" {
  type = string
}

variable "lb_subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}