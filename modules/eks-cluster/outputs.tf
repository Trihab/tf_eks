output "vpc_return" {
  value = data.aws_vpc.selected.id
}

output "sub_return" {
  value = data.aws_subnets.my_subnets_ids.ids
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
