locals {
  azs = slice(data.aws_availability_zones.available.names, 0, var.azs_count)
  resource_name = "${var.project_name}-${var.env}"
}
