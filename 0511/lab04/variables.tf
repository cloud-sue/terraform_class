variable "env" {
  type        = string
  description = "Deployment Env."
}

variable "listener_port" {
  type = number
  default = 8080
}

variable "enabled" {
  type = bool
  default = true
}

variable "subnet_cidr" {
  type=list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
}