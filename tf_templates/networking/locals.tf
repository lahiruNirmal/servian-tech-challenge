locals {
  zone_a = format("%s%s", var.region, "a")
  zone_b = format("%s%s", var.region, "b")
  zone_c = format("%s%s", var.region, "c")
  az_zones = [local.zone_a, local.zone_b, local.zone_c]
}