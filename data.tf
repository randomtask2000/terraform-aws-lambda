data "aws_subnet_ids" "selected" {
  vpc_id = "${data.aws_vpc.selected.id}"
}

data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
}