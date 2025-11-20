output "eip_out" {
  value     = module.core-compute.eip_out
  sensitive = false
}

output "vpc_get" {
  value = module.eks_cluster.vpc_return
}

output "sub_get" {
  value = module.eks_cluster.sub_return
}

output "coredns_version" {
  value = module.eks_cluster.coredns_version
}

output "vpccni_version" {
  value = module.eks_cluster.vpccni_version
}

output "kubeproxy_version" {
  value = module.eks_cluster.kubeproxy_version
}