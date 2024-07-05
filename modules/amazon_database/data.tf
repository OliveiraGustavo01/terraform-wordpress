data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_vpc" "vpc" {
  #id = "${var.vpc_id}"
  filter {
    name   = "tag-value"
    values = ["${var.vpc_name}"]
  }
  filter {
    name   = "tag-key"
    values = ["Name"]
  }
}