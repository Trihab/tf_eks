output "eip_out" {
  value = "${module.core-compute.eip_out}"
  sensitive = true
}