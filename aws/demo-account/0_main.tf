terraform {
  backend "gcs" {
    bucket  = "terraform-state"
    prefix  = "aws/demo-account/"
  }
}

provider "aws" {
  version = "~> 2.0"
    region  = "${var.region}"
  allowed_account_ids = ["${var.project}"]
}

provider "aws" {
  alias = "us_west_2_region"
  version = "~> 2.0"
    region  = "us-west-2"
  allowed_account_ids = ["${var.project}"]
}

data "aws_caller_identity" "current" {}
