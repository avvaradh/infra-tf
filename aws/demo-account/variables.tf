variable "project" { type = "string" }
variable "region" {
  default     = "us-east-1"
  description = "AWS region"
}

variable "demo_vpc_cidr" { type = "string" }


variable "looker_cidrs_us_east_1" {
  type = "list"
  default = [""]
}

variable "environment" { default = "demo" }

