data "aws_region" "current" {}

variable "image_id" {
  type = string
  description = "OS image id"
}

variable "vm_type" {
  type = string
  description = "VM type (eg. t2.micro)"
}

variable "instance_count" {
  type = number
  description = "How many instances you want"
}