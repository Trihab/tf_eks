output "eip_out" {
  value     = module.core-compute.eip_out
  sensitive = false
}

output "vpc_return" {
  value = data.aws_vpc.selected.id
}

output "priv_sub_return" {
  value = data.aws_subnets.my_private_subnets_ids.ids
}

output "pub_sub_return" {
  value = data.aws_subnets.my_public_subnets_ids.ids
}

output "coredns_version" {
  value = data.aws_eks_addon_version.latest_coredns.version
}

output "vpccni_version" {
  value = data.aws_eks_addon_version.latest_vpccni.version
}

output "kubeproxy_version" {
  value = data.aws_eks_addon_version.latest_kubeproxy.version
}
